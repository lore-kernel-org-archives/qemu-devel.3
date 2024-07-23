Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E7EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBDO-00081A-FT; Tue, 23 Jul 2024 04:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWBDB-0007zx-Py
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:49:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sWBD8-0005od-Ad
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:49:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc658b6b2eso5061055ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721724569; x=1722329369;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4+LHRgl9EwRECPYcVTVFGRj3zVHl1MBHrBy8lBeBjtM=;
 b=fLOBQ7bxkofSGRwLlI2c/e3PXIqO8/iPdhEpfVD+iBqhFWn9TcONa+zSPHSpp/gnLS
 aGWbOtkLSEnqIC+Yxaxf+QU5UITpLHkyD363/q2HUvJNPYjdmREIAK/ZYKNb3Yk9ltGZ
 /g3U2bCQhw4VbKUZ4bVXIbIn8hp/oFVDba4fHninHCmd/E/H+kXSJwnu0Y422zH0Ss9L
 rLez3wTNeIhzebXIM7vcdzqOsZ6c9rKi/4aSXmcskmmkLQLZVRGQP5sdM/85/cz0T5uq
 bCgeu4vsoTPl2qmb9GmQ+tD7F0C3uBcphdCdQ7dTePRJN7U5iuVMcxuaIAqpZ4HhUv5B
 fnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721724569; x=1722329369;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+LHRgl9EwRECPYcVTVFGRj3zVHl1MBHrBy8lBeBjtM=;
 b=fw5ujoaxIRzOutVf7+QzJyuWMzFlFLYW0k+JSfQL1LhU9zwGwkF29orTAhW8GL8gz5
 vcuQV9noI7fwGDVFwa+tY7w9kRPVjbSXhkj5DOrFsC23qQndaYKs8C9TQEDB6rnAQAoI
 IGFiRojnp0lagRoiaNFnvnFnF4UjPe2vUY5wz/+2/fFgK0SoWh2ijf9HYkSyedswUR63
 UrIaTwLYN8fsTWA3dgy5el0SBZbLH5UYGqSNenLM++Y7xXBqZaE/9zxmw5oRZDlo32SC
 ohvvCPVliqC1KQuwlKQn+Rx/0lhRMQb/M0hhVXTonTL5LWxB189A93AGy7aD/ElZfkmb
 pBeA==
X-Gm-Message-State: AOJu0YwYdnh+/XNIXi4ITwNYoCaXL/K6oVNUbTAXnU9y/x9TIIDIPMDk
 lSv21ylmPP1Nh13PmR7sMeWK9g6WirZRKm+kVD1a8eyTkMmXAjsnIMHIcDfxT/H6mRU5B9IO3Jg
 Mm9k=
X-Google-Smtp-Source: AGHT+IFweY+Ffpm+aXAzW3vsRqWYu5DPu+FUaoR2qucfGbNXikZpG9yFUajx1zNSP7b7YQlPIAtuQw==
X-Received: by 2002:a17:902:c409:b0:1fb:6d1d:aaef with SMTP id
 d9443c01a7336-1fdb5f50b4cmr23095005ad.11.1721724568677; 
 Tue, 23 Jul 2024 01:49:28 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fd93d4a380sm40345135ad.145.2024.07.23.01.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:49:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 23 Jul 2024 17:49:26 +0900
Subject: [PATCH] qemu-keymap: Release local allocation references
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-unref-v1-1-88606ffd4552@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJVun2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3dK8otQ03RQzo1SjJAtjY4s0EyWg2gKgYGYF2Jzo2NpaACnV/Cl
 XAAAA
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Commit 2523baf7fb4d ("qemu-keymap: Make references to allocations
static") made references to allocations static to ensure LeakSanitizer
can track them. This trick unfortunately did not work with gcc version
14.0.1; that compiler is clever enough to know that the value of the
"state" variable is only referred in the current execution of the
function and to put it on the stack.

Release references to allocations and suppress the error once for all.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-keymap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 701e4332af87..6707067fea04 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -154,9 +154,9 @@ static xkb_mod_mask_t get_mod(struct xkb_keymap *map, const char *name)
 
 int main(int argc, char *argv[])
 {
-    static struct xkb_context *ctx;
-    static struct xkb_keymap *map;
-    static struct xkb_state *state;
+    struct xkb_context *ctx;
+    struct xkb_keymap *map;
+    struct xkb_state *state;
     xkb_mod_index_t mod, mods;
     int rc;
 
@@ -213,6 +213,7 @@ int main(int argc, char *argv[])
 
     ctx = xkb_context_new(XKB_CONTEXT_NO_FLAGS);
     map = xkb_keymap_new_from_names(ctx, &names, XKB_KEYMAP_COMPILE_NO_FLAGS);
+    xkb_context_unref(ctx);
     if (!map) {
         /* libxkbcommon prints error */
         exit(1);
@@ -234,6 +235,8 @@ int main(int argc, char *argv[])
 
     state = xkb_state_new(map);
     xkb_keymap_key_for_each(map, walk_map, state);
+    xkb_state_unref(state);
+    xkb_keymap_unref(map);
 
     /* add quirks */
     fprintf(outfile,

---
base-commit: a87a7c449e532130d4fa8faa391ff7e1f04ed660
change-id: 20240723-unref-d62e2b8338f4

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


