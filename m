Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71854E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 05:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPbLE-00045P-GF; Mon, 23 Dec 2024 00:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tPbL4-00044h-Lt
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 00:50:46 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tPbL1-0003qu-Qi
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 00:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734933044; x=1766469044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WX2OOPu39NT1f+TdKjMEYGepmyEMhi3ud6Tj7jZI/lw=;
 b=cZ60B7vhjvLlQoKvpnU8Ngiiur9S1X/cxXrpobpOxTnFdtcOu/H8at7e
 OX6NGb5rKU1/LUPEHsDG72E4wi3NoCWtL7jbMp6b8FZS8o9bbiOPveSxk
 9goTNcuxtNjaFhJgHAfHpE/vjiNxxQprV4km+Ncc8DkcQCP0VScARcpVE
 5L5g9/vOAL7xOKsYNAvVbdAqSPDOpyjr9+1FIIVCdFc35hoFRxsJxcLzC
 HRI6W6wdrOFo75WWUqy23egFGP1b1Drf4oumklh5IuSW8ZSMMwicpA6Ym
 sI5Iakz1hAvCYcSH/M7O81w3Xj5CiGrg/obfTeV88XWc1Q5sIP2btMFvp g==;
X-CSE-ConnectionGUID: 4i2Zn/wVRA6yrlYDtmq8Zg==
X-CSE-MsgGUID: /X+zWVAmRdaOxoroKs51CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="39330438"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; d="scan'208";a="39330438"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2024 21:50:39 -0800
X-CSE-ConnectionGUID: TdA58WqXQ3ORCaI/7JAcwg==
X-CSE-MsgGUID: bFVB8rCRSu29qd+gR5jeiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; d="scan'208";a="103980125"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Dec 2024 21:50:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 22 Dec 2024 21:50:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 22 Dec 2024 21:50:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 22 Dec 2024 21:50:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELYpQ7/sdJcVtaGlOUg+VxmNWz6uzFEdnCg2Q3s1uYHLUlOMEiVDlgQ8YlbdplOZZQtxOe8c3EbixCSVsKL7rxeimgQm+b2OCATpFCgFuj/wxFPfHIvlcK/mpnCF9LxmjD0D2L9RNiodcscxCCaS0jDHHaWWD6uWcuMM421vnluWmx15C8fqkuK65SG0WCUIP/hV3acL98FEU2M9ZduBAgnOStI+jBsD3zu5P1tsOdtO/b2r/ZU8b66F2Wepc1AOTcIXh+pgzGBg4EHGvZL6PpeVdgBzElQ71FJA7OzmUn1+ifjQHZbhrP6RlFADyVoTjOuSaB4f4zBq4w62b6pbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX2OOPu39NT1f+TdKjMEYGepmyEMhi3ud6Tj7jZI/lw=;
 b=Ng2P1537hMJWcAPeBmqaRcaOgmkiXH0dRKmbDE7J7AKwOTRaMS+2OweiC5aZqpx+EBHLw6YH6bKP1ld9jT6TQc0W0emt04aNLbdVbtafkPeLqEyAl3W+pEh1pznRyTJFmnVmk6xQWLydQcBii1nqTirk33iq8Ahg4QLREmLTWfHf5QFGYiKslv0DBjJCKQvgrWq6urXzaw1RsFQHC9bamrPAKxEw7bctcnOVH3b+f9GuWf/gipVM/7Hx+cmxD7TENdNypjc/vm+o4gPXpJnZXX/sSPIJFT7lmf/zkJMSjaojTTgDVTNz9vr8ZZlQ2jf1AMRAH1dKyjW5xxolyir64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 05:50:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 05:50:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>, "minwoo.im@samsung.com"
 <minwoo.im@samsung.com>
Subject: RE: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Topic: [PATCH v1 04/19] intel_iommu: Fill the PASID field when creating
 an IOMMUTLBEntry
