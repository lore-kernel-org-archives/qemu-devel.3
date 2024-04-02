Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B1DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXUt-0002rg-5g; Tue, 02 Apr 2024 02:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rrXUr-0002r6-Mp
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:19:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rrXUp-0007Fm-8e
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:19:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 431HXTsX001164; Tue, 2 Apr 2024 06:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7qSdp1PjtYPoun9aAM7/Ck7wDA8YX54s8o/dqBa054c=;
 b=GyOu/4iD+sfZDjAnb7I55O0+16/IXLm2CwmcQAzCLn0lXJcfd7VLveMIXCpphwRzKULW
 dEJcLGZCfpbysgEr0uxxfHc7gyot9msEj0u+DASXeoah3ADdm1/+RnqF/Wg5ToTYsmo1
 3is9LJGontk3b3ipnNfv6CL9QtdWRTvNn4hbbYKaEoqdCrBFzHNDmRGUHnXIbT/BtxNE
 uzfaLaCQS2waaFEUy1qkabh+p8ykrHy7yPtbDRwgv8b+2V7ZWBpN1E2nCA73BkCmmQVq
 xYPDLzu4Lov/JeWPJHacSgeRbRHadF+/73I79KBfch/jGZ7Nc6SADCwB0HavPmQ1yoKj YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69h4kv9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2024 06:19:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4325Mvh3011791; Tue, 2 Apr 2024 06:19:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3x696cv9c1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Apr 2024 06:19:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc7uJrbS5P4bEyU6yZK4s37hk2ZKh0RzD75DCgGGzHkCwtZvFJFouAy31jKXdsuFLG8Wy7vRdYoUh5OD24YX8BnaSYNd+q+AZxZApwDy+J60PshK5qePW2iGtjvgpQtqh5abcdfqhCNA5uYDhLs6dVHT2ywhZ2Vec9eUKS+v9AdSUFhkZZJ+sb1ecWjfLhjbSAOacyPnWY0GwGbFfDjABTv6eYT1o8jt/ZpWz9i7up7G7+L7473fVnIp4MmHlFSaXhDKOCuiQf71UuEVtoGpegh3SbzbvMsC/RivdLK/NxH+hS7dw/mH74RKxn7xrECY/THoQRXZIsl5urruAaAQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qSdp1PjtYPoun9aAM7/Ck7wDA8YX54s8o/dqBa054c=;
 b=g8nbQH7+w7M/qOjkTd6PwhVlNYt5cTQ2P5Tuqb6auxLz8bRai+i4QBno24Ft635f65I3mxuyBD5zvPyZCOuYd9XItoGeJXvw3e86Stgfjvd7KATAIgZotxCwRMqicnT1oIqtkFDlx6DPuxrvc37LlK4BJyIoUJmO+z0RAk/WlXG2FCvbJyrBMB3XdIj4G5u8+dDPK9mXCxOnJfx6EO48Av7/ZCOJrxJJIkE9DnzF0E15FRYhoY/wUaAAajU9B2rcSBntjDC1dq4TK4R6knfOQumrPHQ2NUHE0NzDJXNK7/Kzd/4s6S4FmP5dJshIn4faOdCs6OX3SC+hOheIALuQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qSdp1PjtYPoun9aAM7/Ck7wDA8YX54s8o/dqBa054c=;
 b=Gt4p0NmIZ0evp3yyITTu2v0h5WAK1fB7dm4cqBJe9LsJB0HZ991/h/3LxjbaKObCXFPug0IquNifO0c9NztMFpCCUUaRmB8/AYj+zztsrDMSlYSGndCyP9O4e7T2aO/WXCfENadsK4J5nXrygRo/YWMPoxd4g1tjeujNQp/mvgU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN7PR10MB6330.namprd10.prod.outlook.com (2603:10b6:806:272::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 06:19:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 06:19:38 +0000
Message-ID: <58cf082c-fa54-48a6-aa49-e8b6cba60f53@oracle.com>
Date: Mon, 1 Apr 2024 23:19:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
 <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
 <CAJaqyWdDRqMEwVh6ZcVdnEZoXy-_9B2qk25eYcoVmeeTxgGm8g@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdDRqMEwVh6ZcVdnEZoXy-_9B2qk25eYcoVmeeTxgGm8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN7PR10MB6330:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhFUnAhROkWEvmUN0XUO6PcltLDPagNd804MEQVneSkwiweO+259cstMc6Anev0OA26C4TBG6ua4CpwRuvyBkP1drDF5yPVICc6Z8tx5u8SQCD/mspeFPQC+sYAgj87TWpyDJMbkreDYOIJLL1zyIfF6beGA561K78lP6HqMTqPipQRKGbh/j2Sp+ZBZV9YwogbEBCEbKeEBNxOiNx1P0hXksXH7z5YekDKNtasMMUlB8tIIijguAzKdaUPotc+13HhpfBLb5/LB2HppTNRM/2GdaHUV1v/nOUAFMv3OTdldi/lWwxq8+ANtC36at6MepbLePv4f6Rn11jmx8LcJUeRAc8JKWysXpq8pdHZol4MnJhqDYBAqxYd09Dysp0gxlm6yXXbSrhHVLb8IlBrGBy0lUKogBUnHYm7pmWxiVBe6/9qnRqFYqSnBxW2cdFlmpKTiTotggH7nA1a8eqMDoETOMvFJIvRvYHxvfm7Dcjsb252E6l4zWjBRYlBUmRmuBShoCIvye0/mu4we86WYnF1Gb48+hhZWuyVlyEoLvBnp96bUO8/vuC0epT6WrQSNbMUTYQ0doyUlbxDf1Lftmja8dBeFhO82Mqrh7vto/iT1ohHF9hRoDlLHB5pmgR5/W1iyeF1Rx73GaJXGW5Ek6jXpCf88t5kpluWlkFZXg8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFLWldTczRycU4rRWhJbGZOUEZBWDdrQlh3M21XQkV1RUVNaUtwYjNkT2VF?=
 =?utf-8?B?eCs4RkEzMVExK0hUdXRHQlV1akRIV214SjhqZlNpZVFCTW10am9ydG8vblRH?=
 =?utf-8?B?eU55di9xV3VxT09oZFFsaklQT2NDZWVVV0lDY2xLcUh1U1JqZDJMaFJWWWxY?=
 =?utf-8?B?bHFKMmt2QTNJd25VWWdvaHlmNEpPOGZDWWJXaEgvai9TdE5YRzFrVG5weFRJ?=
 =?utf-8?B?Sm4wMytPQ2xTNUR4Tm5QVmlwVkhSU1lNUCtQOVR6K3IvUmo1TEhhTUhCKzFt?=
 =?utf-8?B?UW83Y1FWQk5JR3ltZitwd2lWVnArdDMzTkdrTDh0SndwMVZZKzNsL040RGpV?=
 =?utf-8?B?cUdsU1I4VmhIMDRudDJ2ZThSVXNsZXcwT00rQzVlZG16TStod3JmaWJsODJw?=
 =?utf-8?B?WjVsNVprYndZUlRRNk5iWXlNOVpqd0tXUW1XSVJydVg0czduUHYxL3JzQXlX?=
 =?utf-8?B?eXgvbE9xWTFpMnlNMG90Z1o1alhVWFJKZDFBdFBGSjk3by85WDR4WGZMMjhy?=
 =?utf-8?B?U2ppa0RVUjNyNHF3V0xTOHd0TE04a3hLL1pVSkdEUGRwQTJVaytGZnZrK0V1?=
 =?utf-8?B?RzVqcHVKd2NySG10T2xPVE9sUHhiUE43Mm5NSzRjbTN2czF4c3NrUjRDSWlz?=
 =?utf-8?B?SDJMalhsWC8xYUEzVmlQZmRidUVQbDdKcTgraXFPSU1YelBBWFZNQzBGVGRI?=
 =?utf-8?B?L3FIR0N1TWFmaFpndGdrTnI4bHM0TjNramthSnIvT1pkS1lka1Z5amhMYldu?=
 =?utf-8?B?VzRIZ2VjY1FLM1NlUTR1eWpwOVF1K3ZFUFFETk1uSmlLVHdWWGFuSDJ2Znd0?=
 =?utf-8?B?ZUtmaWxzVk1VQ2xieFgxSExDNGM2VUlETW9uakdEWHhSeW1Palh2ckRWZXZV?=
 =?utf-8?B?aWN6bktJQkl0a21UY2JHUm5BTFBQVU5QMkpPL1FnVVp1dEZMelRIYUVSdDQv?=
 =?utf-8?B?SXhHalJ6aEwvVmM2TkpFUlBMdzVPQzU3YS9lNCtwV3ZyVnVSTEsxS3NzUHFw?=
 =?utf-8?B?N2NHYjNLc21yb2hiNE9hMGdlV3AvQlBjU285NzBMVCtBeFBZcldtbzIxQlov?=
 =?utf-8?B?ZUJtNTB6V0xuWFZiOEM2YlJvb0NyeUM1NmpHM0pXRFZWMXg5YjM0WUtQVkZW?=
 =?utf-8?B?MWp3SGdZaFU5SkNCd3A3ZHFmWm9JSXRNc2s0UGsyZ2pqc3ZCNUVTZUozYVFs?=
 =?utf-8?B?akVQekdUUkgxZzkrczRXUnZuVjhTSGZRSGFpMWNuc1lXbW5DaVBrWk5LMndh?=
 =?utf-8?B?UksrTUNMTGZrN08wczZNNjJieFFpbGJ4Q05tdnJJZDVPYnR4ZVIzVkZadFZO?=
 =?utf-8?B?OHBLOW5uQ2pPWGdxY054ZEdaR2ZZSk9MVzJxZWlEMllZQTVkL3lLTWNYOGRV?=
 =?utf-8?B?M3hQUHF0WHcyRCtMZ1YwRVZublZCcE5hekRQOE5HRzZxZFI3MzRzZ2Zucy9W?=
 =?utf-8?B?akI5TVluQ3VIOTFSa2lSY3F3YkEvcGp5aXZ3WW9qcjMzUHRlNXZYblZUMGlo?=
 =?utf-8?B?b3l0NllnU1NFVXMva0tNNlFVSk4zemtTSFBjcHA0c0UyZldJeWFqNEtMS3RD?=
 =?utf-8?B?TWc2RTY2NkJrZTZkOFJxN0FCem9YWlNiSWNuYWtVRUZPVjNFWVhLQ2pYMGc5?=
 =?utf-8?B?WDFscHA3V1ZGTmVsYlZ0b3YxQy9OTUMyU0M4TTh6aGJjY3UxSnYwN3hpWHps?=
 =?utf-8?B?N0ZJVGxzRnlobUo1NjNGTHdxQ2tiajV0VUVCallqNDhmQStHZ2EweFJQNXpO?=
 =?utf-8?B?ZXVMQ0hWWTBhZFM3QjgvQzNaNWtXZWRwWCt3OU5qUEJuY0Y0bGc2RlBIMTIz?=
 =?utf-8?B?UkdycDBuVjRUWS82NzRCcjE1NzFxeFhyd1NRRWdyRjJRK3JNYzZWRHNjTndV?=
 =?utf-8?B?NDl6eVo3VlA0V1RER0c0QzBqa3JMUjc5b1NqeFIvZjJGWmMvcDcrL3dmK1VV?=
 =?utf-8?B?dkNuczVKU00yUWlObUpyWW85T1NPUTFycHVXUHFNeDlZTmlFNGh2amJMdzRR?=
 =?utf-8?B?Z3M3OHRBMHlkaXBZNFVBMmkxd2VoVyszbWUzS3h5Y3VuTStjdTFmWXhyS0FW?=
 =?utf-8?B?S0NGaGpSclhLbU5pRXNiZ0daWWdzV05VcEVDU1RFUWliczM5b0ZkWU9kOGQr?=
 =?utf-8?Q?ng3r+6vRjglyUgTPF60Zcm+Hi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nVJ4XDHS+KUfl3M3ChkS5hjCzJD1v6WodNKDSrXtMHoicl2y1YDoLc2JEboNfzadSNnYtJA0O1JDKUUhKVcM1PlZ9QdNBotyD+d6IVU/24bpdf2XR2JDMqb2niB+Liy+VRRcYSdX+iaSeeyBMWW6qhOVEsip19xRfqy9QExhVEwpVaZqx/t84RIAhO8j9D4wawww8Os6+pUB1NrRdDhii97icyr9YQ7yBlJTke2Mj79ts+4GEUVIqdev4Q71/tBUZ7ED6NsdiqTJPo2sziw5hpRG4a4XBZbS8Qobxy/q3+drXZiLo2hSu6Yxypo1e5p7U5K2NcLynW+fYJUgl2E+o8/x0hfkOcqX8Xqe3opyMg4I9sejVshfPTg90hWIicL3w+lFTy45SwzQir8ye/An09VUIlPol2rH+GWMbOOOq1xmLelndu6Q2wqzycwKeg2LMrgD/0ItXi1TOrbuj+MD+eYIgjdqm+ebRmRZUBRIkM8F0lu0MfdLsymmqKZkHZGVf0m/eoD74YDtI3s88G9d3Qj4+gWtDraWIUJtPWMKCj4iw8R1T8dc2Smjse0Gl8Z42R7IKl/xDP4wed5jEN825hxRfGZ008aeEgsX7lbJQ4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e623cf-2063-4143-4092-08dc52dcdfdb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 06:19:38.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CFEo86EkMrJJuJ0OKA5CFDjn0mgXKJvuR5mL/k0EI0hLsF1QWPmG0j+BESCCSlEYsLST8H7+EFl64fj5jxz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_02,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020043
X-Proofpoint-ORIG-GUID: rnoxQraIBnIFEBnBhUbnHhsna6eABnSQ
X-Proofpoint-GUID: rnoxQraIBnIFEBnBhUbnHhsna6eABnSQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2/14/2024 11:11 AM, Eugenio Perez Martin wrote:
> On Wed, Feb 14, 2024 at 7:29 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Hi Michael,
>>
>> On 2/13/2024 2:22 AM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
>>>> Hi Eugenio,
>>>>
>>>> I thought this new code looks good to me and the original issue I saw with
>>>> x-svq=on should be gone. However, after rebase my tree on top of this,
>>>> there's a new failure I found around setting up guest mappings at early
>>>> boot, please see attached the specific QEMU config and corresponding event
>>>> traces. Haven't checked into the detail yet, thinking you would need to be
>>>> aware of ahead.
>>>>
>>>> Regards,
>>>> -Siwei
>>> Eugenio were you able to reproduce? Siwei did you have time to
>>> look into this?
>> Didn't get a chance to look into the detail yet in the past week, but
>> thought it may have something to do with the (internals of) iova tree
>> range allocation and the lookup routine. It started to fall apart at the
>> first vhost_vdpa_dma_unmap call showing up in the trace events, where it
>> should've gotten IOVA=0x2000001000,  but an incorrect IOVA address
>> 0x1000 was ended up returning from the iova tree lookup routine.
>>
>> HVA                    GPA                IOVA
>> -------------------------------------------------------------------------------------------------------------------------
>> Map
>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>> [0x80001000, 0x2000001000)
>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>> [0x2000001000, 0x2000021000)
>>
>> Unmap
>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>> 0x20000) ???
>>                                       shouldn't it be [0x2000001000,
>> 0x2000021000) ???
>>
It looks the SVQ iova tree lookup routine vhost_iova_tree_find_iova(), 
which is called from vhost_vdpa_listener_region_del(), can't properly 
deal with overlapped region. Specifically, q35's mch_realize() has the 
following:

