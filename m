Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6FBC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2T-00084t-TG; Thu, 10 Jul 2025 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2P-0007sf-3t
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2M-0003YR-1m
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Mgvbw018518;
 Thu, 10 Jul 2025 01:53:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pm2SRgwQCZ9jiWGwZWNaL21zne5VUj0SrW3LuVusr
 G4=; b=G2sX2cSmyDj3zphsybQ2s1+4DnLk2eVXfJOd0iN8tMQnzCLfWhwEjKt7m
 6A8362vR2OY19Eml6Esja/m5MDfPuLlgkKrIzdzc8aTmfrAW/AyPogeng9waiJ2v
 L17SezzTPmTfDTgGJD6bINt96ykbAGDxeGpBTqlzlrcmZNPQ6D2T5cIwHNq/EJQP
 t79KMrAAXWblciLF72GPKYRKIDvgA1p3QwYfyh5PgmnToTIECEbJEnVMJljWTjus
 +nGamQBiivLFRWJ7lZ1fHFDTUBodpghrxkNgR3A6yHND9Er7dtoc6j057Nzn2IPw
 +1dK7p2Hqevi8/ZI6MnNxb/r2XvPA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022103.outbound.protection.outlook.com
 [40.93.200.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wek8i7YNiJ0JBw/1sCfzE2y9X6/B58xFuqDF612R0TZs5HRUnM4qopRTb9yek4zlQPUYW9p4/fU9V74hUA8iSTsZBd9gz8VMRhdTMI6pSRTar882/7nyOnXi8gIqyoekJHIdG8gQEAwjC9WG90Eamy6pbO3t/u6P1yzdocX47nEVXv3gl21AIEBIOeLoHndu212gAMavDn3LJtSTv92pFAflBd0Bng/qeDe9SL47OI2pkessMO72bSx7uZ8ssTz82XxJ22ezIlqDOmTAwygjQnaGDRAe0gJ9td3GCE1pCjSU5q/GUIsmLx05qLxFdoeDxFjKrTM7y02hMwjCU3smnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm2SRgwQCZ9jiWGwZWNaL21zne5VUj0SrW3LuVusrG4=;
 b=jc8jDps1QTKaPyjWTHL+fdsnk5NjIJaLKJ0dcsv/2cq4y7mAr6bm27gpyENHyqVr5oMR8TjEf68m8DIBQOxxnlsx2yI2bOO6JHoSxWen9l3FwaYSxyRmlfo7fxbwv/9m1D6FbVaCy1lLVR4FTSm0Np7AEsRC/Sqgq1lU+CEV//VTQXBmVkHWitO68oIod4zPCtyPqxsJ7/dWKuGsN0TF7iTFtaPFGKELhe2Dou8VTdrdcmWNX7Dz2PdM0Qe84NAuWcQx1Bz+8EvcCB+6Mk0RQtkCrclHbDNf4OGTI//hMfeveJkR6ey9vFBwzhUzatD4Jbv28JOdGojQ7hcR6Lbgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm2SRgwQCZ9jiWGwZWNaL21zne5VUj0SrW3LuVusrG4=;
 b=CUkjcL/a8bJzBK1YVWoxYl+9RbiF07e6M4szDkdGhw11xASgC++O6pDn1MVG0x1pfX+d3zIW+Yt4Ydd82eoN7I+bUmF7uDATIKSWzdgoxOzs4+2xdxHSjEtUPA/JNU2t8s144fdkQgcTrj0cL7f6q6FR6c1r9OE08B+4e+7WUQkEDjIIHpbYPlMm7kIlrYwglQsecXeNSrr/av2rkQrInhOwFFfGOyBEO0SFfwmUs9NuXRWgnE01nT2wPrWnyYQpQFh8H0PuLSohlOqb9E++nyRVHEd4xq4+gdWf0VLsmqjpNw/grRlLfg5RtGLj68bHpD+jRKXkwUPps6Q7ZK8Dow==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 09/18] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:24 +0100
