Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7804DC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMv-0002Qi-0w; Fri, 03 Jul 2026 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMs-0002P5-BT; Fri, 03 Jul 2026 09:55:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMq-0006W5-GK; Fri, 03 Jul 2026 09:55:46 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635uHcl1960855; Fri, 3 Jul 2026 06:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=m4QHY0ShYrHKGV1vFGyavWFFyOy7YQX7HEDoLGrke
 is=; b=WApVnavdiV3ahLiXyFYTv3xJD1/gbWx36J33YsL2HukX+F6fjckwWE4nn
 hcvf4pHkKQhHdfqtHKXKHFfIpjKWFv95uk6yUODjtqDItPiC8LKcxq4dMqBOKA03
 snQUO17mYTF0G/LCSDTpuVWHJVdFTixEAMhR3eBBPxpDE1NY8GZdvJ4p8s4Lzhf8
 RSXOaU3ROp1XFW9EMTiUiTnlMAqyuYRL80Io2JJhuG6GijBm+tu7lrg4+P+mXca5
 /qQOLH1KSeeEnMCEGDohz9waPktRMVN3gVp8hrVk2Vg+coUt+qPf49hbSKxsdRpd
 KqvO9I7vAbML9IBDcLpFEHMbNeU3w==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020084.outbound.protection.outlook.com
 [40.93.198.84])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f57ebdr06-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As3lpj0KzxIgaJA4LTk7LIeevCGT/7/yqOxMcLsNAXu15sh1oVnMf879Vdwal3KqHBppEJKxfBeIxRjeoZinFHNaVRNRJW0tOzRgVY62/iTXvrCTN3sqgtM8gHeQvgIbNMmYWdjVLisOJynib3KcVhYkvYN9rr9ZXoa4NxYN05PpGw57S+SppS9IChpjyo0qrCtrfnIzzOimahMvDseAZZaszHo0gM6MBNV0xztO7skPX2mG8G3iI6TFzYeqfDDZnG/8ByFrkXmWZ9BnxVnzE/IhAxSt0TvXL1da89whh8nmyvF65o0YISwk7xt89INeMN2xnTdz1SpKw5Wkk38Vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4QHY0ShYrHKGV1vFGyavWFFyOy7YQX7HEDoLGrkeis=;
 b=aCc4KldLfdLuuH9gXYOE04ZV8VpnRgecsBAo3ZSA2o3r3CownY/iSZI33bwthMh4KxIapVzm2hUI3r7HwuJzvU0f3fZaO5VCL/4OEqzSItcsPlHshPAmeq+GbjBF02tzwcnHC6a+esNRMS/fWsOOQlQ2KOK00TCid2PCL5QpaucP9DU9juzfdqpN8Ncf8iSKHUjxrhCIB90JXMnBepue3/KXqRDhacz61icQsgZhDq3ZUYww5tLFTYXiM6H/uFUIyXuLgwfR2X7lCX1qNQrsgTAFXuBzs7QjHlCbrvmT3D2oIDsrx0F+0rXVff4PLVnfNUj3X616Sykd1Jal1oWE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4QHY0ShYrHKGV1vFGyavWFFyOy7YQX7HEDoLGrkeis=;
 b=ot/2KMz1/CosEQhvHlP4Tt7MQY2LbrzOgemG8Kc5dPCevwlUXiMnUsX3XCe50kZbAia+MS5Avq6jkkgng5V0LZQHi5oiiyN0jqFFh9hXe97lZpTkngyEHu/Ia9060vGVMZw15FOx4t9IL/umf+gDk9GRbGLIWfv8ZN9ZqWkP6AryPkEy8pZ/IZLiiOkLqeRFr0Uy4RvK6uMsAwEzL5nApXPfCmMEkdBnWs9zoINrKQswY5QnOC9BZKDjxmtRELi0nIKXQ2ftHJ9LGNTco+X4y+kJsvAu8cHOB+YDBrgoaJVBQ2h6ur7UVpvB8foHP3GdQWzg7WzA6qpupeqVHmrjgg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 04/12] qom/object.c: add
 object_class_property_add_uint32_ptr()
