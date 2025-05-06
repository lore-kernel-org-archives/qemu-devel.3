Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17262C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCGdJ-00015N-GE; Tue, 06 May 2025 07:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCGdH-00014y-Pg; Tue, 06 May 2025 07:38:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCGdF-0002fs-M2; Tue, 06 May 2025 07:38:43 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546A9EJ2016435;
 Tue, 6 May 2025 04:38:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Aqw8X79Pb1nPpxm8sKPSQE35gxiIU2KBV82k+N1Cz
 ns=; b=DjSY4SUwdfWkVXmxe2TUazxE6s4smjiFY/+zhSRfN6z9A03R7Bm30yBxf
 l95MG1zTZlz2M46IaDKL5YS8h7HKRRxGnFEnzM44Ylzrh7kA4+LdiTzaQDOamlq1
 Qx140kccfF/0BR4I18x/X40Ee/B58IQiHEyYVUixgPKZvynCwNzvs4CHcKvjWPAp
 mBIsuB/CllmFq2wXUEA+KQWI+ooqwaY31vgPHIvN/p7awG/EAPvlbGXoKh6iPY1r
 A2R4PlrWD5SPLknFD8XDr6uBt0795LTJS6ST0p6mMn6TwnIinvxaFc8TAUiGBqXw
 paR3voUAZEJ+nFzxlRHZcbzexBvWw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010007.outbound.protection.outlook.com
 [40.93.20.7])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46df295sps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 04:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scxtNVZg419rwhXqDR8bnbE2fb4H/0Bg2n6peBl3XS3ICkUZxDoyEi6eycdZTG8FyxTdI881VDTRcY2XdMefcoJAfkwxSWaMey965B6y4eVAwmZlu1E4EKagEjCpM6plz/O6fnoP94x262vLwqZatG9BBkbLjG9gIbH07GJ+4ZKDwcRl9n3Po6cOPkQqo1Jy5+k3hSSw9bPY2w/KmOQPUVQ5gtrRUtBMvX+iZaK/uLJIzv7rh5O2eQK4FhiZyafSolskMkIH+rp6EiRZvQd+hWEZRKNMXXVSEuG3E4SC9lDY2/yeeG8cdm8eYDrEEsukV/uXWdAuvP+ZBMN6pRg9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ukzatl2XLuleSymUBYj2iuS1baYJpd+A4XHYhU80E1c=;
 b=zTPgNOBObMzYOqoa+RbMe/U3Yp9VtcP4YPgS6SudPTxvT7tZjO54x/O1e2XotaqtIw/oPmcri8G3qSyuzUKYTXtbjdcTKdWG9QR+yUyMOBdmwNHUx8SSyxErOFndOQO9pxUZzvd3HtkkrkT7hMcMpXtHcRUNK6I6HHvEjtKONvjXzmGgLfTrjTVPrGkpuwRS1r8lgdO9bQK7apSGSIZ1J9GrY3sjtB8xXy+zcwsS0qVKBfkg6SdCGYtBDFfURp2s7jk2P0ahIMr+Xhpt/DHp6WWUOK3Qnzt2TF6TnN/+UioxWKw0WaOQmUWIYzKl4FCjppq0KJAcl4v2SEBpXmVYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukzatl2XLuleSymUBYj2iuS1baYJpd+A4XHYhU80E1c=;
 b=hvMpNBgR4QvZkUW4PTksOAPdJdQ3Pmc4dr9FFqRn5jRljq3dTsQ6fxmtg/ag8yXNXY7jmiVtMXT1KfrILyBkTkgN8A5P0EVYIZfNIE3VUUJKkCEX18kZ3gXOYEpXGqQ4+BYiUwKp3ZUQjI1pSTcLlSb8fJVVpEDv1uZcFRIycV54FU+3ht8/cfyjyQyCgmDL1iZava2tYTmO0xnGRfhFpHEi71vNwQZiQ34t2A2E4/FyTd8Jtydx0Q0IDKIG36tI9U9zxzFjvhd1vOZblVq2+pmZtmCMSdK28HS28uNbC4BM0WTnNGjL7mTKfLkPuMzP8XFI0hd58KQYAlHp2f3UfA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7288.namprd02.prod.outlook.com (2603:10b6:510:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.19; Tue, 6 May
 2025 11:38:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Tue, 6 May 2025
 11:38:27 +0000
Date: Tue, 6 May 2025 12:38:22 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 04/15] vfio: add vfio_device_get_irq_info() helper
Message-ID: <aBn0rtBxPyFDOaF2@lent>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-5-john.levon@nutanix.com>
 <21e7accb-f5e3-4f8c-aa76-e9e2f2094fb6@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21e7accb-f5e3-4f8c-aa76-e9e2f2094fb6@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a7dffa-f56c-4c53-629f-08dd8c92843e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?llG9jnNclf0k1IVnXZnXGq4sKtkV+/biPhpkH5wOnaqAu5IBwLTffrt2mN?=
 =?iso-8859-1?Q?//OlHPBlCq6IorXiI0lMBJxQoFmIxgq4aP5sKo/EiqxxvldoWz72Anni9k?=
 =?iso-8859-1?Q?sC65h7m58JxnOwAS3/Ikmsw7EB5hOWvXtDVMLBhAiO6LRvcJCVNeDxU/IJ?=
 =?iso-8859-1?Q?o/tyCWN9WwkvJ9WpiWZ4ST3WaKhc3PKAsFwfZVqb5ooMu8+R1eEpHOq/Bj?=
 =?iso-8859-1?Q?FU6jTnjG4mttSX4919cP71OTQ8lEngKtdNRA0lJ9u/bBYuR/LDkHs05t4c?=
 =?iso-8859-1?Q?OtUAPgXIHfdYmkhQCzrAaoe4Edg3cUBglRUMJRrnxUhHM6VxRzWXqPIlBF?=
 =?iso-8859-1?Q?pU/p0OYNb3Njs/6JZ2B8psadCGorNR39HQzi+N5GV0O1ZBoqsMwAXJEab2?=
 =?iso-8859-1?Q?e0k+2t8/rg0XbH+HfqL9BR9edl6s5zu0pqk1swTcwl8dYWRYcJhgRxTDp1?=
 =?iso-8859-1?Q?p4wa11QnGa1KZVAiQCd36n1R7PgY7lKzQbbY06fZ2/XncnyUG3mUszI2vF?=
 =?iso-8859-1?Q?N9SZeFMTJ6vBttL+I/v3wNdyNTfLAUp3BtNr8gfXgvf2t0LmfZr9AzoHY2?=
 =?iso-8859-1?Q?n9Au4OumA38YXklFQ0IBjMTPaTaYI+hk33Z4uRNCr19UioAJQJGIQo9/tp?=
 =?iso-8859-1?Q?cXFgMREDgbB5aVqAC9bl8zOje8wEDnXAvm3tDLtH/LQmpLHzJWi4V8w7SI?=
 =?iso-8859-1?Q?qYBAG0BGwMr02JWoKX93bRKomqx2NSJ0SEWDy54liuVJALDR8tbOcjDTXp?=
 =?iso-8859-1?Q?o7SXfDfOgzn7eBIef7kuxlecTceIN7MsmODLToCfkbkkNMCEpyyaNkWcOQ?=
 =?iso-8859-1?Q?VFWb/4m/vr4NyJTE42W/lhw5hTuV8AGf+yuaL5DR9ls5BaoXjUt+cxeBey?=
 =?iso-8859-1?Q?tuNGYgYEa7PZfpLU3XXJpiIOW14M+HIF1oBQ+4rRwUe/WT6VIqA7yHBnLF?=
 =?iso-8859-1?Q?zFETUjOLzGENVq46Jp7pRE3IfzbinQ92ZkGvTMPMFSIZKWkhll2OACr8Mb?=
 =?iso-8859-1?Q?70ZIWOiJXWuUE14uuBYKcEDsApYbp4WYSFN/XgKO1rChBA2GbDrFTPJaJ9?=
 =?iso-8859-1?Q?LqEkO6pC3mQtSnmfFKy5LZyI1pzuAuUScCBp4U4h9HlaFPIvFHGacdFTxV?=
 =?iso-8859-1?Q?9NNaeZIQTmwEl63ws99MpsB+htKCxkynnpKTvnKawPJS98byGMgTi0ngC+?=
 =?iso-8859-1?Q?oEFsRUigxNp5RpjxVGYXLX/h7s7504NiAWvp7XNaOKnZ9OvzG5vM9HK+TS?=
 =?iso-8859-1?Q?uJ87121FpXGiDOXjPgwkOflu7iCkbK+cSE9K+S45BYeBfgixRaEoG6eFO0?=
 =?iso-8859-1?Q?EMJ0Gwusu0v+/iv1YT0D8Dj8LvbsVeFThz6/veb8vFLUV2mveidI5BRcCo?=
 =?iso-8859-1?Q?EdeKQZAtV7EhOCUBV33YzdZrLdDG/L6Dq/leXJuMwoVAFy0jFLXGzzWc2X?=
 =?iso-8859-1?Q?jZwW/cjhc83vU5aIlq09vJyVtNq04XfGW0USZggtRncYYUr7Ka+xMd6TAt?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kNbMZbMUYHWnPrdcWuN8BXBI45bhvoqaMkGEaubLix1a4VU2UtW1DJoPp9?=
 =?iso-8859-1?Q?O8Ub+jxZlRT966oHUGbxBbSaIfPiTmWumMH4xg2sZD/6BgRVhDKqa+aEAg?=
 =?iso-8859-1?Q?4Dyty/0ODse88YvJd0A6PB/rZj264JAHIvEpujoWW6dkxmP5vkOpSpZQxP?=
 =?iso-8859-1?Q?ePsLVzm4XLtwRS5WkqoSamNf4RBv8dlzMv7QLDtdL93UVOIfMXG6TCACn6?=
 =?iso-8859-1?Q?xdSR/2t68tmsQwQZz1mGND1Qw1sqpx8Ae5gdligYu7yjERamnlPkDHkhdT?=
 =?iso-8859-1?Q?lAVv6dueM0uBbPpdnalT+MfxVF3KpbkG/Yr+T65xbBwOVpoGe+dmQGNvsG?=
 =?iso-8859-1?Q?4vjue4ACaoCzh1itq+kDyMrR0HBgTsW4x/jmzngHCUqWoGAuZcIr6+8vW4?=
 =?iso-8859-1?Q?g8LJnHofQf+nvYfK4+KZv41vsMc7dLk1Lipx74vZPbIIU/sSRF+A9vRAi6?=
 =?iso-8859-1?Q?KQd2152Zf/KqkwE06kfGRIosEJGO39X4EWqtdk0cezFDwTedyg0XKNF/Cj?=
 =?iso-8859-1?Q?3mLlAWUR5FI9bB0ntPXKLY/+uiApJMDqZCcwF+E6T6BqA4NwKDJt/Og7vS?=
 =?iso-8859-1?Q?pcKzKhs2P9zIC0jN4cV1oXP+o9PZ7vN3QTF+Ls0rSjg2pBsFEtORU6IyH8?=
 =?iso-8859-1?Q?SwHWZaAyEnUfMcJ1zJfs6P/2IYi0YF9kWGBtZdratU9OZK5KGgj9g0Y+fu?=
 =?iso-8859-1?Q?sYJKRhe1D5ShRaJIg/XC3QmRVBz3yy3OBTAEb+ZVm7TvvCPKRpwUSRU3Ha?=
 =?iso-8859-1?Q?ezDErUW9NvPyhUr2r8xXp65ASIGMkrTujzJgFxj30kPWUy2nWC5oPl/HkC?=
 =?iso-8859-1?Q?s24kbqvxtXzolaBeFsBVCPPFh26HX1cIl1wCT9T8QLD0BsZC0gUeP5z5Gh?=
 =?iso-8859-1?Q?xEJDaFfjHtPu2ucU/Zo7wi1k7MWPGusxn7arLEfaTCzk8wvRHJuibd/0nS?=
 =?iso-8859-1?Q?1XYa5tE3yqOfafRonmm5UC9u7z9H/8xnGsExeBnjiyd2P4rYDpXxOk8hwe?=
 =?iso-8859-1?Q?XhLK+lfJ/jIbQDpxK5K9q2hygkOVliMrQExPSWtovmP0OuIJymyAt+wmkz?=
 =?iso-8859-1?Q?du7/rzZQe+7Kwe1iPr8xLLMPqc0KutgMJXvqD+iCvZrzjf/S0YgrluKgh9?=
 =?iso-8859-1?Q?lXy978iJIeeUMVXcvq8f9mmRJJRc4OaEN3LGPDo35YAvsJrE6ZDjx1lJgA?=
 =?iso-8859-1?Q?ZO69xeYSkDbBzJOwtw50ARGBEEuLZ/tGgD7bwfQAD5Ngq2IP0iQgeUmw1F?=
 =?iso-8859-1?Q?tJ/bxTC5hhT65GsaXzWJ2vl9xm6wEKlYOVEAKLMrf0rBEMQqWXcTIT4MNE?=
 =?iso-8859-1?Q?6oh4UmCmhlL6f31JGB7kNCZje1msBRLAa0IDYvjxc/neYsL0s8C1w7E2II?=
 =?iso-8859-1?Q?x9VCDjKk8oo/Deeyz2tjhMJhuWrhLIuJ4i3UB1nZ83EANgK7hruqfGhREk?=
 =?iso-8859-1?Q?ZSMZA+gc/i/uz+kM8KLd8djWixo1TFLJ+guVvQeODFNe8vXxS1fAX+O2GY?=
 =?iso-8859-1?Q?Gw+wmNc6nY3RR4dtKDiu7Fq6JdSJMxeXl3Ugl9CHKbDvHGCeNRFiJd4njL?=
 =?iso-8859-1?Q?+8K+apkknp2mqfjplpMQNsCf/wpd85t0b2l3U8QfHqs8xKFfGmh0Z8O+kG?=
 =?iso-8859-1?Q?BLS/6J8XgIDyx2vPR5YKyegnI77Fd/omrJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a7dffa-f56c-4c53-629f-08dd8c92843e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:38:27.2690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MHc96xHMy8uO7uybL/647wy5BDLEJqIwSJJLKM0VlpN2QHXQo2WiELgSUXyvjW8/NMGDOpRvWzqcLK1zQTX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7288
