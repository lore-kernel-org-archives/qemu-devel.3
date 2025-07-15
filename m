Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1258AC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbP-0004Sf-7z; Tue, 15 Jul 2025 01:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbJ-0004ND-0a
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbD-0005is-6H
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:10 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELHIpD026861;
 Mon, 14 Jul 2025 22:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NR
 T4=; b=TcOasXjKVnh5JoRwWeZiwebEzH2wpLqZjn6wY+RQcEIAVHqaIrZo+aECY
 8ucCZoky052WoEPdHPN8hNOZkn/XchuueTOw0trIKzbZXquX6oz+aCwOwGze/86M
 e6nE7CGpOjB4MxE1PggZelMEK3M9CYMvc7TMdLP+pwKfKtLlUKd3S/8vsxO6yLWP
 8fVpxRlOLPBEGOmzMHteYRbRf0pBHHXbfFZYBNAW/z2kWLns3bbAcbH1qj/DyRf4
 ytn3t8aApXk4Z2f8XrtyqaRYVUOY9SinRDYqXwYRRNCdpxiLq5otavXfAPk5r+AD
 HEJ4rlXtopSiqyyNxqjyLKXgeFZ9w==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81d9qh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0FKCu7PezClnR0ESC/rGFn6bNzUIfqRnsU1EJG3UxKB82s8spjtPGz8ssHK1lF87+LCT7drwzuRzaUluNR4VTcq3mD8XeEe9+k35tsMBjxy6uyT7sA+GA9sIIrouGIskeDs/ttsxdLWdbEEbPdB2J/CkUA14GpEIPbLjZwuROKUtOk7SE5XXgbN9uYZsNJwQYKQsKKKtIjltxuA36AXggDJNGD33k2jkwQfT6FgoES8h3s45nMDchoGNdis2FmPWaEzThVNg2UU5rIv3fUM7YFQ/oSMRz/50lMgGS0B0SnSXhnr+coMoS3i5PDQ3QbkuZkKjOG/M6E4v3sBkHc8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NRT4=;
 b=l8VSkZ0tc1GI+n4z1jbmHLYySmKE58+9EmS23V3mIPY5VHyX3oR9x6wdhVC4ie/W4nh79rR3grG8Ow0hpSHseFibn/4oF7pctyhYEatnZI86RVX+JnzHvoHYmTE6sTGUGimhyjPmxu2xXsLvT2w7u9cbQ4/hQxiFdZyg01P9mGQ26nsW2YYJ0D/Z7ykTOs2j6YX2VrbVt4tknFR1xN8wThjjW5cGlJU+ARJOOTkSaNSySyKC6L9UxsBB6eGMgu9AGPN0iRKDtmiJYYZbQR7tVsxu2dJtnjAdIabCUW515OKnPd8HtNFjXeorM88cE8yeFMw+34MwTmiHWyhjQdOq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NRT4=;
 b=JpymwaZ4x9soFPATzSUzql1s+9jvTjNg2bXfxt+ItMUMFhTqEoWx8spb9gJ7CYzdQ06YXMMBhRiyEcWWb0cL2CT52iK4ojbz6hw1BbIAXJDbQm+kZC87SK1KluhBtg14pPK9gHnnQDrFrQjJosG0Na/by97O0Gx6RBajk6BEoKz+b0MFtjNw90wcGCI0/JtLy56ciOaSt4atWQprxz4fY7hMB+5jGJI4TrFTT6WoskJI53gAfUJK4kbwaj5HsxB8cEsfeA1XXRVOEManJ9BsfnpdYaFlm5ElZvuYfkYneoCYAvxZyMA4atVKfdQuqvMKcOKtaU601Gl4kAypJVTzmA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8841.namprd02.prod.outlook.com (2603:10b6:510:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:52:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:52:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 1/4] =?UTF-8?q?hw/vfio-user:=20add=20C=C3=A9dric=20Le?=
 =?UTF-8?q?=20Goater=20as=20a=20maintainer?=
