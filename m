Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E68CAC5AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Ur-0008WO-In; Tue, 23 Sep 2025 09:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uh-0008Ly-2U; Tue, 23 Sep 2025 09:55:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ud-0004Ge-4t; Tue, 23 Sep 2025 09:55:44 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5P5pk3995713; Tue, 23 Sep 2025 06:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ww0FPO+hnvi9CElcop/qGMyP0fjXhubJZfccNgphk
 WM=; b=UDEO9WQ85c6/729/TLHp9/cacmTZ9frcYUKtQkrlW/4HKoz87RTwGitAH
 QVXGRaHQnqs449EYxxG1d+9h+kYHt1uw69vBRCUirfxhlruf5WBJh8dMc5MLg1i4
 qV8KyznlFUKv0fGD8CAbuZAIgJtvItZWdG8eTArTKuQ8Q6wgXlByroctXskPKJ3k
 ZXpOET12xfkidDoXHKT3vjYT9MY2rEnCrY7tQdAPVI2ZfWP0j89b6wQhOYDCWsBS
 kDW6I1FdSueoBViEFe7oXKvzwPu9q7M7xqWH4ZQaL31AdXDpP3/gC7Eo2LRg/2H8
 +smaoEulMbuIHz1EFS26FPTt1XoDw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020088.outbound.protection.outlook.com [52.101.85.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjfch-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij2D9Q9skBtjW3l2xBZD4ZK16IGClnZclkas1HRg5Uu3IVHqN4SItwi/1JjtjfdJGIE5ozQG7czJWv4LESw7ImVSROO6bgFaUfzAsX5qm3aMz6YAQZXtLSmodNnwSqQ3zvJKrme0GhGQMBEI7+PeJT81HusebBMmZI0Hv3Gr+AKvzvlzCiIIknjVdylO24hQN9EaclxeCnnk9pX3tVwgx2oAeinFSUeqZbA7zPBKt9vS8jksqEDLn6kXRqdtulaoipilwiHjVUj/09hwtEZp4A6iUqJXQxnrwnEAlGQjkilFgnLINMzuJ8ovmG6ujOzuBIRbHofq0W6t1F9sWiqK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww0FPO+hnvi9CElcop/qGMyP0fjXhubJZfccNgphkWM=;
 b=ADtAZwApy/+CqSYxVO+iAPAc3zwSyef01SWcXT5PkvjeIR0KgUYPCfL+orcs+Z89BfI4u322/TNZ7IbKBflEe0G/OGkVNCR5Mgug0vYGJECnqVxAIUkCzTJfxn6XCXqC0buGbXO3C6lghGGkypQ0fPo0DjSTRaGi6ZnefoZLKfTSpsQxz0LWj5HDZ0nN5+6oIBFUI/Nmb1A+wjXUoio2BCazEsXL7Etji8025uT+G7svK75RsvzF5XDPTiab+DH3Db//qiQrXOim5i7Kbp15DBDEL/C8rFaVxeeG7hn+0i/trFiOXAzDwTROrWlN44JNN6SAPdd6UXJB1Y9TUAm6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww0FPO+hnvi9CElcop/qGMyP0fjXhubJZfccNgphkWM=;
 b=DGbaUzatx0viOUQMxgbs7mA3eYCOrrKKbUttayGU7+LIwdM7OgCOdZUQTUoBxgyvvDCQZCUtazBiCUNpo2U0Sz9GO2A9DZfzZeFmCHxDYnbnMbg+4TD8r6xHd61jtjiFhds8VbnelgmHk11YNPqh61E+fGOpkbOdwL0+DLg321ZMEL9Q+oVAYy1fzeCIuT2YZ0PXd0Spe8q1Z5N/2V1WPRFR8Ea6N9MBFwtYJuT6EGAtM/9SeBI7F2M3WX9b2J0qkoFMtMISsir4t0BN+rh/n4MYCw7hmb4vWSjZIJ5byVRSG4LIJOtmm9LQFpnOZN5f8IO8f9JRHElr3zVHQPksZw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 19/27] vfio/pci.c: rename vfio_pci_dev_properties[] to
 vfio_pci_properties[]
