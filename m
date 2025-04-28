Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F4C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R3l-0001mM-Fy; Mon, 28 Apr 2025 12:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9R3T-0001aD-Ex; Mon, 28 Apr 2025 12:10:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9R3L-00084d-UF; Mon, 28 Apr 2025 12:10:02 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SDRwqi013771;
 Mon, 28 Apr 2025 09:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0oFDdUwVdB8eaDe4P6ChgzUgIDlOFkBc1YQIwmSfe
 L0=; b=vy9iNsxKu7dHyO67dxTlMeIhiaDkH1QhX0XX+80LcDLo9KAPDzDWXIscn
 t/BQdL6k3cjcsGrtvMQdTMDrMe/j2DU20AMTwwJIXPPQY/ETBV0mqbSoxB07Jf4t
 GpbU0UWHadnqF0inSUzrafL9KkB0/FqH4lvmhcljxPElApeL45rn32pbb2ngkslw
 X5VeVE7lannYl3UhpbWxueJBD2dCv61JSmXSGIKJEzPGcmFQjnavFYBfl+4wKzuq
 yzRBQVKsLgqpoCm7GpUbQ3JLEiBiWLxYygWFhRfXs7Fad7P7KBGaZrRwvamFLzr6
 bTujp8RYmWcV64+JJfc6ZBTK2gENA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjjufpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 09:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXDHDtUUn22IZzGF5krz2MYa3pTKCMoWDBaoON7PbukMGTezpr5eIhnu1DPkNpkEp/fRmhlPeXkXiHa9YJJuBOvQKZXi6/VLfeRl0vBle8NoSl89Q3ME5MycAU/87wA9K7M839KhVzjyU2jT4XfWk1tBjgdKj+DB1KPw6Y2P76WtHEGXvRB9CYcQ8uHiuKyeohWAn01qdtThbDBj/KklcMN//DiITxqqzd6EJTo/ctPoAz8DG8h/cnV/Jjh9AmfavrxcBy/SzU/nx//EAi8kVaJm+TtFrEO+s+ZZhP9p3E9KjTU/zLMmQgFcQRprA8/ylIQP9VLpdBy7yMuQSnMPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+08RHzv3Cx/eZUDVxbtEw/v1yEdjlMxD3PxI2iqBJo=;
 b=bEFNj+Pw1ygE+vu8LktQy+NZ+hng8MprgdM9SVg3wM0jVLghJltEkbVZV81F6Krg11dbGQME/OY3LmCtaTGa8KK+o/tI+iUJWOLHuJjn7DIAW/n+qfesWRjbtCcWZXWL/OWdGNPdApzUpuoetaaiRHSiT4sZDw7MaOr0wSfQNNcZOXz36Pbyz7/VlXw1t2lnqk3ypx6oiK6eYYChgHZb2g1J2IZx+jZVBnH4pCkeU07TUUH3ni2lxrmryRtrYclukyYP9tdJZUhWLT658ZQWuya4aRz0TtcO/V60zhRJrbj8038n1Oc13Ux/GvK8+cQsrHzEm5WgWqmk30uAFfQg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+08RHzv3Cx/eZUDVxbtEw/v1yEdjlMxD3PxI2iqBJo=;
 b=SRaaHB8Bp1ZvPfkqIoH9u+Kd5xRhQi0Ws9RqkZlOzBmpZvi/v0N8uuzzBPJGqT+Fk0SjhG1l376RoDZtuRbsFy+1nEFOexxCOsDsoN/trMTCJARABGe9uKjcp0O0eWjJK10toZEA8tanII7Dka7kQkyqYGw+ms5ccvEyCBH8nXb159MQ65z/cTTMIbrUpVCK6dtiaUHqrdtt1bl2vL+kR/hqQeZWvMX8kJRA4BQGebm3vR4LN03yCP5UGls017Y+OorxnOyt+8RaD1ALvaDVWjp6AU7VQw/p1VXYY6mkfuTxoGeRFojCKkcQrK/h84oz/mvbzaiw5HBKaNlnpDD46g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6978.namprd02.prod.outlook.com (2603:10b6:a03:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Mon, 28 Apr
 2025 16:09:07 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Mon, 28 Apr 2025
 16:09:07 +0000
Date: Mon, 28 Apr 2025 17:09:02 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 12/14] vfio: add region info cache
Message-ID: <aA-oHktTgfqR-KWV@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
 <fd6fa8cc-8e11-47a5-881a-1f0205aac742@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd6fa8cc-8e11-47a5-881a-1f0205aac742@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a93d13-b977-48d2-ecfe-08dd866f00fb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7adf/6zjnmNF8JUPerTOZ5biEEwFulS8XWSJH68+jcZGPmdW42igBEGHF7?=
 =?iso-8859-1?Q?2wxb/toonOgbgwm1x1kB2FHBVVx8uw7a1S3TUatYZ7fyM76AKG+LKV/X4k?=
 =?iso-8859-1?Q?bmKCzRu0hN1rIGjZcrEG9L+sBsj+g/pRRBXiYzLPlo5FaQMzFl9iC3shzE?=
 =?iso-8859-1?Q?cyM1dOj9JfJjceLWqrcW7VXSUWRbPo0OHNWikpO0V2aujh39qkEt8s59k0?=
 =?iso-8859-1?Q?BmMjwXznSJIrPnTfq+OnSljkS/XvKfxr2UU7JnRxLikWAYlmRMzaFdz50+?=
 =?iso-8859-1?Q?mt6F3+An9+2OH3LueGMhCwi+rU1RRYfeYg4A62iUNviL/4MB3rj2RFA0Fw?=
 =?iso-8859-1?Q?uijVo9ukZ1uiFE7WxquK6zZuVc6R6FZ4eQnOpBXXYbacHaugiDU5KLhPd5?=
 =?iso-8859-1?Q?0eni76vDUZ/3hwPZRg+LZVlr+AICOi0QkW1/UrfMtvNBdxlIn1EPvBRrr0?=
 =?iso-8859-1?Q?fHaOYYIc2Bu+l9JsGmSFBussMvg+iupGdDxh574/s0/ZX7jHgXHm/J0n2q?=
 =?iso-8859-1?Q?90dXspyEyPcAEn59qYo6M6s31qhg6hLKK5RGXBcT4Of7kbc3p5Exq2Dsd/?=
 =?iso-8859-1?Q?Q7zMAZwAMm/yqAmWw+VOBCD3nX61vZU23G23TGWfoHpuhtIW8mLBwV5NjC?=
 =?iso-8859-1?Q?4tecFDASjlMl2OgGUhPBI1zjyYQGp64S7oCigIz5cp89QbY8DB05VWcd4m?=
 =?iso-8859-1?Q?VxI5sqJSZR8ZqecRVuLk6ipm0jpUsxIXpULwXvG6BzySV4WYg3FRU80gS+?=
 =?iso-8859-1?Q?WaWZZoL9CQH5P8gYjesay/eBNUhSckxxgiP+LNbfqfbvek+gaJYGfLTwB/?=
 =?iso-8859-1?Q?tQTkcyIwxq4i9T4gdyJOrRqRXLk3CSnFYrIQP5ARxfLH5nX7io/6TiOf1e?=
 =?iso-8859-1?Q?TrOGIAmOjtHJJqqTuRqs7o5WiSpDdB3gqm9g9U2JtinPey+qxI1y1sWogJ?=
 =?iso-8859-1?Q?vFCtmZwIYCEWT27nwMXJzTTjG/rt3hKQKnxmwra76El5EMLw8x1JbhDLsu?=
 =?iso-8859-1?Q?OqrZI9bhQm7eocm2aLXD4WX+liuvKjwocAoY3Hd9bzNF4bSeRgVNlfwzDv?=
 =?iso-8859-1?Q?oO854sr11VYJPZkOmDBGkF6gm56YmOx5k/t3qktyzw8MmF9gU1QlOoBHMA?=
 =?iso-8859-1?Q?fRdur7lviwoGBfHPG3m23qOSEafZtG1MExHsPl53l3cEQvQbkj9/HsJynn?=
 =?iso-8859-1?Q?rL2kN+XSU9UVzOls/ZpS5E89EQf5jt3CQQMVruLPd5USTglfadioFBxT+l?=
 =?iso-8859-1?Q?dwHTVS0Eb9WzjXVyBozqlpATJ2zxPUV6zNx7SsfwQEc041j5bMsMKfNe8F?=
 =?iso-8859-1?Q?UHReL7PU4B001TauktI8vJbEoIKhe6q8iLpxpQGUNg+Gdpd86XN1MkLsLt?=
 =?iso-8859-1?Q?Ho+7GlzeC+KdQZ0DVJyzxgW1xaZ7o5xYuur38oeZnjDYPBPlQRknGCuqPq?=
 =?iso-8859-1?Q?EltQckHF4SmcN59J3nrCVM7JVWN37lpo/hiK9mSc0lq3cVgHuVx1MpJK54?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zMdyx8QwxYtXXeg0HpUE1gDblsH7jUEhhZglbtvDzEEAy2XzULf9ZZXqHW?=
 =?iso-8859-1?Q?VylDGZ8vJbIE4/IdzBVDcN9DFAjaG1++VCqY0LtRkuGW0Dm03jYKXmLNy2?=
 =?iso-8859-1?Q?dgYA6SRGmaqlUCvxG0x0BB+HkTLis9Kf8jStbcnCGWmTfwW9Im7ZtSbC8J?=
 =?iso-8859-1?Q?d+j+LywfKpvMLBzmV+f0DAPPofPjOZQ+UpRlW84EGlkS/U+KSZaFlqhnK0?=
 =?iso-8859-1?Q?lYvI/szdES1b1raS3b+Qhr/2Rzqnl8S3oRvf/gONNCFqHk4VGMlQBdU9Dt?=
 =?iso-8859-1?Q?66TvVCk4s1QVvcuGgX12LJ094cVu9bvZfKB6ENXrVyLX2e/M9NOhxqpeln?=
 =?iso-8859-1?Q?PanxfB6wZTRiRGvnNfiqvvC2FbaLrFE8nztOYYSJYPltadOcDpwtgbYxmi?=
 =?iso-8859-1?Q?OPrUu9arJ1ZAvuev+McPLcwNWMBKYun+5Cf/tk/iCY1VQF67ppgNVz6atX?=
 =?iso-8859-1?Q?isV0k7iQEo9cdCfmEkhjoOQ9sySpt78wf/wCsR/905aJO7adMDE8XOOd9P?=
 =?iso-8859-1?Q?jfUfdx/mQ1AANV+s5YZsUtgSwIPE/y1tNMhKub4tXZVpXND7Hz+fa/iUCr?=
 =?iso-8859-1?Q?NyDN+Xi0sgpNcknemODf24N3qsjq8L5V2Ntl/ml/NvJN7Q4M+WiMi4Mvhv?=
 =?iso-8859-1?Q?2sIhdjVKVHleqIalrFFwKH1SGqAuqW5CjCWAYCXLKPs7e+A2onrj8vRJbt?=
 =?iso-8859-1?Q?hmNCMVo4TztB+vAbtEeNJStKy9roFe99Dwdh+whE5VOl/Zahd9q36TH/jI?=
 =?iso-8859-1?Q?Lb1Oo3+ZC/CV6TjuGo0ebznrKIRoIRwXOi7K7EkjI2FWnsAhA0nzKgsL5M?=
 =?iso-8859-1?Q?UPA87FOkfJwR6sWhdb3Y+KAlzipQ4UvRU2hTI1fDn4KKpeVGUwFwqo1L3I?=
 =?iso-8859-1?Q?8rH6Bv1lqxYhoZf/ElyjlLxlmE1Y9GcPV+v/FSxiw2OiQj7baw57wXULga?=
 =?iso-8859-1?Q?BEzVSjaPXR9NYj8VY6fDow0uZ3mF8KneK9JjyX+tKJzknZdY8mpfdKCz8p?=
 =?iso-8859-1?Q?SPrEDYcIsor6p8+t3r7B49U7d7I/pplIR1g+GkNCsXce7Ay00luBgG3OGK?=
 =?iso-8859-1?Q?8G/hh46NOOmZcuc7amLqNyZcBihISeNS+1skU21+ROB7o33ZeNALK1Kbai?=
 =?iso-8859-1?Q?/BIoeet82+AC1PP6RqE58YLAFCz5krUTRGL0IbGI2jusT0d5dZOTpLl8oZ?=
 =?iso-8859-1?Q?bcdLT4e1qZ5QscjPiCeAg6cEvuSB3QnVqrNAHm52Vv2H59NDYh0RQ1C0KA?=
 =?iso-8859-1?Q?Yb2io2/Zlbn1zpTwDDVyBS9SG7FNri/AtO7TuAGYqHC6sL8oqofRl1w8G5?=
 =?iso-8859-1?Q?zUk5qd3p56G+6AAYDuCrT25rtZikce6wiNdmJtRvJfaebf3BfQDztwZ6Ra?=
 =?iso-8859-1?Q?AwqVEfgKqntZgaPUV9W5DjBmcnkEAxvi6llkEH+BbmfcENoag+900D14Ep?=
 =?iso-8859-1?Q?UN4XYIjihrBnv0T49HnB0EIkN8umE9YPifuInI+pMVIpnO6IZjfLRLSdlV?=
 =?iso-8859-1?Q?l3Z092QRdlx6ZASEAnt/U/vf702/jFXydJ2ZKPyvEOb0JZp/jPdrM5tuay?=
 =?iso-8859-1?Q?x0VnPO2NUF89vLrXoFtlGRTp55sPnEIPxSWDrFQIXJg2iASSq5RZzz/SI+?=
 =?iso-8859-1?Q?njTpvWoZZZemeDtBgFGwBmFU5MM/9E2PVc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a93d13-b977-48d2-ecfe-08dd866f00fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:09:07.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMDqFfyl0xS5cc/E3i90SjJIawPgTPBmGJGyuUuvoMHsd4006DS7AuwFZ99iuqoDKfA702ziUxaoqI3dOFSGRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6978