579     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), 
"smram-open-high",
580                              mch->ram_memory, 
MCH_HOST_BRIDGE_SMRAM_C_BASE,
581                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
582     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
583 &mch->open_high_smram, 1);
584     memory_region_set_enabled(&mch->open_high_smram, false);

#0  0x0000564c30bf6980 in iova_tree_find_address_iterator 
(key=0x564c331cf8e0, value=0x564c331cf8e0, data=0x7fffb6d749b0) at 
../util/iova-tree.c:96
#1  0x00007f5f66479654 in g_tree_foreach () at /lib64/libglib-2.0.so.0
#2  0x0000564c30bf6b53 in iova_tree_find_iova (tree=<optimized out>, 
map=map@entry=0x7fffb6d74a00) at ../util/iova-tree.c:114
#3  0x0000564c309da0a9 in vhost_iova_tree_find_iova (tree=<optimized 
out>, map=map@entry=0x7fffb6d74a00) at ../hw/virtio/vhost-iova-tree.c:70
#4  0x0000564c3085e49d in vhost_vdpa_listener_region_del 
(listener=0x564c331024c8, section=0x7fffb6d74aa0) at 
../hw/virtio/vhost-vdpa.c:444
#5  0x0000564c309f4931 in address_space_update_topology_pass 
(as=as@entry=0x564c31ab1840 <address_space_memory>, 
old_view=old_view@entry=0x564c33364cc0, 
new_view=new_view@entry=0x564c333640f0, adding=adding@entry=false) at 
../system/memory.c:977
#6  0x0000564c309f4dcd in address_space_set_flatview (as=0x564c31ab1840 
<address_space_memory>) at ../system/memory.c:1079
#7  0x0000564c309f86d0 in memory_region_transaction_commit () at 
../system/memory.c:1132
#8  0x0000564c309f86d0 in memory_region_transaction_commit () at 
../system/memory.c:1117
#9  0x0000564c307cce64 in mch_realize (d=<optimized out>, 
errp=<optimized out>) at ../hw/pci-host/q35.c:584

