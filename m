Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EDDC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCa7-0002ZQ-4g; Thu, 20 Mar 2025 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCa5-0002ZI-Sv
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:52:54 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCa2-0003wc-Sk
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742464372; x=1774000372;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TyoBoo3uOcvZ3tKcBPpbe3/0oUc3o0OZLWId+rEJMX4=;
 b=np0Hdf6iM6SaChamvD4avmAExZzod7aoHzGoupJ90unzWX6vpQotQA2U
 W7P6ZhLNOyw9VSGotFh3DRfaobLvKLnBgP4+FCJ7X6d+fqRdeLtsKGsYY
 37MNPvCAYx8HkdlFfFtWZxGVckL7iAHlhtuB0Yl6914u8e8/BEn0pROiM
 U/Cc9PbqhrwDpCds6325uIiL/u6Ib96Yw3Fb9UxttD4p2iVGHTCcQvIDm
 81Hg+W+lRl3vlasCXgXUwPbb9TTVeTBS5QPufGmgVrGXjtm8iSN27w3jJ
 7klWhO8BQOMSXWDBNSowllAwe3XoNAhbza98buBkXPbi6tmLDTco1kSMp g==;
X-CSE-ConnectionGUID: uw56fSMYTo+lRA8yyirdvg==
X-CSE-MsgGUID: sx3abDZXRre3Pu/77Hdkjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43699170"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="43699170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:52:49 -0700
X-CSE-ConnectionGUID: sIoKZPjMS0CyD5tnrtcPuA==
X-CSE-MsgGUID: 8p3+6yr5T2u+CJA1pNk7bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128274790"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2025 02:52:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 02:52:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 02:52:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulkJoDT4wLJMLvnrzvnYfjPrc+dOqEbSvWY/mC1OQOB7B9NOq33F7PW6t17Z1HB+RBIERg7tKE7fQBXCai5TrgGNQn2YyKb7mXR+Gd43nQmpxD/n7IdO3Zqi/4fLo0KD4GyzLozNWQH72I6fL6puvqgnmqbX6ciPbq2qeOdyMVkfEWZD5BRLEsukiti2KwKWM1wiHJz+YnHvzBTwaro6fzzx+wAURAsd+Xs8ZIw2aW1HksRCuLoV7mVAxvC9iGcSmUbJDaCPNgFhNUyvjziYNCIwAT0fc6LGJ/RuOM3q66mRszO4ZjhLS+YYRgE1gPix5YK6T+DaNMnKWZKbqukW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyoBoo3uOcvZ3tKcBPpbe3/0oUc3o0OZLWId+rEJMX4=;
 b=w0IEV8y+glbLYxjN1BHK7e+EeX9vNl2AGtMn3kn3LpvQpzds+g8ylKqhD9rvVdvifSC9/tueLviWYkGZU4ufo2hC+WRdqrHBFWBhg9U1kSRY6kgEVDNdQ/Ra3Yi0R2yBMoqgqcaVZnC1ycqtYqVQaxrLa4l9ZdcFmygA2gdCU//CM7kSeOucYyYN1m7CXqgKKE1jrSzDftUMbBdBlpxX9TflGB1CHGJuuCm2yqoH84aJscovHVImt+7oBpRThhXLzNjVvrxBmeZGKtBkpqi4aRpQAu4/uEaVCPns3hvpVchIhmMYI128waQ/Y+xlv2aIB0tGG2Nz2/fwhQm3bjX2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:52:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:52:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Topic: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Index: AQHbl+v5GdaKalDSUk6u3PTGyZcGg7N7y3bw
