Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BA6C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 03:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8ttl-0006px-6p; Sun, 19 May 2024 23:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8ttk-0006pp-4f
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:41:16 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8tth-0007el-Ox
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716176474; x=1747712474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u+AhAVWtwMi5FgbZ+i4Jn1MxrPZor7Url6pAZjO6LXY=;
 b=HONxIQ/I5wq/8Bls6O6ttAenUPMZudtYezqxR83N1YjSPx49sgHoVKyB
 vZiYshWooZ5xWhmg13Fj54iJymP+Y9MWwzvI1FikHIJRTBov4ZxyIwROZ
 Iis/6rxxqWCYUzGTTqggOefCDvUjob4HwSNp768j/NOmv3huY1Hulq9cf
 M4o9e3eEBs+HarLhwKozV3RcE6TBDbyKMvk7tD+t/Y6DANAVu/nuWs/NZ
 ZPIG2e0G9tKi+hTGsqMMWQG4rpr2rmic9g8ovPMix5pMcwfzgIVUf6o3w
 cERYJ+7WVTji30nDWdTTHTu0S9pfIHm4MuLipKhgz4jCaT2+p4yHbganl w==;
X-CSE-ConnectionGUID: v0gHCEhaSbyZ7EnkVqwGmw==
X-CSE-MsgGUID: BgPk8KJsRQC6Cm/fUAU+lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12408501"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12408501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2024 20:41:09 -0700
X-CSE-ConnectionGUID: l4N4ik0wT2KrEikh18nRzg==
X-CSE-MsgGUID: 23V3Ymn0Qxeer+db2zyd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="32413792"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 May 2024 20:41:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:41:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:41:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:41:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QabDSlKEB3u7go40w/RjBWjxz8A4GDX/EPujg46CqNHkc83L/Nwj0bAUhtEIUpdsVbthp4cmqaCJrnYAEYeyxErOfGOB2VqW4mEYRXuH+8YzfoyInUoOLqNOxyVl6PWOn70D6SnuDMdljAfkXTXXkiZoJsAVuFqt3rM9yBSRhkNgaNhJt9zuQoO23i4HzNl/qvD9pJ5xMzNpcdTBxMX40BxratRvC0gDHUu9TwlCAz4GxrcXChmgNPHMWx60xxfh0dwKP8IGS8/GtDovJuELued98wPh/VbmjZriGBHDGxaiDndGtDPLWlzCB+iTbRAD57for7wyaR4VwKTz+DReKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+AhAVWtwMi5FgbZ+i4Jn1MxrPZor7Url6pAZjO6LXY=;
 b=LFTQd/BJK1smm4Dg+Fo/4WWlRL4GBgiCGaQB+ry/eiU9eQDgA27s9HXjbQ7v/frShMsOm7XTv3N9uD5gD7sbLaeUpigdtww53MBdXDEN6ZW8VZrRJRVGgyhoAvH9b06syIhkSgC9vy6E1me0kK4TBgsPdyp75wxXPbPXNGc9j0Aw0UlPe1QNdJ7KJTVXFj05jWSbh8HxAYqUCS9NjjYG+x22uq/XaxlgC0iQTpxLbxvJ4l7zoE5mjysE8S5XY8lktqT2m5gQH1YDUeC2u2E8/kbaUKOcH3TzPiTSS2YIOieq3C13SQJ4mmBbfj7BpNxa2zadh8/L9QsoSTmIg7RT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 20 May
 2024 03:41:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:41:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mA=
