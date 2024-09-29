Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E0CF6491
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 02:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suk8K-00053w-Qz; Sat, 28 Sep 2024 22:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1suk8I-00052t-3G
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:58:02 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1suk8E-0008O9-WF
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 22:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727578679; x=1759114679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pWQKmFtV4VeLlcASXMnJnZeyh9DSJA40w5GeTwjt9D0=;
 b=DXW1ueVFf1lQ8HJRgctqQNt7ItbphJwRobVaQ6TgPExMwWGcosKdZCyP
 TZmFuYY8PNcJnHmAzf8u2Iz6SEFfBmnyoXhmVqLr3fNWQura/1MLmVsYy
 7rvhUbLbUqumq/C7lKiksxvBh/FAOwpD+RD47KfrfWRhSrsSqzsdi6eA6
 a2V7t6h+bI1ztfWEmyjoaR8swMONx9Qgm5ULbHLF4DlQZVpY2jsmQOD0H
 /tNkdIFUBVzgV3FAY/e60/4IOqWi7Z8VMrfFvTNmZPGGgHYPhqPpYga96
 X8LF85A0fQAlMBtLD7aUV66bImfYkwMOf/SpMvKAOQf8/QYpmnMfDYs/O w==;
X-CSE-ConnectionGUID: 5GEeXEPxR2WKOFQDHuhsXA==
X-CSE-MsgGUID: Fm87nkQsQI+x8KqmfCDF/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26495175"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="26495175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2024 19:57:55 -0700
X-CSE-ConnectionGUID: aMMCpw/RRu+iOfCvnZy8Ag==
X-CSE-MsgGUID: lxFxf+QRSwWhlX8j04BPzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="77450942"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Sep 2024 19:57:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 28 Sep 2024 19:57:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 28 Sep 2024 19:57:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 28 Sep 2024 19:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV3f9TcxzrTp5QHL23yce3TV2EgjmKy6MGhQsWuXs2BOKGN70QaN8atg04gGLndC1f2BXMEIH+50cB7xPDttabiEdTHZw3VYTyud2D8Ma35OVIXoKIXU2gnMh9nODkvM8x/34ptencYBWKklKcRh8SV8qCpzysAE6NNKo/ApLs6jVKXf8q21pB0JRwzgPrS10vrBu6WRR9H4ShoohAXqrnbyKopSb+zmq5qJ488Lx0YgQsoi/dYtwgMeu2ntyJbzXR1DZ1fYZNWjqSYOO3sEqszZwpIVuVU8FTop5g3UIMI17nUg4mNXcccZybUnUXX0bHFCdwbxbjthMvst05PKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWQKmFtV4VeLlcASXMnJnZeyh9DSJA40w5GeTwjt9D0=;
 b=qiFQw2eQbznpzYP1VQPHimxpdLRARcaX1P9S2FEaIJFpE+R9O9WUqmWtOGqe3Z0RO586M3HI88Q5AqCyHFzUQSJCSPxpoMDm/o+2rGyY5bUTNUdvq9Oakn28a9Ul7fMULLrmBzqIcsIwdpIdXOqsIPTC03eDDuPrmqFTPpCTG+MmDZqxr3TLqv+f09b0Ii8hWLUWE6vtQaKXEpM+t4EvmYi596azo1BRQnXAqmoQ9A4i2iFKnBCGkeYEUvG58xg9tdYx6VODBDBQIeak/iY6qgjcoydxsSqGQ46rlqd3zK1WLc1MTYOpDpNx15EPbfuVwKoweVDtZ1tcglgtVpGsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV8PR11MB8677.namprd11.prod.outlook.com (2603:10b6:408:1fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 02:57:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 02:57:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Topic: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Index: AQHbBAtAgk8I02zLVkit3zw09AVFXrJrHZ8AgAAcKdCAAuVzgIAADBAw
Date: Sun, 29 Sep 2024 02:57:50 +0000
Message-ID: <SJ0PR11MB67448E87A00E4F3E9084F81B92752@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-15-zhenzhong.duan@intel.com>
 <CACGkMEuV=ZdnGE7N=YehCxpNiVPXai=WUdgJjnxVxwzBnTMEOQ@mail.gmail.com>
 <SJ0PR11MB6744CF33309D78D902DD052E926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEvn3HUwhmHE0dvg+g-o0jpH2g-xHciZ_u8CH75qm7KdkQ@mail.gmail.com>
In-Reply-To: <CACGkMEvn3HUwhmHE0dvg+g-o0jpH2g-xHciZ_u8CH75qm7KdkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV8PR11MB8677:EE_
x-ms-office365-filtering-correlation-id: 381d05fc-2d4a-484f-5aa9-08dce03281a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WWhhSWFLOGpWRWtkVnF5dlVhMmRMYXdnd2ZOM2FxbzBCa0h1OEpSVTBBSm9B?=
 =?utf-8?B?eXVYTjB5T0ZYeEluL3ZubnB6ZGpidW5rSDNuV1BmNEljUkFWSVQwMEFYbkR4?=
 =?utf-8?B?Smg0SnlueVlBZmhKNml3bS9SSlJzVmFsN0FsaUtLVXRYZHg2RmxmVnFadlJQ?=
 =?utf-8?B?QXRuMWlPTi9UeTlTeWVSc0RrMzROMVNrd1VKb2dCWHVGTEpybnZ2VGFXWktt?=
 =?utf-8?B?K01LTjRxNXIwTTN1TzcwTUJVcDV1UHJYVUhGd0FEMmFjTGZXSXlqKzlORWtF?=
 =?utf-8?B?aktjN0VaeFJiV1BKenB5dTR0OWxkcE16M3hNd3g4T1VwdmsrRFQxZC9MajNP?=
 =?utf-8?B?anJGcHJYV1dEQlZwUlFHSzR2ZlRUZlFBclQ5ZEZHNk9zUGk4SFMva0tFUGJy?=
 =?utf-8?B?YUFwdVoweDZkUVIzYVZrNmFJUU9zNjJBS2V1dFVWazRSQ0VNYVhTTnBoSUxG?=
 =?utf-8?B?NWc0WUJpbzFJcWVzV3JRTTBBQTM3QXhiM0JhYmVxRFhlSjdZejlLbXpNYWxy?=
 =?utf-8?B?LzVaM0xpbEpLNEZjVDZCdmZOUFNQcmxCZUdvTVBSTWVzVWFMTlVsNzZPMUVB?=
 =?utf-8?B?RzhkNkpMMTh5a1U3QVN1Qk4vV29xVWhabFhGSE9melZoU2t5MTYzS0FTR3A5?=
 =?utf-8?B?NDJ1VzZ4cktlNjhDazQzaXptQmNWTkxEVHd0WXFKTERib2Nac1VOWk80MFJw?=
 =?utf-8?B?TTNvY1JsMlM2WjVITkF0MXIwakVMSGdWZHR6M0kweDRpQUNlS3ZpWDRYRTFQ?=
 =?utf-8?B?aDFMWTBqQ09DRmVTbmxXUUVDZlZldVBxNGpGekxiWGFKSTVzenhCbmhyeEE2?=
 =?utf-8?B?TjJnUXhTSi9la1gyWGwwaTBXd05vMzRmTGN5V0tsMFE1blA1VXNBYy9SQlRy?=
 =?utf-8?B?NkdXWlVOZUo1VWNORWNmYUhUTGJoUTFHZ0dzU0JDUjgrV0pJMS8zSVNucnVw?=
 =?utf-8?B?ZDVVeHYxNmN1UUtwYWVvREdYZjlPZCtIZ01yd2VIcW9RSVFsN0RvL0ZNcG9H?=
 =?utf-8?B?THdpWnNWRExCNEo1eFdQOVczRlE3aU8vc0pUdFduNjdxZ1NSelpNVHRmbERl?=
 =?utf-8?B?aU5KTEZLWWZ1Uk1tNU4xSXJwNDZyaWxaSGpZSkJsSHNOR21FTjRVR3c2Y0Zv?=
 =?utf-8?B?TzNFWjB5amRPZExrKzhDVUJTRnpTZWEzalFJajg2ZmlZM2xMbEF2Zk81YTl1?=
 =?utf-8?B?WkFJM1ArOVA5bmprME5BVDhnWEJONU8ra1RHWHRxNEErNGp1R0VXTU9haXZE?=
 =?utf-8?B?cEIxMHVoN05XN05TNVdaRzJvM1hvNGpCdGI4emE4WjJlWEo3bUtVMzhydlQ0?=
 =?utf-8?B?bU1EZTZwbU9KdlRUQjBzQjUvZmhSNzhmTnkwZUQyMm9ZNkpYT2d3YmNhN0J1?=
 =?utf-8?B?L09JMGZqc0tSbUowQzNtNE81V3IwRnp5cmRkeHVJUTIrT3Ywd2JkU1hPM3Zn?=
 =?utf-8?B?Z1pOT1BKbUZjK2F2ampaT2o4WlF6RGJwdGIwNno5ZkZXQnlPN2VWNXhYVjEx?=
 =?utf-8?B?QURObUNOUFFyQU01dms2M2phMHFiZWZvS0w4ZnNWdWppdUlkYjRSblRVci9v?=
 =?utf-8?B?UXFKUjVsS3ZLRVhENTgzZGwvbThpL0hPc3BiczgwS29oaU1uQ0hoRks1UENu?=
 =?utf-8?B?ZHg5YjVJNDRVZ0V6YjFkWWM2Mk9ITXJ6aysrdU9pZkVyNEUyNnVDQ2VOMVBk?=
 =?utf-8?B?QUoyWTh6NXB0VzJqTVFmNTE2dXlUakpDakdHY0FIcVA2RUhKWkU1eG5zQmJR?=
 =?utf-8?B?WVJhSkdNU2tkMGRHcmk2NXpPd1JKMnJtVFlJNmVrM1pjN0MzbFJocUpEa3NL?=
 =?utf-8?B?dkpKMDVLK1ZPZzVCdGMvdzZ5eVhjdVdFdHlSdFEyYTJ5YTJwU2FtY2hQbkVs?=
 =?utf-8?B?czF6M0FGbGtFeVdFQWlqRjFKVkpjakpseHZmZmtNMG9OeFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N29wRFJ0WUt0OVoycEJqcUFEK1VrV0NIRWU1M1NRVmZrMDRXYm1HdVBDWitV?=
 =?utf-8?B?SkR6Um8wUkN4dzIzQVl5U0FPYWd3NUlHZXZJZHNld0pWR3crWmMzd0wwelFW?=
 =?utf-8?B?bFRYei95cTVwRkQ1MUZoSCtMakFaSWlUblBlb3VmOURBdjR4UFBJdHFhRmFJ?=
 =?utf-8?B?QVhtNGkzdzNWb0k3U2RsK1dmSkE3RnJmRGVpc2FOYS9uUW82UWp3NDFPeVh3?=
 =?utf-8?B?YTREM1ZtQ2I4b1FkaFNFSlgxTHcweVVFL29OT2t6VXRTUVZtdzlSdTJUMWIr?=
 =?utf-8?B?TlRpMCtwa2RhWkgyb1ZVdGhKWWdtSmVnZUY5R2c2VlhvVUR4dzBiY2lnL3BX?=
 =?utf-8?B?SlgxYnZ0M21jU0xNMDlsRzF2UzRQYjhrK1FGN0xGK1FTZnM1VzY1N3VsQlYz?=
 =?utf-8?B?bG9aNjlndW1kdWtTaUoxd1ZHVnp0ckFSSTdxS2RjNTVyWUVsMU5QSmlqeStn?=
 =?utf-8?B?SlprcHNCOG1FTFpNMG4xdUFoUmhJQm8zZ1FSUG1iWXFTTVl2NGxVWmVvdG9T?=
 =?utf-8?B?cERiRnpOS092KzBYWmx0ZmZOckFTemJyNFpJTy84UzQwbVBhMWlwSTg5ZTM0?=
 =?utf-8?B?Z281eGwvdTVOcy9MUzBKZGNycWpFclB6V0JoSnVGMEVYckd3ZGJlRWNnM2wz?=
 =?utf-8?B?Y0szYTIwY3NKeTJzaFlxWVVvcGRnS2w4ODU0MDQ2aUdkdi9oMUE0SEgxdTFI?=
 =?utf-8?B?VHlXaThJSDd4TW03VjRvbnEyWlpBUU5UeUZxSVFYeFIyWWVOSVZhNzRGa3A3?=
 =?utf-8?B?SjltTFQzaDFiZ3l5K2V5R3E4QW1nY2taRit3bUJxWnpSTEFtMVhHaDRBb0hQ?=
 =?utf-8?B?VzVFQjdhaFcxYWhvVm5qTGFIUVFBbHBtRkRoTUQreTRFSmE2bW9nS205NnFs?=
 =?utf-8?B?TlhyV0NNY0U4eDI0TkxHSGszZmVOTVZYblFhZnNqSUd1Syt5ZXI0ZERnaFFC?=
 =?utf-8?B?WXpsMVIrYzFFeG9OZm1JNUtpcURSMWIvTUJmdDNXdzJkM0VNUHpnOFdMdkZp?=
 =?utf-8?B?QVRESXluQ1lPd25ZQVRtOWlvQTc4RHhqdjYxbHRVMUlNdjBRaU9NNFdnY2ZN?=
 =?utf-8?B?bmhnSm5vWGw0a0w3UzAyUWNGQ2VFelROTnZxbEc5MXJXYkR3TUZnSC9KK3Nu?=
 =?utf-8?B?UlR5V25mNVNaTVV6a3BpVUt3RnRJTlJlVThzNW1NRGp5VDB5TVVoTkJOVUJZ?=
 =?utf-8?B?ZDlPSjdYQTY3bmNieVdTV3F0aktvQWs0cHFPOTNlVFZIQUFFbDZNNVYzN3J0?=
 =?utf-8?B?MVJ1UktHS3pPTXlLWFptK29QanRWdzd5WVpXT0M0ZXUxVG15R0VDV3RPYlZy?=
 =?utf-8?B?cEJaOHFNa3hCNk5nTForR0prSlBvWkRuWE12S3NpVXFlKzlFbHNYN01PZE9L?=
 =?utf-8?B?L3N1ODl6MGNVVm5JbFdkRDQxaHptcTIrK1hwb3lRenNQakdtOXJOVVpHMlVX?=
 =?utf-8?B?dGtaTmVzZVo1RWxBOFhrZXpBbjR2Z1FQSjZEUlVWSmYvZHdrcXZmZ1BuMWlJ?=
 =?utf-8?B?MXQ3Tk5UMHV2S3Z5RFBWTWllVXllc0NJU3NzbkFmT1d6UnFweElkWitjMUxH?=
 =?utf-8?B?THRHclUzZEZ3SlIrYjg0ZW1qVENDRHBCdWsrR0hFYnZPbVF1OUc1eFBRYkhu?=
 =?utf-8?B?SWsrblFtMVMzMklVbUVDeFFaRG5vZFJCNlUzaXR4Znp4L2JkdXNpUzBiUkVq?=
 =?utf-8?B?M3R6NytydTROc3VFTjZidmNjMnVCRjBXcVFkaDB1RlBQSXJaQVg1QXpidno0?=
 =?utf-8?B?MndmZGJldUdxbEtETFNYamZmZVhIRm1xYzM5aU1za0UvaWwwQU03UFdXSGtL?=
 =?utf-8?B?YkxCajROSmhIcTl3eVZGSjBOejZKdjdjVzFpNjRNUS9XUkZJUVlBQnBBVmlE?=
 =?utf-8?B?TU1Xb1ZxTEJReWo3cURGcEZldzNLRkZhU0xNMVlVTW9zVTBtamNWeityQVhP?=
 =?utf-8?B?SHpESzBqUG4wZjh4bVBMN1h3SVVJZzExNTUxUXhnN0dyWXVUMzl2TkE1cXhN?=
 =?utf-8?B?NFhSejJ4VkNhUVYzS3pVSlY4QlFWTmNEekh6NEZGSnhlV2trMThGQllhOUV1?=
 =?utf-8?B?empuYlV3WDlpN0hiamxLWE4xL09RaTlQbERZWHhLU3lJdzNXVHErT0tFYmwv?=
 =?utf-8?Q?z92inMcx/t8ZlDRvMeWW8YK6P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d05fc-2d4a-484f-5aa9-08dce03281a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 02:57:50.6953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7u0bq8fFZnjT+T2c6aFg7O1Js1PtFKu6SGzGkbUchGt3XRGQHBfXpf8FQ/zpKSj41+gKhVdbO49kOpI9LgwSRpk8tmS43JI6tVWDsWAIfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8677
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNC8xN10gaW50ZWxfaW9t
bXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4NCj5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0K
Pg0KPk9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDI6MznigK9QTSBEdWFuLCBaaGVuemhvbmcNCj48
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+ID4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+DQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNC8xN10gaW50ZWxfaW9tbXU6IFNl
dCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4NCj4+ID5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPj4g
Pg0KPj4gPk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6MjfigK9QTSBaaGVuemhvbmcgRHVhbg0K
Pj4gPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEFjY29y
ZGluZyB0byBWVEQgc3BlYywgc3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIHN1cHBvcnQgNC1sZXZl
bCBhbmQNCj4+ID4+IDUtbGV2ZWwgcGFnaW5nLg0KPj4gPj4NCj4+ID4+IEhvd2V2ZXIsIDUtbGV2
ZWwgcGFnaW5nIHRyYW5zbGF0aW9uIGVtdWxhdGlvbiBpcyB1bnN1cHBvcnRlZCB5ZXQuDQo+PiA+
PiBUaGF0IG1lYW5zIHRoZSBvbmx5IHN1cHBvcnRlZCB2YWx1ZSBmb3IgYXdfYml0cyBpcyA0OC4N
Cj4+ID4+DQo+PiA+PiBTbyBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kZXJu
IG1vZGUuIEluIG90aGVyIGNhc2VzLA0KPj4gPj4gaXQgaXMgc3RpbGwgZGVmYXVsdCB0byAzOSBm
b3IgY29tcGF0aWJpbGl0eS4NCj4+ID4+DQo+PiA+PiBBZGQgYSBjaGVjayB0byBlbnN1cmUgdXNl
ciBzcGVjaWZpZWQgdmFsdWUgaXMgNDggaW4gbW9kZXJuIG1vZGUNCj4+ID4+IGZvciBub3cuDQo+
PiA+Pg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+ID4+IFJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNs
ZW1lbnQubWF0aGlldS0tDQo+ZHJpZkBldmlkZW4uY29tPg0KPj4gPj4gLS0tDQo+PiA+PiAgaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAgMiArLQ0KPj4gPj4gIGh3L2kzODYvaW50ZWxf
aW9tbXUuYyAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KPj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ID5iL2luY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oDQo+PiA+PiBpbmRleCBiODQzZDA2OWNjLi40ODEzNGJkYTExIDEwMDY0NA0K
Pj4gPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ID4+ICsrKyBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiA+PiBAQCAtNDUsNyArNDUsNyBAQA0KPk9C
SkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEludGVsSU9NTVVTdGF0ZSwNCj4+ID5JTlRFTF9JT01N
VV9ERVZJQ0UpDQo+PiA+PiAgI2RlZmluZSBETUFSX1JFR19TSVpFICAgICAgICAgICAgICAgMHgy
MzANCj4+ID4+ICAjZGVmaW5lIFZURF9IT1NUX0FXXzM5QklUICAgICAgICAgICAzOQ0KPj4gPj4g
ICNkZWZpbmUgVlREX0hPU1RfQVdfNDhCSVQgICAgICAgICAgIDQ4DQo+PiA+PiAtI2RlZmluZSBW
VERfSE9TVF9BRERSRVNTX1dJRFRIICAgICAgVlREX0hPU1RfQVdfMzlCSVQNCj4+ID4+ICsjZGVm
aW5lIFZURF9IT1NUX0FXX0FVVE8gICAgICAgICAgICAweGZmDQo+PiA+PiAgI2RlZmluZSBWVERf
SEFXX01BU0soYXcpICAgICAgICAgICAgKCgxVUxMIDw8IChhdykpIC0gMSkNCj4+ID4+DQo+PiA+
PiAgI2RlZmluZSBETUFSX1JFUE9SVF9GX0lOVFIgICAgICAgICAgKDEpDQo+PiA+PiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+
PiBpbmRleCBjMjUyMTFkZGFmLi45NDlmMTIwNDU2IDEwMDY0NA0KPj4gPj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiA+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ID4+
IEBAIC0zNzcxLDcgKzM3NzEsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9
IHsNCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT05fT0ZGX0FVVE9fQVVUTyks
DQo+PiA+PiAgICAgIERFRklORV9QUk9QX0JPT0woIngtYnVnZ3ktZWltIiwgSW50ZWxJT01NVVN0
YXRlLCBidWdneV9laW0sDQo+PiA+ZmFsc2UpLA0KPj4gPj4gICAgICBERUZJTkVfUFJPUF9VSU5U
OCgiYXctYml0cyIsIEludGVsSU9NTVVTdGF0ZSwgYXdfYml0cywNCj4+ID4+IC0gICAgICAgICAg
ICAgICAgICAgICAgVlREX0hPU1RfQUREUkVTU19XSURUSCksDQo+PiA+PiArICAgICAgICAgICAg
ICAgICAgICAgIFZURF9IT1NUX0FXX0FVVE8pLA0KPj4gPg0KPj4gPlN1Y2ggY29tbWFuZCBsaW5l
IEFQSSBzZWVtcyB0byBiZSB3aXJlZC4NCj4+ID4NCj4+ID5JIHRoaW5rIHdlIGNhbiBzdGljayB0
aGUgY3VycmVudCBkZWZhdWx0IGFuZCB3aGVuIHNjYWxhYmxlIG1vZGVybiBpcw0KPj4gPmVuYWJs
ZWQgYnkgYXcgaXMgbm90IHNwZWNpZmllZCwgd2UgY2FuIGNoYW5nZSBhdyB0byA0OD8NCj4+DQo+
PiBDdXJyZW50IGRlZmF1bHQgaXMgMzkuIEkgdXNlIFZURF9IT1NUX0FXX0FVVE8gdG8gaW5pdGlh
bGl6ZSBhdyBhcyBub3QNCj5zcGVjaWZpZWQuDQo+DQo+SWYgSSByZWFkIHRoZSBjb2RlIGNvcnJl
Y3RseSwgYXc9MHhmZiBtZWFucyAiYXV0byIuIFRoaXMgc2VlbXMgYQ0KPmxpdHRsZSBiaXQgd3Jp
ZWQuDQo+DQo+QW5kIGV2ZW4gaWYgd2UgY2hhbmdlIGl0IHRvIGF1dG8sIHdlIG5lZWQgZGVhbCB3
aXRoIHRoZSBtaWdyYXRpb24NCj5jb21wYXRpYmlsaXR5IHRoYXQgc3RpY2sgMzkgZm9yIG9sZCBt
YWNoaW5lIHR5cGVzLg0KDQoweGZmIGlzbid0IHRoZSBmaW5hbCBpbml0aWFsIHZhbHVlLCBpbiB2
dGRfZGVjaWRlX2NvbmZpZygpLCB0aGVyZSBpcyBjb2RlIHRvIGNoZWNrIDB4ZmYNCnRvIGRvIGZp
bmFsIGluaXRpYWxpemF0aW9uOg0KDQogICAgaWYgKHMtPmF3X2JpdHMgPT0gVlREX0hPU1RfQVdf
QVVUTykgew0KICAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQogICAgICAgICAgICBz
LT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQogICAgICAgIH0gZWxzZSB7DQogICAgICAg
ICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfMzlCSVQ7DQogICAgICAgIH0NCiAgICB9DQoN
CklmIG9sZCBtYWNoaW5lIHR5cGVzIGZvcmNlIGF3IHRvIDM5LCB0aGVuIGFib3ZlIGNvZGUgaXMg
YnlwYXNzZWQgYW5kIDM5IGlzIHN0aWNrZWQuDQoNCj4NCj4+IERvIHdlIGhhdmUgb3RoZXIgd2F5
IHRvIGNhdGNoIHRoZSB1cGRhdGUgaWYgd2Ugc3RpY2sgdG8gMzk/DQo+DQo+SSBtZWFudCBJIGRv
bid0IHVuZGVyc3RhbmQgaWYgdGhlcmUgd2lsbCBiZSBhbnkgaXNzdWUgaWYgd2Uga2VlcCB1c2UN
Cj4zOSBhcyBkZWZhdWx0LiBPciBJIG1heSBub3QgZ2V0IHRoZSBwb2ludCBvZiB0aGlzIHF1ZXN0
aW9uLg0KDQpJZiB3ZSBkZWZhdWx0IGF3IHRvIDM5LCB0aGVyZSBpcyBubyB3YXkgdG8gZGVjaWRl
IGlmIGl0J3MgdXNlciBmb3JjZWQgdmFsdWUgd2hpY2ggd2UgbmVlZCB0byBzdGljaw0Kb3IgaW5p
dGlhbCBkZWZhdWx0IHZhbHVlIHdoaWNoIHdlIGNhbiBjaGFuZ2UuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

