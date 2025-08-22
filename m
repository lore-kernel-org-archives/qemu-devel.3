Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5707ECA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQeq-0001Z4-UH; Fri, 22 Aug 2025 08:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeb-0001WE-Mr
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:13:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeZ-0000e5-7z
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:13:57 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8BBrr703328; Fri, 22 Aug 2025 05:13:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fUXH7kZvyzaepKiFW9WCwWOQFVqPfIbSWzRnfWUyu
 Ik=; b=eILrqnquJm7iX+/h0oP2k31nkxKfA8mbipL6hbJ/qh1PqC9x/DC098QOc
 b5Pb6GmlzIO42nl/+0eRaIV+B/G/tzB8pf9i7o24UVmpYaT6U6eLabUoSSFJjqJw
 Am2Pk77YAdsj5SSe9bSG3lHUA3zAjicgeWDb3MWTqYk8G886s700pcFwGkYf2mhn
 UzIv1p22W2kt/QQoEyvDQeHx4NSJ/JtEkRpn8eWS/QP6cTXT5dlLK5nsUr69k3Uw
 7PLWhoDFX+27Y9GlhcXJmY3V6BSqcv5AJiQkTTbO8imeHIKIKh+L4V3RBiSbq5ZK
 lzQzGIzE4T2RnaAULXZFRD2C9uBhQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2124.outbound.protection.outlook.com [40.107.102.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48p6uaa6fp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsrZAjL0VmlMkpRnGogBuwJth4+banMXbekLHnwRIIFkNewMW1gZAt2GcT82uWltZWQpWUTT04Zr63ntnE58lVByXP2pQYXN8JO7XOr6KLUWTvp6u0p/Nx+wt+c/JJpZ3TmWHFQkMIm667+OctI43aZqZB9oTkA/8Yn63abALnTmoV06g8gbXJXCZ7GRXyHUbMx0CY8RsL8/aaR/FaAyRHAiu3fa/XnHBSfCB1tk0+E4uWAGc3+ndejqcN39cwnozK0nXfROZ+kNuWsX/SWqp5+LrGRqztI6SYNpUvXQdaZgfbyGuEYv5FTRsmaHANC4jqJhH+spgYarG3txXmYV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUXH7kZvyzaepKiFW9WCwWOQFVqPfIbSWzRnfWUyuIk=;
 b=AMYY5htwoJpEhQsaP8TU2puL/IN6UtPlvcKOPTWXXlKh7KFCHNVyCweZevxZqtl3qxrR4VHD/LaBku9hsmGZsj+gqpW1Q81cgOO2XnvOyGXJwVYxNjGRmFzMILypQEvPt/rZcAA4o2P8Yri+qUKeVMuIWa6ES6vEN/SUvWeROS3oKFIxnbbKKVYPQ/FoJEtuorFU/jhyBof8bG1UCIiqev2Vw3zhYn2QhT983cATGYBxGvuocZGkMZjWMS79+TcW18bbgkaJITXh6ksZxNgXG9JfXx2LO8nzXdJ44Mi0EWVqkKnJH9AFfKG9di5G64+cYjJ9sr/H4K0lumA6k0ogNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUXH7kZvyzaepKiFW9WCwWOQFVqPfIbSWzRnfWUyuIk=;
 b=XEOmCpMzHb8g9UZ3aNGCR+7jyhfOGvAHXMZi+Ia7igwyZ9tZYwEb+B53DFrOmF4NQaLO0fwAV2tgItfQRlII6Kvv+tznjXuW4uDMRuT5zOPrgpHjdaTNBV/ONwOlu7EDRmyZ0W3u1o7Vh1DH7iMlvxYn4JteLuNcORyAOb8v3Pwx+FH9JTLy1Y95yV+GYhzts8iMuiml7IsbixjgBx7FdgBjm8y/d8hITg0aTeUiPoYlsDhTk7k+4I5E2kSMkzs+g8cWNzJDOIEVG6J8Wu+Wlc6noKgSxtxU4VF2QRXTz4jhtIi1TMIVZqlysypMr2SKdfxZCNDd2VFVJ51rFF3ZaA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6505.namprd02.prod.outlook.com (2603:10b6:610:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 22 Aug
 2025 12:13:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:13:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to 32-bit
 CPUs
Date: Fri, 22 Aug 2025 13:11:47 +0100
Message-ID: <20250822121342.894223-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: eb60eee8-7aed-4509-8a02-08dde17559f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUpYL1ZCWUxWYmp6T00vRTJCemhYeFZMdzh1VXE4Q2dKelFKb1pjVDFRRVNX?=
 =?utf-8?B?andNTjhCMThnNzVPQWFISmNXU3NaNVl3SDVkSFlFTDBIQjkvQlBCNXZsanh6?=
 =?utf-8?B?MnZRSnh5dGJvdWEyRC85b2N0R2dJeEpuSEhJUFZqSU1EL0hMZk9OZTd4UWJ6?=
 =?utf-8?B?NWhYTTIvQ2NGTUQ0UEU1eDVRM0dJL01UcEgxanZ4VWZwM0pEY1I3Y01BdGF2?=
 =?utf-8?B?YXV6R2d0dWxDK2NmdlZVYVpZcnpPNTdCZHdKWmIwb2lyOWhjWXpSblhTT2tJ?=
 =?utf-8?B?QjdYUjVEM0ZQbllvOFVXVU1MMStkV0NWNEhiUEZ4SlBSdkE0T2lKVElVNkNs?=
 =?utf-8?B?cG9uajJQT0o5T1RCbkR4OWtvdHp2djJkdHNIWHJvdFJ2WFJHK1R5TVNwS3BI?=
 =?utf-8?B?WE90RVEzMW1oekdNcnJ4U1AxbnpaMEVIcExEY013em5ESEdhSExHMjJPeXJQ?=
 =?utf-8?B?SVIxQWRiU3YxWlVXajhPY1BjLy85ZTZ4eXNWTDhJZm1NSWs2dlVxbXJxbXdM?=
 =?utf-8?B?dmZZWEpwK1B5NjJOL0tqaUI1Vno0c21OdHEyUWt4K0wvT0c5cXZUWTBxMWJB?=
 =?utf-8?B?eHMyWVFPbkdXazdzMDZ2WWgvZFVHcDVTK2szdE9hTk1zTmszbzJQMEZQQ0Fn?=
 =?utf-8?B?a29FcXFrRlp4OEhhYmpac3V0dlpZaUFJZlkrQzI5ZVRQWjVPOGJvL0pwOGVr?=
 =?utf-8?B?TW00ZS81ci9vNjhpaUU0aGZwR21zMW5YTWMzd3pWNEVIaFBySHFxNnVLQUwr?=
 =?utf-8?B?ekdjVHR4ZUdkZE45L3MzR0F0V2dsbkNxczBYYkZSRGRQL1NiTFpQd3o0WnA4?=
 =?utf-8?B?TnUwcFkzeXVCaElOTDhQaFdJU055c3F6RisyNVdUOXBxOUxFVXpqSWNHSmM1?=
 =?utf-8?B?VXIvenNYYlU5OExaTlpmdE0zZTZYSWlub2hldHIwbHdSQUZNS2dsR0RtaCsy?=
 =?utf-8?B?VW00ZVg5K3V1Mm9MVGMrZzc2L3hZTFZhbXoyZnlHUnNCck1NajlPY0VBZGQz?=
 =?utf-8?B?MUZJdVQydTJ0ejZTeEN2VGVqMmF0N2diV0wyUG1vNHdYYmE2ekliUlUrK3By?=
 =?utf-8?B?bUtUNlM5aEVYVjZxSTZNajVqRUE0RE5VSysxVVZBSEo4ekhRK00wOHAraDFL?=
 =?utf-8?B?TTN3bEFZTXdvUk0zK1NkV0IvYXByUTQ4TnJscnh2K1RqV2R1dDhIYm1tL05X?=
 =?utf-8?B?ejdCdzVieFBTcFF1VHZuNHNNckJxOWdwUFVtaExGZHlaWXBEa0REYnQ0Nnd3?=
 =?utf-8?B?bk5NY1l3R0ppbS9HdHFwWWsraUxOZ1E0M0Y4dytxYUphNUhSbFRkMEpUeitE?=
 =?utf-8?B?RDNTNXpoR2Zib0ppRWRYK0laNk5BSjVtZGNoVGlLQnJ2bGxwaFo4dkJmazhP?=
 =?utf-8?B?bFVBbTJRZjZoUTZtT3RPU2hTV2VJU1ZMUFo2N2UrUUZwc3EzR1RPWjRXSUs5?=
 =?utf-8?B?c3dTblh2d0tPZGFiNkFjQUVFTGRoL3ZQbjFXczYvaDgzRHBrTm1QNnB0OWtB?=
 =?utf-8?B?TTlDR1BiZE9EQ1VkYnBSVjZPMGdpRzdReFo2N201aFg0em1Tb2p4Wi9zZG1Z?=
 =?utf-8?B?MXErMmVubkR3cVZJY0lKVGdFQXJMejhabVlIQnNiaVFDcUFLaUdMZUpab1g0?=
 =?utf-8?B?S3RwZUtXaFc1WkhqUFdFeEwwODVmdVk3QTNFaVJDUXRVZjFmUnZqYzJld25O?=
 =?utf-8?B?UHZJSlhMSXN5ekFGQitIMjlmbW8rRmVhU1FmVTVDenJVKzB3YVgwU2JVKzZY?=
 =?utf-8?B?aVZkVmJNaW10dUJCME5sRnN1Qi9KQ0NQYWdMRzJxQ1I0THRBSFhOUjhpc0ty?=
 =?utf-8?B?aTQ1N2Q3RG5SSCtGendMenFEZ05kV2FDb3lwZEFzVFh3cUJxQ3pGemZHMVB1?=
 =?utf-8?B?SzVwKzlJNWk4V1FCWkt1ZjVpdXVZMzRXUW5rZ3BCMndXTEVpdUZLa0swRnZW?=
 =?utf-8?Q?SvC6kqqV+q0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlOLzZLWC9EMHNyUCtIVG80aEUxNHN4R2xSeVlrREJzbVRmNzNPeldad0Zz?=
 =?utf-8?B?Y2lXVDdKOXdaOExscHZjYmxYRjlCVUM4a1pZY2RVYjNSSFREKzhNTTViUEdK?=
 =?utf-8?B?bGxvQ2dzRzNGdFlaaTJQRFhjYTdpK0NlUGd6RDBmMFFZVUU2WjZudk5LL3U1?=
 =?utf-8?B?VVpnWWpoOXBRbWdwTzZsYXlyRE95WEYycCtJTkN6dzlxNUl3bXVJVzdDVklF?=
 =?utf-8?B?b0w4UmZUS01NVE9pSktaeFE3MkQvenF5QjVxWE9Lb2VYVXhBWUFQQlNjekZX?=
 =?utf-8?B?UEN0YU9TamcrKzhmNEcwQmMxR1Zpb1FrdFhUSE9PcVNVQTZZTWhiZGNSNDBW?=
 =?utf-8?B?dlFGRVJzTTIzWVZSOFNLYUFxamFjUU95RkNTeHpSenN5MElQTzNVU01Nb0Jt?=
 =?utf-8?B?UTArMVlvaGVBZlhCM1hheEVYbkRndTBaWVJIWnZDcmtPbyt0SDRpdFFpR0xq?=
 =?utf-8?B?cVAreXhkV0h3VU54N1BpME56Y1ZTb1VPQnliY0k2ZnNHMnhCMGN5QmlPSnFP?=
 =?utf-8?B?K1VoSktvRkxCR1RQb2lXMXVVb2dFcGVkOWFUU0Z4WTErNndEbzZ1MWU2clli?=
 =?utf-8?B?UXhoWUp2dkR1RXZyQldaL0dpY3pQazJ3MXJybnRDRlZINzg3SG9laXhkblBi?=
 =?utf-8?B?NEwxclBZMm40QXpKVVc4ZTNXc3VvSmVYOXlwK2Z1UHQ1TFpkeE8ycXhoWVFx?=
 =?utf-8?B?U3Vtd1QyVTFsZXV2VmlaMTVKRVVxM0U1OTl4dGdaem5jZUZsMjZPZ0w5OXRV?=
 =?utf-8?B?dmxTbnRPQTc2VEtla1lMYjgwL1dEcFVVMkRKK2Y3aTY5TkR5WnhCdGxCamt1?=
 =?utf-8?B?eFNMbEd1K2hDUnYxVFJTTHRwN3VGOVQ2MEtTNW9ENWdGUVVCN3gzOE5Ka2sy?=
 =?utf-8?B?V2ttdzlxS3pZSHdNQVhicFl4SHU5b1RrOXlpd1hCcVlNNUFxdUZ4aUord0g5?=
 =?utf-8?B?cnZZL09hL2s2cWYxUVFkTjc1THpON0lsajkzb1JPMDcrSEc2N0JyYXF4SVFn?=
 =?utf-8?B?OGQ5K3lvNytuSDFGSkNudWV4ZWRVazdsT0ZQS2syVndoTVhCaW9jWlpMeWlv?=
 =?utf-8?B?VkJ3K3dudkdKQzRhZnF5MlBxQ1RyRmlxSm1xYWh6UlpCQXhYM3MrK25mRTkv?=
 =?utf-8?B?eWtGWEQ2WkkxVlFpRlpMY3dRdHVPeThaQkhmUEIyWEFEOTcvZ2JZMGxCaHRm?=
 =?utf-8?B?Yk9zeWZaRE91R2t3c3BLMksvamo2LzhzMkpxYXBhdGNhdnNTcGpCT0czRnZD?=
 =?utf-8?B?QlJwSU9LaVBDYVhuZWJaQTI1ZHB2Q3ZSQWJQSk5mVVNQU1JEbmJmYm1tamxu?=
 =?utf-8?B?cy8xMmcrc0g1M2w2MXVuQ0xjRDhUSThwdHpaSVB0VWwxdENjMlNHZDRpL1Nm?=
 =?utf-8?B?bnFkZE10SVJnbHM5SkFta2hsSDdKeVVQMWNwS1JkWXZ0MWgxRFZXV2RFU1lz?=
 =?utf-8?B?MGxJWHBHM2tXcG1TYmZwc3ZncExrcFFtbHgrYVA3MFd4aXFjOStGejNqYVFK?=
 =?utf-8?B?SCtjNDN4cGdPbXNjblpQdVpQZmdSL2dCdjVQUGNTdjF0a09nOGtxc2JwSGxy?=
 =?utf-8?B?a1F3SFZ1c0Y0RnJHaWdwVHpWcll6K1ZjQ1ZlNk45VXJaSnlUZnVSNEtuVnZN?=
 =?utf-8?B?d3ZORW1HZDZPWUpaTzBNSlZHQ2o2eElGSlp3QnVVa29VNm5YVjJFL3hMV2x5?=
 =?utf-8?B?bGgxZndDeHZQUUozSFBUNGxUNDRwODBCR1N6VE4waUZiSXZRZGZlME95ZTBy?=
 =?utf-8?B?aTB2TUJtVWxxVS9jOXN3RStxWmpub05xQU9EQS9mTkhBOWdvRkk4OXpIdnI0?=
 =?utf-8?B?TzhDc3ZwZWNaVjFLM2R6K1BUVFRHNnNrbVA2UGdEaTRmK1NGbjZHY3ZSd2dl?=
 =?utf-8?B?UU9weUYrcTVWS2NkalJDQmRYWEZSN294RUJQeUpmcFlKZkJFS09aTmZmV2Ix?=
 =?utf-8?B?d2xLakRDbkFxNWdCZFNHYlBMYUUrOHdLMkl5VFdBWmU5WTVyeTBwODlOM2l0?=
 =?utf-8?B?aWpKbFF2eEVVVGsyTG1vTXRRRm10aHIrVGwzWkpzamQ1cGhPc3c2UGo5Rlhj?=
 =?utf-8?B?Nyt0eE9CaUFQMTNnbnM2RSt2WUZFc0JSajl5U051R0FMaUlON1hrS2xZa0k3?=
 =?utf-8?B?N3ZkWEdJMDdVNlV6R2RvbU9leW9UaWo0cDRta0o0NW12ZzNFR1N2ZndnMUla?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb60eee8-7aed-4509-8a02-08dde17559f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:13:49.6311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxUa0qdQ9w5oh93CqkIwTwN9CFisUE863Y2D5SdzlFkLn7lsNTtZFYR4RVY7p8Ipxutss6PLTQ3l9nv0rIvzG6Qwztp9cPZjWQOZn7dEoD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6505
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX6jJd641ukJm1
 m/S/YDm50jbkaL5FXh3KtjCBFw1ELS9/aDoXMWA6CxUwmsFf/7BE/FtyzwaqxIcKJz8MRZpvz6t
 9lAENbXJUhHYToRwf8qGVhdlO1Jt37BPVPVNhjT62Pvy/3Oix6kQzJCt16ICCJfD58xqQdXyROA
 y2JCoju8rpt2mKMFboJu3zjUtrOOY/wf07ng6XbuWPdf/Sptqz2SsnuC3P9LPvWHtcfDdYyzPzF
 Ze2rA1zd0mXS+kp0FKcwUFJRqvSjef1ZDK0Ho5B0Zac4bhMYFLX800smZinxCS7t29+a2cp+bGS
 wvzm+s0c3Qcx0tj6tJJUk4xGAt+jLI5A3CQBZ35qNuJ+HiTtbikN376tb4TZvBSVD0xhDQLt0Xj
 COaBLvxitACBHjzz6muy2AkPLSTMeg==
X-Proofpoint-GUID: 4fQ4PqF5dzUq5Sjd8GwRUIe1rgGKP8Kp
X-Proofpoint-ORIG-GUID: 4fQ4PqF5dzUq5Sjd8GwRUIe1rgGKP8Kp
X-Authority-Analysis: v=2.4 cv=Zsu0697G c=1 sm=1 tr=0 ts=68a85eff cx=c_pps
 a=MHwok5EG2MSMEd9B84SlyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=nuetpX4ixqIVgyrW5aIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses -cpu max then the "best"
32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c03324281b..5720b6b556 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -806,7 +819,19 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -819,6 +844,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


