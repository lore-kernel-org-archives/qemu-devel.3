Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E299ECCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY98-0005AU-KA; Sun, 19 Oct 2025 14:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY95-00058v-ND
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY91-0000ZL-Jh
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:42 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-26e68904f0eso36671455ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898518; x=1761503318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=bDt4+SzPPKGx2QR27QPUuCHvIATmg/kKmraQMhn+LFRBZGurNVTCwZEmYFc9FZy3vJ
 gDcDlM2Bh8dtw7Ef8yZuRUAKjSTLw24Fy8UY3s5yZlclp+ZyjDb7k4qOsLUk9fIoe3f+
 qHEu8ekHSwQXg1Ad1elzkj+wOhCrrSo03YqeEw6SShY78T2r87RMaIQeTPseHsu+hoM3
 qRaefrNpfz8gLJm0Rc/QamE3+DlJ9ojFf4eEpyFKL5Lwy/rfNZWHY+wZ1oof6s9jbhMv
 CUf00i80fu7YPgjMGhS0fxgAPbCHgJ8imBlIffhb5frS0vq0QIvdv+1kI4EtRYYriUyi
 zOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898518; x=1761503318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=Qa/tyzJDCl41Rjrinf/EleQaTXByXXLMzoy29wDHr6qffhvrUsa52LSrxNeGdgJxOT
 2sRGUTWrkHZ2q3oYA34v9o/eOs1WocbNTX155HcJW062TzeP4Ylq/2/pnINIpNeuZlbq
 fiDSHQD0kmup0V6SvVbVFxjj/O47VSv3SOt3XvIpC59fUvKF+GxPH2VWZp2xzx+a58Ys
 +8fyBe7sdVZPUVfpjzcG1bfV+mBzsKg9M2RpBSzKFcyys3P2WL8OTL1t3Sh1+aMQSONP
 BXrqXmAtCiPRpZIEt/GrI5vq3/19Y0W1p0JdV95jI7LPOV9TXvIG22zd/r4kiD6wvD8G
 5t9g==
X-Gm-Message-State: AOJu0YxZ722cO7+jGxd2pFVhATzJc0CNwU6Zh0GnOL9WcOYsU6fbS66u
 Y8xtnNh6AH9kYqbuiiXnAC+9Q1ORkFCQfyQ34n+S/SM946TfafcRr/WCLc0BQdBmHw/vO+7901d
 xQp71Fwg=
X-Gm-Gg: ASbGncvBwV6YZHor1FNFICRNamQ071r/nKSVIK66LYMiu2lmNeBsAN81p1s11/n0OXU
 t8wEJX/WLYcHUxTRbSTHtm5m+jq3t3oslzFEn59qGP4Ob8CGY+jhbUfda8pj58ooEU4lREcCJOE
 BxPQJrsQ9p5FlErEhzalC1IaNEnhKn7UIUktuv8HBFrQl/scIIJnXiyYrwCUnWAjTnWI+Cea0Cj
 mlJ+dtOFNVCsi4GS+HJDV9QMU+fcoFR8gaA5PXHpPUu0H0G9Rw0LOGwoux5U3h5g2qAmVhR1+EU
 jKeBTmEH1XR7Gedc71v/5llgxoIpUSoRtNsbzoZoTSuy9HhjTLBHn/IMG+FW3yK1SBbh9RNIMLT
 iC5WQ/PUgc5qhYJS/4whLNU5HO+pdHVNf55PqKtGX4vROah96daJ85M2UodeDyPeRYHLYX8LQH1
 PBH1sxL6BiukuPDjTu
X-Google-Smtp-Source: AGHT+IGh+PAbDy2Xo7dzm6WOBjAnX4qq9nK8WzFXW4AAz/ilcDbOeejwCNOLBqUZRkpYgiZI7FHwdg==
X-Received: by 2002:a17:903:46c7:b0:28a:8ae7:4034 with SMTP id
 d9443c01a7336-290c9cd4b1bmr129232225ad.25.1760898517856; 
 Sun, 19 Oct 2025 11:28:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/9] kvm/mips: Remove support for 32-bit hosts
Date: Sun, 19 Oct 2025 11:28:28 -0700
Message-ID: <20251019182834.481541-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-7-philmd@linaro.org>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa0172..c5710a6a47 100644
--- a/meson.build
+++ b/meson.build
@@ -295,8 +295,6 @@ elif cpu == 'ppc'
   kvm_targets = ['ppc-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu == 'mips'
-  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
 elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
 elif cpu == 'riscv32'
-- 
2.43.0