X-Authority-Analysis: v=2.4 cv=WtErMcfv c=1 sm=1 tr=0 ts=6819f4bb cx=c_pps
 a=2D6/CIrCIWs5X5ruZf5FWQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=fftdXDaRshV6qFOD4U8A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=QYH75iMubAgA:10
X-Proofpoint-GUID: tcFBtER5h6U_eioT1MRJGqAk8CNAelcB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDExMSBTYWx0ZWRfX08WGWeB6Dnkp
 9g8aU5hpgpIRYwQDVMQqvsf/ybPyVpy9N6dyOFtUr43N1ut6wDu3QyjqEj4tDDmzKpqVlZoVuZo
 jNMEnyxDu38EKDdAPhZyeHmsgsxBps9A9OHyWwxajGZRz+67jxZhDxat7Jlq5ikkEXqSBWn8B7/
 fvmok6rGcufO/mmL/7n4oWr1pmZwUYtsQp+LmRVBDysFVKCOs1CBlOcEIOBc3Mhlw3j9n7+xu7A
 HNVCDenk1tqIeveiaoH+tlAK+lPhEIQ89WxiU7zOFAJJX0Di8yk1zIunUIkeUbSk79BfbGDAQjl
 IXu9Ts5EZ5IFSq+17DvJ446hWLBIoG02zHcXdtn2boTsNBiV6NzyynwcYPBzrvxHzIDqX/n6+hh
 WTBW+s2uSDT/VXhd28vUpADH5uzJlJDYi5EfKrNLuEXB4mAwkjVR78J///L0uiaEM9HsFflt
X-Proofpoint-ORIG-GUID: tcFBtER5h6U_eioT1MRJGqAk8CNAelcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, May 05, 2025 at 11:19:30AM +0200, Cédric Le Goater wrote:

> > +int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> > +                                struct vfio_irq_info *info);
> 
> This is breaking the windows build.

Sorry, I forgot to set up cross-compile. I've done so now, and it was actually
vfio_device_prepare() that was broken, I think, as it was outside of the linux
ifdef.

regards
john

