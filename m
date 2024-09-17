Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFFBC3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVZD-0004SZ-Bq; Tue, 17 Sep 2024 06:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZ8-00045K-Ev
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVZ6-0007Kz-S0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2A0bMQNYir9UiOIApKS5SDLnl+/c9VOLN14bZaqlyWE=;
 b=NdjpxfAbzSDvACG3IlDkmSHdEIbCwKPw6E3hnjtPn85yvK0gJUUn/f0Ml1fzuTILyFPb4+
 lx/1gMZx5c7/OWG7+C9lxGsGYhS4n2ASX9Uo0RdwTjrQLHHXkxgwYLOmhgWoqWwejJN5ZJ
 nOrrUH36RfHHq7YkmqmHsS9kYxSc8sA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-x2MMbfEENSijvHX_W6gpqw-1; Tue,
 17 Sep 2024 06:36:05 -0400
X-MC-Unique: x2MMbfEENSijvHX_W6gpqw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40441956048; Tue, 17 Sep 2024 10:36:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB6061955F54; Tue, 17 Sep 2024 10:36:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/17] tests/qtest: replace assert(0) with
 g_assert_not_reached()
Date: Tue, 17 Sep 2024 12:35:31 +0200
Message-ID: <20240917103540.149144-9-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240912073921.453203-13-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/ipmi-bt-test.c  | 2 +-
 tests/qtest/ipmi-kcs-test.c | 4 ++--
 tests/qtest/rtl8139-test.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
index 383239bcd4..13f7c841f5 100644
--- a/tests/qtest/ipmi-bt-test.c
+++ b/tests/qtest/ipmi-bt-test.c
@@ -251,7 +251,7 @@ static void emu_msg_handler(void)
         msg[msg_len++] = 0xa0;
         write_emu_msg(msg, msg_len);
     } else {
-        g_assert(0);
+        g_assert_not_reached();
     }
 }
 
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
index afc24dd3e4..3186c6ad64 100644
--- a/tests/qtest/ipmi-kcs-test.c
+++ b/tests/qtest/ipmi-kcs-test.c
@@ -145,7 +145,7 @@ static void kcs_cmd(uint8_t *cmd, unsigned int cmd_len,
         break;
 
     default:
-        g_assert(0);
+        g_assert_not_reached();
     }
     *rsp_len = j;
 }
@@ -184,7 +184,7 @@ static void kcs_abort(uint8_t *cmd, unsigned int cmd_len,
         break;
 
     default:
-        g_assert(0);
+        g_assert_not_reached();
     }
 
     /* Start the abort here */
diff --git a/tests/qtest/rtl8139-test.c b/tests/qtest/rtl8139-test.c
index eedf90f65a..55f671f2f5 100644
--- a/tests/qtest/rtl8139-test.c
+++ b/tests/qtest/rtl8139-test.c
@@ -65,7 +65,7 @@ PORT(IntrMask, w, 0x3c)
 PORT(IntrStatus, w, 0x3E)
 PORT(TimerInt, l, 0x54)
 
-#define fatal(...) do { g_test_message(__VA_ARGS__); g_assert(0); } while (0)
+#define fatal(...) do { g_test_message(__VA_ARGS__); g_assert_not_reached(); } while (0)
 
 static void test_timer(void)
 {
-- 
2.46.0


