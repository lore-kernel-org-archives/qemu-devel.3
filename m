Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E7EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPUt-0007L5-SW; Tue, 03 Mar 2026 08:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUd-0007H4-K0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:56 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUa-0000JX-FF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKU7E0G3XQz4MHOT89k5ShDvtWCM1e2v4o2u5r3ads1eyR8b8lmSsehcLzUZjEAO2Z98PAK6vGJluzlFnUTKgsrVjYnuNxMkx+Sv10dmtyon+I00buAOJNM/gnERL77zpL4Frf35CzLufd1W/9We05tyK2ZC/EoIhyF/RWKQ6RsuKd1bhYH+I1fZ32uBL8JRc4AZ4z8efsUpyDZj0ZhqA+v7BpH2G9cz94K3Hm0WR6Fu3wLSWuu/1gEYIRnmIWMF5GW6nXT3UfG/eUJ0YwnqetiXIkdA+S82yhsmW02xtcoIJNsXcmaB5Mq7kSYf2NfFC5+2vkvY3SrnBkWuILvTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8aI2MFTQDgYL2F3AzjY5EZAlMdjTjeGrmFG9uE4hBc=;
 b=VQV+uSnY5h+hMvUSti8mnkosQ2tDBxlxIhbrKU5qCsSXmWpw0YG1WOZ64hDwou05/tZ6nJ7RfzUsxpgvHkH63t2ZfRdL83gS8mVjfUvOaN8pke/gRvr5V1kk1Lfg39guw33r7pkQPBjcIB1eIU6YaLNecOS1f8uPzq8OnvCUisS53YTIfcg/LWwi64NB9wS5OIyVV7HclIMSDgc20dLluU9T099AhCqjnx8FRXMQvW5ndvCJ+Iz8jRP9911LixBWwionSLwWpQB+D6QoI9DYebuaYx59RBEs3FqZeOSLX3eluTUdOe2+DgPwFpb4o3AJh57EjBGOIgovqG6ZG2dGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8aI2MFTQDgYL2F3AzjY5EZAlMdjTjeGrmFG9uE4hBc=;
 b=fGDYy7KqEN4PcdKFQu+hI1I4cvgnogeuH9O0bSevNVZS+Z4OXKnKXoKaCyuVFYCVIPupK6Ug/eNQLA94shxllnDUaoGEDLekimuqKm+Bw/ak0DaOA/Z8UwUqulH1TDKx3y+v5/rKxD6ojetIaIS6AEp7pp1w7juN4vjXbhluzts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB1207.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:48 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:47 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 6/7] plugins: prohibit writing to read-only registers
Date: Tue,  3 Mar 2026 14:07:32 +0100
Message-ID: <20260303-setpc-v5-v6-6-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=D+Zp3heOBNuaqnxs8ULmBdp32/BQih3GtGnFxKOJ+Uk=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1nQ9L48iNfYpi619T4ZNuUN1+tBvEWG9CBo
 L1xqtQmZyuJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9ZwAKCRCW6ye6MV/H
 fH40EAC/HQIgXxpbcpCn3ZLo6BBIh2TtaIHurFAI5WUvAGIdJcLcwdHXjxV9EPp5swDTO/ib8g/
 JQ8/W+JcYJ92ZeqCPqGk0o9fv/3bkmyGSXn0oUm9VzBEv6j+2ON6zd9LMDZNC2ySOhfVMQBMxej
 tKKAwKNPOwCdEhl/GRKkys96qaNVnMA07z8ztUsqa7YCeAcr+dJgONjGY1xTzWZXtNFkg28Gnkb
 LVMpjUEqyyyg66E1UBtGBZAKcY5EZlElt+6Qy3/8kGLtokFdngafZUPFloQnlo/K5T/qgieK/cR
 sBq+mkddSJNF1NMmxBmrjA0k7WB2OwAZPhjLMmZdyxkk1D+H7vqqYy3+EPPWpuEe1EpaDK+H5nz
 SMdsDiVJlkY/P4T4MGz/9uj+rYqqCrX2Yeh45nsCyWKddTir/EXJaNKu/Z3mty0lirqx2OCu7lb
 GYeyqYg09d7fAHKi8ovCjkNE8hQPjmlyitrsCjgWERXVWG/WZ2lA4SmdjWhnzWikHXmagHAUEQc
 WIu6b820NWcTKXdKZHIqeeHUzZaaKJ8gopbM2SoYWKBnH9tzIiXYX79ltV+/DfQykbnAdkaYsWs
 pVZtURklNNfiHBAra3yJsT+wwo/mxlZuCWULXcXVYgYvGQwSAXezPJby1KddyPIUq8o8rkV7ZTy
 9n67Y+BTS7uUkvQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB1207:EE_
