Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD72F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bp-00048P-P8; Thu, 05 Mar 2026 05:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bn-000487-US
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:07 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bm-0007Sn-9B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHTzQdrqrpHXGXJTWEPGcN2uhwPJRrllVPC3hB7CyGpyXLOPLL4Cb1Tpondg8AtTBv0Y1Y6BNLVb760mgrnE0SvwwLiVGe3SRvraQI7meK3YU8qbL89tEiPU/BAXQA8iSlTKJvhCYetIHbKMtaP6OdYufiiTSkL2lbDRrYPjoA7SUhnkM1TSkbNKZQ8ElZmFoVVBqNAyv7cx9D7LuVSPkeUaXoBFkA0tyWA90uwVAvOP8SMtDHX9ovNUIYKM03qxFM8370AoPyxjYsKXVTRkUQf9Ll5rA4tOcyZNN6ThWxDlTphb6ju7zYqSZzvlIs8YcAsMlps/Mx6FoHO01HH65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOjK6YhwJ94VZK4T+jVI26G7yyZoxBwuS9BkoveV5L8=;
 b=IspHW/RGwmPH4c+9aTI059jBg6g7Akzkt4vz/pPfSQoxA47XZ8vvS4GN6ht+yVsYeYkGeMIIPLSePQ9Iq7t7MH5yR47QKksJ17K3sCn+agrxxM9UEgh8gW5Z0MLwjkIFEw0+bLmFTxbaOSHppluUX4tzM8cfmXAht0DFAnwr3xVeczrFy90jOLsUyUkPhoqdxjZRjxwV98JDZhhKueL23SzaZosfHT+iKAYLt+aGluovw8VHhLbl1/j+zYyQ2ZjjAns/mdf46kgMvxSJTVSBAbkFL2SDDm3ESoSwmmD+j3cUGaHsdusDdLSDX2NgzhEdrgjKPsIsLdzFseHIbcX3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOjK6YhwJ94VZK4T+jVI26G7yyZoxBwuS9BkoveV5L8=;
 b=fhOc8tUB8bEcqtgizDzuS3d9gVyGsoAFTuXJIWC0YRiflnKuA1FrG+xBBSDaFhJIiUqMuQOHalI10BQD27SjFiS+sT4uOeMytYdD31r/NoFVDVNt1QkhvX180Dfhmfa97/KpurbLexVXQZJWsWc3733SX5bjf4DEEG6WMUKxblM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0807.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:46 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:46 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 8/8] tests/tcg/plugins: test register accesses
Date: Thu,  5 Mar 2026 11:06:06 +0100
Message-ID: <20260305-setpc-v5-v7-8-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3940;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=DsPVfVyCgkD6lMdW7JqG+hheJEMS9k5/3gWt+eljOH4=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTLv+U9hsgM23AqzV7Jw6tw8E8GE5Wvnh8NH
 XiOSoWtJ0iJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUywAKCRCW6ye6MV/H
 fIfbEADYX1KKS4gg4HCfRW/b6ETLG3iYa7V5OPAOjD+87A3FB+6QCJqMV39keltyttury0+iq++
 8Ua7ESdOlaAMZfyPBWFwE9VGSv93YUZ2Vl3GJaf4e4Qv0G1S8TwasVPTmb9KU1MgB3LE+I6pHK1
 yQQeV+SsUI6+IzUpYPrEqj12FM4X07cK87JC+rqBmGY7dEm+RalGfDE3dNJ8D94TSQoQR0zqzxD
 8CPZ6WBjz28OOpGDGae6upcbXhawErQbpmERDCE2SXzNQdrC52t1ExXkM5QHub1Y1KlWgzvmHVV
 thv2aP+uyna0Eky7/r4UwcAVqw76T3Zsvhm1rLlDQN2S66wxcsS7XVGvfCGTwtozur8VSdK+CjM
 puRjbfXflZ6EG8FtlrliLpfUHw19OAM9hT0PCwfeoS6tRBluHp2O5JL5JzW+gFetHb3yS+gb04q
 uziZ0CIZA3SY+FXaFBTJ2NnVZJ+/jfL/JoZ+objqhUhrt6X4GVUcK5auE+D/zHfc0vYzDZEm4dR
 4B7kkyTTcsDf3KO7hgYKtjp/DeKy9ED+axHHyxTFsK4/z3/HzFELeD6sFbwoU/QnJ3jP1b6EFTY
 yV4W9CkZMHs1jW/JOziNeV6ajnUUT2wcNvj/sh45vSndbHAqc4rcxA4tkiB1cmSIEYIjVp4flZ3
 8ULsVSVn9dco73w==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0807:EE_
