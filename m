Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2DCCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 05:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr9rL-0001rU-31; Mon, 01 Apr 2024 01:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rr9rI-0001qv-Ns
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:05:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1rr9rG-0002vk-5B
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:05:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42VNYCoV024857; Mon, 1 Apr 2024 05:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xrxTZHLMmx52YgrySTYWTD3YTO5y4vVoKeVwUW7j4Lo=;
 b=i00Fh2nq0lsffzuBVrQXL3klTf9B11g+YPvVQ8XDPa+hPa3MroA/y6yJNRQ7pds56HB+
 oe1OG0pjzlgKHLJ0a7auptIIZlKfIJivvlSYtSFSkNPy+20AQXzUCe6SQF2F2vFquEns
 f/turLUkn2D6RhQ6ixo/C5CvRBNnlwmCSs5L9HuG+fK3O6QaozJFGW/S0/lF+esua94d
 dqs9Ja6v4PjncoDqW8j9o5rZMIiDsiPcaG6mDW1m5dGoDgpxxZfsO+duSNT2iLFIBczR
 oJqi/sXWSfb/t4JIN6fA426dkc0t754EktPkAJc5aaTUQcdmN7CCfuv4qPO67UK0q3aN 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6b9v9kkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Apr 2024 05:05:14 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43120IkN021462; Mon, 1 Apr 2024 05:05:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x696558ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Apr 2024 05:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chXP+PMkSnMpWvZ2vLEohw849oS3F4//bBAF3OZzGCrttk5tVgJqf0kKn7KIo+o59SCqDiTXpW7xTU2RoBQPJnGt6f1cZGQEjICzImzuelWfv/nt8qJcCXyFAbGro+Bgzwzb71laBRT+fKiebSpdCCZta5cGxr9u6DmXp7G7uH0X31UjqG9i1KsIet8pG/rjhiwCvinHOLyL6NI+x8+4RgdtwU5KJaKqW+eU8aIPlrpmqsQQPypp9cHeruDsK/NK368fKN/fWUS4PDHex1bmdRfnpenWjcNZLh/5Bjko65XldTTvNJXqvlpwpoHUVVUnpwnWtcdf5qu6gzVdtOvh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrxTZHLMmx52YgrySTYWTD3YTO5y4vVoKeVwUW7j4Lo=;
 b=Hi1UgMwgjtgqTlVQ/X6YWcucwTVtc8PIAhEtQe+v1Ia9ODaramv9k90iEqmJq3/OtyVSF6cvZmNGIQSV1uq5/PyrxdFZdVIRC+WR7f2AKSkryC2ULNDGLvEwDNmpCvcqcUZgdynyiOxU/S2Rsw/pFkQIhIp7okR+Gm+sPkaHQskzRF/dey7TPOYJmzYGMYa97LC+No8OgTNXdqgE8SfIOJb7IcBpjnIJ1yVpVkoJrB3zXoU/fIDNnFKy9FPh+9ur5kt0eAsRT9Xb0vvp3J7l9glbMmDrIfGioYcCItTNFFR1JRXtddaT0JBNR1KygXhTKB4Le30Tgk/3CwvnNXG5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrxTZHLMmx52YgrySTYWTD3YTO5y4vVoKeVwUW7j4Lo=;
 b=nUNb67t7J7Rsfh0fs7rQ9AgoSEWUT4GN94MVLmq5FfwaJkI4YmfIv5m4Rq0/MpK2nEipmol1w+C1N3T/7Fsc6SfEDS5xkoidsUPk9dbMRHItI8vcCbESJ0a68mM8mcIVQYe5Z4HL/eUbf1cr4XmnOkxtEjRUlyy8wyeZuj1qiBw=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 05:05:11 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 05:05:11 +0000
