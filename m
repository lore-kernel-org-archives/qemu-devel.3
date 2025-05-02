Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415DDC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmas-0000f8-1l; Fri, 02 May 2025 05:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmaq-0000eq-5I
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:22:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAman-0003Uz-LK
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:22:03 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5424RlTX011364;
 Fri, 2 May 2025 02:21:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zEpMfMo8SKrpPg7dM/2I3A3asgf1JpX9ibHPiqXFa
 10=; b=EkvDYqZFeb8DzSJiotS+GWXxg5YhkDUR3AsyLN8vBLR7rLkMKWeCAW3KW
 7vPejEOKUWi6s8N252WD9j6VnI1xyCbTy5nKEbl6Oj2DUSKvFJMMtOzzzN8lJSd5
 QxX2TgIE/CmOTI0mp4PPVKdUeK+gQO9Skg6VS0D/GFRMNPt8+Uz5v1W9AloLwsDv
 E6Y5OSh3h4vYxCJlNPrnbF1phK0sM97/MDAaFk2X5yB3D/idZWSHly37XRqZ5ZOD
 0cZO4TQ0rZ24eB+hkDktLuufCY4/FByR4A6VvuL9AlgB5wOWKoGx4vySU4Rjv0Cv
 3XXZKnR/Fjbzc7Ub2oCHibbIEy0bQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468xtbnwyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux8wE1Nu+cdjpIvpwGCFZaFyWEh766VzXU4orNAIu6tzMNbIn4f7aaxEdliEmaZUSLYRLePXW89Dq9nTakD0c9RzfFK+pz7ec7wHmo2X9g6/M/IcYM+64M/kf8fozzmylzcBHC4ExlTSgEEWOvtCdSuACqb8gd2edPsNAd21VgK0C/bSGMynQEZcjsr0JAltydcID70kBGJZCDqMuIAsDHUCP+C+XIRMJcExbEYX8Dk1nzvzKNECxWdKeLjt1X2NR5e051G3n2FSHuvSopSYJzEvvD8gffTcgkYcUBSxfW4WhpXGzOQmrwaLRvKy/9rJ1lU33T1Xm3Iu+W5JVHqK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEpMfMo8SKrpPg7dM/2I3A3asgf1JpX9ibHPiqXFa10=;
 b=uEBoLPAxj9j6kYPn//Sq3eldg7iKKrcvH66BM5dL6qWfh6rrL88UtmOYSDtgYmNjpm4YdTVJD/VikolmaN5F9/NE6aGme5s+kup0IIHM6IpQKmo2FiGqDsCtxgElTLXlRGXnidztnLvCGnJWkzHElfx9al4spl0mtT3Q4Pket3heGPLznsLLkxunA81Hkp2AUh9xtTBTrdOhxiI8ctrB2pZB4HL0VLMkb7anOsnm90K1dwO/4HJQSDVoB6UGp0W8GU3CWLf/KsnI7bhlhgXtUPQ89AGBWSiCVm9gPXTnIrWjGLlc8WBAfBCDbn53uB7DJqyYwcnJKNM8AbsUtDh7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEpMfMo8SKrpPg7dM/2I3A3asgf1JpX9ibHPiqXFa10=;
 b=toAQP9KdoSHAfM49fTNhrUph8KY9+p30xmwNArXs7dzTZzMy93htrsn+ppbOZnSNoPgH0lFx6NYE7hyobOWw0UowFYfSKkUeOnibajyfydmz28HMEkqA2/lWrw8/vVoGh0cfJ4con/29nSzyS3w6b4HBIUvblHLJSecUtf6JnLHQCak7w1lQDxVF/lj//SUE1mtZlRs5jrFI/HBYWQDv5i1ktpADuYPpCkIHvBdK8KUTw5aILBjNscX9VERz2ZlScCRlg3HV6B6WKGCN39ifzRPXjrzEMS58mONDa/nX6kZxuyhrLUWIP5M6Jlf5HRimos/cxAsJTNEeFmErYYlKqw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:21:41 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:21:41 +0000