Date: Fri,  3 Jul 2026 14:53:06 +0100
Message-ID: <20260703135512.3213964-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0179.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: c613f61e-df53-419f-6d28-08ded90abe5b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: nmkQzsDgy+2DlP9ZEoSIlktvRtNe/saAx7eD8vH3E4FjwXrgMmhiE7XTJLdw6G9QcY/Qax6u72knpPyRf26lJsQTJ+TQxHTj+rbJ3OZdjY79jUBBEbsV2hP7KGWHkQxaUk98ACFfHSe4J8Z/17MlAfZhFbADANpVbaGhNJPf9qixPRmigiDuDVfumIfoqK/cyGMZ3S2c8SYRQgBkG64yywqi7JYW7+X6xFp1h9p8+v0ICBSeWqvwjkrHzjLiZDXE6S3z0I6qqLi2d6aUgKuWXIbrQtKuoibcOaC2KuM95qOD9zXH4zjaZx/tNcLb8BdQGvL/I2VUSpCANgA++sTLs/KkYYjRMTaJKgKP9rAuSAhovLGDLtOoTlpi6DB9QioEtwO0G5gII27giC62xGxTdG24oZ6ckH5Qnr1hzpevKPm0jhcawzUV9L6EqVsyTcOYqo/oZJ9Ns3Fh/qMk8hT0uk8r4r0IMgWugQoM/VaC/08g6YUoIo6t0gYgwY3ME2g86N056ipcQDM5qa/K/HNKZbMuAnbVUtTQci4XAUR0qqC5hNd4lP8ALclRwfbjIzZRExTFo5ccSw3IxOqBAexX5zXbG92ytfmK8d+FZqOBepToxHOUNl8b8+9zyUfP+OIaYFgM1QVTWFtFHRrY3SEjt0Qe2sdcGPicEH/EslRPPZ2jrk3LvbQsXmonVNTMIC6t/0iKOREMUn/rLa1Oj2xIvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDb3yx8KV6P79LhfApGhgHt4Qyt5FxtPNoQYd+H8Bu68M7y2LutbJn3+ITSZ?=
 =?us-ascii?Q?Zs309Zx7quEO5bMDUjhZjoDZvQ2EaHi/Iaqw4R9/Nhw/FKAzNH3PzCSZF1zG?=
 =?us-ascii?Q?s0VohCi0WfqH+/t1M7herVLsPLhgGRYNUYyXgQlBJ/RRBdwPDpH9/ZXOSSaF?=
 =?us-ascii?Q?ORK9aJ8VgMYM1nWPJSWI7NW6oi7NS7sbe77Tozij9HSkU9gDScrB8PgJwGGf?=
 =?us-ascii?Q?64zPeyRT0pg5o6flHyv6iMLnVISnpVauDrpxrl93cGQk6PYpnyT124CgdgDK?=
 =?us-ascii?Q?Owm/Pvq1by9mxQ18zqDr4tp8HfJSiRDNdSB7FC2JuSWQr3yegoh2VpYu+p+l?=
 =?us-ascii?Q?pIRUukLD09jOj8458sm/Z4x9yIeAorHxs5T/BZbQYTsqzOaFssY8d3DxGqgV?=
 =?us-ascii?Q?/Fldei9ikZqHumWRUn7OJDI4S+ll7jOHZj1b+Ax9ri3kihlZK76So51UMu/t?=
 =?us-ascii?Q?GhsxlMJ79tfO2LHJKjvL7bID7Y3lhj9JwuNMXPKF3qEp8Cat8CTJZXtJh4fL?=
 =?us-ascii?Q?eQ1nTcjPhayG3rPlnrB41LHrxAbErN+uO2oxocCugjUjnF0JkL4cqvT/7IA3?=
 =?us-ascii?Q?V7FKLpZlloiOqiX43slBIGZEoU+ww7mb4+AkukTCjbJYgfxhWpP/91+N5AYX?=
 =?us-ascii?Q?wujr2EpMiul5ZOLidWMADtFt6CXW5imLR3iL9vmllysYG18xHSlny4EqgPkG?=
 =?us-ascii?Q?rkw6/o6qR0DRRP8Vn4NXzRWeMoePQV5v0Zfc4YNokXif5eSODFokkPQEw5IA?=
 =?us-ascii?Q?tt3OaPoJswTVDAUDUYwURpLuItfd8KYbABIqUF06HnhvVP9ZlnxRUCdkFudn?=
 =?us-ascii?Q?51+77d+gEBVl8NfNqcMvzUX9ht6nIgrQksuWpn9XC+SsSpYnekOkNhQO8iWr?=
 =?us-ascii?Q?QukZs1+nDb+FmE82FTASaIhjfKK5PzXrrV0P4lY2S8Qgzb8Zc/PYfRZDEpXm?=
 =?us-ascii?Q?7u/UDqkcRc8nQRAM535W9FoWDR4DOc1BwhrVlVFqaqziJw4eO0qA+gB3dOrG?=
 =?us-ascii?Q?7L4BiooeDtJ9rYWOHc/GVsZ0SfXgEYmUANz2/QA5w1O4c4GNWpVdV0PJVB/l?=
 =?us-ascii?Q?dAys4N5XTMErhOU4MFEBhQrUZqGn6RjDYm8zR7lxJTT+E6+alNx5QvaVCPJ7?=
 =?us-ascii?Q?pcbhRtVS8ps5V29iRi71WVjQDeOHwafkqSY+oWd4GEQO16m+6doZ2VOu8z6r?=
 =?us-ascii?Q?X6Dj4fZ+JGlZ32zyRl0htq/WhqHW+acDfw5XSo18M96kVH7vg0Cj8A4oN214?=
 =?us-ascii?Q?o3R2FJ7sx0aVNDyPe6UoGVuAouBsLnS8T5bO4Aj8mLoGLkCCNdKPLCS080aO?=
 =?us-ascii?Q?Gcqw2LieyvYHiUlB8IQIIZP6+1A7C5VSb3PlIilSD0n33SUEEm0KXH6TEmDj?=
 =?us-ascii?Q?xPnLRFqbQNRLRsqlNHb+b0vyRWcN94n9sPJM/XyvKlRrwHYD2ytcObD10CBG?=
 =?us-ascii?Q?WkuVFZNVUejlMf7ZmkoIMECLWwQJBaPbJpr3qQS1QY3XuZqfwBCjYv7Jd4nG?=
 =?us-ascii?Q?uwLx5XC/0w3gXGpLNHlbkVXqzl1+pHqkX/VlfPEQGKrruKfkfxqs2RzOTq5u?=
 =?us-ascii?Q?/QRXn+/fD9MwFCUpYL6S4AKDiu/RXYbzZxNA0VET4wdU8YfKbUxn/VAfUFRs?=
 =?us-ascii?Q?x+Xo+QQQJ5Uu8IbYOJ9T2VHbiDyPy8u5zjR0vQeWd8Npjad0zC6BBjn2I+h3?=
 =?us-ascii?Q?z/Xdc7laekVtMDoN0fjDl2WHKe+kyC1Y4ngfBPKxpz4OYhQ0pLVML2Uo0nwq?=
 =?us-ascii?Q?Sg6MZIVzhKbcEM/t3cMpPXh4HRivmfo=3D?=
