Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606FFC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJ42-0005ua-6H; Tue, 20 May 2025 05:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ40-0005t3-80
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:15:08 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ3x-0000ym-Q4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747732506; x=1779268506;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LLQAjUo1ABym+dKemlCmm/zKniv0tbz5dg0jl52gT7Q=;
 b=ahKZHXdZyl8wIDZ4QBcdLl91/HB9Cfna6B0mM/zN0vD1M5wfTaU52pGW
 6KDupzmlWuSU4ZHrPBGLe36WhS64xsXVc0NPAdMMwKp4dg62Pdae+UW84
 NUpNNUMO29YtPsWgYkZ36tHCz1kMaLx01+C6/poaKo9bo2eLzDAw9ix9E
 PcVXVeVHWTvhXIG2NhOX3otkPk7gXyAvEqTMp76713FW4zyI6xVGVbKla
 pS5/LMmDRCIRR+ZN7xHgdggIzC6jcc8MYBnIK9FcShunzsx8lnLmhfSEm
 fJmYBRzvG7DMsH3oohwgEn24G1orYRibX89U9xNss6VBVZjKGxipfMUeJ Q==;
X-CSE-ConnectionGUID: Ca/yLIkJSMa1Bo3DEvX2Kg==
X-CSE-MsgGUID: nfNIf0whRL+kN3BQvz9rmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49584948"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49584948"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:15:03 -0700
X-CSE-ConnectionGUID: VmYXO3goSbeZ1yGmmSnKcQ==
X-CSE-MsgGUID: Hcm07lqQR9uEJTjKxIFPFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="139667789"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:15:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 02:15:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 02:15:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 02:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szh3DbdcQIo5oCIa6HAQ2AjhnjNgoFRt6UN3BzT4E/L+XH2CuGWsjNjeOdTcj6yyVNI3V88SHpyPpB3xov0v5JsEwCHr4c/xUcP9KYPt6bWfoQxiUO3qcl1LktLmFtet7oy4MMNFbDDsmB+4349sXxV9zFuMu2VDbE0guNBi8sm7hiRpfn9UPW/jiwSZmtmEvd1MEF7Wq7nAvgsl2IKiUL0vhRgb07MlLY1I4mrte7PFweq6QmJH3GDqeHTQ2JclKIHi0ny/rtXioorrouygRiL+QxKAt8zmicSp4p2fXQIekZ/4AOOoawV3avwPW/XuFm4IFBfAYn+evaEcIZzvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLQAjUo1ABym+dKemlCmm/zKniv0tbz5dg0jl52gT7Q=;
 b=qT+rAS5wQp6WWalEBcL39qy0LJPN5i0dWC5dYbAwnFetpqabteKSgFEOAifKLm63qV3NiaAJSfnstimzAkIQzn5Sj9zEwnurvVpFr4r6u/6RQKJXofscMyotvm5PxuOwop6h8dNVSFjejHds5LWfOtoWI65uS+ruFAr/w+ZwbPrmQJx7mzP5SwqsRr0qxusHPBiUlYrcEqXcexQrCm3icGtziVxmA+fQ6y/QjqZHVVqH3Y+TLs4inP4pWtgylrMH9Tp+YTVrzafatoaR0npsxwnuH34nqC+nxb+Z/U9MaZa6TleYFwHwfUgAPOGAi51AxJI4pS8lVas8FBj75TZDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:15:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:15:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 37/42] vfio/iommufd: reconstruct device
