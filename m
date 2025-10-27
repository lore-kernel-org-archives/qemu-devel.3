Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12B2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9Z-0006Mh-UM; Mon, 27 Oct 2025 07:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9Q-0005s1-Fk
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:36 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9A-0007cZ-0X
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so471685266b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563535; x=1762168335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PhvPHHz2nKzNx0dR+rkbmZq1ESoRDt6FUBPfkcoyms=;
 b=wFIIH1LW/SN5gWuu1FNeYKW0lOBFUVQhuL+8AFprkZHWzsPCicgd4XOJWmBWwq9VcT
 F4l8oaXV3gwoD/4nHhy+3GYL8XUbsgNjLY/kdYWDFUDboUjRiMiOo6stAhQgVuUCCfB4
 3nh2GGN/m7UxtG8bp5zt5np9UM3N6eCTs1CnDbS8x4nAgYfw3RNepcfSI7gvnAoOaNeS
 9ASBa0yfNQguM6adc52tbMAsok+T8qmx+zm0O5lsBddDqaXY9Le0YRg8fK1rH5hgxV3s
 Oq5qgDmmeXyL1xZG7eKD9mAFKXORHyErHK4k0GHw34b/lMhVa2jRck+Xn/TmOielkQTp
 4MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563535; x=1762168335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PhvPHHz2nKzNx0dR+rkbmZq1ESoRDt6FUBPfkcoyms=;
 b=Cb04qQpTFY0c9ufPzTIC0iXdEeLzzP/+ABWYA/fOBbgvMTZD/7Knb2g0XsRCcJsQRG
 6w1wz1dZldomUNOBpGIqn1GsoO4p45ED/8E2qYs2DZESUDaS/zn83QNYiPJOje62S0xn
 67qzgcQnb4W30xNaSmBpHu4a9WDYPmJXDuvMeJlMDQtb7Eyp2FlZgcCOuFkRGdBOq52X
 j5lzqYxVUPziXcBgX0l0EIBYdVB/13SKe8q5jlRav3vFVCgBhUjZdbYgLxKhhGUvIq5E
 8b1D/P2O/kEupL+OBykbm6RlA04GxGIFQM4eHqGJXqbr6+hSQA6fglH8xth5ifPF6WNQ
 8oaw==
X-Gm-Message-State: AOJu0YwaOUgCUkhXxwGRY96/gwl3PVeWhKyn1t6JvsFatNVYzlVm4yjk
 rSd942vqxeL7DIlX7uV711tA4r/peFmLO4IRBWHSqppv0lj9rhUoqnjFwdLrsOJO3QU=
X-Gm-Gg: ASbGncsSaq9uOnFUCNcJfD3Iu7Hh7VSXSVq7c8/nTX83H9nZjN05upYShAfqkJ/rc5v
 0+yizNIy8XY7PWHYVhXCYOX/cP+lzYZodHtSfXJyqbRL8GD/xJ/Hq2NUfa/HBQCroh5ZoaRRzWv
 chbRuSVJMtVOkXlpNFAs9AeGYGAOroekXDYjOUL8Juu9YuhqPxbDAfzzAWmB61tlSR1kCSbkXPW
 WhZNIzRv+BifVPayP1iSIfZd2TyxDDYRpeL8dWDJzmoZgNS9w1pD17j+DgzJR5X+vysac0YpcKL
 wY30aAXir/uRkRzwP0VnjCrUxjzudJICu0OFcWKWN6hHjtIyeOUVOBQGL9fBLwScqF+zl1NCCOT
 Fqyb5m+FF8EIpI0wkZyqzzLr+yKRF0rPUBBT1uKaQxr2LjUIuDyp0SQj7mBIxJiuiZFWtYfeeqd
 9x
X-Google-Smtp-Source: AGHT+IFvvCvIty1DfR5lRQdjx9oxrgbu4HcCbWQum7FpsPzWGCkS4/ZxOKXh/Bm3P5OVv9Aw1Mskyg==
X-Received: by 2002:a17:907:3e0c:b0:b6d:7e04:7a24 with SMTP id
 a640c23a62f3a-b6d7e047d4cmr934588966b.36.1761563535106; 
 Mon, 27 Oct 2025 04:12:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548ed8fsm737084866b.73.2025.10.27.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 460455F929;
 Mon, 27 Oct 2025 11:03:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 33/35] configs: drop SBSA_REF from minimal specification
Date: Mon, 27 Oct 2025 11:03:40 +0000
Message-ID: <20251027110344.2289945-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

The whole point of SBSA_REF is for testing firmware which by
definition requires TCG. This means the configuration of:

  --disable-tcg --with-devices-aarch64=minimal

makes no sense (and indeed is broken for the
ubuntu-24.04-aarch64-notcg) test. Drop it from minimal and remove the
allow_failure from the test case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/devices/aarch64-softmmu/minimal.mak          | 1 -
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 --
 2 files changed, 3 deletions(-)

diff --git a/configs/devices/aarch64-softmmu/minimal.mak b/configs/devices/aarch64-softmmu/minimal.mak
index 0ebc1dca561..3c8582e12cc 100644
--- a/configs/devices/aarch64-softmmu/minimal.mak
+++ b/configs/devices/aarch64-softmmu/minimal.mak
@@ -6,4 +6,3 @@
 #
 
 CONFIG_ARM_VIRT=y
-CONFIG_SBSA_REF=y
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 46db9ae0138..ee13587d99e 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -107,7 +107,5 @@ ubuntu-24.04-aarch64-notcg:
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
-      allow_failure: true
     - if: "$AARCH64_RUNNER_AVAILABLE"
       when: manual
-      allow_failure: true
-- 
2.47.3


