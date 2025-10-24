Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E04CCF9E9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHeR-0003gR-2w; Fri, 24 Oct 2025 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeN-0003fE-Sp
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vCHeJ-0004ME-Su
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:16:11 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59O5892i2480408; Fri, 24 Oct 2025 06:16:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WxikkQdFsQob2J4ycaPz142xLOXoXShEPfytpwZAU
 6o=; b=Ert8LeeVFZOCfsgVOaX7SjVv0X1wyr1SlNsWipaFVkU/IWTXWfvBvWNtL
 YJ/sTrsZHtQ5IXE5RehtQSlAfxRVO6RBWR8kqO8RkIa47jhn8BPfiS6DgzaxpvQO
 1v704ghlV/uS16P5Nyj0WdmdleGAeG7XEpGPxEtajt/sHhC3hN39n7VtI3hP4tyx
 8SCebYOnyfw/IemrVGqQIFhyqPb+zOrHDJsJDaDtovFkVAjJ8HjxqnrLQwUfjV7v
 fmu/pSmIBvMQQ5cTT/LqsaE/HMjyCWoScRIlkdX2ErDG2QCKqOqmQM1i1zifSzlm
 voITvOv3MRNzWiRJJlvpWklbDM1oA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020097.outbound.protection.outlook.com [52.101.201.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a031h0tp1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 06:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqf4R40M3V5xoaqdGulzu2ijNeyTKbq8zdP09dNzaqs5ocghjkBGIzwUb9BQxQVwE9UDSewnkzgWiOM9vJwiO80n/LL07AiYeqhPwZWUMP/CrLAgECOZZ8mrIYY6dRzC3deqr+vZINz6NwV79vmePwZGWn2ZO9SrOQTqBfS8B+AiqJwf6wB+PzDt1Ji81o0CPQ3LvscyZ0yr76eBznNvLlRAfPaMeJv2/HvcsJI0YOhmM9HgT2IrbWNbLIo1zVmQbHX9Fp3j1c3dgiMPvKbiJTKieksBNVsjEsE4NQ88Vi99Hh2RaN3PT5bz31xZ6Oh67XIoypBnd1wtJQVyNeUdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxikkQdFsQob2J4ycaPz142xLOXoXShEPfytpwZAU6o=;
 b=QeA8PglWMaMQWhlgnXBR177pAMgorFd/Csa1e6pfzOQO0cydbfzP5aOmnmHUe/+pDP9GkAkV7NdafLVifv2Qw/EyYFX3uUdzviazPUVttnw5rkL56TxPrd6tYkdjAR6ldyvRVCWrktcaJxtUDBYyzPYUCQyk1I6t4un2rYSEzninT1om3rJRJElJP6lwWaZhT93dw7xLdLJEypfWqChLFHKi63pEFyH8b1/u/zcJQSRCf04CrOVu6JZzUDE88jviPFRSWhR9aaNh3H2HSVf7Hc3ajOE8xDSGoU9q8qK98/DA6Y//sTfZYMAJJfqAv3+HQzL8b9mSrmf33UO/S7PEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxikkQdFsQob2J4ycaPz142xLOXoXShEPfytpwZAU6o=;
 b=SBQq+gacND4eJYoCPYy34ZCecU+wtktyy+C86nZd7f5LWmahzMGBofnoOfF9ye8gknU1oIrCtmaXILkMvm+84p4p1rMOe4Rhbh6YJIbSqWQ0NFbXhc8vwDRD4D8F24ARIzbN98WJGDKsUbSlFQzvsBzcCXen+X6L+fZuxBAHPcCYlo3Y1+zZjCSADE4YDvF1vcdOyy7l1y6zhIEDEpUUGg6YFVC4Q5Qr4fedI/RWZOuWJQzjl0I3iBufBV9xcY2J3Oolw4V5o6SWpBMfOgCiSwma/hAwB6EuarzasT/HFDJGbP4G+QS/N0MA5y7kE/jwldBGeuycMeK79tnA+ZPywA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by LV3PR02MB10643.namprd02.prod.outlook.com (2603:10b6:408:281::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:16:02 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:16:02 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v7 1/2] QIOChannelSocket: add a "blocking" field to
 QIOChannelSocket
Date: Fri, 24 Oct 2025 13:15:42 +0000
Message-ID: <20251024131546.929499-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251024131546.929499-1-tejus.gk@nutanix.com>
References: <20251024131546.929499-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::10) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|LV3PR02MB10643:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb517ea-1291-4e4b-b19e-08de12ff7ae7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2V0UjZrOGtiZ0hmb0c0Mnc0R1Q2RktkSk1Rb1JCMVFYa2s5NUNjYy9iWGli?=
 =?utf-8?B?RWM4NnkzelcwR3hFMUhhMS9aS3VEcFpkVHZKSVRZdjdBSnNiM0RjK3hTeTIv?=
 =?utf-8?B?UmRjRnBjb1V0OFRLN2wzV0JDTDRNSis4OEpMZWlaSW1FZ3krcmtsWnRKWU5v?=
 =?utf-8?B?aVN6bkxIT3I1TGVlMm9HclVUc0lsYkNaSWRaSExyWnhLNjhvcjB5RUpDemJQ?=
 =?utf-8?B?anh5NEROQWdhSit2QVdGc05VNnk3MlNsRkFJWElVa2M5cVhmTjZjMVRXemxo?=
 =?utf-8?B?azVMUDVwVUQ5dGdWNTVBVWtkbC9TRFdyQlRMSkNxL0VaaVFxSXBuWVJNSG1S?=
 =?utf-8?B?aitBRDBGQ0FMQm9TejJVdzNLVHFBNnNxNUU5bkRLNjduK1JzWGJPaGhubFdn?=
 =?utf-8?B?Qzhob2JZempGOFZuanZ2VVNrWUNjeWwvUmYwZEU2L0xlTmd2dHBLTjl2ZUpF?=
 =?utf-8?B?VTZDWUo1Z1JlVkxYMWlhOWFURkdHUm5sdTlxQTdJYTZVYTFwTjExa1dWY1Fx?=
 =?utf-8?B?QU9rY3NtcS94UjZlZ3ExR2xnSERuMVFFeEl3d29Tblp3elhSNUhjYzI2K2tm?=
 =?utf-8?B?aCtCMTRHOUVxMWxXcWlwTXBsQlQxRWNmb3NERzNaeEIxTFlOT1piTVNabUtL?=
 =?utf-8?B?NkRsQWpVamQ0dlI3VERIUHMvZm1WOXJWSlNadzMxSXMvTEVXcXVkY2huS1RN?=
 =?utf-8?B?YnZCVEJZaWZzN3hic3BUQkJuL1dlYXR6TkV0ZVRQSXdOY3QwS0laWGF5VlAz?=
 =?utf-8?B?VE01cU1xWmt5M1A4U3ZyT242MEVQYXZHVklXTmpIZmRVcG1YYXBRNXUwQnlC?=
 =?utf-8?B?ZU83bzZhcUdWb3lRTXFpVUxsNjBja2tCbzRBQXR4cE1NT3lRa3VGTXJLY2lu?=
 =?utf-8?B?Vzh5emNHMS90enl1M0VIbFA1UEhGcS9iMXZUZFRZcTdMKytNVTBneld4SSti?=
 =?utf-8?B?VnBhM3VNUU04b1BQV1FMQTJEaDhLS3FpSFE2a3hMeUFNUVoxZ0xpaW5PZWhK?=
 =?utf-8?B?UE5nVURNSW84TGEreGVia3BXTDdjZ3ZFK1BDWkVWZnV0QkJySVByY0pnd2RM?=
 =?utf-8?B?Vmt2Tlo2WHdFZ3NFK1I4S0FmN2M0aWs2dHRkOHpLMllOUmVTS0tRdUxleDh1?=
 =?utf-8?B?UkxELytYQktUbDZSd0dBNEk5VEJoMUo4STVSVWpiQVZaM1pJb21SQzYyK05R?=
 =?utf-8?B?dERHQ1VEL3RFcmdlTFo5cHcwam1aMWxIeTFlRnBBUkJJTTFlNUF5eXFYRjY3?=
 =?utf-8?B?NSs3NHo5ZTIvQVBwc1h6dUw3ayt3dVlBWUp2eDBaeVcxcGE3cUxSZEV4dGxw?=
 =?utf-8?B?a3B3WURCWmlFdVZaRVJHcHhXQk1qc0xwb2NHOWNieFA2WFdXY1hxVThGQmpB?=
 =?utf-8?B?SzNWdm9nSE9EcWM3WUpnY08xMUZyL2E2a3A4endTdUtvSGkwb0dLVDliWW9m?=
 =?utf-8?B?MEo4R0Q0RXY4bmFuQTVCVkFUQmwyanNKWXhiN3hxNlNYWkxEeUtIRkd5eVds?=
 =?utf-8?B?dlFTWFQ5MkJ4WGViaHZ5dWpjaVdDR1dXY1dCVnNCTm1FRzFLL0Y2NHRsY1ZK?=
 =?utf-8?B?WGxYQk9ITE04VHFnRXV4SGh6Z0FKNjJXQ1VQNkE2UVVmU2JhbjRhQTh4Qlcv?=
 =?utf-8?B?THV0Z2lyM0RXZFpZOGtvelhxUTZUSkRtZXR6dU10enBPREwvajhuR1pXTW9h?=
 =?utf-8?B?WjRXMC9sdjFYUlRNM3BpeDdKUHJoM1JQMVpMTXBENjVHeDFtYUo3UHhwbzRK?=
 =?utf-8?B?R3ZvdFZjYjE5NzZoMVlKc0hWZVlIcWd4VHQ0TGg5aythL09HVUVSREo2SVVa?=
 =?utf-8?B?VExaRmlRQitrOXVCRmlXSVJlUXBvbGlqOVh4cHBUZENnQkgzUDZUaFkyKzR6?=
 =?utf-8?B?aElaQk4yRXh0WXZFL0RML2FMeXJBN0NRT3l0WmROL1VzWFdBNXovaHNUVnd6?=
 =?utf-8?B?Y0NoNnIvZHFxaFZveXcvTzRLRUZURTl2WmJGdDUrbWZWZ0pSZTEwSFJLZFBs?=
 =?utf-8?B?c28vOFlaNjFwTmMzdjRyS0gvQ2J2UXB4YzJDTEZWbm9MTFRoUzNRTld5M3k2?=
 =?utf-8?Q?Mn6DWm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRwcG1IRW5BTFVvQmNXczM1TXZYRGMxNUo0VENaQnQzcFpuZUdUdms1OHhU?=
 =?utf-8?B?YXJ2M1NIZ3FQbWl3SnV6em5hYkhFNGlRY0tNTy9DeDdtL2pJSFphMGk1RXZp?=
 =?utf-8?B?RUkrbHJLQW15dnRDMnY5aE1qOUhtMlI0bzYvdkdhdmhmck1iZlU5MEp4TGxP?=
 =?utf-8?B?dUNOenl4UVdoZ2pDb3RGdDVKNVJrTExrL1ltR2FWMFRoSVI4dE5JRHcyRDdZ?=
 =?utf-8?B?aWJuSFJpSGZJYkdyV3FMdWFObEpLRm01M04rczlLeDVQQzdhakRwVzRuQk1I?=
 =?utf-8?B?RFpvM2hnTHlOelFLL0FrUEhvRlFnQ0xnTUtLWEZTam1ldnFCUjJ1d2lDbE8r?=
 =?utf-8?B?OTNxdlZjUjEwM1VzaVNvelkwWElyNm1aN3FJSXJDUmF4bnNnYi9yVzk5cUlP?=
 =?utf-8?B?OFVnK0hlam5GVlFGWUJheFVkdVpLdFJCKy9heU5BMlFVcG9SWkMxVVFxYmVn?=
 =?utf-8?B?ZmE0azRPTG5MRS9zd0VQdWVnbWltcWR3cUxNN3lzamZja05CU2daR2dlamZi?=
 =?utf-8?B?eTdGbzRkZFJ0MWRJWThRSjEwN2FTaEZJaFJqeHg3RDV6YTBWT0VPYnAvT2t1?=
 =?utf-8?B?WFZRQ1BkMnExMFBPVFBiU085R0RlN0o4UjJxYzk5RHZobEdYOElsLzUrWTZ5?=
 =?utf-8?B?UlROVXdIcnRueTJ4S3lVWloxM2x4TmxLMHJjcWRWUmpBWitPODZqWVZranRi?=
 =?utf-8?B?NElpVFVrejQxbXV0c01OZk5VSDZTS2VNWmZMckhsRCtIL0FXbFFrdE1oWk1K?=
 =?utf-8?B?V2RhZUF6M29vcm1wQmUwOHdzcVA3VVpGdk9WWW96Ymh1UERYMFJzaGszR1c3?=
 =?utf-8?B?MlNhSVFkY3JDMnp5Qkx4ajZrN2hoK1c2U0Zkdk9WNmVRT1hTMnVtU09zSCt6?=
 =?utf-8?B?WURsRkFJbUx3TjBVa0VZYk16QkhiNG5sUkc1ZGlDNVY0dW5lR3VxSGFKeEQv?=
 =?utf-8?B?L2xCVGgvcUhPa3JtaVZUU0QwY3VJd05yTHRkMHRJSXdKVkhaOW9nVkRGNUhH?=
 =?utf-8?B?S3JCZkxHTHdOYzdsQUdTd2hTbGJmWkdweUVlQ3FCZXRnV3ZOeGxSdlhYVncx?=
 =?utf-8?B?cktZR2ZmS1NwSk9QMzIyY0haOHY2RzdLc0p1dUorRC9kSk9OUTQxWWFiQ0x5?=
 =?utf-8?B?b2JQbXZpRU0zYUxaMThxWE45VFJVMUdXaGVBMkZvUklNY3VyRVdNNWxGSDhD?=
 =?utf-8?B?bFl6WmNBNXd2ZEZMcGxrVFRkS29YS3FadEkwZXdpdGU1d1NuU3IwQjFLaHVX?=
 =?utf-8?B?TjBDY2VkclVURmxCYlNxdEtZSWVTTU5IV2lLanZXL3QrTUlSa3BKOWwrMFZW?=
 =?utf-8?B?MENvdWNnWFd6MGhnbVlCTFI5NHpSWWpwUnVmZVRYeW1zd25NVDJnKzMwT1Rn?=
 =?utf-8?B?bkdMSmZxQlV4Q1Q5TVV3YnlhWjBwZDJjTG5LU1ROcGVlSHBjTmtUS0pSTm9j?=
 =?utf-8?B?b3JtbXJDQzN1UWxkcTUrdEM2ZVROQUpHTlZNQUpCSGkrYnljNjFubkR1VVZP?=
 =?utf-8?B?SVNPMERLVkF4dFVNeTdCOXdPUHUwcE5UaHpBd0xERHhMUmJFa204MXBLTjU5?=
 =?utf-8?B?NkVMVm42U2dCUC8rUVBVaFF3NzgzRUdlNXR1UmxMVXlqMTlOK2FVTzB0cmJO?=
 =?utf-8?B?dVl5WGNQbWxUWUIvM3JqbHlETTVEYXBaejB5djkyVVZJdCt4dEJMRnQ3U01j?=
 =?utf-8?B?dHc3L1ZoaE11K0RDVG0vaUVVY2RWMDZ0cUNlS0liZEZud1QxZjF2V3E1RWJl?=
 =?utf-8?B?WHFERytVM3FNSEpFR3VvSUloeXF3VDFobHdhQ3lEK1h5Unk3Zm9DeG5BbklT?=
 =?utf-8?B?czI0Unoyb1VVNGhOblVmeUVvcHJJKzRKbDRSZEhaRFN5bFhSUWl0czcyN2Zl?=
 =?utf-8?B?Vjd2Ym1mbnFXSnNBZC9VenhoS1NMb2p4eEpvczI0aWVnYklneGg0YzRWRm5V?=
 =?utf-8?B?Z0dYTjRkYnEzT1crMFRrWm56T0lXcEFVdHFSTEtLOWhhZHNnby9NN0QwWHdK?=
 =?utf-8?B?T0ttbGs2U2dJMDFOWE9IS296ZGE4NWhWenlPMThjZVZtYjVHK040NzRUcXMr?=
 =?utf-8?B?SGsrSjZ2U0ZBeEhvY2U2OHRjdER2aWN6czlta1hOd01jRzVNeDlqSzlOVk1l?=
 =?utf-8?B?M2xNSEYwZXA2bTExWGpxNzB4aDhvZ0NNL2oxUjMwZk9wclE2WEFqZGJlRDkv?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb517ea-1291-4e4b-b19e-08de12ff7ae7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:16:02.3356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OM+STo/yguJ5QMabKtjW78HOEIJ6KsneNhW4akndTrvUhm0wCoA1/ThKlQmo52vad7KiUMz9AcU/WCqgHDxtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10643
