Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6222C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRAGY-0000rZ-Op; Tue, 09 Jul 2024 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRAGV-0000n3-Bm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:48:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRAGN-0000U6-Bo
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:48:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT7RV022747;
 Tue, 9 Jul 2024 12:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=SrFisW7vkHOf9MOjBACDK65qbTqbsRjc4A3D3RJhn34=; b=
 bYLq5cfQ7auNWBwEROFx2LbvJmPBBVDWeGV06fMLIzmbY/z9ZEosqVkaslmB/DDD
 rCV2/tL8h+rTI4ZdLXCxj1sPZk30yU8vvdZYv8dUC9b7nS/JseF+zlEc70iFsE4i
 x27lzAqHNg6ARme1DPFgZ/Y2jNXojART9vXQ/hejUpNWzvtO+S48ndvjD7XuH7sj
 FyHeCasxkRenBcIUG1vwoAijSm6QKYrHQKHopuERC5bLY2qzmm8Gs1qc224Ihv0i
 I1DRGVf2MmQGlsXY3He6MtTbmOTJY6EY5ojVCfWEQyRhG2OnLJWNn5rbxzVygTVd
 vGAAvWUNdDRtk79bYE4fmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8cs7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 12:48:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469CWjqm029834; Tue, 9 Jul 2024 12:48:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tttm0pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 12:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu2NrfwCYYUijGxKDdQ/iJeeu7NtE9TfODIE26yN3Sro+JiMAy2FKk+V3xuKKJ1ze15q8rWBPK7wKTPy07SabSNQUjsc3qxSfSaS3dZO8Ne0CM+Mv1PHiLlxMrHu1xgWQdk5EKIbmB1m1PEavuo04TDIPp8X2haK3QPKSiGk9ufUdAb3J1uehoYMWW0eTdXcY+666TQzoh+QCxozcwXmYP6Cjd+4D5K00rPchuYW+piMt3U4Mu+xkin9KVztW2ifntKJyEYDwIE+DzsLXqoZhlHNFaeWC7OkPqMpffzbvhLc36GhRSptudsseZYyJh351pzN4SbaFcZgeOWjbk3XiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrFisW7vkHOf9MOjBACDK65qbTqbsRjc4A3D3RJhn34=;
 b=KBkQ8YepmzvGNB4ge9+PQ/RdKpd/B1xCppwZK4fv8qXMqhAasGjqoN6l2pqrpuCWul1TOpqH9Y1Fndtjdb9yYMw7Qw7D2vFpoOt6djYLFpes1k2Ub2Y8ZK2x39NHjpW8ifQpNrLpoeET/+23Yw3XKvyE9QnnQ2NZTkgi6oLn+sU5hv6HboknfK3+goHIVD+W8rfGgO/2SkT076Qda2mnMpCRuDSNYJwuVW5pAsPy5v9YzcGrelCkDYN9rK6od2+CQ8g4TK3pM3Mco/KLiJrnvZW+lAb2ipO2wXRbCis6QKrznejhJfb1ktkUasOd7Z6rCsKKYHhFJLmDGsxTc/NBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrFisW7vkHOf9MOjBACDK65qbTqbsRjc4A3D3RJhn34=;
 b=lxpM5jc5eeMdHWmUKQYyMhO+Avxy6bDExh8wff3K2uWFvD0F7GoV8CUrY46XlgpmFXVngGlNc0E9Z3FbtxjNJHvrTsu7Mccp1xLCTPAigrbZ9kMF2pmbVSGQOF4g95qTIfyO31YcXlQJ7QrJhwn+YvmTS7cDzleD5ibZuXhG0Xc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 12:48:01 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:48:01 +0000
Message-ID: <71f35047-d456-441e-9276-d8b952b0c609@oracle.com>
Date: Tue, 9 Jul 2024 13:47:55 +0100
Subject: Re: [PATCH v3 05/10] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-6-joao.m.martins@oracle.com>
 <a3f22b3b-e3bc-4dd6-b6fb-cfb726addfbe@redhat.com>
 <ce8515ae-2fd6-417e-9f2c-43bfb8b605c9@oracle.com>