Message-ID: <1bdbe062-58b4-4945-aa78-4a580ae12259@nutanix.com>
Date: Fri, 2 May 2025 10:21:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] hw/audio/pcspk: Remove PCSpkState::migrate field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-11-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b8f1e4-eaec-4e12-0ef4-08dd895abfcd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWR6M1lYcWFMMkVLbjdLWHdPOU1sZjlBdFpsWE5aZVRNNEUxWDVtTGRZOEpj?=
 =?utf-8?B?KzNobmhvcDREbGNwSHZMZFczRHI2aGxpamE5SjJvMEI4a1d5cS9tQW9SMEkz?=
 =?utf-8?B?bHVjVHBSOVhWSVl2OUh5L1BHd1BDRXNqaDJDakJwSnZMUTdxM0xJZTRYbFA3?=
 =?utf-8?B?QlZXYUZWRW5oU1RZdVZWVERWakxkeHNiMUhBY1F4d0diakhCQy9mK1dKSVJG?=
 =?utf-8?B?UmJMTWxtRFlHUUhxRG02OFVWTFpKLzNSU0ZFUWUxTGNjdXcwcTErL0o3Y0tp?=
 =?utf-8?B?VTFhdTZmNjk3Qkx2Nk5GR21GVnB4MFF3OXE1YkZrZFovWUw0RThFL1dseGpP?=
 =?utf-8?B?TTI1aUVOelp4elFDSjFpbi9GRlg1OXkvL2tRTTg5R0dNVXFpaERnaHNoV3RO?=
 =?utf-8?B?RUFTeHI0bEJhbERTa1pMUVhKNlZZUWVDalhwc0JhdE5PaEdPQzMxYVE2Uzl0?=
 =?utf-8?B?YkxremFGUVRCMDg0ay9BYi9hOXRBSTdwNG9oSUJFdmozSDVoMXNPc0dhT2Ji?=
 =?utf-8?B?eXJFcGMvQVAyL2JmTnJlaWlnTGRxbnBBVmkyamduR0c4MENSMlJKSkxDQWJC?=
 =?utf-8?B?Z1RRYlNBdUJHRkxVRHE1T2xDM01RUjQvMTJzUDllUFZ2T3RHL0Z4dHRmdGRw?=
 =?utf-8?B?dVNONURsMStqZEFPV0FRRlVHMnp1TkZ3VmhyS1EwM2EwSjF0akt0QzhpbEow?=
 =?utf-8?B?SExCRWpWLzNQOENFSVNKdUoxWU5FL2NqdjdjdGNZcldpMVZISURCNDdPSVNt?=
 =?utf-8?B?QjhCQ214YUtKeFhGWmRINU5iVUVqQ1BENXpIVngxdGN1MjIzTThPRkw1ckVD?=
 =?utf-8?B?NnIzQnZCK2RUZG51eWVOTml2VzFoaDJDb1prNTJzck9sdHZVZHFZVnBLd0dT?=
 =?utf-8?B?cXZ4blRqclpXdndyWlN2YmRyRmQrUEpyWVFrNDZJRythS09UM0hneXN6ZElt?=
 =?utf-8?B?Z2djUUpxT0RqbCtLS0FCTDhMZlBvQURPMVpzYzNUbkU4MVZuQk1hNHZxbng1?=
 =?utf-8?B?VUtmK3Bzcll4YjZ6Znd4NWUxTWdMMm5oVzhRdHI2NEd0RzUyUmZraGNNUjVK?=
 =?utf-8?B?YmFyQUFkNy9yUWZnVnM1eEU4ZU0zQTgyaW1VRG0yV290c1hQazlkS05XdzI1?=
 =?utf-8?B?UTFnRE9hZG9kQ01ZVWsvSzdjNXNtRC9aYW5JWk9BTGRPdG9sdFF1anJmVTN4?=
 =?utf-8?B?MzFrZS92ZnBwSjhPa2hsWlR6aTVyRDhnc0Q0N3hzOTZPOWdPOUtsTFVGR0hH?=
 =?utf-8?B?Ukl3YmJkY3dLdFZyNHRJRGlFYXVWK1RKWGpMcGpnL1NsTHJBdWpaclVudG5B?=
 =?utf-8?B?NmY2S296V1NLVE9XOG5CczNjV1czREFuRDZMQ011UWUxYlliamNzc3o0TURP?=
 =?utf-8?B?YkFzdDZiTWh4ZzRXUWFiTm9lYTdzdXdDSE1pUFhsd2t1aDl5bXhnN3p0VlhN?=
 =?utf-8?B?OWFEV2Fmb3FRakxpOU1mSW55eGpxQnVhNlJvN3M4aWl5TFN6Q2JVUTRtT0I0?=
 =?utf-8?B?WXlPcU02WGJZL2ZPdlVjaXJNTzZmUEo5L2MvUndqUEdCa200emxrWVlOMGVN?=
 =?utf-8?B?K2ZER05GWjZwNEpJVEJVYkVqT3pVWW1JT3Z5WVhGRnRuK1lvRUExNjBuNC9z?=
 =?utf-8?B?UUF5T2NzeTVKdEhkWTZJdnVuRXlNN0xyaHlFTHhUbGcxSklrZzJNREQ4bEhx?=
 =?utf-8?B?NzluWk9UVU92YWEyTEZuSDBhZlBVa3NJbzljWmI0YjdNMEl2R2VhTVNNbTha?=
 =?utf-8?B?R3lFQk9YOFFxazZFcUEyU3lEZHR0b0pEekNNYTBKWUpTVnBFdS9WQUpWMEQ1?=
 =?utf-8?B?Tnl2Ty8xdUpXUHpZTHJVTFhYNWJBR0tjb2d2OHJSeGpxRnVmaDlGcDlLelVX?=
 =?utf-8?B?TVZoUTVPUjEyR1V4VWQ4UUtRK01lVFM0c3llQWNLa1dhc1N6RnNsTDhjZTRo?=
 =?utf-8?Q?H5eqirnJugM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzk1cm5PNkVzWDZUU29QOXk2d2R1aTAzNlU5UkRpL3VpaEEyb2tPS0RJUVlK?=
 =?utf-8?B?cTRzRnE5VzBDSDJnYkc4dGw4ZCtEVUZvUlArQS9SZmk2M3FPUVlpcm16aVhh?=
 =?utf-8?B?QW9vUnBlcUF2NjBISWJod0hJL1pkNm4yWmN1aEVTcU1KWmlIaktUY2ZjbERo?=
 =?utf-8?B?ZTZPWVBIRE93VjYwcDRaVGhSeS9BYS9JQmZ2UWhpaW9VQ25wUDZaSXQwOGhm?=
 =?utf-8?B?TGc3d0xxSFBGM0pnMlordjZSeGh4NXUwcTQrU2hlVlQyemZmT2s4eGdIRnJQ?=
 =?utf-8?B?ZVpWeHY1c3hqME1XQUkyWXdQZGRWTUh1QlVDODVKL2IzTEt6b2NYSFAra2x1?=
 =?utf-8?B?dlFEMjhxUU45T1lEbkpWTWsyY2F0MmZFbDl2RzYvaFJ6VU03b3ZYbnIybDN1?=
 =?utf-8?B?UDdYdTZtRDJ6TlhlQytHTlAwYktHYnlWdEViWmNVd2JNWWlKRS9CSlJCVTJ2?=
 =?utf-8?B?UzZFTUJvUytFdktVamNwS1oxdlRjR1JseHlTb0ZyQ3NQWGtUNW1OUk9Rc3Zo?=
 =?utf-8?B?TmpSVEdDaXliZXRya3RoSkdZUGtnZEg4UFZBVDBEZ3l4OCtlZTJid0JaeDA2?=
 =?utf-8?B?T2lneG9BTFVmN0JJd0wrN09vTUswK3N0SS9GQjl6b09oQ05NWUJNU2d2cVE4?=
 =?utf-8?B?bWFCbWRlK29kWXJ3VlBBYi9zaTNwb2lwbkhRRHdCK3ZvT2pPWEp3ZVkyN0VB?=
 =?utf-8?B?bG0rNHJ4NDBGQ0JVVzZTemp4ZXFlNDh3cHJpNUMzR3dJRWtUWGZld1ZGVkpH?=
 =?utf-8?B?U2lTZlp6SndJVVBsdWZkOHlsNlp3eVBtK0pHcEFoY3dRdGNiVzIyMVZZMEtW?=
 =?utf-8?B?TkxJdGZVWXlUY29jdkJxclNVR1R2VGkyMkdVY0lPL2xUWWJzamdqWng0WGxj?=
 =?utf-8?B?RFVVbU1LL1Z5aG5XK2x0ZVJZQ096SVZIcFNaWmNaV3NMRXpjUWlSL2EraE5I?=
 =?utf-8?B?Ti83WVZjcnpKTWNoVGVJZUc4NmhDM0VFLytpcng2UzM2a3BnWkF0c3RjNEZw?=
 =?utf-8?B?TEFzeG1lL3VaYTVidFFOVzBFckhPODUvMSsvMTM5Y09saEtzN2ZsOXlON09h?=
 =?utf-8?B?WmhHN29DY3JNUTlYL3czM25OTVZWbisrejF2RVJ4clBkaUF6b094REZJbDZj?=
 =?utf-8?B?L1dSWm5wTHNBRHBMakFkU1l5OUFDbUxKWDl2d3ZQUnI4VWpueFZWRFhyMEQ2?=
 =?utf-8?B?MGZ1NTgrd0VqSkV4ek1UOFU4RTJ4MUZWaFZLL1JmT0c3Mm1WUVAxV0thOWpu?=
 =?utf-8?B?MGc2RGZYOUlhVTUvaTZqWHc1eU5SS1BDU05XOFpWRXZMNGkvY2RLYk1odFNn?=
 =?utf-8?B?L3ZWV0hidEpDL1h6cm95QUZXV3Z4azZwQ3pPWVlPSXhScHNSVHNnNStxSDcz?=
 =?utf-8?B?eWhncnlFeXFJb3o2K2VZaXNQbGF3MVNwRXFMVUFKcFAzeDRYaWgyZ05pU1BV?=
 =?utf-8?B?bWNXU1dkRkFUTmt5emdZdUtwQWdRalJ1R25DamlyU0p5alFZaXV3TFd1cmw5?=
 =?utf-8?B?ZnZkakR3cFhKdWZCeFl5ekRNY250OEhVRGlKL3pZeVpwRFhBTUM5a0VmRTgz?=
 =?utf-8?B?Z2xNNWtCdHVkSmhyNGxhdzcybThwUlg2eFhOSlBVVEdCQ0w5eFFuYjVLOEZC?=
 =?utf-8?B?RFJLcmNIOTJpSXBVOVNiWlZCQ3NPZ1ZnaFJCR085OUtobzEzQVJIYUd2WkMx?=
 =?utf-8?B?NVpMMm9sbFd1QllYV01lTlZISGZxaVU1cWczcGFFeUZFd3JvRmx0YSs1SURR?=
 =?utf-8?B?NDJqeW8vT1BMQjMyMGtLOVpZZU10YTF1K1lHaHd5cHRrbG1IU0dvY3NtdE1w?=
 =?utf-8?B?cWk4NlVuUjk4dkcwSEx4Z2VIWEZsUmhjVFQ5SkZBcXZUcDgzbElaYUt5OFMx?=
 =?utf-8?B?ZDFROEttSHdPQzJXRmxhaHBpakZWUUhqZ2pUY1ZPTm9QWHhTa3VNdUF2Y1Nw?=
 =?utf-8?B?cWw1RUZrd3pUaVArOXJlb0lnQ3BMZVQwRWYwcjdncGpLbWF0aDZ4cFdFUzFZ?=
 =?utf-8?B?TXVya0FNRU1uTUp0STY3c2pJRXNUTGNUbU9MOFl2ZVcxRkRmdjhPUDhjTnVX?=
 =?utf-8?B?OWlKZFo2Tm9wcjJDRnFJbWowaVpyQzhWU2hjUmFSRjZtT2gvRUN6TWsyQWRY?=
 =?utf-8?B?YkZmU3Y1Y0o2TC9scnA1WU5mK083R1Yxcm41bXpXM1pPbmx0cjhrNHAzdjBp?=
 =?utf-8?B?YzFaVU9STHEwNmxDSjZWZmFhZDBWTHU2TTdIQVZFR3lvOTRRUEk0Y3dxMnph?=
 =?utf-8?B?aXM0bDR1eHR1Uy9SbTZNYlZWRUl3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b8f1e4-eaec-4e12-0ef4-08dd895abfcd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:21:41.6578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUO1te3yGE0DgOAByWK2T9qHjOlAH82WgBDdXzWrCMN8AjtflX+Oy/tmE6rA4inMHNB3OYjO9T7zwVJEXeSCVe7iLweIwjitzViFlDNlMX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Authority-Analysis: v=2.4 cv=QLBoRhLL c=1 sm=1 tr=0 ts=68148ea9 cx=c_pps
 a=BfiT+f4K8gVEfImFRIf1tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=V1JMwzO6omIvDfnQkcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bxr2Up9bCgJD5g5LkDb6_5yztu9TkSW9
