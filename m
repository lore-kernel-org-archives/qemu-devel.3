Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53693C0219B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtM-0001sa-Ml; Sat, 08 Feb 2025 15:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtL-0001s4-D4
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:31 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtJ-00057S-U0
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:31 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so37240915ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048248; x=1739653048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83rDUEYq9wOvP0NwfgWL2G1APFDj5PaKxVull0vQqa0=;
 b=SBYL+erU7+6ZGt4cFR+W0yyQp/YC/1+ANcDswvyfPt9qEZTdJ+QHRGuePriHLTNULx
 6GnrS9OUD0zDg+T4/C44+cRKy1fzucaK4uG48fsbWTcCMT0qw2DxD4kxB8UR5JL70Q0L
 9Ob9BjLXVHRYUw4MutwheQ+nyWMGepFzuMsF662ae4bbRoQ4FmmcSjlpXSSGIYkDIwze
 8MpL4Gm3ku/cKv/hcpzxyyu7rtpRYq7awW0i0h0SZWfUF0y7sTYkH+ksWjFfIbj82eDF
 Mth9hubBslr2jhS7m81pxSV/kMe0qTxQhSIDt1TtFvTi8a6lXcy4IJySCdkgDe7C96jl
 8Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048248; x=1739653048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83rDUEYq9wOvP0NwfgWL2G1APFDj5PaKxVull0vQqa0=;
 b=XBdHK+6AS98K3mSyqebLDbf0JRKrSzrXDK5UN+1n9md3pNJUTZokElQGFqEiJjxnAy
 j7GWOQqFBe16QcS/+Pp9dnEqvm2+fygzj8giw3Y5jLYecOZbSCiZrP/Zzm5gz6H2R+pv
 a61BjS6zKP1MnQJ9ApaWm9Si1qp5iAW5ZutRNdA4qBIXBH5sB72bzDoXwsZky/l4BJcG
 LGcM74YYFqZHbMochpfvMwgttf97VW3GYX1FdrJGopM5wkjUqeuDDg3OKYGkWDpq/0kl
 F5xVWvy2my5f47XEH4e/tCBY8yKrnEyudBvd1Y4eYKWpMnyTsvvAfp+DTqH3cn0gkph7
 nOCA==
X-Gm-Message-State: AOJu0YzCNmiB+cMEPAFO/Bu0DhRDwNoNuq2cVzPn006/aQ/W2K48uzp6
 ENfPiwXhzTQEJG/r4WNg5GZlsiymH2DGXj/xbwIke0YDmlquzNqUchgoCw1sNAtk47AP0v6Ucag
 r
X-Gm-Gg: ASbGncvQPajH1/ileOMdoIyRq5D8J7YMfvRSDopuH4xs02/o7D+hP4OzKRFSdm38L6a
 xTEhy4cQEvfRe6ccO8EmPjaXg1nUeFvjKG1ztlR9R2an8mgaI2dH8wNAzwyR2RO251EJu4lTVJO
 4nXF8j0hN9iZ1DJgWFk3XEyfnMqwYa8WAx9UFs/5aDceCzLK7dhLJKNE94jICxJjkvJiZsVDHq9
 aOErj/mkf7/m+O28Qr1cYt5+50Tc1mvmxQrtmmDw3DbWkgYAw96QpHdlb5OUG71aqlvZUWAKzhn
 nuXsEbVXWYWfAcubJ3iD1Q/2w1tYuQ6OHoEtdhRnEW4diKo=
X-Google-Smtp-Source: AGHT+IHR5XbiC3W4qEz5o6s/acQj0eIQ59PIpwytOF90inFH7/39rRhpg1+0fBe5VcO66Ka9M/r52A==
X-Received: by 2002:a17:903:2309:b0:215:58be:3349 with SMTP id
 d9443c01a7336-21f4f17114bmr149994135ad.14.1739048248429; 
 Sat, 08 Feb 2025 12:57:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
Date: Sat,  8 Feb 2025 12:57:18 -0800
Message-ID: <20250208205725.568631-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 1af8aeb194..911955cfa8 100644
--- a/meson.build
+++ b/meson.build
@@ -304,9 +304,14 @@ else
 endif
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'x86'
+  xen_targets = ['i386-softmmu']
+elif cpu == 'x86_64'
   xen_targets = ['i386-softmmu', 'x86_64-softmmu']
-elif cpu in ['arm', 'aarch64']
+elif cpu == 'arm'
+  # i386 emulator provides xenpv machine type for multiple architectures
+  xen_targets = ['i386-softmmu']
+elif cpu == 'aarch64'
   # i386 emulator provides xenpv machine type for multiple architectures
   xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
 else
-- 
2.43.0


