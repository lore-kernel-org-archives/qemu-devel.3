Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E93C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 18:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raKDR-0006Xc-Tb; Wed, 14 Feb 2024 13:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raKDQ-0006X4-1E
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:42:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raKDO-0000nX-9J
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:42:39 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EIAeL4030087; Wed, 14 Feb 2024 18:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h44UypHioP/uYnAUyP4WuFBnXwycomLde2sRU6W+bUw=;
 b=TxIX4/H5cXr6moQ2NWCZHdFCC/vCqVz3vTPkBLyAA1MX2OpwIdtLAXHr+8zGuRuxs27Q
 TDLvyxO1agkt/z+/1LjfgIGdWEK7vNwCXyBKPUir84Q7kWaGKXtHGw6L51csGWGXL8jI
 jFBxjPRKmaj8FIx2/Ni+u1y/jVHRFiVFXrlJLyPPZxt+/9QXgYhsA8/9wuHof3bZa4Kt
 Qr+2UBPe4V+BugpZGBjJPvB4lJ8YsIa7vwey0h1gWkPq9PVnTySmhJWPrPdCSO1fLdCZ
 H0bEu2OOqPJPbpXjWd8C/2vapUl0g/MJXgMC6X2zpIu5GsWdMZVM9+W3Mx8Msy6TG7ys zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0g31f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:42:36 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EIDfMK000883; Wed, 14 Feb 2024 18:42:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk9cnkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 18:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRxz8fVh4iXdbT8Dc8aa/vShVt5FfkK8NMGbswKwcrI1u3vXeVhduVr8nF29v+DmfibiUSFsWcQ/Yhk1X2TWZrvA/+q9+RaCmeKzzBVeD6qZxRz97Xr/jr5RDU70PJmLQ4opVnDAShjKi/zyta9xWGlnajjJA5uAM+JUtmEdy3Q1JdOJiKqTrwHrs3//8kH4RsTPB1WyqzJZ1tpv/tPkQl7w70OdwTiHRdcAaFndy/OrtnJhRdXLUROhIJ9kONGj+NzMAagAX6aCvBvzXgKkFHsY18EFkgEgMgw/NrgWj4otVTV4Lu5jKhLa6vIL2i/55NK5pTu3rsRbX2Is0A6ROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h44UypHioP/uYnAUyP4WuFBnXwycomLde2sRU6W+bUw=;
 b=mT6gVjGBDjzdW8s9BzzMuygOyOLY1TLngfWQz4jU6MN52GVAwyaNZr5aAKGHOyJXVgSdsgEWWDldy4mheA6lL2QQGUIapviqmQU76DF4cG3kiP0FgwEkXfgKEx4h1EXGnJJQEghphaG3kpAqWevkWnDeU0yBmHIVLKLeXH1S0gUoXLQudmPnvUkFvEGQEhPmzgCy9R+nQSca0crcb8hd8WJor0J61iP8rWJv6I8rXYqegj4lG7Np0eOtdVCT4Rhpwx0TvPYO+LOEPM8qhuoKTTcQQj8luxbOXpqEIR4jB6QKjri6wPFWo0K5VTIWrezQ9xrBzQ3qYHMiZZJQAxop1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h44UypHioP/uYnAUyP4WuFBnXwycomLde2sRU6W+bUw=;
 b=ooaPv3ztGofEx4NEQv/UnrIE1PLpV4mCmLetyZzoJKj/htIRDVqKWdRNGcX+dHTAmANWO+sen8GBVx0z4f61qNk/7Clm9y2P3IZEGIVcE4PzOPHCNmjNjVQYhabxtn/DBAVG5BX5Ziu71dh3xnC/+5vvyHIUU+5EFgST7DiwaYw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:42:34 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 18:42:34 +0000
