Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C2E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV6w-00048P-1b; Wed, 08 Jan 2025 07:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0x-00021h-Ve
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0i-0002TF-RI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:20 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so66646315e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338687; x=1736943487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teELEAk9lxdpoQ7xzO+V1Ovz+lGrytHqETaOuw27UxQ=;
 b=SDf0vlrPMN9LzFPxdCb9wpwDTvbBiv9lxnAtQy+mx72+TBsj+fWwyV3RsMVKoJq0pH
 0J3QAj3YYhAks/xi868+JrYP7BliKbn2+oEt/Zce3GCl4X1W3qeUUTk71mf7+UYTvahU
 adjY3bV23N3/vifjn+S0RyoBFY84cJCiLAUSLAo6uwduMJvxtkYsnlZrZD9VJBMLpkOg
 Y3ot6RAeI2oa+F1Lh3ZOHuOlJS1DWWYfN3MKKcxFDJqzHWGLok74wqTDeZTD/vn0OaHj
 H007AzC6drPZQ+qyrzeyc1fK6Ka9Xozh6r9Ch+5kEWBgmnSJmjNeRWIgOFtyQbhgCbD0
 RcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338687; x=1736943487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teELEAk9lxdpoQ7xzO+V1Ovz+lGrytHqETaOuw27UxQ=;
 b=gt3w4iEONW/TGh8uoEyN8JkGMGOBmF8xU/VuitOW1vDwgSyuLdz9ct8tcb4CUx5alv
 kFOBG5jXQui8OLEsQBw6iBS31BwPKxLXMVwuNCL5j6Em8Em/q1rl7YtNDM21gn0w/oaR
 oahM5oU/sfZTUrPNx2358Qlyhz3f7/KJnL3HmaVz5nLeOjvgbdXQHro6IARDNtWcO+zR
 r4Jffb1xSAc03s1kpXF79myrnLX2FkRE4/ynEOoUmp0h+86hRTS0+o0fndBv699Ksnm7
 pNHyoJn16rgqJnpJ8fBYisZDRVS8DDSqhq7KnqtWyb26MvolhgOqr9esxzgA+gLIHlZ6
 k3Gw==
X-Gm-Message-State: AOJu0YzLIdT9IiTICUJsH/UAbH5pEIIHQ6e6I44CM3l3C8SGBgLFxcTa
 fK47rRTFctCdzVhtN+4S//0i5+B3tz1385eY0+m5EsJBfsnxpTJuOHnzXD8I0ek=
X-Gm-Gg: ASbGnctLmdWX+hhV3jsMpGqw1ZEnocHziM/Cik4IOMEsTM4d7CF9BcxSooRYzmoBiB3
 R4ttTF7HoMhk9mTr8alcntkyaN1PRV3u9kiQwIBF+qCqmrUCJQcEw+mr6seBUMnVHgysOqpzUb9
 QJ9xyBDINLtl25hKxanVn8jK3XaMkJhlzqpgAht/hv/NZbq2rlRPBnuwGAOo2svSmyAkEKcYKM6
 GOB9nNFG/cw4b5VMpaIAdOVPOzH0ZYr9ufcXUhFi1e1l+XVI0nR+Hg=
X-Google-Smtp-Source: AGHT+IH9EmdrrLmuX302owwafBOgoAOVd3AQoLbVMFh6VqlzqHPPhx9nx2Xrg+9KHctVd74rmrQtzQ==
X-Received: by 2002:a05:600c:3ca0:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-436e26f01aamr19025195e9.21.1736338687071; 
 Wed, 08 Jan 2025 04:18:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd14dfcasm39816765e9.1.2025.01.08.04.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4A166030B;
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
Subject: [PATCH v4 32/32] MAINTAINERS: Remove myself from reviewers
Date: Wed,  8 Jan 2025 12:10:54 +0000
Message-Id: <20250108121054.1126164-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The time I spent contributing to QEMU was great, but I've not been active
for a long time now. So removing myself from the reviewers list of
"Integration Testing with the Avocado framework" and
"Build and test automation" subsystems.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20250103194450.360789-1-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cab9018d9f..c1d954c9de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4152,7 +4152,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4198,7 +4197,6 @@ Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
 
-- 
2.39.5