Message-ID: <53699224-f6d1-affe-1e99-2ed4812e9164@oracle.com>
Date: Sun, 31 Mar 2024 22:05:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: qemu process consumes 100% host CPU after reverting snapshot
To: Chun Feng Wu <wucf@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <c2bad656-0231-4113-af5b-75e4247d2ee2@linux.vnet.ibm.com>
 <3352e507-528e-4666-8d14-ff6522d06d76@linux.vnet.ibm.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <3352e507-528e-4666-8d14-ff6522d06d76@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::12) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CH0PR10MB5147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/CcpoD8EdJ8NWt8rem3qzG0ZVRgAunrjZBls9fTfO0FedvqUyP7+vBq24ya1y1L99ipC4/XbbDdGBUKRejlMwPbECcbyTI4TfgL1AbX3CxilFXBjjCQn4kSbQnvhdvEE/vrFtkfHFt4NNt+V8z1g0h/QaX1CGCP3pINcx4eGQMNDL3r23d+H4zFw+tQw78BLW9Ia+r8cbWzY4Z9l8ZUDL3uMuzbDLrTirx7/TJsD7XkO0cPNTgxtO49P5/QPHWzRk/mwO+WlltBCwoXOY0G+jWOjGuR74u7UhhRDSWJ9fG2bx3vCujoPwnHulAzadC4GY6hmNhN6vF3kFu9fx/qAt84jY9V2/ArJOxsB0SSkM5wnZnaaOoi1jxOL3i3G2Nst7mv2dFKiyEZA60LnnWgrCaIUHylM+0WrTlHpxGdfPTte+XSDxYm+Jrl+Z/kyi7Kpn2mawYjZL6EDvNo5rQqVDA/pI8nJLlYNyXZdhbj8+ImPWxpZLuDIonhMktC4X27AF3e3XUsDjbLRKnJxI1rutKtHgnw9csb3NhdZCJNp+It13QrR/pyNuHLwhFqyOzUIQ+KklLfGqLOHT33Ih3uhvbWmTW4LVM8IXDOahaeYmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR10MB6425.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmF3cEc2bHpCZGpIKzdCOEc5OFoyVjVrZnhIVGRXYmhmY3EyTDJLS2Q0V2xF?=
 =?utf-8?B?emtNcUw4WnBvd1hxYzBUYmdic24yNXJGWFJXTk1iMzA4aGJ1SDU2dXgrVFU3?=
 =?utf-8?B?bjBvUWJKTjF1VmVKb0RXYlorQlBhWkJHZjNKYXJYMDRUS0ZoZ0tVcEE1OHlS?=
 =?utf-8?B?VTZvVVRZeE5MNE9JNG80Tk1vbXFIL3BCeUYyRDhRcDNPVFJBL0g0dmJlZVEz?=
 =?utf-8?B?b2VDUnNVU093TkdpeFIyaWppYXpHNFIxeUYzVS9nOWRCcGN3U0dwWStmYzdP?=
 =?utf-8?B?c1g2R1R4TW1RNmFiZTZEeDZjbnFLQkhoUERVZGtuMllCbG1FQ3hod29GZGp4?=
 =?utf-8?B?SzR2NEgxWFZ2TllsZmJROWNKbnY0Q2V6b1VCNC9NN2JWcitZUCszK1ZWdmpw?=
 =?utf-8?B?b2o3VHJ4TVBHMERjbXpjcjVUQkNOWnZKdk1nZ01OZS9iZHhTdXcwS3Z2aGxP?=
 =?utf-8?B?TWZsL2J2TXVhcE5SUm8vV015RjdmSy96MzNzVGdZMXc3UHpXWTZHMFRNZDN3?=
 =?utf-8?B?SVBRaFJIK2VqRkFka1h2UjVpNG1RcGZoZUUvdnprRk9ONFN2S0p5Y3cwUm9z?=
 =?utf-8?B?ajlmR1pjcWVES0ZTK0ZGTDFxSHhQOU1ob2xha3IyQUtIUzBNSlNlNmdiczJB?=
 =?utf-8?B?V1NtamRWaTYwdUV4ZTQwSHhHSXpLLzArdnFMYUs5enE0Q05lZjc3WjB4MklO?=
 =?utf-8?B?SFZJcERMais4OWFYY2NpRGpYdllBbFVMTmgrWjdIMFZyQWNmQlpZcjNNR1FD?=
 =?utf-8?B?V2pMaVNCQ09ZN01ITElnYmZYUFhaZEJtSHVkRmlnRmptaTFSTHdhYTBUWnBG?=
 =?utf-8?B?QUkxZDIvSFJIbm16T0dKWkdNM1hOa1pXR0NEcXJ3VlZmdlllV3BxeGdZU21L?=
 =?utf-8?B?blNINjlaTTRyemw4UHBmWlU1Q1pCMXBzVkRIL0lKVktJZkRHZG4vdkNia0o1?=
 =?utf-8?B?Q0s4ZVN6c3M2MllHQzQ1Q1FoWm1tSFVLUTAyN3p5VU8yV2lWdTdGNlVOVk4y?=
 =?utf-8?B?SFZ1NmdEMkIyaTVoSG9BUXNUSENyQUgrRWN1emlLdG5ZUWRiU2VDZUtmL1dW?=
 =?utf-8?B?ZG42UHUrNkNJY0JOODJ6TlNYSVFjalYyY1M3L2V5cGJCL1Aza2lWTmRtUGVN?=
 =?utf-8?B?Y0hvVjFpd05sS2pjbk96c1FjbXdWR2lIVStmMkUvZDl4cVRiWElzdk1YYWNo?=
 =?utf-8?B?TFYvdnFDUk5sWDFOL1Q3UTQ3Tk9URjJsTyt4NFU0MjR4YWc0VU9IeWhrNEU5?=
 =?utf-8?B?OE81NGcvUTlkbkljTjB2YWNJeGpheXZ1VUpPOG41Y2FGWUhibFlnQU5tSlBx?=
 =?utf-8?B?R0VZN3QrZmZFd1gvNlVKRkpvWnMwMWxSVFlQb0g0Q2F3TUVRQVpJV2M4MnpV?=
 =?utf-8?B?eVRjVWY5TkRUekVOdEYzOC90a2VMd3J3eWgwcnZ5K3ZEcEwrbHYzOEhlVGtB?=
 =?utf-8?B?U3N2ek8wVGZZanBOMjBKWXIvbW5pL0JtN1JJVmVVaWZ1VjBJM3hJNUN5Ykpt?=
 =?utf-8?B?N3p4ME91eVVhbVNmV3FCaTYvejEzUXJ1Zzd1dE9qZGREM2NwcFNyQjhoZ3dW?=
 =?utf-8?B?Mng2NUFIc0dmVE1uTTBPalgzc2k5T0IwMmRBV3I2d2x4dW1nRG43ZjBZTEhW?=
 =?utf-8?B?dnlkZ3FDbDNodWZQSG5rbW0wMjloVEFPZEM5UndJNS9ianVtS3QxRllnV1Bo?=
 =?utf-8?B?c251MVp6bGF5R28rOHNkcFpDTDU5T2NZRzBBOTJqWTVXSXFVVDJmcHlJUG10?=
 =?utf-8?B?YkdnKzVEMkdIUndUZnpYb2pxc1M0a0NBZ0t5RlgvVWhuRWViSUY0amFaNTlU?=
 =?utf-8?B?VE5saS9yM2RCU3VMZ0VCdks1dzN1NmdoaFVidEd4VHhxQ1p6YUFuNFdkY2FY?=
 =?utf-8?B?eXRPQjdCcTl3SFlWdnRXeGNuRGo1MUNUZ3ExTkRGZm9ETTc3MEY4MjlGMGJ0?=
 =?utf-8?B?R2ZMN1dla0w5b0pvWjQ1bTNNYWt1dTZERmExWEZPNzNicGtOSWpoSEFFU3Js?=
 =?utf-8?B?bHRWVVlJTStDTWRDNjJhY1BiYXl5Q0RQaTliTU03TzNyTkphRDlsNFNJWDlU?=
 =?utf-8?B?TWZLMTI1UmlENUVWZk5TMndVNzVrVHp0a0RockZOWkdaaXVGRVdVSWU2aW8x?=
 =?utf-8?Q?KZhAikxU4sa8+mxULf8JTTWWg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ctY5VQGP2dd56H8MjnJ8ZK4vIfqEflfYeJzowR2/yfQiD1tDg8be22r3m9mspQvZbIrrIGn2CB+6CVyvXTeiAN9RyaYyfywAU3l5Wvb/cgCQ7q78pgeAZ/1gf/SE8Qlbmcp6tIXFKWrC7VDBULFKJvaiFofFOP/pcMkP47rjqozVM/hkcEkmwg/mTGMi5mqDyDaP05JUEC8qa7VRqWu3kOOwLo5y/Qdx+ArDw1cgFBZ/+A31JlHGpmdS4iGAUvSHx2+C9mZ2QUcs9/CNmObcTjKyDwyoQpDfFACuVssfTsaH0ij5qzcQVdd5QbY59PPB6TvGE/Za83sdfmsC1v144C/Trd/8V+P4s6wQ+uswZzVOowY3IGDeGNizZEbLZqfhWtfvjm3h1DlsMnWhPoLFCNjzpsgmiyuGa/FsGCk1hYHOQbdRLAduF5yj5UPN6yA3lDqAv0glGf4MnrmSRbyrmtWrOvNONM6AFeDOT99mYKxLec6kF7YvbEKPXG6yFCffCR2RrAm/EqXmM4Tfc/uyUVGuHi+NPzcFc4/hn8sVihlXiRlQnuwk1D2VMB/2qMwmhFcrNZkAJ02a0Y01fwcjIIuiWNNaXXnERyd6ZbX64U4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba55a88-151b-4bf8-72b6-08dc52094ed7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 05:05:11.2040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZAnTpKSxC3K9ifJq6rXly+MCPE48DKcSsFVHeuYqv+G/YmH0knLylO7bIuyZNubpYAZ1ET2Np+78JzMjok5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010034
