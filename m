Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE344C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOx8c-0007i3-IM; Tue, 10 Jun 2025 07:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOx8Z-0007hC-Sl
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:27:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOx8X-0007dF-B1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:27:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8mALB031756;
 Tue, 10 Jun 2025 04:27:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ClDo8ydmmnzZhB90mhMiwrZhVswUHaSKwtAJxXXbI
 HM=; b=AxfRQYm9RAHP2Fpf+vGu8MNdLP8SpQreTi9kPNiKu1UttCFgqxwpBmuhQ
 uXXKpVx5Tb7BIMMCPQkWit2IRlOeCfpdUskCv9K3WB7uExxa4Co1i5Rj95kPxAo5
 PWE+/z2JV5tgZ/TKkVCGhn1AyQlX9Ea9wjeKrA7CJhD3fNh5v88hfUKUZX0mWD2N
 99Sn0eiZMkbP9kiw1IJvNpEk2J75GkgMtEBmQ/2OXbWHKDFDOmiG5Sg/7YrX97Tw
 wcFEpROIofMSlTvD+GBoTnG0/MDcg6vF6ttHT5Au/kg6ZHRr3/PB11xZ5EZKbjKL
 nhmHN68sBaERUiko+IxK36pkf9jOA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2107.outbound.protection.outlook.com [40.107.243.107])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474my0wvtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 04:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfWg3XN5faIvriWEoJ/yMLMyeqaaJnbCqlNfsOd7p6XsuiZyEt+BQJg3PQUHuk7edw2MNzbMx70/03XEG2QWH6axfaHmmsyEEnTdERK4uLrERxhTp93NO0K8wlqq6JQJyjtxLTOmSnBSjHx3ubMfL9lD7fJj+RTcJ6ISpKcrHDCBRh8WE+CWBswieMSiZg0VoIQDl7CAjiZ5ug3C/0jhQl5+qfckfjznLQCdSlE80Tjlut0YtsC9NidxhKKRDFRtM25mH0zur48PNXxuFoMU6ebxM7yHUe+rQxbeeBFCHefSc21FMuJWRK5JH65HXe6Aa3MT3soDzJwLFc6kjvHLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHvj4kc74d8zAMFwbJ4a2dn5HjIlzSScIC26pxO7AWo=;
 b=YjeLOnLmRSLVvCKT/Hs8MspF7G7OYRKMxyw8RZcbLdRwjHHnMlCbcFg81dtfoPMYFz/t3elxgt2o0/ZdMOuEjVmGMr9MExd7A2CbA6IkiijLttsk9actapCXYDvR1LK9st7USHwjSLKDRY9O/QvKzPiVzE7c2XsokR3QFzPBJR8ogXuq0wMRPJtlWZukCEioIUNkKnRMtVe16GyaAlhVo/yZ7mN/K+86NroMGe6YpI6tq3SRJAYV5xtM5WnWU1D+xoMri+Q/K+YPh7LdS3KvbwYvpy7z3DNAZouvP2Kqdsswra30aF6GTZ027OglqA+WffstlIdxw/cJVVjiRb2bdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHvj4kc74d8zAMFwbJ4a2dn5HjIlzSScIC26pxO7AWo=;
 b=dCEXfkd1b9ckc8CpRL14nVSMZg5U6230G+tQnXVTz66VwViVMGz5LrPuZOZlAwkVRx0iZDg0Vut36xS6TjOK5F51Lfy7vkwsChgL13tf95gjo22F7JfbrZRg7K7FUy/h3d442FYtJ+b/8JTrlP7oETkWufmpXa2mm3R72SobPTH01MIMg3xxMtOReeEDLK6//y1lhgcpQEno0Kt6iPHs/yZVwSB5UbHbl41dxFZYQFQB6IV4meSEb9uiuOeMydun8aq0wGAA7CoqcW9T9BXpMd8QShy9FGEqntm1zUDh/SH0CxCw928sbdLVZx0PuHV1C6he+Nefco0WQS8eVLddKQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7696.namprd02.prod.outlook.com (2603:10b6:a03:329::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 11:27:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 11:27:19 +0000