Date: Tue, 15 Jul 2025 07:52:43 +0200
Message-ID: <20250715055246.422834-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715055246.422834-1-john.levon@nutanix.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: d69534fd-9de8-4773-c8ba-08ddc363da22
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkExckp2THVxOTVCMEt1Z3ZLb3RDOE9ZMHVYUkY2V1lXTktKYXZqR2hELzN2?=
 =?utf-8?B?dzRuVkZIR0h3TEt4aGlTMS9lazIzeXNBSTZHU3pOcmhrUGN6K0xlM040T1V6?=
 =?utf-8?B?bHlsekRkYzMvSVJmR1ZDK3FUL1ZZY2dQOHBzbm93dVRvTmxwZ01MM0cxYmNi?=
 =?utf-8?B?SFVtL2s0bUIwNVhESGNYNDlmOHg2bnpBQ1NEY2FZeC9lTFpKOXR4enZrb0pr?=
 =?utf-8?B?SnN2ajNvMlo1QVZDb2dpT0JOb3M3Qm93dlRzUnp3aUtseUQ1K0hMdytNVzVr?=
 =?utf-8?B?OGlUOGVkYWRnMXF6V2ZKRkkwUnJNYWkvOUlVaGxtbU9xRkdKcXFOR05jdFJ5?=
 =?utf-8?B?cDJ1eW9ucFQ3T1o3K0dyajNKc2lQbVU4UzFDK1cyNmV6aS9sNnlBTCs0QmFo?=
 =?utf-8?B?RVU1RWl5Q3RtUkIvK1crbEQ2RHo0QysxRFVBby9NeHBwbzNMbTVkUFdxSlJF?=
 =?utf-8?B?R1hhQUI0M0ZYMmRXWnRjOUU3WDhFK1NCc0tPMisrZ3RmenJ2NHg3SzB1Z0dl?=
 =?utf-8?B?eThkOFlPV0lsN2dhVk9vdE5HTEg0ZFlBRG84bUN2ZE9kaXdaNzZzZUU3SjNj?=
 =?utf-8?B?TVoxSjhSdHJ2dklPSFJGY1RIcUhweFdNTGpDVC9JSnFYcHU5OVQ2MzlGNDgz?=
 =?utf-8?B?L01sUndQUGVSRGRIMDZhVVd6NTFPdVFGVFhMazREeW54a0FLbndlTDAyZldm?=
 =?utf-8?B?dHUycDlGZTJmMEpFMHd4R2hNWVYwa051WXRXNTZJbzQyQTZsSVBUSjRERGxp?=
 =?utf-8?B?MTR2SnVXdnZ6M0c2bDdTMHZ4NkU2Mjc2NGpQNkEzL1RZTVFjSjg2Tnp3a2Vx?=
 =?utf-8?B?cGRRUk41V1lob0VwdERjMUpaVXI1NlpoZUk2bU91Qm94a1gxZ1g3M2tRTFVE?=
 =?utf-8?B?alRGcXRoVGphYStsSGxGYXJWZmIrZGRLL1N2REo4Z2VNSVk3RWU3ZGx0b2xU?=
 =?utf-8?B?MUVrUk92cCsxUmxhbWt6NHp6R0FOSDhnbzZpZ1VKSVBPZzRPS1lxOWRHZUlj?=
 =?utf-8?B?d0t2R2JWd0hVTS9GZ3k0eEFQaTI4NHdUd2dOb2lySEpRNTQ5ZGxxY0xTTGg3?=
 =?utf-8?B?VStCaTFjVlJXRGYwcy9GNmU4UkxyZzRZUU54aFFJTTJrRjl0eVE3OW05b3BI?=
 =?utf-8?B?SHgyUTFZS2JkWGFNNTBFVExXeWs4bUp1bHBLcnV2NjV4YTdPbmVTdDREZEtM?=
 =?utf-8?B?MW1DVG5zbWg2REZPQkF6TzZ3NWk1akx2RTA1WFgrMUNSQ1ZJdWdSdkp4SXU1?=
 =?utf-8?B?MGxkamRGd0tYYmtUck9ocU83QTd0R2FIMDBBVXUrV0tmaE83RmFLbHdCNmxI?=
 =?utf-8?B?bFBneHBXbTBmWUU3d2xKT3lhU3lNTlovdWRBN2FDNzJaRzdsaWgwVFFQZTdO?=
 =?utf-8?B?eGU3ZGFwU0JLa243WXNlS1JvVmNiQ3B3MFlRZXRLSURuRmFxTEJYa096Z2tM?=
 =?utf-8?B?UVFiRkRUTDZhbmVRMzlYRHNCTFpMY2VNSml1R0haT085S1NGWEdsemdKcHZY?=
 =?utf-8?B?UWJEcnFCMmJRQytQb0VnR2dmOVA2d2YyblRTR3ZpTStNckQ3VmZZNUY0MkNB?=
 =?utf-8?B?QndsVG1wcFl0Zy85YUpQbng1cXBEc3V0d2JqdUFyOXM1WndVU3U5djY4NnV6?=
 =?utf-8?B?VVo3clZzblp1N0Y1VzJyUVAvcVNQellNUnZvSkJwTktkR3JydVBXandFZHor?=
 =?utf-8?B?MzZZdWcrcnoxcVdENzVpcXJEQlhwYUpVYnp0Smg1ei9mdTd3UVpJRm9YUmJW?=
 =?utf-8?B?bkJTVnhBaEdKbEQvZ1cvOTF3MThxcnFZYVQ5MG4vZFh5UXo5b2VEeFFjRkRH?=
 =?utf-8?B?Z0xmSFM5cHJzZk5MZ2gwRkJTaTQ2S1haT1ZXTnFTK3ljdjhwYlhZbjZwUndD?=
 =?utf-8?B?Yk1kTjAzM1dwbnBQR2ZzSDRvblNWdVFaWXIxREQ5ZU5LNjdNY05Ca0ZPL1hG?=
 =?utf-8?Q?Sh78KCYmPp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pld2oyQjBuLzluVFBDclFMZ0xlOEdQYXFLbld6OE1OMitXNmhIL1RpdFBu?=
 =?utf-8?B?RkR1SXVTNkllbkJVNktkNk4wZEw2K05vUTlwS3BMZEtrVDh4MUhWR29Mb3o4?=
 =?utf-8?B?eU1Walc3b0VOeFl0WjZnWDV3cHFLbTFWRWk2aUJPQ3RYTkx6ZUFjYXBhcUZp?=
 =?utf-8?B?aFJNVlJ4YzcxeGF0TWI0bnlkMlFQZ1FrVlQ3N2FsM1ZJbFBldk1sMGk3TWRD?=
 =?utf-8?B?YTNQaUYxVlF4YkxtaE80ZmxBOUVJQmlsL2Z0N0U0eGRWeGZ0aDlNSTdhRThS?=
 =?utf-8?B?c0s1ZEo0NjFwNmpsemxSODFrcjMvSXozc2M5VUJTd3hJdnZqeE1sa1gwUVl3?=
 =?utf-8?B?S3NRK2xEVFlPRzB2S2dEeWdHOXdocy9PVjZrSkpuUzZGdm15ZXhZWjlGRGRa?=
 =?utf-8?B?TjRTTWxwczBuU2creFhsZEIxNFFWcy9vMDF0Z3R4aVI4MkJxbDEyV1hqeDl2?=
 =?utf-8?B?eUpvekt1Wmw1MkpCRFJ6dUZhNmhGeUwwZE5DcEc3MEVWTkZnYU1rOHVJYmUy?=
 =?utf-8?B?MkRIM2xIRmQyaHJrMFZWQktaMGd4Nm9XbzllNE1kM2ZvTm11M0twUUlqZTgz?=
 =?utf-8?B?L0J5NkdPYjFVcVZ4N3pLNFEvRzRzaURIVTdyVzczZVU4UWxJUmd6UzVJeUVp?=
 =?utf-8?B?VkZ3WWNERmVCRVNXV2xFeHpBNTRyUXE1eU02Qld1ZGtzQVVmd1pvNXY1am9B?=
 =?utf-8?B?TE9QS0x5MXZuaDhONWVtdGVQY0Rqd2NZQ2ZlUkNSWEJyL3VuYlIwL25kY0dv?=
 =?utf-8?B?VG5vam0vaGEwWmxmbnlpSERDbWY0TElqTklzWnQxVGNrcEhYRXlnQXYrMldz?=
 =?utf-8?B?M2hHajYxcHZVR0ZOMysxeUQySkZEWWlGYVlPaStLOWNlbW8vOVZId3huZHdY?=
 =?utf-8?B?OHp6eE10OE11bEJtZUlmMXV1QWt0cWFOM1ZrZm1wUjlMTFRyeHgySldNbGQv?=
 =?utf-8?B?akxyVVRPeGFrUlpaS0hXb1B0VG9Ya1UwTDFYK1FyRkxneWdHUEJYWlVtK2k1?=
 =?utf-8?B?UjNyUXRkT0RkQTRqdmJaTzlFUnJBL21ySFR4R1U3cXUvYU1qVFVkOGp2N2Rs?=
 =?utf-8?B?LzFBOG9nS2ZrOEF4dkpPV09HSy9OY2p6MTJJNXZidzdYcExNVzUzUUQzb2RU?=
 =?utf-8?B?Z3RlcTRWSThQK0p5dlRLd3pmUG4zdG9VUjhtWmJlaU9BTDBUZlFIcjhWRG5U?=
 =?utf-8?B?MXJnT2g2cWFVd3hjcm9yRnVPR200Q1ljYklNNm9HanA0L3FQeVhBMHlULzNO?=
 =?utf-8?B?YmpaSXJyK3BnNENvMmJJUDNNQ3N5VHBRQkJHUDF0dFNqUkpWVnh6SUVzM3Ja?=
 =?utf-8?B?T3ArS0doZUFtSVNNNERTem1iK0xZMmdTRGZ3SUxxbzBRdC96Wm9ZbUpjNUMw?=
 =?utf-8?B?bWIzbEluYkZPY2k3TUU1RWJlRWNiT1owYjdvbnh1SGR0L1FXUTAwbjRmbXJX?=
 =?utf-8?B?Z2t6NWJCdUxjRlU3M2hSRGtDWW4rOWk4dUxnRk9uWEhkZnlhTU9ubGI4R20y?=
 =?utf-8?B?aGljakJYd2pDT3hoZnkyVUp1cGRKdjAwRERSNitSZUNxaFlWbllGemlxSDZS?=
 =?utf-8?B?Q2FYYm9Gb1lKcDhWajR4TzZ2Qi81cW1paHc4cEZVTU4xKzJ0TkJsVXU5NlRh?=
 =?utf-8?B?aThqTXhFNnpFQk51NjlvOUZ5S0xFNWpMR1hHWjA1T3hzdGJLOEJ1MTgrcEIv?=
 =?utf-8?B?NDkzK0p0SVZhOFF2bll6TktVZjR3VXhWTCtHT0wwV01Qbys0ZTBKdUE5SU1j?=
 =?utf-8?B?QzNpQWFtbkRCdzNRNjVGZ0pYUXJiQ2dud1JTWk9JMmRrVnllUS8vUDJsOFVj?=
 =?utf-8?B?NU5BMitqQytYUWhFYzlJZW5Yd0RMR0c0ZWcyUE56L0pZMDlhVTM1VXN2NGZi?=
 =?utf-8?B?T1VQYWxTb2ZNYjBQTVRwcHZYclUwRmllZWRDK2M0clJSL21yQ2tpZHpld2ZS?=
 =?utf-8?B?Vy9KZG5TTVF5RnU3VUQrNzhwL1lCK2pNbEpLRkZGSTdFK1BoQVFvSnJJbEJW?=
 =?utf-8?B?dHVZTXM3bi9FbFpqbUFCZytLMmdlbDNDL1NvbEZtVU1qS3Eva1liRkU4VjRZ?=
 =?utf-8?B?WHl0ZDRnc3kwREp0ZU5TVFp5Q2w0bTJZUlRHYUFudnNaL0ZxbE1Mb054bzR6?=
 =?utf-8?B?enhuMCtNUkd2K3gzaFE0SDNrL042bTBES2JPaDJadjBVNC8wZGZwS0l3TTlM?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69534fd-9de8-4773-c8ba-08ddc363da22
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:52:58.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzAyKawt5pGgq5JyhOuxQYUElsJ7s6bI4Wb4uv8slopP+gk0uM3cUnzFib0ul9nUdhTCRSH7RZZysFDroe6zMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8841
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=6875ecbe cx=c_pps
 a=+jfnsvNtYUVjUhI0lc2tVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=RKmUxaklDYudIDoUp4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RXs7e-DhtbdyPIj881NPCzslKcjlKkXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MiBTYWx0ZWRfX7x6b16DQV/NV
 MCNkyfxSgP8068X+8LjBo/4vWEFx+Axlgu5LHZA56jHfBsks/mXir+2mLuojYr6sRhxPViq3KX2
 EUB2CYfn+SKgF69i/ciBWbjRg6Lk6IZJQjQy59j4IspJr7nk/enMzYv5hL3UJk9/iVjqrR6AkfN
 mkqEgZ48/Bvdw8gF/Ex8ZQDxhhVGBoXvP1dqZLhkfnmX+ZjVTfnwxfrLapQLpySdUNh/r08GIgX
 FoOhbPe49HSCyR4LCuMjivYtVlXUS0Vs1SfrbuTRlOAZMf3QoKmyg8xwAvwj7MmbtLaxf7Rt6Oe
 mSwauxEC6AhtMaKQaI/d6938URhipUvLQeVE7Z0SLBrjuEfrgVd3fhtvgNE5+eoYU/EcDn2uWIp
 rp9keb0C34QrsugbBTKKLt22soqtUzQtYuAcQvwk5hbCPIlp3I/H8LqP8gbGUpFrS13kPmm7
X-Proofpoint-GUID: RXs7e-DhtbdyPIj881NPCzslKcjlKkXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
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

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e88ed2c0a9..30e9b71e6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4287,6 +4287,7 @@ F: tests/functional/test_multiprocess.py
 VFIO-USER:
 M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
+M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: docs/interop/vfio-user.rst
 F: docs/system/devices/vfio-user.rst
-- 
2.43.0


