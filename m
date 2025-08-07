Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387ADC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxug-0007tT-RF; Thu, 07 Aug 2025 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ujxuV-0007Yu-AD
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ujxuT-0003p4-Nk
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754562704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8w3Cxk+e/HdehZDP+UNsCur4eyTAg3cqI8YUurDMt0=;
 b=O0tYveYEJ67Bc0KM7nSLvM6SEGByksMrDXpD5hJyDWY3auDm9uYYIMVM7onYQW/lHS2nIa
 s5ZOiScj8hMarBpAAGLfWM/+KprL3RtYtSJUJs0mtM4HBiSQOkUYrhvQgmyxOPuj6uBLQE
 C6BpgF1RWgifb2FVwhmZx2fZ7jqqimE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-f5ZtQpweNomKZ8LkoKS2BA-1; Thu,
 07 Aug 2025 06:31:43 -0400
X-MC-Unique: f5ZtQpweNomKZ8LkoKS2BA-1
X-Mimecast-MFC-AGG-ID: f5ZtQpweNomKZ8LkoKS2BA_1754562702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60C919560A2; Thu,  7 Aug 2025 10:31:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DB36180035C; Thu,  7 Aug 2025 10:31:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, William Hu <purplearmadillo77@proton.me>
Subject: [PULL v2 1/1] ui/curses: Fix infinite loop on windows
Date: Thu,  7 Aug 2025 14:31:31 +0400
Message-ID: <20250807103131.1912150-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250807103131.1912150-1-marcandre.lureau@redhat.com>
References: <20250807103131.1912150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: William Hu <purplearmadillo77@proton.me>

Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused by a
65535 == -1 comparison.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
Signed-off-by: William Hu <purplearmadillo77@proton.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[ Marc-André - Add missing similar code change, remove a comment ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
---
 ui/curses.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index a39aee8762..161f78c35c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -265,7 +265,8 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
 
 static void curses_refresh(DisplayChangeListener *dcl)
 {
-    int chr, keysym, keycode, keycode_alt;
+    wint_t chr = 0;
+    int keysym, keycode, keycode_alt;
     enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
 
     curses_winch_check();
@@ -284,8 +285,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
         /* while there are any pending key strokes to process */
         chr = console_getch(&maybe_keycode);
 
-        if (chr == -1)
+        if (chr == WEOF) {
             break;
+        }
 
 #ifdef KEY_RESIZE
         /* this shouldn't occur when we use a custom SIGWINCH handler */
@@ -304,9 +306,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
         /* alt or esc key */
         if (keycode == 1) {
             enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
-            int nextchr = console_getch(&next_maybe_keycode);
+            wint_t nextchr = console_getch(&next_maybe_keycode);
 
-            if (nextchr != -1) {
+            if (nextchr != WEOF) {
                 chr = nextchr;
                 maybe_keycode = next_maybe_keycode;
                 keycode_alt = ALT;
-- 
2.50.1