Message-ID: <2c8867fc-fce8-4964-b641-09f7903ff594@oracle.com>
Date: Wed, 14 Feb 2024 10:42:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: mst@redhat.com
Cc: jasowang@redhat.com, joao.m.martins@oracle.com, qemu-devel@nongnu.org
References: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1707911419-11758-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9309a24e-3254-401a-9e25-08dc2d8cb574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvvK1c//4CiYgd2HMNEl6ULfTZvuw3ttHxgn4DVr8Ia62HqWktrXljE6T9EHMky5eF910rV2GwjdtsZt1derrWiGTNF4YsLD6gTgMPOFTqnvkjqsmHoN3A8MToP+VjgymD5zvppCJcjPMtA5Ksf1fCZc7tFnF8iepS5uRMBj89l2oU5ZhiD1OoVzt4TJVf8zBcUE8n0d9fyehY5wZqcdwEgA7YXQWuLZ4DrzZeOdRDA4PudUXzoV1qAw+Utc+sKW0T0p6hGhwPnloeMojEgocYKbpdfbkyuGkv38AICNdm80eBtB6H2o1pKktERjblRPDe9VFVCFfT7YTevP7DHdtXNBLyYlwo0a2Y7Xn3kViVrt3d5bqbzZkrM6B7gge1jJXKRI5WZsToChWb33X3bb2Y/ipJP4irseH021yE23ZJYAi4TCWH4BFErHiZZT1IraqsLuZTokn97obvwFIoyv7e4AednJwTWobD5PMdMFO+/lls6Foe88y/ndT3hrvWdfJgZCVPv3HOnzI1f/DDyinRZf7+0srg2/6y9gnKzm9b9LFJz1HIdSonMQcPFnwGI7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6916009)(8676002)(8936002)(66476007)(5660300002)(4326008)(66556008)(66946007)(2906002)(83380400001)(31696002)(26005)(36756003)(38100700002)(86362001)(6486002)(6506007)(316002)(6666004)(2616005)(41300700001)(53546011)(478600001)(36916002)(6512007)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJaNlRMWUIwV0J1Y0FCNHAzNmJGSnBuY1ZTSkwycHhtZmUwUmp2dHJ3SllP?=
 =?utf-8?B?Z3pmUGJuR2R1OFhmYU9DeTNYODJsOVliZFJLZXRWRENKNnhVRVBGeHd0RnJQ?=
 =?utf-8?B?QXNhNm9LQUVvQ1ZhcHJyVFlDYmVZT1JRSHBwRVJTdW5NUENHSlc2TXBoOE9J?=
 =?utf-8?B?OG5UVTBqZkpvdFI4WDVhR3BJbEtibW03cmhjazFnQVBNeGcxdkh3b0lneFI5?=
 =?utf-8?B?S2ZKS0tMcXh0VDl5UnBtT1dlV211eVpQVnRhZ1k5dHJpZDE0U2lRdmpYREpK?=
 =?utf-8?B?dUhscFoxanc1azVuajFwU0tUQ1Uweml4N21adlYyTUloTEhZcVNQYzBJcmF6?=
 =?utf-8?B?U1pmdkE0VWlvTSswT2VzMnhBZU1wRHlPQ1l3cnJYckg5RC9OK1RVZDhqRzBy?=
 =?utf-8?B?Q0tVa1BzTzlZNFd5VlZOOGhwUjIxckZqYjZXZXZqd3dSQVVBemVMTFdqQnZr?=
 =?utf-8?B?YmJyZHZwME12aW9PMmNWMzZ5anMyOXloZ1N0R2hrWkJZKy9RNkVVLytYNlVo?=
 =?utf-8?B?TGkrWW9adWthN3VjckU2ZVd3dVlZMGRUM2Zpd3ZEcEFWaFpmRDBGQ01ZV0kw?=
 =?utf-8?B?cis5L1NEUDJoVXJSVmlhaDgrWmJyRkNHaHkrWHZIVjdkakVrd2g2eEtMYUlv?=
 =?utf-8?B?MllVOW5VOFB3QmllNE9CNzFpMC8vdm8rTTFyNXdrUzRxcTBIU0x2VEd3amhV?=
 =?utf-8?B?WVJENzNEekRRTTJ1d0pBVmhsb3ExdElwZG5RUzFaM0Q1d0hJRGpPNXJVeXlP?=
 =?utf-8?B?SUV5eWRvejc3RitPeGsydWxTZFB1TnBqWUpQUmhNUCtyRU1VQmpkWU8vQ0dL?=
 =?utf-8?B?eFNOY1duNkZXS3N5bXlKRG80WjlPYURtdmdCNG1PVVhlNVJYQVM5NVBkTjhp?=
 =?utf-8?B?VDlrV1BkVXR4ZVFvMmF0clI3TktZZWd0Y24wbm4xV0xXQS9OanFWT09XdkxJ?=
 =?utf-8?B?dnBXVThqbTZ2bXhhdEVCUHF4OXpSS2lqcHdFZHdSaU8vTWtteW1nQVNWUm0x?=
 =?utf-8?B?bTI5RFdJYnlXa0swVHJOTHJQRWlhaUhFQXpoUmVQelQ0dU1SN2RTMXQxNFBz?=
 =?utf-8?B?Si9RVGFwV2lESFBISmhNRTN0Q2pEMHhGTHljZjd5ZVhaRklLWFhzdVkrSG4r?=
 =?utf-8?B?blBnQThHQVprNW5jMjNOdmpNeC9kUFR0dWovbU5MRlMwWVg3UUpkcVM1NFdh?=
 =?utf-8?B?dTQyekE0ZjF0SVZ5bG56MU5pbGhJekVMOUlpWGxSbWIyVnptckNRZDVHekRx?=
 =?utf-8?B?L3hOUi9Gdk5EbXpPbUUrd1JKK0JFczRzNG52R1ZqakZtYm9WSlNIc1BWUnJH?=
 =?utf-8?B?QzRVeWNQeU1mOFZlL05QeTFEK0VXeUozcEJsVCtUT1M4UzBoSlJRcWFzTml2?=
 =?utf-8?B?M2cxMzB6RHpHWEErVlJZK25Hd1ZLWmpNNTJxT1NRQWp5eHEzM2o3R1ZXVEhF?=
 =?utf-8?B?Q3lraVJqZ2ZaVlAvVnFZMHAzU2sxSDJXNzRNY2dTZjBNVDM5TlA1UWk5TXZW?=
 =?utf-8?B?TGtyL3N0QUIyeC9LL1JNcGlValcxb1FxL2hkalkrSm5KSVJKZEJJQnRGQzB5?=
 =?utf-8?B?dWVkTkVYTGxWWXoxTjdjTnlPSS9HOHI0MktxYnZYVVhUWXhMVmE3aDFVdmky?=
 =?utf-8?B?VzB0NlFkcnNIdGprcEdzQ3lIOUhYRXZIcDhBMnNnZHNXbzI2amY3Y2IrMndV?=
 =?utf-8?B?Qy8rTTdJczZVUkxxY2ZuSnVkRmJzOXpmVzdiMWtISzEwN1g0WmM2ZnZnOEhT?=
 =?utf-8?B?R0NJM1V5RURLUUlNV2cvTGhuemxVNGpXSjRTZkpXcUpteHRlQXh2ei9jWjhW?=
 =?utf-8?B?c2dwU2RQSFh4Z1FOV3ZpK250U2Y0blRsNldnM0Z1R2dVaGlzRDhOSURiMEZm?=
 =?utf-8?B?ODh3UFloTXJHb0poUjUwNWJ4Z2xCdjU2KzVkODQ2VFpXZDg5MFpoTENNcWdn?=
 =?utf-8?B?UHlnWTZySndLTFFMZ2hIeUxBNE9ORk1Lbk5Ud1ZKNFNMMnJxZDJTTzJiTmJG?=
 =?utf-8?B?aWRtMEhhWVpWRFlwdDhwWEk2dXprUGtTMWl1NWx3d0RUVGlOTHVlb1ZLZ1ZN?=
 =?utf-8?B?V3ZhN1lmbzRMV2ZlTFNCNE5HUFdqR0I5UmdMcUEyY2dIcTVQNXNOYUoydlow?=
 =?utf-8?Q?vD7NtjIZcvY8Cz/nPuihITMou?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: id9kwpOvip1yLyYxRcXsZIa9595AiSZ/qsdfcjf/0IlqQWZ7eeH0tGW7WJJrENWuhkJjrP6r2vCghsrVdU1muh0NsIZY8j509bYynIbOz5GmyLJ02/xj5tHQ+0wCe1DP8ocbP0w23/IEE+LPZqJWIACH1GIr+CVZLaKgyLkdvuBTjPDz6E2n748x275+yIOM7tLwzRix2JDs8zfYHaJfatRyNrs3RXnkuOykjtnC+eM5TsJI9/p+X4St/vQTgzimBOrcbNyPSLGreRRi96ssgNxFnJFX+BsjxRgw655UcQkJrODG1/bmelvwKKdYv9uvYMQxzs4O8U7ufqShAJ9Up6EWCWsVz/7xuo+kBQinOBMaTuR1L1DSOF/0SSJIymUMYqenlul0mDXDXTMX6/lpHI1x2mhM1PvmuGgrO6m1uMzn/qWcfsUnES8vXVMHjVmw0cX63UTeigAedVEu9NcxJPWNjkXl8Au1CExixBb4xJ0eij65GfjUDkdMzrhALJjd0m2p4hi+MlPA53m+SdnIH5X1N5P26AgMiu9zt+CnIl7GQExv5eA8rdYsMYZIgN+iVsR0LgvsSIjnR1MNHVaan8a7jNmCQy6aDqlNFrFWXxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9309a24e-3254-401a-9e25-08dc2d8cb574
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:42:34.4463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crjs9nshMoV/P1rnHELkUyAlOfhySI74zIgQa+e82SSc9sCo93Geu5N6VmhW2iNZUS3rhgYRCPVh4ymENfsXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140145
X-Proofpoint-GUID: bjNFaSoaExjj7aIOvgz15jIWMsMdZ2qf
X-Proofpoint-ORIG-GUID: bjNFaSoaExjj7aIOvgz15jIWMsMdZ2qf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael,