Date: Tue, 23 Sep 2025 14:53:25 +0100
Message-ID: <20250923135352.1157250-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: fa070e7a-763f-4585-d236-08ddfaa8cd78
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tYfAc0nG6kHfJrLDHByN9C6fo3YQ6iNmR6xvsu85yFHjZ2fTZkuLU6UupU6?=
 =?us-ascii?Q?3qdJfzsjOuLR69PxSK3h2pVz0DmEdFolZZewMJ24kyBYOQ2rEcKYk+dOyxbD?=
 =?us-ascii?Q?G5HzZTwshQRFKxSyxOPrjaclBxxFC+MdqhFlNxubmFSjJLLYIYh/mwPnT2pk?=
 =?us-ascii?Q?005dDl1BuSam2jIU8u6lHBNlz7vvQ60IvUv+bX0CjUssODgwLZD1uRrVTrmg?=
 =?us-ascii?Q?o3Izw/XiYdI+D5fs5dciugzePsMKXQeTAOtvc5uBN7scHNuYWzi6E8y4paff?=
 =?us-ascii?Q?8cC94K8bww0HZEnCnN8sO5mk2Q+AIWbKax46GkbCYGgQ06wyyMTnF6vn9ZAB?=
 =?us-ascii?Q?hOflbv3n8fKdrt6/oFkKqOck8zU8H+MRiqkM7gwgFeG6gozKeBTrGeEBB2UW?=
 =?us-ascii?Q?QBeMx5j9Fc07+71GZ5FuV7k43NEDKKUjO5H/AizW4RtMcdbU0kjC0p1Qy9Ww?=
 =?us-ascii?Q?e0AkcdQWDGmczrI1JGuClfP9tZSQtcrXdSiNGcPHyt8YzlFeE4nhCShe5fU+?=
 =?us-ascii?Q?I3ZoqmC+PIKWtWzH21zi3PQPPAQRNKSzn3k2BmQUGSjo+yia3M6zD/pDMHn+?=
 =?us-ascii?Q?GTbMzsfvsQ8ziMgVK71xsLEBEpW1M3Gd3lw3fyvY//aS14+KDSYCOPSH57wu?=
 =?us-ascii?Q?SRtYFWTz/0tQfpfvwo1iAgMfwcIqREqWc2aMbtQNW2aQIfiE1TuzTGFCI5o/?=
 =?us-ascii?Q?LN7WcOYOBOVKgrT+GA9Y0I00E8MMDLrFI6RZ/Fp/0hO0ZJAmAqLLeocwn00l?=
 =?us-ascii?Q?v8/Y8I+LRoBQHAJJEj56IhVSY5FxfUiFWbs/XXvNvn8a0YqR5ChZAcx+Q6Pi?=
 =?us-ascii?Q?mEbHl3R7rUrHoKXD6boMJCHm2Fst4GgNsWf8Uhnb4W1j+L2jCEYKrCL/klaw?=
 =?us-ascii?Q?lq6uAX69PZNeZUWW4ZkXGkynXR02KH5c/6kwug9pzc7SyNu7fYGe7rUagFYy?=
 =?us-ascii?Q?bcu3+d9Jwgd6PEjOfcKEmDkWlooWJq4e7OKWG9mIqh9USnqWEHuYNpTzvvff?=
 =?us-ascii?Q?7t5bVAL63+rlTLwOa7u6bJd0J1KLqeEjXur6DPsR4LpO4tSA0rW+Mhyl3pHQ?=
 =?us-ascii?Q?gQeraDQCwzJelQHlI+qoqE2ljWUCxW/w4+YYRxBWhj+Yv2qMK+nITvshOpw5?=
 =?us-ascii?Q?oTKksuFG0B7FsrStgBUpDw7uwzsLHmm14k/DLCjfWejpz5jfdviQjYzNgZ3/?=
 =?us-ascii?Q?iNitclcCEgRrLI5Qa29ASb3zYTYxG/m9Ee401cXhV38aAVDkP2Kj9XvCqiUY?=
 =?us-ascii?Q?F/g+BHeRcbS5lXNSwzn8V7dm3Tqj70I51FpdWcnv1ATvVg8eqqneWRGZRxJ9?=
 =?us-ascii?Q?h+gjsdEXOkdRY/NbZqMcuLTGOIdNzUIFlKyT4iJLTtYzVft8x24tsRav4gzG?=
 =?us-ascii?Q?jrG1Goztag7gsg1PLtA4hrKCzRRy2rHZVvaJKnxtwTLN/LuqjO8VXKSaIcoI?=
 =?us-ascii?Q?I17qCgrC/uC8FanbhljwTnRivD+oexFn5KDY8Z05yanzC+WyKaE2Bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E/dp7D8hE87/oPbpChLo+IoBH3VMe6YCvCxhqaQE4LV5kfzpX3Sv0E59VxF3?=
 =?us-ascii?Q?qwzYvjim0mPbqZVsHmE1MoJ/wocN4DcQtD/ZOIrL9SNMbR0KEmfyuBOuAb9H?=
 =?us-ascii?Q?VeeABK6SPTvQPgfsEFhaPmUg12Gm8AkxY2ETGNJ5v1vlSSmvuLLvSPWnVshB?=
 =?us-ascii?Q?X3C2lWkzzMZ2FZWW8b1ATL86I4JYus1vTY4r/6z+fRmQI8uAxEeRoe0x0mPZ?=
 =?us-ascii?Q?yN6h45IhXMC4yR75YGYvHSBTB9HWZesiMOHbB0e1LYMWAbDSco1kMR9c++lu?=
 =?us-ascii?Q?AH1nKaItHtkZLw7wnJcpp6727d3O5O1dJk+Nk2aP/04dQikvBwxf5CngMo/X?=
 =?us-ascii?Q?gsqJFXT6svjX3AmHrx18LVPVG1JvvxWoRvxvSw1k/Klr3AzNaFVe36SRXkwW?=
 =?us-ascii?Q?YOKwkeveubcK0yKEI9LtBCH1i7EwsIRNHw9110rmUqfHvKJcJ5pzDMFs87Gv?=
 =?us-ascii?Q?wK6Q1sC/8aJAGCl+b1yHOtMVP8zwkxtCcGfkHNKdZ7vbCBMs/ZLoH6Q1CGKw?=
 =?us-ascii?Q?MezBoE1PEvGO2sGbRr1HNtGbUUyaGCzCr4HyHd48UHNsdvtCpUucV7mCxGag?=
 =?us-ascii?Q?WmAYv7Yk976nHu+rdSD2NHBNQfXCHX5Tj6luheq43mb0gSoYVHjj7xMAqqIi?=
 =?us-ascii?Q?IiokU3YaZCGfcSHST5MSmfe7MP78GEu+/APRGQalbu7ZoDrlJ8KNO0sLq3pP?=
 =?us-ascii?Q?a0NEKB6j80AOsKPaBvRpqaTGUaZVoRiB9v6GXwBdFq88cj8kE9C0YLrBOLe9?=
 =?us-ascii?Q?sas132DqpLo+tgoDI3tG9LrdyWYLviB0QEyqE2SQ3FNuFigAnS0PxT9z059x?=
 =?us-ascii?Q?wyOOtK84YejQxwuNjnZwB2SpA4MOZwXYYxoQLqdvSMR23wBQhb6lt1+LhOAQ?=
 =?us-ascii?Q?JALyLbxcbCQk31jHYOOz4d1aWa+AmaKR6ryKGjJHe4Fc8jNRRCa8s5/WvuGQ?=
 =?us-ascii?Q?UZ0pH43wvGf0b1DXPTxbdrgb+lgOTKDwDBcqXpai7gfU36lYRzGMbaDpgNqx?=
 =?us-ascii?Q?dyVASPme0oMyHCXFsrM6p10yKOqx5Skfgpx/+K/SinD49gGMAcnfuhOC9lym?=
 =?us-ascii?Q?dltm+st8Si54u4ZH/LW3rPSvuEjWzryaXWkr7f30AgVosRGZM+G4zvm5P98l?=
 =?us-ascii?Q?56J7U89XOJgL9u2BXFSbac/EAQFn3CYRJIDR35lv0JfV8zk48tG/RiTPsltI?=
 =?us-ascii?Q?gTIVTcmlbDV5KM23ezW3xfg4NHFcBEW32CdcbFVkW2EDKK2Bu/sdQGFAv8cT?=
 =?us-ascii?Q?FW+5iQJLqQzgudD+cdbkSWM/5+OhtK/cIvgDJWXI4LvxOXnMVpcBpK0353hG?=
 =?us-ascii?Q?wB3yKjxc75DJOhOXI3VuqyS1PJt6plwViGFuaf7Ez4yQzTC5IYZfZCaweJ5l?=
 =?us-ascii?Q?Rlu/m43HC80dpmlrxEhrhXIYghc1QDRJJa95BeMOpOYIl1jp6T0hZb8SzdHN?=
 =?us-ascii?Q?CrN00mSZbvnnY/71cIR73yiQjQQYvqo+m6H6UkTrW4dOOd4O1iMcM9YoE3Yg?=
 =?us-ascii?Q?4HA0I8R/sDWK8XQIDNA00cMET0r5ItVYwAf6gwdEFrMNHDuBKho4w1f3r8bS?=
 =?us-ascii?Q?pp+D5KKhAjsZsgUoUzGBMrU4Plg/8FJL9FQBHkbmJ0RqyhKaO/J9R5Ms9dea?=
 =?us-ascii?Q?DDvSN2584WW4qBUErwYXI+PtH6loWV5rBID5eLmW71ygHYQo6VlQPllBdljw?=
 =?us-ascii?Q?EJUYFg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa070e7a-763f-4585-d236-08ddfaa8cd78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:06.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBnNPFm6dWxuTP7GFzuoyCReXNvL+oVOW0t/6M5cpCKnirWxQbPdMezUzzxWEyxxUpgRTrn8/0s2jURTlYADa6Nf7gf6iuEOCTlygfMXr+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXy2TXbJx9gATu
 jxKb+KAwF27OqWATUCuvXqYV+L5BKbG0PCJMVJ0bplcAErHHaHXU7ggoi04ZQHO4JpsGSiFdw2N
 QNSle5ikdCoO+5CHYxQ2v9pVfnSqmjFy26tEk9zjAVvD4LVaG38e4rGvPFGyXbjjpqP7UVrUnnU
 O+R3liV4PsJLGkcBrEBMoeFRBovB4nSFG3EUjQsfEfcaoU60iKhWROOz+wilkwXDbpK8htECFR6
 wSPaQu5W0CZJqzzoFmrCK3ttQnxsxqomC2QWNyGuSJVUjwy0dcGHrOn5XpHvE/2xQdpr+mlEMMj
 gmyt4j+6KegRnJg06q+yfytOBh5c46ra6Vy6i3DWJPaKldp/QrIDTd6R1oYJ38=
X-Proofpoint-GUID: y4ai1rlQsFIIg_wAZjAzcZDMFojqLJct
X-Proofpoint-ORIG-GUID: y4ai1rlQsFIIg_wAZjAzcZDMFojqLJct
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a6bb cx=c_pps
 a=RH0axx9bUT6qb0hBLGrbHA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-an67RP_g-7o1LT8KO4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e8d2e36df0..839b5af339 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3687,7 +3687,7 @@ static const TypeInfo vfio_pci_device_info = {
 
 static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
 
-static const Property vfio_pci_dev_properties[] = {
+static const Property vfio_pci_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
@@ -3773,7 +3773,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, vfio_pci_reset);
-    device_class_set_props(dc, vfio_pci_dev_properties);
+    device_class_set_props(dc, vfio_pci_properties);
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
-- 
2.43.0


