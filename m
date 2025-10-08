Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB93CCD186
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 05:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6MWf-0000Jk-9U; Wed, 08 Oct 2025 01:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWb-0000JG-6j
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6MWZ-0004H3-1V
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 01:15:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so54412525e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759900537; x=1760505337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eslKW+p03GhGF8z2Kg5qqE7QI5BhEBCgWrdPZ34U7no=;
 b=Kt6IX3YIG/osZlePISQtv8ObC0mCBBiD8rRnvE4ZNMvw+/BPW6ON5J6imgzmwyxsHd
 cyk7xtPUf+hoYLzQrWqQKLt9OqdArVTwhUYsYuJFLQXEcQTzyJQ87GBo9F66tYe4LLC3
 msojDH7Wna99u4GyjlUh6mJxmGln3gzwZF5seA47o3YAgJM2SD+IPxOBVyXdlmfVBF3o
 00OypL3rfjN/Qldkvv5BmnBwo48SrfsJZ4TR46/1hphIfiNdzmMXofgczxKDHW0n8DA6
 khrwwQeV+u1cHpn5JxBVKDZxcVd0NM5o4L+97kkxAB68f63r3KJi8lncwLMlHi1cj44/
 Sisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759900537; x=1760505337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eslKW+p03GhGF8z2Kg5qqE7QI5BhEBCgWrdPZ34U7no=;
 b=GOatA/WM7vYg7MBih35f6RC6WvQy/SiH9sQMZ0TQ4A6GUSn4IcZT8Z/eP6bjkRzFp3
 Lq+ny+YCabs+StK1m4tNlmJ9YpCLggGBeVCjtBgWvfsfQ7ldvL7SO71A7yyYI0CWrmzh
 ebKZQn+ca4yj/d+f7tOmiMZV+KjG30R1vU3/ntbGjyrARqUPD5BMy6GCmzvt15aCe+on
 WXMiSuHHnMP8YuorCvYwBZMdWqOoIHlJtZL3CRUb4sAkVRapQ3xmB17B+of1RfRxDpDR
 GHlTy77HfzvcObx/a76x5dUNpaV13baGivRQElXtuXrL2duftYNiGTeN+3XrAfr5njqE
 skRg==
X-Gm-Message-State: AOJu0YxUfz3aivXDzYmgtH52wD8E08XQ7GNLG0DZcghVWR9z5GK+SHo2
 5bGr+4FYTYmTb6DYx43Asw8M5/Ry0hDHEUcPfHnWdtKeLzbf+xbYH/E0W/XVGkr5X9WE7+ecyjE
 vIog+6hUxvQ==
X-Gm-Gg: ASbGnctAc5reCXjWGNJErP9SB3s75+HqrnnhTfe6BCMC+NYD6HWI+yKx5vS2ZW8z2mC
 Fc1fsovK1hDvcpbWerUISA4S+HFEaAGpmYHKP3yo3RBiHMtoBPwuFxsjIKAE9Kkwdm5U6dAzqnH
 VpJ6WkgHaCsPQOpWXGL+CveWo/qfAHZd+6fesPieiIu6mvgYM0oVP0DrBAlopxt+7r/unwGThxR
 T+p39WXyeYPhxZjVMW5hNZbQ60GvluSJ83G9zyaVTXsidrhlJwEC6LUT3Oi5bkGMBZAoXpbh59n
 FdWprleTSBV/0ChrNXqdTK1aqFeyBy+j/CdKeomk6/xKya+VHPFhyi37CAffIBKeEjkMTtHojtU
 kLqpnpnel7AUkTjJW3ogMQJi0iQGxC9u/8RL3yVRSveqns7wsRVjpB6sP3D4RlAh4bj4GgMuD+D
 SopnVWsn2zYRIVpI1ZCjZId3MK
X-Google-Smtp-Source: AGHT+IHeRV7H4UvPgPY0RE81CUgJNI4O/N7WEQTSupiW8+Z/YqewMtkrngxIWX+fwYisea+uVHF53A==
X-Received: by 2002:a05:600c:c16d:b0:46e:3f6f:a8ee with SMTP id
 5b1f17b1804b1-46fa9a9f006mr14270705e9.13.1759900536615; 
 Tue, 07 Oct 2025 22:15:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c1726asm20477635e9.12.2025.10.07.22.15.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 22:15:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/xtensa: Remove target_ulong use in
 xtensa_tr_translate_insn()
Date: Wed,  8 Oct 2025 07:15:28 +0200
Message-ID: <20251008051529.86378-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008051529.86378-1-philmd@linaro.org>
References: <20251008051529.86378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
for virtual addresses") the DisasContextBase::pc_first field is a
vaddr type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 34ae2f4e162..bb8d2ed86cf 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1166,7 +1166,7 @@ static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUXtensaState *env = cpu_env(cpu);
-    target_ulong page_start;
+    vaddr page_start;
 
     /* These two conditions only apply to the first insn in the TB,
        but this is the first TranslateOps hook that allows exiting.  */
-- 
2.51.0


