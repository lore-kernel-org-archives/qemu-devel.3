Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5918EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6NK-0005Ud-Pd; Thu, 06 Feb 2025 13:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6NI-0005TG-OX; Thu, 06 Feb 2025 13:13:16 -0500
Received: from mail-bn7nam10on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62c]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6NG-0005Lt-Ke; Thu, 06 Feb 2025 13:13:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDbwYtGDIGvpJuz1O3UpKtB+9ql8kRSt39RG+BrbwvxmzokS0YI1OkPPHCeK/Tjn7sSvflVqLii0gcIDC/L7cSGo+013vMX+KA87ddz94hUDm9nbAD0CGoJLHdXzR6Btb9iNlJSslmxwDUb4gHqRdyyODkHucBL1eYKBch5qX0E0Y2bVn7TTsMR/B9fBW+qXqzgyxQo3bjXlIEbgtLn5ew3Zh3FWUGWEiEfmAhlm8XFmEn1UrZs3FSX9ofucwzVXwYMkZ+gPhw4l16FFT+JIksR+66mq6AUhPJAxkd+cpZlIVMSA0K8yy8nb525ppVHFnCj2ooFPFWG+eeJWaPd6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrE7PgfknCFbz4ZVK7rJn6rQoQqKD1UopUYhiSgVxr0=;
 b=rxFH6ptX8GVDUV87GgOlF82QQAkV/Gu6lQ21RA2f8OEAHv2HXthFkeA8nLGffp+cCrQQM8X1mZyvR+KiHaSFPMmloBa9oncsESSPqVODQ+JRWP4CxZw1d2QAWms2Hl0swetwfjzmuIeCMw/eiXTA2ceFZxWRSf7ZOzmEjae4Jl1E3wy3CDgpCB9iNbRSU90XRYfP2Z7rsLbTvg3CNRvdNz+9HVaWcU6yqdjjfG5atRxvewnWoqnjlAtEmjB6WJF5mcoNvj3NhXIEQa7UfsK3gPAM/pa6bNCWRqe6AaUfyda9cfYG1OgC4OvsHDhBQ6kv9HKqhr7uNZpE46T71f3/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrE7PgfknCFbz4ZVK7rJn6rQoQqKD1UopUYhiSgVxr0=;
 b=H6+hKvaaP3gfRCO6e4JMCHWyNYXwx9F3hevLBo/msa0Sx60pJS7PQezWxnalmwXKNofiIbtsSGZfpnmrdVzT7qzRA+cVfaWCrAl6xOQlOIt5chOs3P/pahI6O/NgN67vXMToGxS7A2sofXcgISCaTJ+qXpztBacSmri7vl01SUAk8iDG4N97Y15fcDbkDj8jerlCb4oio+ugJwuxO9irjRFOtu29rL3qfLyJToVMKLgNkM1oLf8ixUcxVEeHiw5niUPSyMTZ8K2Fdg0Eh5MLCmJVeP/gTUWBA3oRaxcX5hgWcCeu7Sr9L0KxUvW31AjK23aiBmrx6VfjqAyxL6JGvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 18:13:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 18:13:07 +0000