X-MS-Office365-Filtering-Correlation-Id: f18d8647-20ee-46fd-4939-08de7a9ee88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|786006|19092799006; 
X-Microsoft-Antispam-Message-Info: WHwGmB4e4G0IMPadM3ltjhpEL4bG4Ss2H1Rec+4zeoOlyYchwytIJ5VrITqHjXM0vPfi4RRiHUH2WfGwbJS7108nMV6CDo9bNLXd1kQYkpSktw7SMhVA5ocZuTk6lk0O4cUaMAwSynlZ71k0kaMVSYvGv7oVm+ef/uHFyyiQ86jeY/n7QOcjrBXS73X2rYWtiTe6h3o1AXC3kSIY0TNZ6f7GC1ghG5KOnVB/p8b9MpXpJt4GMD1xTbQ+QvE29HGvc+VsOJFgpudwBBAD3mIu1LjU+S0Qi++7RayKSzoFPTPBLJ8vAl+cu8+PhcadimUS+xxsGr5YpBKwnfLDp+A/VHaBkb3BoURtZaUpLn6YrS0Ot9Vx/9dUp57gq6ozAINGgau7VT0uLxX6fCwSXQI2BeC2P0cD6Ae6n3dWDjSwqYRi0ZSpXoymMhzY3wHU/+8Ugb/sojxk80p2/R1o8nwxYWjI0nRDt/0O1HOkf8qW3/J6hIIuO7oiXh1GbAsctpWueXSssAnlX+F2UchSSZmppm2a3Hi79K4PW0JOnt8KUik3cLjXLSplCgPdvyRDUOPG2quRbBlGsM/ru1rHYvuIrSbLKNC0qF6YfkI8mvwDygPy0VC284nThGcoznledfq9A3m9mRIlJNswHov5yFTw6h5lUyltD1x2Pc2O+Q9eg+vWNb0VTBteVdXVdZ0nGzJV8U+hDcyzCZWeIEIUgOlOODIo1KubtQf9nypJE0sV3GI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(786006)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW4xWGoyYnc0RVNRY3J2ZHhGSFQ5aEVBRjA4RlpucEkrbXI2aXU2eTRaVk1x?=
 =?utf-8?B?MFRZNmZYckFPVGdoS2lBOU4yd2hBeThQSThuTTdtTTBISVJ4WjhLNmh3NGVh?=
 =?utf-8?B?VitNL0lXZ1NybzRCdVd0dU04eGZPbGVoZUNoSW9tSnFQWXdNdlVIdytKM0pS?=
 =?utf-8?B?bXhsK0lLejQva1pPTk9lZGROamYxako2TG43cTBQWU1NdkErakNLdUtXMUVE?=
 =?utf-8?B?NUoxNDNZR3RrbTRvQ1FqcUVPdWVwS1JHME51cmZpeU1HUERnWi9mZXRhWWFL?=
 =?utf-8?B?eDVqelRZSHVPS1FXZndYbDJtTktWZTh6OC80QklEUEpZR0JCZWNwZjJHeUxa?=
 =?utf-8?B?a2V3aGZLY2FsTHlXRzhKZlZENlRmMzEzQks2VUtORzdFbzhvVUZIYyt1SitR?=
 =?utf-8?B?RlVUWWxpZGhaVTJUeWl3NWY5dHI1RVlIN0xMT0JWUkI3MlRYWGljdE5YVk15?=
 =?utf-8?B?WHhZV0doSzkzV0g1QUNKK2VhcTUzRmlvSVFVK05GQ3plMzMrTWQxQkRMakdQ?=
 =?utf-8?B?TmhjWHFMQ0xhVHZXZmRwVnFiV1FJQnI0QkJLNElxam5VV1RReFRaalliUWt1?=
 =?utf-8?B?RG03SEJhYUJHQUZ1Vm5tUkhFb3NxRXBLU3RDajBtVUJwUzhza1M2NWowb2V4?=
 =?utf-8?B?RDVwN1Zna3ZZeCtSRGYzRUROdVVKTWVibFc5c0JCNVNhUFZxcE5leTFlZFhS?=
 =?utf-8?B?UllTVzVCTTZ4VDZuRDNQMkJyZHdkSzBoWFN4U1gxOERHSjNQQVNKVitmWnEw?=
 =?utf-8?B?MjlRMjBrd0tZWWJBTHF0akJJZFNqVmdsMmFrNHlaYmtNZkFucHAwWkxvc1h4?=
 =?utf-8?B?VitvYURObmhSM0U3TEhZdElRUklGZEIza2RlRHFnK0FCdW96bWhZUVFQQUpx?=
 =?utf-8?B?aXNOdFRyYVpzSnYvYXBNMi91LzdKM0lmZTVnZmtBWlJIN2s1U2JXVUYybXI0?=
 =?utf-8?B?NUNiQVg0a1F1Wit4MlJua1c3dFRpMmw3NWZ0S1IwRE9MMmFlTkVpNENKZEt4?=
 =?utf-8?B?bkQvNXo0U3VxNCttYmR6QlhNTlNRMDlBM1ZPRWVlN0pQK0tuclV6Y0Q2Z0hO?=
 =?utf-8?B?VnFsWFRJVVFqZWFESmk1UUluU1NFZDF2M2Jxbi9jTXFSSDlZNWZZM2s5blVm?=
 =?utf-8?B?czZCdTVDQWhhNHRRNGhkMHRhYmNNVnIydzc5MVVlODBKMzFPRzFuYkVHTzhy?=
 =?utf-8?B?WEQ0d25iUU5sZTlPQjQzeWQ2cHJEbkdZbVJMdUx1YkJBejArQk9pNFA5MjhD?=
 =?utf-8?B?K09ROWpaRHcrWHI0bmhydVQxZXBwRjNhNFZLOHF2ME51YlZ4Nko4K3gzRkNF?=
 =?utf-8?B?T1FsRm9qSVY0UVlNczhBUjRIT2pWYm9DTzRWaFM3WHFUZlRMQWVRTng3Ykt1?=
 =?utf-8?B?Q2RSWkVJcXpjcU5IWW9rbmRXRTRtaEJpQVVlSGdXVUQ3clFNaWc2YkUyWFJv?=
 =?utf-8?B?ckJaWHFkY3ZyVjlOWmx1K1hSUENpVXgwTXAzb3QwdnJsOE1VdDB5aG5XcUdI?=
 =?utf-8?B?ZEJQdXp6WG1PUEUxR1VCL2lraUN4YkMzREV0VUQyYmtKMmx6WlYzUkpma1pp?=
 =?utf-8?B?eG9ieE1ZVmFNSXNXdWczbmkzSTFBUGJMSW1BSW1XN3dtVnBwM1lYRUh0aUp0?=
 =?utf-8?B?dXhsK2paZFE2UE1rbVNWWWlhbmpKL0hUajN5TjU2MEUxdmtlRG9oRVNyZ1J5?=
 =?utf-8?B?NzdFV3VmN3pJS2tHY0k5OWt2eDFVMmJFRzh2ZHJxeW40WnVqQngzTTI1R1hk?=
 =?utf-8?B?Ni9PL0tzSUljdHR4dktpNkcrY2MrVlFpRm1iWkhQMjhHVzFUTkVzT2hrQTgz?=
 =?utf-8?B?RFB3dWRMNkhWTWlsVnhTOFh0NVB6aURPZ1ZpeEd5VE5qdEZZbXRmSUZTRnIv?=
 =?utf-8?B?QW10dE9wc3dDa3JzZE5YZFFpcnljK0RLRGVnZ1ovRmtKSGNFZG1vaVVPdkcz?=
 =?utf-8?B?Zk5WZnlEM0JZRDFqK1RvYjd4djgyN0hCaEs1a25GdzRXTnNqN0ZhVXBOVXgy?=
 =?utf-8?B?NmMwTE1ybUhxMlBvT2hYYTY3Q0daTDRpaEN0dElKMEJYUW93NnRtZ21WQ0xj?=
 =?utf-8?B?cGJNdFJ2QXZIdzdQTVB4dVBUcXQ1bWhkbjhzRDdLbUZlTDhLVlVKUUVJVXVK?=
 =?utf-8?B?TVNCT0NMa0JkUmpyRlZ6b0F2alkvN1pwcDBRTTBPODEzYUpaa2gvbnpHekhN?=
 =?utf-8?B?MmJSRnBLT2hmTFFyajBRa0ZnclpzdVc0b1dxNUNZMVY3SVBqMDdHdmZNMjdV?=
 =?utf-8?B?M1MwWVFvK2QyN2E1OFhrYndhaWtmazlPQ2NzWE9MVGxOYllPV05Yd2hGQXBO?=
 =?utf-8?B?Y2NMY1ozK1RoVHJTZkVDQm5Bb1BZTUpHR1ZqQzZ4NGRyYnRoZ1lJNy84Y0N3?=
 =?utf-8?Q?qy9xxXdd75uHPdsw=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d8647-20ee-46fd-4939-08de7a9ee88d
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:45.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mmcp4qq4rTwY4mIOYWI3qNNrlFUMRNM3ohrl0cOyZX2vVlrOblwKY/zTSIwNtCVN4vnfAa6AwMlmToyeROhlHNuXjaHehs8jscc/iUYxA5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0807
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The additional plugin tests register accesses, specifically both for
read-only and read-write registers. Writing to a read-only register is
currently not tested, as this would trigger an assertion and fail the
test.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/plugins/meson.build |  1 +
 tests/tcg/plugins/registers.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index b3e3a9a6d0..d7f8f0ae0a 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -6,6 +6,7 @@ test_plugins = [
 'insn.c',
 'mem.c',
 'patch.c',
+'registers.c',
 'reset.c',
 'setpc.c',
 'syscall.c',
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 0000000000..6d627c7037
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,79 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This plugin tests whether we can read and write registers via the plugin
+ * API. We try to just read/write a single register, as some architectures have
+ * registers that cannot be written to, which would fail the test.
+ * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_assert(regs != NULL);
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    qemu_plugin_reg_descriptor *reg_desc = NULL;
+    bool success = false;
+
+    /* Make sure we can read and write a register not marked as readonly */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            success = qemu_plugin_write_register(reg_desc->handle, buf);
+            g_assert(success);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+
+    /*
+     * Check whether we can still read a read-only register. On each
+     * architecture, at least the PC should be read-only because it's only
+     * supposed to be modified via the qemu_plugin_set_pc() function.
+     */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+    /*
+     * Note: we currently do not test whether the read-only register can be
+     * written to, because doing so would throw an assert in the plugin API.
+     */
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}

-- 
2.53.0


