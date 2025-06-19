Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2AAC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNe-0004Ey-39; Thu, 19 Jun 2025 09:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNc-0004EA-Ex
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNX-0008Dk-VM
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7OixC013270;
 Thu, 19 Jun 2025 06:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TBLpsxtYnKCZGPa6nWZU0WtIG+dmzl9JSrFKnvaCK
 pA=; b=MM8E0UHjIR+os5eSKAkyKdHamQS45QcrNorlzdX3QsIsn9hg6je+GV0uR
 2z7ayPcY4MegvQ3GRLFj8L1ve+ZW8FSNO8xIvnpMNWTLjKVsVc7OLUjx/qki2V+i
 xGr+JjvHtDgkOUnrxJ+gdxJP5voyZWyqKPBe/YMBcq8MkWVc7DW2BY8pz9AKIfhx
 6NP5KCmtPHpwBadz/HM7tbF+4vgScXIyifePRYjCwGN3l8o0c9WVurmy/WpgguTp
 gkEHMUkkmXpCCyPnLg+ghAn52FJQnVaL3AAPDKjnv8yZiYhv4nUK/xVqob3FHjdJ
 DQvOPhyof1ntL1yTH4hazcdjkcjsw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020091.outbound.protection.outlook.com [52.101.85.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU8Oy5yGLI9+sdWtZuI+jkmsBKrYLZn8uJ8qtOeMao5L2A6PiVAdd+/h82lmmVJ2ydlZj+fwnAZnMRsi0MNuni5e0qhvpcE//oYxXfyWKAb0u+A3HZUatwqJE3HRjaKe6buJP5SKjHJMNSXBO3BdOdLMwUzE0V+TeGPR+IcF5RfaSZSwvzRLGTaVvX4VZd7HjX6TTZErJ7kZw44iHLI1Grf/Nc9hfqhvxcu4YRnhwkC9r2lDXhPj2/CNcKar6IlUcE2h/l7vWIpnmXjNMwLq1D2zg+6VU57BA2rNa4lBkrCqTgRYDYt+H6SnUX1f9w+LZ80U8J45wJdJcBqjIvpDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBLpsxtYnKCZGPa6nWZU0WtIG+dmzl9JSrFKnvaCKpA=;
 b=CEqR5kjY1i2K+HZI/CS1YLZnxIJkUKRxhTZ5Oh8wfuPqyGtmRCnlHjT2ob0945mZulluZZiNsr8kK9BBfquMB5IiSII7wa0C9LHJ2s60diZVyUhqFVaLvGT6lanNkfjm42cmzHln6tdBqGQKzKMsMI9XibKI91VDlW795Gz6pnhjwvu1iH2Iu+pOFGiuf/d6TPUdRojea48NF2zf36Gcvvc8HTC2k/aFdmXvrwY/6lsMSHffc7Y7ZH6AV2axcYLGCwuyznawTb51HMe20b56WLHQLWnd91/7Or0Lv3Z5YmhaLqRKo6nBayWFqgx2iuX+UTyFk4/OibKYy/hx4bi87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBLpsxtYnKCZGPa6nWZU0WtIG+dmzl9JSrFKnvaCKpA=;
 b=MfxvGguwF8oa0nLweahVhMsJxR/RpFwRsZySvn7TIuJ8TMzZ0M8NFFPrlLUBME7R76YdDzTmYiJg+e6t2S6ZvxSYovrhmiqu5ziWA+vml+CCa9pPS/dsSwuOilo04dwwXyoEZbSFuZiNTdMqUWbgwUNRLcoUC2wAI1AgDuXGtLMM+AReZ2i5I20RbSrMR8cTvPF5du5syRPxyl0VE94T5WT3S2FuRt9Z23liENROhI7DfyuLoFMRRoYcHPboPVIsOT6C3Ge5caZKlpARO0ENcOF/kKfia+AdnL9TRFfnlkStuafwdqX9DuVpbzP61YYn07CMpyMo7/CA0IyWreuT9g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 01/19] vfio-user: add vfio-user class and container