X-Authority-Analysis: v=2.4 cv=TOJIilla c=1 sm=1 tr=0 ts=68fb7c15 cx=c_pps
 a=dY44fPPHiqsl/jBMM45sDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=pg60GzFlFQrSi9hmcNYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xEzQI_v2qFS-dJ3LDnj1Ngb5RfGgfaNf
X-Proofpoint-GUID: xEzQI_v2qFS-dJ3LDnj1Ngb5RfGgfaNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDExOSBTYWx0ZWRfXzm+JZNCGSO6n
 6PuM+rS+KYOCrHLFO7nNKQ/Ti+/fJWzezSwxYC6PnFmLULpjebcxEvIUuRyCPu0FEgxeFsfMoNj
 ORbqoS2cTgfyIo6/fNldf9Y0VUwp/GjW/gIPN2hkfbVWuPXDob9dzLCvd/oKPhkgTcGxVwMgw7F
 7NdYs12nAp5ubE9ZDxB7vv9PEqSDZRtHndCbD2PL9S2YCd2ChCP9ca+ZVM4uK4ncFg3VGTbJoXq
 zi9O9z7BfDPLVfn1sisuisLLzkAeOwRsYpHFU6fIwksExrmiVQwxObGjnrI+DB8LrsJM4hO2UHg
 MXow+g/Q1N5V8wC7AQMvqTtrhXSxtK8YK1F+Kyttck45aZxXkHa3RsWNqbhfl1jwXJNmKOGb+Hx
 3+kuaTQaWXaGFZypzGHjgt7qBQgryQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Add a 'blocking' boolean field to QIOChannelSocket to track whether the
underlying socket is in blocking or non-blocking mode.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-socket.h | 1 +
 io/channel-socket.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a88cf8b3a9..26319fa98b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool blocking;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 712b793eaf..8b30d5b7f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -65,6 +65,7 @@ qio_channel_socket_new(void)
     sioc->fd = -1;
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
+    sioc->blocking = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -859,6 +860,7 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
                                 Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    sioc->blocking = enabled;
 
     if (!qemu_set_blocking(sioc->fd, enabled, errp)) {
         return -1;
-- 
2.43.7