Message-ID: <20250710085308.420774-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0042.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f3171dab-7461-458d-ca22-08ddbf8f4748
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vi80NVplRklydUx6MEhrSlRsRldJUjdyK3cwWTVpSk04RDhJQnJqcHh3Zm1S?=
 =?utf-8?B?T3ZkQTh1RFFLcWlITlBjTWg0aUhGQjNMLzdwL1J3UWZ4VHVFREdOZjB4Q1R0?=
 =?utf-8?B?TGtTRVcycS9vYWVJZzB5ZnJQTEhyVmRNL2R6c3BXdjVDeDJiRkZPd0lUbU83?=
 =?utf-8?B?MkVlZlUxalNXaXlnU1JxT3ZLSWJFWlIvZjFuYzVSVHdWQ3pBRHp6Qm5vSU5H?=
 =?utf-8?B?S1h3S0FwNHY0dURnMFRLRG5SM1RQelFVaHlrdlV1RjBteXg5RTRLTmhHd05x?=
 =?utf-8?B?UmJMR3pFZ2ljRlBQcGxwSFBIaEhzVjIvMFZ6K2dTdnVUQnFacy93a3RpdUhL?=
 =?utf-8?B?TEFsRzdKd2hoejd2a3NaYUw4QzVsSExKd3lQZDVMSzdZUGpCTzBrSmZCSldk?=
 =?utf-8?B?NUQ5OC84bzd2eXRSWHZaZ2tqZ1RLODdlRWJQNERSNWRacm9vODdSN0o1Z1Qx?=
 =?utf-8?B?c0puQVJWckFteXd1d3ZYS2xJbldDL2JWY1h1MzloOFdYRWQ4NjZBYWdqTmtM?=
 =?utf-8?B?VjJzMkU2NFNHMGd2UW1zcnBmdW5XY1FmT21mUXZ5alVuUHAweERKOTdFbGFp?=
 =?utf-8?B?VXJvOVh1dkd4SGphOGY0RGRDWVF2SjlPcElscWp6aVpHbGFOQWhVVGRWUTI3?=
 =?utf-8?B?RTcyTTRKSVlQMk5ndnJnbDdnWDB1MVNtTTQ2KzBVdHcvSUJpUjdPYnB2Mk9h?=
 =?utf-8?B?djNnaWNxQUhDREorVXR3VEUvT0lKM1ZOamJxeHBqY282Y3ZoL2ZTZXhkdE13?=
 =?utf-8?B?K2ZOR2FaUGJnSlhjelYrODRZVU1tRzdPUnFVbnByamVTVnhHc1dRTStJMnRq?=
 =?utf-8?B?Q2dVMWlhaDJNcGZFN2oxNDI0UkFacGxKdUJIbzRqT1NqUEE3cS9ub1hsWFRi?=
 =?utf-8?B?ODlGZ1g4c3ZWb3ErNE5hMnR6K2k2Z1o0VU1KOXhFWXVZK3R3aFc1NEJnbnVE?=
 =?utf-8?B?WnIvVC9WWEN3cEYwZCtERDNDek1RYmlwZWVudzQ0OGFmVXpqdnhrdmtSRjQ4?=
 =?utf-8?B?NXA5bk52eis1U2I4M2hCQytYRENNNEZCT3pEdjNyK3FQWCtHV05aNzFxZkVi?=
 =?utf-8?B?S2g0Q2pJUzQyLzZMRW9YVDhMc0VMMWUxSmsxb3lwQ0Nvc0tpTzNzNGR2b3Fx?=
 =?utf-8?B?dFVjUDcxZHRHUzRXSlNkeEd5RTRoNlVrNnBJYWJCTFoyM0xmRnZjM0Q4TSsy?=
 =?utf-8?B?aE9jVzlMZ3RsMjBETVYvQTgyOVFMbVZ3ZmVyKzFQWXI2K0JmTWNOTFI2RStH?=
 =?utf-8?B?cWwwZERaVFluelBVSDBjN2FPTCs4VzJiVVBiek1sYkhyNThGNEo3VjYzTkdi?=
 =?utf-8?B?VTRYUXg0NTZlY3FRZW1Gek50R2l6VjBPbTg3T241YnMyblU1cFVBNlBHZnc5?=
 =?utf-8?B?cTFVbVA4TWRRQ2tsak8yRnpDbmQwZE9tbXhUbno0NXNCaWRkSVF5N1NJdUla?=
 =?utf-8?B?NVNJcVMxNXlSOHQ0NDljK0lYTHE1NnpWZ0tHYkN5cGdWNTFpNnFYcG8yc3Bl?=
 =?utf-8?B?SlVGWE83OUwrdWZ4cWtVOSsvK1RZYzgwUVp3Mk9qVDlFVDNSVzdGNUZXOUN1?=
 =?utf-8?B?WWg2WDAvQ0tJQjZKcDMvS2xPRGhTM1hja2JYdERrTUZIZWtrMjMyTVVPVitx?=
 =?utf-8?B?ajlWSC8xbG9QTVZJZTAwVGJnaTdsMTRmM3F3Szl5U0YvNDJNTEJiTEdJRkpC?=
 =?utf-8?B?RnVKRkY0NnRvLzFicUhEanlwbk8rWmpOL0Z0TnJoZ2FPai9WcVNGSXVMSnNW?=
 =?utf-8?B?TGtKZFZITWFrK1ZRaDllQzh4UXlDaEltOXpCZjhQMVZVdGxNdlN2d204R3E0?=
 =?utf-8?B?TGdSdnhWdWR2elo2b1drWE5udkJqOU5sci94bzdITm11THZNSm85YmpDbjI3?=
 =?utf-8?B?UkNlS0V1dXd6RndzdGhibXMwRkVDdndDRGRUeUd4RnJlUUZMUjdEc2RTWGVq?=
 =?utf-8?Q?cIZbpMBB6y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHVGMnlHeGFocElmSXQySEJVQVRjeEV6TzRHOUlHR2loanZmL0ZLRDh6aC9p?=
 =?utf-8?B?cms3U3NvODltT2xvZmRvK2xkVGhhQlN1dS8xTGxQVWxRMXZhbEc0dnRSeDdW?=
 =?utf-8?B?NXhBODBtbWlGR3dZSmZPMkRUSVhWWkhEUWtJR0ZFVlZodU9jNmpIN0lHL2o5?=
 =?utf-8?B?aEdMY0hsakFzbjhrdnVmaUVNSWVPeHA5YW02WVN4VThHeWx2NXIweHZSRXJj?=
 =?utf-8?B?eGNHdGtqUmdQMEVFRFNVTGJJa0liaEVJMnk1ZDBWUm1SS3BkZDJtaDZhUmhT?=
 =?utf-8?B?Nm1WcjhXWUpWU0t0MTdWNzNHMVNGT1VBWXB2L05jQTY5Y3FYRUx0Sm1Yb1Yz?=
 =?utf-8?B?RTVGQXpsUGp3VGl2TXF5dy9oTGNsRitKVTdsczZsakFSZnBHZXBoL090V2g3?=
 =?utf-8?B?MVZBc2NLV1M1b1d4UmE1UE1UcWFkdHVNNFdTVWxhWmZEYlZPcTFNdUFuY0wy?=
 =?utf-8?B?ZWZhMG1jYWV0MkJWL0VCRnhFR09maEVCd3VtYmZEcFEvMHZvems4MS94cTFX?=
 =?utf-8?B?ZUI2NzNRMXVYVjY2ek9NWWNTUHVKNWlqQWNYYmpwMlo3OWRtQXlGekZLQndo?=
 =?utf-8?B?M0ViNmpLTnhmNE9kTGhvajMzcmwyMGpLcEhpbUpSV0pPdk5hOUZiM1F2L0pF?=
 =?utf-8?B?c3MwU1FydHhBTUtiYXRTRjJzcmRWZ2dQeFZ3dVB4Y010ZXZnNXcvQ1FZZDVj?=
 =?utf-8?B?VFk1ei9ETlNDQ1UzVG82enZIMWRzcitWVjBGdHNFSEJjeGhjeXR5NGEwMDlp?=
 =?utf-8?B?TjIycGRjbkp3UWhZTDdrYlJ2ZUJ5MzZobjZ2T2ttaGk5MU9nNWc4OE9qMjla?=
 =?utf-8?B?a29OWi9oaU9Yd04wclFveU94U2syT3Izdkl3c0hCV21Pd1p2UFdyMUY3YXE3?=
 =?utf-8?B?VHBSQ1lsUCtrNDVzWk9ZczJsS1BMdUdRRWVrd0pUQ1FVd0lYbSsxV2RYT05U?=
 =?utf-8?B?V3J3MUs3ZjBvM2x1elZZUUdSelRicWVrWU9wcEZDc0xZeFVOakpOVmVhNlNr?=
 =?utf-8?B?dTNhWENFOVd1RnpDY095QjNsSXZ0QXFiakZGRTRVclI3eVBINXpXNFFqQ3Fl?=
 =?utf-8?B?aFlFdGhhZThyNWR2YW9uNjlaQ3VvOTBxaXY5T0U4dTM1NGw2eVR5dTd1MkV6?=
 =?utf-8?B?cEkzbVN1a0l1N3lYSDBBSjB5eW9ObE5OOHZqUXJWV0YyM3RvdkYzTGVJMTFX?=
 =?utf-8?B?ZU82Sk5Fb0ZwSEhXWkU2Tk9NTit0Ti8vNUxVNXBZazZMWm5uYm90SURLaW9n?=
 =?utf-8?B?ZmVDdXVFSmtFTklZZWNBazkrd2FYcVFPYTFtZ0J3SVljOUthYzdRNGlaak91?=
 =?utf-8?B?RGVXOERRckZkb2J4bEs2UU9VRzF0clQrT05WTmV1b3ZRN3N1bDE0TnFBUXJy?=
 =?utf-8?B?SkJsMWk5QWlGemNCUjg4d25TMEwrek90a3pRMW1qTzFER0s4cHFwNGJBbVNw?=
 =?utf-8?B?cENuRDl4STRpMi9XdmhaNjRrakpzQm42eGthQ1VtcHF4SFdJcS9pRjczNFA2?=
 =?utf-8?B?SFJzTWVOblNxQ05ybkdPOTJtSGpCY1Bsc3NaYlNuTXV0Y2kwdjBJN3Z2a3o2?=
 =?utf-8?B?M1RsK3d6eExFN3ZPaXU0bDNYTkNQRFNTbm9tWEUvdkVEQ3ExbTBWMjlDN09X?=
 =?utf-8?B?L3hoemFUTUJwc0RsblZyQWNUUFRFT3hyajNFcHQrT2RjZzFCMmcxMTJDZ1pK?=
 =?utf-8?B?b0NFMEpXc3lhR0ljdXI3TDd3Uk12Szhwd0ZBSVlDM29hLzFpeTNyMGQrQ0lS?=
 =?utf-8?B?aUZSeW8zVTBicWU4NjNSV2kvMmkzVFE1MGhkdmZ3RWo2TUF2VVdaMXl2SzRk?=
 =?utf-8?B?bTMwWHJVNGwxTkltMENHQUdoNG16TExqT01kSVFjZjFqcTl0NzVJN1Z5bmlw?=
 =?utf-8?B?cW0wYnRGV3Q1YVFObzJKbkJmWGV3OVI5TSswZWkzU2YvWkxYQll3aDJUaWxt?=
 =?utf-8?B?YmNFc3VqelhKYkgvbzV4MXVtN0xXK09RdW44MGtKU3lNWEdxR2R5WXdGazcr?=
 =?utf-8?B?SndSK0hwVml4S2grUVdMTyszTWh1OFUrNVorM1M0aGRueWllS05RZWVQYlho?=
 =?utf-8?B?Z1Z3RnJtU2lkL3JzcUwvaWZkSXd3ZXc0QWpvLytBRUlLSXJTcS9GcDBVeDZI?=
 =?utf-8?B?cFhCc3duQVZwVlUzNjZaUkhBNjd4cFpZeFJNUGE3RTF6WlNiM0U0M09uSmlB?=
 =?utf-8?B?WDFDN09uN29oUjRkeHE0M1lJN1BzcE1HT2xOSlltVTRUL0R5UzRLNFc3eHZZ?=
 =?utf-8?B?WE1VYVNwOStGUVB3Z1dmbWtFVG5BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3171dab-7461-458d-ca22-08ddbf8f4748
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:45.4691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF8ghrqLUEem5vWLl3iejGy5z0rM1UH51oQLRuQrnL1Zf9QIMx7URX+akGzxn9quzFcMkiiDfWcFOxV31f/EFj9fQmSqP0NkBkp6wsclXXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7f9b cx=c_pps
 a=NRt2x9XRVm29nzkZGme07w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=aqeCdxMHYQgX1PSeTiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Y2I9djKr7bSLUkXm4C3lpAcAlFWaZZTP
