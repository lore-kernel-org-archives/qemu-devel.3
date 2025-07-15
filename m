Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7819BC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeLG-0004xL-LA; Tue, 15 Jul 2025 08:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKX-0004he-GJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKO-0005lk-IH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:15 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7Xvtk007677;
 Tue, 15 Jul 2025 05:00:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NR
 T4=; b=PdbwKA8oyRJr8FmQ604ebycWQJE7v+MOLFiHFivZ0mYBvQ0cqqgGFWkSi
 hrSzgjph1IDMpThmsxRzg+dBCv3KBdxYMGkRWdwsikVkgHighJZdH3hyTBs1k0fd
 LOTdynMj6FeqNKIUM9yxNT76P04zPsajyCfrUkQm8MfYQQoX1higGcM0PbwDlHTA
 4ZRN24N62/j3MBB8MWzBRUZmb6RJF7nG67/qvnAmh84QNwk4puxVgUXZ8Ev9uxEt
 g6Nq9Tm/ffGV9YeT994XrRsWFxBiMfP6LYYipwb+TRUKGwcQmnwAHAWEqGVyz/gt
 tI/8CLlss6K0CnC3xcinInLxUO96A==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2102.outbound.protection.outlook.com [40.107.95.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1de8gm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYweMKxAaRJCNd91dwgNDYzixMoaljGx1vx+qRA14rDiJm4YrO7jdPZe3Cdz5Q30J53X1m1Vs9HawVIl22rNfmt71PunChAGObFhkib2PjTzX4398cVIzUU3Y7jZrvsuPH6kjWkzvcYH6ijUl/s6mQL/0tg73gnpKSLq3sym//MTOwL2EnSDwtIQk92+YOBgk1vAT1KWJIJQDyez23kXiNM44r1fiCoVUfHTj7uFrC6dUCv6aOlFnfKdfjsiaTtqPyNXGcnHkSgMfbRps5AH9HtZn/MTS5zZz4d3FFVUKH+zTePh4IP7e/iD0hpnSv4tonU6hgKh+DzIgSDQlqFwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NRT4=;
 b=F400YjzDX2HXw4lFtN7borA7t3DmiUOt/7qPk8pp3O3wYaftRsdV9ROhUdXXh3XYw7K5lOgIxA/vyF+thwiblQDZDSDdW3XO39TkuC84Wco7WI+IN1bVIf6tGs46KSDhr2xURyyG12gmkHpqRO3IS8BZyMOxjanYl7LDO+jy2Nyqye6vSrx5iFNJqkyKvcQLDzTlXuXSg9gDrzmD3ew81R6eoO1MFbuPKfYjNAHk5c8/MMCP60nZHyhYVFK0VSb7ZdKlUI0exeK9jeJ411v8V+LpVpZ5JTA/mqjFC8/0Ad5g8BEsioR+Of7TiyqR49gwoJa+hlT+XEnwkK+eXvTBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOxeSzq3Gun4Lm9jTwFVjvvSNEh+ffSlkdrt8C/NRT4=;
 b=C7jLUVPA1WD1HXxZ7njOgjKKlViugYUdn29HYlQKcaH9tjAWeILvbPX5CkFyCkhMtyj7vR2IGZ5Hhzo3dane+0TtvHLEcdWBBY1bX9y2XUgnMAt5+9A13tClql5KZ4NkcuChww5+ePFkSDrbiwLklvDr6UHRmNke7xh9kkL+KyH1wSxwXGb3xf2RdkBTxTU4tavRWaDuMBkj903J+w/Yzu+XSzeSE3QBWJRcKBzk6mGKbhzdVflTlc7euv4YxfpEgf/nGpuEZ5mMkTOxQfoGlbGFsA+VGKIMuxiPDCZ9j0FdnxE+j4tBKhwGN535vCSVLplJnTcllir57Vj1Av85RA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10710.namprd02.prod.outlook.com (2603:10b6:8:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 15 Jul
 2025 12:00:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 12:00:00 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 1/4] =?UTF-8?q?hw/vfio-user:=20add=20C=C3=A9dric=20Le?=
 =?UTF-8?q?=20Goater=20as=20a=20maintainer?=
Date: Tue, 15 Jul 2025 13:59:51 +0200
Message-ID: <20250715115954.515819-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715115954.515819-1-john.levon@nutanix.com>
References: <20250715115954.515819-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac4f314-17e9-4b81-d98c-08ddc3971fad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkJmeCt5S1ZDZ1grbGhKcEZZUDFENlg2VXprdElMbXRqOGVTSnBoM0Z3amNn?=
 =?utf-8?B?MGxHSkJiYUt2SnRPb25CSERqcEtjM0dnNnNJcXpRYlI3WFBORWpPZDJqTVgy?=
 =?utf-8?B?NEVSMERoN1dmU2c4b2hDalFLYUJHeUhwOFRjT3F1RENEa29ST2FaT09wZDJI?=
 =?utf-8?B?K3hoTkh3TEJoSG9INXk4WHdGdFQ2a3VrNVB2bXBidXZ1c3kySjlEZWpGZHBP?=
 =?utf-8?B?eXJKUUdWS0VCTlAyRkRZaGNkU1JnUG9wTTlhM2dsNC9TZ21MWFZPcTlYTEla?=
 =?utf-8?B?OGYvQWI0L09aM1kwUSt2d2FIVGI1TVg3cFU3emZSVzBUc2ZGV3c0STZhZHpN?=
 =?utf-8?B?YnNoUHVIMVByeHJMaE5qT3ZIVjcvb0V0dlE3WnUxUE5DOVFTVVNCZldJVFpM?=
 =?utf-8?B?c0ViajdmTVQvRVowV1pGbG13dU8zdWp2VW9LTUFZaUtBdGc4VTRmZXp3aXdX?=
 =?utf-8?B?VTFBWXFzM3F5ekVNM0hIRzNaM2xzS1BPQ1BYUHZIL1U5eXJWT1Znb2syeGxI?=
 =?utf-8?B?L1J6R0kwTk5ON1BQay95UWc1R3RGREo1THpiR2ZuZE1pcGtyS25CcVI4ZCsv?=
 =?utf-8?B?MUVYSXgyY2Q4YmZLZkNzeDZuUFNadlFUQk5MeUNtbHN2OUFnREZ1RHE3V2Rj?=
 =?utf-8?B?RkhKMVBGSy93S0dJWVpZYXVGelc1RnlmbDR5MXpwOWptaWNlOTk0TnFBSHRO?=
 =?utf-8?B?K1NkUFpXWkgzaDllK09RWUl1NFhxMndlc0w1MlFma3hTRU9VWXVnWEdaUmtV?=
 =?utf-8?B?dDNZTnNNUjlmQnBtSXoyRExQN1lkbGNMeVZodVJMWllaQ1RDakYwZDAzWHA0?=
 =?utf-8?B?MG1XdkxhdTFTWVFIdEhNYk5kak16bzh1TzkzK0RyOFB0bjNGbURZa1hCNXV1?=
 =?utf-8?B?ZGJlU1pscllob1NHYXlzbktjV3BWVnkydGZKSU5DenpNNU5EUmlzN1JMUXFO?=
 =?utf-8?B?YnBaQWRGeVRyRmtYdTJUb2hGbFYyamFNbG40NG1DS1BNR0tNU2dLdW1UamNt?=
 =?utf-8?B?RnB2T2IzVXR4UEQzNDRiRXljeFdzWWE4U1VqZW1aUmJoNzJjQmVCbHlGczA5?=
 =?utf-8?B?c0RVcE5yRXdKRUpGTlg1ZUhRKzEzWEVPZEdVSm96NE5TeS9VMm1idkh0cmVM?=
 =?utf-8?B?SVRUVFZqT002SWxleEpMTGJLdXh1aXozelREZHBYdW5pb3c0MW85SWx4bEw3?=
 =?utf-8?B?Q1Rqa3ZjNWlKTGtBSGZhSGE1a2NXejc4TkR6LzhqQitNRFE2ZFBmYnlvTEUz?=
 =?utf-8?B?WDdqZ0ZGOXVHaDhZNjdYZmg1OCtmUHRoV2ZMbWkvam1mc2gyd0U3REJqbVll?=
 =?utf-8?B?V3lpeUNDRW14TmFLZEZEVDV3UVdqTkRmaHZMT1RiMStycmRsT1ZIMU14elVI?=
 =?utf-8?B?Y0VzK2U4cnpIZmJGeHB0K3RibHQ5aVB4YTVtSzhmV3dOZ0RmQXIvU1JUaWU1?=
 =?utf-8?B?dG9xZ2ZIaE83RmZKQmUwRXcvMGJwTWtyZTljVm5jK1FqVzk4TjFCOTFmdmNJ?=
 =?utf-8?B?dHFiazB6WFVjR2tuWVVyRU95RkU5V1d2UnlqSTZqdVdBTG9hNjlmcGZvZU5T?=
 =?utf-8?B?czZEZmtzbThBaHRVUW5FZm9OeVB3YUdVR0lHeG5RUlhBekJha05nUFErSGhN?=
 =?utf-8?B?TFB1OWo4djVUSCtBalZnai92WjBwaGFMcDQ4SUkvSkl3S1RzbG90U0xXK3ZL?=
 =?utf-8?B?QmFiaHB6WXU4cUVNejc4UkI1TXVvUkpNV3orcDMxUjFaWGpORm5PV0Rab0Ur?=
 =?utf-8?B?cFhaNGxvNS9ub2dZRnRlVHVCaDIzL1JoSWNFSU5ud1dIdS9Ra0dIR2dleVkv?=
 =?utf-8?B?c0wzL3pTQlFDYkNEdU5MVjBNazZQeDN2RVY4dTQ5QTdZN1N2RWxJam9YVVRP?=
 =?utf-8?B?cEJ6M0g0OGpyN2hDQVArUTRpdGhoZ1hiSmgzNWt0Q0lvWVZDRS9Od3N2anI4?=
 =?utf-8?Q?IwzxHKRi9ts=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFWSklSNHNmSXNTVXRTMFlFTkFWOUU2dTR0QUoxaGdmVE12SDJTUDVUV0p2?=
 =?utf-8?B?V1R5ZzFMYWxrRThSbVRtWnp6dng1cVFuWkpyWXV4YS9KdWN1U0VJWW5WNnRu?=
 =?utf-8?B?K3dGZ1ZBYzN3QXV3K0sxSjRVZnMxQkpFSm5MNlZZemJDeDRqSUx5b3ZGYTk1?=
 =?utf-8?B?bERSWlpqdEJKczdmaU51ejE4a3VwaFFKYThMbXBSN3U1Y1Yyd1dkNjNBRWVw?=
 =?utf-8?B?Q0tTbnpKUVdpWEVQNkdhRnVvYkNJbUI3VWNGSjlBQ2ZPYTNCWmNjb0dWTXVm?=
 =?utf-8?B?NkgzREpCUy9iTCtLSVFPT1NROVhJd0dXNkl5cXRKVzRUZnpYd0hPakhJMjJK?=
 =?utf-8?B?OWVRcFU5KysvT1diQzdIRHhrUHkyT2F5R3FUL05yNks3bW1LSSt5YzJROVE1?=
 =?utf-8?B?WmxkV0FURXgyV3NjQ2lTOHdoZER6UFFLeW4zV3pEN290WWhXVDB3ZDN3b2xn?=
 =?utf-8?B?RE95cUpmZW4zUlRhQURVRE1Eam5kMTJvTVN4TU80NjdIdGhiTWRzcTBPVUFs?=
 =?utf-8?B?QVVlaDFhZUF3QXdYKzgwOTVVMFNZUmk0b2NYYXV2RVVJanpjUTcySm9VYklD?=
 =?utf-8?B?MnhMVm9LTnVOaUZ5WTdNMEVISk95ZlVmOVFaVzZIcmorV3FTZU13UERMRitM?=
 =?utf-8?B?VmZ4V0lmdnBwN2JoRHI0ZjlZb0d6MWhUaDJoc1NydVEzTjU4aVVDUCs0eXNV?=
 =?utf-8?B?elhhOGFoZkpEVDNGZ3o4WFJIeUpaUUZzUjltOFB6YVAzZmloVXlQOUtFaGY0?=
 =?utf-8?B?bFNNcWhsL2hjRUt3M2x3SXkrQ2JBR2NVRHVqdFFCZlpQMFVnVWFiVGxkc3I3?=
 =?utf-8?B?cC9JQ2xBSHp5Y1dWd3RVQnhGZXdadjBDalNKWmkwOFFJY2NEejhGWmZrVFNK?=
 =?utf-8?B?RmdTcXJnV2JqVk9UTkRNaUVhZmVlRFFSSnQrdm1vaHlZNXo0azJ1ZlRTeVg3?=
 =?utf-8?B?RWdhcHpWN1VuamxFSndBRit6bG1uckdKdWN1OVBpbEs3ZVBHKzlkS290NW9W?=
 =?utf-8?B?WjZnYkRVdHVaUjRiTUlpOFF4bmJ3VnhNZEN2SDFsU3NjZkQ3TTdKWnNFVDQ5?=
 =?utf-8?B?OVRHaVUxT1dpMVJIa0JNWWNIY2JSUi9BQ0VybVNPV1Y3eVFnQVFJMld1NzM2?=
 =?utf-8?B?QlVWek1iN00yL1Z4Y2ZmcWN6ZTBFV2NGUFg0Sm5FeDIvMzNtczVnTHlMYzBa?=
 =?utf-8?B?YTd0WGw3Z0VDQlZwckgvSmFrU1RNT0FwV3N0bDlGcmQyendIMUF6b21CcExt?=
 =?utf-8?B?bUpWU21ucTRGaDZDY1BtT0dnVDhQRFAyQ3FCVHBlcDhySmNBeHVMQ2dIL3Jw?=
 =?utf-8?B?SHZYZzFMN3Z1NFg2RkUvRjExSytrek11QkRkUUN1NEsyK05yRnJtRFRwd3Ni?=
 =?utf-8?B?ZVJQUU5xcUNhTVJyVHpHMUlCdGo5a3hnYUt3eUlWMlFPWUpJQXFnRGNXTlg1?=
 =?utf-8?B?ZERUQXVYbGxsMzlqZ3VRM05iZXorUWtJVy85eHAwaUtPU3d2MG5EdXUyZ3Nv?=
 =?utf-8?B?a1V2UkdQcERhZERTTDZKamtJdFJvSjFLK0Y5d2lyMCs0Wnc2UFhlTTV6SDJk?=
 =?utf-8?B?Ym9hZ2EzM3lLc3N0amQ0eG1FdU9PTWthS1h4RnhieXkwU1IvL0FOY3M1YlNy?=
 =?utf-8?B?RzlDUTBGM2NWempiQTgyazEvYis4S0thSXhTcWVsdTVDWlhPZWxHMEZRc2w3?=
 =?utf-8?B?ZFFtZTgvOUt6U2VtYjhoS2dpVWdaYjhFT1FFd3VGMUUwVVB6a2xkVW1Rb3BK?=
 =?utf-8?B?c2FsdElGbmh1aXp2a0V0aFl2MzVsajM3dmRycWc4aGt6Z0lkVDRlNEF3eVBm?=
 =?utf-8?B?OGt4bG9OalRLek9uVEMydG9ramZmL3FYNVRhOG9ka0laN3ZIbW1zSGR2aXNw?=
 =?utf-8?B?WDgxVi82VVdXRmhvK0JVL1ZvZDFoSWMzc1RCQWNxaFVHeEZTTlhvWUpPVmtM?=
 =?utf-8?B?Y0E2TTUwOTB6dDREMHY3VVd6ZXJESUx0bGdLMnZXd0Q3WXBMUnBSMUtmZUoy?=
 =?utf-8?B?cTRYdUM0cGJIbmU1WVZ0YjNwYkJnTkp6d3ZoTDhxQVhkRE40aHU5bnp6bzB4?=
 =?utf-8?B?WVhRS3paeFQyWGUrbVpnT2VkbGVtVjBBbjV0Qm5qU0N0Tnpjbm96eUVvZ1BY?=
 =?utf-8?B?RCswMXBXTGZiR2U5dTN4Y1Z2UlhoQmx0U3cyaEtZWm1DK2RaL2lBYWJrdWIz?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4f314-17e9-4b81-d98c-08ddc3971fad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:59:59.8991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqJbiFTza1j2kQgmIz8/WDCHUwAmwPu2Ks7pO+6es6NHrq2ACnSMKoM2ky4jgbXmdRJKSrVZ+uRyIznskpBRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10710
X-Proofpoint-GUID: PKSwCeQLtJngaUtsMHCY7YHxF0c4F7uQ
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=687642c2 cx=c_pps
 a=/q+MpTbIxiH/H22goC6+3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=RKmUxaklDYudIDoUp4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwOSBTYWx0ZWRfX/z6e5fDiJ1qg
 p9DgyfZh5zFJ50hduAeZQYZo7eOcqi+AkE2iyApY5gxlf5E8cc6XozzJhWu8s1RaGWSnoJvaesM
 MwGRWvS0DT2cE+1JoIpfgGmA9KAG0Mc5CKmKDGeN7HZDpdd8XmNyqkw3v7pvhTKEgYWCnL+xZcs
 buChuBO+2uTcrYBFkh9rqtzUfo/JPxcKK8wKJHZVNZU75t/ac64/FvAHudWV/nmLEd86EkhgrjU
 TQP0EL/34uUrtVyoaob53ugqzNZvyr9RWRcXi+3z+gEOZJySDyY+9R+IGWU/SdB8NZe+GoaEGCJ
 zeLlv7shb3ilmPJSNfnURcxAIGHzJLrcT2N4sj68Lz8nTt/n1eOjkPK4oFh+hiGr53bHLid9hG8
 x5NqJEMS595EDmGizbI8HKmbKdAqRoN1EUMBlQ211oGOaEyllaoc+teOTJu2a4BK7zAmPDdI
X-Proofpoint-ORIG-GUID: PKSwCeQLtJngaUtsMHCY7YHxF0c4F7uQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


