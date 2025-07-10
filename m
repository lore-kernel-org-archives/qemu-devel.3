Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38EC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2Q-0007ue-0z; Thu, 10 Jul 2025 04:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2J-0007na-BK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2G-0003Xj-RZ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:46 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A2vb2X006138;
 Thu, 10 Jul 2025 01:53:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UuxmDkHlGK2qioIZUCl1D2cQpX9TzTmymVY0PE7L8
 bA=; b=I9obIExIwSgMvxZSAkSxZQTN0Z7dwzsEAQfVOHlaJBCaf93WeC/DyH5VA
 vDLg3iaz5X7Jc8CyEq1Xhz4JEzPQHyu8c3n5meh1vnLjgpccKJQ6F1S7H0/irtOQ
 ExbN8mcTamJI5ZOf9/GHYAjjRSkpGiPEdkT3KYwrOO+d4ghOsSisiTmE7/csHZQe
 E8L/gra4MEa2xVH8O/nLikDkkUPWTP8SXtWZGrWlfshfhbzrfPU235ERTeMk3Cpj
 3Mkp+gsND/bMwGHTPjAsfLk5SPGT4u3/bdcpv2uAu6qj3FD/fjxxSkhw2bT0R5wH
 YJtgh9CEJtiLTq5n0Rt/pRVv+Kv/w==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020093.outbound.protection.outlook.com
 [40.93.198.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHZMkFS+0Z6hw08rFrSrJpNUT6SbQDBC8q6obEnjw9GpKsNOcmSYz8aWYHTzoHitAuh237Ob96llS7hl7PhAd/+4MBYG7WX3XalH45KSBl1sOIgEzz2zrql04A5F6WaSvEX8qZsMUHXWDywB2TrabtjpvrVEFqH+iopSWSGdcFHLAoCw1+2P9hM6kJ/V3C3BhRCMRACFuRYNMSb8eOjn9w68D2I4hNtIIfVqCK+bAnfDUSXL0RY/t2iITKy71iLBAsoGo91bo2FlHWMAR6MhbkHHKR7qLYA6PeA8NTzTL+j6xR9SUW565K/tmcF2ULUpX4DPPB56epr84YWLDjoT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuxmDkHlGK2qioIZUCl1D2cQpX9TzTmymVY0PE7L8bA=;
 b=QOik+dQ+55UYGAb/VsLqgxlHqPQ6jH3q4sXh8o0q7UkuvCJXkEJWlvPZX09J6JADYc8gGSwOPY/EnST5mC+ltXoPpqxwi8M9MqwfkTwwB0GGSeH/jOMwBofspVtAo8xostuPLi0LZrZiL47PKk4pOWgMTMO915uE5AWn7VDekzZpGqM1uRyqcj9hENKYYNuRoBgYJ+P6o5R2RxkP82HUoL5qPMByF5NPKqog/acx31228qkl7YwiDAZYfJw9VWAjOG+Cqx2pgQ3cvwA0oEBsU2GtH3qKs9vZKWpnsn6qd3Qf5nptVK/gv5Ls7CHOEFQhIxj7+zy8UP6msR5cEx8uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuxmDkHlGK2qioIZUCl1D2cQpX9TzTmymVY0PE7L8bA=;
 b=vLNfQM+KziT14TKwKK0FUNPl9pmD2XFyf7QsZnxxwQSLMRCtWsmSXZQqn+CePJRV6LEqvUc0OFA1Fji2Q6hzSfhyfuSG5EyPBSwu8wSblQtHQcaaJEfS1pIIYMR1GxPhmc1km/9Jy8OKTv1d0I0EgBxFc3MIZ1sC9R/xV08LBNNSNhWxRWPYjp5SQkMTU09yaZbsok+3HeulhFci9Cl2U02We3IYK/ZEcYoeityMy5CwNT8wCG482BVhgprFuu46bjupai0gpvOeBnD8sFO53LqXGMbPx/XXRKy1vQoWDwnuUlrtcaBnSh4RADsy5rEtZf7/HVw0YiJ7JlKx9ceVaQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:38 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 07/18] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:22 +0100