X-Proofpoint-ORIG-GUID: Y2I9djKr7bSLUkXm4C3lpAcAlFWaZZTP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX7Wo6TEcg91yN
 WxP+fNmfL4R5zD2yWgoPGXh3qYrw/OQRhxWUhg0JF/RlOc0895pUJuwzgS7yiXRSRiVQgdzzyrF
 DGyaSQnVhdyb1gZxKT8uPIGn0DMJMvrMmTZuIhwnRVye/3tkGHiVS1kBJoqGXM7DBW0POc6/5Y1
 PXcS5ALBPn/wMo058MpT/VQPFKsVbAYiDYp/2GD+/94QSBxeuznVegM2MEX1gUpb0kFsWlhqWW5
 /ygrtYj/B+HXeDYR/oIhlrMv/wmVFj7cjlgQpMGYkhZ2iF000ARdJcY2r5uMffYma28NibrDZyS
 6BH0/LHQtDGDljTkiAlRrBjpci7/YlE+lEUio0Ctd37JYDWXm5XXbyB5P5FH6ogbLtSAjHAkdg9
 jyO/sWvnLi0pTU0DF/I7/LWMmLc53hpS7v+tEimXJDvgTt1WRZGaEprVL6aYnq9ez5kiGt6Y
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 80e4ed8c87..48d0b2f5b5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,7 +426,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -461,7 +460,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