Thread-Topic: [PATCH V3 37/42] vfio/iommufd: reconstruct device
Thread-Index: AQHbw1Nd6KUUjFss8EmA3FcR+/yVvbPVEYkggAUUEYCAALXG8A==
Date: Tue, 20 May 2025 09:14:59 +0000
Message-ID: <SJ0PR11MB6744ABA4A81529721137C05B929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744AF09E9C87B1D9C919E7E9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ed11b186-1445-4f1a-8f60-fd446d9e15d3@oracle.com>
In-Reply-To: <ed11b186-1445-4f1a-8f60-fd446d9e15d3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6034:EE_
x-ms-office365-filtering-correlation-id: b1db3dad-1a25-42f1-cdb7-08dd977ecbf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2ZBVnNFeWRXaHh2eEIzbCtDeWpGamZuenJLYXNlUFBQWFZiMDFJVld0d2M0?=
 =?utf-8?B?L3RDWGhOb3BBODFvYmdxWVI3MXF1d3Q2dGJXYWFMZlFYbHdGMHluTTdhYkRU?=
 =?utf-8?B?V1d0ekp4TlFqc3drSFlGcm44Q09lbkR3Z0d4YU9PZlRlWEQxR1dkbStLSm8r?=
 =?utf-8?B?SmJ4NmZOamxmN2pRK2oyYnQ3Zy9wUDdYdUg5c1l6dy9HT2xYSGI0V3g4eXho?=
 =?utf-8?B?VlU5K0QrN3pnVkRYZXVrN2YzN2lzV0RySG9hd0U1RkE5TmYvdXNHcnBRMWNI?=
 =?utf-8?B?ZTZKRTBCQ0dJZ2thcjF2SVo1VFl0MW9JYXhicjcxcEJhUm9sUzBKcENPTTlU?=
 =?utf-8?B?YUhQY3RJcE1EbjBHMEtLWFZwSjM2ZFRnbVpFMVdnRko3QUdxckpRU2xDY1JQ?=
 =?utf-8?B?TmtKU1IrQXBrY0xIK211OFZETkcrNW0rY3c3VWsyTldUdHRkdFRjZkhES0w4?=
 =?utf-8?B?b05hMFRvWmxoZjIvcEU3UW1jb25jaWZSd1dWSWl5eCttcUkwdnRoNzM2bVUx?=
 =?utf-8?B?a2d0MzR4c2w1ZDhsQlRtNDBzK2RLeStBeXNpK0VJSU10cDBNaUdBRVRVM2xW?=
 =?utf-8?B?UVorOVczN28xdDRBSW9RdmRjYUhsdEdTVzVQWGZJOC84QXFxZ0I1SEFVQWFy?=
 =?utf-8?B?NE00NTB2ZzRvcm1BMGJuZGFRbmxkWjAyR0F5NUQzR0pXSHoxR0hyT21nZFBE?=
 =?utf-8?B?dFBWVVNFNklTT25wZVU2U2pFU2M1TXYwQ2poUFhxZk4vTElzZlNHblBnaDQx?=
 =?utf-8?B?N2l1ek10TnVMb2JCSG40TG05bzhxVGdsVlZmTloyMVkwR0VqbGdTYVJYdHNt?=
 =?utf-8?B?YXkxQmErUTQxUVdDVlM0R0pFRkRxVmVBMEpNUkdkZ3c5bGVsbmNJamJ4YlR5?=
 =?utf-8?B?SERxcXZ6YmtxTE1PeGpwU3hob24xbWREeGRxQzMzWEJ0TWE5MkhINHMzK210?=
 =?utf-8?B?K2NEa1JnWVRFYUdTUm1jY1NYZ0poQ3BHVjNvWXNFTWVJcXRKTGdtSWtrdm1o?=
 =?utf-8?B?eGo5NlBxS3IvZEM2dXFkODhtV2lXOG9YYmhzUnRWaGJqNUFPcUxuenUwVjNL?=
 =?utf-8?B?Q2Ezd0ZaaEJMUzlmRVlXUGZOS0xoUkdQRG91Q1Fpblhub1NCRWM1WmQ2MFVO?=
 =?utf-8?B?ZjBzVmlCVkl5OXYyY3psZURaTXlvYXB2YlFCa2h5dldhU2QyRi85c1FYTDJB?=
 =?utf-8?B?TmVrL2dZZzFVZXA2emFsSTFITkp4WmxCZUJWcEFLSldTdHA3cWV4ZTZzcWZ6?=
 =?utf-8?B?YUtEU0ZYckYyZkp3emxSSTFITGo3MEhDS3NXb1ZMTzFwQ01CR1VMZXYyaUJm?=
 =?utf-8?B?N2RwNm5ERzBWNng3WDdyWFhYeE5GSXRSR0d6VEJYR2UvVFhVcVpOTTJXWldL?=
 =?utf-8?B?cUg2UXFIN1N2aURyMUFFYm5Dem4wRmE1Rkxxdlo2cmlZQkFYVThNdUxPNlFX?=
 =?utf-8?B?NmR5ZWZvODFCYXExYjZkVWNET21ReFdqUDZJVVRpeDZ1LzFFcUFNSDZWMGg4?=
 =?utf-8?B?TDNTbXM3NTZxZ0JQSE01MXp1cncrUEJzZnJqRVpWejR4VWtGNWM4L2ErdC94?=
 =?utf-8?B?OGd1U1BOa2hlVlF2RERxQU5TWW9KV1RTbnNNNVdYd3l3bXQ1YWdZOTBvTzV5?=
 =?utf-8?B?SmhtMWdqcDU0cklmTW8zU0FsdnJqc1d6UmdpdERUOWwvZ2V1SmlBcVVSZUpV?=
 =?utf-8?B?VzJ0YzRjNzgvekZ3WXlsQmVNZnpHeHB6cVJZalNESm43dVY3ZGViMFhQV0Qv?=
 =?utf-8?B?Qm1TbG05VTk5SVdQb28rQm0xajZ4bk9PRlZkSWZrVWRLbHN2ditGRjQvSFpt?=
 =?utf-8?B?RW1EWWI1bVl6amJJVVlHMGpPMzNnNmt2SmhjY01WSTg0ejU5WkEySDEwMi9Q?=
 =?utf-8?B?VnRKazR2MjhtdVRGTDh4NmMyclZhTTB2czBiUHNsdzZzMFFWZGh3MWJQck8w?=
 =?utf-8?B?TTdjcTlOY0diQXdwaHhiNjg4UExZcjFaZFBUZHZXSWtzM0tvZmUxM3JtNVJP?=
 =?utf-8?Q?37tFtWnPTn2CHtKqCfzwdRoOFZOSuI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTVBUmJyTWU3RDNXY21BZllXRGpuSEJLV3FDby9uYjZsaHRlZkdiY2sxdVRJ?=
 =?utf-8?B?YWVLN2dxVXkvQloyNi9sRUpIWTF4T0xwTklBcnFKa0tXQmRTSXRWbjhhMEZY?=
 =?utf-8?B?SkYzRklXdlp2QkdGU3dSTkFhTUJKb0Z6ZW0rWVlTeDRLTFArWnJrYXZNY2pw?=
 =?utf-8?B?QkNRL3V4UVdvWTEydWg0TmFITGRvZnU1c1daY0MrR0pKekgzdlNUdC9LeFlw?=
 =?utf-8?B?WWFnbVpLSVQ0YmNhVGV2R2p6U3hJWnpEUmpjZzhZUmRQVXFLdGg1V0p5bmxL?=
 =?utf-8?B?MjQxck05eUo1WTd2c2E3UXRXSG1sdGdlVGc4bFQ3TjdLbTVZU2ZnY216OEd0?=
 =?utf-8?B?clpad04rMFRNdGQ0czEwaE81dmxlTzZCWmpPdWtLdjhJQTd2KzZ0bC9NMUlZ?=
 =?utf-8?B?RUprQnc2eEh5c1VOSUpSTVBJTVAzVGt3ZmpzN2hpVFhSVjRBOGNVQmdFK090?=
 =?utf-8?B?OFgzWUljdEUxMGpYWXJKT2s2RVM4Qm1mNi9wRG9sajJZbm53MXFhSkNmRUJx?=
 =?utf-8?B?ZVIrRFJZeGNwNlI5Q0V1SkFRS1owN1ZYWERnVWJPbU84OGRtUEt3dytYU09v?=
 =?utf-8?B?NTdtd3JsNm1BekhnMGJ1dzYrdFUvRVA5K1Z1ck15V29NV2t4V2tkVzEwYUJO?=
 =?utf-8?B?ckx3eG5MNW44NUpNVVgzMjQ5ZkFTQ3FXOE0rbm1yTDNlekhYdnQ3UmRGYlUx?=
 =?utf-8?B?Rko1Y1FlU1Q4T0I0c1UxSjJRdEkrR2xibW9hTklGK2p4T0VMc0ljMThPYTBm?=
 =?utf-8?B?ckhBMlZ4SVhsUHRpVFVqeWY4ZW4wd1BMTGlJRGtjSmhSb1ZFcC9TeDZEQjJy?=
 =?utf-8?B?Q2V0eGRDRkgyU2pLVzdub29pTGVmaTN5alFPTGV0UjRMbHpSS0grdGdxb2FC?=
 =?utf-8?B?Qm5MYlRZbkVWSFJ2czI4eDJYSmhqeHYxN3Y5RExscVRzZk51bkZaWjZLUGk5?=
 =?utf-8?B?UG9qM2dTbkdReExyeXdVVkVWWHd3dEZCb2lxcDR5SGd2bEdWNVpqU0Q1MXpz?=
 =?utf-8?B?YXdrU1dJaVlFYlVQL3hKYnhOWHliek80eHhvd0tzc1FSZnlNc0FyNHhrSCt4?=
 =?utf-8?B?cjdzQXBYVTN3NCtuOGdja2hXSDF2TWhiRE5NMVRwcmhLQkFlbTRTVFRsMFV3?=
 =?utf-8?B?Z0g5cG82K2xQem1BTWY2aTMxdmZoNXMvTmIrWVE1VStOYXVBejNlQ2FJMlox?=
 =?utf-8?B?UU9QcG9PeWd2RTVVSm5VR2RTODA2N3hydnZNMGhSSmRMZkU5YTlRMkJQWW5H?=
 =?utf-8?B?WGVhTmlLVnRwZGtVTVFrVGplOE5vaG1IRCtUQUM0ZW1XM0FsejFsVXFWVzNK?=
 =?utf-8?B?K1hSb2I4eXhzZVplSGpIVExFdGlCQWhQUFRmVytvb0swSkk3dGtIT0F0Rks0?=
 =?utf-8?B?KzVHNk0rdHRVc2F4TkVBVms3dklHVnRMQ3BYdEdKdk1LbXBGelhUR2ZLVlQ4?=
 =?utf-8?B?dDExM2tRQ1h1dzhmU01LTS9lM0VmUTdwZXFGM1ozNUJqeWFJWlNXaCtyeFNZ?=
 =?utf-8?B?ck1HQS83ajVhMUY0VzNhdkNDV1BFb0VDTmhoR1lwa3R2OUdBMWRIZVhTQS9N?=
 =?utf-8?B?OFduQVJBL2NtU0pmMGprTU1UZXVSRW9oeDVNelY1aytSeENxL0lnNHRoT0VJ?=
 =?utf-8?B?K01obzFwWTdPYWd4NUxjbkoxZHJHalIvUGxiSjg5Y1ZDNUhoQTNxREhZanFS?=
 =?utf-8?B?Ukdrclo5d2tDekhCTzZhWkgrOWYvQ1dNRE1VbWhuZDRTQm0yL1Zka0FORm14?=
 =?utf-8?B?RjJCRElRWThBWFQrZmpEcjUrR0xpREJYUzMyZFYxN1JxcXVJZEtaS2NINjRr?=
 =?utf-8?B?NEdFLzRYUGFtZTZLZTBwMGdzWUpKa2VCdmg1NjZnZ04wNURhSTlGYlhFZThm?=
 =?utf-8?B?d24zeDkrZE00bjZSZTVxZFRyYk02VXBxSjhucmVxUWVhWUJQUFdOUmlzRUhp?=
 =?utf-8?B?cXNqM3Mvd1RyaWJIYllPRHY1T0VwNFV6aDEwNDNtMThmVTEyVlNIbWtxV1FZ?=
 =?utf-8?B?MyttZWJTVndhcHVwZ1FnWFVSUStxK0ppYVhEdkF6akk5cStYSVNTSU5KZFJl?=
 =?utf-8?B?L1RldkFReWEvZ3l4cVcxR3Y1Yk9vS2lZQXNvYW5Ea1ZzOEdSVElGYVp5WmFr?=
 =?utf-8?Q?dmbZn/YT1duTcmY1vSv6RCKeg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db3dad-1a25-42f1-cdb7-08dd977ecbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 09:14:59.9569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csLnlIuCipQQaGByxvcCTXCDD/UXWcPVp/X2npLWi6P35dpbvFWZtWD4qVs1TegeTQ2c+KuCIKtWWBZUPZoQTyBjimbBTk+aTu8IiAgZ6R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMzcvNDJd
