Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDD1FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9bS-0000E4-RJ; Tue, 05 May 2026 02:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9bA-0000CK-CG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b6-0005xr-5V
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfrrwrN03JoDX1UHDEy1542TbBdn4gexX/B54SPADws=;
 b=CvkpkHzZ0odCBbz0SuNaErhv1xCOFB+8o4e1QsDbcybVkbB4mYWWoRApXzP8Vki2OehQ2R
 GqdGn0mnRNGRvfm3sW+JAzFhTHFtqYfp3uR5uPtzhLilBfeo+nc/o7lDKgCxwalob3LlAs
 QphRiaoYS4ErQ43pMMgfr4p0COREwxo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-m8YQn6NxPZyHbvU2_NdsdQ-1; Tue, 05 May 2026 02:49:33 -0400
X-MC-Unique: m8YQn6NxPZyHbvU2_NdsdQ-1
X-Mimecast-MFC-AGG-ID: m8YQn6NxPZyHbvU2_NdsdQ_1777963772
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a3aee3813so1955376f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963771; x=1778568571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfrrwrN03JoDX1UHDEy1542TbBdn4gexX/B54SPADws=;
 b=pm+WHvJhl/D3/bY22jH+FDjdr63wvAsf4DmYWVI2N96IhB2J1uatWJIe/JQjm7Yc9s
 OOc9O19D1CoQes20/44ARQf/hxaQ6CSqeIfxENB7iNJmqMKly6moHeMCHnk678ibTVFm
 zDnBnGrg7f94IKgD7TLaiFM/NHVxiOLcnNd1Dqb8Oeu3qHgLK74NMZGNMg3qM9lT0qsF
 ZpkVWhz43ZKUAJrxOyQGbDLxwcXrZ6sq5Av48uQT60uTjwJpgmYGLR8h5c/bdhnY/UnJ
 975bl4q8QTLhjio5GzkW/rmQJrQ1DqiA/gcNlYGeG/m7a5jgoSy2f/F/FIc91BZgkugn
 xTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963771; x=1778568571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfrrwrN03JoDX1UHDEy1542TbBdn4gexX/B54SPADws=;
 b=quQSBUUNGguwXxNn26nf9WvNcWVzfNakNniMTtau11ykOy+7eLhMqQiTf+j4VxZ4Tl
 94R7R2JfTo64Kv5BnDzWLTo1zIQmWZcewkgmdfQ8P7eS+70jTKnW9uhP9SpE8lds4fws
 tCPkFMSzbncz7e3OQGPo9iNIltn6vgheKuxA0IwagJFst8zKQEX2w7aP2ko4qLNHYu/e
 ETat2+jSVExu56g8shPDfTCjzfe0sLM9rHMS9EtK/G19gHobV1LT7ylVsVrgBtyWofHv
 b+CxpqHLDaqVo6h7KFlfWP6X8sogCYed6coO43+SCLFSj0G3IMdqVNngPJuwklvjMa54
 eHwQ==
X-Gm-Message-State: AOJu0Yw4MGcAc3P1qxbeZwHzrucaBsiD5SegUIJNy87/0Q5SCn/ALEHT
 yBsTOhLv7kHQnhD3fHPISTBvZcv/XI9mZP3+2CYz2LeXu5T4xIwuWkRqqvXMr7Z4Fh3C6qR8q55
 P86PhC/Y5ZDkR44zrXqQvwJR9g5a2XfyuHfOmwWBNNO8eCVtMT+Bqx0rPLsL/t39SyrSqunfGV9
 SDjJFpBRHpNccGpF/Ota6u/IZTWcEPZJx5QwPrTtmT