Date: Mon, 20 May 2024 03:41:06 +0000
Message-ID: <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
In-Reply-To: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8386:EE_
x-ms-office365-filtering-correlation-id: 606e0fc8-fddb-44d2-13cb-08dc787eae43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?N3J1QWZGd3pHeE1UWmc5YmNwWEFhREU4cTZ3dzk3T1dUcVBOQ3U2SzdDTXJR?=
 =?utf-8?B?L0hoU0owR0J3V2tNSngrWCt5c2grQWRnS0VoU2JNb0hRT2Erb3JCYWN2dWtL?=
 =?utf-8?B?eUZCREl6QVZkOURELzBqSGpERzMzbVBQaHk4cmJSeUNCeDM2aUNyTU9CbndT?=
 =?utf-8?B?M3ZWOCsxVnFKcEVKaVh4QS83eG9OMHlOMHlhZ0IyNE9NTFQvdXdNQjFNbm1u?=
 =?utf-8?B?cEMrdjAyMktlSlJVbmdzYWFmeFVpRWVjRmVVZ2MzWGgzSE9NOGV4SkYxemkz?=
 =?utf-8?B?UitWaXorb1JRVVc4TjNZUHA4RFRzZ2dkdVJQK2FNTEFDMHlEd1JxeGVLODM5?=
 =?utf-8?B?Tjh6K2dLSXhRZ3BURnhtN1JtZlNxUUhqSlcrQWw2KzhKbVFRSThVQ25WYjc3?=
 =?utf-8?B?WnNXMWdET1JMTUtQblE0UDlVM1FFSGZTZjBKS1RpYVN3ckFjdEFHUC9VT3pN?=
 =?utf-8?B?MC95TlpIN29FU3RRTTJsbGNrQ1RaWGN2NDF0dE5QRlJSUXRwMXNaTjdvOUZr?=
 =?utf-8?B?S09OK2FRU0RsSlAyVWlqc3JMNCtkSEZKODVyazV3LzVYMnYvOG1nLy9DQ3p6?=
 =?utf-8?B?ejQ0ZEI0dGdMNkFkbXEwQzI5bWUwRGRUVlBvdElsakVINC9QdGcwMldDQ25a?=
 =?utf-8?B?cGhHaStlRmw5RlhZQUpGcldLeGlzS1ZoOXhsaDV4dTFqMVlMcE9uR0c1SUJ1?=
 =?utf-8?B?R0lFSUozajViQno4NFRiRmFveVg4aVpRN1lvUVVvSjE1WnNJTXRMOFBYdGxO?=
 =?utf-8?B?b1pEamZCWnJFbTJBelpUdHlhd2dSWUExUFRXaTdTQXFyVmREa1B2VkwwZHFx?=
 =?utf-8?B?RnRlYlJCQlFiaksySnlONUJNalBBd05LZUVxSzczbUppY0tZS2pzQ011dFVx?=
 =?utf-8?B?bWgyZDZsbzk3VFlvMVI0dHhrWTNrdi9ld3dNajdSSGZKRkVEV0Z3Sm03WVJy?=
 =?utf-8?B?UkNReThBZTVrYzV6bFZHYlQ3M0xPa1lELzhhZTB4Yk5BL2h3TXUrYy9UTm9Z?=
 =?utf-8?B?ODZsZTIrb0JUbXAwSVBYZ1BTMWZ4cXVIMWoxaW5kRy91d0R6ck9ZMVFzVEpG?=
 =?utf-8?B?Qjdzb3AyWStGbWlGdURWRldzUW1ZUkptajduNE4yVmNub1dTN2o3RktIV3NQ?=
 =?utf-8?B?OFRCbk5zanlwTFVGSzczWEYrMzFMT1lhZEN2Z2F5ZEMxSkdGcGtmckplRklX?=
 =?utf-8?B?WWhFNGM4RmtWbFVoaDYrRnh0RDRmdVlvTUU2Tk1RVzJheElwZWxDdzlzVlVt?=
 =?utf-8?B?VDFSanVKS0cyRjlhUGtNQXg5TEhRNVducWxQMjdIUlFwakZpWkpJVWloamFB?=
 =?utf-8?B?a2ZGMnA1WHVoNUJvMVREQUtaYmk2MjN3NTllQ0xSUmxLYnZ1ZlFORGFBdFAz?=
 =?utf-8?B?N1ErclFuK3V2MVAwZjRqMnNYdXZwQjlsOHk4NGVhNUxMdmtVWGlUWG42TUp0?=
 =?utf-8?B?OHRKa3pEa3h4Q0N1N1AxRTMzeldHWDNYOVpyZWVvS1dFeld5cUxaZU1nL3J5?=
 =?utf-8?B?Y0xOTU1iOTlEbFVUbm5zb0Zya3JEcnFqUjEvdElGQ3drWnVBTnNESjVUZFA0?=
 =?utf-8?B?b2FZeHNMd1NjbGdOWGFMUFBKTHdtcFNrM1Q3ZnVZdXFHaGoxVTFKcUpUZXpO?=
 =?utf-8?B?aU9VY3dYS2N1azZGNWwxV2Q5UUJDU2RBV3lxbGxkSWNWTlJyRll1NXNtVklN?=
 =?utf-8?B?N0s2aDhWU2pxdFBzbHBYYXg1Q013VHNXUWxyU1FGd3dJNXJvYjU2VXMzQ3Vq?=
 =?utf-8?B?ZDltSlplVFpZOUN0RVpwUnpaSnVGWkVaYVg0SThlTVFwU1NTcGo3S3lQNUlF?=
 =?utf-8?B?bitSKzBBeXk4cFRuRWVqUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJJK1ZScWhrcFhGNkpUTk5JVE8xVGFkc0NBZndxdmVGZ3BvODByNnkvbVNR?=
 =?utf-8?B?TjUzUVZYNTg4RnFLNDB2OUplYmQ1ek45aXNiZUNCbmEydjRVNzJuMW9Ybyt5?=
 =?utf-8?B?c0Rnd3U2WXFycDZ6TXA1dXJHUDYxampJMlhybUwxUVFNelhJdWNWTmEyU25k?=
 =?utf-8?B?SHdCMGJKYlg0c2dhKzRweGd3eXlnY1FiVnBWQjlsU3dvWjBaZzhFWWpZN0RR?=
 =?utf-8?B?Snl3S0IrT2RGZVRlclVwUkp0SjNuNmhYb1cvZ21aMzRuWFAvQUNpR1MxeTlr?=
 =?utf-8?B?SlI3UUt2dElLbDY0R1dtVnV6VTBldTNRMFYwMjdNMWVYbjJSa2tDZEQ0WGFo?=
 =?utf-8?B?LzA3aWxleWV6Z2FKQUhGWjZlOUZYeFY3RmtDV04wYkZyYlp2Y0tVU25hOXhZ?=
 =?utf-8?B?SXk1QWhuMVc5eHprTWp2cXJZL3lUMmYvZy9PczROZDhpaEVuL1M0Z1Fhdlpv?=
 =?utf-8?B?dkZHcEVMd2ZDNjZ4SXh4SWJKMk92SzJZNjU0R2hjWm5UWnBBRnVYUUF2bUpl?=
 =?utf-8?B?VW85YkMyOW44TVA5QkNhSHFWZC9XWmExY0dzRTRpQ2RXdGE3L2ViVkFRb2Yr?=
 =?utf-8?B?ZGhGdzNSaTdtdWw4bGhTalBiZVY0VTJncW11WkNUMVlLb1I4R1pqZG1GRG9o?=
 =?utf-8?B?bnJTNUpGRVVVeGZBYVNyNFRWaktBdXBhOWZtd2M4b3pnU2JGOG1Sb2RrSElW?=
 =?utf-8?B?VFFGeS94U0JJY1hmdXl0cko4UWVEbTk1MWVzSTFvTlY3OHhIR1g4UDhBMnhX?=
 =?utf-8?B?dHNWcFZ3MXM1OFJSak9TTThvR0FwM2xqNE84dEM0b3lNVmRnUDg4eUwvUnFo?=
 =?utf-8?B?QW03SDF1S0twcFNRa0MxeXN2bnRUWVJ3UElrWkY5RU4rQTF6ajJ5VEpTQi9W?=
 =?utf-8?B?T3I4YUtESjFzSHB2UHZZSGFWV3BpazVPVitJeldFdFRXQjdmUmZmaGtwQkN5?=
 =?utf-8?B?S3FWWXJjUy83RUhYb0xRaUh0OEZyREt0Qks2QUJFcldjZDZSeXRkL2psVTdU?=
 =?utf-8?B?SWQ2d3g5aUZqNFZoczUvNEI4OWlxVXVCWm9ySlluTUhjYUlyenlCNjB1aXk3?=
 =?utf-8?B?TnRmK05Xem1jNW1DN1M5YlEyOFlvbmV5NkVldGI3QjYyWXpIL29WZmFNWkNt?=
 =?utf-8?B?ZlJONUd0S3hoVFBGeUw3bnZYcVBRU002cVliN2RLcTR2S3FEdnUvRWU0bzBT?=
 =?utf-8?B?bEdZQVk0bERDSWVKZzlNSkNiQ01Eb2Y2VDZ4OVlhL0Z5bm13RGt4S2JGNDhV?=
 =?utf-8?B?d0JON1JtT0pDbzBCZGMveCthcjc1UkZ2d203amtZL29UZ3dBdG1ndTB6bURS?=
 =?utf-8?B?N3hDc2NnVkl6azJuVlRPRGpJcFFGL0E3MFcrU09NM0l0RVVVVXFqdCsxV0p0?=
 =?utf-8?B?Y2FXZXRiR2U2TlZKMGJ4b0xFc3FnVjhSNUd5bVN5cGtCaUtXSXQ1TFhoYndE?=
 =?utf-8?B?elVYWFFOU0ZvdmFqeGM3NTlZbnVJWlJpallaVDJzK2U0bE5zMHovcU5NRjJV?=
 =?utf-8?B?c0VOMFZ3RytCL3dkSFNCWGo0cDlPcjRnSytNWkJsbm8yMjJ4eFV3SjBKQWhh?=
 =?utf-8?B?OVZjS05QSmtmUWVTR3daOFQrNnlISFl3YzlmQllGRnVHTDNHSWRMS0dDTUg3?=
 =?utf-8?B?MVRhQ1o4R29EVlpHc3pqVGRjVHVhT05lRzRzd0w0RzNXdTNLU3R5MGs1TW56?=
 =?utf-8?B?RzdmUnFxQXVXMmZsWThlSC83dWhuMTgwTDVYYWtTeGxHTWk0dndUUmFEOURO?=
 =?utf-8?B?S0ZsU1pidm5Tc29XOWNFMXgzR1ZIQUZjYnlaY01oR2w4REpsWitlcWhqd3JB?=
 =?utf-8?B?Nmx5NS80aHhZVEJaZS9BRFVhamR3TTFpb1ZseE4vOEN5RkZOeTRidlZHRmFR?=
 =?utf-8?B?N0gwelRGVXdVVjE3dHdRc0JLOGtNWDZMdUV5bWZFdytKbENUNlJMR2pqU05Y?=
 =?utf-8?B?UG1kN1FUWWRhR2dndlFPdkRrYmJPbDJlZHl4dnNYWGp0MjdGMUJmVHdNdTEx?=
 =?utf-8?B?NVdjK0pGVUl2bHU1bnVOeTN5UGpZOW83aExXVGFRR0ZCdk9iQno4bFJLMkcy?=
 =?utf-8?B?VHB3d2xCa3FFMVBnSVlha3E4bFlYRVFybyt6ZXp1Uisva3NFNjdjY3lUQkVX?=
 =?utf-8?Q?EurOEYvJwiMinqUK1kPWZ4/hT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606e0fc8-fddb-44d2-13cb-08dc787eae43
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:41:06.4506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgPysY875Abv2mZREP/SpDFptM9C0LKFn6v0jIZMgbSJC8Yea4hReSp69gQ2BiWbWzvrpN9B3Rns/IBexoGFljUS9sSoTo16yKrIkyn+rNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U2VudDogTW9uZGF5LCBNYXkgMjAsIDIwMjQgODo0NCBBTQ0KPlRv
OiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5DYzogcWVtdS1k
ZXZlbEBub25nbnUub3JnOyBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENo
YW8gUA0KPjxjaGFvLnAucGVuZ0BpbnRlbC5jb20+OyBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51
eC5pbnRlbC5jb20+OyBNaWNoYWVsDQo+Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBQYW9s
byBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsNCj5SaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29zdA0KPjxlZHVhcmRvQGhh
Ymtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+
DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0
IHJlYXNvbnMgZGVmaW5lZCBieQ0KPnNwZWMNCj4NCj5PbiBGcmksIE1heSAxNywgMjAyNCBhdCA2
OjI24oCvUE0gWmhlbnpob25nIER1YW4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90
ZToNCj4+DQo+PiBGcm9tOiBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5pbnRlbC5jb20+DQo+
Pg0KPj4gQ3VycmVudGx5IHdlIHVzZSBvbmx5IFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgYXMgZmF1
bHQgcmVhc29uLg0KPj4gVXBkYXRlIHdpdGggbW9yZSBkZXRhaWxlZCBmYXVsdCByZWFzb25zIGxp
c3RlZCBpbiBWVC1kIHNwZWMgNy4yLjMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWXUgWmhhbmcg
PHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPg0KPkkgd29uZGVyIGlm
IHRoaXMgY291bGQgYmUgbm90aWNlZCBieSB0aGUgZ3Vlc3Qgb3Igbm90LiBJZiB5ZXMgc2hvdWxk
DQo+d2UgY29uc2lkZXIgc3RhcnRpbmcgdG8gYWRkIHRoaW5nIGxpa2UgdmVyc2lvbiB0byB2dGQg
ZW11bGF0aW9uIGNvZGU/DQoNCktlcm5lbCBvbmx5IGR1bXBzIHRoZSByZWFzb24gbGlrZSBiZWxv
dzoNCg0KRE1BUjogW0RNQSBXcml0ZSBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzIwOjAwLjBd
IGZhdWx0IGFkZHIgMHgxMjM0NjAwMDAwIFtmYXVsdCByZWFzb24gMHg3MV0gU006IFByZXNlbnQg
Yml0IGluIGZpcnN0LWxldmVsIHBhZ2luZyBlbnRyeSBpcyBjbGVhcg0KDQpNYXliZSBidW1wIDEu
MCAtPiAxLjE/DQpNeSB1bmRlcnN0YW5kaW5nIHZlcnNpb24gbnVtYmVyIGlzIG9ubHkgaW5mb3Jt
YXRpb25hbCBhbmQgaXMgZmFyIGZyb20NCmFjY3VyYXRlIHRvIG1hcmsgaWYgYSBmZWF0dXJlIHN1
cHBvcnRlZC4gRHJpdmVyIHNob3VsZCBjaGVjayBjYXAvZWNhcA0KYml0cyBpbnN0ZWFkLg0KDQpU
aGFua3MNClpoZW56aG9uZw0KDQo=

