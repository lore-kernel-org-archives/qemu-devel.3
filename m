Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5928C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmLs-0001xJ-TM; Mon, 22 Jul 2024 02:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmLe-00010C-Mt
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:16:46 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmLZ-0006MH-Jx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721628993; x=1753164993;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YjIKLk5TxvgBKbYaam8QRg8+S6or4fpjAzbFoYWyvBE=;
 b=l54AhrKLn1v2IP7BnNdcOUiMHg4cTEjleJUzkpefJphBeWVeF7JkST2U
 v7+cDo/wtc2n1G1VRSc6H1yQkyeFLUzwZq7QDK9rCvX/zpgXoV69YtZPW
 MkS9IeznV72n4AnJHDHUvc0lRxUQsdnW2On30Yylgy9V8/nSCKYc5ZLtS
 6UomqWC6qHhOEs4A3QLxiN14AHTCDQHjTMf/DtTY54ayQ0A83PuOC1QPy
 tmZjfQJ5tO1UsJ/V1Nm/LcVwtQ9ew5BHgYJAA/IsWRJPhSVBaa9n0OQH9
 WbUBFXoUyvlxxk3SWPJX1NS55TPRUePvZ4FBWLtSgiAA+sFrMxWdH4Q2L A==;
X-CSE-ConnectionGUID: OtMVJstuQcG6+ZiVE1phng==
X-CSE-MsgGUID: oUqmPA/lR6uV0k6RA8Jljw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19052791"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19052791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 23:16:31 -0700
X-CSE-ConnectionGUID: cx81Ptq4S4OWyfg5jn5qcA==
X-CSE-MsgGUID: /XgC5nrdSHi+mCUtmjBHHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="89227273"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 23:16:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:16:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:16:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFL5Dz3Qj2ISWY4cuKH689s07Nc1zTk4qEh/8Q9dMehtTHU6M8OSsJYWTeLgFCceyJMsN0Don+bdNA4aiiWia+mqpLpqNetUiS6ca1PlYecnq07IB76sexyCjTBH2TyixXvNzEq4SRnkKlmuXjWiValc1Gxd59eQKSgCp0AdtvXmHHzVAb+K29jHp1B/k1ajwa2Z39NWPPsoe2h4qQQvE8BERmt4bZlPKuAoY2kxMG5+fj65o+4QVJuzyoDf2D4yykQziejc1XMLZkLyaeYPUHR2uD5sk5IPLgSkvHI6EsqYe1NyrprtbwpTlu4+ifjPK4AMgZu7wk1ROmx/+udrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjIKLk5TxvgBKbYaam8QRg8+S6or4fpjAzbFoYWyvBE=;
 b=shxMOGd3Wh02arPm42UBJy9gRmWRe0Ssru9WoMmf5QdcgVAHZLVxvfr7QZCHIANYyoVuo4Bmdz3G7uKtLdldrViullRZ7g6zAZdFBnLrMrN5uGhl/QGblfcQpdCSEhT8RRl8MNJ2i03kPMm5X9t6eZwMF41vjtS8H30/hwYKzIQXwY8PO3rlomhuIj1mCuBuuoo5sEWuWFttHjfILy8OpXNObuilueYAYdhsOE8w+6AwaB71/hQs6pIpX/VnmEZ4BN35/2/0c8C0adcP+5VzPAottcfZGqgWCDJqtW8sQMFEN90RldGEKn/w0WRxipE+9sD7fVohdhbJBly4PAxm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 06:16:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 06:16:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v5 11/13] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Thread-Topic: [PATCH v5 11/13] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Thread-Index: AQHa2dQJ/9HR6bOOR0Guv6re03eYKbICSZ1Q
