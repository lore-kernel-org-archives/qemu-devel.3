Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58EBC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKhT-0005k8-49; Wed, 28 May 2025 13:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uKKhR-0005jP-1P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:36:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uKKhO-0007aM-Mw
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:36:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SGQ6k0015431;
 Wed, 28 May 2025 10:36:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=hDPMAhb/kU+RmHA
 PCL1AGpPen313xO76AC2hDS6iuhk=; b=lcfyfGIjIaoXt1DJCDIva4XYis2uEUG
 9xVkuxcoaEGOjYe5GxJvguGIIR4Ci6b5YYIyYQCfShy5vzCnHR9zxWXMGdoKkYl3
 l9Kay+ndIqxqhnfYhpMJkoCfTgXgCldLIrp+wmXnj6fwr3Y9RVp/4Crdg4nNpMsI
 0iHCmrsW8xXHiWWV+9z/+rpiyXU6a+s5fuNbAx1G39I9MKAjbNrRq0a/kCxp1EHx
 3rhziCYBbAOm0BjOd0uTjDB+/3Njmdd0AtdJFHpflqtsa9uAsQ0AnOiwEssPmHAZ
 CUg9Y8B9qRAvwq7VvumochZ/GuQMf8OBlZaZVDjDyopnkIwDgCpmO/w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46ua18hfxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 10:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEqCoLG0mCLk/oDcTmMgKazPbFw1IJCM7l8RvcvypIfYtxk2zM5yoMym36ICpQltb4gKgmyfXBAqbaBeaqusnbDBksdAmtiPRzIC6WjQdJHDE1+5Hl1zMDegagse28st1JYtKFjVGHVrOevI8q4tBpeSWp/Zk7OcD03gC/20FVlKywPUFteHEoeBfaVg7UKfaSEmdMy+alTyH1EMm01J42g06AO59pXLB9uc02+57HME/8D6yqJ6HoMmbgOTQXIHSHU65m3q02E9kuR9Wida5ZfemjK5lDcE7O0euvU+DUwvb0BpgOml9rJUsZl0JzcjaPWYM4xz3cOf1OC0Ck1y1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDPMAhb/kU+RmHAPCL1AGpPen313xO76AC2hDS6iuhk=;
 b=WYYAXIno12oOSAOV+V8pCfCV8/X/Q21N3HeK54CZSvdYGkjCmE0YxHJFQ0plWLUZL0fcA209rx14R9Rh4dZtkXBum+IUtEjillmK7/mnZrW+9UcN1AS14ZA/5qUo6hAgG60/4qlaD7VK4k6Qc91Bmd5RPbhkOuTPG6C/p6C3ZBEb2+uExIsnB3uuNYJJQ0BUFgraLjAdMg7KAxytnX2jX7ESkvdJEv1QMp08iytccA3O+p8untMN8F5FMaDIcFYbB3sECFSrfwRN0KALEOjuuye85QDk+sOpMbzy3NMjPQM2tbskVuW20JYhUSDgAMdSSHESARPL1dJBNx5hBfTk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDPMAhb/kU+RmHAPCL1AGpPen313xO76AC2hDS6iuhk=;
 b=ipHP2t8lAZ/oQ8wSXb/0kjAo6FFiZgnZ5HaWF4cl4iwGTwyYK+FkxOhTl7MhjsTtlTuO0oXC3cOfniGwb4fFrm5MvKtMhYBo0h9nqgGEjA9hgBo0+39SaoxMgu3GyuJwTifAVg4iBuIGFsmU+I6hQjCxtc69MWUD3gS4HhMibVgAYUTkts26HcG9aXjFlHX9w01gnsynJ1Sh1dJvpkDQNvH71iYzswGwunxPTkecPEWjL3YFsjfAOO8ROkzX/kU60X5QKDuHY2VrCX9hZnkG8hXr40Q/6bqtRywPbYTl2frBQijdv8h4OEMpWCzxaSqoCu4FWIf4VPBjHHPG724xbQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB9453.namprd02.prod.outlook.com (2603:10b6:8:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 17:36:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:36:09 +0000
Date: Wed, 28 May 2025 18:36:04 +0100
From: John Levon <john.levon@nutanix.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v2 06/29] vfio: enable per-IRQ MSI-X masking
Message-ID: <aDdJhD9R80qiXqQz@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-7-john.levon@nutanix.com>
 <19e2b44d-0dcc-424a-904d-a7519e25d93e@redhat.com>
 <4b6d6c6e-5e57-455d-95b6-05a0fe562241@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6d6c6e-5e57-455d-95b6-05a0fe562241@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 082ef371-ffa6-42a3-5593-08dd9e0e21da
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9WzZsIBEHDb/7UeNWY29+2gCZjv+QME7qbdJHtl5ocIfp7beNYX3s+TAWaAg?=
 =?us-ascii?Q?zgqWBxEgrh6C/MHOmgutiWgosWDMaLtnEa+MxPJyP2pdd+ilXaszhxm7ZZlm?=
 =?us-ascii?Q?RumvGte3q7jGfQYk5gzXtLwCZ6fzlKajsDjcA5p/QcQEFJ7UesjfPAQLAVae?=
 =?us-ascii?Q?Gu6wKDpraNLexTZc8/OUMbnP8tBUwUz7M2gfVc/iOIWgd7MBskNrTwqNSpe6?=
 =?us-ascii?Q?5fNN5QhncfT6f6B4L5jwJ6KS899H7gN143HHAOVjSEBLX1wOReBn+Ogwo1Gg?=
 =?us-ascii?Q?bq/Hm8b1ejnPrezgotD1LqV3zdGZzC1bCZ24qIoMtrVjsdqNZEhZ2nASffXe?=
 =?us-ascii?Q?m4G/V7b/7jjGh7rqNZ+LBtt+nqH3DBnpQrqdfL8MzzO5Lcg2ZtFiol0N70IH?=
 =?us-ascii?Q?MDLpA9eVbxj3hHFWubCa3Jqef3h1QNagbvVUUohfVZBMceQufmNXAam5HW4/?=
 =?us-ascii?Q?IFah043KHpM2fLomff43xU6ifGFVlLBy6bjsMaXLnhD9xo+GAUApr1y7i5sz?=
 =?us-ascii?Q?QgYLGasmcE6/qjzL9qY9ERfXJOQpTV0oG48yt5IZtN0+YyWJfYrDTu+ufdJJ?=
 =?us-ascii?Q?AasyS/hr0JZZIpj+K/Xr5W3CU9ddwVfMeD9/ZTyE+hVfVewfhUr3aFFqhePs?=
 =?us-ascii?Q?Im1MCTaK/NMIb3zjXNLxXoVZat/b1jBIHWe315M/D/xJReujo7MkDYTXCU6K?=
 =?us-ascii?Q?ZS1IKH7hI7DfaXMwKm+1VysYA3ucV71aB+FiJJ5vNw5IwA4lbWK9t2keYzWT?=
 =?us-ascii?Q?LQatdSxhZ2D0QLRdx/rE52fpEWfOWCuEwifW6ponAkVzLKfuYEoWM2CSdd1I?=
 =?us-ascii?Q?CEkh7Iodwz/DtHYkZJlXHLi3zxx0tF+xS9B6oTlvd9YVOI02GZbnWQiTowpN?=
 =?us-ascii?Q?sXl7jbkqB5aQD/RGWmq/E3JTVAyr4NHXkAxyJraMeZgsU4LEAjoJizvG8GUX?=
 =?us-ascii?Q?/dS0LZd5EMxj13NYhwRDuwh5PWE8gv3ZfURdKMMpxny3xzvt+O4pjDtBezeN?=
 =?us-ascii?Q?jaVLY1AEHsApoTphso9lseCYUPLf6xPdBR1k+797KyltINUKZYJauIe7d55l?=
 =?us-ascii?Q?HlRQWRHgmE1FvbOer6VQUu+ovwYs0PYDbOxm5V43PDwMP62gtJsLyeoYfQh4?=
 =?us-ascii?Q?kElqeZh+Pd6aDevpQSpPWBIGdeGS8h17rSHWUQsgchdfDMaTKF5BbEgc4UQt?=
 =?us-ascii?Q?wfgHq2N9cco2p97hZfC/XmhDzFJ6u/7w0/LohoOS6sPqporofdHInXHUMmIy?=
 =?us-ascii?Q?5G9WTX3DKBLebObJuigPcXK0hdgyNv2l2fKpCzBL+umu/S5ffBiRQE/sO2qp?=
 =?us-ascii?Q?pYOHZhvRU/si+6F6qbpevfql+XbGtvuYFLnG+K4tn0Y4NXlXlCB11rpYX4te?=
 =?us-ascii?Q?UvFiuKwfAaqtzBET5s1FM6iiCi6cCKT58rd0DwBE4+zh57TayXW6/E0bjlpz?=
 =?us-ascii?Q?6ruzcFrvi1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NSnCWV+Q+yMyfMiHRNmL0ufCeIlHoWKNc2OsCeKjXoWpFjugLgcn+mkXF/C+?=
 =?us-ascii?Q?qbd8BH2glDjn28FXQPFyNmh/HpxX/te97jjGoSatx2OAf8niFnezj3MxfSu5?=
 =?us-ascii?Q?1IdhDC7M8BqCIf82Wl+MBSeg0sUwyRhE7f65RnZQpzVC4rEfvSX5TLSpPY51?=
 =?us-ascii?Q?2bXzAqGL3fgt/hqRq+XVYXDZBwqSx8ORa25gZxhhl+3+SX2GgjmVzf3S8C5e?=
 =?us-ascii?Q?DPdzurQkm1eYMgP4ENMksGWVUeGRGS8r9vkPS1riwbp65q4H7huCU0pSvU2u?=
 =?us-ascii?Q?YV9AMQklGe8Db0r3tHS93/xXvBgDIL68GB+MGbJNtivXWJx34SHtrjitvZqJ?=
 =?us-ascii?Q?InZDecUqmhC09HJ5bOoY1lmtpCTdEe6NDS7MnxbQ3PCLA8TSVZ0L0iKD5/Z0?=
 =?us-ascii?Q?kO1giL0tRfFsdAD6aJD3pEZn85vgR3gOQGqmM1xf9fIv79egHstcCD7rc8fn?=
 =?us-ascii?Q?wqdYKsoa8LnfluSAQkyYvxax/MgQCQShZm/OdWci4xBoyVtr1BmRRTX742hm?=
 =?us-ascii?Q?2Pe+KEr61IGNuclGLVUxmcsfCR+lG/W9jOgBnFsvaWLCUcu9LP/lInVJCUrX?=
 =?us-ascii?Q?xIwAZYmc87TeQKLg46lWAsLXQZm7PNbWwp5lc7pOhC0ngiHsuV8Wh8Gjr5F5?=
 =?us-ascii?Q?RYUOJC+YWmpdkYN6Zc5kpruU/Kn5GmwknrpmYJaY6gEhCTQ2pQxLdVD6jvhc?=
 =?us-ascii?Q?uwLFV40P12Cjmr1a5h0ris+Lq1vkLX6qEfCU1Jqx6esCd36DapGt1iWcXuH3?=
 =?us-ascii?Q?3EjWOilJPyNLYlauWR6c0CIWoXs0jN22sSRNupTz+CMZd2Vh89YxueW8dUh6?=
 =?us-ascii?Q?e9z0iBkoT28AnJIF8TKr9We25m1WgI/djpe/t7KaqXNLSSNoxnPlh1Z0chd+?=
 =?us-ascii?Q?a4RbM6lw4n5NHIYUDk6O22hBsQZtDUQ//829WXj3WgKYMcCCpuxLchqklyYm?=
 =?us-ascii?Q?Oi7iO4qcrGG5EaeVtjlGJXBsxxkefhmZDpOfNX+HUPXmx/cnhDNNJMxftAfw?=
 =?us-ascii?Q?2n72wOi6qC+gIv5soq+MEgsIINowSeV0kn5S9itCMUWmtyPmQyFWI0IZC/nf?=
 =?us-ascii?Q?uwMGPf5PtcqM7qfpBGvjF1kF0r8+aiFdHox/8G+BRtDRFwh+gHKUpVzrelNP?=
 =?us-ascii?Q?eV1Tq0mmhudgqvbL61YdXAu1DqqFryBLqK4QNuMMjOJrQxydisp80rLj/n8U?=
 =?us-ascii?Q?lUC/2kWSoDbMvV78DFMq5wiYgRT388frNX+ZM8tlu+Ep8DzZrfPP1eG/0u63?=
 =?us-ascii?Q?I9RLvZpzsDomDwEaE9NQKnaEL2EvnahG0U7WX4ksI67Iv50zoT2za/f5swSJ?=
 =?us-ascii?Q?xG6laOoA+RTXSLPkS/OtbxkJUVIPY3osDEJJFpLOaOil2lv6vILjpxjMYvIr?=
 =?us-ascii?Q?GZzIezOjIpjk7AicaFsgBIxuSmziCTc2+4egBzYyFa5dtjMTt/PiJcWXcHka?=
 =?us-ascii?Q?paMsrQSrJCsUUcV3/1EoKjZeAQJJPxfsD4iwJO9HUEiPkLH80yYflL36+CNs?=
 =?us-ascii?Q?SHGQQQRFwLuJkcg+grGpN8cpfk5+lrW8McUocHiTIlUKY8w0rGMyYcRsWj1E?=
 =?us-ascii?Q?XrvhffDNrMHCG0SdX1gwYF08AxUZ1NilAjYvbrSm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ef371-ffa6-42a3-5593-08dd9e0e21da
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:36:09.3004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLG5LfeLfDCF0MeGM3iZ1Cmla74Mku1H6D1Ez7VUPhlIMfdnVqmK8y9r8corxgtMfe8wgAH7RiEvFfO2cPjwcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9453
X-Proofpoint-GUID: qB6KSR_Xs9oXVBkYBejERpbiVLO_wDVv
X-Authority-Analysis: v=2.4 cv=LvGSymdc c=1 sm=1 tr=0 ts=6837498c cx=c_pps
 a=RqubJsdE8dpkPRvhziTryg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=lMKXOThmoPEE7Pxsw8kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1MiBTYWx0ZWRfX+lq+GfQ7HwTP
 Hm9/6HWPal9mCiGUJSF2EVRk1uCvep4z6sknjpqV2M4wLBc2kYvj4r8nDOQuT1zyCl9Pat1h5lS
 m9XWSxEwyWoHInt4qFq2GjG4KIWDOMOiT4qtS61EtZ8uoK5MDtO3UYTYQd7O4UENw4vvmYikdCB
 58F3RUmLlpnTCzUo34GldwA/8Vtn/gUuyg3ONY9DLa5Glad7DxhcY8oRUdsHSeSHzSeBVvB7uBG
 Xa6Kht0K3S0ZiCCLZ2ati66xMqTXjCz4Dlp50kmSsPLKoOMGk/XibDhhbXMMXHJsriMCjvkUXOL
 mfJwKfAcnvgd51InEj74rvuOy5p0k+3S+1ptLhY5d/0TwPqd0josFPmMVr/h5oUky8F6oMmszy7
 JqiktrMgGp02cHE/hVehfEfQYA09GG/QggLfTGIyEev18Z9d+PDCdhjtQ/j7PgcPU7LFRKTY