X-Proofpoint-ORIG-GUID: RiLBtAvRxrhbY_ZKRWcL5zfQWfTrRElU
X-Proofpoint-GUID: RiLBtAvRxrhbY_ZKRWcL5zfQWfTrRElU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.33,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

To share my test result, I do NOT reproduce the issue with the below command
line and QEMU-8.2.

However, I can reproduce with QEMU-6.2. The mainloop consumes 100% CPU usage.

qemu-system-x86_64 \
--enable-kvm -cpu host -smp 2 -m 8G \
-object
throttle-group,id=limit0,x-iops-total=200,x-iops-total-max=200,x-bps-total-max-length=1,x-bps-read-max-length=1,x-bps-write-max-length=1,x-iops-total-max-length=1,x-iops-read-max-length=1,x-iops-write-max-length=1
\
-object
throttle-group,id=limit1,x-iops-total=250,x-iops-total-max=250,x-bps-total-max-length=1,x-bps-read-max-length=1,x-bps-write-max-length=1,x-iops-total-max-length=1,x-iops-read-max-length=1,x-iops-write-max-length=1
\
-object
throttle-group,id=limit2,x-iops-total=300,x-iops-total-max=300,x-bps-total-max-length=1,x-bps-read-max-length=1,x-bps-write-max-length=1,x-iops-total-max-length=1,x-iops-read-max-length=1,x-iops-write-max-length=1
\
-object
throttle-group,id=limit012,x-iops-total=400,x-iops-total-max=400,x-bps-total-max-length=1,x-bps-read-max-length=1,x-bps-write-max-length=1,x-iops-total-max-length=1,x-iops-read-max-length=1,x-iops-write-max-length=1
\
-device
virtio-blk-pci,bus=pci.0,addr=0x4,drive=libvirt-4-format,id=virtio-disk0,bootindex=1
\
-blockdev
driver=file,filename=image.qcow2,node-name=libvirt-4-storage,discard=unmap \
-blockdev node-name=libvirt-4-format,driver=qcow2,file=libvirt-4-storage \
-device virtio-blk-pci,bus=pci.0,addr=0x5,drive=libvirt-6-filter,id=virtio-disk1 \
-blockdev
driver=file,filename=test01.qcow2,node-name=libvirt-3-storage,discard=unmap \
-blockdev node-name=libvirt-3-format,driver=qcow2,file=libvirt-3-storage \
-blockdev
driver=throttle,node-name=libvirt-5-filter,throttle-group=limit0,file=libvirt-3-format
\
-blockdev
driver=throttle,node-name=libvirt-6-filter,throttle-group=limit012,file=libvirt-5-filter
\
-device virtio-blk-pci,bus=pci.0,addr=0x6,drive=libvirt-4-filter,id=virtio-disk2 \
-blockdev
driver=file,filename=test02.qcow2,node-name=libvirt-2-storage,discard=unmap \
-blockdev node-name=libvirt-2-format,driver=qcow2,file=libvirt-2-storage \
-blockdev
driver=throttle,node-name=libvirt-3-filter,throttle-group=limit1,file=libvirt-2-format
\
-blockdev
driver=throttle,node-name=libvirt-4-filter,throttle-group=limit012,file=libvirt-3-filter
\
-device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-filter,id=virtio-disk3 \
-blockdev
driver=file,filename=test03.qcow2,node-name=libvirt-1-storage,discard=unmap \
-blockdev node-name=libvirt-1-format,driver=qcow2,file=libvirt-1-storage \
-blockdev
driver=throttle,node-name=libvirt-1-filter,throttle-group=limit2,file=libvirt-1-format
\
-blockdev
driver=throttle,node-name=libvirt-2-filter,throttle-group=limit012,file=libvirt-1-filter
\
-netdev user,id=user0,hostfwd=tcp::5028-:22 \
-device
virtio-net-pci,netdev=user0,id=net0,mac=52:54:00:12:34:56,bus=pci.0,addr=0x3 \
-monitor stdio

