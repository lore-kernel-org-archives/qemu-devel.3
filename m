Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B79C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVv-0004ZA-9k; Wed, 12 Mar 2025 23:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0004YM-Bc
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVh-0007Zj-9x
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2241053582dso12845105ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837527; x=1742442327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBQxmR44l3wcTYT3oEMIjdMUBd+/xO2J5+TsC/x2ZxA=;
 b=Oj39lZI/0YncivTOeT+HmoOUMeBA0QPOrRyXo+F5AZIUfHak+fS5cjzniRp36JX6RG
 MegWgb9td/+nqs8Q5cmzvdU2toHe49yW8gTudST98VWKCLpI4C09FRT5P2/K4ftqPb9n
 Ysbj4EFI8sYPbpxuRho/XJ8PjrEWXDiOhRblCmXiwJtBkXCpgnQfN+7ZuZC/n/cMpap/
 LAMqP69cFdJXx9bpuYvIjql2X86uA6rne5TKFMJ8UUegjXZTspu+X62g2D6XWlirH0qV
 QYZNDRtIS7bPuq+xHXrEQufD1EfS5icZdw3df2p6bJuTgCYzMZoPhboXYLYq1xF1l3Vz
 oXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837527; x=1742442327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBQxmR44l3wcTYT3oEMIjdMUBd+/xO2J5+TsC/x2ZxA=;
 b=Tp9senwdXjPyu+XVfPuxMT/D/Y1ALaXbNSVhzphpwOAk1e4ecZNg32Ude47uA9G/6L
 MQzxQ0zkahf63VMGJYM0RHxSXgM0LUr6xcHap2ST+Frr78cG9hazy4XB444zDP/jfI2X
 /66JhPFjblCMliag9oUJhZS+D4iR5t7AIA1OkHo3J8X4dtJ19eaLtoIkaIxwIf/Wob3m
 TiHlyoakSFxHML5/C5thdA7vSfIMt2R3yPMZNuWU83IXB38GS9JpHj/jNK5iNi7E+vS8
 6z3AqCNuerqZQAsFDoRBcklK5WIUktl7eKejCMbCmeNioSrtlhbgGbK0yXo37oxkrXmr
 gD5g==
X-Gm-Message-State: AOJu0YyZ1DX2e3mveRD0T+Iez6pCUpdfKHSAojsxSjJgXHTr/yQhZm8o
 Q2tiFx1SHrppOT3auXg867gLgtpO4lNsHMxs1NU22wBg/Wu2EFu2MCoal9YWMRaiI6ZT7TkOqEp
 5
X-Gm-Gg: ASbGncvtLnASEKIJAGQh4PcJQpKpEibAv9AfVrlVYY3sM4yUHc0jB7OgG9f/CvSTjnF
 0Q8C6MZ4Suem1iOVH4W6fcfqiv39AbzU/JOLK7W2fgRuaeiK2pscf6jHOBabZ6vNqdFqOYcb1xT
 VS/VXxHG2tfsLPn2GohuB+SeSqqKK9DHP8ojaNE1fDzrgvJZdz3T3+cf8dtdqctC6p9026Ly/x0
 ACoE/za834ul7sq8rY+8wJMEEim7/EbJIorjBvTnCF6YdrbaYu+iD41ryCzSJhtOGD6r8x++vdG
 LgAz4XrTXTmW9YXCuKIgMemW8lzyS/Ybs9trnvDOyXGkGR7j0gzpTS0AhGHMFPw3A1Qlv3BI8CR
 D
X-Google-Smtp-Source: AGHT+IEaAZy0IYkXI33o+3dAp/nX35VY7pdPU8aKnqA54qi3Yp/slABPqqGttmcZKZNHXO5lvCORQw==
X-Received: by 2002:a05:6a00:843:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-736aaad3d00mr35952286b3a.22.1741837526882; 
 Wed, 12 Mar 2025 20:45:26 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 01/37] accel/tcg: Build user-exec-stub.c once
Date: Wed, 12 Mar 2025 20:44:41 -0700
Message-ID: <20250313034524.3069690-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

CONFIG_USER_ONLY == !CONFIG_SYSTEM_ONLY.
Therefore it's cleaner to just add to user_ss.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 38ff227eb0..14bf797fda 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -12,7 +12,6 @@ tcg_specific_ss.add(files(
   'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_specific_ss.add(files('plugin-gen.c'))
 endif
@@ -22,6 +21,10 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
+user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'user-exec-stub.c',
+))
+
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
-- 
2.43.0


