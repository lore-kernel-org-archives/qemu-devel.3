Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C35CD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZX-0002yi-5Q; Wed, 20 Mar 2024 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZV-0002ya-V6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:45 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZU-00035M-CM
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:45 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a46db55e64fso274465566b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951222; x=1711556022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxFF+lXeHd0yKI0Ua/EbWo5MYrhYmKhteKonFtX7/6E=;
 b=UYUusye8mqKGJe+0Zog8qq84r9yQSf2f8VdlNPlgqgfVTEDybf7cdKnCk3fEXsj1RY
 0DQ1p0dIg/MAD6SR90FNJA+ubgt0KRZvS2b7lBt7bUsd9o0Wka4NzlRvi+q0zZcP0uuA
 mDrPkzF0GNlPHLGL9KruUNrK9TzD89YxNWyyNAa7eHbfcuxExNU+1orOiJgr7ZY1qkG5
 OQgqYIv65JZkjBkcZYTf2EKnyvvE+dVVFcOcF1A5YlNIkRVb6F5NPWl5+S0kkpgRQDMc
 i/rm6YRvPODi15l5yvpXb8O+Zjij5hSZEUAM+4DwdVFmaZP+qp8+C9uGYJ5nq4pORiZX
 Nisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951222; x=1711556022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxFF+lXeHd0yKI0Ua/EbWo5MYrhYmKhteKonFtX7/6E=;
 b=BmnsUYBnB680I221a7wDpNCyGuHms1N26fLRLhVm6c31tEdVih/0Vw1SrtjQMhHKNo
 pQuft9AqSRQFgvuhENvUbz3QVEsPBlfNl8b5zdIdEh+1ogSgoy34WMg7x8qMLlWWPpl5
 +m4DYsjBZb+dT/i+NLyviR3RANnQEPJIupFLWQrpyhF4JswjKN6h0BAYihmnYeFKKd8F
 0u69AjajXVZZLhd4qYaK0/9c5Vs1kguY3PIowNNGhEGNKEhIADIsIqPei0UHfdQQ9wnU
 hX4LDln8toB2OFN9ytxZ/PY0u5Cwvo02TxNW1AAgnV7vhoPiI1juasgWfy5UvYCjqRFZ
 ea5g==
X-Gm-Message-State: AOJu0Yw8W4SJDDxkYs1SskB9R74C5EI7VL9DIR20XLRt/TIJ5KlFCEzG
 dXAeEkXNtqhUvmjFQNXqoXZuI9fcc12ZfG9cq6zEinaYHtu4nfYh1gkhoHrO974=
X-Google-Smtp-Source: AGHT+IE5gzyKXVTa3S93dRUtPoBZtGMvGH2W39MChXIfJWWnkLO80NqNJRrvqdYrQ6AljztcYtMfpA==
X-Received: by 2002:a17:906:1856:b0:a46:643d:9a3 with SMTP id
 w22-20020a170906185600b00a46643d09a3mr10914707eje.61.1710951222070; 
 Wed, 20 Mar 2024 09:13:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u16-20020a1709063b9000b00a46e35bef66sm1940559ejf.219.2024.03.20.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D7735FB8A;
 Wed, 20 Mar 2024 16:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 3/5] tests/avocado: drop virtio-rng from sbsa-ref tests
Date: Wed, 20 Mar 2024 16:13:38 +0000
Message-Id: <20240320161340.391798-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
References: <20240320161340.391798-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

sbsa-ref is supposed to emulate real hardware so virtio-rng-pci
does not fit here

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <20240318-sbsa-ref-firmware-update-v3-2-1c33b995a538@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index cbab793455..259225f15f 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -132,10 +132,6 @@ def boot_alpine_linux(self, cpu):
             cpu,
             "-drive",
             f"file={iso_path},format=raw",
-            "-device",
-            "virtio-rng-pci,rng=rng0",
-            "-object",
-            "rng-random,id=rng0,filename=/dev/urandom",
         )
 
         self.vm.launch()
@@ -179,10 +175,6 @@ def boot_openbsd73(self, cpu):
             cpu,
             "-drive",
             f"file={img_path},format=raw",
-            "-device",
-            "virtio-rng-pci,rng=rng0",
-            "-object",
-            "rng-random,id=rng0,filename=/dev/urandom",
         )
 
         self.vm.launch()
-- 
2.39.2


