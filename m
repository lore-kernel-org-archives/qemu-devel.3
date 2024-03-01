Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD4EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6yZ-0006Hw-OD; Fri, 01 Mar 2024 12:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yX-00066F-UP
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:47:13 -0500
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yW-0000cN-4q
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:47:13 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 86DCE362AD0
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:47:09 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id E1ED636107C
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:47:04 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315225; a=rsa-sha256;
 cv=pass;
 b=TKGJW4eVsT9x+ndl3EKRWrfH+XBFXC1uSj8pBUF5c4c7j3DXfsWQ2FMQ2UubLYpy/WH0/i
 As08hGZZVygx0yBVy5oji+Y6mHRVZQvBl+UDRy6Idge++yrzMdIhDVBv0DZuFmxBdw7I9B
 2ZZ97yo2EN+9+CgDZAEFcmz6bhXnTPFOZkXVqpbqiTQIJW9eXCMJgfsl460jRd932uDreR
 KOosQDAfXVqq6W84u2Aj6RN4T06yGehc3cf/NM4n01OckQRW0uUs6aI8yK6JcZLjGbvXHB
 V3JuoFvfIQCvK8iVyQOUEy/zUd9uLA3WhCBD5sEpjuxAKQViPJJ/fe/hmLgStw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=S7SHDhlmpFjlxOugOz6KuS8B3f2c7/2cN5ozYLomgeU=;
 b=TYI2Jyg2VycHAT1dV9LElkrUCB7HUow4rYhuHdrPgU6FreOSC5kNsxiWa/VHWOXXLyj1dn
 nM0NwX9vAHxnE0W7uT2AqwxJEixzu4A574HaS6pzbwa4idMBihBI4y4m3cNvc5UXGljXUS
 MvS6cW/Q6tV1T9cfo/EzYUf1T8YDV+uYxUbLO+N0U8zEvI/pM+9XJOOZm3DyOpjuGvUqQy
 bnT9Yl/benZFDq4kvnCdkkNcyP7R1vsnvnp99SEhQnfz6+RLw11lEK1KhIl2rwsFcDHnPV
 wCoaNU/TYLbiB5VxixP9HvNzGKfd3/A3zjZ9PNCEdVjKXfDi7At6/ap5lGwKkQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-d4z79;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Stop-Whistle: 565f78922a0729c8_1709315225420_441547854