Date: Thu, 19 Jun 2025 06:31:35 -0700
Message-ID: <20250619133154.264786-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e7245a-a726-4bac-e290-08ddaf35abe9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzVrUXZnS2xKUzg2SVB3Y0RKY05yUkVsZDhrTTRFNTBPRGRDam55cWRwSFBw?=
 =?utf-8?B?TXQwN0plMjU3ZzhRVU44UXRVN3gyZURzUHlJUWI0czZBOXhuMVhWYmJDYUs2?=
 =?utf-8?B?U2RSMS9rNUVqRnNib2ZwdFBoZG1RSGhUb0gwbloxS1lhNjRmaVEvWDFVTGc0?=
 =?utf-8?B?Ynk3TzVEcHFLRWJUcU53SGVDb0RNTmo0eitEbmJyQlFYWnhmdEFRRGlsaUF4?=
 =?utf-8?B?eGlzeEF2TXBVRzNkdXdUL05wNnFkbmFMemg2eUNTeWt3MTlwUXZ4dnFhS3Zj?=
 =?utf-8?B?MEN2Q09EdGpqUG13a0xrcWdVMXF2b3ZxTllCZHBscE9uejZ6RzArbDYzWVg2?=
 =?utf-8?B?ZG53RUpCQi92dXVkWktQWDBoOE56TjhUVkNqaUp0MEZVSzMwd3ljUWFVN2Rj?=
 =?utf-8?B?cUtqTkxSbTU0dE9xUmFkN1dGZEdONDJzaVcycjNadmxKNktadFVtMVcyaUZ1?=
 =?utf-8?B?c3hIZVcwb1FIZXNrQm1ERy82d0drWlJoWVVpRTlFMmxvWUUyZ0kyeDNPMkxa?=
 =?utf-8?B?dXRLcFlLTldUdWo4TnZmSStJVmJNU25RVC9OYlg5K3RaMmxUVG92eERzZklB?=
 =?utf-8?B?c2hoYUhWdDVISG5BZ0dqbDhjdWgrbEtOeGJGc2hkN09USjlaZlIvYjRlWlFK?=
 =?utf-8?B?NWkvWko4dXlCMTJYbDloZHVVQTJ2WmRRTEVuTlQ2RGh6M05VOGREZUY5QzNt?=
 =?utf-8?B?TDd6U0hNZXZPckFOU0QrYXdTbDhpM0xEN1VMR3pXTCtBVHZVWEdhNFFLMUVS?=
 =?utf-8?B?RGsrN2JaYTBkYlZqN2Jpd21iK1EySk9IUjVsRi9UdnhkS1pnSVJuRVJmV0Jt?=
 =?utf-8?B?UzVmc29uUXFiWW4yQ0VScGd0SlY1T3IvdmZjTlY4Zjg2RU5XaHlNV2thMGlZ?=
 =?utf-8?B?bndrWkNtYUZLTVhSRGQ4UjJlRGh6ODNQSVhhUUhjb2tSanZvUjlVcGxGQ2ls?=
 =?utf-8?B?cXNlUE1LYVlNbFRoWDc2RmVyM2ZHejFhR0hWcW9kVCtvdjRNbnpCMy9IWmx1?=
 =?utf-8?B?SW9SQUdGZC91c3MwUTIwaVlnVW5aK2pzOXcraXdxNUc1VjJNZnl1TkNHdG9X?=
 =?utf-8?B?VnBCdkx2OXkweU9hTUVEeUJRQXF4WFphWktlUlFsZUdrOXpZT1RkR3dncU9x?=
 =?utf-8?B?TkVha1hVU01sc29ITHpaTXFhcThyWk5GUGM4dkZnbmxNMnZLZUxPYmE1ekd0?=
 =?utf-8?B?Z3F4MzA3ZTBKbVpSMGlhV21hRU9FRUdVeXk0bzd0RjNiaE5kRmlaR0h0VG1i?=
 =?utf-8?B?bW9ZbzM0b0hnRUNQeG5BRWtYaHZoWWs2L2VYM29ZM2w5Z0pMR096azJJcGFY?=
 =?utf-8?B?djYxNFA3bDcycGswM0MvNDkvQU5UOWlkNzhJN3NaOVl6KytrMDFaNnlKYzZS?=
 =?utf-8?B?ekRqYTY3Q01iaDVmTlUrSXBqRmsyNWRmS2FpQ3E2eGwvOTdIazFoUzN2T0FY?=
 =?utf-8?B?UklGNGhlNjJodjF6SjlXbWlGY3RFS1NtWHR3Y2o1UUIwMHJ0WWNReHdzMldq?=
 =?utf-8?B?TElmL3pGZGhXK2tkSW5PSlhRdkFOQm5RWDNQUlVMeElMbzF0Wm1uZWw0bmxs?=
 =?utf-8?B?WVIzbzdDVGE2U0NlZ083N20xV0c0UjZMQXNwT1krSzdITmd4NWc3K2tmZkhR?=
 =?utf-8?B?MTVRNThrUmVWTWNMcm5KSEYzcjZrSWpJMURCS01JanZXMVNBSE1CSDZIcTRh?=
 =?utf-8?B?VENlNjBDTUwveEdHY3hCSFFCOTZGc2V5eEUrbVdLQTcxWmlybjNyZXN3ajlr?=
 =?utf-8?B?VjlDalRJRWFwSDdIeFY0WitFbzBDYnFRQXFnZzkzZThuemphOE1DT0FrZFhP?=
 =?utf-8?B?Yks1WmNDTHF0Ui9DTHJmWDhSVnRBRjZzNks2aGs5K3crbmFLOXF1MHpmWnRi?=
 =?utf-8?B?d1ROU3d3UUJ1SXBvNk41Q0JJWjJkNCtKV3VKcEd1UGlIZm5FUmNrWGRDQmVp?=
 =?utf-8?Q?iSju/NunLQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJpRDBGTFc3cmk0RTVMN3p4eWdja1kxTyszNjc0T3QrOGZibHVNUWVlZDVP?=
 =?utf-8?B?OUVkNW1BOVZ0djVDT05sOER3czJ1Y2RTRUlFbWI1U3h0RFJCWEg2bWtHL1Vq?=
 =?utf-8?B?dHNWMUxQcHY4U2w0MktBQ3FZWW9sVGx0aWI1WHRFdHZrSHRiT2JiakwwS1dr?=
 =?utf-8?B?VkpqTlhhZGpYT3NtVDR0V3lkMUF6TFNFbE1OZWJRRWs3RTc0cS8xdlZrOFEr?=
 =?utf-8?B?WWJFLys0UlZMNUJ0RHRMMDAzWWQwelN0a00zaDFQelNhNGlSNVQzYWNkRW84?=
 =?utf-8?B?SWgwVVEwNFdqYjRyOCtsanppdUtDVHU5a2VtRnR3QnNVWTh4SmZpdVRXWThG?=
 =?utf-8?B?dFdBMG5jVjNXUHd1bC8xczdhQWtJYUVmM3JwaVdIYitJZ3NlZkdmWjFoRHho?=
 =?utf-8?B?OTFWeEdWOWZRbHpPNythczZGaGRRM1ZXZm1jZjNPcUdiRXNhMkM4SlBaalRB?=
 =?utf-8?B?Z1FqSnl2T0RGcVU0THRBdGE5a1hPRGVPcnNtRW1mMmN4cEIzUHJSblA1N2ta?=
 =?utf-8?B?WGpnYU1xaHFFWExhOW9saGZ5cStSWE16bjdZcDFEdVRRdFphSzh3cWhUazJl?=
 =?utf-8?B?UHI5MjhCMUpVSWpORTcyZFpLYWRZVERINWVYTzJtNmJ3Z2JXalBMWHYrQ2Qy?=
 =?utf-8?B?TFJISWh3ejFZNm1BbFY1UWsvOER2NHVKVlpCeGREclZ4U3J0UC8xQjV3bzl2?=
 =?utf-8?B?K2RsajBsRkVqbzVIWjgvYnFXaTA5a0VnQ3JtOWpwbWdOUGU3ckJzWC9jQ01q?=
 =?utf-8?B?S2VUYzJaYWViQmlXSytBNzZkSUwwSCtvbDdWb3ZhUnRtcDNlckt1R21EWmFN?=
 =?utf-8?B?WGZlYkI3cU1jbU0vZU5zRU5NUElkb1RvUytVRWZFOWtUT2ZJM2xFZFU5d3I1?=
 =?utf-8?B?dEduSWtEZUJpaHNIdDR2MkVxd0hYdkNEcndoVHZ6THFjS1d6N3RkWEp6dThP?=
 =?utf-8?B?NHY2eXZnRGRFbnRLMFdOak1MaW1Ib1dsYjBOUkhwL1E4UXRTRnJrd21xbSsw?=
 =?utf-8?B?ZFI2WnNoQ3JhbHBXUXFNMEZrMnpIdzYrZ2lVZ0djVGhVZS9vTndLVXdPcE5Q?=
 =?utf-8?B?TkoxQVB1YUxFa3d2RUM2a3VKdVJMN1JwbzA3dVRBbkhFQitvT1FsZFdTVml1?=
 =?utf-8?B?TUV4SWZ3azdvL2s5a0xrWjNuTEwwNllpb3VJaUkrQiszSWpTbS9JOE9SQnRD?=
 =?utf-8?B?Y3AyRys0amZWYkJPSTdKS3NKSFk3WjV4NHJPa0FNNmVWTWdqRmlRTUpQcVlM?=
 =?utf-8?B?UlRLd3dIaDVkd1IxTkczelFRK0NCRVRMUDkzNlNZSVBJdHJ0R0RLUnZoUlI2?=
 =?utf-8?B?Tm1kT0dCc25ZUjZ6SDNabC92L1FibkNaRnhFZGdEN1hiaUVTVm5KQmM0SitZ?=
 =?utf-8?B?OGxwNzVGVDU3SzZxc1VTd0R6Z09mTkpVbk92RGRJTW56RDkxSmJyNUw4ZVVK?=
 =?utf-8?B?eS9haFBvK0dUTllZN3hFWlhyQWdrQVBmTWFXenlVa2NUSTNMME1mcm5hS2sv?=
 =?utf-8?B?cTA4RXZvMHpZRHVPd0NpMThhOXFXYUk4dVlUbzEyekdMS05KTVRENU5lZnlW?=
 =?utf-8?B?Z3lQQ0U1OWpsZE1qcmY2Rm5oOW1rYzFjVGZXM0YyaFpzaUhPbU81eXdhM3NQ?=
 =?utf-8?B?SjBMdUFySkpuM3phSUlSWEVSYzZyZFNIT3dkSDQwaW9GcTJLc3RYaEd0OWd0?=
 =?utf-8?B?Wnk3bjl6V1p5Q2pZSXRCYTg3MnEyUVp5cDZjNlZPcy9uTWsxUDVuNDF5bXBL?=
 =?utf-8?B?Mnk3bm1GeHNCQUwyKzltQ0kyNmNFYWNlbnpvcDNsejhYYzMvYmJVTDRmUVE4?=
 =?utf-8?B?aTU2UC9XRlYvU3k4cURKL1lpc1pJY3pSalFtUll3azVqWkUyYVFpbzJoLzFz?=
 =?utf-8?B?MkhieDVGbEtFQ2lMWWNZdXRBakk4NmE3NnVzeU1oSitCWjNqRXpsN1RrMVBj?=
 =?utf-8?B?Sk9kYnNCMEI0VmliZitmSWNCaHA5OXNBZmlVbm8xeitPNWFUb2plSkxOb0Zy?=
 =?utf-8?B?a0xVZCtTb0pTcTByTDJ1K0tVQ2FrVXJ2L0NjelI5TytHaUI4OGljZ1VFWjhM?=
 =?utf-8?B?OU1UTDBINU9hT2dQMXpPNHpIWW5NZG9kdlFwcmJQOUhIdzJZMjdzSUdNa3Iz?=
 =?utf-8?Q?1l16P6dZu8rqt1VeF4MGkc8yE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e7245a-a726-4bac-e290-08ddaf35abe9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:01.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lbg6euvmcgpS8jKrlBTRF5+RnBcQ/elK0X6M01XTfIrgL2/Zc42vDZjSpCmru3kwlpKwZvrdHJDjFCK9ilMsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX7wlzT5TqWtIk
 UAUYeMUKtcSsqxQ4iYQTzgOsL9i6tFLD55qwuDN08dh9qDNzgpbMqvFX3PlkdEpMoe1bKmsSYiU
 bYqya7Pt21ANOofG/VWtqnHS+cOZd/qlBmiXrxJVT2SMamIutaxAE7enGfQMEDUcSrpRSZ5+7aQ
 Is5G6i5WfVdsmPY6nPLSKiSoRIY0GUe5z2mnPz/h9fNB5CoJw6xVZqYie1XydiEtVr/tDL633e2
 XK31E6KrPUZe8rqiqLJi/hVXf63na+sK7c1SLkkAbwRVH+BZH6y2opjY92I14dDME1FCOu8nm41
 BKRGp670U9KE3TeC+en1P+Set4xhtJgFLPAFdK8TCojlHaVcdyqCfgGvud0rZaTp2fhSKLo2k0Y
 Bv5YV1wF35X8IA9hrhjmQpQ3/dHLTVLj8JPB9E/sUvNInkEp1kCWbPecgCEVYCe9OYKv9xet
