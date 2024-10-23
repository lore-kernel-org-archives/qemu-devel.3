Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F892D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9b-0007RI-IV; Tue, 22 Oct 2024 23:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9B-00071t-Rc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S96-0008NT-30
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71ec1216156so2644390b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654490; x=1730259290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCKXvUBSkRViX0aZzCD1w905ppkafna+McwzoZP3XIY=;
 b=dRlKKLHjkM6+T3YMta8Yo3a/Yj5NirMMxTga43y26lAMsrQFhR+DLdgD+7E4M6oSXd
 VbZizKUnxrvUV36rgaNrL2CRP5bv1gKqyrLJ0igqKhmzRi4FTKeFCvfT5gJSOUFK3hMY
 /hG5ed+Z+SewR1rFL9mZNG/BKntvvjTsS9blwaoG1S/NEpCEYXHo8RofYHQPtNaQzFfE
 VMCUBNXzJmP+XH6A+G25gHxMyXhK/knI9g59PovgbF00Wh3A7y5PpJKsPei1KUOkrEjZ
 Fgaq0b0szhKGMlCKI5QaJlXa9UeEiwU35KWq5ajEhoByvIf9cyQC8eNWpw/+W5UiF4S6
 GAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654490; x=1730259290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCKXvUBSkRViX0aZzCD1w905ppkafna+McwzoZP3XIY=;
 b=XlPnGbBTTFI+6lbEWI5TlIAjhtjRNTgYuiCyExpD/OKTVSG8mpXX7ANSRgpPT3kd0j
 T7aogCuyPJNCWEWiXFUAvBZ4AUyZyRdDwEbkzQepFPwlSQ9e2xDf4/EmwTHL8NFHp2RG
 Jr0eCdPiUD4qGpHpLBtKu4MQnOpSKfKqylKzfaNtBEhtpEbol3VUFtLZ//uY47JTbHr0
 2SucHg3esKJz/eeEA/7VbFspCZ6FncPnugC+T7X8B3xZo+kGFTu4kf9Al6VtB+srKyGF
 ZEIkwT+B7fzJsegoq5MhHpbzTiFZbSBxvhmwaw4qm9yCqvo6EPmcCZH7nD6lD+nP2DBx
 8Fbg==
X-Gm-Message-State: AOJu0YwsoPSErz/hYFcA4hkps5zoweOConRAxFf7bJwdNTWyIn+uFCUR
 mSwtRzQ1ozKbPBBoJmQhNeouQlY2iPs1JVyNxTvx1El70CERPBGHmm0gGyDdtkDCYrMHRu2CTQ7
 I
X-Google-Smtp-Source: AGHT+IF959KK+g75b+QF5E99mfGqenOKPXkjaeKZ1neAvLiQ/dd4tr6J9m+hhQiLxj7CE5mePcAKRw==
X-Received: by 2002:a05:6a00:2ea5:b0:71e:3eed:95c9 with SMTP id
 d2e1a72fcca58-72030c70a4emr2143538b3a.22.1729654490061; 
 Tue, 22 Oct 2024 20:34:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/24] linux-user/ppc: Fix sigmask endianness issue in sigreturn
Date: Tue, 22 Oct 2024 20:34:29 -0700
Message-ID: <20241023033432.1353830-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

do_setcontext() copies the target sigmask without endianness handling
and then uses target_to_host_sigset_internal(), which expects a
byte-swapped one. Use target_to_host_sigset() instead.

Fixes: bcd4933a23f1 ("linux-user: ppc signal handling")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241017125811.447961-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index a1d8c0bccc..24e5a02a78 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -628,7 +628,7 @@ static int do_setcontext(struct target_ucontext *ucp, CPUPPCState *env, int sig)
     if (!lock_user_struct(VERIFY_READ, mcp, mcp_addr, 1))
         return 1;
 
-    target_to_host_sigset_internal(&blocked, &set);
+    target_to_host_sigset(&blocked, &set);
     set_sigmask(&blocked);
     restore_user_regs(env, mcp, sig);
 
-- 
2.43.0