X-Proofpoint-ORIG-GUID: qB6KSR_Xs9oXVBkYBejERpbiVLO_wDVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Wed, May 28, 2025 at 01:16:32PM -0400, Steven Sistare wrote:

> > On 5/20/25 17:03, John Levon wrote:
> > > If VFIO_IRQ_INFO_MASKABLE is set for VFIO_PCI_MSIX_IRQ_INDEX, record
> > > this in ->can_mask_msix, and use it to individually mask MSI-X
> > > interrupts as needed.
> > > 
> > > Originally-by: John Johnson <john.g.johnson@oracle.com>
> > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > Signed-off-by: John Levon <john.levon@nutanix.com>
> > 
> > This one conflicts with the "live update" series. We will address it later.
> 
> AFAICT there is only a trivial conflict versus my patch
> 
>   vfio/pci: vfio_vector_init
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_1747063973-2D124548-2D17-2Dgit-2Dsend-2Demail-2Dsteven.sistare-40oracle.com_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=v7SNLJqx7b9Vfc7ZO82Wg4nnZ8O5XkACFQ30bVKxotI&m=us5Q7sdvPzuJ8qd0-KHuGcuoxQPDRJYPJ9dFmIeHxb0i8WnpPqrLiu3UuGSoq95U&s=Pd5fbQX8J7_CHHWD16ZuvXKJ13kipONxypuqS_cjGI0&e=
> 
> because I extract a handful of lines from vfio_msix_vector_do_use into a
> subroutine, at the same place vfio-user has added a local variable new_vec,
> but the new code will simply be:
> 
> vfio_msix_vector_do_use
>     if (!vector->use) {
>         new_vec = true;
>         vfio_pci_vector_init(vdev, nr);
>     }

I'll take a look when rebasing on top of CPR and ask you if I get stuck.

> Also, for now I am assuming that if vfio-user is being used, then I will add
> a CPR blocker.

That's fine (and I will take care of it in my series), but I *think* this
per-interrupt masking can apply outside of vfio-user.

regards
john