Message-ID: <20250710085308.420774-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: eebd1b3a-8bf9-4a31-eef9-08ddbf8f431b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEhFNlBaUHdzek52M1FCYno0eVVaWVprZEFpVjc1UnduSWtYcVJWWkVBV0Vt?=
 =?utf-8?B?QlhHbXBRMlN1QTNTSUNGcmxBVTkyUlg1R3hyRlNjZ3RLSkFpb0NWMTlJRTZ5?=
 =?utf-8?B?QTJ5UlZ5di9vN3dOY3JVTTVLRmgxZ1JTWnBReVJoU2VmajlYMkUyNCtycEZB?=
 =?utf-8?B?V3p0aXFmUzY2eS8rZVZLR2d6WWVnYUk5QVRnMVMxMnNSNnk3NmV5MnlDVjNJ?=
 =?utf-8?B?Tlk4UTFuNlJpZmJ5cVF4by9NZUVvVTlIcTFjaWFmeVZXbHBLMkNmZ3ZpbWVw?=
 =?utf-8?B?R3luVHRzRmYvaTl1Y1hrTkdTcmZuVUloMXhZWnpKdUZUam5vVzRRN2pFR2ZN?=
 =?utf-8?B?YnVwUjB0bTkydS9hMkJqMDgvM3paTTRackVpRGtmOUpwKzhObG1QaW94NXRR?=
 =?utf-8?B?VWxEc0dCNmY5VjlNZk90UEtza1Y1eFdTazZvS0I0Zm9OdllaSjFGejEvejhl?=
 =?utf-8?B?VUhZemI4Ri9SSXpsS3ZkVDE2ZnpMd0tQajNXTVhOQXdiZHJwSG1tVlVRWm1x?=
 =?utf-8?B?U1Q0dklyWjA3TGd5bjlrVHlQNnk5bG9VUSszc2dBbmVDYXhtc1V5S0R1QUNH?=
 =?utf-8?B?M3A1Q2tuNGlyL0N1NGJTMGtJT203MFJVMlBIUEJlNlZrckNpVTM5cjdqeFlq?=
 =?utf-8?B?RjFRQXRvcFp6NHV3dXUwY1RNWEFSOXljdHYwSWdkR2NFUVM2WG0xbC8vQ3NM?=
 =?utf-8?B?Nks4K3VqNnFSeENWbk4vanVFcTNad2dXSmdQQ0dsMXkvRE1oUzdRYW1ScHRB?=
 =?utf-8?B?d2hlUnYrWURUR002Z0d0Z3VqS2VJaU5CVTRJV1h5RjBlZHRRVDd3Z1BQd1E2?=
 =?utf-8?B?ck9ra241Y0t2a0dML01qSDNtSDRKN0VIcEpXMWg0WE1DZ0NkVHJDRTJaVVJr?=
 =?utf-8?B?amhoSlpaNExYV3JPZlRuTUgrcXBCb0tBa0IzQmVPU1BHbzlpQngzMmhUSko4?=
 =?utf-8?B?Yzl2VWQvZmVackJvRGFxZmxRMlJlbGo5RlpQdmpwVTVwK3ltOFprRUJtMHRG?=
 =?utf-8?B?TmI4VVNDV0ZTSkVmWEN5VXg4UlBPckxjYmF6cHNpU3pmbjdXenU3SCs1bENV?=
 =?utf-8?B?cE5tRVI1N0wvZURFTUFVZHRWbHNUTW8xTmdxdnY2Nmp3YU02NkJpOWRMYmJo?=
 =?utf-8?B?K3FCMThuT3Nlb1ZvK0xwL2pMZlZwQUw1cDc5QmZ0elBkZlBhR20zMTlsUFQy?=
 =?utf-8?B?ZXB5TkVvYkljNVlyOTAySjFwODdabGNFeHd1aDduQzA3ZmpNYkdETWxBeXJo?=
 =?utf-8?B?WkdwaHFGTDcwbmVLY08rdmNOTWhabWp1Tk1BNXJvWmNJbFpnUFVPam9ZSXIw?=
 =?utf-8?B?akdVZXU2ZUM3ZjVGTzBDMlc3TUxDa0pMQWgyOWNhS1AvSHdXbnEyKy9VQk9q?=
 =?utf-8?B?K1gvdllhOFM4SElPRXJ6dEQzTFE3L1g1WmZ0L3N2dlA2cG5KNjI1Q1BkSk9V?=
 =?utf-8?B?M2FhRHg2blVFK1lCL2VneHFxaC9DU0VxakwwRFRFR2VBT0dvYVJGQjRkbElm?=
 =?utf-8?B?MGJsR2pMUEovSW5maFJMUUNrWmdVRHdxL2tVZVhpZ01IR0NEUmdYc0I5cFpH?=
 =?utf-8?B?TjlidEh5WWYrRUpjb256QkQvZmhtNjlOUWhRNEptWHpTVGovYzFPUWNGeFYv?=
 =?utf-8?B?c1pvQzdVZDNwZit6Nys1akJybWx2UVpDOFlPVFdXRjRQblJvaERtdjh1eklM?=
 =?utf-8?B?UUVhSWdVY1h5RUI2SzA4b2RvODMzdkJ1Z3JmdUFteEh3ZEtUOTFJNGhCQkw0?=
 =?utf-8?B?NjU4ZUM2OEVSTWordEJqczM1YTF3VFQ0WVdTSStXdU1sTk5TTytSTVJpOXV2?=
 =?utf-8?B?V01hbitKVVJjSFhJejRGakFGZjk3VlJUMExaM1NDWkZxTWhPQ09kZGVRYWx1?=
 =?utf-8?B?WFVZa0lDMHdkTUVSS3hkczVFVGFKTDdTeWVDOG1IU2prU0ZIak5LVzg2ZDJT?=
 =?utf-8?Q?89dC2Pr7CMk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlhdDcrMkhRUkNVV3NrVmJ4QWQyQXFBcWUrNnN2a3ExUFlFb09kNzJ1Yy93?=
 =?utf-8?B?T1hDTXNsamNLSDRRUlJRYVNSc0pOU003TkFRVFZoSlFRTzE2K1JteWdGemcv?=
 =?utf-8?B?czlvakExNWJpb0NHVjQ5OXM1bGpEUTczUkFKS3A5c3FaM29oTkh4VjhKMWZV?=
 =?utf-8?B?UGJoc2h6c3lRdDZRSmovSS9vVlp6WC8yeEVqSWRWaGluRlhOR0FTOWFxa3pM?=
 =?utf-8?B?dklFS1BUVXplYzNKei90SzdqL1JqKzNvMTVhSmZ4bVRVdmVZcURFOURlOVJL?=
 =?utf-8?B?N0tWTDZFOFg3eDRzUUp6RDBTTFVVZyt2WHJLUWs2RWJIMExTYkF6MStEbk9O?=
 =?utf-8?B?VndKL1RUSTlwLzBsQjFkNG1QaUFzeHhxaDNUSDg5ay9KckRGekVuWXBHZnJU?=
 =?utf-8?B?Smtqblo3cVlPVEhkbEEzSHRRSXdaYm5sUUhPczJXNDRUM3ZiUlZMNEdpQUt5?=
 =?utf-8?B?WWhVNmUxZFlzWUNZV2F4MSttS2hPSksxZVZnR1BnWW9aSVFnMmk2RHllSW14?=
 =?utf-8?B?OE9FcE5mVlJONXd1cmpIUjZjSGRvbmp3Ukw5KzZNRnAvZDU5YXZ0MFFUZ1JM?=
 =?utf-8?B?SkpVOE1EMWN1akRPWlhXcUJLOE1CRXNORklhTmFEeHJHY2d3d0lUTzhsdHg4?=
 =?utf-8?B?OU54TDM1S09TY0dISXM2UkxMNk04WkxaTXNCdkk3UUhISjNiL1pEOU9ZQjVT?=
 =?utf-8?B?M2lwTEJhbE55SWt0SFZKbHUvQjZYVDByQi93Vk52RFdWcEVZUURKYnVCdW9Q?=
 =?utf-8?B?YTB0QkgxWXRMT3JGSWZSWXR0M3RLOWFtQ1FieHlVeHFhQlhZbEI2bXVBRmtD?=
 =?utf-8?B?NzdmbU1TTnYzYXJWaitzYUNuK3lURHJ3UXZ3UmNscXBMZ0U5V0dUdmtVTm1J?=
 =?utf-8?B?c1VWWWhPSE1VTmxEcjFVbTIrYkJjR0NWMFBBZ3I2VjJTYzVkckQ3OE5xM2pp?=
 =?utf-8?B?ek0zM0pZL0hnNGFHUTd0a3NPVTBTU1pnZElZT3RPTU1UZXJkUkJIdVVTU1RU?=
 =?utf-8?B?cUFjWStud0wwa1g5OVJuOStpWWVEMmRNT1B2NjRFS1pkclZtTFhEMHdxUjBR?=
 =?utf-8?B?ajBXKzRwTlErakhDM2QvSm40WGdlZVE5Mms5VzFIOGk1MzY2RE1CajIvUWhF?=
 =?utf-8?B?a2FkakRoTUEwbXFmZVJ0bm5iOURpblNTYzVDOFczNTFrcHZzVDQrWGNMUDNl?=
 =?utf-8?B?U21BbmN5b2J1ak4xRzBvVjJBeTFzL01FdFFaVnd3dzdDZGNPbHN1Z3VBRGxi?=
 =?utf-8?B?eTVMa2FUbnpTUTJXNjEvMmErZkt4ZUx0eUh6ZWl3Rm9kY0ovVHJnODJNYkgv?=
 =?utf-8?B?L3FvR1FsQlp6Q2tOV2M1Y3FTRmx5TzZWdkJueFZvd0ExU0ZYbnV2Q0J2bGpq?=
 =?utf-8?B?WUNQMXorOFpIelo2QVNpTHhIMlB5MStLN1p3b29EM2FZUS9KS1diVjIrVDEy?=
 =?utf-8?B?Y1ptdFhMMytUMzUwaGxORUFpWW5WcW1QNjllL2pMWnVieU9adEF0MmZNQ0pB?=
 =?utf-8?B?SkNIWWNIdjBRWlgxdC95T1RKWmVGT3IvQU4rSTN4a3g0YUV6alJwTjFJYUN2?=
 =?utf-8?B?SEZzcnRveEJmVCt2ZGVzSWxKQW94azBPZEJjbkRpUW1zMEdnN1ZHOWFqeTFI?=
 =?utf-8?B?T09PTzVqYUlPTDNUQ0pONU82dWE1UFhoWmlYTHlMeXZxdVAwV29kb1EwK0RH?=
 =?utf-8?B?dzRvUkpJNDAzdU00TEpudzBKVXNyVXRWbTlNc0JneDF4VFJoanB5Ykx4TEVS?=
 =?utf-8?B?SWsxQy85c0lzd1JzOUt2ZXk5dEZ1OWdYVk5Jd3REelRQSE9ja1Z0OXlNbjc5?=
 =?utf-8?B?Nmdrand2dkNmVVNXV0M0Z3N1cEdqODRzMVU2ZFZzTmI4MDZNMEhSWERGNVA0?=
 =?utf-8?B?SEtYcUJvRlArQnBKYTFPUi96cldhZUczNGJUa0V0SG9rS1hlbSsvc1EvRVQr?=
 =?utf-8?B?c2k0NFRwOHFFbkgvT1ZhaW9GT291bHpYbkRWOUcrNWpIR1dWZXhXY3dzYWNz?=
 =?utf-8?B?b3duWUJLNnE0aW1pQkRiZ1FwSUYyZTVrdk1SV3VrcEpZZU8zQkJYUkZHZWg5?=
 =?utf-8?B?UWwvcFlqOXhXUm9NNGxBWEpTVDdxRXFQMjAxb28vcWs3aHhtcWRSSmcvSWFi?=
 =?utf-8?B?RDNWRmk1VUxpMjhDUk5pRERQVzhwZ2IvMDQxTEdPb2xWL3BhcSt4M1h0d3Yz?=
 =?utf-8?B?UWNwcndsN09ic1RGblU2bUU5SE4wSHY5SU9UcDVXVnJRbldpY0ZqTXZiMis3?=
 =?utf-8?B?SEMzVWJFRXRpK0YyYU9IamVMY013PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebd1b3a-8bf9-4a31-eef9-08ddbf8f431b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:38.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3EyrtOjdQ8qkyybgZi9XHLjXZ+BU5z+RfZXoDPSOZtHXf7sXhDatphtw1EyTuTB5SLwXsqsWoMFwxi7nsH/ccW2VG4o4BWq4QHdtQ1KgAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7f95 cx=c_pps
 a=bGwgGCu/CPolCU/HHR4Rmg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ujh50bDcNmnl632s5ONMujABtQxvDw0g