X-Gm-Gg: AeBDieuj4nGEH+GNgI/CXDgwRkKR2kaOctmB1NYzBRvFzgNnTnIYrthXHiluT+G9IjJ
 7DVe4KaisguWX4+QY5OmJczM38liU681TQ+DFBldE04/fch1gShHV9md5KzDjABAqaKwvkcRfcH
 b9evo/kClTG/avvILgPL+eUDT02tqGPchpM9AqtZRT4ynL/0JAhfOWDCwf2ood/pFN0rHcdN2Yn
 1h2mXqCljVHT5PRqTaqjGejQVlJ9n8q/JLFQqVeRk+0nnBT6n+BuH39+SH//Ks2EmgD2Mwg91fQ
 oDzHCUSbRqaGJulZJzlT45FpnZUGfdrxrj+tHxbYdSOY2qDOO8Ljjlxdzs4F4bgOdhEhEjnf3f/
 awNxKY86Tl3e3S/NVY2joa2+vF3gjjWw/FSubzq44Yhnp71tVYZybasrGbyplorftBIPkzso+L6
 bzWiPD7SFLIGU8N4RdRnTJ1clttl6iZv7srBojCqE=
X-Received: by 2002:a05:6000:18a5:b0:449:a07a:967f with SMTP id
 ffacd0b85a97d-45005a97b08mr3084239f8f.28.1777963771661; 
 Mon, 04 May 2026 23:49:31 -0700 (PDT)
X-Received: by 2002:a05:6000:18a5:b0:449:a07a:967f with SMTP id
 ffacd0b85a97d-45005a97b08mr3084200f8f.28.1777963771186; 
 Mon, 04 May 2026 23:49:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2487dsm2158730f8f.35.2026.05.04.23.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 4/7] json-streamer: make brace/bracket count unsigned
Date: Tue,  5 May 2026 08:49:16 +0200
Message-ID: <20260505064919.177855-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com>
References: <20260505064919.177855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It makes no sense to let brace_count and bracket_count go negative,
also because it immediately ends error recovery and sets them both
back to zero.  Instead set them to zero *before* choosing
whether to process the token queue; this makes it possible to
have the fields as unsigned.

Note that JSON_END_OF_INPUT now forces the parentheses to appear
balanced, so that the queue is emptied and an error is reported;
hence, the "type != JSON_END_OF_INPUT" condition can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qobject/json-parser.h |  4 ++--
 qobject/json-streamer.c       | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/qobject/json-parser.h b/include/qobject/json-parser.h
index 4c3d89f751f..0cf6932ecdc 100644
--- a/include/qobject/json-parser.h
+++ b/include/qobject/json-parser.h
@@ -31,8 +31,8 @@ typedef struct JSONMessageParser {
     void *opaque;
     JSONLexer lexer;
     JSONParserContext parser;
-    int brace_count;
-    int bracket_count;
+    unsigned int brace_count;
+    unsigned int bracket_count;
     GQueue tokens;
     uint64_t token_size;
 } JSONMessageParser;
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index f3dfdcaea12..d400e3814fa 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -41,12 +41,18 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         parser->brace_count++;
         break;
     case JSON_RCURLY:
+        if (parser->brace_count <= 0) {
+            goto end_error_recovery;
+        }
         parser->brace_count--;
         break;
     case JSON_LSQUARE:
         parser->bracket_count++;
         break;
     case JSON_RSQUARE:
+        if (parser->bracket_count <= 0) {
+            goto end_error_recovery;
+        }
         parser->bracket_count--;
         break;
     case JSON_ERROR:
@@ -56,6 +62,15 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
         if (g_queue_is_empty(&parser->tokens)) {
             return;
         }
+    end_error_recovery:
+        /*
+         * Cause error recovery to end immediately.
+         * If not in error recovery, the parser will raise an error
+         * (due to JSON_ERROR or unexpected JSON_R{CURLY,SQUARE})
+         * but error recovery won't be entered at all.
+         */
+        parser->brace_count = 0;
+        parser->bracket_count = 0;
         break;
     default:
         break;
@@ -83,9 +98,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(&parser->tokens, token);
 
-    if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->brace_count >= 0 && parser->bracket_count >= 0
-        && type != JSON_END_OF_INPUT) {
+    if (parser->brace_count > 0 || parser->bracket_count > 0) {
         return;
     }
 
-- 
2.54.0


