Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98027C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSHo-0001H9-12; Mon, 29 Jul 2024 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHj-00013z-Tc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHh-0008Fj-K2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so11169075e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266856; x=1722871656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FL/ZPZYccUWSxTKfYMWLY3Pr4brfg/yi6VP3FOnE2ts=;
 b=UBciM1CREDudpU8DKsAfNDe3kN2snIoHQCa4poEA5fwc+tbBxM86uUtGK3z4bIadBJ
 kWkCS9+biAWxBWgXDCRVyLAmxkkn4k5NDPE6uYGmNwlpKuH18uvbycYXVCGIFW29lCOP
 ea7FL3PSRau4OrNIX42NPpElb/EyFohs4SL8NtbkmP7jNdxaBSc0hE7k9Xf3roQBEoaf
 h4A2Qk4qhocoP8YodmNJ4chj4Rz+brp2GKc+hdMuey1ADNcBquiJw2dIWUI1Fsf/pb+c
 ZUmPNsjI692kYmlu5/ip5GGW1BpyPxbZTNr5ZPkJ72U0DH78ga/u7nYW3jwOZnPjj/8k
 kRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266856; x=1722871656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FL/ZPZYccUWSxTKfYMWLY3Pr4brfg/yi6VP3FOnE2ts=;
 b=xB40LNzSJJVViG2Q8w93HcU06aYGwiivatGvWC5Nf7IThmV8Xwc1GwMy5fZMdSmM6L
 goWQ+boEC50qRiqsLoM7nwG63yRLU3PAc4ZXudSXK+pqIJoSrsLR5CXCdHZV9R1FdpVI
 +Z9IRdftcRmBqp2LGq9LZWtL73E69naNnXS3W5kWkLxQ4+n505XgvfuZy5cCAva5sJ4G
 3EYDdkf+13n6+ySJOMyOj0J++BMKvtRYhhMWhD7c8qT4S9/Dm+X979CaKnAGCbsdoGv0
 CGoTzrRGiZhuaqMnm2G/DwKV5uRzLvP3/yJnAdvTJnPe1n2A9Mqv20Bex+hW0lSNkw/+
 TGFA==
X-Gm-Message-State: AOJu0Yy6FJxtjgLerP/L9FnxedYk0rhWZHULPqfxcNTPgpWReZ1andw3
 VHnZgfjzwq7tNUNabfm9ywM0ZxBdU076iVzoyx+K9A4+YPvvgxF7TnbZ/L/Y1sM8QIzA8UHdiuv
 J
X-Google-Smtp-Source: AGHT+IFTq9mW+t3SB8tIw1r+RJVtnMv8GjHrE8u2BJPv23gMI6GGTSZOPsTn6T1rVeCfk2v8v0htOA==
X-Received: by 2002:a05:600c:1c93:b0:428:29e:67cc with SMTP id
 5b1f17b1804b1-42811e7228emr56389085e9.10.1722266855637; 
 Mon, 29 Jul 2024 08:27:35 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367f0e26sm12513213f8f.47.2024.07.29.08.27.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/14] python: Install pycotap in our venv if necessary
Date: Mon, 29 Jul 2024 17:27:03 +0200
Message-ID: <20240729152714.10225-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Thomas Huth <thuth@redhat.com>

The upcoming functional tests will require pycotap for providing
TAP output from the python-based tests. Since we want to be able
to run some of the tests offline by default, too, let's install
it along with meson in our venv if necessary (it's size is only
5 kB, so adding the wheel here should not really be a problem).

The wheel file has been obtained with:

 pip download --only-binary :all: --dest . --no-cache pycotap

Signed-off-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 python/wheels/pycotap-1.3.1-py3-none-any.whl | Bin 0 -> 5119 bytes
 pythondeps.toml                              |   1 +
 2 files changed, 1 insertion(+)
 create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl

diff --git a/python/wheels/pycotap-1.3.1-py3-none-any.whl b/python/wheels/pycotap-1.3.1-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..9c2c7d259365c8a0487228c6878e2c0b10ba6bdd
GIT binary patch
literal 5119
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

literal 0
HcmV?d00001

diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..0bc4144d4b 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -20,6 +20,7 @@
 [meson]
 # The install key should match the version in python/wheels/
 meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
+pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-- 
2.45.2


