Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB105C3ABBB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBun9-0002E3-6m; Mon, 05 May 2025 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBun7-0002DI-O8
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBun5-0007vq-CJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33677183so49097555ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746447561; x=1747052361;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t04z14wWroapxvAnl8Iq3X/CG6hH1NqfPrwCf2qMuUQ=;
 b=2I6D7oEMme8Npy5AjDDMMkA59wFIZXFtztZn9Mjv16bCejiMP+RVv1s7uj1ytm/pwZ
 obKaIdvxBC98fLbMxBi7cOgy2mujWcHQYJuXl3JTfN8CjENWx8ONB05wItceqY4HpUTb
 wfEKlFpn2P8kFSfKr0IY6WpibTf71uA+t6IRnsXhjjNqcPvMJPR8OHW9q42+/qVfGzAE
 q8GDAf3ilrm7K9nh6xZaJVe5xT0vVs3xXX2V6F0A7QyMZTuCExT/32WhHb7CRx0laD7o
 evgxenS2zzLyslVKOnFBkM90dObNzSfq8sDmhC8Gedz/A8vcTdd/wKbsftF7ztRjuWW3
 iLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746447561; x=1747052361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t04z14wWroapxvAnl8Iq3X/CG6hH1NqfPrwCf2qMuUQ=;
 b=kYCXeXnd8aja72gRwStzmzJKU7WKsqFbhhfA5v3mQ0xrzZOsx6nhQT5GKQ3VmfZC0q
 TX46J9S0hBTCP8FvuA3sxuF6dsewUjgLQyC0/eie2SRpi1nvvKSRDkxJAaAokASZ2j9Z
 0WOSsEyX8a7WugOe85kxgX6fHyE5dKyxTfhQzmvtXNK0ez2jG5BenGEqgBPwJlbhKMB8
 KPmmcKWY7bIViNtjDZ20eVUdMq3vDEdGUNnwFUmquxYn4wZMBdxSEIbpWRqDe5jeisf2
 pcyCA9TYpjZRYY3ve237oumUypj7GEBwE1fLWrl5207lGiJrnV8TGxKMLfiXQDcqhta0
 +CBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBZj+gxx6E5cbMpNeqADtPi0mSDmQc3hg3zTXeOucInNMRaKiIfniYUe25xkXh3X+09bRB8aC38UvO@nongnu.org
X-Gm-Message-State: AOJu0YxFTowLm2IYPj2NALhkJgM94+VKtT0XFYDnBSYwbPe10bjY9iZo
 Y2uZIp0U9uRzW/k93J4gHLbqvyLbxKDH3YcjtI39q4fBGsVdJaXX09bxcbw16pE=
X-Gm-Gg: ASbGncvArTSNp+X13xDZUuVMx/jerxw7tSDjPrPqinl1qk+XRsQNrbHpI4Enrr9OFbm
 7ohkURNDTXO/sN30bSjMqKEHgqjRCRt/2UyrhP4bF+8pF2TuGLxgTrd0fBT38Ux0ebbvjdFDUDP
 /Ic5G2BED0cl9LiFxiCv0MhQr+oiry5uEK6t55ibQy7EcH7XjwDdig7nFODFggUhXx0gd0bWijf
 DCaHCAlS4xUj1EM8eEQVp6TbM1IubfNsi/wWbaAv9OPs2oLVDbdTwEX7DeVOaeS6vbQDo+Sa5hu
 QpSnm0SaefPIArNIi4GUkqZim8RzpH2MB1ZTqJan4cUS4tA=
X-Google-Smtp-Source: AGHT+IFIbKARMWNLiFcRFdjy2s7n155ChEkZXSgXXhfw/ERlvPFC4OKfcrgxUQMkrEhhKJGlmX7ODw==
X-Received: by 2002:a17:903:1904:b0:226:4764:1963 with SMTP id
 d9443c01a7336-22e1ec39ed5mr102307815ad.51.1746447561495; 
 Mon, 05 May 2025 05:19:21 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22e15220541sm52605275ad.126.2025.05.05.05.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:19:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 May 2025 21:19:15 +0900
Subject: [PATCH 1/2] docs: Bump sphinx to 8.2.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
In-Reply-To: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

sphinx 5.3.0 fails with Python 3.13.1:

../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-build:
Extension error:
Could not import extension sphinx.builders.epub3 (exception: No module named 'imghdr')

../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 version of python-sphinx and the readthedoc theme

Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
sphinx version.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/requirements.txt | 4 ++--
 pythondeps.toml       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/requirements.txt b/docs/requirements.txt
index 02583f209aa6..50148c99cbd9 100644
--- a/docs/requirements.txt
+++ b/docs/requirements.txt
@@ -1,5 +1,5 @@
 # Used by readthedocs.io
 # Should be in sync with the "installed" key of pythondeps.toml
 
-sphinx==5.3.0
-sphinx_rtd_theme==1.1.1
+sphinx==8.2.3
+sphinx_rtd_theme==3.0.2
diff --git a/pythondeps.toml b/pythondeps.toml
index c03c9df81b5c..4c0da288be6c 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,8 +24,8 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
+sphinx = { accepted = ">=3.4.3", installed = "8.1.3", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=0.5", installed = "3.0.2" }
 
 [avocado]
 # Note that qemu.git/python/ is always implicitly installed.

-- 
2.49.0


