Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3083DF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvS-0006Sj-Qm; Mon, 09 Mar 2026 11:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvR-0006Le-Lf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvQ-0008Qa-4U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso14194075e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071622; x=1773676422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F1/3YUpYRmZXjja4BuejGPaJcObXsK5Vr2HdAMOPQ14=;
 b=Uf/sISJsS5Y8Cd4r74HKM+EOPVhiftpkXbDRTJHSYwcHQiqD0l5aYkGkgIK0wRen7Q
 MiFBsTv1RbyEe1Gof2VYUj/OVKZuanqUB5nHQRpfWYVUJ7qgdCSWThwEopgRguzD2s65
 r3fyv+QGdj45osv4stLXvpdWy3k1JGzzc4ecl+cxCPed0LmFr2Mkka1wB32rk2+P7AMk
 1qQOHM+B8BjnccWF9Bg6lNSuD4oCUgySt+IUiGygTruwq6vg+gdG+Tc0SsBc+9IN8pE1
 E/9XIYOS1c11FSTTUq09W7Vrh131/BUOOp0QgFPm9x8MHh4yinvgp+HjrrMMe6IpvMqX
 U2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071622; x=1773676422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F1/3YUpYRmZXjja4BuejGPaJcObXsK5Vr2HdAMOPQ14=;
 b=khYslWKghTGx/u9OoYT/1+o0M1QMhnJYyLCXHzJRfuH9jFTkQphSIGlCi5fa6O9czm
 rY/i4Y+nlD7FiTyBHpIwU2yOYWF79sKOXXiFoBhMgB7pgIKdSfjrZWWyoAzz486bdKeN
 gcTWKzMVCJtm3opuF+X3uIMrhYp1d+autWxwT09iJX3vyzHa9GT/hiz2JONwj/Mmxt/+
 DbzLmnCLDiJpDURH1cm/CLukrBYZB18Y/VsKbIhkQ6Lc07rc3mplFkdpzNeb3JXH34Oj
 ODqqWQ8k9YHLNHX6KFuiByA7A/QNaB/nynaZmgM0U6bWWIu9kYj2y6WtfNS9K9SzCx29
 eyOA==
X-Gm-Message-State: AOJu0Yzj8ScnaxyFAv94LsMVhh1vpp15crOjqppYh4Y1kshh6TPBgmuf
 anTHkJYCKiK4v/EPN/gEx6ZWwc69sZFoKL6Q1v0KNPli2IkAlhnjFSZ3JSGP1xSkIOD2XRUSp1R
 P5+viMag=
X-Gm-Gg: ATEYQzxLneOKNzjKYOPJY45JYYhVRO7Xm7vulD9+GLW06A8fvfxCeB2Dqeb8VaU9THj
 AW6UyADRiizXd4VPBvTsozYAacRxXMOWt18JCvQVa8c2AdG9rSRVl16WH9FuAcFii9qR4PIRAXM
 WbSFTN8+IkT9nfGiLUr8EELEWh6ZG5kv5NHzw7tB2spAKm87vcYLorVyaWkJBsvsqUbpiw314ty
 6qVxeXJQhN0ZQWXpBOYfs7VkcUc2cvwcvEbsQQqT4fvk5SG7xa5xis+VBSn75I81siudxKI8R3N
 Jpk75/Nir5yqfny6FePINLAwwpeyKjNuBjLKSvwq+P4hIr2yD0z1wGho5OX6KhYgwgVLDh9unFz
 dZnEx+SomCKyAURcctJ9c5QVe1rA8X4su1dQmvYJJjC52XvnCq2dNhtEp9fzqnviXdg2MbH21UU
 UsiwSHrt8QKg/2csCf9CSEfKwkhFRDlRV9SO8F4knzXUSz6eUuMHfWRiCSoAmjE0RMoDFaRna1
X-Received: by 2002:a05:600c:8b53:b0:485:3b33:f4b6 with SMTP id
 5b1f17b1804b1-4854192dd55mr2171895e9.0.1773071622071; 
 Mon, 09 Mar 2026 08:53:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f1f5sm1661765e9.4.2026.03.09.08.53.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/49] hw/i386/pc: Remove pc_compat_4_0[] array
Date: Mon,  9 Mar 2026 16:51:42 +0100
Message-ID: <20260309155219.62400-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The pc_compat_4_0[] array was only used by the pc-q35-4.0,
pc-q35-4.0.1 and pc-i440fx-4.0 machines, which got removed.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307154202.86309-4-philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4e1dd436ab7..22325324d09 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -268,9 +268,6 @@ extern const size_t pc_compat_4_2_len;
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
 
-extern GlobalProperty pc_compat_4_0[];
-extern const size_t pc_compat_4_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f33e3f72656..addf602da08 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -177,9 +177,6 @@ const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
-GlobalProperty pc_compat_4_0[] = {};
-const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.53.0