X-Exchange-RoutingPolicyChecked: T/fK49AwKbYq+U2/IpJ8Js2SiP88MYsbLxuLN5uu2btP0HccpEPZc40/kmFxvBLnZ+qMZN2olWPCJEGQSpVYGQZe64xG5cGqWLeEhT/ze4vPPuj8giRzboayTRfT0T17+hBNAto3qTzSR7TY3bYzcrERzFxoJJbQmGi8FyfzCAoi8sK7whW30RVyy66nEuMt4G0v9VfMa5EwQUwhYhFW7PkIolaNAAzEgsNJzIv3AgipcC+uEdj85IL7KWGV96bEIxYaLjZ0PxBPVf+P+P9mjd572GViU/xpWJr/ylxpVFbOpb6Tp0n1h71zcJOuyz8Pfggg175uRXcQzSxic7F6ag==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c613f61e-df53-419f-6d28-08ded90abe5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:30.1705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWNXH580HpFGypXo0stDAemIfhxTB03nqKnv7/D96hbrp3EDcmkRvisBKRmbZgVxX214BNubnyWlcgTekN4TxnOn4ItommJ5yGoJFo4eiww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-GUID: j2yxPlVBAUNHj24_JD7XnqH5qA2EAWy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX5hEiPDYIedy9
 ITdrSJqL7SUuQtU8oMzWS1VeUQWWIpkjGsWKmCdJKi/6DJeQ3xgBWbwbxSah58vnESpxUAhS7VO
 J/xBX8AwJ2cQtLl2jziJ57H2UZsiHZMFtdz6pMLMr9qI/JR4Qo8B31QX9F2a+AhXZCTnH13lEW/
 8xlQPbslk5//jQDyT3g7bMNXyU7HrmYWQXGzDL5J7b6dil5Lb6EAg//F/LGsivhukRQoo8zDukJ
 Xt/I7umxvzVTL5dtzpLzmiO//pRX5mi9F7ltJAot8JwGBu3vptHpxfI7C3BmpP+TnEibLFCtt3P
 6WiylEv3gP05PYmIbaAfn0582SNkWZFRArMZWcVMEBJxNBejVtzOKEB65ZT9P08+rPC9iA8Slgx
 fpzzwVXFBSoXzXBM75D0gsWyChpaqzhBllhSj0zHiUI0V5lCN7MtGAniDLmWF/BVbtVWTBnmSUG
 AxQahXH0QmR/JMHKXFw==
