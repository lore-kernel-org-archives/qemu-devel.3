Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FCCC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh7p-0000jw-8Z; Fri, 04 Jul 2025 10:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7f-0000ik-Fz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7c-0004du-Qm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:39 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BSSeg022206;
 Fri, 4 Jul 2025 07:10:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zyeKhr35EZKtAE0UmUCPg6WHOT+4bU8uc9Ff3/dHA
 lE=; b=Okj15zBMLoxwbdL2E7qPeQy1doQmrw61YzXNsKb1Uq4P8GpW/FrdBfsv4
 /hQryP9pJYSlOnr7+uUlhn09qx6KO/b+RVkHb+Q3r5qYsmptlJTbX/mMksBhpcXV
 V30+zU7MRqkQHIknKBpMmvYTT+BSD9iunhGu4iMwM6b2oT8hGdbWGnhTHAwmbiSC
 IBru82K37rquWPzTUH3Z7irrp1Pb6BeAYvA6pGcwcNlLmBZqnWlZtMSU6SE+cB/p
 KFO1SfHWR7VXKhTYW0occjpaIDDQg352T2+1GDUvzfosyBvT63XEkgDkoD7XS3AY
 XM/ejpuzzFcbxVi5lYJRE5Wk6SW/A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47n1x96a45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDIRIkQlOYrm6iOglcqLOU7z7n5bdmvjwmeiU1UNxJuhWWOilrORVI7HLbzxDTREzjeFdh1qOEY76beAVcIhaYTkxVdckPrVi4IP+cqLk2tLhkg0JQipxmASDcdGsNdvROfO3hLiIp21Vi4RivbINj4y9d/hofM4HvB8xb57btU1KKteo41qE61CSO8y4t+RlKkHxj/FZfJAfJh+fy5u2Gn0yOn6HvAogJ+AWoVIAndD997vhGpcOKt9UHgjKFPa5Zom1hpuVOLaSUTzBRnCKbV4DuGsdIc3sz4qlluEi60zLCX9tgELZtHRCIX4s6LGN8dagm5435J9Cym7JUY0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyeKhr35EZKtAE0UmUCPg6WHOT+4bU8uc9Ff3/dHAlE=;
 b=VtLdw9h33mq4VJ9sKxRV/ubacwf/bhdgVqt2JXj3nz+rEQhdnr3/Pw7cavWO7izRGdm2IKDFOdU21s6+/pmXp5StASG8QS2hqQKUgBUorwtJRH3ge5LWL+0GN5aGzfXFzDLHU6I3sEgrfCDtyRmBsmRZTfTGEUU5llj1qZqLUg8YrX7aHcxwH5JStnT8RT1ziBb/Q8FcTpKt/Wsx3NwEzine97lXhqeBs7h4v5+VSMIj/tYCj2Y/myomQ37YntHdaZ8Da7J+k2DEgqXhYU7dXKgbPaI9uVx0XoSfw9ETlyHvqHTjCk0ak+EXdeg6vmTNb0AG5Ajpa8KEydmoae08Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyeKhr35EZKtAE0UmUCPg6WHOT+4bU8uc9Ff3/dHAlE=;
 b=FTr4pDWFhrjpAN+E6NeH23m6Em6JYGDtNfRjUuRtyWSjnRDfPSBph9eLGDhotc7TxJTCv+X7Y2QAx7kuWHXBkCGzB4P7ebACRicTiShf8FabUWTuLLphdWRPL7Kgdeu6+7X6OF+svHV2tXPFmAFQowIOtf8SpAdiMV6RF2ufSROUloHGBzKqHt+9QCdc34q+//QxaXhPN0irTIJ/wJV0V1NxgF0eSsOF449C8/PyL3r/yN2eIFKf0dcmxM72VhYu45aRuhkD3B/l7ke/XvvisZngthJfYD+3e4CpmFYB2bZWr9/sGiniTAmJwp0LmiUnmohfzkRUyAkq6o17OUx8iw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 02/14] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Fri,  4 Jul 2025 15:09:29 +0100