X-Proofpoint-ORIG-GUID: fqNH5t3eKzaCS41BkZH8CGHJfRgJQAoZ
X-Proofpoint-GUID: fqNH5t3eKzaCS41BkZH8CGHJfRgJQAoZ
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116b cx=c_pps
 a=kkQK6hjpUACXm7ua2zl0Pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=u7rQ6wk7R_5OE3_9H9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Introduce basic plumbing for vfio-user with CONFIG_VFIO_USER.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   8 +
 hw/vfio-user/container.h              |  21 +++
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 208 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 185 +++++++++++++++++++++++
 hw/Kconfig                            |   1 +
 hw/meson.build                        |   1 +
 hw/vfio-user/Kconfig                  |   5 +
 hw/vfio-user/meson.build              |   7 +
 9 files changed, 437 insertions(+)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b3dd2684..9bc1005b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4250,6 +4250,14 @@ F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
 F: tests/functional/test_multiprocess.py
 
+VFIO-USER:
+M: John Levon <john.levon@nutanix.com>
+M: Thanos Makatos <thanos.makatos@nutanix.com>
+S: Supported
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
+F: subprojects/libvfio-user
+
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
 R: Andrew Melnychenko <andrew@daynix.com>
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..e4a46d2c1b
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,21 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f0232654ee..3cd86ec59e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..2367332177
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,208 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..86d7055747
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,185 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qapi-visit-sockets.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    SocketAddress *socket;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
+                                           device.vbasedev);
+
+    return OBJECT(vdev);
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_pci_intx_eoi,
+    .vfio_get_object = vfio_user_pci_get_object,
+    /* No live migration support yet. */
+    .vfio_save_config = NULL,
+    .vfio_load_config = NULL,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    const char *sock_name;
+    AddressSpace *as;
+
+    if (!udev->socket) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "e.g. -device '{"
+            "\"driver\":\"vfio-user-pci\", "
+            "\"socket\": {\"path\": \"/tmp/vfio-user.sock\", "
+            "\"type\": \"unix\"}'"
+            "}'\n");
+        return;
+    }
+
+    sock_name = udev->socket->u.q_unix.path;
+
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+};
+
+static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
+    bool success;
+
+    qapi_free_SocketAddress(udev->socket);
+
+    udev->socket = NULL;
+
+    success = visit_type_SocketAddress(v, name, &udev->socket, errp);
+
+    if (!success) {
+        return;
+    }
+
+    if (udev->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "Unsupported socket type %s",
+                   SocketAddressType_str(udev->socket->type));
+        qapi_free_SocketAddress(udev->socket);
+        udev->socket = NULL;
+        return;
+    }
+}
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+
+    object_class_property_add(klass, "socket", "SocketAddress", NULL,
+                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_set_description(klass, "socket",
+                                          "SocketAddress (UNIX sockets only)");
+
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/Kconfig b/hw/Kconfig
index 9a86a6a28a..9e6c789ae7 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -42,6 +42,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vfio-user/Kconfig
 source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..791ce21ab4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/Kconfig b/hw/vfio-user/Kconfig
new file mode 100644
index 0000000000..0bf6f1191a
--- /dev/null
+++ b/hw/vfio-user/Kconfig
@@ -0,0 +1,5 @@
+config VFIO_USER
+    bool
+    default y
+    depends on VFIO_PCI
+
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..8749526cd0
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,7 @@
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)
-- 
2.43.0