X-Proofpoint-ORIG-GUID: bxr2Up9bCgJD5g5LkDb6_5yztu9TkSW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MiBTYWx0ZWRfX049hnWK0MnzD
 JM6NZaiUPocFKO/RyIHAjz8d+qUj3F2POydUA0bgeJHCSjKTUccFPJk2mQUBII0UeVoTHMClbUI
 Vf1wuczYMNb5vW+qXo4SDZwxHriIQp3We3xuwBbOqIm+NoPCJw8WXnYQSQja/+/fLAFglxdduhK
 hL0NJnzW89As2sKZgZBOk7Yp13DIW8PQIrDgbA2E3yQ0tw9zR7v0hJHGwcLrIpMMcQd5IZ/VPyO
 IhBq0KqsBXbodzD5OFLPe/70Xkt+kecqbsKqx3F/8lhBfXIpET96ZlTKtGMvBn2saSnjrWL0pNn
 yON7p9sZ8IgEbrBp2kbcTcdxZMF2amIcZY4bpPI1X4ZNvcYiKaz5Au4OP+oJgf7VJ0FQIVXlAiL
 G6Z6eQu3Wf5Ub+Fqk5yHSt1t9ryFVJ1lp3NguxAW3lLbwKZqvo7p59VVJGFxydFqZJr5+D0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The PCSpkState::migrate boolean was only set in the
> pc_compat_2_7[] array, via the 'migrate=off' property.
> We removed all machines using that array, lets remove
> that property, simplifying vmstate_spk[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/pcspk.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index a419161b5b1..0e83ba0bf73 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -56,7 +56,6 @@ struct PCSpkState {
>       unsigned int play_pos;
>       uint8_t data_on;
>       uint8_t dummy_refresh_clock;
> -    bool migrate;
>   };
>   
>   static const char *s_spk = "pcspk";
> @@ -196,18 +195,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
>       pcspk_state = s;
>   }
>   
> -static bool migrate_needed(void *opaque)
> -{
> -    PCSpkState *s = opaque;
> -
> -    return s->migrate;
> -}
> -
>   static const VMStateDescription vmstate_spk = {
>       .name = "pcspk",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .needed = migrate_needed,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT8(data_on, PCSpkState),
>           VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
> @@ -218,7 +209,6 @@ static const VMStateDescription vmstate_spk = {
>   static const Property pcspk_properties[] = {
>       DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
>       DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
> -    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
>   };
>   
>   static void pcspk_class_initfn(ObjectClass *klass, const void *data)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


