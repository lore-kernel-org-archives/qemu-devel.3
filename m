Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D339EC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfU6-0000SV-Rb; Thu, 13 Jun 2024 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfU5-0000PJ-Ah
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfU3-0008H2-Mz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f2c9e23d3so1189065f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718266017; x=1718870817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o245QK4N25S806OomhIBP0oO91KklkhB6AHD4fZXGb0=;
 b=e80nUtK9YJZjef7ZfXtaX3jJPuQjDUtHrkqhLxpv6jIfC5nnwL2S8uBapR1EMOhbMb
 7rRU0kYPldZwtHAmlMrh5mnGlYrmXUTTbhuKvlRkXVr9GofU9HzH0w0v+SYzUiuMIC/O
 UEnhwhLFRFjJIJM415FYKGgAkHooVyRkmQgURu9MVDKP5l+liV7DUlpXCIE000CTAN6u
 uZRXqMYQXdM9Dx0jcxDNpVphyYW2WNk/7C8XeuJFId0MY6sPBEzr+RXMrQ+lIUUYVcUO
 eH8e2vMjiiwv5FuvHRXPO5bkScQS1veUfYgWfT+c2dpCu4wMD5hG8DCEqFg0wEbumCAd
 BOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266017; x=1718870817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o245QK4N25S806OomhIBP0oO91KklkhB6AHD4fZXGb0=;
 b=wDuPnbka1t3Nt3KEWLD4yJteGk4QGXt2pVZYn3fQvqKGoO3KA3HiJYXgz/mCS25TyZ
 y3bYBlsT0iUUT8y+LKq6GdxTszae6a9qEiOUTIO2KZWFLqCh/VYDgUl0jEOlEZBcYPcL
 3nJOwwxy+psgDxaiwkXyNrOOQ/Y8lEItV8K1tUwZBzIg+HaH8Y3GNE0OMAW8rBrALu7I
 at8VuxmvIvqG6yiSlzs2HIBE9ZDnRtExSwSYZtYzuBFMeDdMG8DCrQYiy+OiBh1O1Q0P
 UVp7HcKsI2YtTnRPn4HLFKOyp+Q3oXxkDKNhlACtPpH1obk/9B9jX7gKDTuiHbeXz8bH
 VyWg==
X-Gm-Message-State: AOJu0YzVO7X7kQXEwWSVRIYfZpbL/PBuqFswYLgqN8VHRaAfOp0QvYL0
 hpHlOs45/TONyUEsAIU8bhnhKBzIxYWU9k+RCLKRa+fp5d40JrSZcRaGnW6xq6Afewt4gLLYorj
 2b3k=
X-Google-Smtp-Source: AGHT+IFJC4mWdREdKyi1SdnbGLaP68DJBWUeOVAJbSxN80qM87ZrIH0jjAtz2ETlSA2uxzJ+GCTaGg==
X-Received: by 2002:a05:6000:18cd:b0:35f:1acd:750 with SMTP id
 ffacd0b85a97d-360718e4d0fmr1417935f8f.25.1718266017620; 
 Thu, 13 Jun 2024 01:06:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104d88sm910811f8f.104.2024.06.13.01.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:06:57 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 1/3] util/readline.c:fix lints for readline_handle_byte
Date: Thu, 13 Jun 2024 11:06:11 +0300
Message-ID: <16f745ac7f5fef74498709ffd98857e76edff6aa.1718265822.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
References: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While they do not give warnings under our current buildsystem
configuration, my clang's language server daemon was complaining about
missing default: labels in switch statements.

While at it, add /* fallthrough */ annotations where appropriate.

This is a purely style and not functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/readline.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index 494a3d924e..ded31b04b7 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -405,7 +405,7 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         case 12:
             readline_clear_screen(rs);
             break;
-        case 10:
+        case 10: /* fallthrough */
         case 13:
             rs->cmd_buf[rs->cmd_buf_size] = '\0';
             if (!rs->read_password) {
@@ -425,7 +425,7 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         case 27:
             rs->esc_state = IS_ESC;
             break;
-        case 127:
+        case 127: /* fallthrough */
         case 8:
             readline_backspace(rs);
             break;
@@ -452,11 +452,11 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         break;
     case IS_CSI:
         switch (ch) {
-        case 'A':
+        case 'A': /* fallthrough */
         case 'F':
             readline_up_char(rs);
             break;
-        case 'B':
+        case 'B': /* fallthrough */
         case 'E':
             readline_down_char(rs);
             break;
@@ -480,12 +480,15 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             case 4:
                 readline_eol(rs);
                 break;
+            default:
+                break;
             }
             break;
         default:
             break;
         }
         rs->esc_state = IS_NORM;
+        /* fallthrough */
     the_end:
         break;
     case IS_SS3:
@@ -496,9 +499,13 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         case 'H':
             readline_bol(rs);
             break;
+        default:
+            break;
         }
         rs->esc_state = IS_NORM;
         break;
+    default:
+        break;
     }
     readline_update(rs);
 }
-- 
γαῖα πυρί μιχθήτω