X-Authority-Analysis: v=2.4 cv=HeokiCE8 c=1 sm=1 tr=0 ts=6a47bf53 cx=c_pps
 a=kHN3x5GyKc6C//KDRj4sJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXx/pEbaxcSXrI
 HaH778FjeWP2wjCZxYwZKZRJWxsnH7AqfLxf6ZHL21ShGdQhC1W7Xm1lLjwzHoP4JfbSN+7Hoqi
 7nBZ6P+o1tcsh7rJ2TORiglFjTK7y+s=
X-Proofpoint-ORIG-GUID: j2yxPlVBAUNHj24_JD7XnqH5qA2EAWy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds a class property that references a uint32_t within the object instance
and is intended to be a replacement for object_property_add_uint32_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  5 +++++
 qom/object.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index a175505d40..9071d49a29 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2008,6 +2008,11 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t v,
+                                    ObjectPropertyFlags flags);
+
 ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
diff --git a/qom/object.c b/qom/object.c
index 52e47068ed..3089eba273 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2797,6 +2797,30 @@ static void property_class_set_uint16_ptr(Object *obj, Visitor *v,
     *field = value;
 }
 
+static void property_class_get_uint32_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint32_t value = *(uint32_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void property_class_set_uint32_ptr(Object *obj, Visitor *v,
+                                          const char *name,
+                                          void *opaque, Error **errp)
+{
+    uint32_t *field = (uint32_t *)object_class_prop_ptr(obj,
+                                                        (ptrdiff_t)opaque);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
@@ -2939,6 +2963,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t v,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)v);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