Date: Tue, 10 Jun 2025 04:27:15 -0700
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
Message-ID: <aEgWk5NvYg01GnUO@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <dfa38212-2f55-4097-b025-beafe11bb3d2@nutanix.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfa38212-2f55-4097-b025-beafe11bb3d2@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::23) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: a2eef687-ac3c-4261-2e2e-08dda811c27d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lHVwL3zALINDaxqeO2Cx9ORH4sSjYz7vQD44QhNV7P7FgCR0XqF8rC/dvB?=
 =?iso-8859-1?Q?eR7vsohXhdXx6I611mBXEJ31RoXK8UXaIEbB/aZWbr2SKldyofC1hE9CUc?=
 =?iso-8859-1?Q?eIQYEw4ZkUby7NFVDJxEJyLjb6iSsXWnQAoyGVsqF5DnkZT1J1/3r/VvJo?=
 =?iso-8859-1?Q?4jZXk+/lDP15gOELCNPoghEGaJ38OCie64dBPdMsCvTVXkA8LPOMZSrajK?=
 =?iso-8859-1?Q?UXAH3qbvZ6nL6WmPumQ4JamaiD5ORzp0Rv8y9txFY0kM9VQB54PcT9tOKy?=
 =?iso-8859-1?Q?iNfafFHDGa9afi4uhzjoXDG4tDezGTLGMVwn6fXd/yqpNeK+qvO8WfPY5D?=
 =?iso-8859-1?Q?cFE0AIY9aTDKPKL72eGUM5xDZLTFdqkXgx8/QDCMqML0qHUhlHX7J8HZyI?=
 =?iso-8859-1?Q?aDl316H3D/XvPQx5d09duj30k6t1X03Kn7ixfl9Hlr/aOFvXygvjbO7CZ8?=
 =?iso-8859-1?Q?qc1yXwmwhaNYk5HERE/x7SUOseGYlR8RvQHUwp0xQ4F00T2eLTYtFdJDof?=
 =?iso-8859-1?Q?1wgXycspZg1WE9yRP7eC+wJ/6lPUOo3dSOFgc1M59tHZkzyfC3X1XmRAH1?=
 =?iso-8859-1?Q?hYD7EfD6Zq/nEAHO6U6N07i2LzYkwJQ5YMn0OOEhG+rtrw5mf7XLl7Wsb5?=
 =?iso-8859-1?Q?o0LVagKtrwTKTmB/x8zuFmJeiVSbtjkp2BwiQHTtdIZpP84GkHmQnfonC+?=
 =?iso-8859-1?Q?9/eXv+ERnFmLIQxnk2BvhWJYlptRIERWmlYOKbErpHfvu5E6KdBnywuhbw?=
 =?iso-8859-1?Q?O9M/hj8Labfmh1NAmgNOyi71coZeCRrInM2evhtHXKhdcDDWNFXr+XVfmW?=
 =?iso-8859-1?Q?g2ICX3nOtvjFF42v/A8Bes4s/odd3B7bSqDoP32kNh2Fvpu6UB8BrDCZ6K?=
 =?iso-8859-1?Q?34EP/+FzDoNPNZt17D0kMkn33PBQDRI5RBpU8CWApbj9sv57M2GNrxOcp2?=
 =?iso-8859-1?Q?3tG1ouypcjwjkFL2T0bwlHmBgPdheZim0n+GPFkg2wgVPxLgKV3U751BZa?=
 =?iso-8859-1?Q?oplGVL+OQx3WOCPer/0ttJks1p2ULh/lIhx+Z0+UI0zVveX2vHL5fkLXOp?=
 =?iso-8859-1?Q?mYkg4EjSMwdbhbgA7JMxy0xsvzkN6Xw4TKOA49KBbm6oCSimIZ2RR3ZI6Y?=
 =?iso-8859-1?Q?B1tSOdnKYkcxf4KkiWokwMciKXBe2C5c/vGP0vvI3P7mWLZXNRU+uIKthK?=
 =?iso-8859-1?Q?1N1ZpzmbrwgHzBMmaAbNufX4NojUcdmCnU1M+ElbAsZarHlM/hHHJXdRzy?=
 =?iso-8859-1?Q?6gunW81egBuvVFOaXHspwcrA+YXaCXfRFNKw/8ttokyKLl7WJt/Omd4GQ8?=
 =?iso-8859-1?Q?ClxGkPsO6J3IA7LkCyrZl7JiTuKhjkSubZA8Yz7qKV8aP6K0xWCM7HtiiX?=
 =?iso-8859-1?Q?0Iu/JKP1BtHh5BZQvCnwVG+2KF/opqYxpyytsdvEEuynKOY/S2xH6pHcBH?=
 =?iso-8859-1?Q?8PmTNAIWMSOlZbILVjSjbtoExr5tTGTaHRcnYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z2fRvpIz6Q0Ns5FrUgvNbDD1h8CWJAYW/dGHzAo+J76mY7F8UGuEbOdu7g?=
 =?iso-8859-1?Q?LQuDfjT3ApgyPP+HvhvvYPN7j+MQ1hCfJsXtVx3ZfDF6w4zmodBooYnMkZ?=
 =?iso-8859-1?Q?Q2Rx+fuHblbPmW2+hgbg2KEB/oGji+WLH3h73/FVeRiNnZVha6zXPfIoEn?=
 =?iso-8859-1?Q?DXG7dz6V4dd/LGLZaiFetIRCv0yGZtPHHzPCnz34DfV8jZIG62GhMlu3BU?=
 =?iso-8859-1?Q?scmrzwy2E7gTFv+yQF9C7UKJHGDn2IqT0nzOUt0jbcK5bdJZNSJR0ZlsRh?=
 =?iso-8859-1?Q?Gn2lOI/uJmUqlGF+e67X91nU9vYnGuGXNo3Yq6eIM01ez57bJE7SMnvMQS?=
 =?iso-8859-1?Q?/j86wqaQtAHdHOCwxwb3O3kTJhy2d4B9pCqkWM4aNzpNNXGGPECbkZJNBJ?=
 =?iso-8859-1?Q?z9teNIwyZO6+YNwb4NAFoSrDSSkZoLXi/0vh9bsT3bdx5wakXDfBrhgjp7?=
 =?iso-8859-1?Q?HVZ1s4w/YVpqkV7dUKXJJBgnLrYlcUbNz53jPdaO0lkChbFgU167wgRCWf?=
 =?iso-8859-1?Q?R5MbMEQwyLtUZ5CvslFL8oRjfkCU6Ma3L5P8A0e8JAlkgPmhqeH+P1hiTz?=
 =?iso-8859-1?Q?3n8gzKgXo1U/W6SjMBfRdqTTUMbLh2DqNQrmHiXxK8EyEebC2SGv/5LwjV?=
 =?iso-8859-1?Q?3A3xmkC8XkEu6+HdTIcUu5W2+n3Rmg/4wJOYPAF71Z6jXuApUdfCPxlECN?=
 =?iso-8859-1?Q?x1auhOTAmUmBoQJ+3NvHAM6tuxIYY+sWN1E9bmVNFfbxtBJXvqG4lEK28D?=
 =?iso-8859-1?Q?/wh1ZlqqG1EEob3MXWlTfre0h1xfbFgFvMQRcJijoKzPExH5shIyxJ199m?=
 =?iso-8859-1?Q?OrHLljPzllJfdtXjLYZ0tpH5v7GgsaLuC7+FlJyfhcJLoDJ0nrVkTCdatB?=
 =?iso-8859-1?Q?CL6KTsPLUuZhbQYcIfNkwQejuMqr6Fm2g4V6OZEevbYnvuEa94cfhI4U97?=
 =?iso-8859-1?Q?hN+Mxe0kls2Ss6bxByf8cfUS99J4D/BneBrvYL7KMQqQpT55poPKH/n4Oo?=
 =?iso-8859-1?Q?cxNMR0itvsR+uUd3TSnvniGyf3qza/Qh9zN8TkU8B3ThK1K197AJm3beEu?=
 =?iso-8859-1?Q?+hmD6GMGCYeJx27WMlifVVsswD5tryKcrrvmJtOeXAXOIOPSYF1+kjg/lg?=
 =?iso-8859-1?Q?M8DGJRUdiDI4/6m8movA3VlgKTBsj962dOS+4TC05FPoopJqyiI5Hrb5dX?=
 =?iso-8859-1?Q?rwBXQ+80E0JskPnFZUnc7Ig/Exhm19d2OpSieRd0SFfOegU6bM8zyOMkpb?=
 =?iso-8859-1?Q?MdrrVlahQzqyPopgXV4V7TMa1isR9urgUoj8UMjdHhJ+ovzzl3uR/xFjNz?=
 =?iso-8859-1?Q?OEh+UzFq6fb4UZIHL/e1G2yMLQP1clMoT70dAwMJUWw9zgw8Xe+Egokta1?=
 =?iso-8859-1?Q?qauEQEFLnq5hPlUrYINja3qKJB20r6m+WaiMfmarW3Y8X4rcHTKJt40Qpq?=
 =?iso-8859-1?Q?iMhuIBef1nOQnaAdTIi6J0vNxHuABoRsYq1byZSfFZLuhN7UCPEpNkkGUM?=
 =?iso-8859-1?Q?WaxZR6kT9sZlDqYt6I8wZ5967XSNfQaiLuM+plDU36aY08iL9XBpzfr8DH?=
 =?iso-8859-1?Q?ry+2ULEuM+NDwH/6wWnI2kssAr6rKGzITklhmIcz4VMujV/SDOGiGtvvHy?=
 =?iso-8859-1?Q?cwcRuVwMwnay9cY1d6rAoeyK/E+cPNPrzF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eef687-ac3c-4261-2e2e-08dda811c27d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:27:19.0803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+nHqRseaNVSJcyY41t9ZAfTyjO9UzeXBgzHZXFCirO54vXLvmqDOkBLcAtoC7XeD90TPV/Osc+xXOCKPIrDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7696
