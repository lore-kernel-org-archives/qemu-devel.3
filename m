Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577C2EA855E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzTON-0002He-FW; Mon, 09 Mar 2026 01:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1vzTOM-0002HW-PP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:42:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1vzTOK-0003Jl-IX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:42:58 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628EfC6v4140311
 for <qemu-devel@nongnu.org>; Sun, 8 Mar 2026 22:42:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=BpPso3qHQYS/Z
 RTiwptr0cx9DReXSA06CVY2n89itlE=; b=Lo6Sk24lyPd/COzmxkX1B1pHGdKVA
 geRkNGQWQFKi+TaYnF8PjngHVm/1LMgV9t7QS0U38bTxPBPZ/AJ5zfxiWX+2Ppgb
 MI9/sPcpLdDS6vF6lKKm9sa2Y6U0WU/IxjfvP3X2Bv86Mks1eIoJoxwGmmNdPM1h
 tNOabjUiV/JPAWcxsHge6cqxyZrEV/gWhe75a+ubQmY44Ig5ej20P7vZBp61R3Vy
 eG55xdY6BI3conei/bdAgCyx/Mj9UNU9aG7grm0g4XbjYoUoP7vNQ7gBIanezQ8t
 nGNf4RvowpK4bhyBApa1ludmVWulBHKUu8ayUFqDGQCrn9LVJLDUz/oMA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022114.outbound.protection.outlook.com [52.101.53.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4crgtaatg0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 22:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klNONuAOZYn6PVSpFfo7jvkEus+CHKww9J+UEdXEbf+TtqGWH5LgX9jx6o3TJgq+KTKdSqanDiGd1mE4J9DQ7suHNSe1jHvHDDdSv6la57FjRmU5Rg0ifIuuDYAAj2QSZ0yRNZPbAMb9RU+7OAHfIxDndUOnP9qaUA9gd4ZAbianmt+fUVYOCsRbiqgNmyPvKYZIBVWsO0yusnwRktRcTuPFj/lsLouYLPU+Vx8COd1QJGBGjJMFDLAh/kNUqQGFyP4lZ4cbcoPRZGHzfzl3I/VgTlslQYTzrr9LxT7HAcWvxuX2q0n1pRrHp1QL33diJ3vj0VS/zv5PHXzLSOLN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpPso3qHQYS/ZRTiwptr0cx9DReXSA06CVY2n89itlE=;
 b=vqhrANJ4MbwQSpeW9ptX2JoheebxmKBE4+cA67F6xorHZ4Rn2+AoNV58vosvDxd8EjUBaO9tFfPJcVvu25jUkv6RSttLOhvAxtF1YJWZuAD40A9z9iygTbNtwyHR4LbhowBwK9WKPXoIXEoA/8KqeAvWNrqkD543/TkbP+EgAd6G0NZZugDLO2GbvcHqqoR2v471s8mRp72SxSF0ai3y1adCM8FZsSRp8SXOGvBVOe5oRD3gPHzBpqb9o9ZlVRd5d8ew+c+JVrWgr1rDXcSEZv0wKSvJFvIJL1qV+vPWOt2dZ5S8zIqzCeVudEr2WraBecb8EZ4P26olJ4ACk3iviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpPso3qHQYS/ZRTiwptr0cx9DReXSA06CVY2n89itlE=;
 b=gvUNmw+8ayV1dOWIyMKoaSaMuq+nZhnt/fA26bczk+V+idKtL3x3u+Xe56HJkihkW0Xz16KkWVDKfIofN1Pco7+kxawxqaAdT1oZuu+BBItbfMLfiYorFs7RLAZ2b+KvSysPHHbbAKkg3GFe/OvEghTbZ87CwGreYG0JbpcgTw22BUx/c24zvquaPCt0JjQRDWOBSVamumdFVKX5ukv/N47xq1ohwMswG/cGMXg9rY8g589Tk9rtCfhEGAYaOxoQJGErxmTG9B+PWzNoH/XtOuitFAoOSM+RAEQwaFZJDuQp3ysRiW25IEPntrzPSekYtPgWsmiCOAj+leuOOgyesQ==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by DM8PR02MB7943.namprd02.prod.outlook.com (2603:10b6:8:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 05:42:50 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 05:42:50 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org
Cc: shaju.abraham@nutanix.com, jon@nutanix.com, mark.caveayland@nutanix.com,
 Khushit Shah <khushit.shah@nutanix.com>
Subject: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
Date: Mon,  9 Mar 2026 05:42:42 +0000
Message-ID: <20260309054243.440453-1-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:610:e6::35) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|DM8PR02MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e81a81-a8f8-453c-0870-08de7d9eb374
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: yREaqcIXsWfzxKv+H/UIZiQWtVNBsARwA4pY8pouOzKQcx2YHyZxmXLEuVE2cBVBCDU8FeGjCuNhsglAsh0OwsNo7coMwHbHei8FrG2+bcRKwSFHwWHEDQnFxpxXeqcQRuwIvugNdR6aLZ4lKfrkJ8KzDUI075GQ0b3pZxEkKZZN8G6ns9P+DJGHxdPwtubgeIPxGtscjAzuCytG0q3ikZVXbHNzoJBbJLhf2Qag8DW9CzPftTHbcJFWhOCZLVv89iOwhGFWbhfku2/yZxfsIySYzIygzKlMtf8QY6GVYxv9pdhjc11LBJnhqxpZRv5jG4+NLyNxAT+mC3kVqVDqi293r4WHnzORXgI0mjLzA2LwQPJSZ7BYj2Uk80a78I17iu4JYmTdPoi6PERDsFkUmTgUHFnWsrocnVOUxF4yL4eedPDMZW6oXSXuYsrr350QMd6KG/2eZfXEOeuS6XIHy5Z1RIbAodlG7H7vdEQEwRpcp3G2Mp2syPoiKL7FlpUAWCl9/XCcYzLFaD19ENcOoJK73TEYzrDEFWiRzVHY6B8SPqTo7wAcfn7GZKnqON0MgF5m1Jm+GWcIrqo3W8j4u3DK+XvycVLOYgjpQ9MHBpsjixJdqjlnlNENGeBO6V3J2tSs4LJUHKksOiEcR4tuffD9T9530BCy1chV+b6sRGcbcEWU3jZjb0kd7Dno6Un6K8s9AiT8oq55PC0hI3sZgzmaAWF+7L/Cb2IwnJMAA8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnrICAQjFlw/tKhlDdPiyOpUpouA6u4yy9AbT97qrKp3dw8g4PdtJb8dBXbi?=
 =?us-ascii?Q?d6r6c+bAasxM0jxqI7RzRJBBCKciSPOxj/9ck67R7mFx0imrBgh6nvK/3oUk?=
 =?us-ascii?Q?dIvqx4L9ozH8oC/xotgKO0byfIGaqOUFia25lyqND1+p8ARhKQSXelo1Wt/N?=
 =?us-ascii?Q?xBW43Q5Sf199xa0mOQHCSmTyW+nAhpvXdbPxgCD6B34G8Q4radty8f1e+ldN?=
 =?us-ascii?Q?j8hq3gmGL2OF5e61llggpNPNXPJSE6DRf2rIg8HVKvItXStM1mjFv7m9K5SO?=
 =?us-ascii?Q?tB89wPNbxpIaP8xUZj6rtGPEcGRQuu5K+a6RBrXXy5rsc4NhgwitjC3769Oy?=
 =?us-ascii?Q?ZoAnMRxIZBmLrzbxchiybIZSOKZEuwo6gyarHbbOZlMOCWC/qPrC9YH+PEvV?=
 =?us-ascii?Q?YypO7ZudlZnIZniOmX0ftE1mVRKExomDuzI9W61E4Jo5TSeIf/pSm1HFlCwI?=
 =?us-ascii?Q?7vbJFVzg1YsjAQbg0NuwUw9vkD5awYB3JxO3/+E7iYvxTmzg+Q6aEUJZA+N9?=
 =?us-ascii?Q?djLhUgQK955jTTd2/DRAseoFTQJgRZ7LB7ObKlpfZxOCfKPp7RL1yY4gescS?=
 =?us-ascii?Q?3HnXvZrREWkPUi6D5aFrXxi1O/KvnC8aFzGXAX41v5xIBp7wj98q1a821bXz?=
 =?us-ascii?Q?GUhzloqWXudRtJ5Og0UAJ7SOiMJoJMa0NP7Kb2qRoBQf3kgKEKjXnVm92d2P?=
 =?us-ascii?Q?JWGocmrhlMj/yrx/fAYJKlOlE6z+dfXxVwQuyK+Z+6AeAj78DgtQTkX6l1uW?=
 =?us-ascii?Q?TPfNkrD8e4x3NY+r2yN7BHlokjHQCIYMKE12tE0PAuy21iqj7LQdUWD1cZ1e?=
 =?us-ascii?Q?3Z+m2X7NVwQ7cQSubG6Vkf3Krs4H4iuSd8reXWqrVx1Nh+3xtDFWYdrmCuHi?=
 =?us-ascii?Q?/gXRNsnNmOHl7vqZnVn1QcaihZibPgGp211P9z/OqBwEZhaIKMkOWTwYgnRY?=
 =?us-ascii?Q?w4vDSfG/jL8tfZkc419e8Hl78/82fX4c8/Q/TeJaDqLvScNUgaM/aXH8xaQ2?=
 =?us-ascii?Q?+h9sa1rCf2SoBub2d+YnIc9Wun7c8a1rx3zgVcIA3PWvUS4A9NIIAoSbHJyJ?=
 =?us-ascii?Q?YU2Hnx2rip7hbb7ft7I+U1zRY9kruhFCFgLpuS+4dtj7C3aR36klMa3FvFo9?=
 =?us-ascii?Q?E7TB++/1FhotGPS8Z/dewFxSbaQ60R1iaxwflsIlrk6K0Pnn2OzBTydV4LWD?=
 =?us-ascii?Q?hdS1frMoNpB377+FCjEsq8B96e7AheFJtWXGvjY7S1IiPJ/aZVT3f0+1spYs?=
 =?us-ascii?Q?XjdmMsRDRfrZKUsJumbpYMhvYRB48O5538WGYCWX2g3vnWbtGqiM+hkDqJja?=
 =?us-ascii?Q?jI1Eut1YpYgFbVHDwSjWPwRzT9fnbG7zTdYYeZDl4ypQUfdTEBxBxUFCC5XA?=
 =?us-ascii?Q?JIC8Gu4AC2U7OUaRftOsE6bR8hGH+AQwALZT4aW7ak0vtGeYTeGqoVm7R36Q?=
 =?us-ascii?Q?TlPFi9wpgnTDWLT0874ocSbLGjIl3/kslhTaDUNP2qW4pPH1m8YdvwyrYohp?=
 =?us-ascii?Q?sGl1xBzsAv+bysxhBFE4zmToo5/VSS1YZ2eAUHUGBGDrNjqSv0y9NX+sRB/6?=
 =?us-ascii?Q?ZfFO8QXzlgUIAUEv9Mnd6KUqtlGKflninI3BInQMISjHLA73b0LSakTiR77e?=
 =?us-ascii?Q?NLEdckMDfQbdgeqz9NSj9wlf6FgAcBi3cJ8e2l2ogbdhRp32ZTSuMxybT3Qu?=
 =?us-ascii?Q?HFgOtI0QqDFhc8xpd7ion2BJFRZoygu+N2WdtHrzxtL1O0a8LdEYQrcFGkte?=
 =?us-ascii?Q?ei0d5Xh/exCMbhYixKOE+S0aFFSZ+mE=3D?=
X-Exchange-RoutingPolicyChecked: sxxBqvg+ENlToFhJoD9PMrfkafnrJ5hQ8lNZih1BpBVdd4YtF8p9B0edrwBgloYF7790/mqq7d6HEjUOop+GNLN4zgej8YKM4LF9kjiMOS5hVb9XQH47tCD/KCWNqs15jcIV/hubRRE2McFRL9ewp19XrwB/K7os0iI/sWZDOnaTLv+87zRAJ6dZLQBNoxUWc81jIYXplhmlB8yweNWc+pVLGuaPj+f0VczIGjuNDTWH+xePyhRkBVlM18LyN4hA/1H7YpvbQCCunYRslg1ikxgb2WWPoVGWD1Iw0FEqTYoYqGclse+wAnf7cBN5N2xa2NJ2TCq8l4UU43IQVs0PrA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e81a81-a8f8-453c-0870-08de7d9eb374
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 05:42:50.3627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDzzFShm7YJFwoB4wuPvD+/jUHlzVIj0coWPYANf7SHrTSc3NKOV3cKv9FlrzzFIe0dnrx+DYNVVJj1EQPLwvXNpmmd+pJaR39LzRCDsLV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7943
X-Proofpoint-GUID: JDhQWZ288pLwMyA31NpB4hYrvrWL-rha
X-Authority-Analysis: v=2.4 cv=Ov5CCi/t c=1 sm=1 tr=0 ts=69ae5ddc cx=c_pps
 a=PPij9JC9dsFwf49xmEs+Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=-U2uNs6vP0nRpjDBlIoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA1MCBTYWx0ZWRfX7zXg8o3ano+R
 ZPFfFNJdvrmlFBnyjT3nZwkjtTjaRuvGhhhgb5vCZ5CgkTHi6QpfVoCGvMI623+7fDy1fsP4o/Y
 OcTLHiF7Ih+Em8mwsHIH4jMQ3pmPmEfjQEiqQZWzDrk9mVGg8hv/kYEaxuo5s3tIEM+ZDPP186M
 xjTdm/4kfMvkON0FLju0iz7D8hZVNd8w6ppSaO+pW+kqRbfHgewpJsHEPuHY5esaDZ5GWhrqTAK
 a29PGK7ddLpDUc8MM7eA0rio0pcm7c/YdGumXWypDn4Wd38QmsDfEy0hdv60t7U+NK9ED2XsXiH
 K3TeXFQo5rcKD59fpIZqsrpQzCCvgsx88GJ7A+KZeAMxUKCchgFORkywewkKeFsYuYX8cdQk7Sl
 rzZjg3OMrIPBrxe07Jg3YJpBpCj792KsyWDJslrbxxxPFAwIvTozf2Ofo3nyyV40AB6EhcML1iI
 gK8h0Hv0QlQ0WUuPKaw==
X-Proofpoint-ORIG-GUID: JDhQWZ288pLwMyA31NpB4hYrvrWL-rha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=khushit.shah@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is an RFC posted for design feedback rather than merge.

Problem
-------

In split-irqchip mode, KVM unconditionally advertises x2APIC Suppress EOI
Broadcast (SEOIB) support to the guest. This is wrong in two ways:

  - IOAPIC v0x11 has no EOI register, so advertising SEOIB is incorrect.
  - Even with IOAPIC v0x20, KVM ignores the guest's suppression request
    and continues to broadcast LAPIC EOIs to the userspace IOAPIC.

This can cause interrupt storms in guests that rely on Directed EOI
semantics (e.g. Windows with Credential Guard, which hangs during boot).

KVM fix
-------

KVM now exposes two new x2APIC API flags to give userspace control:

  - KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST
  - KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST

This patch
----------

This patch wires those flags into QEMU via a machine-level field
(kvm_lapic_seoib_state) with three policy states:

  - SEOIB_STATE_QUIRKED (default): legacy behavior, no flags set
  - SEOIB_STATE_RESPECTED: advertise SEOIB and honor guest suppression
  - SEOIB_STATE_NOT_ADVERTISED: hide SEOIB from guest (for IOAPIC v0x11)

The current implementation automatically selects a policy based on IOAPIC
version at VM power-on time, and migrates the state as a VMState subsection.

Design challenges
-----------------

The KVM x2APIC API is one-way: once a flag is set, it cannot be reverted
back to the quirked state (consistent with other x2APIC API flags). This
has several implications:

  - During incoming migration, we must defer setting the flags until after
    the SEOIB state is loaded from the migration stream, since we cannot
    know the source VM's policy in advance.

  - Snapshot restore (loadvm) is problematic: if the running VM has already
    set enabled/disabled, restoring a QUIRKED snapshot cannot revert the
    KVM state. QMP/HMP loadvm makes this worse since it cannot be detected
    at init time.

  - The flags only take effect when kvm_apic_set_version() is called inside
    KVM, which happens from limited paths such as IOAPIC initialization or
    APIC state setting. This requires setting the flags before IOAPIC is
    initialized, necessitating fetching the IOAPIC version from global
    properties rather than from the initialized device.

  - Automatic policy selection (current approach) changes behavior for
    existing machine types without user opt-in, breaking migratability
    from a new QEMU to an older QEMU for the same machine type.

  - Machine-type gating (restrict to 10.2+) helps with older machine types,
    but still breaks migration to a destination with an older kernel that
    lacks the SEOIB API, again without user opt-in.

Preferred direction
-------------------

Given the above, I am leaning toward a KVM accelerator property (for
example, `seoib-policy=respected|not-advertised|quirked`) with the default
being quirked.

This approach:

  - The user explicitly opts in. But requires user to understand/configure
    the property.
  - Works with any machine type, no machine-type gating needed.
  - No need to fetch the IOAPIC version from globals.


Note: The current implementation also does not handle the QMP/HMP
loadvm corner cases. 

I would appreciate feedback on the preferred approach.

Changes in v2:
	- Update flags in patch description to match kernel naming.
  
Khushit Shah (1):
  target/i386/kvm: Configure proper KVM SEOIB behavior

 hw/i386/x86-common.c         | 99 ++++++++++++++++++++++++++++++++++++
 hw/i386/x86.c                |  1 +
 hw/intc/ioapic.c             |  2 -
 include/hw/i386/x86.h        | 12 +++++
 include/hw/intc/ioapic.h     |  2 +
 include/system/system.h      |  1 +
 system/vl.c                  |  5 ++
 target/i386/kvm/kvm.c        | 43 ++++++++++++++++
 target/i386/kvm/kvm_i386.h   | 12 +++++
 target/i386/kvm/trace-events |  4 ++
 10 files changed, 179 insertions(+), 2 deletions(-)

-- 
2.39.3