X-Proofpoint-ORIG-GUID: Ujh50bDcNmnl632s5ONMujABtQxvDw0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX2xFBbCmZHsT7
 zyTkA+j17lQPgTFg6yGwMViq4HZZ7PP211eppR0Hy/CPttjFlEvicaLdGKo9eWxCBk4CKGsmWHe
 LTLWC9zNTljvR34pLrXoav8bmVG5Knjlzaz7CVEHtEg3QWbOiQ/h9/CK7bv97DwLT1rhl7y4V3Q
 WYgtlK04W09oC+tzcxNEmBHxRd4SJ9vuYSbzRvVo16PO3nlJwdZPYLxs1yJOJ+3M7yr2563e92e
 VQxuwBlypH5Jp5/TCb9g8EjUcE6O8Wl5F3AiqQajIVTiYPQc08CTTvCRI8njJqrpbqTXLCG3MCP
 qd4BBpg12uWstfFTW3n+LR0QUPpr4DJKSA5Qjq+pjgofT61R1HaBZRNunFYmdln3kyfgxr25lts
 5PYlbi4cBflVZUcl20PeRC1fVRixhUVctfZnR1YPoITh2n07SOlzba8AOLIFxGVhcddmH45U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cbe4b33ba4..2c508f9db6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -573,12 +573,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