Date: Thu, 20 Mar 2025 09:52:44 +0000
Message-ID: <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
In-Reply-To: <20250318095415.670319-25-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6016:EE_
x-ms-office365-filtering-correlation-id: 382f6cff-cd9b-442e-90a8-08dd6794f69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dERaTHVON2Q2UUZ1QUlmdFFjdUx1VW1jVm80MWFGbHpBc2FQdnB3OUZuUlQx?=
 =?utf-8?B?QllwdS8ydkVMcllHNjRGenZDemtUVXRQRU4wdnNHR29tc1V1RjM0UWZIMTZF?=
 =?utf-8?B?d1Vmb1JNem96aExKUkdtUVFvWFpDSkt5aWMrcC9VUzZQL0ZRS3ZPQWRhemJZ?=
 =?utf-8?B?OG5seE9Xa2hXeEd2RlduM3JZSitCN2JzQmR1WHZLN2dqcUlsNG9SbHRzREk4?=
 =?utf-8?B?a0E1Z0R2NjV0Ui9xb2NJbFU4ZXNja2VKeEI4MmFFM0E1ZENJSTBZWHBsNURx?=
 =?utf-8?B?eVFqQTZZL0VhU1ZnZVVrTlFMdFdTcVFXbC9XY0tPeHR6QStrSzFldWh0WlhS?=
 =?utf-8?B?VURETHlMQ01sNjMrb1owS1dHSFIxbFA5UHBub3QycVZ5cmEvQkZ6aEttdHEz?=
 =?utf-8?B?MS9VVGhYOFl4RUFyM282M3grTW9OaXNiVmc5RHRNaHM5L3hwblRqT3VSa3JG?=
 =?utf-8?B?Z1hRdCsyeHV3RHpYWStwZ0F6UmNkUldIREZ1RVlQV014L3dOcmw5Vm1McE9p?=
 =?utf-8?B?dCtpYVZGZFZ5eUdFeXNHTU4ydUUvaS9sdG9GWDhCTEZNTEhQakdYZXBWR1k2?=
 =?utf-8?B?eFdSci9hQ3RPQ3QxdGJyTjUxNm02b3RrOTNXM2hlM21jUDk2cmlJZ215cE1u?=
 =?utf-8?B?RlpqOW1lRzJwNUJGcUZIWEVZWS85VHZxV243MHpwOThta281cWV2NHorbzY4?=
 =?utf-8?B?UVZIUTloWHprWWNTY0s4cFl1THcxM1hlRHg4bzRMT0hyQzBveFlQaHdLOUhz?=
 =?utf-8?B?dG0xczZSWkFLalRpcTFWYXkvZG9XcGlGVXJONENubFhqWEFxb0M0YktNcDJQ?=
 =?utf-8?B?TUpLeGp4aTdTNUhnSkphOFQ1UllxajloZlE0ZDhUNkoxM2RSNjAzWXV6YnZR?=
 =?utf-8?B?bWRrVGJBeUZhUktzZ0NZSUsrUk4xTGVvakdDL0ZYZ0VjbVhNaTREb2cyR0wv?=
 =?utf-8?B?d3pMSFRlZ3FqN3FpRlNIcHJ0bGtLdGVBSGpRSHJMTklVOC9qWERhYm5meEM5?=
 =?utf-8?B?bTRmcUExa0pCZEk1VDNDalBza3VFNzU5QU9VS0NGNDhNOXhRSnBBMlVGd0tC?=
 =?utf-8?B?Q0R3UWYyUVlvK0tsalZuK0xwUmwwK3c2Wm5FL3R1S1ArdEdPdnhoYzdaZkxh?=
 =?utf-8?B?cllodnk4NkdtU05NWC9iQU9WbVRodi9PcENaOWZ1S1B4U3BmT05zOVpIZnBh?=
 =?utf-8?B?RThqcHpDSVBUc0VZOTRxTitKMWNCc1lkK2hHcnZoK0JYbS96cjFiZEVHLzlW?=
 =?utf-8?B?bWFYa0dacEx6UDZvRGdSUno4ZHM5clVnWVVyMTJuays2Vnk4VklGbzQzNFR5?=
 =?utf-8?B?MlJjZjR0WEhZam1ST2ZUajJhUG5ZRWxWdFk1M0NJcEZnQmZxclNiN2FjM3Q4?=
 =?utf-8?B?QmQ5VlpxZmpzK1JRT2VoK1JFQStZNk1GOCtEVzhqYWlEd3lyT25uTXV3VFBX?=
 =?utf-8?B?andhYTFWa1hsTnc4bTRNNDc4Z0x4NWdXc2pNeG1CTURBNWZoTWh2UlpyVG5T?=
 =?utf-8?B?OGZTcDZIZVFzSVl2Z2dwOUJWQzQ4V3dobzRON3FUaXJoMmZtMDlzSDcxZkF5?=
 =?utf-8?B?anRWK25xNExzelNkdDcxbFFBT3UvRVdQTG5KSWtSMEhGQmlpVURZbmNpQ1M1?=
 =?utf-8?B?Yk9WVkRiNDhldzAvTHlxSW9IUjg4dFNTMXBuNU9GMll3blBOa0M2cm5IcUc1?=
 =?utf-8?B?SWpHOW4xdkM0aEdZdjZDbXBFV3MvWjhrMFJEMGRpdmhjVnVYK3h4Z3pINExO?=
 =?utf-8?B?SEtzTnFZYUgweXlBSnl4U2ZML2JpTXB0QVVDOTJJT1IzUU9jQTZnUUxLeEdx?=
 =?utf-8?B?ejUzK3Y3ZnlvRDVDVW9qMGhPNTFGK0I5TldhQm1SWitQVnpsaG8wUHphaEpN?=
 =?utf-8?B?djRaUEcrYXRkZWlYc0YyVUIzNmdodGpIdkZvUFAzanEyWEFJTmlHanNLRURG?=
 =?utf-8?Q?wYdtObl0LdTiBnDGLo/uZok8ojopJoMD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFlM1YydVRsWkRuL002cGFxMmNmbU93R0NPVU5iQzh6OVh5UXl1Y3B4STFT?=
 =?utf-8?B?T2RkMnhRd0R4ajA3dDhEUStrTlB4ejFGc2ttR0kyNzZ0dGtTVzkzQzhxYldH?=
 =?utf-8?B?VG5JUS9qd1drRkNmZ05DdGNYeEI2UTd0aW5TQldlU2ZwRzNsWWdhM3pmTEVL?=
 =?utf-8?B?ejRIR2pXdnJjZjY1aHNDalovVXFQazBGNVNTd1hEcVA5dnRvcU9pdHpLbTNu?=
 =?utf-8?B?TUVkekV0QUF2WTI2ZzducUxVT2g4Q2JpOFJPRmJvOTlBNnZRL1R2a01zaWYx?=
 =?utf-8?B?MkdMZE5rbWJTSlAxdit6Rm5SeVhCUVRWOU9PczlaekxXY0tDS0xrbDBWY2JU?=
 =?utf-8?B?K0JpU1NxU3ZzcDAzT0xMUmNCcGZkYTNoM1VhTkdURUlERldnaXVXN3JFY1pS?=
 =?utf-8?B?YzIzUS9ablNDYXlRU21ybkJrbUJvczlBL3ZrMTYwTHhFU0huVURVVCtLZEVC?=
 =?utf-8?B?bGxYTHVRdWpSdWxPNXRFQlcybGZwMmVGTmx5Sk04Z1BxSkdHelA4a2g2UFow?=
 =?utf-8?B?SlhMTS90ZFBNamc2ZndYS3UvU3ZNSEVyMHlSUWJYcmZFUDdPd05zb2MwN1BV?=
 =?utf-8?B?NjFRQzFLWXhBWDFpaUx4czVIajYrVSsrUXF6WXYvYzIreXorOFQzOG9uZ3Br?=
 =?utf-8?B?TFZEcnlTSStFNU9vOSs3bHNOWWk4K3ZmM0dzRW9KZlhKakxna1JXalNHZ1hZ?=
 =?utf-8?B?Yk1ZbTdOOFRtRzhSZVNwQ0dNZFJsZWtxNHltREJqVjdVSWVuVXJjV1BjYTFM?=
 =?utf-8?B?N3NhLzR0ODZmS1BQQ0VVTDB3a3ViVjJ0cUd6eFpSRldMY09JR3dkdVd5bHJx?=
 =?utf-8?B?YnNYRmJzSXFQb3NGMzB5OThtTDNOaGZIaFRTUm1CWENLZkQxTVlhMG5QTHFT?=
 =?utf-8?B?ZncreXBEWUYwSHVVejdqUzdnb3FyeHZ5aUNuVDhUWjNFbTdzVlI0ZkxIZE9I?=
 =?utf-8?B?T3lIL3FBR2RZWXJPajN3clJFMlp2L3c4TGtQK0xHUWV3K1Q5MnFnazB6QUMz?=
 =?utf-8?B?SGZCd0g4TXBTcXVIV1J1WUY5dFg4bEdQSGNyb0QwNlhwSWhtNU9mOFIvem5y?=
 =?utf-8?B?OUNsMHVJdEhpMEdjY2ZUR2wzMDRFT3gvUkgxbGlxRUx1MUJnZHBWYkR0R0Jn?=
 =?utf-8?B?ZzVXQm50V0lkRncxejF5RkN4SHRvUlF4Skd3U1lDQWtwTWFvVXk5RmhrTFlW?=
 =?utf-8?B?aE9ueHh5UXpYQ1NZY2xxZTlUYmJqZW92NUZMMnd5UkJVaVBUeUdHSmoycUVn?=
 =?utf-8?B?YUNNRC8vZkxFMmFPUm9qQ1dsUldpZEQwQWJEK2s1YzFuZjdzZ3hzQlBNS2F1?=
 =?utf-8?B?dW5xMW5vUUFIRW53Zm5PYjdleG5MMVVUSXd3QzRnb3VKbVZaL2k3aWRDNkl1?=
 =?utf-8?B?WUQxb3dPcnBVWGtFMFNSU01HZm04eTByRnJTYVlzR056YTRYaWZCNjF3TmRC?=
 =?utf-8?B?eHE0QWJzNHVUSk9OdVJ1MnNJTFpibGtLbkw4UXRKeUdPZENnZkxoMlZlTy92?=
 =?utf-8?B?T1RIcVVUVUs0Szc3ZnEvOFhIVEJSTUkzdXRuZFU1d3N2NUs3Zk1xYmJoM2ox?=
 =?utf-8?B?cTgyYlBGdWNmSkoxQmNURnVLbzNWbHZpNS9CdHlHVEZQdEN6SjU3ZHpwV0JX?=
 =?utf-8?B?bG1aRVNIV3UxanpVYktFUlpJNzV3cDNpSlpkMW5xYm9SUFRtc3pGRmY3TTQw?=
 =?utf-8?B?djlOY1Vuakxib3l4M2wzQStFRW9ZUnRIQ216V3d3L20zMzBSOE9Cai96UjhD?=
 =?utf-8?B?UTU0bXZIYVVXRHhVWUJiYmFsbVZsSHNCaUpMMWR2bXNIZ3pzNWJUMyszdTVU?=
 =?utf-8?B?RFE4NG52ZVJxY0E4aW9BcGNrZFNVNkhyczJRenFHeFd6OFQ1Nk5mTGl1MWs1?=
 =?utf-8?B?Q0JMMTN3YkczU3Noa1cwcTNSdEN2NDE2NENUdXc1cktMdmRCanYxRkJxSXY3?=
 =?utf-8?B?SGlHcEN6VkExeDVDNW92L2paVmg0eGhrTkhDblF5Wk13QWZDblJvT1dVRE9G?=
 =?utf-8?B?OXIwSFJqSTZnczYyelBTdmZqcTVvR1IyZ005dm1aY3cwWUlUSHVGSHI5YkU4?=
 =?utf-8?B?MEU0SEoyMG9oMWRJdzhVU2RKaFBSV0xUZ3hwSHZHUk9TTitYVHFxQXJRdUto?=
 =?utf-8?Q?7F9SIby1tZFHVpbSJvCeh3uIF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382f6cff-cd9b-442e-90a8-08dd6794f69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:52:44.6650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wISoOcMu2lcDK7ejlbICb4arTGMh0mCbHjZcYczn8QkWawPMzGjza4kxzQxseegGbCp7JkETBXqosjhhuYM53qADtZDVxUUyIVn5PZ65G+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgMjQvMzJdIHZmaW86
IEludHJvZHVjZSBuZXcgZmlsZXMgZm9yIGRpcnR5IHRyYWNraW5nDQo+ZGVmaW5pdGlvbnMgYW5k
IGRlY2xhcmF0aW9ucw0KPg0KPkZpbGUgImNvbW1vbi5jIiBoYXMgYmVlbiBlbXB0aWVkIG9mIG1v
c3Qgb2YgaXRzIGRlZmluaXRpb25zIGJ5IHRoZQ0KPnByZXZpb3VzIGNoYW5nZXMgYW5kIHRoZSBv
bmx5IGRlZmluaXRpb25zIGxlZnQgYXJlIHJlbGF0ZWQgdG8gZGlydHkNCj50cmFja2luZy4gUmVu
YW1lIGl0IHRvICJkaXJ0eS10cmFja2luZy5jIiBhbmQgaW50cm9kdWNlIGl0cyBhc3NvY2lhdGVk
DQo+ImRpcnR5LXRyYWNraW5nLmgiIGhlYWRlciBmaWxlIGZvciB0aGUgZGVjbGFyYXRpb25zLg0K
Pg0KPkNsZWFudXAgYSBsaXR0bGUgdGhlIGluY2x1ZGVzIHdoaWxlIGF0IGl0Lg0KPg0KPlNpZ25l
ZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4tLS0NCj4gaHcv
dmZpby9kaXJ0eS10cmFja2luZy5oICAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysr
KysrKysrDQo+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAgIHwgMTAgLS0t
LS0tLS0tLQ0KPiBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICAgICAgICAgICB8ICAxICsN
Cj4gaHcvdmZpby97Y29tbW9uLmMgPT4gZGlydHktdHJhY2tpbmcuY30gfCAgNSArLS0tLQ0KPiBo
dy92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gaHcvdmZpby9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiBody92ZmlvL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+IDcgZmlsZXMgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBody92Zmlv
L2RpcnR5LXRyYWNraW5nLmgNCj4gcmVuYW1lIGh3L3ZmaW8ve2NvbW1vbi5jID0+IGRpcnR5LXRy
YWNraW5nLmN9ICg5OSUpDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vZGlydHktdHJhY2tpbmcu
aCBiL2h3L3ZmaW8vZGlydHktdHJhY2tpbmcuaA0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+aW5k
ZXgNCj4wMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi40YjgzZGM1NGFi
NTBkYWJmZmYwNDBkN2NjMw0KPmRiMjdiODBiZmUyZDNhDQo+LS0tIC9kZXYvbnVsbA0KPisrKyBi
L2h3L3ZmaW8vZGlydHktdHJhY2tpbmcuaA0KPkBAIC0wLDAgKzEsMjIgQEANCj4rLyoNCj4rICog
VkZJTyBkaXJ0eSBwYWdlIHRyYWNraW5nIHJvdXRpbmVzDQo+KyAqDQo+KyAqIENvcHlyaWdodCBS
ZWQgSGF0LCBJbmMuIDIwMjUNCj4rICoNCj4rICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXINCj4rICovDQo+Kw0KPisjaWZuZGVmIEhXX1ZGSU9fRElSVFlfVFJBQ0tJ
TkdfSA0KPisjZGVmaW5lIEhXX1ZGSU9fRElSVFlfVFJBQ0tJTkdfSA0KPisNCj4rZXh0ZXJuIGNv
bnN0IE1lbW9yeUxpc3RlbmVyIHZmaW9fbWVtb3J5X2xpc3RlbmVyOw0KPisNCj4rYm9vbCB2Zmlv
X2RldmljZXNfYWxsX2RpcnR5X3RyYWNraW5nX3N0YXJ0ZWQoY29uc3QgVkZJT0NvbnRhaW5lckJh
c2UNCj4qYmNvbnRhaW5lcik7DQo+K2Jvb2wgdmZpb19kZXZpY2VzX2FsbF9kZXZpY2VfZGlydHlf
dHJhY2tpbmcoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UNCj4qYmNvbnRhaW5lcik7DQo+K2ludCB2
ZmlvX2RldmljZXNfcXVlcnlfZGlydHlfYml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpi
Y29udGFpbmVyLA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklPQml0
bWFwICp2Ym1hcCwgaHdhZGRyIGlvdmEsIGh3YWRkciBzaXplLA0KPisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPitpbnQgdmZpb19nZXRfZGlydHlf
Yml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLCB1aW50NjRfdCBpb3Zh
LA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHNpemUsIHJhbV9hZGRyX3Qg
cmFtX2FkZHIsIEVycm9yICoqZXJycCk7DQo+Kw0KPisjZW5kaWYgLyogSFdfVkZJT19ESVJUWV9U
UkFDS0lOR19IICovDQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5o
IGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj5pbmRleA0KPjE4NGE0MjI5MTZmNjIy
NTkxNThlODc1OWVmYzQ3M2E1ZWZiMmIyZjcuLmNjMjAxMTBkOWRlOGFjMTczYjY3ZTZlODc4DQo+
ZDRkNjE4MTg0OTc0MjYgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmgNCj4rKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPkBAIC0xMzAsNyArMTMw
LDYgQEAgVkZJT0RldmljZSAqdmZpb19nZXRfdmZpb19kZXZpY2UoT2JqZWN0ICpvYmopOw0KPg0K
PiB0eXBlZGVmIFFMSVNUX0hFQUQoVkZJT0RldmljZUxpc3QsIFZGSU9EZXZpY2UpIFZGSU9EZXZp
Y2VMaXN0Ow0KPiBleHRlcm4gVkZJT0RldmljZUxpc3QgdmZpb19kZXZpY2VfbGlzdDsNCj4tZXh0
ZXJuIGNvbnN0IE1lbW9yeUxpc3RlbmVyIHZmaW9fbWVtb3J5X2xpc3RlbmVyOw0KPg0KPiAjaWZk
ZWYgQ09ORklHX0xJTlVYDQo+IGludCB2ZmlvX2dldF9yZWdpb25faW5mbyhWRklPRGV2aWNlICp2
YmFzZWRldiwgaW50IGluZGV4LA0KPkBAIC0xNDAsMTUgKzEzOSw2IEBAIGludCB2ZmlvX2dldF9k
ZXZfcmVnaW9uX2luZm8oVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+dWludDMyX3QgdHlwZSwNCj4g
Ym9vbCB2ZmlvX2hhc19yZWdpb25fY2FwKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBpbnQgcmVnaW9u
LCB1aW50MTZfdCBjYXBfdHlwZSk7DQo+ICNlbmRpZg0KPg0KPi1ib29sIHZmaW9fZGV2aWNlc19h
bGxfZGlydHlfdHJhY2tpbmdfc3RhcnRlZCgNCj4tICAgIGNvbnN0IFZGSU9Db250YWluZXJCYXNl
ICpiY29udGFpbmVyKTsNCj4tYm9vbA0KPi12ZmlvX2RldmljZXNfYWxsX2RldmljZV9kaXJ0eV90
cmFja2luZyhjb25zdCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+LWludCB2Zmlv
X2RldmljZXNfcXVlcnlfZGlydHlfYml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29u
dGFpbmVyLA0KPi0gICAgICAgICAgICAgICAgVkZJT0JpdG1hcCAqdmJtYXAsIGh3YWRkciBpb3Zh
LCBod2FkZHIgc2l6ZSwgRXJyb3IgKiplcnJwKTsNCj4taW50IHZmaW9fZ2V0X2RpcnR5X2JpdG1h
cChjb25zdCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwgdWludDY0X3QgaW92YSwNCj4t
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBzaXplLCByYW1fYWRkcl90IHJhbV9h
ZGRyLCBFcnJvciAqKmVycnApOw0KPi0NCj4gLyogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9yIGEg
bmVnYXRpdmUgZXJybm8uICovDQo+IGJvb2wgdmZpb19kZXZpY2VfZ2V0X25hbWUoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCk7DQo+IHZvaWQgdmZpb19kZXZpY2Vfc2V0X2ZkKFZG
SU9EZXZpY2UgKnZiYXNlZGV2LCBjb25zdCBjaGFyICpzdHIsIEVycm9yICoqZXJycCk7DQo+ZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+aW5k
ZXgNCj40ZTQxYTc0NzY1NDlhMGM1ZTQ2NGU0OTlkMDU5ZGI1YWNhNmUzNDcwLi5lODhkZmUxMmVk
ZDZkZWU0NjljMDZlZTJlDQo+NDZhYjljOGI1MDE5YWU3IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8v
Y29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+QEAgLTM1LDYgKzM1LDcg
QEANCj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWluZXIuaCINCj4gI2luY2x1ZGUgImhl
bHBlcnMuaCINCj4gI2luY2x1ZGUgImNwci5oIg0KPisjaW5jbHVkZSAiZGlydHktdHJhY2tpbmcu
aCINCj4NCj4gI2RlZmluZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPDQo+VFlQ
RV9IT1NUX0lPTU1VX0RFVklDRSAiLWxlZ2FjeS12ZmlvIg0KPg0KPmRpZmYgLS1naXQgYS9ody92
ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9kaXJ0eS10cmFja2luZy5jDQo+c2ltaWxhcml0eSBpbmRl
eCA5OSUNCj5yZW5hbWUgZnJvbSBody92ZmlvL2NvbW1vbi5jDQo+cmVuYW1lIHRvIGh3L3ZmaW8v
ZGlydHktdHJhY2tpbmcuYw0KPmluZGV4DQo+ZWQyZjJlZDg4MzljYWFmNDBmYWJiMGNiYmNhYTFk
ZjJjNWI3MGQ2Ny4uNDQxZjlkOWEwOGMwNmE4OGRkYTQ0ZWYxNDNkDQo+Y2VlNWYwYTg5YTkwMCAx
MDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+KysrIGIvaHcvdmZpby9kaXJ0eS10cmFj
a2luZy5jDQo+QEAgLTIwLDE0ICsyMCwxMCBAQA0KPg0KPiAjaW5jbHVkZSAicWVtdS9vc2RlcC5o
Ig0KPiAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+LSNpZmRlZiBDT05GSUdfS1ZNDQo+LSNpbmNs
dWRlIDxsaW51eC9rdm0uaD4NCj4tI2VuZGlmDQoNCkl0IGxvb2tzIHRoaXMgY2hhbmdlIHVucmVs
YXRlZCB0byB0aGlzIHBhdGNoPw0KDQo+ICNpbmNsdWRlIDxsaW51eC92ZmlvLmg+DQo+DQo+ICNp
bmNsdWRlICJody92ZmlvL3ZmaW8tY29tbW9uLmgiDQo+ICNpbmNsdWRlICJody92ZmlvL3BjaS5o
Ig0KPi0jaW5jbHVkZSAiZXhlYy9hZGRyZXNzLXNwYWNlcy5oIg0KDQpTYW1lIGhlcmUuDQoNClRo
YW5rcw0KWmhlbnpob25nDQoNCj4gI2luY2x1ZGUgImV4ZWMvbWVtb3J5LmgiDQo+ICNpbmNsdWRl
ICJleGVjL3JhbV9hZGRyLmgiDQo+ICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiDQo+QEAg
LTQ1LDYgKzQxLDcgQEANCj4gI2luY2x1ZGUgInN5c3RlbS90cG0uaCINCj4gI2luY2x1ZGUgIm1p
Z3JhdGlvbi5oIg0KPiAjaW5jbHVkZSAiaGVscGVycy5oIg0KPisjaW5jbHVkZSAiZGlydHktdHJh
Y2tpbmcuaCINCj4NCj4gLyoNCj4gICogRGV2aWNlIHN0YXRlIGludGVyZmFjZXMNCj5kaWZmIC0t
Z2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4DQo+YjI1
ZjNiNDA4NmQ3YjdmYzZmY2Q1MTlhOWI4YjI5MDQ1MTNhNjU1Zi4uOTMzNWExNzkyMGIzMmRjMmJm
OWNiNGVlYjJiDQo+OGY1NzM4MmYxNGFjOCAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2lvbW11ZmQu
Yw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTI5LDYgKzI5LDcgQEANCj4gI2luY2x1
ZGUgImlvbW11ZmQuaCINCj4gI2luY2x1ZGUgImhlbHBlcnMuaCINCj4gI2luY2x1ZGUgImNwci5o
Ig0KPisjaW5jbHVkZSAiZGlydHktdHJhY2tpbmcuaCINCj4NCj4gI2RlZmluZSBUWVBFX0hPU1Rf
SU9NTVVfREVWSUNFX0lPTU1VRkRfVkZJTyAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgIFRZ
UEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCAiLXZmaW8iDQo+ZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vbWVzb24uYnVpbGQgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+aW5kZXgNCj4xZjg5YmQyOGMx
M2RlYTU1YmNmZmY0NzZjZTk5ZDUxYjQ1M2Q4NTMzLi5iNmY1YTdlZWVkYTAzNWI1ODcyYzJhMTlm
ODANCj44NjM4NGUwMDBmNDIwIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vbWVzb24uYnVpbGQNCj4r
KysgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+QEAgLTEsNiArMSw2IEBADQo+IHZmaW9fc3MgPSBz
cy5zb3VyY2Vfc2V0KCkNCj4gdmZpb19zcy5hZGQoZmlsZXMoDQo+LSAgJ2NvbW1vbi5jJywNCj4r
ICAnZGlydHktdHJhY2tpbmcuYycsDQo+ICAgJ2NvbnRhaW5lci5jJywNCj4gICAnaGVscGVycy5j
JywNCj4gKSkNCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby90cmFjZS1ldmVudHMgYi9ody92ZmlvL3Ry
YWNlLWV2ZW50cw0KPmluZGV4DQo+YTFkMDFlOWRkZTZlYzUyOTY0ZDQ4MDRlOWNiY2U1YTZhMzJi
Nzg3OS4uZjNiZGNlYmU5MzhkY2NhNzdiOTEzZWY4MWENCj43NDY0NGM2MjJiNWQ4YSAxMDA2NDQN
Cj4tLS0gYS9ody92ZmlvL3RyYWNlLWV2ZW50cw0KPisrKyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRz
DQo+QEAgLTg5LDcgKzg5LDcgQEAgdmZpb19wY2lfaWdkX2Jkc21fZW5hYmxlZChjb25zdCBjaGFy
ICpuYW1lLCBpbnQgc2l6ZSkNCj4iJXMgJWRNQiINCj4gdmZpb19wY2lfaWdkX2hvc3RfYnJpZGdl
X2VuYWJsZWQoY29uc3QgY2hhciAqbmFtZSkgIiVzIg0KPiB2ZmlvX3BjaV9pZ2RfbHBjX2JyaWRn
ZV9lbmFibGVkKGNvbnN0IGNoYXIgKm5hbWUpICIlcyINCj4NCj4tIyBjb21tb24uYw0KPisjIGRp
cnR5LXRyYWNraW5nLmMNCj4gdmZpb19pb21tdV9tYXBfbm90aWZ5KGNvbnN0IGNoYXIgKm9wLCB1
aW50NjRfdCBpb3ZhX3N0YXJ0LCB1aW50NjRfdCBpb3ZhX2VuZCkNCj4iaW9tbXUgJXMgQCAweCUi
UFJJeDY0IiAtIDB4JSJQUkl4NjQNCj4gdmZpb19saXN0ZW5lcl9yZWdpb25fc2tpcChjb25zdCBj
aGFyICpuYW1lLCB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kKQ0KPiJTS0lQUElORyAlcyAw
eCUiUFJJeDY0IiAtIDB4JSJQUkl4NjQNCj4gdmZpb19zcGFwcl9ncm91cF9hdHRhY2goaW50IGdy
b3VwZmQsIGludCB0YWJsZWZkKSAiQXR0YWNoZWQgZ3JvdXBmZCAlZCB0byBsaW9ibg0KPmZkICVk
Ig0KPi0tDQo+Mi40OC4xDQoNCg==