Date: Mon, 22 Jul 2024 06:16:27 +0000
Message-ID: <SJ0PR11MB6744650052C4FFB13BEF7D5992A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-12-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-12-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6796:EE_
x-ms-office365-filtering-correlation-id: b869184b-1902-45f5-941f-08dcaa15d21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUJIUSs4aGRabG44b0k2eTdrNUJOSEpKVjE2UmJuUTNlbk1LcTZMemNiYVhp?=
 =?utf-8?B?cGF6clIyOS9ZT3RjSUQrZFNYbGRzZmR5Q1lTQzFKcXd5akwrS0IwYUh6ZjZx?=
 =?utf-8?B?TkRCa1orVHZnVWdOWDdDaWsvbFV1WGFjT1QxSi9wNkxVRlZXYVZUa0R1ZFdV?=
 =?utf-8?B?alNBOFhTc3U1S3piNUV2Tk5Gc1cvVDFQMS9tY1g2dE1xMHFuelZrVnppaElU?=
 =?utf-8?B?bEtzSUpBSGs1TFJEMHRuTFA1S2NVOHIyRUM5dE4yVVZCa1ByQ09YcDVMM1JV?=
 =?utf-8?B?eWRkbEZVaHBFOU5BRGFPeHlSTE91M3FnQTZ3TjZnK1FweUhxa0w0WFpha1Y1?=
 =?utf-8?B?OUZKS0lWeVE2Q1d2Q1l2eWFKU3VZRE1XV2s1OWFRQXdaL3JlR2xDR2tRWDNT?=
 =?utf-8?B?aXRRS1o1aGRwSktTcUxmdDA0YlhJWDZNQ3FKNGwvenVGUmZxNzZsaThIMnlq?=
 =?utf-8?B?YnZDY1h5ZVYzeXZ4emRvZ0lEZUZua0JzeElTVXZoTHZXQU5wK0JZSnptZzcr?=
 =?utf-8?B?T3Iyd3d6dDl6OXBmMFd0WkpSU3dsZ210SDFzeC9Qcmw5Z3c4OXNqclJxTTZx?=
 =?utf-8?B?a1lqaUhSdU1EOXVVOEVYQWJCYVFmNDh5MWtkdTVtOEtVYTZyZklxZWFJL01i?=
 =?utf-8?B?enE4dTVwcm52UytSZzNMTGRNUVZiY3pEVUNiTWlXSEZtNmpSR1BhSUhZNmJt?=
 =?utf-8?B?VlFqdjVLS05sdXhETU5wejhqVVpHT2tJdVVkampqSWR2VUpDN1FYOXgzY0ZU?=
 =?utf-8?B?b29sYjBKSUU4MUdnd0YrOXUvbFhXSHJUMmJXRnoyVkZwN3RPSXM1T1NnV3p0?=
 =?utf-8?B?blowTlpDdUxZb2hZa2NmaFg2MUh0QzdmT0FDTm9BZzh3ekRFVXp2YmlsOFc4?=
 =?utf-8?B?RFFKQ0NobHRiSVhmV1ZESXpmOFpvbWZEa2F5QnloSWE5S0JWelROT25wS09I?=
 =?utf-8?B?aTNnNGVvelIxYmNqUjU5TWZIMzcydDUzRlJ2R0xmR21rcldFRUdZVFNwUHBY?=
 =?utf-8?B?bkxhSk9ReVRIb0dWWjZ2c0xvTkhwQTBJQjlEQ050Zmx6T2hlbmh0eDNZTWdI?=
 =?utf-8?B?WUd6UXlrVTQ1N3NxUTBNSjlUMWlJekhzWW5SckhjNUVZNE52MlVFZFFsVDRN?=
 =?utf-8?B?c2w0NUJCVDRyVEF1emIwUUdiM3VhOFo2UElUbFY0a3JHSVZOdENleWV0Vi9k?=
 =?utf-8?B?THdqSW91ejdWU1NISlMxQnEyTUVKbUlsL3BzMURzb1NXMDNmZG9YK2JUQXNF?=
 =?utf-8?B?am4wMDVRSHdDc1Y3WW43ZEdpWEVFMGxkMWFlWkNxc3pVQVVBK21JQmU4NUFI?=
 =?utf-8?B?MXdXYkNXajJEQUxtcGlnU3JxQjJtNXpNZ2lQNnovWW9qYWtyUDdUSUpGWHdQ?=
 =?utf-8?B?QlNFUnRDUE0yR09mMFB2anR6dDBBVXZENWE5VVN5Wk1xd2ZrUUs1RHNqQjFK?=
 =?utf-8?B?NkZPTVhKYXpmcWxrWGFPSkg3M29FWHdWNkFVMXVnT1psb01ldWZiemIvYW10?=
 =?utf-8?B?cVZOQThRVWZUTkNPMGVvOFYzdFpjY2JtSXlaYUxoYWh0VUFkNjNQUWs3NHlB?=
 =?utf-8?B?QWhTKzFRYlU0QkNMWE5ZbVExd3dwUUxXSDVkMXF3dE5aVEViYmtudExiOENM?=
 =?utf-8?B?TXhvbGtEYTRTM1E5Y0pSRHM4UVVQdE9qZjQrQmdBM1NVL1ZTYjUwQk01VjV0?=
 =?utf-8?B?WVNkTFRoNXlKZ2ZBM3lvbXBOVUI5UWdzTnYrV01EcjhiNTJNZUpLaVNwK2k4?=
 =?utf-8?B?T1owMTR0bFhBWVp6d3VycjVaaXZWU0swMmJPWFZhMXM4MUQ0bk9yaFVZSWp0?=
 =?utf-8?B?N1paME1SMzNXbHZIQ2pMQkkrVCtpb2M4WVJTb3VnNm9WKy9vVjUvTVU0SHk4?=
 =?utf-8?B?KzhVRGgyNVdMeDZ5Um5ZTWprVXZleDBvMFR1enlYbTgzYUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDE0WmJCRFI2YXRwTXlEMkcrdG82WXNjejJtalVONFVNdnhyZFZPeGhLN1VD?=
 =?utf-8?B?SEFPYkxaWVhObkwvNzFJK1RuaXFHZlR4bDFSaHVyVk14L2F2Z3RaSzJwSlhB?=
 =?utf-8?B?NGFpemhRUVhVU3dCelJyVytndmROOFBMZng0bHJqTmJIYzBySk9tMEZ4RmRx?=
 =?utf-8?B?R3FHN3hLTFF6KzQ4R01XRnNQK0o5SmdrL2h2NHIxaWx3YWRNdXhVdTNUWWFX?=
 =?utf-8?B?bzZ4NlVoMlY4QzZicmFCSjFGdm83RElCWWNTSlE1YnRpNlA0Q1EwM2k0SDdR?=
 =?utf-8?B?alFmWGJScWR2Ny9hZ2toZlVORTlPeSt3MmY2Y1RSTWxOMzVMaXNlL0JtUzNq?=
 =?utf-8?B?RkRHTE9qV25EQ0EwdmVFdEV6aHZZMFZDOWE0Wld5ZlFCQ0JFb29KUnNYaHFr?=
 =?utf-8?B?R1Q2Mk5rM29jRTNCejh5MHFseFd4dmYvQk5QSERZcmlWVGxXbDRDWlZuZGNu?=
 =?utf-8?B?VFNBd3F0cXVZNGU2SGZiK1p1Z1A2bTNEb3U3VlVGSmcwYVlEZnlZQzE3UWxa?=
 =?utf-8?B?ZVVUbWtmSG5VMDd2cnNZWTBaeHFYZ1lJQ3R4Y1RGSk5EaC9Tdm5VQjlzcTVm?=
 =?utf-8?B?YzE0c1d2bVZKSWZkVElTQ3RXVE9XdkFEYjFyd1d2VW4ydWJSSjZMcCtBYVkx?=
 =?utf-8?B?VFk3dzVEM3YzVDllWHFEVTltandpVFpQaWgwTm1iSEhjRVBSVUx4TGMrczla?=
 =?utf-8?B?ZE5RWDFxTzFVcnV1Rzh4UTZxQ0ppVkNod0dpbDh1LzROMHR4VGtvRlR3K3Ex?=
 =?utf-8?B?WEkxNDM5S1R6NUk0Mjl1clpST1B5QzZiUEh4a2IvRFZZOFhBQmRYdTBuclhq?=
 =?utf-8?B?dXZXaTlNc3FjVkFaZElWQmR3eXNodGtsNXdlcXZiamtvNGFpZm13SWJ2Tjd4?=
 =?utf-8?B?KzFZa3UvWFd6Y0EvVy9hN1hhcFhvT09LeExCYWNtVkFUTTdpcVl6aG1OZVBt?=
 =?utf-8?B?clRNZzZwOXNMZ0J3TndpeVNFcWNrc1lab2tPeFJEUGNaTHMrVWI0K3d2VDJw?=
 =?utf-8?B?QXNNYW03T0M4VG44WUR1ckwya0NDekhyR2dla1dlR0VWK2lsL3h1SXo3d3ox?=
 =?utf-8?B?ZE03MGZFUUxHaDZacmRvNmxNSjdNRm1iZXh2ZkhoZm5mM2YvMnJQWXErUWs2?=
 =?utf-8?B?TVNTUjBjVnpvcSsvcVdsSS9QUS9BYTd2MVhWWVIrbzFQSU5ZNTdoSFBsbjNG?=
 =?utf-8?B?b1lQY3dwUldFYjd5aHNtQk5vRG51Nm9RZ1YyMDFqcitLOVN3N3JIcEsxb0lk?=
 =?utf-8?B?clp4cHpDY0ZGenB3WTlIZ3h3alN3dzNFbDU1aVdlNUZqK1AralJ0SElqbStm?=
 =?utf-8?B?QVhSaVRKYm5wekZwRjkxRU5rOVltbEx1RzZzdWtydnBESzJzcVV4L25SWFEy?=
 =?utf-8?B?K0hyVGZpcVlDMk4xVVIvUFFhT0xuK0orUHQ2di9yRnhRMVJHY2hHdFRqM254?=
 =?utf-8?B?VHlMTWxvMG0vZzh2Vm9SL01rS3RKdGxlZW0zdWRveWFESmVjSXpQcEl4amFx?=
 =?utf-8?B?Wms3VEFFSUNySE12MGxaZk1XTkF4QldlQkM2NmdNR3cvVThwMkdmQi9vM3Va?=
 =?utf-8?B?cFl4NVdoZnBEVmdLdG1YUjUxNmRNNFlHa2lwallmV2JzMFBuZ2NkSDFaVUdn?=
 =?utf-8?B?QWRIRW9LS2RQQ2YwUGRrbkxvTmFhZndJWGtObHg5QW9BTHZkQ1JVb1E4aVFM?=
 =?utf-8?B?T3ZnUFVWeXl3N29CdDFEREFFR0ZqWm5HSFZ3RUhXV21udFlvKzg0UDdiUjZD?=
 =?utf-8?B?eEZRMGtINHVrZE9kM0VjeW9aUjRvWTh6M29HMzJWNzhNTS8rMkRpQ0NYZ0Fu?=
 =?utf-8?B?NEFxbUZpR0MwNTc5N0tsVEdCTXRxbWxlV3U2WlJ5dU1veWMvRTg1dWlZV242?=
 =?utf-8?B?RkFqOUJOZFdnY05RMTFJQ21WbzF6b2J0OHR2VmczaDQ1bmJyWmxiQ0lZRXJB?=
 =?utf-8?B?Z0JvNUd1UjhoWUdMaVl0S3NkM0JXVEZwVlFURElwakgzSVlUZ1lWRG5sYUl1?=
 =?utf-8?B?NkNadlVtQ0dEL2FqQ2tIOFRybzFKYXF6Yi9sakNEY1VkaWk2cnMyVDlsT2xW?=
 =?utf-8?B?TVMrdThYR0M0K3ZLSURUMkxkdVhYdE1DVFk1K0JwZEY2S0Q5Nm9sSStON2k0?=
 =?utf-8?Q?bexCsj2URsu5WcZh+nW0JxzUt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b869184b-1902-45f5-941f-08dcaa15d21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:16:27.5448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dgi3SE/Pwa5iTi8hloH11z6TzOZjPTxdKB/dvYtAuST67MmSgVobDzVuonNE0w8Hp9P4mCEaupwQtSVLouO5ffoSH4JB7uOsx6QzyrI1yY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjUgMTEvMTNdIHZmaW8v
aW9tbXVmZDogSW1wbGVtZW50DQo+VkZJT0lPTU1VQ2xhc3M6OnF1ZXJ5X2RpcnR5X2JpdG1hcCBz
dXBwb3J0DQo+DQo+aW9jdGwoaW9tbXVmZCwgSU9NTVVfSFdQVF9HRVRfRElSVFlfQklUTUFQLCBh
cmcpIGlzIHRoZSBVQVBJDQo+dGhhdCBmZXRjaGVzIHRoZSBiaXRtYXAgdGhhdCB0ZWxscyB3aGF0
IHdhcyBkaXJ0eSBpbiBhbiBJT1ZBDQo+cmFuZ2UuDQo+DQo+QSBzaW5nbGUgYml0bWFwIGlzIGFs
bG9jYXRlZCBhbmQgdXNlZCBhY3Jvc3MgYWxsIHRoZSBod3B0cw0KPnNoYXJpbmcgYW4gSU9BUyB3
aGljaCBpcyB0aGVuIHVzZWQgaW4gbG9nX3N5bmMoKSB0byBzZXQgUWVtdQ0KPmdsb2JhbCBiaXRt
YXBzLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3Jh
Y2xlLmNvbT4NCj5SZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY28+
DQo+UmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KUmV2
aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRo
YW5rcw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIHwgIDQg
KysrKw0KPiBiYWNrZW5kcy9pb21tdWZkLmMgICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgfCAyOCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+IGJhY2tlbmRzL3RyYWNlLWV2ZW50cyAgICB8ICAxICsNCj4gNCBm
aWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUv
c3lzZW11L2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0KPmluZGV4IDZmYjQx
MmY2MTE0NC4uNGM0ODg2Yzc3ODdiIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvc3lzZW11L2lvbW11
ZmQuaA0KPisrKyBiL2luY2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0KPkBAIC01Nyw2ICs1NywxMCBA
QCBib29sDQo+aW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoSU9NTVVGREJhY2tlbmQgKmJlLCB1
aW50MzJfdCBkZXZfaWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKTsNCj4gYm9vbCBpb21tdWZkX2JhY2tlbmRfc2V0X2RpcnR5X3RyYWNraW5nKElPTU1V
RkRCYWNrZW5kICpiZSwNCj51aW50MzJfdCBod3B0X2lkLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBzdGFydCwgRXJyb3IgKiplcnJwKTsNCj4rYm9vbCBp
b21tdWZkX2JhY2tlbmRfZ2V0X2RpcnR5X2JpdG1hcChJT01NVUZEQmFja2VuZCAqYmUsDQo+dWlu
dDMyX3QgaHdwdF9pZCwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+KyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3QgcGFnZV9zaXplLCB1aW50NjRfdCAqZGF0YSwNCj4rICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPg0KPiAj
ZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRA0KPlRZUEVfSE9TVF9JT01NVV9E
RVZJQ0UgIi1pb21tdWZkIg0KPiAjZW5kaWYNCj5kaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVm
ZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+aW5kZXggMWFlNDc1MWExYjJjLi5iZDRmZDQ5ZDI1
MzYgMTAwNjQ0DQo+LS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+KysrIGIvYmFja2VuZHMvaW9t
bXVmZC5jDQo+QEAgLTI2Miw2ICsyNjIsMzUgQEAgYm9vbA0KPmlvbW11ZmRfYmFja2VuZF9zZXRf
ZGlydHlfdHJhY2tpbmcoSU9NTVVGREJhY2tlbmQgKmJlLA0KPiAgICAgcmV0dXJuIHRydWU7DQo+
IH0NCj4NCj4rYm9vbCBpb21tdWZkX2JhY2tlbmRfZ2V0X2RpcnR5X2JpdG1hcChJT01NVUZEQmFj
a2VuZCAqYmUsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgaHdwdF9pZCwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDY0X3QgcGFnZV9zaXplLCB1aW50NjRfdCAqZGF0YSwNCj4rICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+K3sNCj4rICAg
IGludCByZXQ7DQo+KyAgICBzdHJ1Y3QgaW9tbXVfaHdwdF9nZXRfZGlydHlfYml0bWFwIGdldF9k
aXJ0eV9iaXRtYXAgPSB7DQo+KyAgICAgICAgLnNpemUgPSBzaXplb2YoZ2V0X2RpcnR5X2JpdG1h
cCksDQo+KyAgICAgICAgLmh3cHRfaWQgPSBod3B0X2lkLA0KPisgICAgICAgIC5pb3ZhID0gaW92
YSwNCj4rICAgICAgICAubGVuZ3RoID0gc2l6ZSwNCj4rICAgICAgICAucGFnZV9zaXplID0gcGFn
ZV9zaXplLA0KPisgICAgICAgIC5kYXRhID0gKHVpbnRwdHJfdClkYXRhLA0KPisgICAgfTsNCj4r
DQo+KyAgICByZXQgPSBpb2N0bChiZS0+ZmQsIElPTU1VX0hXUFRfR0VUX0RJUlRZX0JJVE1BUCwN
Cj4mZ2V0X2RpcnR5X2JpdG1hcCk7DQo+KyAgICB0cmFjZV9pb21tdWZkX2JhY2tlbmRfZ2V0X2Rp
cnR5X2JpdG1hcChiZS0+ZmQsIGh3cHRfaWQsIGlvdmEsIHNpemUsDQo+KyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlX3NpemUsIHJldCA/IGVycm5vIDogMCk7
DQo+KyAgICBpZiAocmV0KSB7DQo+KyAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJu
bywNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICJJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRN
QVAgKGlvdmE6DQo+MHglIkhXQUREUl9QUkl4DQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAi
IHNpemU6IDB4IlJBTV9BRERSX0ZNVCIpIGZhaWxlZCIsIGlvdmEsIHNpemUpOw0KPisgICAgICAg
IHJldHVybiBmYWxzZTsNCj4rICAgIH0NCj4rDQo+KyAgICByZXR1cm4gdHJ1ZTsNCj4rfQ0KPisN
Cj4gYm9vbCBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKElPTU1VRkRCYWNrZW5kICpi
ZSwgdWludDMyX3QNCj5kZXZpZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90ICp0eXBlLCB2b2lkICpkYXRhLCB1aW50MzJfdCBsZW4sDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqY2FwcywgRXJyb3IgKiplcnJw
KQ0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+
aW5kZXggNzEzN2ZhYWY0NTQwLi43ZGQ1ZDQzY2UwNmEgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9p
b21tdWZkLmMNCj4rKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPkBAIC0yNSw2ICsyNSw3IEBADQo+
ICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiAjaW5jbHVkZSAicWVtdS9jaGFyZGV2X29wZW4u
aCINCj4gI2luY2x1ZGUgInBjaS5oIg0KPisjaW5jbHVkZSAiZXhlYy9yYW1fYWRkci5oIg0KPg0K
PiBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9tYXAoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJj
b250YWluZXIsDQo+aHdhZGRyIGlvdmEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
YW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0KPkBAIC0xNDYsNiAr
MTQ3LDMyIEBAIGVycjoNCj4gICAgIHJldHVybiAtRUlOVkFMOw0KPiB9DQo+DQo+K3N0YXRpYyBp
bnQgaW9tbXVmZF9xdWVyeV9kaXJ0eV9iaXRtYXAoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UNCj4q
YmNvbnRhaW5lciwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklP
Qml0bWFwICp2Ym1hcCwgaHdhZGRyIGlvdmEsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaHdhZGRyIHNpemUsIEVycm9yICoqZXJycCkNCj4rew0KPisgICAgVkZJT0lP
TU1VRkRDb250YWluZXIgKmNvbnRhaW5lciA9IGNvbnRhaW5lcl9vZihiY29udGFpbmVyLA0KPisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklPSU9N
TVVGRENvbnRhaW5lciwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYmNvbnRhaW5lcik7DQo+KyAgICB1bnNpZ25lZCBsb25nIHBhZ2Vfc2l6ZSA9
IHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpOw0KPisgICAgVkZJT0lPQVNId3B0ICpod3B0Ow0K
PisNCj4rICAgIFFMSVNUX0ZPUkVBQ0goaHdwdCwgJmNvbnRhaW5lci0+aHdwdF9saXN0LCBuZXh0
KSB7DQo+KyAgICAgICAgaWYgKCFpb21tdWZkX2h3cHRfZGlydHlfdHJhY2tpbmcoaHdwdCkpIHsN
Cj4rICAgICAgICAgICAgY29udGludWU7DQo+KyAgICAgICAgfQ0KPisNCj4rICAgICAgICBpZiAo
IWlvbW11ZmRfYmFja2VuZF9nZXRfZGlydHlfYml0bWFwKGNvbnRhaW5lci0+YmUsIGh3cHQtDQo+
Pmh3cHRfaWQsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpb3ZhLCBzaXplLCBwYWdlX3NpemUsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAodWludDY0X3QgKil2Ym1hcC0+Yml0bWFwLA0KPisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCkpIHsNCj4rICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+KyAgICAgICAgfQ0KPisgICAgfQ0KPisNCj4rICAgIHJldHVy
biAwOw0KPit9DQo+Kw0KPiBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9nZXRmZChjb25zdCBjaGFy
ICpzeXNmc19wYXRoLCBFcnJvciAqKmVycnApDQo+IHsNCj4gICAgIEVSUlBfR1VBUkQoKTsNCj5A
QCAtNzU2LDYgKzc4Myw3IEBAIHN0YXRpYyB2b2lkDQo+dmZpb19pb21tdV9pb21tdWZkX2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiAgICAgdmlvYy0+ZGV0YWNo
X2RldmljZSA9IGlvbW11ZmRfY2Rldl9kZXRhY2g7DQo+ICAgICB2aW9jLT5wY2lfaG90X3Jlc2V0
ID0gaW9tbXVmZF9jZGV2X3BjaV9ob3RfcmVzZXQ7DQo+ICAgICB2aW9jLT5zZXRfZGlydHlfcGFn
ZV90cmFja2luZyA9IGlvbW11ZmRfc2V0X2RpcnR5X3BhZ2VfdHJhY2tpbmc7DQo+KyAgICB2aW9j
LT5xdWVyeV9kaXJ0eV9iaXRtYXAgPSBpb21tdWZkX3F1ZXJ5X2RpcnR5X2JpdG1hcDsNCj4gfTsN
Cj4NCj4gc3RhdGljIGJvb2wgaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZp
Y2UgKmhpb2QsIHZvaWQNCj4qb3BhcXVlLA0KPmRpZmYgLS1naXQgYS9iYWNrZW5kcy90cmFjZS1l
dmVudHMgYi9iYWNrZW5kcy90cmFjZS1ldmVudHMNCj5pbmRleCAyOGFjYTNiODU5ZDQuLjQwODEx
YTMxNjIxNSAxMDA2NDQNCj4tLS0gYS9iYWNrZW5kcy90cmFjZS1ldmVudHMNCj4rKysgYi9iYWNr
ZW5kcy90cmFjZS1ldmVudHMNCj5AQCAtMTcsMyArMTcsNCBAQCBpb21tdWZkX2JhY2tlbmRfYWxs
b2NfaW9hcyhpbnQgaW9tbXVmZCwgdWludDMyX3QNCj5pb2FzKSAiIGlvbW11ZmQ9JWQgaW9hcz0l
ZCINCj4gaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoaW50IGlvbW11ZmQsIHVpbnQzMl90IGRl
dl9pZCwgdWludDMyX3QNCj5wdF9pZCwgdWludDMyX3QgZmxhZ3MsIHVpbnQzMl90IGh3cHRfdHlw
ZSwgdWludDMyX3QgbGVuLCB1aW50NjRfdCBkYXRhX3B0ciwNCj51aW50MzJfdCBvdXRfaHdwdF9p
ZCwgaW50IHJldCkgIiBpb21tdWZkPSVkIGRldl9pZD0ldSBwdF9pZD0ldQ0KPmZsYWdzPTB4JXgg
aHdwdF90eXBlPSV1IGxlbj0ldSBkYXRhX3B0cj0weCUiUFJJeDY0IiBvdXRfaHdwdD0ldQ0KPigl
ZCkiDQo+IGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGludCBpb21tdWZkLCB1aW50MzJfdCBpZCwg
aW50IHJldCkgIiBpb21tdWZkPSVkDQo+aWQ9JWQgKCVkKSINCj4gaW9tbXVmZF9iYWNrZW5kX3Nl
dF9kaXJ0eShpbnQgaW9tbXVmZCwgdWludDMyX3QgaHdwdF9pZCwgYm9vbCBzdGFydCwgaW50DQo+
cmV0KSAiIGlvbW11ZmQ9JWQgaHdwdD0ldSBlbmFibGU9JWQgKCVkKSINCj4raW9tbXVmZF9iYWNr
ZW5kX2dldF9kaXJ0eV9iaXRtYXAoaW50IGlvbW11ZmQsIHVpbnQzMl90IGh3cHRfaWQsDQo+dWlu
dDY0X3QgaW92YSwgdWludDY0X3Qgc2l6ZSwgdWludDY0X3QgcGFnZV9zaXplLCBpbnQgcmV0KSAi
IGlvbW11ZmQ9JWQNCj5od3B0PSV1IGlvdmE9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0IiBw
YWdlX3NpemU9MHglIlBSSXg2NCINCj4oJWQpIg0KPi0tDQo+Mi4xNy4yDQoNCg==