(qemu) info status
(qemu) savevm snapshot1
(qemu) loadvm snapshot1

Dongli Zhang

On 3/28/24 03:50, Chun Feng Wu wrote:
> BTW, if I download
> qemu8.0(https://urldefense.com/v3/__https://download.qemu.org/qemu-8.0.0.tar.xz__;!!ACWV5N9M2RV99hQ!ObhT3ZYGr8GQFt4p7dWc-t-CFeKff1UzyRPc9WQrAuhz1B7jDC1-VTqjoCUDcrhXsffyBQuRtnoZhfZhS8FVig$ ), compile and install it in my ubuntu22.04, launch vm with the same command(just update --machine to be "pc"), the host cpu usage is not high, it seems to be a bug in QEMU6
> 
> Also, I have another question, for disk iotune or throttle group, after
> reverting snapshot, if I login vm, and run fio, I/O performance drops a lot in
> both QEMU6 and QEMU8, do anyone know the reason? Any explanation would be
> appreciated!
> 
> 
> 
> On 2024/3/28 07:32, Chun Feng Wu wrote:
>>
>> Hi,
>>
>> I am testing throttle filter chain(multiple throttle-groups on disk) with the
>> following steps:
>> 1. start guest vm(chained throttle filters applied on disk per
>> https://urldefense.com/v3/__https://github.com/qemu/qemu/blob/master/docs/throttle.txt__;!!ACWV5N9M2RV99hQ!ObhT3ZYGr8GQFt4p7dWc-t-CFeKff1UzyRPc9WQrAuhz1B7jDC1-VTqjoCUDcrhXsffyBQuRtnoZhfaQOXc8pg$ )
>> 2. take snapshot
>> 3. revert snapshot
>>
>> after step3, I noticed qemu process in host consumes 100% cpu, and after I
>> login guest vm, vm cannot(or slowly) response my cmd (it works well before
>> reverting).
>>
>> /    PID     USER      PR  NI    VIRT    RES         SHR S  %CPU  %MEM    
>> TIME+ COMMAND
>>    65455 root      20   0 9659924 891328  20132 R 100.3 5.4    29:39.93
>> qemu-system-x86/
>>
>> /
>> /
>>
>> Does anybody know why such issue happens?  is it a bug or I misunderstand
>> something?
>>
>> my cmd:
>>
>> /qemu-system-x86_64 \
>>   -name ubuntu-20.04-vm,debug-threads=on \
>>   -machine pc-i440fx-jammy,usb=off,dump-guest-core=off \
>>   -accel kvm \
>>   -cpu
>> Broadwell-IBRS,vme=on,ss=on,vmx=on,f16c=on,rdrand=on,hypervisor=on,arat=on,tsc-adjust=on,md-clear=on,stibp=on,ssbd=on,xsaveopt=on,pdpe1gb=on,abm=on,tsx-ctrl=off,hle=off,rtm=off \
>>   -m 8192 \
>>   -overcommit mem-lock=off \
>>   -smp 2,sockets=1,dies=1,cores=1,threads=2 \
>>   -numa node,nodeid=0,cpus=0-1,memdev=ram \
>>   -object memory-backend-ram,id=ram,size=8192M \
>>   -uuid d2d68f5d-bff0-4167-bbc3-643e3566b8fb \
>>   -display none \
>>   -nodefaults \
>>   -monitor stdio \
>>   -rtc base=utc,driftfix=slew \
>>   -no-shutdown \
>>   -boot strict=on \
>>   -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
>>   -object
>> '{"qom-type":"throttle-group","id":"limit0","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":200,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":200,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' \
>>     -object
>> '{"qom-type":"throttle-group","id":"limit1","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":250,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":250,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' \
>>     -object
>> '{"qom-type":"throttle-group","id":"limit2","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":300,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":300,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' \
>>     -object
>> '{"qom-type":"throttle-group","id":"limit012","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":400,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":400,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' \
>>   -blockdev
>> '{"driver":"file","filename":"/virt/images/focal-server-cloudimg-amd64.img","node-name":"libvirt-4-storage","auto-read-only":true,"discard":"unmap"}' \
>>   -blockdev
>> '{"node-name":"libvirt-4-format","read-only":false,"driver":"qcow2","file":"libvirt-4-storage","backing":null}' \
>>   -device
>> virtio-blk-pci,bus=pci.0,addr=0x4,drive=libvirt-4-format,id=virtio-disk0,bootindex=1 \
>>   -blockdev
>> '{"driver":"file","filename":"/virt/disks/vm1_disk_1.qcow2","node-name":"libvirt-3-storage","auto-read-only":true,"discard":"unmap"}' \
>>   -blockdev
>> '{"node-name":"libvirt-3-format","read-only":false,"driver":"qcow2","file":"libvirt-3-storage","backing":null}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-5-filter","throttle-group":"limit0","file":"libvirt-3-format"}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-6-filter","throttle-group":"limit012","file":"libvirt-5-filter"}' \
>>   -device
>> virtio-blk-pci,bus=pci.0,addr=0x5,drive=libvirt-6-filter,id=virtio-disk1 \
>>   -blockdev
>> '{"driver":"file","filename":"/virt/disks/vm1_disk_2.qcow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}' \
>>   -blockdev
>> '{"node-name":"libvirt-2-format","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":null}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-3-filter","throttle-group":"limit1","file":"libvirt-2-format"}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-4-filter","throttle-group":"limit012","file":"libvirt-3-filter"}' \
>>   -device
>> virtio-blk-pci,bus=pci.0,addr=0x6,drive=libvirt-4-filter,id=virtio-disk2 \
>>   -blockdev
>> '{"driver":"file","filename":"/virt/disks/vm1_disk_3.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' \
>>   -blockdev
>> '{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-1-filter","throttle-group":"limit2","file":"libvirt-1-format"}' \
>>   -blockdev
>> '{"driver":"throttle","node-name":"libvirt-2-filter","throttle-group":"limit012","file":"libvirt-1-filter"}' \
>>   -device
>> virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-filter,id=virtio-disk3 \
>>   -netdev user,id=user0,hostfwd=tcp::2222-:22 \
>>   -device
>> virtio-net-pci,netdev=user0,id=net0,mac=52:54:00:12:34:56,bus=pci.0,addr=0x3 \
>>   -chardev pty,id=charserial0 \
>>   -device isa-serial,chardev=charserial0,id=serial0,index=0 \
>>   -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x2 \
>>   -sandbox
>> on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
>>   -msg timestamp=on/
>>
>>
>> snapshot and reverting:
>>
>> /(qemu) info status
>> VM status: running
>> (qemu) savevm snapshot1
>> (qemu) loadvm snapshot1/
>>
>>
>> my env:
>> /:~# qemu-system-x86_64 --version
>> QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.17)
>> Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
>>
>> :~# lsb_release -a
>> No LSB modules are available.
>> Distributor ID:    Ubuntu
>> Description:    Ubuntu 22.04.4 LTS
>> Release:    22.04
>> Codename:    jammy/
>>
>> -- 
>> Thanks and Regards,
>>
>> Wu
> 