Date: Thu, 6 Feb 2025 14:13:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206181306.GK2960738@nvidia.com>
References: <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
X-ClientProxiedBy: MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 1202b633-cce7-4457-1e0c-08dd46d9e844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mGNMZpEU/d90zJUSGJXZ5CrWDV3D8h8YKuZC+mEyevzc4LeOpWxpLA7tXJmy?=
 =?us-ascii?Q?eP7+k+ryPqVisqLpyWJJLqNWpP8ey0n/E4Py4OlDZdYTnmMgxjhHhByVMai+?=
 =?us-ascii?Q?G6ihXUHg7reauraeF9VzLgQlcNZHB/sbrtNO/lL2rsAMv641cmz59aJg+4CL?=
 =?us-ascii?Q?znFnP5/USs7SICJEm1G7K6mm75MHFBwvqjPk/l2K/t8th3b2xl7nGcbRYREL?=
 =?us-ascii?Q?9Tny1iCyYf0tSyjwIbQA9iZMh2zw5jG+MRDFZO7zCId2j+aKDJxgu1+/LGWZ?=
 =?us-ascii?Q?1MaSi3HyErDegcn13p6u30n1Ke9nBZ6njNPO/OX4ECGhaa5BCaN0TVM5w2yk?=
 =?us-ascii?Q?++fZ9a1ryon6+5vOB/DKvJcknQgkRGQXzyEv5GoTeve7a0KXsGL0ZvyFjwk4?=
 =?us-ascii?Q?rwFFGDfpzb7RkOWpyaOP/IvgbaEPU6r7jYYMaN5iptMxw3mmspwgCpwK0f2R?=
 =?us-ascii?Q?AmVoI4fLUChLCUDWXQZchiatfyzuHx6HClXfLH9JCCUkvDA9TNFyonDlCVY1?=
 =?us-ascii?Q?cGr1kVJUsvJ341mNOBcuPLzXgBryft9Ii4gMwMw9E/WnJXa3sxUTm6hHQkCd?=
 =?us-ascii?Q?bGzSMHEH4SKl1pMzu4XsSgeQZQXiU0SqlRLkII0ihqeLhUnNZLYpnHmCFM8n?=
 =?us-ascii?Q?w6r4J/maquxti1yGOwFOZLfYs3fjZJ7ljZ+gp+nZIDNFnyVb4OrpqAdHvcRc?=
 =?us-ascii?Q?nZxE94YpIaPq6G1kDVQdyHFH30Gmcmjtab+bbHElku5bNfT7WZJKT8Uh6Nk/?=
 =?us-ascii?Q?WQm+OPAgYvbl9pgFC2kOblH9w/RmDYzzW1nUGp3PKZpLM/xvNSwxB+7iAJL6?=
 =?us-ascii?Q?bSQEB9wbpOZ43q0Pg6F8Vstz5/wJanUj1gIGXRhV411DT4rPBlcaI7U/NGoK?=
 =?us-ascii?Q?m+NIjQNu7uiLy93vhffWhCjaIX1Z5Ayfi1Fg7/zyDqmzqF3T3f6gdUUEDFJu?=
 =?us-ascii?Q?V8k3dmy7dzuOvzdQskm+UNwg7FBzHAONLUvLR2V/WDdBtpOw6xept7VTnUdb?=
 =?us-ascii?Q?RYpEZ1mcvohsI2qGBYFiK9VaKEmCN/iKNS57xc5gU4lqVP3eZhQ29SEf6Ohs?=
 =?us-ascii?Q?zfzau1sRmkk3wDFo6mG/jSJjzffDI8LK/udQZzalMk9jCtNPr6gMJNDWF0JJ?=
 =?us-ascii?Q?RYIaNe0Q7tO+U/DK6/X/tlyHP/LFlToUEX+qqJ6PqfT4CcsjToW2rT3nOPaA?=
 =?us-ascii?Q?TR9VqGKI00YNquKqa/Y8qRWEa63XWfDXJYWR57XLdH//jXsfyaNeBxWrDdXz?=
 =?us-ascii?Q?fUonj0/VItzNIzn7Wur+HTEgHKLwyaLcMZ9v+skfnn3DMlOvMewp0Vdgvyds?=
 =?us-ascii?Q?AHMSSPeyaGQPnwaZvYuBXtQ16eB7wJW/PbJ/M+UGrTjdTtqX7nvgi/ir+OgE?=
 =?us-ascii?Q?tpUcy636lt8pcHYg0+MhmxPWVqXX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ukGkhv/cR5awe+yVf1+5CBVih6r1HHrqwTH1NG2QyMC2v8QpLZi3nKmamUHv?=
 =?us-ascii?Q?BR0lzH22ozVPftFY1dqpVoQjINSlW84pkLTp8YOIY+i6+89zVMJE96E9u5wX?=
 =?us-ascii?Q?du9WaH7tEWvO2P0G1tizEIhH4ZbURHIySZJC03v+j5LqgG9m6MgUSa28/PAP?=
 =?us-ascii?Q?O6rHTtm8XQIjJOLlZKejXJHmLGq8dCaUMeYwUdxRbtXS1cO8SIygKVpj6M4p?=
 =?us-ascii?Q?UIcQxDFBEtC6HibwspHSVQQh4RYSjfnExiu8UY0Y3TQIEklwGFz1/l9dQ39U?=
 =?us-ascii?Q?FFxxdRclh7gPjiPC20FZowZdDgOXFbQKZjuE0QtCNl+Vt9IXSkpqlvGMeQ3W?=
 =?us-ascii?Q?W31+ftzgg0K/KRt0c7lRO5KC/kb4MYRWz/cm7lw+rw8PShJxefiieCNI9edN?=
 =?us-ascii?Q?PjQEWFQVYAJCNvQrzh7ytMiHm/m7bkxalG6eSuzjcuoFG/vg13uNrSMMXfBX?=
 =?us-ascii?Q?SUGzh5JRMrAgZBmNerRE403eNHa4U023Jxp6cdTq/1bMDcZi2P/15Nmz3MA4?=
 =?us-ascii?Q?FjZezrWtBTPC5PDPKeieFMeB+m9Po9yvOsk98ATW3578dsu8oK29iT2kTxZO?=
 =?us-ascii?Q?gK+VeRynifjR8gLszt96ibPvXhk4xMtC/c8o2OWcXaQ4p2bdmP33FSQfC5gt?=
 =?us-ascii?Q?2JWH8z+Yx4ajxcKaApvvQlrStzmfOSk6jx8chtOBh3i0z0EAHWk5zg8zHMiF?=
 =?us-ascii?Q?xZpbHNh/g67Oq2OEf+U6YN7PYX2rC4MDQJeZm9ACuqW/5OkRZbFxcbQf9jD1?=
 =?us-ascii?Q?drn+fMBfG0sW5lJ8Xq8+A30Naqxy3f05QKo6JQ94cXOXDnY1o1Mc2zOwHMl5?=
 =?us-ascii?Q?Tr1ndl/jpoeklCnY7lgfEyCE4EmruMIiLZJWNrCZ9vcNm5TBWCVgFuc1ve+z?=
 =?us-ascii?Q?5iJX9zuqEV1svC3UCJCvJFzwu03BAmMtZHZlAXwyBhlRt18s/qM1gNNR5/ST?=
 =?us-ascii?Q?nMpU63N9S0QUVEg/VuEg/Z96HKYMCUSRK9T8NNrvtFoelxVkM5gHCGgHgR+8?=
 =?us-ascii?Q?MPenT95zzy45djN63vI005/ZEbgH91upGi8sQcvVVT5nvwx9oLmIXnuSjIVT?=
 =?us-ascii?Q?Hi0yXXSkqFlaTPBo9AZGeZ9li7HTNE7aVMG7rvqocKI+nZccGvonLAiU64VV?=
 =?us-ascii?Q?qYBB0xgIypBvBNWCEuZn7M3QSxglElXro5KvP2yDUux6rmgQTUlO4DtqDZML?=
 =?us-ascii?Q?4nHfaYFN14evxz3KecAgasimen2DiSCLS+ge6MJi2nMhGesNTXyjxnpgYILc?=
 =?us-ascii?Q?V8pdrXjwH3e/Jdy9FCQBW6ZagVO+K/2r4TJt7m4KXgdMIbxlkeE4kco+i/5V?=
 =?us-ascii?Q?fsAniuZ2bvOWb7ch2BaZOkTa5UsZKqZ9+IbTHtcGFCUBCpMv/Mis8/NwATEr?=
 =?us-ascii?Q?CxKKrKhouq3LypmmuCSn2U9SD/Ibuqn/vIgME4wo3dlDajq28HzyAlef50Dq?=
 =?us-ascii?Q?kaVif0/BCXkKFlwRW+kkUazrBQf4CiplOwUTQUlYodlBsPwpU1JCgyWspYdT?=
 =?us-ascii?Q?vK2LpKMpV7kf5zFIIuaiR3+njWDlrIGxfU1/YBTo2DT0Gs8wClyN9Yza0is7?=
 =?us-ascii?Q?t4i/P1GWC4IHuwZO57eLmp+JjCmQ89JJMRQmsL+c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1202b633-cce7-4457-1e0c-08dd46d9e844
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:13:07.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN6V9TkLhPcpM3FwTk1lb2U0ZHhwY9ik+QoOZwe++kbXItsEe5dIK8TjpqEoQfjG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
Received-SPF: softfail client-ip=2a01:111:f403:2009::62c;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 06, 2025 at 06:04:57PM +0000, Shameerali Kolothum Thodi wrote:
> > Some kind of hot plug smmu would have to create a vSMMU without any
> > kernel backing and then later bind it to a kernel implementation.
> 
> Not sure I get the problem with associating vSMMU with a pSMMU. Something
> like an iommu instance id mentioned before,
> 
> -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2,host-smmu=iommu.1
> 
> This can realize the vSMMU without actually creating a vIOMMU in kernel.
> And when the dev gets attached/realized, check (GET_HW_INFO)the specified
> iommu instance id matches or not.
> 
> Or the concern here is exporting an iommu instance id to user space?

Philisophically we do not permit any HW access through iommufd without
a VFIO fd to "prove" the process has rights to touch hardware.

We don't have any way to prove the process has rights to touch the
iommu hardware seperately from VFIO.

So even if you invent an iommu ID we cannot accept it as a handle to
create viommu in iommufd.

Jason

