Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C835DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2H-0007lD-Ad; Thu, 10 Jul 2025 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn25-0007eV-3y
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn22-0003WS-LD
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:32 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569LQdSl015992;
 Thu, 10 Jul 2025 01:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iYVyxYoqfiGHDpRqWkyZluW/ryAIrbcmTgm9J+vvF
 qI=; b=RB9VOTm6SprJkLoLYYBmURC5TYx6a+5Ko2uXnWLE5ApD8k3boe6qneegK
 WrQr5rb9POyMJowtkRSwx8oyqwT6JXWov7s36lXdRriyR918BTR61z900+3Z/F3O
 Q1+kbF0wQ3Sf/xzB6N727l9bWZ64h6A1w+b2Dm71lSjpQyWJcfLO/qT8mEpveAwb
 8R/3UghPVPrYAydfRJTQKD461ksHg1U7sm44wGegrCNQvgW9yYHFnFb6hU30R8f6
 CraZHzG8DlVwhZSn9iukvvKZBitxoqC22VIT6zOBuvXmblwlvpX/rhIygULPpMFa
 rKM/wShoEZXQSEcaWYFX9L8lGRsWg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn27y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT+j8E3tivoAum6aMahnjCPzxUa1mePpptVEwpwM8Br0houbCw7kOW3Ge8vdmBTni2HfINtRrdJcGsP1Pm1UonALvJusD+KCAlWOiwdJZr+VNiH4V2NHenYIeaj14Xq8/PO77dpIIhH8dWF3x9Nwn25caOBZcoLr0dFuyAX+hqByBokvytzK+QHPl9CdEeGt47Lq/wgZVunweJ0uld0BV5hhrsjPpuWrj5NehpM5lZAR6ECZKwewmGyqtUcYcruHMVTbZJ2vGtCdR9X4opKYR77qIgymTVFmElQLg1IGfmpIIErVEwOYpRZC/9bMzhsKWNrLZWMmwJ4VlhR/xl04ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYVyxYoqfiGHDpRqWkyZluW/ryAIrbcmTgm9J+vvFqI=;
 b=k2DyM93FjVgrA9MlUEYivY8He9fxeXM64ZVgIhW3Rrdz+J4jLxmvxz+vQHW7njF9Q9eWc/e/RdSEHxpHO3phT6nZzOu0SQhs6qd/0wpZy+2rfgCeVCcFhEGP1ufGUqiEmOHuyl146ODwQl9pHQaG4KGymGQE3+zVZxe4qBhd/wc0wwt5hYVhm3ODDhxy78DFwP9ybQgPEel4JCJbZ/gSuvmXfNoappL4MI7MoGrt5NnErVJvonPTqtO02S0NPtpXkQKcxgK/OGjinQUn9GeBSihu0nYMB7YIiz+wWxboUdbJ2gWCH6HSzWlsWvQ56zShyMnMCdQRXIOmdWpvH4V0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYVyxYoqfiGHDpRqWkyZluW/ryAIrbcmTgm9J+vvFqI=;
 b=sESEwpNNSZUyNCGR31SzMSR/+i4auRbHfFKFB9UwFKQ31INrRHsIZVoSyeREFbua8pmoqFhBQTTQqMY2Sm9u0Y/sbAoIgNtvsNT74Jyq/1nBOgaYLBkArFPlwU71WOPs9a9KRgZX7HHuUczM7d1ryO4R0bO6RRC5jqi2UZEWE3u3SM9k7bXDerlQVrcO5k703QA6zxFfpPy5KYxWWshEamy2tNM0tc5jMN7aR9SxPFDpPz3HO42PMQ5vheUtnIPVHwN48sU61xtvtVKpyMEPR8mvkewtoey8jv8T8KpDZfmKNRVPQEj+XixibQTvC9zpGlNmhInbS5yFh5ie18baXg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 03/18] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Thu, 10 Jul 2025 09:52:18 +0100