Message-ID: <20250704141018.674268-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e93f97-a4f7-4a2f-cfbf-08ddbb0487b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjIwWVdWcXlMbjFxZ1Y3REV5Ri85WjNYT1pMY3hrRWcxaVFHNDE2M3BNa1hY?=
 =?utf-8?B?SXBMS0xFUTFrV1Z5bXkzeGRrZUdxTlprcDA5cUJpWUVuejhJYnJZZlg3Mk1X?=
 =?utf-8?B?NklQYktVY2Qrb3NMYThKOURlbStJVjY2ZzhSK0FnelZ3d2Rwc2huT2pTTTRz?=
 =?utf-8?B?RUk1cXdGZkg2c1JrZnlYaUJ5UFFWU3MwMW96THZaK21rc1RJRUhYdGcydW1a?=
 =?utf-8?B?V1R1M0YzNFQ5MUIvdVFiY2lXQk1IaFZmVzZDWDJMT2hpcjkyV2FtRlBtc2NI?=
 =?utf-8?B?emZrTDF3Rk43SUpldnk2Rk1Oc1dtTXcyejZXSzE3b0Ztd1c3ZVdVL2RMbUdn?=
 =?utf-8?B?QUFxd3M4Nnd0UTJRUFlwUzNneHQvczdrZFB4NGEyd1lqQzVid0tTbllua0Vj?=
 =?utf-8?B?YTRTaTB5ejRFYUlkSkxDT3NEeFYxVWVHaHJJWDJncGZ4cFhNY29ScExQZTFp?=
 =?utf-8?B?ZHJMNHFaaVB6QXpvTHZMa3BPY0JvNjdTTXlBdUlUdEo3Y2lORmJ5NFp2ak15?=
 =?utf-8?B?bkZuNHlCYnRUKzZEUjN5TzB3VTNWb1pGdGs0ZXNWYUl1My93eTl4SDRlSWFF?=
 =?utf-8?B?NCs4L2NpYW9jSkVhYXlicS9NWkV3V3kxdm9wcHN0OVdvYVFud1VxRlRGV2RK?=
 =?utf-8?B?MmZFY203YnJqMG5BV2IwS2daTjZ0Yk1kcHZSUWRSc2t1ZHVkM2dFYWhYU0d4?=
 =?utf-8?B?ckRMcmU5QTYyVnpkcFBwUTNid0FRNVJVcHJsb2ZveFZVMVZ1aEYrdG9xMEJC?=
 =?utf-8?B?NTZoYkFIQUhIODU5SkZXNk1XckdUdVB0UGpSRzVGUTF0UmtSekNNbmFCWTJl?=
 =?utf-8?B?ZDdwVVZZck5rQ1p5dVdRU1RsMGJnMTZkUG9Sc0ErRGtFR0ZKTUJIejJ2dmFR?=
 =?utf-8?B?NllDaXdMUndxU2IvMnBPaDRDUmduZm5tdjF3SHFRcDRuanlOcDlXRUFXWHdP?=
 =?utf-8?B?VWNDNmRxQ281UFBrc1pWODlTTkZwd1VSbWxUSEJySW5DQkdacHBaMFc0cjJI?=
 =?utf-8?B?QmRNaklZMDZyZ2pXLytiOEd2azh3NG9UWlFOcGNFTC9md1hkUlNnM2Erd0JF?=
 =?utf-8?B?b3U1dFVhZnpRTzF2dmQxTEFzZjdlb2EvT3BWd0F5TEJVMSt3Y2xCWE5wbWMz?=
 =?utf-8?B?dm9MaUIvRDFVb1FJWWYrZUZDR1ZIV09leHNaNjlCdjJEWlBZMmF1OFVyT3JY?=
 =?utf-8?B?Q3JHM1BGRk1tU0NLQVl0bVcraWFzRU1xZzBtWm15VGNpOVZGK1pxWS9ZTVNE?=
 =?utf-8?B?R3hvY1NxT2ZLYTJQeVVOZENMdm1LOVI4U2lJZmJkV1NmZUFjRE16VFNMUVV5?=
 =?utf-8?B?dXhkRGZRSXBQZ3ljalp6bDBZV1FiT0lPaU5LRjgzN3pjUHJQQ0RCNU5nQ0hi?=
 =?utf-8?B?NUY4MDl3N25uVXBmVitCZWQ1bGJOdFdncXlSWVB2enI3ZnhldFdOVGd2OSti?=
 =?utf-8?B?WEZGV0NlL0p6Wmw1a1ZBUWowWWRseEd3UkxXb0w3TUg5QVI2Ui80WE5SM3pj?=
 =?utf-8?B?WGhRU0Z3c05LLzNDUlcxU2lOLzlWRll2SmdQT3hOUFdwNDJBcitZejhaazVl?=
 =?utf-8?B?YVo5d1VjWE0vNHh5THhFNlNBdHYxVktNWFZjVWhIWWo2QmUvY3pKelNZUk1m?=
 =?utf-8?B?WFdENzRSWEw5MDNsSjVUcmppUCszaCtFRjlKOEV5SU1wVnh1MXZBT1BPTVBj?=
 =?utf-8?B?QTdrVTg1U2RXVGgxTWNXT1c4VERzZjg3b29mUnN1RlZxbTArRG5wdXFUMHMr?=
 =?utf-8?B?NExMVGU2L243NHVIWE9nMVF4V2NUMGtxNlB0dzZqa2JFSDErdVM5aHgyVExT?=
 =?utf-8?B?MWt0eFNENElhYlJnU2d4Q0FRWlNFQ1JlWXVnS0J3YVhQWmppa21Vc3J3eEt1?=
 =?utf-8?B?dVBCdG9NbkVnRUJnUVRweCtXVFhCTVMxMnRsYStwdFBLOTY1RWpmdzNJN0h2?=
 =?utf-8?Q?JejcGBLIG+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkV2RmE0QlNlUVhTeVY2ZWpFSTBoZXNOQkxkWXJ1OWtBWFZ4SjRSSE8wRnhu?=
 =?utf-8?B?VmRjU1FnZjEyaG9wajV3ck1QdEs2RmdDSkl0MDN4UEJFb3BUdStkS0tuUVNj?=
 =?utf-8?B?UjFkMUxFTXYveXlxTTRJT2tONmpTbTBMS2E3QXlUOTU4U1g2N1lKRzlYUUtU?=
 =?utf-8?B?SUdoVFdWWGt5NGxuMWhFa2pWOUZUVWcyb0tSV2hBUzdHVmh2cC9zR0JCZmxh?=
 =?utf-8?B?aXJvWTJ0cXE2czV4aUM2RmlrU05ocTNUMHpiTTd6V2Q4amRQNlZDTno1aGVB?=
 =?utf-8?B?dWZBTDh3emRFdmI4YXdyNXdCTEYrcDlmcWwyMzVWejRybFpzcmYvYU9CM2pL?=
 =?utf-8?B?U0lhWWVrT0Y5MjVkdU9COThKaUppaGdyem1oaUJUMWF1MjVXSkxqN3JNdjB6?=
 =?utf-8?B?aC9nVmxrY3lJdDBJcmQwaml1WWIrWjQ5dFVETkhLVTJCVGxYVmZyd1lzL3dx?=
 =?utf-8?B?UW5SRkNiQkF5QndEL1B4TTc1YlY5eGY2d2duVkY3Q0xFdGFySFpIdklFUjl0?=
 =?utf-8?B?aDhQcXpzY3FGZndVUFYwNUMyakN0MnJQWVhweW1sUnZqNk1iNVhTZGdKRGNJ?=
 =?utf-8?B?SU5tdEs1OVVNay9NZzlvZE14bnkzN1dOUFZQdEJqU1NRSUkxRkUwRmtuQlhM?=
 =?utf-8?B?SWlEUlJPdHE5US9DcmNGQkJWVTM3WFNnb2FYT3c4bUhZa2JDcnVtTi95MHlM?=
 =?utf-8?B?aVI5R0ZzK2RlMENXL3RCdWFFayt0K0tsdndXOUdGSjNHTGVvSTVVZzBock11?=
 =?utf-8?B?WkszUGRGbDVSditoNHExREpzakRGb2lYOXE0OHhCSmpxTVBzeGo5TS8xbjhF?=
 =?utf-8?B?VFBaa3BJZEtwTisxOUtua3RiNlhSZUhKUUQzREN2SDh3cE9KUWZBMk9sbDN6?=
 =?utf-8?B?U0tIY2dQQzNvdFFpNjhtVmVQbjlqQzNKdjFuMzVoL3d6RFNKU3JaTk1wZzJh?=
 =?utf-8?B?T3hYNTJHa3JxbjFjUDRuQW9TWDJ3RjJIRjk3dFNWTWlkNHNnTUdvN2RpSDZQ?=
 =?utf-8?B?VldrZUFlVFJ4dGJRWURGRW1EVTgrNGFvanlMUWRSZ0F2SmNGMnFGQUViRTgr?=
 =?utf-8?B?STIzb1hPSDBrYWpoOFFlQmdKd1JzOTJaUTBSeHV2cWdmR3k5K0NadGkrNktR?=
 =?utf-8?B?OHpJMDRvci9peXgvcTVXWVJmYUFoWkFKeDFMSW1GUEFGZmFCMncwV292eisv?=
 =?utf-8?B?R0h4QlVFQmJrYk5GODZNbUY0MlhLZHdrV2tHa2NmTFJnWjB6MTYzaWdBazlJ?=
 =?utf-8?B?OGdUUmdOZXJVVVVjNVJPQXpjUDNsR0ErQzI1L2lMRFZqK2JMaE83SU1tbDEw?=
 =?utf-8?B?OGxqbjdzMzdGWTBSb3VWTUE2ellkdjVuUTB5WGlhck9JRHd5SWZobnU3OGdk?=
 =?utf-8?B?WHdWTEJyKzhvYzM1YjFDTlRNN1JXTFVJbmxXTWhjYzB4ZHVJa0VoNzhCV1E5?=
 =?utf-8?B?cGNlNm1wdWdCMXdyamNybGxaWHdWNkhUTnBuSFVLNGNyNzZsbXM5NzRZMEp5?=
 =?utf-8?B?Qm82OHdHdlR3aDRObnlwSmdDZUFSMXl4K2JYd0U4d1hKemlJZVdQYjIyWWdH?=
 =?utf-8?B?QjA2ZXRSMjFwamIvblM4RkljRXY4ZmhyYUF2MGM1MG50VHJwT2l4TDBLUmZ1?=
 =?utf-8?B?WUdjRlYyZHJSeWVNZ1pXZWNmaVhNVkU1Yk1uME1BZ2ZKd0tsVHFqZ0Qwa0lo?=
 =?utf-8?B?N2ZDWFhHNE1Dc3U5aFJTblgvNGJvNG85SEwwSTZPTjFpRUt2dGZKSU0zTlFw?=
 =?utf-8?B?K3ZGNW1BVzJLMU5oVUdJbnU1YVlqUUdQaUpKT2k5UkxEWE1wS3JMcERlTzFT?=
 =?utf-8?B?UnNiK2V2d3FIanhYS2xkSWw0UCtSMW43a04vMHcvRTg4L216VWhGb0pmTkdr?=
 =?utf-8?B?d0l1OXBiMzlhR0R6dDYxV3cxQUEzcmo2WFdKSGUwcUVCdzRld1lmdXB3b3J4?=
 =?utf-8?B?eU9lemRIL21OUUF0K0pvdjU2ZU5JbU1wWWRKNWNGdHNZbFFpYmtLdG1ndDIw?=
 =?utf-8?B?cm50cUcvQnlSQWR0WEUyK0xyQ1RBcWRnNEV2blpwRHVOQ0NMeFNxT0JFVy9P?=
 =?utf-8?B?MHBUd1hSbE9XR1FNMHliTzZqOUtsZzk3NVNyK3JFV1drdndHaDRRVUpQQ1ZQ?=
 =?utf-8?B?UnZUbUhJY3hwSnR6ZSttZGtxaUp0d2hKY3lHMDN3NlR6eHByVW90OC9DbTRI?=
 =?utf-8?B?NVh0K2g3bDlHMTh0THZtYkliTXBocE1DK3BzeE83N2IzUmRPLzNJbFp2cGJW?=
 =?utf-8?B?UVVRRGlqcldla3lRalM5bFlMUlpRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e93f97-a4f7-4a2f-cfbf-08ddbb0487b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:28.8902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMOaQKt5Xj2WgCQXeXeV35XV+ihNRgulFGAdw7yCSk4VHNjOSivTsqxrCr+Kup1c1FnuDqIg+/eImC7m3Hbvoyxn6bK6p3dvLu1I5R2O1vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Proofpoint-GUID: bFaCqECmJghyy1Il24pEjk4RXXR_cyV8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX4ZfA8V2ZnwmN
 cTZYstUJvIME2sAa/ZzJEQCpopIy4uGe/Ig15glYsgm/RPJU84engMmwio0vkcxjja2IsxFuwgz
 vGE8WlSgk1X28aYl5Oz6sRKeIwi6c1F/e2cPknQVpBmX8UHmPGWuL1c/wh2nmmx1a5zeNh6j7Iz
 2Xq6sw7iTRrBwh2BfdLdVD98lPYjBbbZlvpLoH+BFzwjzFZBtwxQpu3mgZhvDltPjmZYN94NzLw
 MlZfhOA70tsWXFZt4RxtJU9lYvgPhpbMzvtf5DxQmuxfg7AZT//B/0OlWyyv5bt3/c1JIftZsiS
 KQd6aCpi0zU7ZF1f3sNjhtCf4B1/mMvDz9OV/PAeG8zIWRMjaS3qSiR42RW29M6XT7Zs16LG8l0
 BLTOAHolX/dEIuO5w+kHClpqz+8deigl+uOQ68P4ZdPBz9Qpc4Dp3HMYe/G33jx9Y8wnXkGO
X-Proofpoint-ORIG-GUID: bFaCqECmJghyy1Il24pEjk4RXXR_cyV8
X-Authority-Analysis: v=2.4 cv=V7190fni c=1 sm=1 tr=0 ts=6867e0d8 cx=c_pps
 a=azKGx87FDiaoMypZd7Lp/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=EScErfUSVzH1iicdKiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 67c52d79b2..fe53beb39b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,6 +418,87 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
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
@@ -430,7 +511,185 @@ static void pc_init_isa(MachineState *machine)
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


