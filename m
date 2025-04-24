Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD19C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tBI-00085p-0o; Thu, 24 Apr 2025 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBF-00084S-9s
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBD-0002b3-FG
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so869328f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488057; x=1746092857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlhuEFGU9Yqfmcq0obyYoUcjG/F2c98mBOFnS8by1sw=;
 b=ruYTKxkwv6Dpf1z7qxS4LEZXRZ7Woo/X8nAt0ucDEZe4u46YqIqwI7WmM5pccilzfk
 lxSnpX/Z8WKJKcG/PXpC45W3HDTePOwNAgbRx5zP6Nm5eXfscPslU1tvAnxuB2mF97pH
 +65bsaDXZrdl+iAYLf+BqE4xQEn1AqtyHU58M2a7ZoYE7OZgGkck6294I2Yve8RsLLZI
 OW5VV1R+yB0y3DKyjKpgW1QufxLHwKRDZGMqbOGi2DSvX5gv/bKNy61fXDx/G+dmXIWd
 U3mQ71MlojeYtSeNsN60JjDiiCMwmQg8pQbdkN0B7ccGNc0ljKozg9E1roL/T/A7IseP
 XcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488057; x=1746092857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlhuEFGU9Yqfmcq0obyYoUcjG/F2c98mBOFnS8by1sw=;
 b=Ggt7ANolAt5MHl7b69U6DF8KmgiyCC1e9//Lzyat/Q3iq86RIH0LX/OClqBqpbl8sv
 gWuG/kkautyez9B1gcDvKSe6/qBwVtu6Z85vhN3uR2bD5ufjAMkVVSUFalxHnMuSczn/
 6hQIzA6P8V7RCywiCURnkBg/tIJMhkNbpAxhR2A+wwFsmiQTE+OFQVNrnnllKhX2m1b0
 vna/h8ZTJoYly9x9XIzHz1wDUMX31HEC/f+LA7ubzJ4PfntxkpMfaFf7eHsE+w/47WqM
 8nKwTo1HfxB5Y3RRtCIfZxJ+u6cOXeY2g7MY516r2M1FbRB3+pV2qWb0plBfwQGXR47c
 QT6w==
X-Gm-Message-State: AOJu0YzpFI8AxWWyqL6017M0sifvP2bX1RYlWZjt+D/BmCzKqXn3qL6I
 D0T3ambU5/RcvCFC41TRfcHYZM9Rs6QDd7bng3/kZwOVKZoFG2dAZXw7m6jvYKrAjwcPX9TQTs5
 Y
X-Gm-Gg: ASbGncvhsaNzg9FKdtAk/AuAnkBk7sCr0cxBjlbdULPdbLvCo3gFAqNOEyJV6C9xN3o
 Crd9FFQCPEw2kLguBok8qUHL4SE66+4kj2D8eARXbq1FZxXutI3CUjG5yWMb8fxbdbHlTCzBxba
 d8VzdBICAatDw8K9NNhm3e0piFbVpzU7zpTHozzDvoV4AHwEJaULs/3TJsZAd04UNCGFnNNWd2Z
 k/9cInVP5qByZ5cpd7A/kpa3J6Mc5xE9tGMrltD5rus1k2UY8scD4qHmh2lgfYBG4/H67uETGZs
 CRPV1mbr1MmuGRBCGx6FgZyhcSW8KXEWmKj6/HxqtC/bKvAyshYxURIG7d9EzOrAY0KGsaDzOQO
 pd7ELgSB7c1GvOXlIk8CxFP6xD5cmgoY=
X-Google-Smtp-Source: AGHT+IE729x0GtSY6eolx8ZzcKDg8K+xP4HNHr4zxyJg8CfKZB1aBsHTGqETuqFQ8pWOUamBhq1Pcg==
X-Received: by 2002:a5d:6daf:0:b0:39c:1efb:ee8a with SMTP id
 ffacd0b85a97d-3a06cfa3477mr1649055f8f.38.1745488057602; 
 Thu, 24 Apr 2025 02:47:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a2fa5sm13668615e9.9.2025.04.24.02.47.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
Date: Thu, 24 Apr 2025 11:46:49 +0200
Message-ID: <20250424094653.35932-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Most files including "exec/helper-proto.h" call GETPC().
Include it there (in the common part) instead of the
unspecific "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h            | 1 -
 include/exec/helper-proto-common.h | 2 ++
 accel/tcg/translate-all.c          | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c5ad98c6a9..816274bf905 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -26,7 +26,6 @@
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
-#include "accel/tcg/getpc.h"
 
 /**
  * probe_access:
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 16782ef46c8..76e6c25becb 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,4 +13,6 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#include "accel/tcg/getpc.h"
+
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 38819a507b2..0408e2522a8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "system/tcg.h"
 #include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-- 
2.47.1


