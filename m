Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2DCE66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfCP-0006yX-UT; Fri, 19 Dec 2025 13:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfCM-0006xs-78
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfCK-0005Yd-Pg
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477632b0621so12887245e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766168847; x=1766773647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpVBRqx1qfeVuk9oF+fByqxYh3BOioTsbTesg1hLqvQ=;
 b=Fezy74WgAUIe1S4J5pWXbS9Wayzpt6BwhlO5eZ5XTjbUIjRBR5s47hkzQawO4bHWAW
 OGEbdb+sDtNfJWnx+2tvEPUEEFyXQWcJ5HZPTi3MPcHvDiVvK/4tq0OD5xo1KbxnLOUs
 hujOiirgreIfCeTWxIqYLIm2UsVkkXNr6tqoOMmF2G+uwoGpKUUmrtP1prR0+JghQ5rA
 kYcdLbtteG8csvn+j3VjQrCl16y1IKdeFHrCaDvUleTCNW/aQTvDjpyT8Jf5ezGpbZNR
 TCwmxxzT61i37FFf/hZRlOiIl+mhnnQpNxbqzbcMWtNN9k236ZKjs1LQWibYSmuei4vc
 xNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766168847; x=1766773647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vpVBRqx1qfeVuk9oF+fByqxYh3BOioTsbTesg1hLqvQ=;
 b=edm2zP/hdtXILLkF+IUjTzp68Sg/jZ7DjFlGy5DX2ia4NembUtj0xhUPAI1+fR5Nwr
 n0581xTyQUuTOy2kJgd4Do7F2zcvPvInMdPAFDTZP1vWM5ldGVY7AGKtv2xFz/lBEF5v
 iqNUNpnq6Yg16Sh0P+cLTiAKWsy0P4FUuXKSQd+HZy/oetg2FS4N0Hm/7A9xqpkYfktd
 7uSqe3FJkz6PDFSzc6dmfohkz4Ht2YtBa6LkUmWGSxx6QJrs1x6q+tkz44xQrjkYyLHx
 4qaCDkm3UeMCisnObJyeEol51ye2Nc9sFHbZ9OYZLHBo96wA1CBirHlAwRws9sNbjATI
 eV4Q==
X-Gm-Message-State: AOJu0YxVnK8lZHoLDKaWTEger6jFe/RTF/YVdQ3YJsnLCJGllnQy7ohj
 OrYdjju1mEyeTogJ8jLXQkJyEsMN1wYTlOC6we7csAarqRzKHq5n4KZGxJrhz9yPU2B3DgLS9B9
 SDZ7RXXw=
X-Gm-Gg: AY/fxX4G5e43cWnwYA2kiGowhF74Qrpjt7XdUOxXxU9JCTLNtsk6/a5eawWgZlPuHis
 KZiz3giMdR3dp28tv9VU0JDOC2dtZvlJ+HQiigvruQhhJsVM05xk8HshB/7Y3pKnbhBGE3hmwg+
 8odiK+Uf/Olx3GAA37LRX5Xc+Bp5oZmU0k8DTqBmKiKGqCbN0Y6jgNHArsVSXiCaRFmMTnHVrfy
 ZCRvjzU59DRxeKkqMYEpGh62XQsB9JpDbZo6aQj03r6ti/EbaLFlMzcnVqac58fS604CyEPbMuk
 VYSGNxX09FC31/uxt216gN2dGYuoBSjQquITLlxJ0gHKuAmQcmHON5XQT1QHVtJKy7Nsaynuh70
 zIY3WrgdpRja2W1zccgieFEDgcZIh9PKK2WLmHJj08yZA+U7tq7ojHW5apsLbGgsSomGZPxJ/te
 LMG+9n6OVOA9jwvmWirG8F7q/IEWhQXoDNkoQNR5nHbXZQj7IwbsSNYIUIR0Nl
X-Google-Smtp-Source: AGHT+IEQWdP9GdAiJAm9FG351lPBWqIMY5CIVsmGG3kZCQkBzeyyYgE4CSyK+r5aOXxnATuAAOQF8Q==
X-Received: by 2002:a05:600c:820e:b0:479:1a0a:ebbe with SMTP id
 5b1f17b1804b1-47d19578ca7mr39385405e9.14.1766168846997; 
 Fri, 19 Dec 2025 10:27:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm58428445e9.14.2025.12.19.10.27.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:27:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid OpenRISC to use legacy native
 endianness APIs
Date: Fri, 19 Dec 2025 19:27:04 +0100
Message-ID: <20251219182704.95564-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182704.95564-1-philmd@linaro.org>
References: <20251219182704.95564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All OpenRISC-related binaries are buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/or1k-linux-user.mak | 1 -
 configs/targets/or1k-softmmu.mak    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index 4cc6f2a6616..810567a98f9 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -3,4 +3,3 @@ TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 5a8eb66cbc5..0e47d9878b0 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -3,4 +3,3 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


