Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81539C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQg-0004rb-CI; Tue, 18 Feb 2025 11:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQd-0004qZ-V7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:35 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQc-0000j4-BU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948021a45so58913235e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739895991; x=1740500791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMi6HKMJEZy6PJobbwMTCNEj8KX/6SAXVrdJz11g72k=;
 b=fOuqrudqQXvNXVgeU76ukVXM9qJm69cRz4785ACoMO6ChMuPAJo2xyvLOIrP5xG6OT
 752YOEStUEoda/HxfqCs+LKC0sSKoe2mYTfTBdA0L9F7H/EHnky5cx7RNwOnO4SOo7uk
 uf3x3m6VS91WqP8/kNETRnb4n/tpglsTnedHEHYNoXe7AbstpwrBjGLyEQIGNKaUPw9c
 cwaqeRz3tMqUDEHRznyunYikMSEzDA9NxjnnS3GuBPAuEuKVpfxAzJKXeNvY8UycQpbe
 PMHMERDjFiAcYjyaORN9U//kMTRqzMuTi6m5x4uq45Gt4GKWGWbMGRzzQBeGpV4cNfBY
 XAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895991; x=1740500791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMi6HKMJEZy6PJobbwMTCNEj8KX/6SAXVrdJz11g72k=;
 b=RnL3Sl8vVXikPzPBucOM54ZkqhUg9rdzcfj4oy75Q3r0seFkrEWuNNoV4BQ8mK0hJd
 dJQtVyto10jsPYSBD4qosutg+QMfUppe/Pzfv1kaCLNG4wewfhR0VepoVMYEVqSL4PGx
 RswbmU7i2gQZXsvdmd4Lt+f+E6/yegQhXAHvhFIJFQVtHBsf0mB0F8SvTKMaeMHAMvhR
 KmK7ahksUQd7SL0CAy0nMvjkCtboec+AHpE3l4P8lHJ5RWKRhF372zsqFM8mbmsZPLmY
 fvtuN/Ff/5di5Vl3Fk+lrXfWCb72rHcPIstK2R+6/2pu2yjkYt25z6ZhtMoOKXrlOJuY
 HHGg==
X-Gm-Message-State: AOJu0YyHwnIKsTvhNvuKpDCuK0tdtsbZTpfQA8iqhQ1CMtTyLi7llnt7
 sJx1YmCZmgKJA2RFpHI+fRjaD+3+PJ/Z3KHk2S/ocrGQwjhZS3DfYFmXLZDU38a8pjQjpjpUt8s
 wJtU=
X-Gm-Gg: ASbGncsgP9yyGZIfIbb4aNp+e9nzyNA5gkgU+l/7zdNv5US/rwnCaI2/l0moCuCI5LY
 aneZQyhfORKz6J91ZFSAax4bDNtbgI/p721qVJclwkhahE562UUphLcmpgr50CckpH/SDpHsr+n
 c+Sweon1gyQwFBCWMNpRIJ6oKjPr09TWPzyLrBihO1jK/JE+tL8Yg1HPehRYLSVUTOpJYd6KRAM
 TE/2lHccrIwSkrCAmmdYVbj5gympqMlVJFXeyrfW3YR0BsgtqxJarVx5PfKEZCiNFATy5Uuolix
 oiNmNrlDXh/hBdDGpxaob3xx26mIHRvoFFo/K+IfVcNm/26oeCIXHaPMX3fsTsq/xg==
X-Google-Smtp-Source: AGHT+IGDR/hUW2+zIj2HthGePLoD6GAPRVrHbOwKJDDnZXahEAaGlBqwa3h93T0HklL55mOUPzcfKw==
X-Received: by 2002:a05:600c:5124:b0:439:5da7:8e0 with SMTP id
 5b1f17b1804b1-43999da82bbmr3503685e9.16.1739895991236; 
 Tue, 18 Feb 2025 08:26:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439941bd54bsm23641345e9.11.2025.02.18.08.26.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/8] hw/arm: Do not expose the virt machine on Xen-only binary
Date: Tue, 18 Feb 2025 17:26:12 +0100
Message-ID: <20250218162618.46167-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
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

Since the Virt machine is useless under Xen, do not even
try to build it there.
A Xen-only binary now only offers the XenPVH machine:

  $ qemu-system-aarch64 -M help
  Supported machines are:
  none                 empty machine
  xenpvh               Xen PVH ARM machine

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 256013ca808..e5f4b1d84d3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -2,6 +2,7 @@ config ARM_VIRT
     bool
     default y
     depends on ARM
+    depends on TCG || KVM || HVF
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VFIO_AMD_XGBE
-- 
2.47.1


