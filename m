Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A75BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 20:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpuxH-0008P7-HQ; Wed, 05 Mar 2025 15:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tpuxF-0008OG-EH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:02:57 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tpuxC-0003fL-UJ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741204975; x=1772740975;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zerv3AYJEehXRMgN7Dbvy2SrxgvnYNMpqv6CuBzXFGM=;
 b=HjmHhmvxZYmYgUeNzW7TZ307TdnxEdcZPCqYyVGorN+qohTm9UMYf9f9
 b5Xrh0c8VRTH8fGN6nQhs64crRVIfx19u18bYtDG49kLt2o2sp6A85kjg
 1PSCKlZafqOyUgO0alO8KzSPXOKQ5Wgzrj7mt2LLn1d6kygBI7bMSurlG
 d12385nDXQJl4TZnWP4tESJFvVxWyMrwgqm5n7/7GZC6ilmpG6s2WTYA1
 3P5yPYcA4z93cchzZFs7zoPy1iwRiIqoMOjf7S/4qOWybSogN5TgZApN1
 bVhM/S09Ps9gZU6XAHcrcBF1m2W0LOJ4/2RuLNa9Ja6ymiUwdn0hEW8A5 Q==;
X-CSE-ConnectionGUID: 8FPe3/fIRN2U9iaNZYgStg==
X-CSE-MsgGUID: 1mf1sVA8RMmXPuO8Aht2MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52398536"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208";a="52398536"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 12:02:50 -0800
X-CSE-ConnectionGUID: AYWMaZW6TumSUh8Ite3Dtw==
X-CSE-MsgGUID: W8QLFAiISAutHoScMjJ6Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118717181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2025 12:02:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 12:02:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 12:02:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 12:02:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvfB5dD2sQaRBm1ukIGaacugKahXb5dF5CP5jAVSBqS91BEbiPBlNpeHqjYteeblsaWN71mrXxSQsmxX7lF3eNYpXqlRGj6rdNBbMJ+Qvba6Ztd+8yA51bH1BNhJJ8AZmeFrdwh789WXCNZEqWOU+kKzboLL+GEDe7gqwSiHB3PUkYfabApgVS+ygRMu5CzVk8ej2TU7XhswfRLlfNQ40+HrnqDKd7kWafSh+BAq42mmug4s+5BiAvMTZkf2twgw0hP6Mvn3jf6cyZ1vpCyXQ9EdYIwjMWyyXuJ67cw58oLpK29sxtj66XHdAGGJ12JcLtdfgoASQw7aJu9GtqfbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zerv3AYJEehXRMgN7Dbvy2SrxgvnYNMpqv6CuBzXFGM=;
 b=MawCrQs+OVhEzTYdHK+1HgUqwvA2A629AA5Q3aOPJu6Se6qaq4vFckrR5PO/hM64DcIrhn8xJLnXTouR2g0lE/ocLVn6HSi1E4PPsLa/WwNB9mKiYCHaDbTNuZpd+qJJtNToBW+LmhqGRl3vtLkh6Kj3SOOt8bgtIJZuvRPSCWxwNSou/fQie/4yVTh/2CkiDpMYykH8kPpy/VvfhMzwhN+oSA/QrMIgybZ7rqCu6Mgwj4oD11IWxwDSPhh96GouCdeUsL8SyRSWFeuFPuFdrGajn8EU2j1V5V6ATOIb2GZZy/toaS5WLblnNXC8+VEXEptj+Ue45OpA5k4ZoaKu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by BL3PR11MB6340.namprd11.prod.outlook.com (2603:10b6:208:3b4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:02:44 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 20:02:44 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: hikalium <hikalium@hikalium.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: RE: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
Thread-Topic: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
Thread-Index: AduHr3IQUyMyDh5wS+uW6ITUR0kANACxaDOAAOTJTcA=
Date: Wed, 5 Mar 2025 20:02:44 +0000
Message-ID: <PH8PR11MB68796F0A7BE7BE3926CF95BDFACB2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <PH8PR11MB6879500CDBB703E22EC3D6F0FAC32@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAB7+XXqH9efN-bG4mAt51jM7ucnH4QcdRHhDnsNjWz8s9A=mqw@mail.gmail.com>
In-Reply-To: <CAB7+XXqH9efN-bG4mAt51jM7ucnH4QcdRHhDnsNjWz8s9A=mqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|BL3PR11MB6340:EE_
x-ms-office365-filtering-correlation-id: f54d9b35-84cb-4f0e-97af-08dd5c20b1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjNkdkxMWWFrZGh1NmhCZlNXMHo5SmVMcXVpSU1QbE54WCtnOG9zT2JkUnhN?=
 =?utf-8?B?OStCWVRwMStMZHRkelBkNWFmbkNzMXlYaUZjV2NnaElCSE5lQUp1MFRjZEp3?=
 =?utf-8?B?a3JNbDU1NzZSaXJndWdzRG5lcWI4V1daMDZTdytHSUNuck13eUdrcFNjOE93?=
 =?utf-8?B?RWxVVUtrL0dabG9Za29JZHZRQTBHdkZOWEM3T2grU2lLNWs0eUNlSE9lbitU?=
 =?utf-8?B?bGl0WHZPRHhlOEhjMGpSd3o5V0I5S3gwUHJCeVlINXBucW1RUzU3T2JrUktj?=
 =?utf-8?B?dHBETVFuNTdiV3VCMU10eTRINGlZZEZZemlUUVhtdmgyNFpIb29IdjdJRWsy?=
 =?utf-8?B?RVdxVXBpdmo4eEt4R0l0VjNZamJQcUpXNEdxSnNubC9peVRPZTdwd01vbURG?=
 =?utf-8?B?bFM0RU80NVhweVI0RHdKWkd2MmZiZkZqYnVsZHVNU0hoT2pJOWpHcDV4TWo3?=
 =?utf-8?B?UG5ZMElKWGMvMDZtdnROTmx6bzlJN0xHU2dYaFEzWC92WWppSCtsREJsd20z?=
 =?utf-8?B?Ylp4cERxKzNRWnMvK2Mzd2NVam5FaWtEZk1ncHFaL2Z5VkJMQW5VNHVKcE1E?=
 =?utf-8?B?VXVxZ1lyakpMazdLOEVDZXpCTTNIbS9odGcxUGxUcDF4WFBKaG5rZGwvZytM?=
 =?utf-8?B?WXRPbDlUNUJmZXEzaExtM3lrWm1YY2hNY05aWVExc0VuRjdrSEZEOU5vTVBz?=
 =?utf-8?B?aEJ4OWo4QzMwell4MlB6bGV4eTZ1V2hQWFEwVGdWNUNsTnpBeHI3ck1zeWVq?=
 =?utf-8?B?RkNUbU1FZVRDT2hjYW8vdktvaHZQcC94WmJrZVJaUjdEd293VDEvdXlXcG94?=
 =?utf-8?B?MGtUaE9lNVp4UkhRMzc3dzhJbWljOHRHdjZnWWpkd2svUC9OU1hmSythK2lG?=
 =?utf-8?B?QXE0WFpIdXJDUmEvOEVOT0w0OWVBcGMxQ1B0dzVtWUd4bmxJSklaYllLSHhs?=
 =?utf-8?B?M3dTaWxVQWdtQmZUZGRteks0ZTdQSS9RRjZUY1ptNm9vTVBUcTVsdFBVSENN?=
 =?utf-8?B?aWd2NmV6OTRZbVkzR2pVTzBkSG1RaEorMHJQcUM4NkRZaGVWZUxVVVBqM2pq?=
 =?utf-8?B?Zk1FTk5MU3FVU2dzSEttS01DM1hOWnRnd3BuakhFWWJwbjVzRkxNZFBxdCt2?=
 =?utf-8?B?bFdzL2xyeW13OEQyWXZWekU1MTJXRFovU3VtbHo1UGMzbzg2KzB6ZDJFZTNi?=
 =?utf-8?B?a0ZCYjU1K2VnNG95VlNMMkUyNlFMcTVkVnVjcjdoT0JETFlnSXNrUGhxd0x2?=
 =?utf-8?B?UUhqL2pDY3VOVE1NUTZyaFZnZ3NhdSsrOGVWYUhSRkVXRy9HQlNleGszWVpX?=
 =?utf-8?B?UUYrcm9xY1RjaTBRZVprd3Y0bG42WWFlcHJTWHVnN2JqWTNrNEJPVTdRV2th?=
 =?utf-8?B?bXFJVnBFbENLWDhnNEJFc3ROSXA3VGhIM1NtVkVibWZqb3RYSFFFVktieXZQ?=
 =?utf-8?B?K3htcEJmQ3hlY2VrbmFVdGpTWERRZlE1VnowZXdVKzBCaU43S2RpOE1iL0FW?=
 =?utf-8?B?WEJIc01iOUFZTzZGMG1GUnBKY2c3eWZ6VndWMjZ6UFlBc0YybnB6ZXRYZHFk?=
 =?utf-8?B?emNXMGJNaWFyMU4vRUlPRzg5ZEpMVm9HaEM3Vm0xdEYxOXkydFhRZWxSRUVx?=
 =?utf-8?B?Sm56ZjFBT2MzUTlmMGlWNGRNK2YxVWk2NXpCYzRGall5bjN4clpIOXp5WEgz?=
 =?utf-8?B?WVM2TEZHWGpValhNTGhFZDdkZWdKVFZaWkhEckw5c1hPZnBHNmFlK3FhN0kx?=
 =?utf-8?B?OHNweTI3OGF3VkQ4ZXBGUmJtRzhzTFU2dTllMlJvcUJOU2U4RkVRbzlHcCtk?=
 =?utf-8?B?NTBTK010ZUVMN3lybVBvbEZYUEVtZDBybjBXajJVaFlMRE1lamJvSitQMVMv?=
 =?utf-8?B?MWxVNlpiRW8vU0tQRERoOThqWTBsTlIxRENLSmpmQ21RZGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FBNkhCVFlxaEo5bWtuS3BZbHNSRVFlajF5VzlnZnZqYlFrYkhFWDBMNDF3?=
 =?utf-8?B?a3N5M2V1VVpaeDRXb0xLWHBzWjdibC84em9QdkFwaU50ZmZ6TWowUmZ1a2xn?=
 =?utf-8?B?YmFUL3kyNHlPNnJ0MTZMS0FkZ2daT1NkUWprUU56cTh2czNnRWxiSnpWSXF5?=
 =?utf-8?B?a1pUYnpsL3QxN1N2YUlKT2FNS29ndTFJVnlHb2NiejVZSFNveDJYUFJieCsv?=
 =?utf-8?B?QkEvRmRSYVpkMmZIVGU0cVJIL2VMbGtrMThOK1FTUTZmM2JsZTBiMC9pdVJ3?=
 =?utf-8?B?UU1qMVllcVFMbW1MbWhiT2VkK1VtL04vVW1zVWhsUHhLd2FrVzNMcmVLdUhy?=
 =?utf-8?B?aWlEK2xFbVpKU0ZnbnBvK2hPYWNwaGIzY1AxdmNPUW0vWm9YMjlYK3R1TE1m?=
 =?utf-8?B?d1lmVHhBVFVVbERzbHRSOFA4QmNhNUdxNUtoVjlqNmIzdHk1NWxpL2VFTy9m?=
 =?utf-8?B?S28wYkU5ckdhMUdSSnNTUi9TeDdUZlZvbytsd1FOUmhpaDVEUmtQVXlHdzdh?=
 =?utf-8?B?R0tCQnk3Snk1Qzl4elZFU2t6QkZSUWNhRlJONEphei8wVFVmc3NFQW9hV1Nu?=
 =?utf-8?B?M1JteGExWTFlZXRvOHc1R2FPS1pMNUdrLzdEbXRZUWFRRmZ2NE00WFQwUnVw?=
 =?utf-8?B?cU5BL1plVFFyNDBxUk9MZVhQYjQxaStnM2tpTThaWDVOZGZ3NGxEVU1zcEZk?=
 =?utf-8?B?VkRBb3BqWjVnOFdwaVFpcFh2WjJJT3E4MTJ5dDVuNktmYmlaS3kyS05uYkdz?=
 =?utf-8?B?ZUZocXdIQmViUm5pbldUSWtIa2xLaHczOVNJU0RBR1V1dENQYUlOUGE4VnhL?=
 =?utf-8?B?SGIyYlRjamtIMk8xdUxPaENRNFdRNHVtYUc4YldyZkFDNkt2NnZ3UjQzYURY?=
 =?utf-8?B?UnR0dHpoc0RrZ2hNU04xTHF2TkFMaHh5QjhoYmdOT0Rlc2NXdHdiYmxkUzFD?=
 =?utf-8?B?NHBRNFFBWnB3TGZWR1k5TVV0WExIQWYxRkpUQW1XM2dwUzdOYWZUK2M4OUhB?=
 =?utf-8?B?NnJjdnhsVHM2UmFYbVM4WW9XbmNDbk14VGZITEVyc0tVdE1VR2VDVVgyWEdv?=
 =?utf-8?B?WGRYdmM0amxRdUpidnFIalhrVWQ2ZGFiYk1sb3RrZWx1S2Yrelc1cldUTGZQ?=
 =?utf-8?B?ZFhFVkc5Ry9Oa1EvRFJ4bE1tWjVkbTRlaXp6TGRDWjNwZVFxcGhHYzkwaWlE?=
 =?utf-8?B?QTA5UXBWL3Y3YWgzVnVPRFBWa2xsVkNITFBSTUNaUmZKTGVLbGtFcnRHN2x6?=
 =?utf-8?B?clFHSk1IOXVLRis4RC9TSEZVQWw4N1VRbDJRYjZPdGxBUWNaU3lzSUJxT2dU?=
 =?utf-8?B?KzR6K2s5UlU1WTA3QTh2VmJabEdzb1J5K0NuZzR3cVAwa1R5QThubUQwTnor?=
 =?utf-8?B?K0dhVWZHWFM3d3RKRWFFTStxeHE3MzRJeHVldnhlOTFja1BrZ1J1RjIzRDd1?=
 =?utf-8?B?cTl2SWllSElYbXZYWUw4QTVXV1g3VHcrUjJ6SWVqNzU2VkpSSmhaNXAvT1Vm?=
 =?utf-8?B?N1BZNnVWWVN4a1NZZ3U0TzFQeXg3WlZaQm9CNWtXRXllWFRXS0lSNXptYTIv?=
 =?utf-8?B?ZDBIYmFGeWdENzQ3YmQrWEhEeGgvakVMU3NWVEh4b1loYzRiRlY1MzJ5WXF4?=
 =?utf-8?B?MVg2K0NndTQ1WFdacUpXOGNWaXZmdlZWV1pjOVhqR0tzUHd1MVlMVlJUOGs1?=
 =?utf-8?B?TlNtSkI2UFJsK2VNWXVyQnJ5ZGhaNXp2aE9oRjFSRmNOd3hGVmZEY2ZXTUhI?=
 =?utf-8?B?QStscGJkR1NxbHpXQkxCdFlTSVE5TXVXSVpTVUpjOC9VN3lEYnF0K041Y2U2?=
 =?utf-8?B?WDFlQ1NPNTdFWlBOV3VJd1pNNzVMdlhzMzlrZG1XS0gxenJaSXI4U0tVaDc0?=
 =?utf-8?B?SlE4YThYMTdUbm9aM0JZQlFQTkh4VVIzNlczTm9UVitray9aRWpMVi85cjRR?=
 =?utf-8?B?aENBQXh2Z1BJekhNUjVkT2VjOFJGYjRDd0c0clc3Vk9OckJ6bEttZXgrMUF4?=
 =?utf-8?B?M05mOW4wTHRPdURpalVGdUU4L09WM0IxdUJxK2ltaHZDV0s2L1NVZ0xjSmp1?=
 =?utf-8?B?d2xSWS9SL3ZtNzZxTVBLTzNSS1RZTUlKbDJPY3k5UXBXTWZKd083WGVWNWpl?=
 =?utf-8?Q?xL21JP9fw/RiNsiAvXYspUKQC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54d9b35-84cb-4f0e-97af-08dd5c20b1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 20:02:44.6110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOZ47n+Hcaz8L65u13sqwfA9jEtwJgCUDau4eGwo+/Cgz/RinET+CcTsZm1IG9Gda2QQc9toRo0TVzyl4x7TsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6340
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgSGlrYWxpdW0sDQoNCk9uZSBlYXN5IHdheSB0byBvYnNlcnZlIHRoZSBwcm9ibGVtIGlzIHRv
IHRyeSB0byBib290IHVidW50dSBpbWFnZSAoaHR0cHM6Ly91YnVudHUuY29tL2Rvd25sb2FkL2Rl
c2t0b3ApDQpmcm9tIHVidW50dSBtYWNoaW5lIChlLmcuIHVidW50dSAyNC4wNCBMVFMgaG9zdCku
DQoNClRoZSBjb21tYW5kIHlvdSBjYW4gdXNlIGlzIA0KDQpxZW11LXN5c3RlbS14ODZfNjQgLW5v
ZGVmYXVsdHMgLW0gMjA0OCAtZW5hYmxlLWt2bSAtY3B1IGhvc3QgLXNtcCBjb3Jlcz00LHRocmVh
ZHM9Mixzb2NrZXRzPTEgLWNkcm9tICB1YnVudHUtMjQuMDQuMi1kZXNrdG9wLWFtZDY0LmlzbyAt
ZGV2aWNlIGUxMDAwLG5ldGRldj1uZXQwLG1hYz1ERTpBRDpCRTpFRjpCRjpGQSAtbmV0ZGV2IHVz
ZXIsaWQ9bmV0MCxob3N0ZndkPXRjcDo6MTExMS06MjIgLWRldmljZSB2aXJ0aW8tdmdhIC1kaXNw
bGF5IGd0ayxnbD1vbiAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLW1lbWZkLGlkPW1lbTEsc2l6ZT00
MDk2TSAtbWFjaGluZSBtZW1vcnktYmFja2VuZD1tZW0xDQoNCk9uY2UgYm9vdHMgdXAsIHlvdSBj
YW4gY2hvb3NlIHRyeSBvciBpbnN0YWxsIGl0IGZyb20gZ3J1YiBtZW51LiBUaGVuIG1ha2Ugc3Vy
ZSB0aGUgbW91c2UgaXMgY3Vyc29yIGlzIHBvaW50aW5nIHRvDQp0aGUgcmlnaHQgc3BvdCBvbiB0
aGUgZ3Vlc3QgZGVza3RvcCB3aXRoIDEwMCUgRFBJIHNldHRpbmcgb24gdGhlIGhvc3QgKHVidW50
dSBzZXR0aW5nIC0+IGRpc3BsYXkpLiBUaGVuIGNoYW5nZSB0aGUgRFBJIHRvDQoyMDAlIHRoZW4g
Y2hlY2sgaWYgdGhlIG1vdXNlIGN1cnNvciBpcyBwb2ludGluZyB0byB0aGUgcmlnaHQgc3BvdCAo
ZS5nLiBtb3VzZSByaWdodCBjbGljayBhbmQgY2hlY2sgd2hldGhlciBtZW51DQppcyBwb3BwaW5n
IHVwIG9uIHRoZSBleHBlY3RlZCBsb2NhdGlvbikuDQoNCkZvciBzb21lIHJlYXNvbiwgY3VycmVu
dCBtYXN0ZXIgYnJhbmNoIGhhcyBzb21lIGlzc3VlIHdpdGggdGhpcyBzY2FsaW5nLCB3aGljaCBt
YWtlcyB0aGUgZ3Vlc3QgdXNlcyBvbmx5IDEvNCBvZg0KdGhlIHFlbXUgd2luZG93IHNvIHlvdSBu
ZWVkIHRvIHVzZSBzbGlnaHRseSBvbGRlciBjb2RlIGJhc2UgbGlrZSB2OS4xLjAgKGdpdCBjaGVj
a291dCB2OS4xLjApLg0KDQpzb21lIHZpZGVvIHRoYXQgc2hvd3MgdGhlIHdyb25nIGJlaGF2aW9y
DQpodHRwczovL3NoYXJlLmljbG91ZC5jb20vcGhvdG9zLzBhMnJzNXFVN2JReWI4cXBrVWJrbGQ0
UUENCg0KVGhhbmtzLA0KRFcNCg0KU3ViamVjdDogUmU6IFNvbWUgcmVncmVzc2lvbiBkdWUgdG8g
InVpL2d0azogRml4IG1vdXNlL21vdGlvbiBldmVudCBzY2FsaW5nIGlzc3VlIHdpdGggR1RLIGRp
c3BsYXkgYmFja2VuZCINCg0KSGkgS2ltLA0KDQpUaGFua3MgZm9yIHRoZSByZXBvcnQhDQpDb3Vs
ZCB5b3UgZ2l2ZSBtZSBkZXRhaWxlZCBzdGVwcyB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHNvIHRo
YXQgd2UgY2FuIHdvcmsgb24gYSBwcm9wZXIgZml4P8KgDQoNClRoYW5rIHlvdSwNCi0tDQpoaWth
bGl1bQ0KDQoNCjIwMjXlubQy5pyIMjbml6Uo5rC0KSAzOjAzIEtpbSwgRG9uZ3dvbiA8bWFpbHRv
OmRvbmd3b24ua2ltQGludGVsLmNvbT46DQpIaSBoaWthbGl1bSwNCg0KVGhpcyBjb21taXQgYWN0
dWFsbHkgYnJlYWtzIG9uZSBvZiBvdXIgdXNlIGNhc2VzIHdpdGggVWJ1bnR1IGhvc3Qgd2hlbiB0
aGUgZGlzcGxheSBzY2FsaW5nIGZhY3RvciBpcw0Kc2V0IHRvIDIwMCUuIEl0IHNlZW1zIGxpa2Ug
Z3RrX3dpZGdldF9nZXRfc2NhbGVfZmFjdG9yIGlzIG9ubHkgd2F5IHRvIGdldCB0aGF0IERQSSBz
Y2FsaW5nIGZhY3Rvcg0KYW5kIHdpdGhvdXQgdGhpcywgbW91c2UgbW92ZW1lbnQgb24gdGhlIGd1
ZXN0IHdvdWxkbid0IGJlIGFibGUgdG8gZ28gYWNyb3NzIGNlcnRhaW4gYm91bmRhcnkNCmFzIHRo
ZSBjb29yZGluYXRlIHdpbGwgYmUgaGFsdmVkIChpbiBjYXNlIERQSSBzY2FsaW5nIGZhY3RvciBp
cyAyMDAlKS4NCg0KY29tbWl0IDM3ZTkxNDE1MDE4ZGIzNjU2YjQ2Y2RlYThmOWU0ZDQ3YjNmZjEz
MGQNCkF1dGhvcjogaGlrYWxpdW0gPG1haWx0bzpoaWthbGl1bUBoaWthbGl1bS5jb20+DQpEYXRl
OsKgIMKgU3VuIE1heSAxMiAyMDoxNDozNSAyMDI0ICswOTAwDQoNCsKgIMKgIHVpL2d0azogRml4
IG1vdXNlL21vdGlvbiBldmVudCBzY2FsaW5nIGlzc3VlIHdpdGggR1RLIGRpc3BsYXkgYmFja2Vu
ZA0K

