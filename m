Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8126E7BDAC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 13:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vryhY-0001UX-Rq; Mon, 16 Feb 2026 08:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vryhL-0001TU-0j
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:31:35 -0500
Received: from mail-westus2azon11010063.outbound.protection.outlook.com
 ([52.101.46.63] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vryhJ-0000EA-IP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 08:31:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQCwjpK7XVA85StBF/pxSlXeNSkgzEllfwLRl0VQcqmPtHH3VoFdwdl4RfHqrQUFh/mWTChSK7KPMHBj+iuLq/NTZYP1B/3oR7Sv2PEWEULhppF583NnaiBYL9zMjV0oAZdBpggrsx9+kkc5DCAXh3U45cgf5H+LU2shkUuztin8QuBGZsX9AbwQ+KJoofq0OdT/uMpcxlDRBQh61AaT0YhKxYNyHSQmlreodWB4QcbhiJl8taWHy79PFmSeMBHERQTF0lsAQ82IgKxccI8jbdKnRh8XwdbhE5iqT2DIUqzjaLkfD7axZVdikdAGGOrA7ej8879233t+70F6pOxm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTXP4cdKiPOmsvCbvjeheodiaR9BCHSOHuBNS9OhJpE=;
 b=dwVDoUDvVzQCfO37b4/OKtQyrgEtRbP0iZZhFaoGfIFOuo30Mj9bG+mZlNOxOuEraibbUBWjqh6mZZi/QAboOBL2uHUG8iV0IZ+6gdpuzhG20BWhIIsbTI+Y0bxdsd9KRHBgEUR9wbuQXXUG5q2rQzrKajMf93EzCVIOHV+8hQbzkuhUgBr+QsjLFOPUliajNUo0oRu2pc31fR/fmazdiK/qBrdk89ZpMFH1koss9b7+VfwGBavnw8t4iF/gR5u2Hw7QacIvzTILwLOMJGHiyChXpIp/FS4AIpSqg8u4mD3pchv+93IFIYLsRz4KmBdewI2hkJd4zTStJJazLaMZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTXP4cdKiPOmsvCbvjeheodiaR9BCHSOHuBNS9OhJpE=;
 b=j/Cp4Kk3nEFkMS+SHYPu8/JuArOtWVDjufPk7txboIRCWYrU9EBGNegn7LrP0peDfhahUZOEsJ6td0Y7ShjSlUVV4gwjLoxmQHB2ftoq2o3gfegk/TbA/xv/CAFW0udqfVZMDmAOwdt6YEv/Ou1iBJ3IeKacJIEAdFmp8ip8V3X3CidISfKF+jTb8LIoC67Oc/DtdxKalUszDGV0vmbu2SPuzDx814venF8VF42fbfqsrCmUaX41QxyUAaceY2P9aPXZgnR9JxBgZWpe5EE9tb8bK+iDrMbOInlsZdM7/X28HoQuFCKOLtFrTf6ZU9AFO0fy7TXTxvRGl4wnpYGS3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:25:42 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:25:41 +0000
Message-ID: <28ce755d-c562-404d-a096-09b5f32f0945@nvidia.com>
Date: Mon, 16 Feb 2026 15:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
 <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
 <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: aad3cac5-a81d-4c21-139a-08de6d5ee1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFpScnhTZ3pIMWtFNFJSdWttekQ1OG5YR0xiUDliUFZ3ZzgySkpvNEdUSGw3?=
 =?utf-8?B?MUk0a05ZckwzcE9vTUZDb0xRMzdWUnNZb2lSK1pGbnArMFAxK1FrWmd1Nm1L?=
 =?utf-8?B?SmhjSFNZcWFMYVh0OWFSLzM0aGpIUjVqYzUxWVpVTTVqb0grV2hzZ1ZiRzd1?=
 =?utf-8?B?RCs2a1BvS1dyYjRTdVV4U3RIazFoUW05VTdGd29VcytPcVVqeW9MRlhJUFlU?=
 =?utf-8?B?ZjJaMDcvS2Z0T05BSzBZRDdhMlhkUjlONmt5VTEzdGtsUEFwUzRPdnd2OVc4?=
 =?utf-8?B?QmF0TXFYVzR4UU01T1B4aDNpQ2Y3NlhUZ3cvdllzb0JadGhwUGplTnBNRVhM?=
 =?utf-8?B?NGdmZWRpcWhUOU5hUEJlaEJ3YzN3dWlraXJMNzNqUldQRGxIaHpkQmtwOWFH?=
 =?utf-8?B?VnN6OEZaUUYvTUcvZVg1M01mN0UrcFdETVdjckNQNlcySjhZczRZM0JWNVhv?=
 =?utf-8?B?MllCWkdWbkRHRFB6NENaV0lJR2FKRW5QTG1PTldPS2FtN3pvTm1GR3dITk0x?=
 =?utf-8?B?U0hjRFduVkN5TXRKZlJrRVpyRm5MTU4xc01xc3B3RkF2amxEZ2xyWkpvSzFX?=
 =?utf-8?B?c2VzRUw2V1JkSVlya3hTSjlCTnc4b0Q1ZUovVzVZWDBnTFJyQ1FGU01vSzJ2?=
 =?utf-8?B?ZXJmSThuak94L200OWlVMHlNOStnSUNwZzg0N2pkLzhIV3NRZ0pTUldrdHFB?=
 =?utf-8?B?ZDVyUWY3cFJKc2Vmc3ZJdFBJQStMMmdCMk0rdlNRNVFqaG5lUkR0RnFYcTFJ?=
 =?utf-8?B?ZzN6a2g3NHN5ekZ3YlduYVhxbHBtUTBhWVhDRkFPdVJuRC9vTDgrUkIwVVhh?=
 =?utf-8?B?bU1acU90cDRjR3dKbFU0eUJMRVcxcDNmZFY0a3gvWEV6VGF1S3p1SWl3Vk9J?=
 =?utf-8?B?NVUwekduTFVHREhwWlFTbmxjWWUyZUFFRThPVDc4Y0xJL3VqTGwrR2JZQ0Jm?=
 =?utf-8?B?WW5jRHJXUmIySFdoOUFPTEFTU08xR3p4WGRIeVdHaG13U1drN2pLT3dreHJH?=
 =?utf-8?B?dCtDV0VZTDFYbzlwK244cVpUZjF5ZFZnNjI0cko2YmVkZ3RNaXFrQUtwNll0?=
 =?utf-8?B?ZGI4anBWYnRXc1hmbkhtYTMveUIxQjAzekZPbFhpSGlKU1NhRE5vQW9MN1V1?=
 =?utf-8?B?a2tTdXJ5eXlFOWZETjVxVjNueGxpMWxCZTFRZjhwZW1zSTRCN2NDczFYall4?=
 =?utf-8?B?NGUveHNJMGdCRXgxZzhiY3dkUWJwZ0NpS0pMQ2Y1N0p0djNNMit0Y2lnZnlU?=
 =?utf-8?B?ZEVBV2Q4dytDOWV3WnBERDA1VmtBdnp4WEpIRnRVNUZxOHJtZ2hlL09vUTR5?=
 =?utf-8?B?dndMbEZaMG5BeEFPZUpObGREeHhmS3RhQlZNdHVZTFIwUisvc2p0SXcrallZ?=
 =?utf-8?B?M2ZhQ0w5SjYwb3VkandzS2gxVGc0TGFxY2xqSEtSYjNnaVlhandTb05RQW55?=
 =?utf-8?B?NjM1aHM2VDFqQTFUUUVBam9NZ1ErT3pmRGtlRVhQdzdNbDBXU2tIVFEyVk1Y?=
 =?utf-8?B?NnBVMUMrY0JNVzhCT3U2cXBHc1h0M001SWFNcXJHM2ovY08yR21NMXdPbHAr?=
 =?utf-8?B?dXdvTVQyN0crOCtlbnlOc2FhMERwUVFVMHk3TGVJMUhZUzI0L1lRWmluNnFh?=
 =?utf-8?B?YzA1d0ZwT0psSjM2UkhDTHVVWVB3R3dnVFlENmR6VDlqenMrdlRJZTFIckMr?=
 =?utf-8?B?UDhpNlVVNTZNQ2hLMVdmOFpRL3c1VFBGTkZmYVVPUXVwTHQvMjBlMml2aDVU?=
 =?utf-8?B?ZjVzUmt6SnNMWTRWZi8ySXVIZUZwWFVVZnFjQUNlN2FVdmRyTXZuT1NBeUU0?=
 =?utf-8?B?bitPdFdQR0pCanRHVjRqQzhOVUR2ZHVmUi9nY29JV0duTVlnV1RLRkJScUh3?=
 =?utf-8?B?QUtPYm9mbzdIVHZzaUlocHJjQWh0OGJReC9WcGlpSHF2SEJFeDdUSEhyRGNk?=
 =?utf-8?B?SmRQM1FUNlA5NjlBdU14Rlc4dlcrdTIvM2pvcEVLcVpuYkxRQnBDRjZ4Tkdl?=
 =?utf-8?B?WVFOSGRHMUpPc0FWQmFmMzB0MWNkMGhoUjBpSEhHMG1ud00zMnE3NEx0Z2tm?=
 =?utf-8?B?RytMbEJjODZaaktYSGlRSkJXV3o3TW1hVUp2QUIvTk4zVG8rTzBnLzV0NEdq?=
 =?utf-8?Q?wAt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2l5dnNRejBwRVBjYmtmVWdKdm9qcUd0UlVtR2Y4Q1Q4bWNGTUdMWFpYTHMr?=
 =?utf-8?B?YVRNOTBqa2dCMDJhSWhhNjgzTk91MkxWV2FsdnFFamM0MnJJME1DdHNsZVRJ?=
 =?utf-8?B?Nnp1ZjVTQTNzMTdWaC9yTEx4ZFdOc0kzbS9BQ0ZHQkRIbzBKQlh1K3pKTkNS?=
 =?utf-8?B?TW1nWG9EM055YXVyR3dxdEFLblB6ZXAxNmFqc2pmT2paREtqbDU5V3orckxu?=
 =?utf-8?B?b2lleVJpNU1BbU9XRmQveFhJa0tBcVcrVGtJazVHUjdVdndaNkVUeTFYMzVi?=
 =?utf-8?B?V0V6ZkdTejdrUXF5bVhkeXZSR2p6OUE5SHNRS1l1Mk1LaGxBN2Ryem1BS3g3?=
 =?utf-8?B?SzlTOS9xTVI3WTUrV1ZwbXpDTkZSSDh5Z3Y3T2lTdDdOMUU4RjQ5MXkwbWZ4?=
 =?utf-8?B?cnRxM1Q5RXRSQ2pQNzFxUzFibFVtRS9RSDBxZVdQN2M1RmVkNGpqdm1nSVQ0?=
 =?utf-8?B?TzFvb05QQk5adk41NnF5NFEvMGExTFVYTnlFSUN0Sm5FVnRxQUxqeWNST0Fy?=
 =?utf-8?B?QUZNcHQ0SWJVbnJNNlhNaW5yOHJQbk9yYnA2K0xxeEFuM0E3S0VqQkJQeHVx?=
 =?utf-8?B?ckZCMkZkdGNGWWhJK25MZjdHRmhkdTJjZ3BVYVkxRWs4dm1nMk80dFdZZ3hz?=
 =?utf-8?B?bmdaOXhNOW5PT3hEMWVvd3RvNlN5amZKTDdCOUJVTVZHbkR3TXNJVm9QV0tw?=
 =?utf-8?B?ejRrcEErWC9ISHloc3lUbHB5UFNLcG1mSGIxWlpiOXQvMzk1OHlIV1BvQ21J?=
 =?utf-8?B?RTdmZTRhbXY2RU43ZVdoVGlOVS9xZVZaMGZtVGgxMlBETGJkM1FCNUxjai9r?=
 =?utf-8?B?dFhSU0FuZjV3NHdWdExFUWMrejlsblh0SCtrUmx5R1J4UjZJSHZ6dThjTkRV?=
 =?utf-8?B?LzhzRTBLZFlZbU9QL2gxbVhITUNQTHN5Q21UUHJLRmxVcXVBSWRMN2xiU3BC?=
 =?utf-8?B?Wkt1S1BDVC91aHVIcUlTTkRPd1VJVXVPSzN0UloyVmg1a3hZSWhGWXRCMnpD?=
 =?utf-8?B?T2xKeExlSktGbEJUaFF3a0NqZmpaSmZ3RTVaQjhZait4U0piY3hQdmhOREFC?=
 =?utf-8?B?REJRcXQ1SGR4SnprMCtwTTZtY2s4ZmFuNHBqZXF6M1A1VUNSUGw4ODZUVGVD?=
 =?utf-8?B?a0JLbG9RRUI0U3dHeDVvV3ZZK1QzRTJnaEJ6ZGdCNUF2YkJ5Kzg3TnF4Tngx?=
 =?utf-8?B?OERBdmtnR3J5TFo4NUZPMWZoVUozUjUyTHZoYTlWd1NHOFVZaDZRcE5aVlZt?=
 =?utf-8?B?MVJKcGJIVkFzdkVYbmZyVXMxcUhGOEJMZ29qVVd3eWVhR1FBL2EzSXd3d0tU?=
 =?utf-8?B?cEZWTjBoS1F1ZHZMZTYxTndIRXBEY2d4bGpndmc1UnEyQWt0YnRrdEZUVEhQ?=
 =?utf-8?B?V0t1S2FpWTFDcHBiVjdkb0ZGSVo0bGxydWFKQ0cxSDNRcEFEQUpaWURSMTRq?=
 =?utf-8?B?OHFqYndGRDBaS1dlR2UwNWswTDlaS3A3UzNiTGFRL0ZvVVpVaGFnSWd4VkVN?=
 =?utf-8?B?ZlB1bU9aQlFoRHhzWnJybXAyb2FiWmpoZTk3TVpFT3hvMTNRWkgrbmhMT1k0?=
 =?utf-8?B?K3pzWVBRbGVuR1REa0NtNkZzYTQyWnh4ZGtHQUFneDlZUjNSRS82eXVra2Rq?=
 =?utf-8?B?Wjd6dnJOOWp4SlF5c0wzNHEyNGZPMEoycnRFWlcvUEw5bTJDamdnK3lObkJJ?=
 =?utf-8?B?eGRzY05KSFphOXBtTmpzWGpVZU1ZeUNOejhDUS9nVHhwMlB4TXQwNXF3Q09U?=
 =?utf-8?B?cGR6Z0dCUHBkRGNyRytWWHhaZnlCbFNZSVh6NFFscjcvQmZ3VEVvRldMaUhz?=
 =?utf-8?B?NHpYY1dSZnNNR0N2RVRWRmRIK3hReWM4TjJoTHBuK3A5ODVFRDNJZFpYbEI2?=
 =?utf-8?B?d2JnWHcxMXYvZTlXL3I5MzR2allNVzRIcWI4dkRUdXYwVElDd2VXRWYwWXVp?=
 =?utf-8?B?dTVFTCt5ekY0di9Qc05pMXVobjZ0c1F2TDlidjRjc1F3MzBRQSt4QnlrY1pq?=
 =?utf-8?B?blF2Z21idEdwdmE3eWtTUmNaTUMvS0pxV2dKRVVGZ1R5V0ZzRG8vVFZpNnFG?=
 =?utf-8?B?ZTNqUTZqYVFQUmV1TzdoeGRrQU93dFlka3JpYUtCeFhsbzd3YnVhbks5VFpw?=
 =?utf-8?B?enVhb3Q0alV6SjU3bS9seDRPaHdPb1NJOTZ4MnltM3R4aGxTdE5OTU5ZOTRW?=
 =?utf-8?B?M1ROQ1oxaE1yMTFwSUc5bm4xaXhUM3NrT21vS1AzZGJtTGJKcFU4M05VSXI4?=
 =?utf-8?B?V1NoaE9pbFBOd3JXRTcwV0gzS3dCNy9NTXlMNjQrOWZNcGt4a2s3VTdTdUF4?=
 =?utf-8?B?NXVJWEtnclVIT294blZCVEZOQVJLWW50ci9TekhIQVlad1pmbGJydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad3cac5-a81d-4c21-139a-08de6d5ee1cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:25:41.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmoz0/M3TmBVqVdPC1rHVZFVCbSw1ag6I/WKLd8oxEF92/B6tNF4unJPJVOxa7sSTPBR9WRaHJ3BKi157rKp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
Received-SPF: permerror client-ip=52.101.46.63;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/16/2026 2:22 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Peter, Avihai,
>
>>> As for enabling the VFIO migration events by default, I guess we
>>> all agree it could be done. We simply need a stakeholder to change
>>> the default behavior.
>>
>> Ack.
>
>
> There could be value for the sysmgmt layers to receive a VFIO
> migration event reporting progress. For example, an event could
> be sent from vfio_save_iterate() including relevant size metrics
> to indicate progress (or not).
>
> Any opinions ?

Amm, I am not sure an event is the right way to report VFIO stats, as 
it's not some change that mgmt needs to be notified about promptly.

Mgmt layer can query migration stats when needed using the QMP 
'query-migrate' command that returns, among other info, a VfioStats 
struct with the total amount of VFIO devices data transferred. If 
needed, this can be extended with more info about remaining data size, etc.

Makes sense?

Thanks.


