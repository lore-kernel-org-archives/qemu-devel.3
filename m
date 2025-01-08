Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA50CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV6h-00034B-CU; Wed, 08 Jan 2025 07:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0u-000215-Lp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0h-0002SE-Kc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43635796b48so5060855e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338685; x=1736943485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOL1w6DXYhRHKCvs8ew1RtJiJh2Nk45cuCcCN9iEMs4=;
 b=cojh8EYWvYwldfOYHrFd1MpOdhQum4LsLpyU4k3KyR15pcgufLyMnpeYYvJ26pwF52
 l8hzpM8ACJmXmc0uAPO0Rfwy7AxtCCT07o2kVqTGf/bDt19VO5dnV1GoE+cruFLubMaF
 m1WGI0TFyK6x5veQT4vElFwbtB+a8mP6ikCGi4Jtt0T6Wo8IrkrjZ4r2QaecepmQ4vmv
 I5uRu2eBuLZBfhSBuQ/8txFxzcCNbhskv5PDCmJpomXJ2bVcTr6+RYRCf7Z2P5B/IGac
 Jg1beRvRyx4f2gGj1mYOyWyhrj3HcGKbvth3CNkJ6p5PIH0LDjTbi8/1Esq1dZhOmI6r
 DB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338685; x=1736943485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOL1w6DXYhRHKCvs8ew1RtJiJh2Nk45cuCcCN9iEMs4=;
 b=YSoR8keJcbxB064ynVnh1dEclB909oyTZXcrLjixdlMRZIhv69g4B6oY8CbJGIVBTD
 TUUaiAYqCjXu9W0Mo3jzMZnV7zTE/FWUvw88W+31CEBy4xRmf3U/aSjOpqtdElVryUc4
 1PA43A+lkj5KIoVe000TEECCO7viRDy6UbdqwHiSDKZ0hr2gXEBV/WEV0kuxB99VbymO
 PoDfFH0NZlF1p3VtX9OrnOy6XVTbOkwMCiiBKes242WBGk4tQx+Q62dB6+lrPTyJeAPk
 4cNnZJR5mAQ03DcFisZiEvEKYekSoeDL2o9yzKu2Hf/CFOY46vqwX0X/XRfg+AtHFB7w
 cDJw==
X-Gm-Message-State: AOJu0YwPSvJHx9InWVVEwSZKN4DW20PyEnoPqWyHnMMUlGY8x1oQAh52
 8HdNr3mdccN8QpXQKd0tBHXF2I0FGdwubXvliBdAmrtGyBozdukWfPW5UOmgWUE=
X-Gm-Gg: ASbGncvFKzEzEEzWRz26GwM/c2ClRUlWgux8ZYnuIdNSQ/FqEHuv/Lkm6vmwQI6sONG
 38EF5EP9jMvjTo9CsoMG0IUmMxK6+fYJlLtLHD8WCZ/TfUq1le9zVY5AXqo6Uhn7YOFIk9crKO3
 NeguSkOVzXZFRFgedl4XHBYy10QhoCGHS+yAZUEkCoZ7JoxpjWjX6T1n+13MH05L/tD1iaDGTrj
 5G3sAdCqqzm425RlSEJOV8bsU19bRaQ5BshL7B3rnBc7Zen7/8QCCE=
X-Google-Smtp-Source: AGHT+IEZ3BVXJWYZEWA9wGATEo+F/iqXbvp4GLVQdNs9HUMSA1Twx1Wyojh9T4yEtxjJCTF7eUN2kw==
X-Received: by 2002:a05:600c:1caa:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-436e1dd3e30mr23490675e9.6.1736338685542; 
 Wed, 08 Jan 2025 04:18:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd15766fsm25041785e9.2.2025.01.08.04.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A54A5FDC6;
 Wed,  8 Jan 2025 12:10:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 27/32] tests/vm: fix build_path based path
Date: Wed,  8 Jan 2025 12:10:49 +0000
Message-Id: <20250108121054.1126164-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We no longer need to go into the per-arch build directories to find
the build directories binary. Lets call it directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/basevm.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4a1af04b9a..6f3f2e76df 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -520,8 +520,7 @@ def get_qemu_path(arch, build_path=None):
     if "QEMU" in os.environ:
         qemu_path = os.environ["QEMU"]
     elif build_path:
-        qemu_path = os.path.join(build_path, arch + "-softmmu")
-        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
+        qemu_path = os.path.join(build_path, "qemu-system-" + arch)
     else:
         # Default is to use system path for qemu.
         qemu_path = "qemu-system-" + arch
-- 
2.39.5