X-Proofpoint-ORIG-GUID: tsF3YWT1BIxXt7PNi0KL1jCWnxdAIxAF
X-Authority-Analysis: v=2.4 cv=Xt/6OUF9 c=1 sm=1 tr=0 ts=68481699 cx=c_pps
 a=uzWVl71sIHdUljkB4tgaPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=zUjl5eEcyzJlYqk6ivYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA4OSBTYWx0ZWRfX/74p1fp5XAX/
 qyyu09ml4XAly3WeKI434Iwcu1BcPvMcALXgWLQm6QSvoOnQ846hG384dkKW7JOKANcNuj3q+Eg
 0uBXLWEHJ/ztwcJbSa8rdip2r8n1vd30jZ3+dfTxrfiiaI8oq+Q6KeB+wIXIegBPA0cHvKDWvh8
 f4C2VgTU/qAheocahmu78RoJVaz5DmpbtlqzAdmoIMT4hvmSp7RqABvVyzqiqvCFf8fUWdpk7UC
 lvf9TQ5Ya+hlxM6l20yGDVTq28DmkJ58zJopRbASfUZL2E4TIKZgrwTAhms0JZinj5bNXniQwZN
 YdvOuuXFddTkDkYACmIjA1OccHMR/fvH+ogij0CI6NDHY9YRmRFSwF+PLMJKoJlW5nO6V3v+80K
 EaLbWtT2N66/WERsPqem5bqiEI5/eCo7vM79AlbV0Lk7eyaNmHbkbe/9BZqU7QvMFmNxGIR0
X-Proofpoint-GUID: tsF3YWT1BIxXt7PNi0KL1jCWnxdAIxAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 10, 2025 at 11:58:18AM +0100, Mark Cave-Ayland wrote:

> > +        /* Use the per-region fd if set, or the shared fd. */
> > +        fd = region->vbasedev->region_fds ?
> > +             region->vbasedev->region_fds[region->nr] :
> > +             region->vbasedev->fd,
> > +
> 
> This feels a bit odd: if you're asking to map a VFIORegion then shouldn't
> that contain all the information required for the mapping, including the fd?
> 
> (goes and looks)
> 
> It appears that there is already a fd field in VFIORegion so is there a
> reason why we can't use this instead of adding region_fds to vbasedev?

region->fd was in earlier patchsets, but dropped as requested by Cédric. So we
must look it up here.

regards
john

