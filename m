Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B2CC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6jc-0000BT-Pm; Fri, 14 Mar 2025 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tt6jR-00009z-Ge; Fri, 14 Mar 2025 11:13:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tt6jM-0005Ki-6h; Fri, 14 Mar 2025 11:13:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E5D9An005015;
 Fri, 14 Mar 2025 08:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=69vbuIIUaz9b4XZkoM/+jJNOTXSgXsf554uIHBIHm
 qQ=; b=ZpetqimPkKGDzCeOTOczV4BphoF4ofhYtnEvZLZjUZvoBvfYmU0y/Tmzt
 ul9NXAusR54UF1uvbYH1YixsIKY/34ZnWjZP8FUBW4W5kBYIbtdYmOMa0Z3roI2s
 g//AdFyQ43Qtm9kGbKZyw77qGhpQJrPmx5OpC5lVhLv6SnTMS3w/+SxJMpewPHum
 P9IEDGJgbbyOhMDkqK9FGrN5NBMTJmVOGxr2K2lDcwBJ4A/YrVJ1ilXiaJHAYk4J
 QYSBd5Yn+xXiNQ3/ixKlUN960/NtKJizFZN00ZJwvK2LwXw9Huh7ylXcfEjZgv3q
 k86G1pM4jef4yAB5wglPVdCF7T6Og==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010007.outbound.protection.outlook.com
 [40.93.20.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45au9br8f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 08:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7iSTOzE7Jsot+V5wgg2Zhe4OIjPnG5dKffoeDBs175LkiN/mBEk8LkUwevsRPEncjFVphtOZR/XHQXI4AvKwwqEDzrFw8txG8x5fWSw3B/4EZY9z+0ni0wKQJ8IB+HxUQzycQk6iTela/YjuY1Rgn4dk9JkgDlbx8rGXsSm92z/TtD1g2PVmCfD/uHuIjcfi2mFGcqjwQlwQsi3/h01HcJVnd1lmZjrfiPtC5AeM0SVhsZGZej8MT/gO0jSAlKbMI320xDVxQhiL7unOnA5JGDm+RxG0Pqh7epAm7F0BtZsrI3/ueoIrNhjdXjb4XtgDuJwL953Si66OvE5ZihORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzm+WFrZk/7F6PSoGpVaroPj8A4GHQVgKoqMk36vhek=;
 b=Cuz8Qd8NaVv4LCSq1jYnapaWHTzf7b/BAbk9K0bjfXHrzv5cd51gc+MxyyEOg/OAj4Ci5XwCVItfhts5eoOjq4MnQuTEwuqufs6a5/zyR6IYcPxtIlDXrx1FMNOyRUUAxp35OUvB8yk9+gWXuTyDH/GdEk7DzdFsykQ0/NfCbaoVapxadiZn9Fg2VLPzRhnshACxrv0CAnN/xQMqiBbRqAtZPm7QINqM6syvN8wGSXaH91EEimMqufKEiIT7ckGQKGJrxKDl0AIybGzF2fa2fjDWJ4QHP3H+jXvs6uC7KVEel06pcIMqy+PcHdhzu4tAr94jnKFO5yRt1MU6BwtYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzm+WFrZk/7F6PSoGpVaroPj8A4GHQVgKoqMk36vhek=;
 b=FCQ1ZKqjxrFwK5n3yeG6yALc+8+bWV68gI37gfidklRwfmoJYiDYKeSa2mQ713jYZsQ55uPk9xFr3iZXVePTzPnO0LYxdFL9Rnl7hxP/rfUhvF2CoBpLDSLH/uD0BcJn0Xv3e1hbwj/pfU0gk37/3GWQTQMRlCKNHLpmMJVhINltuqqH/qp5W1ozSvJId/Q4zAroLCaBUDufL3ROuaj66JMnMYqjSSF7JauEUxPy8Btl0evXLmfP2SvccbqwNET/NJevIqgLoDfxjp6KsSkZSE4OZ1SKaG1aV0Wc9vxa5hyWFQSFBndkVaGOmPTiOlEKTC+0Yo2DDYLj0Vkpoprahg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB8929.namprd02.prod.outlook.com (2603:10b6:510:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:13:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:13:37 +0000
Date: Fri, 14 Mar 2025 16:13:33 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v8 00/28] vfio-user client
Message-ID: <Z9RHndy/dxGentRq@lent>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <5910cf36-ca6f-489b-a7f6-b720733f16e1@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5910cf36-ca6f-489b-a7f6-b720733f16e1@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 4068d98c-9312-406f-0d98-08dd630acbc8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?B4XHbxBr1JCwvzD4JuL614ldyv06xprC3LZnetLdWgYE6cqf8hJiuU6Bdo?=
 =?iso-8859-1?Q?eI/OjfIzO8ojfc7UF3OHKXvOGJXKKBRfxsNy59/iQwRR0B6XH8pTJgorfF?=
 =?iso-8859-1?Q?hG47/z9aCSeH8XH+eo6DddvirkyGjCKJ9e2gIZC/tdGzZT5+/0S9+VMbRq?=
 =?iso-8859-1?Q?ZU0IAlRCJGOdj56uhBYqfQ7nALsX5Mvtrf2j0d6x69cCj6B1LKjz/mzFWU?=
 =?iso-8859-1?Q?lAM72pdHgBG9NT5Kf+7c51Zw1RsXVbAwtvIbb4wiwR1xkng83ZuzFg99Yz?=
 =?iso-8859-1?Q?/s7NpjnBsJ4MqVzzYxGKsnnR80s6z/muL/w1bLRRCHLPmAL8R/n2jk4ttW?=
 =?iso-8859-1?Q?iN5vrjFkf7Z9mJ0wcJXkc7Bf00jnmNLmT0adoW/Ec3LdTpiZsHnAOVjxt9?=
 =?iso-8859-1?Q?4sxTqX5jLaGH19mPY8lASs2ewfaprTeeqF6wL6hqu3blQ2dyJYE8NSJvw8?=
 =?iso-8859-1?Q?KVQtwB5/ykre203vw5p1a8xBwyk8MMmUpL+GnrUYLC2fvLkyHZCr+lw9Vm?=
 =?iso-8859-1?Q?rot4Bp9md6fnFV6JuLCRRR5MNsBpjUD4sL2i0OExhuU+HsyfsH5ct/xbYn?=
 =?iso-8859-1?Q?Evh83E9k9Z6ehaRjlyviCpini/aLEjVCeOkW3yl28K5e5xkI6n6vKWFuaV?=
 =?iso-8859-1?Q?Iak2u5E7gE8PGDvi3XoTvQr8FX+0zILRVsSf4S+W9Jki61ykWNYw/dChLG?=
 =?iso-8859-1?Q?3MiImwTdC00r2CWC93+ogBlKU0qzxRBS43sEQil6Nc4WCwQwAffrNT0ecF?=
 =?iso-8859-1?Q?ogWJ2HdsqjurhIFsyNRR2s76ttum2TEXdK3IR73J0zNFIZq9IyWLqLouoV?=
 =?iso-8859-1?Q?savNbUylpUOZVICtUj3y2I3CUePgc4hujhn9u54sVf+ORMrLA5cP123IpC?=
 =?iso-8859-1?Q?+maz2f46SKsTabKfGJyOmISuXlUYj/7oNYsSDn9KFTQ/N+H6qM925NCsHa?=
 =?iso-8859-1?Q?YveNHz40Gi+q0PNsvmkuI8cA8K0mj/mj58YybFQ9ugG+BFKhaJ+mdXmA7c?=
 =?iso-8859-1?Q?x+IogP/pi+RNIfVA2P6rLZSs/KA9nJzdKzY7G97nxLpbpg2NdX41nXylvc?=
 =?iso-8859-1?Q?IrbntJrid9pcujPyH+istZmuPkQU/owKuH85CehhCItn0+eEoRC2cptId+?=
 =?iso-8859-1?Q?JWvb9DXyoyqn58oBAhivLk7LLtOKJ2QTXw8CrIpiIJ5bf0jtZHW7KBU0gA?=
 =?iso-8859-1?Q?SGw5MpeuJ9aNECZUlKEIIpa5iaPILRlAIivkFO1ihT+xwvYyA/NKH0OakE?=
 =?iso-8859-1?Q?rhCU7Tz4g36IgenEvW13Y6oENzCFzet2IdivWLOJ9rSAkpnt6n1/4/e2bm?=
 =?iso-8859-1?Q?NvJaGe32pdBNYz0hW7ZOnU43zzRaYuxDV/PKE9gNjCond9y/8qtNl9k6/8?=
 =?iso-8859-1?Q?1FhtAnjmRd76hyWNseGzoK8c/p7mztInEWcjDKiUaGAaIr2Si6fmS+XmBX?=
 =?iso-8859-1?Q?jaUJ2rhOb5S+4lJW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?miP0aCjyileJLBrAkGM9BuQ1EAp5iGspWoQyOLajIV6ZxlU+LkAaki+grU?=
 =?iso-8859-1?Q?Vn2FefRKqnOXr8eFYcW7MVHtzO046/7XHECGphlCPL2fw/PMxxh6vnHDuY?=
 =?iso-8859-1?Q?B+QgW1FjlSbrWSIN2EdcVTpimsqBq0wtvFPgnYVdI9Nw/Q6RMuPDpXC9AJ?=
 =?iso-8859-1?Q?gYyNuEbwAJwUSe7N0UrJqvrgJSxYxJTD13547iNWO0ffam+lvx6jcYMFxr?=
 =?iso-8859-1?Q?bDbplfK5cwzGtl0PTT/XFptMO8556drLRMWqQBzmNqVbBltcH14agf3EG2?=
 =?iso-8859-1?Q?NxfjJGYeQbgOx1UoESyZIxGEVKP84V7YWTpWssPgOC+ci30Zx4HNf24TM3?=
 =?iso-8859-1?Q?hzkGk8I3ljiwwlwDwoP/ayCDanF4nGOo/pv0PgDcgaSfOv3vNiz2Yv9rct?=
 =?iso-8859-1?Q?grECPYO+2JTiFNe4/o7qCRAdPJ9lGJn9Fv5X9bjWxd8O77FPJhpB6YMgpE?=
 =?iso-8859-1?Q?yNkOarAZ2/8ktgeSSkHo2CvEprBQzs3gJrqGkBpOH7EDqlClSvddQ1AvIM?=
 =?iso-8859-1?Q?2DmIC1npkWiksDp2NvvfNt2EBYgZ3IKy4YMOdpE777ERGTqUA2BU8lZh0F?=
 =?iso-8859-1?Q?8tFrJBMOiqzd5YZXZbkxrMrDUkzXhbUlouBp0aiFJwf8oD0tCl+fwR61Nj?=
 =?iso-8859-1?Q?maLzWjL/5NKo2jWsBOVl890tFDYbzuCsumCXdnHlPr44IpG1hqSWSdDZXi?=
 =?iso-8859-1?Q?vbEDeOq0lTTA+mGXwqOCT+4BS1T2sJy2owoAsXvGTWv711D7yYHKVsweSO?=
 =?iso-8859-1?Q?X48MNyAlWiNKDObyVz0SGIKaPG8eBn5T/iB59lsd67rJSNtrl5hoMEVYwZ?=
 =?iso-8859-1?Q?69Oc+QzORiit/BvWk3lPMe1M+stLHPcvEgnei0zE/SwN5bPDbb5Y2QXxXf?=
 =?iso-8859-1?Q?AqCYCGBoW0Cggh3DjbK+qFpm6XrYHibr07JZNaJBOedYrcC8Uz4kUV9I/4?=
 =?iso-8859-1?Q?UWL7o2CsO+F81+wqhoNKVDRepEYMVrHy/K25lf1MNS9zH+vP/MumJxzptN?=
 =?iso-8859-1?Q?Cbfx0rm9X55UaKAvueBrrJUjyvsM4XcLLxp0jPJElpLVWnLocXPwGFeJhk?=
 =?iso-8859-1?Q?yI7v1SYpvk+yoFtRJiAyKzq2o7wU2CnaTdzS+VW4qyzbo4j4yhiy6Mccbn?=
 =?iso-8859-1?Q?dQtKCYbpFqDdxuJhigm51LEbLUWovvIjYw80IecN5oaTr9PFe0bzknZCTq?=
 =?iso-8859-1?Q?FK3eIyGWGcU6gMU5XmSilmGmZ+pFqfqMoaGInuu/NI86RbJPMnZeiDQSYI?=
 =?iso-8859-1?Q?ETpF0qbteXI7wKeJlec+OfHj8Q/LGaG3L1bphlkes6oyviN5fm0hk0Rhbr?=
 =?iso-8859-1?Q?6kwu86PwMVK05OvVrKFjljb4/dYvDqURK5pNbdBM/K2VU2EXdPmHOF43LO?=
 =?iso-8859-1?Q?uDqtjdi+9SjIIjnLfin6lUCP3z9tYnKXEviJJXs3YNtDTSF05vMmtSQ+3T?=
 =?iso-8859-1?Q?aZn6818QStNL9SNU4ycfHJ71TNH3ESMFLgJl3iSq9zwNAaqYKlxTjGFOEM?=
 =?iso-8859-1?Q?lRc1MGEVX/pnka/eU3G9/j5GfpZan6BAz0iCDBK5XU92nqrT4FlWuAoslW?=
 =?iso-8859-1?Q?VYSISn/8Kq1SdgT7iwshqgbYVia/39oBdsK7TJk+VCReqxJwjDDlINFdQW?=
 =?iso-8859-1?Q?gm+Sv5wCSW8yNlajT/UYIdyLYW+q9yCPtl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068d98c-9312-406f-0d98-08dd630acbc8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:13:37.7716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO5LgdI/MXySro/19NzXK+7sdEUJHCLr+0gsFAagz9r/qGFFp/6TvIC4oFbAMXOgQh+qHYKQTbc8zlhM/2ky7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8929
X-Proofpoint-GUID: MWHo7MfKnqUT0JLfhd8kwEgmPwekIaKR
X-Authority-Analysis: v=2.4 cv=aNPwqa9m c=1 sm=1 tr=0 ts=67d447a5 cx=c_pps
 a=2D6/CIrCIWs5X5ruZf5FWQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=nyIauhDzR2X6fGPm4WAA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: MWHo7MfKnqUT0JLfhd8kwEgmPwekIaKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Fri, Mar 14, 2025 at 03:25:53PM +0100, Cédric Le Goater wrote:

> > This is the 8th revision of the vfio-user client implementation. The vfio-user
> > protocol allows for implementing (PCI) devices in another userspace process;
> > SPDK is one example, which includes a virtual NVMe implementation.
> 
> This series is going in the right direction. Thanks for all the
> changes. However, I will postpone my review for the reasons below.
> 
> VFIO initial commit in 2012 was a single file adding support for a
> "vfio-pci" device. Since, the subsystem has changed a lot and it grew
> to +16K line of code. Over the years, we've had numerous additions,
> VFIO platform devices, s390x VFIO AP and CCW devices, migration
> support with dirty tracking, support for different host IOMMU backend
> devices, multifd, etc. All these additions never took the opportunity
> to introduce a VFIO interface for external usage and PPC, s390x,
> migration, backends subsystems happily and randomly peek and poke into
> it. The subsystem is now a happy jumble of disparate functions, with
> weak organization and names. The vfio-common.h header file is
> good example of the result.

Right, I certainly agree!

> It's time for a global code reshuffling. I'll take care of it (and
> I've already started) and this means nothing new (fixes are OK) will
> be merged before this is done. I hope I have made enough progress
> before the start of the QEMU 10.1 cycle. There won't be any functional
> changes, but there will be new files and new function names, so it's
> probably a real earthquake for your series.

It's had a couple of earthquakes already, very happy to bear the pain for a
better end result! I will try to look out for your series and review where I can
as well.

thanks
john

