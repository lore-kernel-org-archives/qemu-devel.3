Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4F3D29FB2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKA-0006vT-1O; Thu, 04 Dec 2025 14:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK8-0006ud-Qj
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:08 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK6-0007KO-Ky
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:08 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42e2e50c233so639790f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877744; x=1765482544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ieUcfuBccjg3UvaheR5UfrhtoVaR2ug+xDdEn4VBYNw=;
 b=ZBaRlQbgtc2T4fYa+7x+2CayvkITVlwv4opgnFOGDj86RKOP+kxbHskhDEin2SIqfe
 eobJYbsgl0/goBkGWMFG9rdUCF3pCQy+SWIVEnlPiWDg7ls68pQiLxXNVAhwPKvYVYft
 mxRmWhaDJY29CKlYodNt3KywpuEWLExlgQPHhEWQG+U42q47N9pwWMZpOWcHfUdf/que
 ASnwCzk998IIGEMfcYm2Y6CEkfR041yzfTlUcF4x+tkBBT0XsnrhHzQAlNbJuAdWggK0
 VlexMcuDYLg8A0hKsl5dvI0QnvHfclwGryfjZFNxekh4FvoEHdvkjmvcOSNVXMiKG0tV
 FsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877744; x=1765482544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ieUcfuBccjg3UvaheR5UfrhtoVaR2ug+xDdEn4VBYNw=;
 b=OD/JlfMfyzQv67biAOOCCJTeffFvuSfp2oj3l8CSjejmdG8Pfn0jPVTTJg38VBu60i
 jdpHtay0LWq3VfMxzr+9NmX3PcKMzt/jm+M+G02OjyGlajYiUm+DLtQz/2sL/SFcRFUI
 HK0QZ89iy5DMCPzh1Bovkzwdw/oUCtb6ht8Ak7ERM0FUO4ykzLLiRZ2Ksd3gUv+f9IMD
 ilJGUgahbIZX9Ybi4iMZR3YMJUaAj57hbt2AGrWg7ZMcSpEybRhbj2d3sx2MXcQSjiqG
 oUmASGJvmF4JNe/CyYCGp4WG8qvoH34DhrxSrhar/n/GyYzv4+6YQnYFn14pttNQUPCX
 usWw==
X-Gm-Message-State: AOJu0Ywaw41QPxgreifCkYjjQJjjRD+k86P5OM998GGGtHq2WqK75cdc
 wmTnI9kP4URz9LRQ9TZUgctU1WYtEdH92DxgZoVqExGem+Ad7vrD00D4K09s7NMsALw=
X-Gm-Gg: ASbGnctYEWxQWbH+0WxX9sxppIjKf9OeVXH6DxQ1t/87J2Pdsj0ZUk01AoC+ojh4V1h
 xx6IsO1yf/XYUdZoeSeuUl8hz107vMD80n5CIUwx3JS3oaPVtfzF8Qn03QCI+wjHMX+SIJUOoQC
 mfjSc4od21NOdmJVp8u3XfHSi2vRPrx+c3lIUhdmdsoFFODIwbi/cP7jWttnwciYVtmrInbHtmb
 /KvEubCXBv/lAezVvD6XY4+B39skuPupqab3NhOKxd/7QeAPQXAHsUisEjcjfsjPvPffmF7410i
 ZujXy8+2bJUWvlS7bvRzCBAbP+0kDVBOc+URpgIuAFtcodX0ePuuPlzWIkamXGonrj1cuGqqoXU
 rEu4EhB0qAny09O/isHPOxY+/e/QgV/DkIhbT9qENW+6/waqcMLGG+Cdpy8Q66/OshqcyD+jxQJ
 UNev86uk3ZVQU=
X-Google-Smtp-Source: AGHT+IFY0ZvXrnnSLWDXczBFwUvXmBI+fflIMmldHg7e9b72StD00Ykawae0nILHUnKBM1L2Vpa5fw==
X-Received: by 2002:a05:6000:60f:b0:42b:3131:5434 with SMTP id
 ffacd0b85a97d-42f731a3081mr7171083f8f.38.1764877744501; 
 Thu, 04 Dec 2025 11:49:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm5579167f8f.28.2025.12.04.11.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1BD15F839;
 Thu, 04 Dec 2025 19:49:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 02/11] gitlab: drop explicit pxe-test from the build-tci job
Date: Thu,  4 Dec 2025 19:48:53 +0000
Message-ID: <20251204194902.1340008-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

This needs libslirp to run and as debian-all-test-cross will soon be
based on qemu-minimal we won't have it in a few commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 44df116139b..dfe954fe3ce 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -656,14 +656,12 @@ build-tci:
         --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
         || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
-    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
+    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test
     - for tg in $TARGETS ; do
         export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
         ./tests/qtest/boot-serial-test || exit 1 ;
         ./tests/qtest/cdrom-test || exit 1 ;
       done
-    - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
-    - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
     - make check-tcg
 
 # Check our reduced build configurations
-- 
2.47.3