X-Proofpoint-GUID: BUj3Ut_JricauPIBQOJAXDD5_ToYZeSN
X-Proofpoint-ORIG-GUID: BUj3Ut_JricauPIBQOJAXDD5_ToYZeSN
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=680fa83a cx=c_pps
 a=2TzYObwzRp/N0knVItohZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=PREYPQEfyG0RzPAIYnYA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzMiBTYWx0ZWRfXy+GaEDcPQnOv
 eCaIwnfnUH52JrE3iN0sApYjerhAJYddVyhy1iu4kXxZuK1jbfalZsTeexzcOt8UiSKA6jTsdRc
 PHPHcm/BLtMV6P/iLiB2dISr2owLMmPjDme5T9+RxrtiY/BGYf0Fpzcno0dB2nJn6DmWrKTS8hk
 4waV/f1QJgd0LQ+bMYgUxrIMNuJfpdionCv/5oqWt0CTSdc9YeK444INZ0iCSc4KbNoWQebQ8T+
 GUXLxIbZDzWz9jDwzS7p1C1CFEdOxC88wVA9zzgizHjRspFu0785GZ1m669qvE0k0u9CQ8trNOG
 uaUOsZ3sjGTryV0RTbxovO4oCRyaXzbzY7+Hit9d2D/flr4XMJ0qdCOrc4NSnCC4a5NmXwGrjmz
 qwKIpqBdQ9EzAF6EM8M+QhLxKC5aHVqmhEMSU2syM3poxS12fxZY0YMutTwaIozwh3KrHv3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Mon, Apr 28, 2025 at 05:39:46PM +0200, Cédric Le Goater wrote:

> On 4/9/25 15:48, John Levon wrote:
> > Instead of requesting region information on demand with
> > VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
> > necessary for performance for vfio-user, where this call becomes a
> > message over the control socket, so is of higher overhead than the
> > traditional path.
>
> > +static void vfio_device_get_all_region_info(VFIODevice *vbasedev)
> > +{
> > +    struct vfio_region_info *info;
> > +    int i;
> > +
> > +    for (i = 0; i < vbasedev->num_regions; i++) {
> > +        vfio_device_get_region_info(vbasedev, i, &info);
> > +    }
> > +}
> > +
> 
> if the vfio_device_get_all_region_info() routine queries *all* region
> infos to fill the ->reginfo[] cache array, why do we also need the
> lazy cache filling method in vfio_device_get_region_info() ? This looks
> redundant to me. I would rather have vfio_device_get_region_info()
> operate on the cache only.

I think we briefly talked about this last time. I don't know why the cache fill
code is there; I can drop it.

regards
john

