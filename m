Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4TC-0007K2-Hv; Thu, 22 Aug 2024 05:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4TA-0007D3-BA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4T8-0001xz-LM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42812945633so3987225e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724320260; x=1724925060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQnk0OGW+ME2/AwCx9SVTlqQyyVvO6CjKhuRITvFw3A=;
 b=qZKgagxgYPqCoM3S436bR5J/XBuvvazpWJDY9WJvXAtafmvUE5voSDcRSO5SzneC7J
 LThl3RwcoyW7owTyVrCWPTyRMnmA29B+jTu6nEN+lJU+pROfwNsxQ+PxVYpQDugLPB5X
 /b4KkE7V8ZxamfVuW7KYpb/ts0mOEX/hIOpRq/B4O2P4DbJl8phVdOAsPr4g3dq4aFeJ
 zO1HpbsKSOGzJpOAz2rXO5PJ6miQ4QwkZIptktsMl3BXLrYrsuanIGY9vjdhdvdeHWAv
 FnNpnepQcSU7Ns/idGLDmIrb6yglrqO4QZRh/XP9uVwIpazxetLisg0x/bmSSD7j4YyO
 jB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724320260; x=1724925060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQnk0OGW+ME2/AwCx9SVTlqQyyVvO6CjKhuRITvFw3A=;
 b=VWj9WhzBYHkKoUrf3ZrDKNBmyohssywUlvzW1KC4GS0aRx3UxJfa6XH0CfsiQMWlJX
 QclxueZLwiNprCk3szDjQSXKBWQ3UnM/m0iX/FlO3+6oZpW+NhGbZ6FSNpyK4caBvpzy
 N3cld5iLz8Wa3bP1AG2963Di867wWuzgyuu5CaZRYoGqFQfmYLB9vB9Wut0K8swppyTO
 aWOWMPNplVlfKAUickRMm4TNEvifI659RUWS3OOkBnqaJbuQoXWJ/l7VjX2SKeJx/HDx
 /We+3Fw7ZnZayYL2noGoVv5Li8P4uTIM1+HTv7RI6lPr97oWmTZY/NS3YnlujGaPSgfX
 xKFg==
X-Gm-Message-State: AOJu0YzyLQyURM1LD/wx8/oRVTEClK0VY+QKjSJkzfUPo5dJl43uBIui
 i2I1mSJbyB4xtyRxkIcdkLQDMChBHruZRqbP2EqlegOD/uUWXx+z1Cte9r4mF8/ks4mzqr8MM9L
 u
X-Google-Smtp-Source: AGHT+IEh05fT8MycNuua9GWWULedky34BTNZSkPh2E/Bn7KKuN0IKFSssZ/GFSrUh0tw4FKgcCD1Cw==
X-Received: by 2002:a5d:650b:0:b0:371:9362:c286 with SMTP id
 ffacd0b85a97d-372fd577056mr2924619f8f.4.1724320260355; 
 Thu, 22 Aug 2024 02:51:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730821a92csm1232696f8f.93.2024.08.22.02.50.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 02:50:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 2/4] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
Date: Thu, 22 Aug 2024 11:50:43 +0200
Message-ID: <20240822095045.72643-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
References: <20240822095045.72643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

load_flt_binary() calls load_flat_file() -> page_set_flags().

page_set_flags() must be called with the mmap_lock held,
otherwise it aborts:

  $ qemu-arm -L stm32/lib/ stm32/bin/busybox
  qemu-arm: ../accel/tcg/user-exec.c:505: page_set_flags: Assertion `have_mmap_lock()' failed.
  Aborted (core dumped)

Fix by taking the lock in load_flt_binary().

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2525
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/flatload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 04d8138d12..0e4be5bf44 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -487,7 +487,10 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     stack_len += (bprm->envc + 1) * 4; /* the envp array */
 
 
+    mmap_lock();
     res = load_flat_file(bprm, libinfo, 0, &stack_len);
+    mmap_unlock();
+
     if (is_error(res)) {
             return res;
     }
-- 
2.45.2