X-MC-Loop-Signature: 1709315225420:2756215266
X-MC-Ingress-Time: 1709315225420
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.227 (trex/6.9.2); Fri, 01 Mar 2024 17:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315170; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=D7Jw08MHue6O6zgYmXZX+C+fHq+RJlsgs0fV9lsJvtVou9kaoVY7qSmuRAfCN9OOt2dYBz0QLBHLy
 68p2AtluPR8YezXbaQ/f3JOXXV9/4Mei+x0Og8vhSUA/xGT/P9lTZPFcUCLlQDs8PdMDumFL/1xIld
 57QK7Yo3U2rZkXtO2lbH5M99m2wAgpXpr+X9JkhulJ5vB6xutuHhlZgv7gEYBKFP2yMCTZjfGpY/jp
 BuL+gm1XJPo55+yBjG8HxDZGNIGb5wgfpgKd3BiOE8No1k0PokGRFgBEbwWlpAXVVBKorab0iuttoC
 f7MvT9ZOolhe+9TNytmVsrueBlNM4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=S7SHDhlmpFjlxOugOz6KuS8B3f2c7/2cN5ozYLomgeU=;
 b=RU/S/r/DG2HIkFxG5kE6f9og5whvxoFN6h1FW6FwjmKpqox4MfRFjKnD6Yffrmcww1f3qZt3FuqbP
 sLkBCp3Q/57RrInw3bmYwbg3TOYuEU9r9aQOUOYWOMSBxuRZNfT3ngBUmQXLeaJ6kGXdMl75nSi5dj
 LCgGT9aQ5zoaDAkWVnAyjtyuTzwVx5x5n/2z2vRRTnqF/ETzkRvJwT4YbLwgNAzsr1AK7zKXgy6arN
 9TP5LlT7E67pFvMDRuwYNZuTi0+Ghi2ErMx0sAxbc/+a0Ph6EM37N+mqm5MOr/UjnA/o/LH8B8Y5hi
 jWWwTjW3O9NagoFRcOBiAuh5ohunXRw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=HmIKXR4s; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=S7SHDhlmpFjlxOugOz6KuS8B3f2c7/2cN5ozYLomgeU=;
 b=IzitaiSTNmYvXOnmfqujoqWwWst5BKQVz+22JO226koyYTJoGLQPxomFoSjlZCyN5bbempskhlAPI
 Rk8cz6p7XzghyTOT4f6P2UQeFh2f4D8NN8VOsw5dRJvxi8zMY4IrCYPugu6mt84DrCROjdkdJYYmi7
 7pXmP4PUOK4TF6S8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=S7SHDhlmpFjlxOugOz6KuS8B3f2c7/2cN5ozYLomgeU=;
 b=jVwhgBSM2DzMQdxWdksy8Kd4bVt+/Ur1Y2X4GKXtahI+zTE5oDZ8v3YdZUyyy+4QFr2DsHxplyJ+p
 qyZs/eCOmjA7uzlXkbrjYBn1IULHP74gn/7OXfHORGYBw3mjPgd7m6c8RvHxpDQl9wXY/jCLwmWpK9
 YwveFKe2GxJvZAqXyx4Wo8N09hzylTlheNChWNEFVfjOq5Z/fJoWtsTIb2FNLcaw9tYLCYZm//tR7S
 bpOXQFjQh81d9EYFHSukWjwEBWsyTNBnrFuVjP9G5v8Zrhdb73KLONs5iVS6Q7ZS1o1GGs1G0wSW3b
 5/kbCN6Gi9SArB8TOMlO3dCEtJ6gu1w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 93cd28e6-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 93cd28e6-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S7SHDhlmpFjlxOugOz6KuS8B3f2c7/2cN5ozYLomgeU=; b=HmIKXR4spxmN1DZ0bBUrkLpymA
 MIeP7NYPQZhgC5XoeKYaJhWmdvDQ5GEd5iZ0lYYSYUz3OtFr1tbyCg0D4sLIYtVho05yZtpZEFnPU
 xPb7wHB8DjvIE4KWm0GYG7E0+Au9y6+fJn8sQv1MqdvIttNZY+/pX/ommqtmOJhoS3Sig90GZ2yye
 igN1SQ15qKCNnML0GjMyJGl1JjMZvSz4x7LK4bLE+beqELqRxWBTxgV95jyvtEAyfrIxd4zUMMc6b
 Fz6wMj9BLIf6XhU98UaS9j5Uj8x4guMdjvB7PldxUxf1YdI+i5TX73pmZrGyVGNm0J1VGzJAS4pT8
 7W47mbLQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xp-000bs2-1U;
 Fri, 01 Mar 2024 18:46:29 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 11/12] plugins/execlog: use range list api
Date: Fri,  1 Mar 2024 18:46:08 +0100
Message-ID: <20240301174609.1964379-12-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of doing its own implementation, use the new range
list API to parse and match address lists.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index a1dfd59ab7..c518797893 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -35,7 +35,7 @@ static GArray *cpus;
 static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
-static GArray *amatches;
+static GList *amatches;
 static GPtrArray *rmatches;
 static bool disas_assist;
 static GMutex add_reg_name_lock;
@@ -215,12 +215,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         }
 
         if (skip && amatches) {
-            int j;
-            for (j = 0; j < amatches->len && skip; j++) {
-                uint64_t v = g_array_index(amatches, uint64_t, j);
-                if (v == insn_vaddr) {
-                    skip = false;
-                }
+            if (qemu_plugin_range_list_contains(amatches, insn_vaddr)) {
+                skip = false;
             }
         }
 
@@ -398,16 +394,6 @@ static void parse_insn_match(char *match)
     g_ptr_array_add(imatches, g_strdup(match));
 }
 
-static void parse_vaddr_match(char *match)
-{
-    uint64_t v = g_ascii_strtoull(match, NULL, 16);
-
-    if (!amatches) {
-        amatches = g_array_new(false, true, sizeof(uint64_t));
-    }
-    g_array_append_val(amatches, v);
-}
-
 /*
  * We have to wait until vCPUs are started before we can check the
  * patterns find anything.
@@ -440,7 +426,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         if (g_strcmp0(tokens[0], "ifilter") == 0) {
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
-            parse_vaddr_match(tokens[1]);
+            Error *err = NULL;
+            qemu_plugin_range_list_from_string(&amatches, tokens[1], &err);
+            if (err) {
+                qemu_plugin_error_print(err);
+                return -1;
+            }
         } else if (g_strcmp0(tokens[0], "reg") == 0) {
             add_regpat(tokens[1]);
         } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
-- 
2.43.2


