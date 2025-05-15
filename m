Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C6EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVp0-0000MJ-94; Thu, 15 May 2025 06:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0005Qr-Q6
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnZ-0008GR-Rk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so6075925e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304802; x=1747909602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3wG4zSFwi1rArYil5Li1hl8FAwjHT+ODNe0per2Kq84=;
 b=l7eleCc8Ttms/mi9j8gDXVgWOzFMurYcGGgy0Kt6rw584cR1PVtDT4Fxn3MsheF0ve
 p4Ay1wAiroB4Oa/QbImWGP0UVa1OAxlM36QBNiyiOfn00Bm0K1QqAh7vVxO5dpbHGiTE
 2tPCNhL0SSWX9YR9C4iRYuCoWBTEV5LNNG3a7sImKMO5x7xXQ0DVUTrh2esHsvwF0Bfi
 62Eo88Khq7tThCB68OscxWx6DAdMNZECqdvbUYpX0VOkYV3KlXCYu5k5stAkZxRiXuc1
 fOkT7jIyH0mLH/BQgi3c2GDa1rCKgX9N5JmHL/I7MHWteOpoPsbytdQwZ91f2+ti5v1V
 9JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304802; x=1747909602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wG4zSFwi1rArYil5Li1hl8FAwjHT+ODNe0per2Kq84=;
 b=vX08+bLggyaIU1jYVwxFTrRTf9xoEiXNCWW2vEE7SMz9urc6poIfUBVpyFS/ZW7k5V
 sf32WO1k/AfAgdLDWwXtlDxfGm2O0mS+ZuRnzjFRL6Rb4E1CwV7dWvb9gg9OkdWL15wG
 YjwXZM/oEhccSzxjTMWg1qz7ww53fwyObeyGN+phH4LmjuFyzYVSVTf9wt0fLojqjEH6
 bjP3jLUWUVcYodt0hWBIJmgI+Jh7P3RK1w0w/TAXkuwXcQ/pU+PfN/Y301q2Sm7LRIAh
 4WzaoXfWo+BtkwNRlbIhR7+IWDK3EpKFWR8f8UtDA9ncFhrM+S/qOuKWu/9iQX34ZFeO
 JU4Q==
X-Gm-Message-State: AOJu0YyMhTWZCSGXIMmO5iCHEImYUSL+PXD4QfeGK5V6dIiLfAR1vm0u
 tuKYSrgcZTZjzz9DNdafP1UQe9LtC21/PJGXO2bjr1vuduKnpKRvA2vllLrqow3pT28+insHsqo
 SNow=
X-Gm-Gg: ASbGnct3rL/FxmGxMoVZQWui3UpjBkGYxo/ZGmYmzVNnW8YiLdzXOBrirvl2iUZ7J4u
 rCvo592iimEawAkmcnxPPV7OUfEHNQ3GOSRTJ3YmQmjfr2TA3WR5+umk84d3AvtxSINxWWf5ay9
 mGcIsYpgJlATijTQZy/cvokQG04NsTxVh67gfWwLee6/DlZUZdCjQQ7ZtF0gGjGlvBT9zViC+yu
 Q3CbOQaQQ+ARBVRLk1KJekts6kIhsINt6TWbzNTF3kgjnuUDe2rPc3uIzHBv5fvxti88rx88M13
 1aSA9Aib9PgX0sqzkvMP0cUX56avlUU5GAQEMtwTOCYteLZzNVQwx8H/WQ==
X-Google-Smtp-Source: AGHT+IH8IOk/wznepBONykLnbHb6Ftnl4ktyw0b/jhsGdig1PVFXH8LRZLHma2X4yA0Eaw1GvwXPeg==
X-Received: by 2002:a05:600c:34c7:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-442f97063f7mr16670715e9.21.1747304802498; 
 Thu, 15 May 2025 03:26:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/58] target/arm/kvm-stub: compile file once (system)
Date: Thu, 15 May 2025 11:25:31 +0100
Message-ID: <20250515102546.2149601-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-34-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.43.0


