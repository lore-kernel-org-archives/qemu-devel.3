Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C69EE7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtr-0004eD-Hl; Fri, 10 Jan 2025 08:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004c8-Pz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtj-0004hT-Hq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so23915835e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515078; x=1737119878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJzUqOg+3Q45qTACp4II/nOiuychCFxscRRDpX77QNY=;
 b=AKiUSYDexApgTRSkEP0vf6tXjBLkfg/YZmjg4d4bvwbFUKIbqYhMZmGYTV6cLGFYl9
 DY1vPI4RWxrz+6Amt5VStTxIHFLAgnWRxM4B0fxNUFQCBp+DyjaxY6PZEE4Srh57alhp
 /E/eOPjelkXr2vk1HAaeO3tgyvwa7GYTBlD4v7aerasO+1lL8xkRwQ++zZ67MsA3r0uX
 m5JsuPE6A7NYMRaRQsRlp3wl4mAo8iny9XLmWOVxz5n0pLi7UqFbBShbtAkRs8gnfkjn
 vHDV16CjoAKudvuGl6kWjG3oZ0oGMNPdqrea2u7gorNtpiuNQwRscZjFQ4W7A7S/2Hit
 1CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515078; x=1737119878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJzUqOg+3Q45qTACp4II/nOiuychCFxscRRDpX77QNY=;
 b=pdUT+eVbq3Ic8I/5YRi9mImqoQdImTvefuJYy21U2qclwdC4CCJrWECqaIeWYzYs2l
 wQASWxNijDlPFVsTxfpM5K9R3IQ5pPkXWHDKEQTfX5f3C90fR2gN/qQ/LtRGULu8RcJ4
 pRr9nzfG0mJ0jQxcC1X9GWA/83taCZqfoqqKTFS2EgwgOk97ZsdjMg7COiF1Ila005CJ
 SsCzHtaLxeipN0hBaxNgAGrX8Jx9oqti1fcLpFg/Bg/ToO+qP3b/E9BmfIkq/haBhmCc
 GU/84toSngKYypkOBzJ77EyOvECQ1C43giS5nDs1+BbapmqwzCsEzSA4cfqlq7jBG4Kq
 IFNA==
X-Gm-Message-State: AOJu0Yw+m6QNuDCIrD2QTrr9ttLaf+jy+6tKxh5/BYeKJdO+04MixnOg
 nzjiv8dS9Om28vtGLZSjF8GKEjic/iX1GeKWUlVeYFmDhke8RdzXXhL8vvK+T4w=
X-Gm-Gg: ASbGncs08BrjJAOfMNXJLpsavFY8pBTx0BZ203q5s556o2DLgWxI0vplOJUfbQpdLaS
 VoaYFrnhUZ2vd2HCXz9qi2oEUl6DgDJ/oOFuzaDxRTEeEAFCFgXc3ZU9kfgv/0wwuawADJobgdj
 I7TA49v7cb309OUo5ikREF22H9E/a++yk3yuzc39aYAmILgthxHpc524gTBF6eKz6+oSnVkxr4t
 zQ8r18//AErZEhR/yPRVdLMtyzxjq5mQc7e32MLXYt3yG0vD4o+HHU=
X-Google-Smtp-Source: AGHT+IFpfgWz2oRwy2LQEc2XcypplqgoB+ot0OEbs8vZawxti9EPXaodq4kQGu+oNpBW6O7nAVHT2g==
X-Received: by 2002:a5d:584f:0:b0:385:f638:c68a with SMTP id
 ffacd0b85a97d-38a8730b738mr9946490f8f.30.1736515078111; 
 Fri, 10 Jan 2025 05:17:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89ca5sm86475935e9.29.2025.01.10.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B83AC5FB65;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 07/32] tests/functional: update the mips64el tuxrun tests
Date: Fri, 10 Jan 2025 13:17:29 +0000
Message-Id: <20250110131754.2769814-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-8-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/test_mips64el_tuxrun.py
index 819549a27b..0a24757c51 100755
--- a/tests/functional/test_mips64el_tuxrun.py
+++ b/tests/functional/test_mips64el_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64ELTest(TuxRunBaselineTest):
 
     ASSET_MIPS64EL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/vmlinux',
-        'd4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/vmlinux',
+        '0d2829a96f005229839c4cd586d4d8a136ea4b488d29821611c8e97f2266bfa9')
     ASSET_MIPS64EL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/rootfs.ext4.zst',
-        'fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/rootfs.ext4.zst',
+        '69c8b69a4f1582ce4c6f01a994968f5d73bffb2fc99cbeeeb26c8b5a28eaeb84')
 
     def test_mips64el(self):
         self.set_machine('malta')
-- 
2.39.5