Message-ID: <20250710085308.420774-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: da831c93-d36f-4912-d852-08ddbf8f3a85
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y25wNHYyaXdRZExaeXR3azhYbmRVRnh3d2poaitPdkNVcmYxTzhWN29KRHpO?=
 =?utf-8?B?S3FtVUZ5MmVYTU5iQ3RPWHRJMkgxeEFIdnNqVTdvbFphb0dMZlVmQkVBNkRh?=
 =?utf-8?B?V0pGZjJSOHpZMTlBVHRxME5HM0oyeUtqNlRIcGJCV203YnN4VVBMTGhuVlFB?=
 =?utf-8?B?K3Q4WGczbk5SNyt5a1dMRUdJSERBKzdMNkl1OVlTMG5SUERUKzRvTG1Jc1ha?=
 =?utf-8?B?OHNCSmh2aHE5YW1GOUZ0ZU5LZ2FuLzNvbzN3WnBYYXk1MmRMaHdzblhDbWZm?=
 =?utf-8?B?L3l5QkIvSjBsOFpkZkZrdU0yMkdjdzVKTkpxYU1wZFEyUkNwUS90Nm1hbStX?=
 =?utf-8?B?L3duMWcrOGc5SURZUEN6U1A3SjVpVW44Q1pBZkM3NkJPK1hkNkk3YTVpMS9R?=
 =?utf-8?B?dlN0cW8vZStXL2ZlWGZ2MGdxYzBMdDhwcUNxMm9VdWFraHZYbHZzaFl5RFdm?=
 =?utf-8?B?anZoakIvUGsxOXdkMG5FYlM2UnA0QStrUnRtM1BmdTdFUTliRVk1RTdEa3cz?=
 =?utf-8?B?T2NrN240VTMyODQ1QmFIVHQxdUkzSjRkbHVaUHg1dXgzaGZsM3NManhiNUlQ?=
 =?utf-8?B?VTFtdXZGQnpDeWtmOExBU0x3cmZ4ZjJnemRqQnJiWE1VREV3MmdCdWFJZmN4?=
 =?utf-8?B?aXgzWXdQOXNkL3JmcDFSWjFBcjVWUytOVmdkWEZKV2VlRDJVbzRrZksxUStr?=
 =?utf-8?B?ZFRGd2pJQzVWczBSWGNNOThtRWc2anRPa29PaDMwbm5RbFdta1JTSnZLRDNl?=
 =?utf-8?B?NnQ4aVJUQjdVTzRBek1iYzZYL3RhbWw0azRpaGwvVjVtb0RNOTZoblNObUV5?=
 =?utf-8?B?cTZiWHpHczUwMEZHMU9PL3BvZzFic1FZQ2c1MXJwQW0zRDNwSTBkQ3ZHUkpq?=
 =?utf-8?B?TjZFbndIY2ovamo5alIwRHZJaTcwclloV0NPL0ZtcmdwMDJzTk9JVUJqdWl1?=
 =?utf-8?B?ampwUk9ESndBdHNYRzJGTUlpRGcybHJ0c2JSSERCTW95alA4MnZaQjlydFNI?=
 =?utf-8?B?OEtYOTZKdDZOTVNIRkF4cTR0NmNYVG5nNk9RYlAvQkNJdmd4YzFReUo4MjA3?=
 =?utf-8?B?SUxSZnFxbVhBYmxhdUp0Q0xDWWxDZW5LZzYxMDJZeWpKMzRNNlo0QjNtemNS?=
 =?utf-8?B?WEpjU1FZa1lzUUMxRlV3RFZuenpnZllDU0gwY2IzZllFbVlpc3p3YXk1UklG?=
 =?utf-8?B?WU50V2IvV3Bod0MwczNpWUZNN2VJLzJTZjI4cXpBa3hOZVF2Z2VhYVcrZklj?=
 =?utf-8?B?S1VNY1N1MVY3RCtxcWc2WXNFSW5mWTBzVkNnckh2ejduMW43MmpPTU9INUtQ?=
 =?utf-8?B?THN2eXo5RkNSUTBPVkR5M1RYeWxwQVJKUklnWjF3em9QMm9kNi85Ym16VURi?=
 =?utf-8?B?aXIrbWc1Z2xsOTJXMFVnK3l0R1VyNFAvSkYrU3hUdkdoUDd2eTBRQjFlWkRC?=
 =?utf-8?B?VGJrTnN5TlZ3SElEdVJpazgzR0ZHMGFuMXVUdWpRa3ZRdmY5NGFwdEp2ckox?=
 =?utf-8?B?QkNZRURNYUVpOU1Hb2tVeXFndzYvYmZ6VUpoR2NqRlhaRktOWDhsckNITWg4?=
 =?utf-8?B?K2VyZ0V5c1Z0MTgwNGgvWXB5RnlkSmdkSTJwQ0M0YWlYUE5CR0phQW5peXVJ?=
 =?utf-8?B?VnV5YThCK3lRMC9aUS91eVRPRkRYQ0M0YUM3VmdPSUdvQXNiWW54Vmk2VWVT?=
 =?utf-8?B?OGZBNk1wNGFRb3lVcmhRNkdMampxWmdJY1JQR3BEY3JzMDBPTnFvZkZ4SzJB?=
 =?utf-8?B?UUo4M3Y2UmJHc21nSnd6dWVKQW1NYVpMblR2YUJ3dG5uaWJXL1daWFppVUdn?=
 =?utf-8?B?VHdGNVFoV2VxYUJIM3JMWkg2VjB2MnUrenp4bjFFK0NkTm5VWkcyVDNrdHpu?=
 =?utf-8?B?SnZoNW9XZFBzbi9Fd3FqMy9KTTJ4ZHF6cC9yQ0o5SGwvM2MydHpXRVYxc2Nv?=
 =?utf-8?Q?okcRh4+mPVI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5IcThPeVQwQ1dGTmxoSWcvU29mdk0vWWVEbExZcFdJUytNdDVOWHNuNUtl?=
 =?utf-8?B?OURsWUV2RWRLcE1IVmVKVTAxOFVZWmRiSGtlNUw0ZVA4bjVGbGgycHIyNzRO?=
 =?utf-8?B?ZVRVU0F4dXkyTjdwdHJNVklWZitPNXMzZXlmdFBNN0hqa0FPQTN6Q3d6dTVp?=
 =?utf-8?B?K0JPczhra1EzaS9IY3BpRDNBcjVlSGt6MHcvS0pwY1BzaHFZUUlOZmlWcng3?=
 =?utf-8?B?L2lqMmNBWFZieVgwSEdpRDI5WlI1UlU0VlNpcEZjM2xtV1IrdVpZWjBXVE96?=
 =?utf-8?B?OEw1OGpmZHdJY0M1SktoOFMzc3dmeUF1UDU0TlpjOVI1M2hKREd0OGZOM012?=
 =?utf-8?B?eU1maUNJRENwcU9PUTU2ak9ITWJYd2I5R1RLaUNlYk9RQUdEczltdThtNHZU?=
 =?utf-8?B?UnFBM0tldmVBM2trTlZvT0dZcHpLeGRHZit0UUFjNVg5Qm1Wc0dRNTVPTVlP?=
 =?utf-8?B?OFlwSHd0S3ZETEQzcnE5dElES2RmdXhqMkpGRUwzZXcyMlF0MjlnM2RCcHRo?=
 =?utf-8?B?VlF0YnVYZ2xxc2xGTmRqQy90ZUpKeFRGT01KRjFkRXhkNnJ4S3FacVE5UHhz?=
 =?utf-8?B?OXVGajVodFh6cXVpUFRWZm5kaXJ2M25mdldzVFpTUXpQZUR3UGFuTmE0MDZx?=
 =?utf-8?B?R2lqcjFrdzFrNWFjbWZHNitTSE5lZTlOcXF5UjhjczJNZk5oQ203OE55R1cy?=
 =?utf-8?B?Z1AxMmkyWkVFazhoS0tIL1VQNzVaNWhkN1JtWDcwSXB6YU1lN2Y3S0tvUzNl?=
 =?utf-8?B?Z1dzbnNYaUNlLzVrN1k3MTd4OW91NXlReGIzU2syOVZyMlpCK2MyN1ppaXBj?=
 =?utf-8?B?bTdQMlF1TkhjN1BqTEJRa01TbXVMMjV4K1hybmxkL0hOTm0xTlhtRUc4Z1N5?=
 =?utf-8?B?MGdWcC9WblZ3VVEwbFhmVm9tSXpFRGpUQXZUWEMzT0NaaWFXdS8zS043TjR5?=
 =?utf-8?B?VjlCRkdYc0o4TFJiREtuUHVNcXlVZU9UZE94OXc2MG9wajBkWmFoUzhINXhz?=
 =?utf-8?B?TzdFMUNmRGs0cWhYUU1PS2JIN250NE0yQ2FyREduTU9HUUh4dG9paFNSNU8w?=
 =?utf-8?B?U3JqOG4rbThqN0Q4MVVWVGwxd2twaUlBZ056S0FnZUg2RGZ6WnFJa3NINENh?=
 =?utf-8?B?QnpjRS9obGRPakFsaDRYZ25hZmRpQ0hXZURTbC9SNnYwK2xlT3dMK0owYnIv?=
 =?utf-8?B?NTk4UW16ckNMQVlmN3dRZnQ2d0IrQUZvTitwQzhwclRCY0hqL0VOUFpnbmFs?=
 =?utf-8?B?VUp1VTY0WTBnZlFoVHBUbGlmVmdOYVU2U1FzVk44blQ4Nmt6ekxIUkI3Ykho?=
 =?utf-8?B?WnZ0RTZJaFZxVnFPSlR2cHRIVWFZc1gxNUxtNWFxUFB4ZlE5bnkvdzI1ZTZD?=
 =?utf-8?B?ZHQ1MVhRd2VSQ2cvMUx6a1lnQmFzUXAvemplM1ZvM1NFRzFGS0FhUVNuMnZD?=
 =?utf-8?B?UWRJSitXeWg0dnQwa1RVK2hlTEFCQkVvQ0FqM0VkaDd1TEo1YUd2Ky8wUFd6?=
 =?utf-8?B?U1Jqa2hoUC94bk53TXBmUnpYc0pNNmlOMjA0bENCSVlZT0JZcDk2RDNrTHpN?=
 =?utf-8?B?SnVCNVVkeHJOS1AwVlhJamJOQXoxbUp3TURLMjdJOWxsVk1TWVdyTDEzU1FR?=
 =?utf-8?B?U0RGTWlGdWpaMklaQ2ZjcHBqczdsekcxcE1YOEpwNENESlROK1lWcVB1Y0NN?=
 =?utf-8?B?UmlQUlQ3NWVITmppM2hQVG9vK0JiNVBQS05FaldYRDJKdGYyUTgzZVlUdnVD?=
 =?utf-8?B?ampVQmlOVldKZjhNNUdta3AydjVaTnVDVzAvUnZUVER5OUxRUzN5YzlmUGNu?=
 =?utf-8?B?Vkcwa3VSQlFYQktkODBjVXJWNXFTWnNGazdyeE1MWVRZYjZHNkRVcHEwVUhS?=
 =?utf-8?B?cS8zUEZJS3kveWNJVDJyOWMvQ1FldVJyYXU3ZjhJWmgwSnRNSzc5VTJ6a3hv?=
 =?utf-8?B?Q1BreFZmUWNQYlJuQk8vNTI4Z00vbjJHTEJIZlpveDFLM3hQRFdiczVIUE41?=
 =?utf-8?B?Wjk1cjluTmFWbzloUDBCckRKMVcvb0Z3a3VqMVl5ck9JTmlGZjdsd2tKMDBD?=
 =?utf-8?B?TjR2WWZmclc0azlkLy9XYjliaVRSTFFZZWZTKzZhdW1NRFNSZDFBbDU4VUFn?=
 =?utf-8?B?bHpqcDV1WnJTZ1ZjeVVZSlpKZTZWMG1lcVc3S1FXR295dWpMbkkvanFhQW82?=
 =?utf-8?B?VkJSNExVUngzY0Q2UHFtK05aR0ltWEQ5QzB1UGtzejhwZ2hydndTMld6QVpH?=
 =?utf-8?B?aVFsSVhPNWlnemJ6eVZneWZJdnVnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da831c93-d36f-4912-d852-08ddbf8f3a85
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:24.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bGoda4GXCughTDFs0jNOBcCrOoICo2wPuAlGJ5jBGZ5xod19x8wSbBR7ELaFHR833OdxRuP70+qHz2ZqM6ZGRg/QxyvRRiwx7Pf8oRH8yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-ORIG-GUID: M9ddES7DkybxJ7nOz656YpAjQzmiw8uw
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7f85 cx=c_pps
 a=b6Rudwk60yQbI76W7G6FkA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=EScErfUSVzH1iicdKiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: M9ddES7DkybxJ7nOz656YpAjQzmiw8uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX+AcQooWB/s4E
 azupsfAF9CTANiLLrO1XffLHf8C2+UryaFOSEhhieh7Z1PeRwE4iWkn+rXFkl5ITD741dIFjuTu
 vJJpHTxo1YiXTZvmCNNilCaOTVBJps/37YGRLQFtV7YFKm7sFNOokGcQMzJrj6d59zMy9GAbZjX
 QQL7BMfgZwbATBuOWQ6jAGZZt6OZo8SB7tJ3xsebO4qALwhKOFnAr2zZvZ7YHm6hXVxP7RtFTJW
 YtHCJeJRyBkG6Y7KZu3AgG/NwOrx78e07/mKLL4JiDsyZMfx84QSUuQNCavILyL4cDKU61kvx2R
 o1ATqxUwzLNsGoVOUsR+MzKw+y2N3GBgXnOxYtJrXFc1eNVO3x3THD6ADTLSPWT/a9s9zaiAyNE
 sp/hRaThgs65Uo+QBbW20x7DGH9CgJvRLKCIBTqlOD/tldhUDVyCkhjHvLfQIPrQ/e7BGjB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f66eaeb910..0928b905d5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -417,6 +417,87 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
@@ -429,7 +510,185 @@ static void pc_init_isa(MachineState *machine)
         machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
     }
 
-    pc_init1(machine, NULL);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
 }
 #endif
 
-- 
2.43.0