I'm taking off for 2+ weeks, but please feel free to provide comment and 
feedback while I'm off. I'll be checking emails still, and am about to 
address any opens as soon as I am back.

Thanks,
-Siwei

On 2/14/2024 3:50 AM, Si-Wei Liu wrote:
> There could be a mix of both vhost-user and vhost-kernel clients
> in the same QEMU process, where separate vhost loggers for the
> specific vhost type have to be used. Make the vhost logger per
> backend type, and have them properly reference counted.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   hw/virtio/vhost.c | 49 +++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2c9ac79..ef6d9b5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -43,8 +43,8 @@
>       do { } while (0)
>   #endif
>   
> -static struct vhost_log *vhost_log;
> -static struct vhost_log *vhost_log_shm;
> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>   
>   /* Memslots used by backends that support private memslots (without an fd). */
>   static unsigned int used_memslots;
> @@ -287,6 +287,8 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
>           r = -1;
>       }
>   
> +    assert(dev->vhost_ops->backend_type == backend_type || r < 0);
> +
>       return r;
>   }
>   
> @@ -319,16 +321,23 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
>       return log;
>   }
>   
> -static struct vhost_log *vhost_log_get(uint64_t size, bool share)
> +static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
> +                                       uint64_t size, bool share)
>   {
> -    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
> +    struct vhost_log *log;
> +
> +    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
> +        backend_type >= VHOST_BACKEND_TYPE_MAX)
> +        return NULL;
> +
> +    log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
>   
>       if (!log || log->size != size) {
>           log = vhost_log_alloc(size, share);
>           if (share) {
> -            vhost_log_shm = log;
> +            vhost_log_shm[backend_type] = log;
>           } else {
> -            vhost_log = log;
> +            vhost_log[backend_type] = log;
>           }
>       } else {
>           ++log->refcnt;
> @@ -340,11 +349,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
>   static void vhost_log_put(struct vhost_dev *dev, bool sync)
>   {
>       struct vhost_log *log = dev->log;
> +    VhostBackendType backend_type;
>   
>       if (!log) {
>           return;
>       }
>   
> +    assert(dev->vhost_ops);
> +    backend_type = dev->vhost_ops->backend_type;
> +
> +    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
> +        backend_type >= VHOST_BACKEND_TYPE_MAX) {
> +        return;
> +    }
> +
>       --log->refcnt;
>       if (log->refcnt == 0) {
>           /* Sync only the range covered by the old log */
> @@ -352,13 +370,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
>               vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
>           }
>   
> -        if (vhost_log == log) {
> +        if (vhost_log[backend_type] == log) {
>               g_free(log->log);
> -            vhost_log = NULL;
> -        } else if (vhost_log_shm == log) {
> +            vhost_log[backend_type] = NULL;
> +        } else if (vhost_log_shm[backend_type] == log) {
>               qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
>                               log->fd);
> -            vhost_log_shm = NULL;
> +            vhost_log_shm[backend_type] = NULL;
>           }
>   
>           g_free(log);
> @@ -376,7 +394,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>   
>   static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
>   {
> -    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
> +    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
> +                                          size, vhost_dev_log_is_shared(dev));
>       uint64_t log_base = (uintptr_t)log->log;
>       int r;
>   
> @@ -2037,8 +2056,14 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>           uint64_t log_base;
>   
>           hdev->log_size = vhost_get_log_size(hdev);
> -        hdev->log = vhost_log_get(hdev->log_size,
> +        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
> +                                  hdev->log_size,
>                                     vhost_dev_log_is_shared(hdev));
> +        if (!hdev->log) {
> +            VHOST_OPS_DEBUG(r, "vhost_log_get failed");
> +            goto fail_vq;
> +        }
> +
>           log_base = (uintptr_t)hdev->log->log;
>           r = hdev->vhost_ops->vhost_set_log_base(hdev,
>                                                   hdev->log_size ? log_base : 0,