However, it looks like iova_tree_find_address_iterator() only check if 
the translated address (HVA) falls in to the range when trying to locate 
the desired IOVA, causing the first DMAMap that happens to overlap in 
the translated address (HVA) space to be returned prematurely:

  89 static gboolean iova_tree_find_address_iterator(gpointer key, 
gpointer value,
  90                                                 gpointer data)
  91 {
  :
  :
  99     if (map->translated_addr + map->size < needle->translated_addr ||
100         needle->translated_addr + needle->size < map->translated_addr) {
101         return false;
102     }
103
104     args->result = map;
105     return true;
106 }

In the QEMU trace file, it reveals that the first DMAMap as below gets 
returned incorrectly instead the second, the latter of which is what the 
actual IOVA corresponds to:

HVA								GPA						IOVA
[0x7f7903e00000, 0x7f7983e00000) 	[0x0, 0x80000000)			[0x1000, 0x80001000)
[0x7f7903ea0000, 0x7f7903ec0000)	[0xfeda0000, 0xfedc0000)	[0x2000001000, 0x2000021000)


Maybe other than check the HVA range, we should also match GPA, or at 
least the size should exactly match?

> Yes, I'm still not able to reproduce. In particular, I don't know how
> how the memory listener adds a region and then release a region with a
> different size. I'm talking about these log entries:
>
> 1706854838.154394:vhost_vdpa_listener_region_add vdpa: 0x556d45c75140
> iova 0x0 llend 0x80000000 vaddr: 0x7f7903e00000 read-only: 0
> 452:vhost_vdpa_listener_region_del vdpa: 0x556d45c75140 iova 0x0 llend
> 0x7fffffff
Didn't see a different size here, though if you referred to the 
discrepancy in the traces around llend, I thought the two between _add() 
and _del() would have to be interpreted differently due to:

3d1e4d34 "vhost_vdpa: fix the input in 
trace_vhost_vdpa_listener_region_del()"

Regards,
-Siwei
> Is it possible for you to also trace the skipped regions? We should
> add a debug trace there too...
>
> Thanks!
>
>> PS, I will be taking off from today and for the next two weeks. Will try
>> to help out looking more closely after I get back.
>>
>> -Siwei
>>>    Can't merge patches which are known to break things ...