Content-Language: en-US
In-Reply-To: <ce8515ae-2fd6-417e-9f2c-43bfb8b605c9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cac1361-bb56-4f19-f95a-08dca0155dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWhFYjRsVWRFdnl4Qy8rOEEzZFR1TzZnN1ViVXh1S0JYZHJITm05YlZONEgx?=
 =?utf-8?B?NTZ3RXB3aVFMUytkcEdHL2N1azY4ZnRlMExhR0JlUUdiNHVDMUdEb01vQjJK?=
 =?utf-8?B?OUNXWnlmdktYQUNkTWJwMHU1dzMxd2NRQjg1U1JVTU1NeHRHQnB1Y3ROVU40?=
 =?utf-8?B?NVhLeTlieWxEWjdrN0lZN09nNmkzeUJsVkVOUzg4WEQxSFlEdCsxVEoyM0E0?=
 =?utf-8?B?SjJ4YVFNZDZQM3REKzZIV1RPcyt4NVJrRnBCa1R6MXY4eDJoMjIyVVJmK3Z3?=
 =?utf-8?B?UUVnNnBYWWw3eEY2cnFGQzRKRmRnbmt2MlRMUlpFRWxOK2M1REpJUEdldUd6?=
 =?utf-8?B?U0pmNXMrWDM0SXNQam93MEh1NHZTQUlHckx2QytNRC8xWHBoVCtuQ05JUG50?=
 =?utf-8?B?RTdNdDgxQlF5M3hJam9OemRVdHFXUE9MeFcrYzJzMVA5Q3ZtdnBKbng4enc0?=
 =?utf-8?B?RHdCNXVmb0tZNU40ekRmd05WSnRxMGljUThCWVphZzhMTFV4MkRNN3k2bDh5?=
 =?utf-8?B?Sys2dDFINUxTYkpJNzF3SWZjOFIzU3pmRlc0RFV2MmxIVnpPRno5a29TNVBo?=
 =?utf-8?B?Z20yS2JGNURBekZHbEdzZGdtSmlEczNJV1FYVU1WcUFwZ05xRkNjM0pZaDB4?=
 =?utf-8?B?MTJoTGcxYlIyR0hSU3BkNFdBQzJLM1JZMDQrVk12cnZhVDJKc000eXRCTjFL?=
 =?utf-8?B?emw5SkZtRHc5WnltMTE1TTFxOFFTZlkrSldwdWJOVFZReE1TOXdZWE1TOUlo?=
 =?utf-8?B?OFN0UXpIM0owdDFwOW5ZeTgwWjNqNVRXdkl0RU1wSTlBSjRVbW5rSzl6VnBR?=
 =?utf-8?B?ZWFqR0V1aVNkQkxvUnQrd1JDVXRrZTY2TTZORnhSWHVhS2lBRXJnY3ZCcVFC?=
 =?utf-8?B?dmludllGWUViWDFOWnpDYXdIVGh4UlBsVUZoNHVEaDJ3Vno1MDhGS2RYd1dS?=
 =?utf-8?B?MklSOExLTEV6cjdiYmhlb2V0N3JOU2FJaDhPZFJ6cUtBM3BERkhSeTlSRDVp?=
 =?utf-8?B?MXhaTi9jVm9LeFI4U09MMFk3VFN2QXl1RExiVHRtdW9NZFNJam91aU9tcXBQ?=
 =?utf-8?B?UHZwQ1RaU29YN25qdEFoV2F1SW0yL3RLanJWSDhKdDBYQ0lUT09LSVFkWmZS?=
 =?utf-8?B?Qko5SU15K3FHS2I3SDNkbXh3MSs2Zmh6dC9XeE9nWEJRMC8wandkRGp2eDdT?=
 =?utf-8?B?dWswbko1T3Q5OCtROWVPN3FFZnVTNmltZFVST01vaEJPQnBjTTQxb2FybGw0?=
 =?utf-8?B?d3gvZ21nSXp4TTBtUXhHZ1AycmxBNE0xTXMyZnh6N2ZTbWh0YVlHdzZTTlkw?=
 =?utf-8?B?VyszVWpkKzkyYldhOGMwR2lUaHZFU2w2MnNVQWZLd0lWcFVVZkNwUjRRK2tV?=
 =?utf-8?B?MHBUa29HY3NobkRhYmkxNHBKUEd6am5OSnFuV0pMK09aM0ttZXpBTlQ2b0dx?=
 =?utf-8?B?V242QlBqUDgrM2ZHMWQ4RlpzQXhNUlRTT0ZmaFk0dmowQmE1NmFpK3IyRWcv?=
 =?utf-8?B?bjFLQVVEY2tYMGtuakM5RVhoL0NiU0YvNWNJL0Nvb2hCZXBudEpocnlNM3E2?=
 =?utf-8?B?eFllRGRsTXBjS0UvbTJBZFBLOVllL0E5bEYvaTQ1Vld6K0FLcnFpa1NHeDNT?=
 =?utf-8?B?azl0U0tLQ3NkS1NhRnJjVlc5U3ZKVjI4RFVNbll1V1lsKzJ3Tlo2Qmovenhr?=
 =?utf-8?B?ME5BSlN3UldYMXltOUZkQnY0YUszK1FnWUxIUnl5NXh5UjlYa2ttMmlrVFc5?=
 =?utf-8?B?aVdrdEhheUhHMVo4MlV5My9zbHJicmR5bWtLUnVEYXFOUXAzTkRvUWxFK284?=
 =?utf-8?B?eFBUY1VEZklPQ2NKdkVCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lOazBUVW5zZnZiTlhaT2hzL1BEMWlvS2FqNnpHNkhQOEMvbHl2eW92clp0?=
 =?utf-8?B?NjA5bVo0VmdSMVBGMlJsVVlERE90V2wwdktqU0c0THRMSUo4S1BIajNHZEhz?=
 =?utf-8?B?OXJxTU1MSW1yU2J4c01nM0hoRkxRUGdnb0N0WWFIMnhpMzFPcURGYUVJaThl?=
 =?utf-8?B?TlhwYm1nMTh2Kzh0dzFrUmlSNUUraWF5YnB5ZVRyRHdCMHh1Ukwxa1lJNVI4?=
 =?utf-8?B?ZWRnQkdHUWFZL0FWZzBqai95dWoxQ3ByKzJMM2hmaElLamhpMnpLTmJ2SzUx?=
 =?utf-8?B?T21tTkVXck1SQVpuOUtDSFNXRmFrNnBSNHBUZVpsaW5yckVLRThxUmt1Sjhz?=
 =?utf-8?B?QVlFUXBqdlNrdlkvS0gxRjdCM052WVJ1UXYrWEVIVFd6WWhEYnRQWDBwRXJV?=
 =?utf-8?B?V2I0QmtwWnAvUDZSNGQzN0FLajc1VC9WWFBNZjRXV0NGUlFwTmJnU2h4VHVs?=
 =?utf-8?B?RmJNZlh6UXVTTGxtejNRSkVaVFZFbmxhNk5CR0I0UUxkOFM5NDZrVEN6ZGp4?=
 =?utf-8?B?TkUyTFdiQTVvT1RhcHNUL2JhL0orMExtMXVvNU4wQ1oybVFCOWZzSWNmWm9J?=
 =?utf-8?B?dXNPTEdqQmRTd2hCOFVKRERJOVZOM09NRkxKWG1zS2t5ZytYRkNaQU5JN0ZC?=
 =?utf-8?B?SkhDdHVHMEhLY2NMVjUvZ0R0Q2hadUx4WGk5cXppQ2hhZHBVU0h6aVVYZEM2?=
 =?utf-8?B?RXJwRTBMSWlFWTMyNG05T2VnM3V1cktXN1hWRmZjaUsrWC9MU3c0clVhS2sv?=
 =?utf-8?B?Y3lMTGJabVhLbEhISEVxNWM2RytzUk05M2VtdzZUR3MwdEVCUGRGaHI1eU5z?=
 =?utf-8?B?SStDdm1vU0ZmMlhXNVZvTjVZZUZjTVBZVStDOTN6VWErTFA1My9KY3FDUkRT?=
 =?utf-8?B?cFM0dlpxQ3JzeFZMbzdwdk1tNnl0NHZ5RTNoTHN2MXJLNkRWNHVSM24yQ0Fz?=
 =?utf-8?B?OFpWeUZ4WGxxU2dpcHd0Y0dpcy93d0d2Ymllbm5jUWlYUVZmZHFxOHJmbkgx?=
 =?utf-8?B?UE5WNjljLzk2bnJkUkZ3ZFl0RG5BQ3Y3TnVpZG44ajg0ZTlIc3BULzc5UUZJ?=
 =?utf-8?B?M1BGZFlZTWJnUmwwNCtTYWlBQ2ZiL0RkWWNxRlFsSlJqL1dlaXNPUkZ1VW9B?=
 =?utf-8?B?elp0YlBzb0l4VHlzSDVtaE9EUUFST2NLYUpTZTJSbFBEcGZROUJzcllSMDha?=
 =?utf-8?B?aVVUM2FHV1FrMGRRa3N6RHp4bE9BdVQ4bjY2c01VY0hKZ2crakl5d094TWlJ?=
 =?utf-8?B?MzQzTUR0Tkx4WmE0ay9HUFJMUWFRa0o5TldyUGtlNnp1Y0NySWhKVGhTd3do?=
 =?utf-8?B?WHVUUm9UWktQRm4zb0NLRDdQcjFtaTN6VUw5VWovYUZUNWVoSG80L3U4R004?=
 =?utf-8?B?WW5wZ0wvQmxnVXI2QTBKS2RvRWpoTTJKQ2VHZU9rVVdHUTdYUU4zcy84ZkFC?=
 =?utf-8?B?dCtuSXBTS3c0dEN1UXlsM0hoNERHRFZHTzRkVlc5Z3dsd2NGMXlUb3Fna0lY?=
 =?utf-8?B?QlhvaHp0YkYwTWFEYXNqV09WNCtDdkxRR0gwVmdZT3JVSFZORDVJWEJhUktT?=
 =?utf-8?B?dHRZck5RL2w3S0ZacURudkJrcVBjZzVueG55NW1yWGt0T1RlbkgrbktZWVBZ?=
 =?utf-8?B?d0crdGNQTGRqRnlkajJXdWMxeS9sV2FueUdSbTh0dXR4TGpnN3hQeFM3NmdB?=
 =?utf-8?B?ZURPYm5nbklnMDB5NGtveVh0YVJrWnJFc3ZVVTJ1OVBRL25zM2xaK0RabFVL?=
 =?utf-8?B?MnJKR1liclpJcGxDa01rUDE0VTJRQmpXZmFkOTVZcWxaeG5kUFcwZ2ZiVFhh?=
 =?utf-8?B?REpEeUQ1aGd5VzBBczM5ejl4eTBsTWdmWkVqUTJwL1dEakh2TU9vc1FBbmta?=
 =?utf-8?B?bWNmMGo0Yk9QeUJ0YXdrZVZSM0hxZzl0ZkxrZzNGU2psbFlwSjQwSVIxZ2pi?=
 =?utf-8?B?TXhIempySGE1RGc3V1VsRHc0aWFpb280aVBQMEVCVUJKaDJmWkhaUzRDNS9y?=
 =?utf-8?B?Mm8zNCtDQmwwTFNaU2xUUnY2U3JtdmdFT0pNTHlCVUR1UUR5WXhqZ1dVNGg3?=
 =?utf-8?B?VE9xQXBKRDgzaGhOWWhFVSthTFJXc3ErQVVadktVbGhVRGtTNXhmK0ExSkhG?=
 =?utf-8?B?dlkyTlZSNDhRVGhpS1g1dlBXQXkwREt1RXlNVzc5eTFsR2pDcmlyNkFyd3lP?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tmTzZcB6Lg5kGDUrEIiGdGMoqm7WLDkzNMNUeTAQEs8oq+7RRuczVVX6N1l3zKct+p7+7hcncnSLksWB+aX1JGoBj6aPn879+8zfry3Cekb2foaIwxXJaBIH2Oo3hB3iguE39kqpprnxg/Rwu7NBjX4msFi7IcfjbBEdsApQpwQWxYGx66rRRTR/CYTHBwOECOHbP36tU8T29FKAQF3DKu/EurF/FK0Zh1jiRtMGqZqbafTd5fejB/aUA/KNNlVM/NP29WA6GXy1v/nN8IuK2UvXWIZ1nEfV8YZHn4X0dJLJdwSFmRgM27GnLa/9j1MhRGNXt0sBVI4BStfb9s2jG+N3lb+uJ2+ppJKCf/v5Tr1n0hMDW9WK6Y8TogmGU8gPhhyr69c9bpNrgRiaLsrxP41R03XT9nBmnl9+bp2//KSIOiMFl8rTBNdkEawc8TLo1TKnBHI3Ck83XlYadoF5Mq2IMj9MilxNIe7J8kNfPENj49nwOTsQZjVS0CpSNtlQEnG8iQYBe2P+TWm0fQjDEfGcDcp3LEMZDXEtOrPYQ6beRl8Gv67tzgwAC/uoz1DgKU+by7Jb92ejQCYyHBVV59eKmXVQkFYZBnx0vvfVKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac1361-bb56-4f19-f95a-08dca0155dd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:48:01.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhTIWoQstt68ClMY01w/2jHjOVZPPxPehaYokQKoXat+tNXcRL8G3+pIHdsftyEyuR0umjK8OpgXWuzOMkEDtgVtfrwds3LxTxQsFeVJvoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090081
