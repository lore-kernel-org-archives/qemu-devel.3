Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44641C2BC81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMc-00035h-Tx; Tue, 18 Jun 2024 12:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMb-0002p1-4b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMZ-0007vl-8v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f14af40c2so4690702f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726833; x=1719331633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HjswWTIF2bPBshuYqltbFOwZ+QqTaElXct08AW44WA=;
 b=bRORFV9o58Xbm4og8tsgKVD8oho4hz2qvjSAAhMI95sU+FG0DZEATkz8jSRepwzDCD
 Hd9Ui1JgxdMp+Sz5Y6jzUSjWxndAOsyNaxycZVSWPdj/evt5kkawXk2TY+HffpCY8fzg
 sVt/ekp9Lwncy8u0MawVFLJni34U1oLgLRyXZsbq+1n95S7xdsKRErIMFcKb576y2MMW
 Y825xWuor4/Yjkfc3PJ0j5DBMzZ5Wpyu8rENfaXGgJ5drzkpPcH6Cw5vJi8UESSL7lxC
 IdJ/Vm+dKw8wOMN2EsXVS1NqfHr3TsQiFJuaTHJQ2hBIT/zb+YzB7EEGJcxU3165hgFG
 cEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726833; x=1719331633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HjswWTIF2bPBshuYqltbFOwZ+QqTaElXct08AW44WA=;
 b=LYi2Fug2LdCS+AnvWoy0YPwlmgxIaT6mQWD+cmiy273OJaL3uqfjFcZrBRkmGGNTsQ
 RidE5tnsNyBs2KOUMC07VY41J+rj29mJLGZag81Vh/UGugmoxcY+PUV26q3RuP0V88xR
 L9bs7dO5SzJZFhp76uR860C+RlK+b4+KHnUunYf2Hx8kNnae15N6sIpdessY2i/AcceF
 kcQMjLL/0nJxfmLirGActuCqWpdu+9INCycMls/O3VAsn2TvbSSGyayjhRuG8oiYp0AH
 rARJ7sAgdeR7z8ZTLsXsTFMMKRbbLhb+Jc6MuQcpfEQoi4ODD/kUBs/bS12Z0JkD5wCZ
 vQWA==
X-Gm-Message-State: AOJu0YzQ/XdooqE1eufsy7NqRnAG4QTzRpvCJhQpPwFFaUvZ0Hww+Vjg
 9QbvtqFThMXCH6cPfqUAOY+KKuqL0kaLLEzgj4QuCDxBhOCNuBpSXAvIm3Kc9W8t4AJ8Ndcz96S
 Q
X-Google-Smtp-Source: AGHT+IFY6S2w1YHZOpFTLe17oJe/vxxviZmOPnRRU6vlP9rcSDBdCtagh6Ju/NBs7VQ5EsiWMmpm1Q==
X-Received: by 2002:adf:f983:0:b0:362:a46e:e7e6 with SMTP id
 ffacd0b85a97d-36317b79c8amr22530f8f.38.1718726833454; 
 Tue, 18 Jun 2024 09:07:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3615d7a1a0csm1929801f8f.23.2024.06.18.09.07.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 68/76] util/readline: Fix lints for readline_handle_byte
Date: Tue, 18 Jun 2024 18:00:30 +0200
Message-ID: <20240618160039.36108-69-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

While they do not give warnings under our current buildsystem
configuration, my clang's language server daemon was complaining about
missing default: labels in switch statements.

While at it, add /* fallthrough */ annotations where appropriate.

This is a purely style and not functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <16f745ac7f5fef74498709ffd98857e76edff6aa.1718265822.git.manos.pitsidianakis@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


