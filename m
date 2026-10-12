Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E08CA9EDE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHo-0008C3-V0; Mon, 12 Oct 2026 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGw-0007av-Io
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:46 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGu-0005Eh-UW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itJwss+35SXPmLNHCA1rZPUdPmQRIv0vS505K2UGzeYqhMAX2mUwvo/C1jSOQEmQfOdMEb7LvFYtB2yUrLsPZmWNUqzVwD42G1hC+Q+gka4ElqvsDPGj8Lx4IyI3Gx45OvRokrA432Q4tIbFnS0mYi6hqBZ1rKl3uV3j7l08M/kAi+RS0V8byweE9DTuHF/ellRdpfVpQiDYVXR3kWKCXr8ea3BDt6hkU58lVl2OoAW/ZM/nabbyIMsKE2SU8bLe4bRBIMtphJC5hbTdWsK4zN45bNaswuS9T5fTrJvJW22Norz7DTfFDziWT0Num0JY6LcfPaWXP7TdnvdQFzOn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=YHkdTqtbkU+wgjxVA4CCRMUL17zgrMMRYr13/+EPCz3BVIjFWx+Z2+Y+u6qdq4T5QbXh8ptE91SurQfNQfniq3m8aafxfqNWVzSoizB+HTUZSknmValPdc/Z4QjA0b5g88rkeNLrth0X+EF27rNDg1/34f4mU2tAXfbA7iFntb5bRPdqtXvOfqndotYhnzOOPbmlQrinepEPlWM+hCDwXNn+JYjX+n7E8a3JjYYhplFJ7SB8RdHtRr0+D7YpIqsD+tVrgp/wxiaXtAWwdFJAw7Pnzsmz54fjmfdko+wY9co/4kw9V8XFtJgIp/i6VwgSAiHa3E7SRhu2FHpCO+VI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=Ka+VCXMhuBZKVvpSVee/qw73h7KY7oOw615tLHVstNiSHSNzkxX+u0cip8pb1huc8NxQct950583+NsIBGPEgr2toACZ6IDKG0malkmL0cFW8GH6+Ie6OmvcIx1PkrG4QjjQzCAXiADKXVOJ0I5PzacbqsjOssMcXf+HB+0u47ckeXPDepBjC401HHEAAV07iVry325tXORl63t63xMA67q4VCnBi0j3v2ENMVc9eWwSvmNwFrnd7OC1y6sqxYFXUXseuW32JS35Q9sSSLIeYWrDfuIUzgFJTmpkfyVlbaIGXw43/LJG+K9U9Dh7+ahS9nGiIUK2v8TBDYi3/d1yNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:11 +0300
Subject: [PATCH v16 03/22] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-3-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: d1196289-81d2-4acc-88d4-08df284b9111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|3023799007|261009223027099003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: i2hc05KDodIfzskZT9Zbm6nL0tECm8rCWfwH84FeYVvdORSs8LL3p+S/q1y0RXgW3+dRPVANZnVB+AuWOND141uzkx1neTPxI3H2Lp0v9/JzgtNvsENi+POBczmkY12BM+wVZ2oW8q8ObLQG7b1ZwsqgEa2g/8moZ93y0jkCyVk275n9nO6vqVjsLm/p7HSXHvRdWJvEnogP3CM666m2Qdthqrn2ygdkT8EljZc3jrzVkXPKroldEVCSB0bmyvQ/CIod43fnfYqP+5I+0fsRsW4FvNAtZ9iljAejjUjo0NjcsH1LXFAQeSLKhEVqtiholb49fDpqImwS7eEooqQbFfYdLlIfvTmKodvOGCZrYEFlKY9gMmLkC3cK8r+dKCEC3hta1AIfogclhgTSkYiE1Bafkz4oE8dJ7NxGMqyL3wQ7FdZQnagChk0YlNWTpEWtGVxpuF1fekXVrypi7v7VbqT+60q1z62ImYW2eTTbIhprE16LJ1PyWqunzplsNVQnXCLyKHTUXxJtv/kSbVjpIqlzeW7+NwISC08V9J1G6FlYChj7RaRyiyVXTknQxWpY7+hJpxGUBNQ5pYanEiMZglp+S+szaAn5eCUxBc1g9z2EoWqV3GNKyGCRVSeFjYUMiCY57rc01LRjj89YMIpleIx08SwZMysx8+09OjbsY0LTbSyYUPiOHSBoOSPQgiFIRTZNsWs2FUfqPuvioRKomxI3ApXe1/QB2dKtKNtHnqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(5023799004)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JCeTAvY0tKeXdUbVAxZ3paSTZDMER6WkVRTTViejVSZDEzSzVyQmRIamVx?=
 =?utf-8?B?ZkNFVTFjTXZ3aSszMWR3T1RSbEFqeHRhL1M2V29qSGwydXJodHBodndETkNN?=
 =?utf-8?B?ckROZHVIK2R2eDdicG5oTHlxUDR3WWgveWlpMUFyNFBmUklMbjk1MmdlZ1po?=
 =?utf-8?B?L2RpU0Vyd1pIbjZzWCtPQlpKaW5yWXJGSHZ0K3JHaE0xQTFxdXRvUzcrTnN6?=
 =?utf-8?B?ZUZHayt3MXhVTUIvV212OWVPakh6U1N0Vi9mbDFQSWNNVFZONU9rVG80RHlZ?=
 =?utf-8?B?MXNpcHUwRjB1RjRkQkV1Y0tKK2pTaDUyd29uV1JVOStZaFUrRVEzRU5EaDhS?=
 =?utf-8?B?bE1lTkxleVJSWkdUOG0xRXkxT2dwN1ZiRE5ZWFlFeGxKK29mTENlTThFYTZx?=
 =?utf-8?B?NHZmdmFoa24rcXhYK014c0hpVTJMZ201ZkxvaGg4SThrajdHSHJzdEJtWVNH?=
 =?utf-8?B?NFFmL3lQNksyeUlidUJpRllmTjhhNERwLzAydmN5dlg0S3dlQk1OL1pVOEVn?=
 =?utf-8?B?L0tPcGM0ckpDb1kydUJDY0djb2QwWW81aEROWW5lSnFyektVcVE2MXF4MkNz?=
 =?utf-8?B?V0d6a3k0YXZvOXV2RGdybWRIWFdPbEhtUDRTcjJPS2lVcU8wLzB3RTROUjlt?=
 =?utf-8?B?VklZVUJ5bWtlZHZVRlMvQUN1WGYzUjY3OFNIelREc2VsVlI2OFViUkpvd3dC?=
 =?utf-8?B?M0JidWR2TFAxSUo1VWFtWnFvczMwYUcydGlRMGMyRFRTZU4zMDR6SCsvditv?=
 =?utf-8?B?eFVPOEcwcld2Y1FFNlhzcmhPRm9QbUxOOVJFME9EVFF4V05yaVhTdzV5Wnc5?=
 =?utf-8?B?SmtST2dQaDZDby9LUkZIcVpNeXVXYmUxRFl3MTI2SjhaNkJlOCtRYWZGbmFn?=
 =?utf-8?B?WllkVWVGTHdJZmE3cm9JbjJiU3RXZnVUalJIRDIvUzhSK0RGNk1xekNmWm94?=
 =?utf-8?B?d2ZxOHhzYnBuUHUwZkwyUEplREV2NExzVEN0Q3RmSGxTenVHVXVqZzNZMmNz?=
 =?utf-8?B?VmZvT1pCR3RVTFFTRzBaY0U1QTQ3eDlmMWp4Nlk4ZHh1SU9QVXM1QzdjNnky?=
 =?utf-8?B?cExvZGtnUkZ6dWNHOHFtMUFlZktaYXVBUHJiRzFNdlBxZDUxY1AweldDNXZs?=
 =?utf-8?B?L1VnUnE1a3p6SCt2RktxeldORlNhVFJ0bDFTTnRtVWRJb2FmZ0VtaGJBTjNn?=
 =?utf-8?B?b1RZZStQYnlaK2toQTlLdmp5NVJHL0djeGpYQk1QU08zS0t6Q3prK2ZGUFRT?=
 =?utf-8?B?QmxqMU00dEQ3dmFOTW9Bd2NtL0V2V3c0MlJiRURvSUk2dXY5L0dCZVVneUg2?=
 =?utf-8?B?ai9QcWNDdTMvUEpQcS8xZk1zbzlHb3J1YW5CNlgrY3d3a1JBVzk1Umdka1lS?=
 =?utf-8?B?Y3RFWW5ZaTlxblhVKzZ5d2FZekhGYXFvN0w2SmR3MnhkNURxV2txZTg4clVF?=
 =?utf-8?B?aDdEM2pkOCtUcy9nQVpSSHhPWkx1bEQxcHkydGZYb1lEZ3VIREpwYy9NenUz?=
 =?utf-8?B?UXZQNlFaUkYxNEVtWGt0QXBhT21vSG1qM2hhSC9iWm1weFlwVmlYb0RyR0J2?=
 =?utf-8?B?aGZZd0Qwb1VMdGY4RE1QRTBYcWU0QnpmZWxYT3VRY0Z2Vm9sYVA4L1dGd1I2?=
 =?utf-8?B?UXJidEZLa3N3Wi9GTnRFOHUrZllqRWVDNWFhN2VuTzRpc01MaG42OHd3L25r?=
 =?utf-8?B?ckltM3MrOXBncHgvVlprRmJIZmpTM1Q0djVtcDZneHJqRUtxd2doRGdLOS9l?=
 =?utf-8?B?cEdBYkJHNHRaQkx5V3FYb3RsSmloQWtDekVFZVgrR25DbDBudGdXWWNMRU81?=
 =?utf-8?B?S1c5WDJFODZ4dE02RGk5ejI4Qkxhb052bFZuNmJscWhFWVFJemFYNzVZcjFI?=
 =?utf-8?B?YVBUd2VNVDZ6N0hqQ3pJUlNXVTI0U1ZPOTFWQTNVRUJYM2U0TjFkLzVDbzlW?=
 =?utf-8?B?N2l6VHozaFFWdnhtNXRBTXIyTlBvd1p3OEZJWHdXeWtCbkppTkc2Ny83cnBy?=
 =?utf-8?B?TUw1RW1kLzhoTVE4blZ6elJmem9rcUo0Y01JWDQxV2V0QXZUSlc4bzdoeTFo?=
 =?utf-8?B?c1VQWlNMN3A2UGJXalc1cW5zQW8wc1dVSGxFb0JQYVZ1T2NncUY0TFIxVFBi?=
 =?utf-8?B?OHlyNVNvY3FLeUZhaUx4WEt0L3dHK3ZiMGpwbVZsSEMwSXlTNGlBN0NGVUgv?=
 =?utf-8?B?T2l6L2dBVjl1M0ZRblNqTzRaYnRNVnRNeGxBOVEyaTllZEtDcmZYK3hzM096?=
 =?utf-8?B?U0JVMUFXRnJmcmxrRW4wZUV4ck43M0ZpR21XSkpjamJuTDk2WndpZVpXTGpj?=
 =?utf-8?B?bSs1aDQreWdjTkxQajF2UlpsckN3S3VzKzZsbEtoRUJXOTllTlVoeGZPZlFS?=
 =?utf-8?Q?9jqpteXJmj53icsQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1196289-81d2-4acc-88d4-08df284b9111
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:33.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaS7dFErIsV03el3a/2WIzoRzpDJgSO65NlZs+MNND2uk/N2CPNmgqO1kfHhGWcyV8CR1073BukjcJQtcGU5V+geyMyr3mm0yOCwq2dcubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The savevm/loadvm operation doesn't make any sense in any of the CPR
modes.  Saving VM state implies saving its RAM entirely, while the whole
point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
preserved in place and never put into the migration stream (see
migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
taken with such a mode set has no RAM in it, and loading a snapshot with
such a mode set fails in the RAM loader.

Currently nothing stops these operations from firing with a CPR mode
still set, e.g. after an earlier CPR attempt.  Reject them early in
migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
well as 'snapshot-save'/'snapshot-load' QMP commands.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f2..92eda90114e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -560,8 +560,15 @@ static bool migrate_incoming_started(void)
 bool migrate_can_snapshot(Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = migrate_mode();
     int i;
 
+    if (mode != MIG_MODE_NORMAL) {
+        error_setg(errp, "Snapshots are not compatible with migration mode %s",
+                   MigMode_str(mode));
+        return false;
+    }
+
     for (i = 0; i < check_caps_savevm.size; i++) {
         int incomp_cap = check_caps_savevm.caps[i];
 

-- 
2.47.1