Thread-Index: AQHbQjJvXDmiXC52f0OTAvckNfcVmbLzXN1w
Date: Mon, 23 Dec 2024 05:50:29 +0000
Message-ID: <SJ0PR11MB6744CEB446CE24277E7CA2BA92022@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
 <20241129074332.87535-5-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-5-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6857:EE_
x-ms-office365-filtering-correlation-id: 3437826f-32f5-4cc9-cf16-08dd2315b523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0hzQTRvZHB0M3lTK09vWFNkN244cFU3cGx1M3kwNjFyRmdsYXNUb3F0d01y?=
 =?utf-8?B?K3NiMVREaUd1UTRFbUhtbHdZUTEyMDRhdjNRdzRFbFFXa3RRbDVWcExXYkk5?=
 =?utf-8?B?TktXYjVlZ3JkMktDSjNrMXhpTk1INzdwdkdRc3JXQ1dNL2YwTWJzQWRNZDU3?=
 =?utf-8?B?elF4Njd5TnBKN2ozQ0U0MnNTeDg2THJPYU92SG5nOUNKL2g4U2pXcEVhak5m?=
 =?utf-8?B?c3dNbGdraDdkU1VXZXpxZnVMaG8rbFp1NDBkb25oUTR5ekwwUFFvRDljN0dz?=
 =?utf-8?B?a0VVNytvRlFpS3h1eXJaVTBKSW1yRTdhZUNQRmRZcFlraktBMTFCMmY2N0lE?=
 =?utf-8?B?N3VOM2ozZTVPdHJBVmJ3Y0JXb3BlT1N5dTAyMkJNc1V2TmJQcXpTWnVXNkZ0?=
 =?utf-8?B?ckZrMGZLUU9aeGhlR1p0RXJVL3RkZmtSSmg4N1dZaElGbWNaTDJqZXRzbkdR?=
 =?utf-8?B?T3kxUmxEa0h6RnF3anJrQXZEMDBDT2ZZUk5xN2hpL0cxSit1Y00wOFd2Q3Vk?=
 =?utf-8?B?WDkvNHdHUTloeFM1SnkxeUt0UEtPVVE1Tzd1VDhma0lxNGwydUR6ZGZRTjlz?=
 =?utf-8?B?aGVEbFI5ZjBwTER3TWJzdU8vbTJvcmRUM1d0emRKcTdxQWQyS0JleUI4OXYr?=
 =?utf-8?B?aExmclRhalA1eisxbXNwMGNzek93dU9pbmpNK2g2RFdIczVDSFF5N2xrQ0xt?=
 =?utf-8?B?a3ZIL2k1a1IzNi9TZHVndlYvVDNlcVNPUHo1YStQMDlYTVhaOXVPV1hKdXov?=
 =?utf-8?B?Lzh4bGlQbThQUkJLNzV0UXU2RThUZENWMWNyNWRQSUVmYndzNTZ0WGhtd1Ev?=
 =?utf-8?B?TmJCaFF0RVBhTzZxKzZSZCtISk9OR0lXbE81SFdEYjd3UlZXQVZTVUI0bEdk?=
 =?utf-8?B?L25yNU1ldFNpdTY1SHJzTGdkdUNrOXYybnN1OGNOcnZscUxDZHltL2FoUWJE?=
 =?utf-8?B?WkNFRDh2TmErM0NDVTI0UFpkZzhmZGJvSHNkd3VRZDNMZWhVbGh1dEFwSDdB?=
 =?utf-8?B?S1gvNTlVenhaNkd3SjJ0OCtxMFRpVEFsUkhqdFBXRXJjRURBcXFzcUVCbm5M?=
 =?utf-8?B?RzRCaUl6WGU0TlpzMjFMTWFaNngwR0pTdHpOVVF1Y1BHalFqRGtTSU1GZHhs?=
 =?utf-8?B?SUhEeXFOQUpGay80OWNyZkFYL1lGOUZUa2c4WjlPeEZvWFNuNEs3UzkwbEQy?=
 =?utf-8?B?Q0FDYmx0R1NQRWwwSFB3WGY0MXY3aUV6OHFKN0Izc3N6TzNkUTE1OWJPMEdC?=
 =?utf-8?B?UXh3S3FkZmpvc2xQSXdCeFFMSjFxRTFiUDlRblMxbFE2Q0lIRWlrenZtZGdU?=
 =?utf-8?B?UU9wQmxlQ3Z0amRCUzBxbEhqMWZHSTRGTXdtZnZSdjdTcVB5OWJDYlRpZFEr?=
 =?utf-8?B?ckVJc0ZVT0FsaG16VXU3bGxJN2syWHpsTThCUFpGcVdtc0UwVmtRWllNRlVr?=
 =?utf-8?B?bXpGemFNNmROcnhzMG4wTGREMDBLRWFDemxrUDQwN0NtdlZTcGRPMDBVZ2lD?=
 =?utf-8?B?MDZFai9TSGxMVzh5MkJaWjBhVHlZd1F0cWx3b0o0VmJIbXlRQVBhWFBaaGNa?=
 =?utf-8?B?em1FTXRublBmRzNNM3VrVEJuWDUzU2svY1NxUHo2K2xKZGVvRDBMeDFHK1Np?=
 =?utf-8?B?VGwyMkdsbXpvNmU2V2R2RkcxcmFIbHN0clBkN3RjTVBkcjVUZXpURysrWXIr?=
 =?utf-8?B?OWFzQ1JZc2ZnR0MvYWVrY0ZKUVlvS0tQanJ3bGhPTm1QaXNpM0pyQTFUTXcw?=
 =?utf-8?B?SUx1ZkloT2NQUEx5Rnh2bGphR1JOVnFnRm5NQWtmV0RTNjJ2d2grM0NsT21F?=
 =?utf-8?B?TnJsaXlVL2wwVG5aMnFFNkFkTHF2NDVXMzFLZjJsUVhtczF3MTNaQ2R2eW04?=
 =?utf-8?B?SC9IK1RzOGZlcVExMGJCSWRIZnNTaDdjKzEwZUVjT0l1NVp1WjBRMnE3Vkxs?=
 =?utf-8?Q?mJ/ZtAR9BswvszDB8A87qtRqS+4vt4eO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJQM3FsbVFKbE5sNDNHdTdpaENzS2tleDd4RjZZUTdrNVFha3N6UHNlc3JO?=
 =?utf-8?B?bmgxeTg4NlB6YWtkRUFyZjRabjkzWm40aUYvZzRIejkrRlZORTZvZFpuODJ5?=
 =?utf-8?B?eFV5WnA2YWpjYm54SzhIY0YyeExabi9meGU0R2JJNE1FQnNmL2hMTTlyZW5B?=
 =?utf-8?B?WE9YY2trQVJlMENBQkV0M2NsZFdRQ0pKeDhVV0c5WGY5TVVLczd2TytVa0lz?=
 =?utf-8?B?QmdWdDh4RDhPbDBiWWdrTDcyTi96VHNjZmNMUFVoNmJmcmRsdk5pNHNYVUp2?=
 =?utf-8?B?T29nNkl3VlhmUHVTRWFyZ3ZFdUlMaFZ1eEFaa1AxQWpaNy96UEVkeU5pTVh6?=
 =?utf-8?B?Uno5SkxpQ3BjZWE0NUdzQ01vQlJNcjZTUHA2NjNYMUsxUys5TDBFUzJRQUxm?=
 =?utf-8?B?cDVzcVZpYmMweEpGOGgvcEhFR2dnTm5JVWpDdDVCUmlockJqVDVHZkRPWTFR?=
 =?utf-8?B?bTJHcWdGZ1pXcTBhaE5LWFpzWHQ2RE8ySUFXY1pZeUkvSDVIZ1dVVk5SaU4x?=
 =?utf-8?B?VHZXeDlFcGtOZS9NWi9Uc25laVN4MUR5Y1ZIbC9JSWI4bFczeUNvMHhNOExU?=
 =?utf-8?B?b2JSMXJESThNOHpOVENNQlVxTTBjM1J5bE1pYnplR3FSbXRJKzZuaG03dzhn?=
 =?utf-8?B?SVY2OHhGZXNROEhFQ3lkV1ZkQmJ2MXlQamp1QitpY2d0a2lUdzVrUUpOTUZC?=
 =?utf-8?B?VFFDYTNkTjE1RG12Y3YxWkNIeWJwaVowZ082Q3M3WkZOMHFUZW4zdGJoWkls?=
 =?utf-8?B?dURvWmNwWDNBZlJhREdjMXdjOXF5WHNiVGkybjVGeWZRV2hyYWdjVExaZks0?=
 =?utf-8?B?aWJTUUNQWi9qSnNnVUt2SytUdHhwNlYrQkJRY3FLSVorWkRLbFFDTjYvbDdP?=
 =?utf-8?B?YTF1QzAzaVQvQVVTWE5jb0tRNzhoVXUvQWZyS2ZrUkpDMVFET3RlaGRpU3A1?=
 =?utf-8?B?NWZSM0JQRzdFVHg2S1ByenFEZVdPNkwzMGtKMUZHSEFmTmV4QUJPbDZ0RjdI?=
 =?utf-8?B?N3VSUkk3VjN4QVlXanQ0d0laNlNQMmxzZkVJS0wvTkYvMUEvWU5QdzB3TnZh?=
 =?utf-8?B?SmhwYmRMWVhyNm45Q25qQ0d4bnZVWFJYMXVRMTlpTmtYb1JSZ0ttWUc5ZkEv?=
 =?utf-8?B?cCtZWkgzc21YcVRFWG92Nm12WVExSG1hcFRzRTdYbVB1dGV4RmVGZzlKUTNJ?=
 =?utf-8?B?LzJ5KzlRcUpMSHdTb2RjRGltOUthT085VlN6NnR0UDlSMFNqNFlCcGQrZDRX?=
 =?utf-8?B?Z0VBN0IvZ1NiRFJ2ZlcwQ3FKTUR2RE1TKzVianZzVjl1d1NIQzVtZGtPajNr?=
 =?utf-8?B?Sk1uRUdhT3k2dVdoRjhTZXJBZE9yRmw5TWZUYzhCNlJQUFNaV3FnYWxzQndX?=
 =?utf-8?B?MlM4UkJCZGIyMzFkUkUzNzZtZ2d5NGJHYXhyQTlwWEh0RjNNcXU1enArY2JD?=
 =?utf-8?B?TlAxTkRBMG96bXEydEVyWkZIUFVIZEUzYVZ2eE5jVGF1d3pGV3B3bUkybHpu?=
 =?utf-8?B?blhCbE9NcEZoaXZPZnFwZ05zK0c0MkQ4MDBnME5PVmc2RXNIU2FBVkVpc2o1?=
 =?utf-8?B?NzZFMGdCOWRiWVlsWnNnbW5vU1o4RWdjRUxBNzc5b1Q1T0k4RmdnWmFSNzk5?=
 =?utf-8?B?MzBNNDFMZW5BN0Y1RENjMTZpekI5OGlpMGM0YU8yUzhXV1VHNmk3ZlZoZ0N0?=
 =?utf-8?B?M1hpNmZBamRiK0F6Wktwa0RRaFIwUG8yTkhaaGE0MUg1b1ZkSitsZ0xOUTZS?=
 =?utf-8?B?UUhwV05hUEhIaGhpdjJWUDMxZm90Q0lmMmhYOTN3eFkwTnI5MVJjejZvUXM2?=
 =?utf-8?B?cnBqeVdEWXVlRWtOSFRQL3VrNWZrZlR5THBXbnJEMHp2bXMzU2VLbzBMZ1VR?=
 =?utf-8?B?MXk2SHBMMU5zcHh0Ty81WWNld3NZenRsUlFEOGlmZlduWlNwYXJmWVU3S1Ri?=
 =?utf-8?B?MGgyWjMyMjZiSUx0UHdGcTZzTHYxWTE1MWJidzdaM0x3NW04TDR4Zkc1NkZs?=
 =?utf-8?B?YWZ4Y3hCVnI1VW5JSm1tVGJKRFdzVUQ3TlFsQkkva0FJa0tXcHpJcU9hdEJh?=
 =?utf-8?B?czhyQ3kzMXdHSkhIQkovMkttcEtkeWxhWEdpZXV4bW5MMzYxbzhSOTRzYVJ3?=
 =?utf-8?Q?jOyK+2Sjg02KvDcZCjsh7x0pZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3437826f-32f5-4cc9-cf16-08dd2315b523
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 05:50:29.6219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wd2DVcrJocsYTvozwDKIcEoTkU+jqG8j04RvBhGIuNkh+/DT8bgIwyS3IYgGggS7NcvBrU46rXnjRQzvN8micQFVsYHH9oe7L9JkEK8RgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TdWJq
ZWN0OiBbUEFUQ0ggdjEgMDQvMTldIGludGVsX2lvbW11OiBGaWxsIHRoZSBQQVNJRCBmaWVsZCB3
aGVuIGNyZWF0aW5nIGFuDQo+SU9NTVVUTEJFbnRyeQ0KPg0KPkZyb206IENsw6ltZW50IE1hdGhp
ZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPg0KPlBBU0lEIHZh
bHVlIG11c3QgYmUgdXNlZCBieSBkZXZpY2VzIGFzIGEga2V5IChvciBwYXJ0IG9mIGEga2V5KQ0K
PndoZW4gcG9wdWxhdGluZyB0aGVpciBBVEMgd2l0aCB0aGUgSU9UTEIgZW50cmllcyByZXR1cm5l
ZCBieSB0aGUgSU9NTVUuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJp
ZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+LS0tDQo+IGh3L2kzODYvaW50
ZWxfaW9tbXUuYyB8IDkgKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KykNCj4NCj5kaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+aW5kZXggYWFkMTMyZTM2Ny4uYTkyZWY5ZmU3NCAxMDA2NDQNCj4tLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj5AQCAt
MjExOSw2ICsyMTE5LDkgQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERB
ZGRyZXNzU3BhY2UNCj4qdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4NCj4gICAgIHZ0ZF9pb21tdV9s
b2NrKHMpOw0KPg0KPisgICAgLyogZmlsbCB0aGUgcGFzaWQgYmVmb3JlIGdldHRpbmcgcmlkMnBh
c2lkICovDQo+KyAgICBlbnRyeS0+cGFzaWQgPSBwYXNpZDsNCg0KU2VlbXMgdW5uZWNlc3Nhcnkg
YmVjYXVzZSB2dGRfaW9tbXVfdHJhbnNsYXRlKCkgYWxyZWFkeSBhc3NpZ25lZCBpdC4NCg0KPisN
Cj4gICAgIGNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeTsNCj4NCj4gICAg
IC8qIFRyeSB0byBmZXRjaCBwdGUgZnJvbSBJT1RMQiwgd2UgZG9uJ3QgbmVlZCBSSUQyUEFTSUQg
bG9naWMgKi8NCj5AQCAtMjI2MCw2ICsyMjYzLDcgQEAgb3V0Og0KPiAgICAgZW50cnktPnRyYW5z
bGF0ZWRfYWRkciA9IHZ0ZF9nZXRfcHRlX2FkZHIocHRlLCBzLT5hd19iaXRzKSAmIHBhZ2VfbWFz
azsNCj4gICAgIGVudHJ5LT5hZGRyX21hc2sgPSB+cGFnZV9tYXNrOw0KPiAgICAgZW50cnktPnBl
cm0gPSBhY2Nlc3NfZmxhZ3M7DQo+KyAgICAvKiBwYXNpZCBhbHJlYWR5IHNldCAqLw0KPiAgICAg
cmV0dXJuIHRydWU7DQo+DQo+IGVycm9yOg0KPkBAIC0yMjY4LDYgKzIyNzIsNyBAQCBlcnJvcjoN
Cj4gICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPiAgICAgZW50cnktPmFkZHJfbWFz
ayA9IDA7DQo+ICAgICBlbnRyeS0+cGVybSA9IElPTU1VX05PTkU7DQo+KyAgICBlbnRyeS0+cGFz
aWQgPSBQQ0lfTk9fUEFTSUQ7DQoNClNob3VsZG4ndCB3ZSBrZWVwIG9yaWdpbmFsIHBhc2lkIHZh
bHVlPw0KDQo+ICAgICByZXR1cm4gZmFsc2U7DQo+IH0NCj4NCj5AQCAtMjUxMSw2ICsyNTE2LDcg
QEAgc3RhdGljIHZvaWQNCj52dGRfaW90bGJfcGFnZV9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElP
TU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC50cmFuc2xhdGVkX2FkZHIg
PSAwLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAuYWRkcl9tYXNrID0gc2l6ZSAtIDEsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIC5wZXJtID0gSU9NTVVfTk9ORSwNCj4rICAgICAgICAg
ICAgICAgICAgICAgICAgLnBhc2lkID0gcGFzaWQsDQoNClNob3VsZG4ndCB3ZSBhc3NpZ24gdnRk
X2Rldl9hcy0+cGFzaWQ/DQoNCj4gICAgICAgICAgICAgICAgICAgICB9LA0KPiAgICAgICAgICAg
ICAgICAgfTsNCj4gICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11KCZ2
dGRfYXMtPmlvbW11LCAwLCBldmVudCk7DQo+QEAgLTMwOTgsNiArMzEwNCw3IEBAIHN0YXRpYyB2
b2lkIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2Rldl9h
cywNCj4gICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KPiAgICAgZXZlbnQuZW50cnkucGVy
bSA9IElPTU1VX05PTkU7DQo+ICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0K
PisgICAgZXZlbnQuZW50cnkucGFzaWQgPSB2dGRfZGV2X2FzLT5wYXNpZDsNCj4gICAgIG1lbW9y
eV9yZWdpb25fbm90aWZ5X2lvbW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPiB9
DQo+DQo+QEAgLTM2ODAsNiArMzY4Nyw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5DQo+dnRkX2lv
bW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KPiAg
ICAgSU9NTVVUTEJFbnRyeSBpb3RsYiA9IHsNCj4gICAgICAgICAvKiBXZSdsbCBmaWxsIGluIHRo
ZSByZXN0IGxhdGVyLiAqLw0KPiAgICAgICAgIC50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9t
ZW1vcnksDQo+KyAgICAgICAgLnBhc2lkID0gdnRkX2FzLT5wYXNpZCwNCj4gICAgIH07DQo+ICAg
ICBib29sIHN1Y2Nlc3M7DQo+DQo+QEAgLTM2OTIsNiArMzcwMCw3IEBAIHN0YXRpYyBJT01NVVRM
QkVudHJ5DQo+dnRkX2lvbW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3
YWRkciBhZGRyLA0KPiAgICAgICAgIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERf
UEFHRV9NQVNLXzRLOw0KPiAgICAgICAgIGlvdGxiLmFkZHJfbWFzayA9IH5WVERfUEFHRV9NQVNL
XzRLOw0KPiAgICAgICAgIGlvdGxiLnBlcm0gPSBJT01NVV9SVzsNCj4rICAgICAgICBpb3RsYi5w
YXNpZCA9IFBDSV9OT19QQVNJRDsNCg0KU2hvdWxkbid0IHdlIGtlZXAgZWFybGllciBhc3NpZ25l
ZCBwYXNpZCB2YWx1ZSBhcyBhYm92ZT8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