X-Proofpoint-GUID: X7JKggIKv8jN6XEkf_xuqhonsyn3b339
X-Proofpoint-ORIG-GUID: X7JKggIKv8jN6XEkf_xuqhonsyn3b339
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 09/07/2024 10:04, Joao Martins wrote:
> On 09/07/2024 07:28, Cédric Le Goater wrote:
>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 2ca9a32cc7b6..1b5b46d28ed6 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -212,6 +212,20 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice
>>> *vbasedev, Error **errp)
>>>       return true;
>>>   }
>>>   +static bool iommufd_device_dirty_tracking(IOMMUFDBackend *iommufd,
>>> +                                          VFIODevice *vbasedev)
>>> +{
>>> +    enum iommu_hw_info_type type;
>>> +    uint64_t caps;
>>> +
>>> +    if (!iommufd_backend_get_device_info(iommufd, vbasedev->devid, &type,
>>> +                                         NULL, 0, &caps, NULL)) {
>>
>> I think we should report the error and not ignore it.
>>
>> That said, since we are probing the hw features of the host IOMMU device,
>> could we use the data cached in the HostIOMMUDevice struct instead ?
>> This means would need to move the ->realize() call doing the probing
>> before attaching the device in vfio_attach_device(). That way we would
>> catch probing errors in one place. Does this make sense ?
> 
> Yeap. It also helps centralizing cap checking in addition.
> 
> This stanadlone use of iommufd_backend_get_device_info() was also annoying me a
> little, and there doesn't seem to have a reason not to move the initialization
> of caps earlier. I'll do that

Maybe I was a little too early into this. I had the snip below, but I forgot
that vbasedev::devid / vbasedev::iommufd are used by hiod realize() and that is
done in the very beginning of ->attach_device() of iommufd backend. Not enterily
sure how to unravel that hmmm

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969fd396..42931891bf8e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1552,17 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,

     assert(ops);

-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        return false;
-    }
-
     hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
     if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
         object_unref(hiod);
-        ops->detach_device(vbasedev);
         return false;
     }
+
     vbasedev->hiod = hiod;
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        object_unref(hiod);
+        return false;
+    }

     return true;
 }