IHZmaW8vaW9tbXVmZDogcmVjb25zdHJ1Y3QgZGV2aWNlDQo+DQo+T24gNS8xNi8yMDI1IDY6MjIg
QU0sIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4+IEZyb206IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+
Pj4gU3ViamVjdDogW1BBVENIIFYzIDM3LzQyXSB2ZmlvL2lvbW11ZmQ6IHJlY29uc3RydWN0IGRl
dmljZQ0KPj4+DQo+Pj4gUmVjb25zdHJ1Y3QgdXNlcmxhbmQgZGV2aWNlIHN0YXRlIGFmdGVyIENQ
Ui4gIER1cmluZyB2ZmlvX3JlYWxpemUsIHNraXANCj4+PiBhbGwgaW9jdGxzIHRoYXQgY29uZmln
dXJlIHRoZSBkZXZpY2UsIGFzIGl0IHdhcyBhbHJlYWR5IGNvbmZpZ3VyZWQgaW4gb2xkDQo+Pj4g
UUVNVS4NCj4+Pg0KPj4+IFNhdmUgdGhlIGlvYXNfaWQgaW4gdm1zdGF0ZSwgYW5kIHNraXAgaXRz
IGFsbG9jYXRpb24gaW4gdmZpb19yZWFsaXplLg0KPj4+IEJlY2F1c2Ugd2Ugc2tpcCBpb2N0bCdz
LCBpdCBpcyBub3QgbmVlZGVkIGF0IHJlYWxpemUgdGltZS4gIEhvd2V2ZXIsIHdlIGRvDQo+Pj4g
bmVlZCB0aGUgcmFuZ2UgaW5mbywgc28gZGVmZXIgdGhlIGNhbGwgdG8gaW9tbXVmZF9jZGV2X2dl
dF9pbmZvX2lvdmFfcmFuZ2UNCj4+PiB0byBhIHBvc3RfbG9hZCBoYW5kbGVyLCBhdCB3aGljaCB0
aW1lIHRoZSBpb2FzX2lkIGlzIGtub3duLg0KPj4+DQo+Pj4gVGhpcyByZWNvbnN0cnVjdGlvbiBp
cyBub3QgY29tcGxldGUuICBod3B0X2lkIGFuZCBkZXZpZCBuZWVkIHNwZWNpYWwNCj4+PiB0cmVh
dG1lbnQsIGhhbmRsZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzLg0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCj4+PiAtLS0N
Cj4+PiBody92ZmlvL2Nwci1pb21tdWZkLmMgfCAgOCArKysrKysrKw0KPj4+IGh3L3ZmaW8vaW9t
bXVmZC5jICAgICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jcHItaW9tbXVm
ZC5jIGIvaHcvdmZpby9jcHItaW9tbXVmZC5jDQo+Pj4gaW5kZXggYjc2MGJkMy4uM2Q0MzBmMCAx
MDA2NDQNCj4+PiAtLS0gYS9ody92ZmlvL2Nwci1pb21tdWZkLmMNCj4+PiArKysgYi9ody92Zmlv
L2Nwci1pb21tdWZkLmMNCj4+PiBAQCAtMzEsNiArMzEsMTMgQEAgc3RhdGljIGludCB2ZmlvX2Nv
bnRhaW5lcl9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQNCj4+PiB2ZXJzaW9uX2lkKQ0KPj4+
ICAgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNvbnRhaW5lciA9IG9wYXF1ZTsNCj4+PiAgICAg
IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyID0gJmNvbnRhaW5lci0+YmNvbnRhaW5lcjsN
Cj4+PiAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2Ow0KPj4+ICsgICAgRXJyb3IgKmVyciA9IE5V
TEw7DQo+Pj4gKyAgICB1aW50MzJfdCBpb2FzX2lkID0gY29udGFpbmVyLT5pb2FzX2lkOw0KPj4+
ICsNCj4+PiArICAgIGlmICghaW9tbXVmZF9jZGV2X2dldF9pbmZvX2lvdmFfcmFuZ2UoY29udGFp
bmVyLCBpb2FzX2lkLCAmZXJyKSkgew0KPj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9lcnIoZXJy
KTsNCj4+PiArICAgICAgICByZXR1cm4gLTE7DQo+Pj4gKyAgICB9DQo+Pj4NCj4+PiAgICAgIFFM
SVNUX0ZPUkVBQ0godmJhc2VkZXYsICZiY29udGFpbmVyLT5kZXZpY2VfbGlzdCwgY29udGFpbmVy
X25leHQpIHsNCj4+PiAgICAgICAgICB2YmFzZWRldi0+Y3ByLnJldXNlZCA9IGZhbHNlOw0KPj4+
IEBAIC00Nyw2ICs1NCw3IEBAIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdmZpb19j
b250YWluZXJfdm1zdGF0ZQ0KPj0gew0KPj4+ICAgICAgLnBvc3RfbG9hZCA9IHZmaW9fY29udGFp
bmVyX3Bvc3RfbG9hZCwNCj4+PiAgICAgIC5uZWVkZWQgPSBjcHJfbmVlZGVkX2Zvcl9yZXVzZSwN
Cj4+PiAgICAgIC5maWVsZHMgPSAoVk1TdGF0ZUZpZWxkW10pIHsNCj4+PiArICAgICAgICBWTVNU
QVRFX1VJTlQzMihpb2FzX2lkLCBWRklPSU9NTVVGRENvbnRhaW5lciksDQo+Pj4gICAgICAgICAg
Vk1TVEFURV9FTkRfT0ZfTElTVCgpDQo+Pj4gICAgICB9DQo+Pj4gfTsNCj4+PiBkaWZmIC0tZ2l0
IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IGluZGV4IDA0NmY2
MDEuLmM0OWE3ZTcgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+PiArKysg
Yi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IEBAIC0xMjIsNiArMTIyLDEwIEBAIHN0YXRpYyBib29s
DQo+Pj4gaW9tbXVmZF9jZGV2X2Nvbm5lY3RfYW5kX2JpbmQoVkZJT0RldmljZSAqdmJhc2VkZXYs
IEVycm9yICoqZXJycCkNCj4+PiAgICAgICAgICBnb3RvIGVycl9rdm1fZGV2aWNlX2FkZDsNCj4+
PiAgICAgIH0NCj4+Pg0KPj4+ICsgICAgaWYgKHZiYXNlZGV2LT5jcHIucmV1c2VkKSB7DQo+Pj4g
KyAgICAgICAgZ290byBza2lwX2JpbmQ7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICAgLyog
QmluZCBkZXZpY2UgdG8gaW9tbXVmZCAqLw0KPj4+ICAgICAgYmluZC5pb21tdWZkID0gaW9tbXVm
ZC0+ZmQ7DQo+Pj4gICAgICBpZiAoaW9jdGwodmJhc2VkZXYtPmZkLCBWRklPX0RFVklDRV9CSU5E
X0lPTU1VRkQsICZiaW5kKSkgew0KPj4+IEBAIC0xMzMsNiArMTM3LDggQEAgc3RhdGljIGJvb2wN
Cj4+PiBpb21tdWZkX2NkZXZfY29ubmVjdF9hbmRfYmluZChWRklPRGV2aWNlICp2YmFzZWRldiwg
RXJyb3IgKiplcnJwKQ0KPj4+ICAgICAgdmJhc2VkZXYtPmRldmlkID0gYmluZC5vdXRfZGV2aWQ7
DQo+Pj4gICAgICB0cmFjZV9pb21tdWZkX2NkZXZfY29ubmVjdF9hbmRfYmluZChiaW5kLmlvbW11
ZmQsIHZiYXNlZGV2LT5uYW1lLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmJhc2VkZXYtPmZkLCB2YmFzZWRldi0+ZGV2aWQpOw0KPj4+ICsNCj4+PiArc2tp
cF9iaW5kOg0KPj4+ICAgICAgcmV0dXJuIHRydWU7DQo+Pj4gZXJyX2JpbmQ6DQo+Pj4gICAgICBp
b21tdWZkX2NkZXZfa3ZtX2RldmljZV9kZWwodmJhc2VkZXYpOw0KPj4+IEBAIC01ODAsNiArNTg2
LDExIEBAIHN0YXRpYyBib29sIGlvbW11ZmRfY2Rldl9hdHRhY2goY29uc3QgY2hhciAqbmFtZSwN
Cj4+PiBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+PiAgICAgICAgICB9DQo+Pj4gICAgICB9DQo+
Pj4NCj4+PiArICAgIGlmICh2YmFzZWRldi0+Y3ByLnJldXNlZCkgew0KPj4+ICsgICAgICAgIGlv
YXNfaWQgPSAtMTsgICAgICAgICAgIC8qIGlvYXNfaWQgd2lsbCBiZSByZWNlaXZlZCBmcm9tIHZt
c3RhdGUgKi8NCj4+PiArICAgICAgICBnb3RvIHNraXBfaW9hc19hbGxvYzsNCj4+PiArICAgIH0N
Cj4+PiArDQo+Pj4gICAgICAvKiBOZWVkIHRvIGFsbG9jYXRlIGEgbmV3IGRlZGljYXRlZCBjb250
YWluZXIgKi8NCj4+PiAgICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2lvYXModmJhc2Vk
ZXYtPmlvbW11ZmQsICZpb2FzX2lkLCBlcnJwKSkgew0KPj4+ICAgICAgICAgIGdvdG8gZXJyX2Fs
bG9jX2lvYXM7DQo+Pj4gQEAgLTU4Nyw2ICs1OTgsNyBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2Nk
ZXZfYXR0YWNoKGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+
Pj4NCj4+PiAgICAgIHRyYWNlX2lvbW11ZmRfY2Rldl9hbGxvY19pb2FzKHZiYXNlZGV2LT5pb21t
dWZkLT5mZCwgaW9hc19pZCk7DQo+Pj4NCj4+PiArc2tpcF9pb2FzX2FsbG9jOg0KPj4+ICAgICAg
Y29udGFpbmVyID0NCj4+PiBWRklPX0lPTU1VX0lPTU1VRkQob2JqZWN0X25ldyhUWVBFX1ZGSU9f
SU9NTVVfSU9NTVVGRCkpOw0KPj4+ICAgICAgY29udGFpbmVyLT5iZSA9IHZiYXNlZGV2LT5pb21t
dWZkOw0KPj4+ICAgICAgY29udGFpbmVyLT5pb2FzX2lkID0gaW9hc19pZDsNCj4+PiBAQCAtNjA1
LDYgKzYxNywxMCBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIg
Km5hbWUsDQo+Pj4gVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4gICAgICAgICAgZ290byBlcnJf
ZGlzY2FyZF9kaXNhYmxlOw0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gKyAgICBpZiAodmJhc2VkZXYt
PmNwci5yZXVzZWQpIHsNCj4+PiArICAgICAgICBnb3RvIHNraXBfaW5mbzsNCj4+DQo+PiBJIHN1
c3BlY3QgdGhpcyB3aWxsIGJyZWFrIHZpcnRpby1pb21tdSwgc2VlIHZpcnRpb19pb21tdV9zZXRf
aW9tbXVfZGV2aWNlKCkuDQo+PiBXaGVuIHZpcnRpby1pb21tdSB0cnkgdG8gZ2V0IGhvc3RfaW92
YV9yYW5nZXMsIGl0J3Mgbm90IHJlYWR5IHVudGlsIHBvc3QgbG9hZC4NCj4NCj5UaGFua3MsIEkn
bGwgbG9vayBpbnRvIGl0Lg0KPkNhbiB5b3UgZ2l2ZSBtZSBhIGNsdWUgb3IgYSBwb2ludGVyIG9u
IGNvbW1hbmQgbGluZSBvcHRpb25zIHRvIHNldCB0aGlzIHVwPw0KDQogICAgLWRldmljZSB2aXJ0
aW8taW9tbXUtcGNpIFwNCiAgICAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDowMTowMC4wIFwN
CiAgICAtdHJhY2UgdmlydGlvX2lvbW11X2hvc3RfcmVzdl9yZWdpb25zDQoNClRoZSB2ZmlvIGRl
dmljZSBuZWVkcyB0byBoYXZlIHJlc2VydmVkIHJlZ2lvbiwgdGhlbiBkaWZmIHRoZSB0cmFjZSBi
ZXR3ZWVuIG9sZCBhbmQgbmV3IHFlbXUgY2FuIHNob3cgdXMgaWYgcmVzZXJ2ZWQgcmVnaW9uIGlz
IGxvc3QgaW4gbmV3IHFlbXUuDQo=

