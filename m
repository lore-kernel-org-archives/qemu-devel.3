Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FACC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBun8-0002Dp-Cj; Mon, 05 May 2025 08:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBun6-0002C4-0t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBun3-0007ud-4p
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33677183so49096935ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746447558; x=1747052358;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TJhTBmvQ3KVyJXiJTx6Xhqtveig+dOjq77VWDE3xYZQ=;
 b=LS7G7ptdSvpY3DapfvQe7QKF4fxRaKj0zdwF59+XEkblC0XNkKgFoHhLR8csesIh73
 CwDzq//yqqk1s6IvPsWzLvbj6oPKEuDp99ObBFm3x7Vd2p+adDrONFsxrqA5b69oaYAF
 wqRr/BF60jZvCpfV0a9rgrDNOC6sAFUDAxxTHwh+Ct0GbCYXKCH+/u3wfATj+vCmXPON
 BC+DihyDFu93rD+YYDEmUkzi0BYwwyt/OaLuVxsbdhpox44lC5eRzU3v/vsrxKl5n2mq
 dNrNtf0d5MraZcttsZWhd1vCpSjKMgNFia+RET0CeZkcqjWZtzTEdg7y9RpkbVzxUOQg
 p9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746447558; x=1747052358;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJhTBmvQ3KVyJXiJTx6Xhqtveig+dOjq77VWDE3xYZQ=;
 b=e5yrQwaHXohYJUpgfMMmT3YctTC8mhK/LbHeSolmb67MRk0kwmOsp7i31Bbjm23jei
 fMFWiRvokL2Z272QXV32SeK/5GDVgwUYPc5x7vP6luYyR/FkT1wEY4Who3qpXrsZLC9a
 Ipck2Sqidz4WYHAFQgVGcAVhNoamShQ0Ou4kTarlgN0K8WAg58mK8OA6TjbLlGnVCDUg
 Q1LUSvpnrlVD9lNyd3SWtQ91dr4ZD/hoR4Px09Ud7wiTAiU1G0FI+TBAM/3GiP9ZFBlV
 dmVKD/sv+DrilZOos3NnCGZ9euRXUouvlg+6lDkm6crhwwl7iRytJHO8Hlf/zBOzqbvp
 k2KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVROSHIarHPMwr9nYzDCvJ3W3gSP5Wjs2bLDBLpPAFTOH1uAC2J4RZNN7IrDNKrtAHEFoUe3q0vn8h@nongnu.org
X-Gm-Message-State: AOJu0YxsC8DTylk6Szmq0pNX9pdmrMH7KLjzQw/dtfht/noOJ6LUQQ8h
 7ndRed1bF8MnjKHgC5jRoBQdaBZnSkzlEa5UZKSyS3WCv5MIDCEAAa9rG4dxW4c=
X-Gm-Gg: ASbGncuLq1Z4hkUiZFZofTfaFHGF4Z1ExNNQvxgy2fkoUaLFn2zeTbF/hfbnWfp9JAz
 O1blplnlbCd3XkVU57rluQJ4MORXf1U4mljzA7vECEJVSPfRUA1gVC3gAMdRW1OAccfe9DK/xzR
 XseVhc/SJoATXl2zzQlTFfI7Q5kC7R/FS0olBuzrEqC/Vh6P3ILdlWr2I46fag5KYAsmjrYD6uB
 9xlG3Kll8F3uVMyH/XsxhpuvRiNCPhvnCCtKx33NpAGQZALdGPsagiKXdMUzU75q5/6osUIUXtc
 2BL11yqWVoWpAXjRBZ6RDNDOr0IzRKnqLjaWf2s5jHqccSA=
X-Google-Smtp-Source: AGHT+IG0s4Pdz7rQYucaR8qN9pXu/lnxqwj4i8Ke65jHNqa0ERBswAqRcD02pKnQqAl262Ucq1Rr7w==
X-Received: by 2002:a17:903:1ac3:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-22e1eaf0a6fmr111224835ad.41.1746447558386; 
 Mon, 05 May 2025 05:19:18 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22e173b584csm47462715ad.16.2025.05.05.05.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:19:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] docs: Bump sphinx to 8.2.3
Date: Mon, 05 May 2025 21:19:14 +0900
Message-Id: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKsGGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDINQtLsjIzKuwMNJNTUoyTjNISkk1TzFXAiovKEpNy6wAGxUdW1sLAOU
 Op9daAAAA
X-Change-ID: 20250505-sphinx82-ebb3f0bde7d7
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Supersedes: <20250120-sphinx-v1-0-65151b4441ac@daynix.com>
("[PATCH 0/2] docs: Bump sphinx to 8.1.3")

sphinx 5.3.0 fails with Python 3.13.1:

../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
Extension error:
Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')

../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme

Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
sphinx version.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      docs: Bump sphinx to 8.2.3
      MAINTAINERS: Add docs/requirements.txt

 MAINTAINERS           | 1 +
 docs/requirements.txt | 4 ++--
 pythondeps.toml       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
change-id: 20250505-sphinx82-ebb3f0bde7d7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


