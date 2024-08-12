Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7000CC531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQs8-0003lN-N0; Mon, 12 Aug 2024 04:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQs1-0003Qs-Bm
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:57:41 -0400
Received: from mail-vi1eur03on20713.outbound.protection.outlook.com
 ([2a01:111:f403:260c::713]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQrz-0007iH-KS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0JNXapm63hbLjXVZMrSFW40H1j285wiXSLtxopRyJuIol+0wUKaYsk/iOelP04nV9HbGXCjvxtG/fUzlGE/3QphDWU4O4NQ3GT/qSgpLBsEbq7Qoc2ZuVAceQ64coqjWaLdfm9sALf7hlA0Y02CU62NfUmCB5/i2oHhe+GOccTNCfX960dIWrprsSHvniDMa8B/FX34AFwpIXREf46GCvOZkzChT3ecBZvVUm99BGMUJNw/Lis7sU0urM64Xq6uU94mYnrjw+lOFNs9IaTanRrv4rAHhG9TQlS5W21vKObSX+cmgPlwTZCe+q283waFsstZEKvgrGEj5rGF0AnfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u1UV+WAqhvtHe8BdKZ8IqkkHnjk6HNO2FxwWip1FLw=;
 b=jE29C4axYQMPLp3QHdmseuq3n8kTqOYPvJaBbs6L9NaOT20E8vGiN9zdy7MGaDLRV+s4NJ0Ooa8rFA5Gn7GDZnsvEC5QqIYTlUN/TO6LH6TIDxvbRd5AneHwXYO73KjuKJAhWdVUI/Bg0HUbIPEuL23i1G0pDIDRYdQc3kvo4vzRHmRPtVdY+xBcSQIumKrrE3UEtnrfvN0iLV3vJsMsMV5EIPtUimEUiMB3cd1OGZjf/np3pJu8BwW+ZvIpXkrw1Bju/EkxQ7pgpUw8nZf4JWEXXWeBA89xFYNMyZTC5Z3ZkDSs4u8GaTb2pm6QUKzPKxg34nITnc5gqF3LrScucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u1UV+WAqhvtHe8BdKZ8IqkkHnjk6HNO2FxwWip1FLw=;
 b=hzp9quNyBZ3ropyenNMpN37E8Z2aUT1k5glmCk7HuDvMM4IlNW8fUCR4GQlzMFpfF67anD83JZdKTU/tAoGba044vAEDnf+q6kXg+8azi0rbe6y23FhYLyERZk+0qwpIb4zT/vOx/JSOJKOC16SvFFsqOC2kupcgGNOd6nNmFBYB9rXvH3yLUzejYtB5Tn7QURy9E8grEFdV6gFavocE0gjJGbv37okXMXduZ+5SI7rUNpur4Fr/y90TQ15AERjVnPVE0xjG0bDc4KHr9hqZLzCE0PdHvbUeeHg2ymMT8BhO4ZlYoL1ZqjD3iN8KTqrXv1wUiiG++PT/BT5X4NFaIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB5PR08MB10253.eurprd08.prod.outlook.com
 (2603:10a6:10:4a9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 08:57:34 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%5]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 08:57:34 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
Subject: [PATCH v2 1/1] module: Move local_err initialization to the loop in
 module_load_qom_all()
Date: Mon, 12 Aug 2024 10:57:25 +0200
Message-ID: <20240812085725.1093540-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812085725.1093540-1-alexander.ivanov@virtuozzo.com>
References: <20240812085725.1093540-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB5PR08MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: 192c5540-1506-4a09-364d-08dcbaacce43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9jXLr6nec3+IndeeE7QCB0ueg+IWxcyph8gVT+WC9LEBoelfx/Nf+1PPJK9?=
 =?us-ascii?Q?n/tS+uzDRvF0vdsBv4D2jBNpi8HS/aK8cTsxcYmyIYmpQvF6o5aW2B2rR1PO?=
 =?us-ascii?Q?cHXiXfZeBVPminfOnlDn1/IFUia/kAzbSV6SMpFlQxDK6CXhFVSMtryMtEq8?=
 =?us-ascii?Q?OYwAH6f87xK/czak14KCEekNj/g2xZ2LvvGl3x0oglvXjFwn/5puQ8OyQP+N?=
 =?us-ascii?Q?RsGBqjwA/I+uOAwFga1XyZ0CeUPoTeTHpPQPM6lHvBcO+fC3Lh1vx2S22dwH?=
 =?us-ascii?Q?v6UyUgbl30ekXYFlKoUhsToPUzuMi5ww7hL6nsoFpRXPlhQJ9q8i+6CXfHX2?=
 =?us-ascii?Q?m0QPPLt5vQSLG3fUMnwPT6v+CBtmOH+VG11WvNQEfnA91Zd+ZR/k0BbvTyFc?=
 =?us-ascii?Q?wUJd/ky3tOocXGFMe+f5Z1ZagtMiHWO9yaNFf9iWzixJwDJGx13Z6ROk7Pbq?=
 =?us-ascii?Q?PylJpo9E7A012zcP63P6a0jiM6fCPMsHs0olEceVkV0e2aQXqzIn6u3sgMwT?=
 =?us-ascii?Q?e8d3/NSDP9abdf45KBoIdHaM/dRdPcnyr16JnjiSC8Od1jranqlX7buVHhqW?=
 =?us-ascii?Q?F7Zi+EeWS5Sf6KL9ZVGPPeTObCzyiQI5mCjAFmCsYCneTsRLSmz4vf/ZJMVR?=
 =?us-ascii?Q?CGBszdZGf4FQwO0TQKbnQzyjgU5B4S7It9ZQ+ONa6rkb/NtW6kQxDL533LVi?=
 =?us-ascii?Q?O2inxmH6NBwG8lkMALC7d31LLvqZVH69B43TfJgjU+IdS0h3Rd/2OtR94dCD?=
 =?us-ascii?Q?sl7Nf0LEjQ2I0P9M66JoinRUaqvmWKW4dEJxce8cX0uM/X00BCnfVR2Rgb/b?=
 =?us-ascii?Q?yfETlz+s7kgHDQgGN79P7hal0oJAN/AyDLD3p/ZQn2D/xsYwmxo/CrzkmBAP?=
 =?us-ascii?Q?Wp9BktW4wys1o6ey5+VRHYJCtkjslx0CX409/dBMGqT8RldM/Vm+Zn6jP8KK?=
 =?us-ascii?Q?wwPCqyCoParPURDbx0pQLzKhA/5PfgjYkUktQP26jhtKwIdolD8AvIJ40MlM?=
 =?us-ascii?Q?i3t8y9se9xSxidwTQyqJI2T2RG/CR5J6Hq4psQ93rcsO2NCt3vrDV01TX0Yy?=
 =?us-ascii?Q?8K88O1xgzKTDfY9XGMvtYYXl75z2CO7lHPdvCqV4bjnbZLW9Q5DNuyftkpgh?=
 =?us-ascii?Q?juiIxrOySYe14OSorBc18CTAETjy2FW8lnOwlqVteLwjU1CuzJiPXOrGTrn9?=
 =?us-ascii?Q?M+Dcu6zujAcMzX2QXECO44gSFF3s2J1sfQn/iagp2qCWgXdGKBglPC+0a2Kz?=
 =?us-ascii?Q?bhdj2OjZYrA+ztwWqaNv30Qste59mw/JfMvCx5sFlFMU8aAGV+AFuVMQleV3?=
 =?us-ascii?Q?dQb577+8hAK4YN5j3A5Rf0Ws9VLE/8EH/uIoPIJbKBT1yuhLDp5KkZzZh4Cs?=
 =?us-ascii?Q?+ZO2y4KrRMeE6uTc2NGfrknflwEUSlKsRSOkvcfB/cPpK6JYow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHamftO5zrCeviYzDB4lts5j3Z+Cpyk025VSWu1mPQF1A3SDR41a5zv9lG3a?=
 =?us-ascii?Q?/F0os+mlODptEYLzE1XeXwZGFt8Fl+thZ7zJjFOeCWzzwDAO7J/xrQSSY1i1?=
 =?us-ascii?Q?qirlof5pOOLflX2uLHOYtL/YpXczepU4AfAjrOli4Qo7hpQHknX0h1ORuaXA?=
 =?us-ascii?Q?Dyd5EEJSXws7BfgjyvrpSnocV27Qr914F734hLO3Z06ZbVLm3qPASVO2gdxQ?=
 =?us-ascii?Q?5IY79/LFC70TbuobtZlQ7UrTVy3czupEImLzasxsMIvDZcbq8roHzR710/dk?=
 =?us-ascii?Q?aWXt2M4K/UqT22NqjYXrw86u6edLOVNEG5CMeRxSnaQTlVFKL0G/hUcaxYBz?=
 =?us-ascii?Q?TrEiQCu7JKD0rXESOxS3aFiqdUU3nJR8Xk3flYyPpBES44YM4yrkZz5OkD7i?=
 =?us-ascii?Q?ybUqUUudKR6dnxgA56CNrYMq2pmL5bEs7gg7aqolK+oC9/IUjhYdLTuPY2Bw?=
 =?us-ascii?Q?adY5RUf1szQnkzqFT+XbzeROnUKLJLDqGXYCwk8gJXMDoJOYLzIw8ytK1YAf?=
 =?us-ascii?Q?opUXpm4rr1E5t8VCO+VwZYOJbII36tF4tmlX4Bqwy8jCdzfH1cZRvwXs7V9m?=
 =?us-ascii?Q?/3mC4EsAASF7KjacFn/Am95nBhhAqy7uv+k0KVqpXQa9YsjGpj9+gtjhgx69?=
 =?us-ascii?Q?QlomdAXt/flK7YPQbEyE6kcMVSa2oQIl8pm4Jm70a+zRei/IJVRCx//7I1b2?=
 =?us-ascii?Q?WG5ZNpNSVOseR3ZQA+TsXWTLqCUVRst0X1+iSOid96Q7+gkf9leDLnRWSK1R?=
 =?us-ascii?Q?XcNpc7rlEI/Z3sEoYOLxl+z9InZLiCyYcN8eUpgerwNvrK7M9SlyP8D9fmOp?=
 =?us-ascii?Q?UMpG5qr3dRg1UlbXeyNVquuGlBdW94XaBWsn5U10WZkechJ1zImQzqS4Ftgp?=
 =?us-ascii?Q?HDDO9vQfgYOyN31t0QRq2K18o+nuPgV/2uVSMRtVWpZzYUitKjjykymn1hhA?=
 =?us-ascii?Q?pfEerG+CmuFpi/w6YAGcous0iepupzqOMBBcp96QHDFHPCjug1Xl8k8roxzm?=
 =?us-ascii?Q?0Nvq/vRMYDaPg3V/HVuV6/SeZWh44O6HYLsiPKFbxQ1eChWQGgpAGzHmGxWJ?=
 =?us-ascii?Q?r9MKrfR6QLP+o1z7k145KoA8EVWiWsgagyqWXnELd5BqKX1492CWaitJmVCD?=
 =?us-ascii?Q?WZI3ETkKk5QlHZSb1O+J5+HHCzKZ346KIouSS2rX4ADhj0HoOGsfUTqxzAOf?=
 =?us-ascii?Q?g4SH70gSkLpZ1QCUbEzh6SxYw3I+GIK91h32viRBJrwc/VuVokpCjcQWJ5de?=
 =?us-ascii?Q?hyQtsfrF9GJmxbLWJjZlzPISz8ZQtq6NDXi36QoHKXedgox4rcNPvVOeammz?=
 =?us-ascii?Q?oKDVazua6QpTCrkdgpE/yqp1SaFgfEJrL3Goi1slJdFSfAHq7chgur746Nd2?=
 =?us-ascii?Q?/beK62lCMxL22KpXf0h4qkrcYN5SGA4M9F47CVEvdOVtExMVzwhTqBIsrgCY?=
 =?us-ascii?Q?aQ/bSOJzJWjpdbyFLEekqGvN2W1FkdQ6l1QEWnFRWEtya759J6bRyPKO93CL?=
 =?us-ascii?Q?kFjwC1bip84bMTS+l82aec3qQLw1/pYqof9CghzZvwAXMemjffk97hToP6bK?=
 =?us-ascii?Q?dokbCr1xJltz4H6CglkObX6UD0/N1JHM9zX+J4LYaCFCoOBptIEJArPAJVOe?=
 =?us-ascii?Q?FbQjSyA6+LmJi6hlObt1Usg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192c5540-1506-4a09-364d-08dcbaacce43
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:57:33.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3R185z1fgiv05b0CCQaolnEuoI6xLRG6x//Cr4ts/gIZKbufxZtCVp6CGAy+t4xpSM0tz3KAWWmitKnwp+Zk0WZ6NxE6Damm1+8p4RMdB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10253
Received-SPF: pass client-ip=2a01:111:f403:260c::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move local_err initialization inside the loop in the module_load_qom_all()
function. This change ensures that the error variable is reset to NULL for
each iteration of the loop. This prevents triggering assert(*errp == NULL)
failure in error_setv() when local_err is reused in the loop.

Note: The local_err variable is freed in error_report_err() so there is no
any leak.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 32e263163c..3eb0f06df1 100644
--- a/util/module.c
+++ b/util/module.c
@@ -354,13 +354,13 @@ int module_load_qom(const char *type, Error **errp)
 void module_load_qom_all(void)
 {
     const QemuModinfo *modinfo;
-    Error *local_err = NULL;
 
     if (module_loaded_qom_all) {
         return;
     }
 
     for (modinfo = module_info; modinfo->name != NULL; modinfo++) {
+        Error *local_err = NULL;
         if (!modinfo->objs) {
             continue;
         }
-- 
2.43.0