X-MS-Office365-Filtering-Correlation-Id: 60385c05-7d2d-4e4d-b023-08de792600c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: A/0N/YYGrvgws3TP5hiYqV4u+4KmsdZnQmWdcll4/ot8KJq+YBtBlWxkUvxJhqrQP/2mArDYldvDcd9sOCe3SyKj1KEkiB7pZgeMsNx80CrzfG4DzuZSAIMW+CHqCaeOCtz8meWT9G7XUrn3TiVnIHRsDDHXeVrCTmm0ubSSJjbAJtQGYgb4dpbo/SWjUj2EIhZxKOtK3NL1YXBzqdOac8Dm8AfDGb/NwfVxusIrFNookeNjMkj4EdOFQyjWbIc8WHyeWU6exsRB/l8xmV3G8CZjG4khA7Sk1LtIDhX2b7wsJDEpxMjIJ1O+2V/p4OHAyuH/onfex44R1EwxCUNuNxTJGNmV14C8hdemvPccJTRnX1TNjtYVpDJQ9Q+CsxUVCC+XCJIBpg2kl1MdW3dI/2tvhaw5YZiUaoc0EAuVWenOkFGOpgnulnT9DVS4HnP193b4/lsGAK59+ASUau4Kl21EWCUApsP1I0+h/NZrHmZP8DrfDrlCiS7EqZzDkrtnTjzzhn+Z9A+vLB4HZ6kvRgKhf37gG25oyXPk9nDV8ZpGX3gCKhWC+/z9wi7On/G+i4FDEDhyn8WMlv2ie1dhofQhtc29N23/gO1YDzB7qUatAvT7J4oHPZ/sJENos7wqorcRYvWr2Tjzg4y5rQdrFluaBW7LfKtRvxQ6OY/kOI61qkgl71bTXr1HpxGfEDZ5i/ghc4PBZ56mFCUR1RJkjKFYFJkFiUBCRQPHhou3G4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktobUY4bWRKcFEyYUJGTWp6dUxyWjljbHVjZGVGTC9BYUpQUnBhcG0wc3R2?=
 =?utf-8?B?NEpxaWNDMHpoZFd4Z2xKNm5xRXVPRzhKS1NRYWZ5eHpqOGxvcHNrVS9YYnAv?=
 =?utf-8?B?QmZlMUJ1U21HMGRXZ2R6cTdlaFc2WHFxeXdRcWlmZDY2SFRoUVFiS2cyRkIr?=
 =?utf-8?B?T0FyT1BOdkFNbVFFOWk0Ymg0K3F3VU9qWjZZa2M3eXNoWHJ4RmtteDVHdXJy?=
 =?utf-8?B?TllNWG5SYnpFb0ZZR09oZEkrbEtrTkZIRHEwb0Y2eFU5Mjl5a0hlVEVUeEp3?=
 =?utf-8?B?cCtnT0t6SmEyLzNmVEt0UEx0UWZ1WkQ4ek5Fb0NJeG5ydlpUQUJvS3RTdUdi?=
 =?utf-8?B?dFRzTTk2UkV3a3JQT053OUhqaTM3aGRoeC9tSUtNZk1PMnFSSjgyRTl5eFdu?=
 =?utf-8?B?ckdMVHpPeVBPcWNDSmVYd2RFNEtkanI5bFV5YVppTGFXNUJHVUhHclVXMXBm?=
 =?utf-8?B?Yll6RzBFcmp1R0tOZlZHZmJXMjdvaitNUkhmUlQyMUc1SmZsWUh1QkRGNEtO?=
 =?utf-8?B?YkRmQ1ZtZFhkK3BRaHgwakxhRG40QnBmM0FFdElGeWhvRU52OHA4UmJjZHFo?=
 =?utf-8?B?VUx3UHBWUEJGM1FFbFVQNGp2SjBoL1U1L3NFS09qYzFXczhMeVgxQURaeWl2?=
 =?utf-8?B?bXZxOWtMdU8zRERybCtma1ZOMHlWaHRXY3VhS3BtY3RVV0JuYjdRZDc4Umtw?=
 =?utf-8?B?NnMxMitQR3FTM04wNEdGd2trOUZHdEhyNmNHc2lqcTh4VC9OZG4zTWEvelJs?=
 =?utf-8?B?RWdQRDdJcFUySW1ONW1GSFcxUU4yUE1CakZORExJM2N4Z0h2RS9DclJ0T3Ni?=
 =?utf-8?B?QU0wa3FkSHIrYXBoQjU5QkMwQm11MkFNQzBVNTBsOWpWVWR0K0J4Z3FldWdF?=
 =?utf-8?B?Q3dUbHNQRXQ0WC9rZlVEUmZoVDMrbkk4SmoxWTRZaldUT1hiTlhCT0tvVEM2?=
 =?utf-8?B?aDlRY2V1ZWJsWXFHM3dORzQ3Rk1zdHQ0TTNNa2UxS2lvcmRDajhpVGQ4VmNu?=
 =?utf-8?B?ak0zbFhUbFdaNDRuVktFbXJ6WWJtcTM5bDRKVGRJQWZVckhzK0xJM0dhWjQr?=
 =?utf-8?B?d2hERnE5a0U4ZzVqSHQ0eVBoRGZ2bWpPSnNScjRFeWFSS1RHZHZBSFlwdmt2?=
 =?utf-8?B?WHZhZ21vdElXQ1V0YmNzNC93eGlNMVZBYWkrdE5TWjBGZ0tLT0orcUp5R05X?=
 =?utf-8?B?SGtvQmRDTEJrYmR4NjRza1FCZXdNLzR2QS9Zbm1Sd2h1NW1oMFNzSjAwL0NV?=
 =?utf-8?B?dm1zWTJJbXM1c0hWMHV1Mzg2ZnhRTGlKRTdhbDBXTjJsMzlrZDhBNi95aFNh?=
 =?utf-8?B?MFRzNFljYjBEY2JqZE9LT282YkxSWkxtR0tYdll3aE1FWjZwMXlRR0UzZ1cw?=
 =?utf-8?B?cW45OW1IMmd4a2VheGZpdzJ4WnJQdEFSd2NhSlNKRHBZK0VPZmhCdU14TmJS?=
 =?utf-8?B?ckNGUFg3N3BBQkVjcGhNbzNPaVhsQWNEMUJtQ2I4Q0YyTjRwS2MzT3pEMG02?=
 =?utf-8?B?RWxmUmJXSkpJUmkxRGpRQi9zNVY3ZUh0bG8vc29FSVgyajVSMVl4Yll0WGJJ?=
 =?utf-8?B?bGpid09PSDhId1BuS3lDRFJnOHYrNEpMVi8wWCt2b1B6NGFtVUZCU3dSajRr?=
 =?utf-8?B?VEpWeExMYWpLaWQ5VjZtdnZSWmt6TERZRkQrUzJvVzlLVE01OTlycStQNlgz?=
 =?utf-8?B?ak03d2ZjWFBRT0h1bWtNY2UyMWRtZHdSeXd4SWd1OE1ncHBraUxkd21BeFVq?=
 =?utf-8?B?ZXYwd3FDckdjWGhPY3A1UnM3UVVVait1bjVobklQQWd5UU5nNy9Wb0FVa0hh?=
 =?utf-8?B?QitraE9udW84NFU5emxTWk10ZDBvSnIveFRlbDBJUmp3ZXF4aVhzdjlKb2xr?=
 =?utf-8?B?NUVGQWFNdEtBQVg1TDQ0NXpFTnRLWlJ0clJMQ25UMFpEYTdTVDBDUjVJMGdK?=
 =?utf-8?B?Y3BEd3J5MzhFZWlvc1hudDk1V09kSWpaS2NBUjRJNVdjSy9zeXhFQURQTFRO?=
 =?utf-8?B?bWdwUW5TbU1oUzk3ZzMyTncxeVVVWVEvNXhKS1RFTkZKQ0JoSlFLeXI0bVU1?=
 =?utf-8?B?UC9vL2JpTWxLQTJ6dnBCZ1hLaUR5Vm01aWQxZDFoOEdnakZLVmpSdUh0ZG9s?=
 =?utf-8?B?M21iUHp4MTZIcW9lR1Y1OU1xbnk1Q05ucVBHYlQ3NnUzeTVRQmZYelZrZkpC?=
 =?utf-8?B?YWJlV3EycW9OenBZSHArMU9lNENRaUZFS1g1V0lIQ3FxaEovNnl3bUIxcmx4?=
 =?utf-8?B?ZCtRbUVEakF4amhPWVdGOFZzWkVuNEMzN3JlSXR6b3VKbmthR3EzbFFZKzlW?=
 =?utf-8?B?ajIwM21wMG9EdXhCRVpMd2Y1ZDBOMkVoMEloNXoxTmtRU0g4a05nZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 60385c05-7d2d-4e4d-b023-08de792600c3
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:46.2921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36HGpBj6cCg6hYTy6SOQcg67IShv64XORj2ww7C6oUeo3j7P8qYY0mJcL9tlyyM9jELoRIjL4eEteIdHaxhB+GRmfmh2NK5nsIrtcfiuUOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1207
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 plugins/api.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 85b34949cb..0c348a789b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
     for (int i = 0; i < gdbstub_regs->len; i++) {
         GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
         qemu_plugin_reg_descriptor desc;
+        gint plugin_ro_bit = 0;
 
         /* skip "un-named" regs */
         if (!grd->name) {
@@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.is_readonly = false;
         if (g_strcmp0(desc.name, pc_str) == 0
@@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, rpc_str) == 0
            ) {
             desc.is_readonly = true;
+            plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -475,13 +477,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    /* Read-only property is encoded in least significant bit */
+    g_assert((GPOINTER_TO_INT(reg) & 1) == 0);
+
     if (buf->len == 0 ||
         (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)

-- 
2.53.0


