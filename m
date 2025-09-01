Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBEZ-0008Kr-CU; Mon, 01 Sep 2025 16:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1utBEN-0008Jf-9l
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:34:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1utBEK-00012E-UW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:34:23 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 581ANIHU3259095; Mon, 1 Sep 2025 13:34:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=QazEIIu/4ub9M
 e+N7eNmqeNMnulSRDqrrNwdsWRRd+Q=; b=bnBHDJmrwSTBySM2laYtoDKPNy4t5
 HrIJXqEOaIXsUYmM9PGOBx4/uG9wj30+tf736Wj+WPwN3HX0C1jKPEy6U6lcHhBK
 V6PPXVzuVHgUP3JFfKMnRLOvmZQXr8hcR9YDe1CQECR/ymRkx/fiurry5PwxzpMZ
 mR85QTiOrxQm+N1xzkksuzvldreGL0nu8j0opZGztUXun4GSqTU4BhW4wlNqCuGH
 KNFVfICY2gnHnwxqjLDkzIqDtg+u1Ihspd/GQ5Zjv1RH7zM+el8ndr2rzhoLQpEE
 6ZfnQ3rFtvPWgME6kUE1HLWwrovMOaaEOSN7I4ID/1tNKmLH6PqLPs4EA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48uw73c1yn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 13:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlFqAilfXrAPvTTY7j9W1WCRNOXxM+CWNq2j0uMi86KaeV0OJTYRxz1jgLP3yNp5q2oQs990lbcM43+DxG/y0/4g1yUMuLgoaiGsOr4lObU9h6fclKlcEJrSzCn+FQA/JrxIARDYCMT8kP93beYBaAGAtHmMSYeqjLdkrYmZ5lG9mj2+rZHWstPQxy0DOo1L2VH63rU/GatcDyv7zSi+R8THWT6auaJ4oDmCEMcv1xsUkaMC8WcQJtWwCsFJY3r8DU5l8ZEHZ76GH/Z+vjCZ3s4NV+17BkdvIsilkdzSWzDbWHpvvie/F54LULXrzY/+34SmXlLBCVkjcooQL2Ergw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QazEIIu/4ub9Me+N7eNmqeNMnulSRDqrrNwdsWRRd+Q=;
 b=BdITMwq2tbMxXOe2FZe8d5I9X+cbojzKaZHCC6tufqXLVUCisFw1TAVPdRA846QcOC1tILpbELqQz7bJy2B81TG9/MVLn8Qgo8sTEp3p3b65hUfcg0ppazNkNruQqfX0C8WNrax9vC4GcKrYUBytjaYUVkCs5fsTYOIU7XUHjiaECtf+XDJM0nuuPg62eFESe4mMbn4KkafNeTGOE5E43/NVG7OhrcRii6vRLS0Ez8tZL9leceVBARTWQIPc3UgSnDNGcrRqO9omrcqIJ7iyhBIz/VQvYQaLBXy5sRd2Vuhil1FM3wD9p0AfECI9s7J2kpsEXM3UGFrGcLTLRWkQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QazEIIu/4ub9Me+N7eNmqeNMnulSRDqrrNwdsWRRd+Q=;
 b=PCoq+AFv1rqBSX2TaLVPlPvaxufKaVxq4xlKBYjg4V629e7Bl2JRnb2i57jP5fZE1az0GOxtZ66t0hF6Zr02x6uRL61y0PJT+Jsd2arqeAIQ/KWYcsgv1JroWzpAS1e5TgOUXY4d6822J6sMZZ25BzJV1vEZmOx3fzBr03dQzoI4jD22Yx+R1qY5CFY2UelcYzuCo9BG5sUHRgspVophtRu7e7bBKlJTkxUjeTdx91NDUpDEpjNF0OFqmJlxsLL3lIS0ILrsuOd1qWoGMMEOT4LF1IvMKuEHyydgLa7RXTzgHaK/avn/ZmLQZLkqzEwUkplJkF8J47kkagOgLeDKGQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8298.namprd02.prod.outlook.com (2603:10b6:208:345::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 1 Sep
 2025 20:34:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.027; Mon, 1 Sep 2025
 20:34:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: armbru@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
Date: Mon,  1 Sep 2025 21:31:58 +0100
Message-ID: <20250901203409.1196620-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e87f97-216a-40cc-fdf2-08dde996e975
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3pUQmoxR1RYU2dGUVlCSHM1L3lmK2lBV1JDSytSdGRLejhjVXlMMjJCV2lj?=
 =?utf-8?B?N1cyNUl2TkZJKzJQWGlBM245cHprWndDNS9iNkJVeGtrTGFpdGpTVlNjT1Mv?=
 =?utf-8?B?WDRmTzgyL1BESnVhRDMyemZnMmMxaE56alRtU2JmLzVoR1JmMklLa0VWVG5m?=
 =?utf-8?B?RkJoYWQ0bFZjLzZhMjNTSEZ1M2ZuWXoxZEJwTEtZQUpmZFBTUlRVL1l3VklG?=
 =?utf-8?B?ZVAwaHVENjk5Y0JHeUREVi9acDlGUFAwMlliYzlZVzhKTEtTWnFQcG01bHZT?=
 =?utf-8?B?OEl1dzVWZytEeTloR045dUd0bHYwdklDanIxbUhtUVJ5T1NmVGZMWnhxTG9o?=
 =?utf-8?B?WWd5SDJJdFJjZE1qL0p6eEhJSjhtelJiYjU2UVp6Z3BNZ1NTZ0ZYb0tSUjla?=
 =?utf-8?B?MDgrREhzQmdtYTlBWjduL25HRkhaMWNEOEd5ZDhKTFpzWHNZcG42OFYyeUVw?=
 =?utf-8?B?cTNHSWt3WklISnVQUE9TOXk2SjFtUWpjYUtBaVdEUXZ5Y2gzZXhxTlpmQkxw?=
 =?utf-8?B?eHBGRVBOVUMwWVVMaHJhWnVwMzhid3Y1ayt1YkQ0bkxadW8zU1hCYURTMkRR?=
 =?utf-8?B?ZXpjSzNOQ0JPakxXOVdrb3RUdTZKYmM4aDVjUGxoSlJ0bXhFK0JCM3UxejY1?=
 =?utf-8?B?YVN6QlFmSXJ4Yy9FeWNEc0hJajdCT0MzVHVJSnVuRCtWZHJheERiUjh4UGtx?=
 =?utf-8?B?M2RlYTd1OEtIaHkvcEtBRld3dlZsQW5TRVlOc0NVeUZPOXNnR2s4aURVd2xC?=
 =?utf-8?B?dkFLVEM5cGJ6Z3NxNHdERjZ5UFJXS1FOeWZobFFDTkpxZTlOUVB4dDQ2ZmUx?=
 =?utf-8?B?RXhtcHNkLy8wcWpQNW1ZZDJQdndXK011OXNRUUZrSGVDOVVwRTEvbytjMCs5?=
 =?utf-8?B?b3JFdGd4YUVXMUVLQUROME1xOEFGSFpJaVNBMjBSVmxuU015eXVBUFFHclhn?=
 =?utf-8?B?MVNSMFg3YTJSQlhMR0ZPcUhRMDE1WEg1bXdYVDdLQmdFTDFOaVNSSE5qMWZv?=
 =?utf-8?B?N0ZvenBXQzJjaFNVMmQ2YVEzYUJBYTRqdkZmbVNEcUo5MGIxUjlWN08ydW5y?=
 =?utf-8?B?U3liUkNIQVhqc3lRNzVSTjY5cXUzRnp6aDdoKzU5UWIwY2N2MGNqVmFmd1dz?=
 =?utf-8?B?UW56K3ZTbFJpUnBQbEx4bkFFbnJSaEVkWHI5SHBJU0dYVTRRWDNMeUZqYzl6?=
 =?utf-8?B?a2ZiTS9uTlRLMWtBQjRxYUJxVDhxdGdSdXpGSFJrNWQyd0Fpb1FRS0FFOEdz?=
 =?utf-8?B?UVYyckVCM3A0dmJaYlRoMmZqRVk1Q1J0R2s0ZHpBaEFjYUZ0U0JReEN2Y3pO?=
 =?utf-8?B?U3RYbnBpSVVhdThDbmI4MCt1WEVhSmpBcGtNNU5DSjBHYVJEUWYwQlFqQ2xS?=
 =?utf-8?B?aTgyNFFVTkxWUG1KMGdlOUtHYkZtTTIwdk9PZDVKWDhRZStxQUlidk1jOERW?=
 =?utf-8?B?Visvd1VwOHJtaDhGZXJxajlESm5TamxaN21SL2xPT0NlbFltSzlqNCtWaEg4?=
 =?utf-8?B?bzZGTnI5TnlPY3lNQWQ4dUloMjgwRVdFSlhlUm04OXY4T1ZNSU9BTk42dFIz?=
 =?utf-8?B?VzdtaVFkd2Q2S2xMa3J4bVRITFNKK0hxc211Q0MwYmxYc3pJUkc5WC9sa2d4?=
 =?utf-8?B?K3NvM2Jwb3A3V0ZlYW9naU9KQlM2SkJJV21LUlY5Tko5NHdTdVlEcFhrZVhk?=
 =?utf-8?B?QnBwa1M5bHVLUFYwekRyclZUR3g0UVp0QW5yTTdJajVYbnNwU2pwbmtDc1Vr?=
 =?utf-8?B?c0owd3FuVld4eGtqU2pQRjc5cTZZaWJLYm1yREU1SXVjdTFTbUhJSkZ1ek1P?=
 =?utf-8?B?eWZrckJTNjNNVjVWREdQeWRhb0pYbzlHTG1ubUFsRSsxNUV5Qmd3ZGRqWGZy?=
 =?utf-8?B?TGNLN0xCblVCdVZzU3JlaW9OaTFFSHhLZkVwejdFWkVvVzRPemxwWnc2Rlhu?=
 =?utf-8?Q?ofWbsl3eQ4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRwT1BEZU5PRFU2TE15S3NhQ01BMnkreG5iaExLL2g1c0l4bThLZmhaK2JS?=
 =?utf-8?B?RlFpUnBjTjB5MnRWQ2U4NVhtWlBDNmtxaWJLdjBuYjdsNFNuVitxaTNhVE53?=
 =?utf-8?B?Q0lMZUpzd0hKb1Nkd3JpNC9yN2JSYzRLczAvT2pxTlpNKzY0VjJIRjVyay9O?=
 =?utf-8?B?UEF2eEtEbTFTSjVyWSthTHY5VW5VMlo2MHIzQlpjVWlPZmpRcktTb3lnd0JF?=
 =?utf-8?B?L1BsUzY3TzZ3Skg1Vyt6TkIrc1ZubFUvcmo4MVJaWlYrek5mOGRPYnoxaFJ5?=
 =?utf-8?B?cEcrTHVvRzA3SHpXVVl3RmJWUWRRZWJvZ1VDOTFJV3J2dzc2UFN3TFZVbGJq?=
 =?utf-8?B?N2lIOXZ2bFNUb0cra2ZjRFRseUE1WGd4aVRzcFc3c2RpNUtxYkNjOTVlRGNq?=
 =?utf-8?B?NTV0TmNCUkFwWTFhYzlPNVNhL21FeStEdnRjRGpSZ1V3Rko2U0dDK3phSHZ4?=
 =?utf-8?B?NnFDQWdJQUNOMkROczFmMWV1MUk2OXY0NXNadlRyOU93YzdaRzhVZ2d1ZEZp?=
 =?utf-8?B?TFJaZVBoeGlod28vSVdjSFZ5WHNKam11WUlFaTVZcEpXZk9mNC9VMWNVY3Uv?=
 =?utf-8?B?cTR4dG9zcTJ5NzVOblFOalI3MXBVRUhBSVBuZWFnTXlCcHVuOEd1RUxlb0Fo?=
 =?utf-8?B?cjZVNWdwMHpjTmxQY3dLMUpZSkd0TEI1NE9NazZmeEpVSXZ0N3cySDQzY1Mw?=
 =?utf-8?B?U0UwQmFmWnVKOWtEQXRNbmlTa0t6NWZCbllaa2lhN3VaUXFpQzYwV2NkaFQy?=
 =?utf-8?B?QjNDV2Yva2t2cnIrVlRyZzcwbnEvSGhVZzJXV0tTYnFTUHE2MTVVYmpTdEVS?=
 =?utf-8?B?T2M3MWs5QUlDRkJCakgwZkZGb2I0YUx1cnJINTE0M2xnYVZGSGRnSUxHbSt6?=
 =?utf-8?B?UWJSY3p0RHFMS0YzOEJXcFc4d2ZEeVNkOXVoejViS0hvZVIrWXRkV1RpZGJr?=
 =?utf-8?B?UHJWS29OMjI3TVB0TUxNb2xxWEtOQklRUlJGelZkajVuSDVRQUtPbkVpM1M5?=
 =?utf-8?B?TWY2YWdSazNSWW5EMFdUOHNhMkc4U09DTW1GVmRIWm9PODZxVFBwTlZScDA0?=
 =?utf-8?B?WW15L2JQeDMycFowU1dHYXNEaTVtRlVwZ014dHdabEMvN0xKZVNTTlFRNnc2?=
 =?utf-8?B?aThpcWVCbWFQcFBCSE91L3JpZHN0Q0dMeVdHeGt2eDlhYk4rM2RHbzc0aVZI?=
 =?utf-8?B?ejBrTU9wN3FCeC81K3ZoZ2VxSEhrOUxzOEJyeVlGR3hXT2M5bmg4MkVkaXRl?=
 =?utf-8?B?ZkJwZW0vSVlIdkxrOFNXTmJhUzFTU1NpZFE0WFFoK1Vvek9uNmNhYnhweEU2?=
 =?utf-8?B?ODZvL1RJWnlVcThRcUhCVnlUQ1RtcDVPNGN1RjI4Tkx2VW01M2p4R0x4WHhJ?=
 =?utf-8?B?UmVUZEgxd1lZZGpBT0pLOG5FUmNXUzBYemVlc05wK2tTeVZZVTNUbzEybENQ?=
 =?utf-8?B?ZzlzV0NVZFhFSXJZa3N4bTFaamN1aW1QTTQvbTdXU1BQaFRaOVNvYjVwSito?=
 =?utf-8?B?RHRZOVRUcVhSWlN6akd1ZzBUdVpyc1RPcnBjTlJSa2tKTTBaNUlTOU52RnpW?=
 =?utf-8?B?OEd4M0xOYXl1dHdGb1ZHSkViQVBEdkhpUHNLaEhJdE8ycHpIdFhydWR2TXVk?=
 =?utf-8?B?V1A5VnFjanJnNUlFTzRGd3o2MUZ0YXZWSTI1cExnczJpNnVzeS8raUNvbGFD?=
 =?utf-8?B?UjNQbk9KbmJVbG16aUJkWis0NXRzZEM2SjFkZHl0TFVtTm1heEdPZXd6OFls?=
 =?utf-8?B?Y081U2Jya3piKzhJN2ZsU1FHVkNxT0tTUEhYeGtlSTNVWHpoM0cxUlhhekNj?=
 =?utf-8?B?SC9zcE5qWFdPRXZybnN5ZDB2TW1WNGJ1U2VGam9IcFkxWDVSUXVUTGl6dzJQ?=
 =?utf-8?B?UUpCc3hBS0hsOUMydjNFU3Vqdm5jRm9nNGZnTmxIbm5rcForSWtidytFaUM1?=
 =?utf-8?B?c3RzUGZtWXROUkZnSE9TRlE0SVE2ZnVpZVZqT0JYanBGYU83SzBhNDV0dW1x?=
 =?utf-8?B?UEQ2K3lDYUNxTjFxQ0RUNmhLeGplQ05tcHhDZVl4L0JZNjFib2VzSi9LNGdK?=
 =?utf-8?B?UVYxcTZjZm9YQWZ2SE80U3ZtWGVBNHg2cXVEZ0FLN2FrK0pOT2VST2Q4TitY?=
 =?utf-8?B?dytyM2k1M2xEWHduZmJlbVA5RFltVHF4bHRBaDE0UmVSWHc3WldoUVFObTZG?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e87f97-216a-40cc-fdf2-08dde996e975
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 20:34:12.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbUjB+1RDt52JLWFAnUu/JZy8TIpUEbZ6aBXGNgZK9RaDlEjTXr8c5aGLnPmO3hs1b0EkhOrUXaI1wUoJZEwOg+nk12xdrLjvbwTHTCtLVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8298
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDIxNCBTYWx0ZWRfX+MJExo/po28O
 I6tPjNdG+ePwWlRiQAMbwa2y7WC9R3QjdOzGDSjqZJ2KnyyG5fBk4DMdDS+Eb8zyYdhc7laL+nl
 Hob9Byi50pHb863HU5vUAGQdP3GPBArUlYG9Z97UmW29ScXKCHn6eOAusjo+oaeUS4ctHPBxuJJ
 A9C9WMAUbVERiPLvhBRdCl0SFYZVR6L0GA6hmNDpn4oSAWJK9UCaAMSozwg1W+6Zrrtovmhbw23
 2iV7VhhZXICWqedaHY2JHqPDkfFC2WuTNujxwTXfunLK7PQwqD2uuDrQiQShlGAxzvzM3i4wUU7
 g22DP9ecdfhQb1yzBCRbxQsfHOxI9o9l0ONBa5LzJfLOCPjYy2vrK8r8Sio8DA=
X-Authority-Analysis: v=2.4 cv=e4cGSbp/ c=1 sm=1 tr=0 ts=68b60346 cx=c_pps
 a=QkMd9A5hkDPJHF1mgsh70Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XtCmkCBAeyUS8WWN5DAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4dA-lRCJcj3QBn1zephXzNFOilOynMBk
X-Proofpoint-GUID: 4dA-lRCJcj3QBn1zephXzNFOilOynMBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
(phb) object is now always set in pc_init1().

Since phb is now guaranteed not to be NULL, Coverity reports that the if()
statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
along with the phb NULL initialiser.

Coverity: CID 1620557
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

v3:
- Add Coverity tag suggested by Markus and tweak commit message
  accordingly

v2:
- Add R-B tags from Peter and Phil
- Remove phb NULL initialiser


diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7e78b6daa6..caf8bab68e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -106,7 +106,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
+    Object *phb;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
@@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
+    ioapic_init_gsi(gsi_state, phb);
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
-- 
2.43.0


