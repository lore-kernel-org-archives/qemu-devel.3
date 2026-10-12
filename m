Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E14CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSQ-0005nt-CT; Mon, 12 Oct 2026 13:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRS-0005FH-8w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRL-00076A-Og
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:03:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso1616809f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824630; x=1792429430; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R4RJkr92GUc2ZF3hnVHuHTKb4cA9SH2XyXh8JZQS20s=;
 b=wQtzAGgR1PA8nLxOTCgSP8TH0c6pcoHKobEkKheY3UWLgHsXUeaIJmUgl1Gr+/uBzo
 Mb/gRyCKfkKIjrN+l8TdLuHKE7eXGRTv0hzhTcOPwnP3nJfoE3YDMQrMwRcuLZ9NYdJd
 kbD42FHKcJQRe7GZv0nl22wc8bAaj8phhSc1hDTZVuouEZswN2SRE4r1dqMm4aLGINia
 NLF1+/lc7SKyMjWzE6bAbq9X+VPTzi+Fd3G07ChXc+PUDoeZ0BbkY/HMzod42gHLtrXf
 fWuG9EdmNeHm8LwQX7onw9+ALt2q8uWfmk6Kc2TlWBym1D2iatt5hWYlx8pWJzLY3Rs7
 yCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824630; x=1792429430;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4RJkr92GUc2ZF3hnVHuHTKb4cA9SH2XyXh8JZQS20s=;
 b=bepnmNeGqacnqi6xIIdP2R8GdLgERlvkKL1McUANi0oQaC5KDBP5bONsECQd3+tnrO
 xn55n1BS2L2PjwdKSPoOkUMKn+Wj5VI2Et769t5Nw0BCCeZIOpSFhtuMuwXOWornp3qP
 tnX/qAuT1/UodFJnxsd7ob1VPoczcmBfaOVUiDl0ZkOpSYc8J2eaYfUELgJnub1rJh8C
 kKGcWlP8cIbKkC3oruQwCgF4Pg3JfwS4KQUgZR2NQaZVIVxljFaHzp2lcfpY5X8JvlEr
 qcBCMex0xuTSbJxHPo7/cSXpGlUZ3tgzi9vvEUcieBpCG7U+DBnWaTOaX5slRyXnzbDz
 jnOQ==
X-Gm-Message-State: AFq9FYKgoMDUqN7oaaxToEZ3PXu5bzLVft5yWx5GztmKnxi/uO03Q79q
 rt2DoJP/VxC2oaeUgkatVJmtMbwIOBITlzHkvFZ/aQWDRzL5ZvDLwKV7ap/w+oskjvk=
X-Gm-Gg: AYBFou1XiygEcRfKWOOlcYmYr0nP+6rMBUXQyI2jqq7IPexLfjajHzM15RdebB6bKul
 FiRytEgH25c/Kd+BHC0luVePoYw8y+d9d9iSpjm7C9CWBxoqqgoluXOggdIYOGsZqoz57gf2rm7
 qA+jODvbAq7d/LOwTYCBaga6FM0pmuxnA58zfa6NFZ2Rw9y6uYfLQxfbYmSkETOsQ7kx+gmxs/N
 IieYJ1BcTYq77Mk1m62leXixoLV7LDN5v2M9gRW/f4AKdNe2D24nzd/EH6T9YfgE9ULzheASl9S
 C/4rMPssB2WWNRv7/4pLZvWJh7qH6QrfGb7v8FKUPvqgPQHvobhFFB3G6YaaBsuytDJma4SJrCD
 WCCUhe5n5T6Yf7iO/DyistqePWRmEZRvchEKL0wP02/lkhL2cLab5qL3DANqR70iph1Xpf12Hha
 7w3NK3MVbgvumOqVS+b1ksQmzUdD0f/6yEjnQnV7Yqhn1TgZ87uecsJowrH+Whf2dkyv9jtA==
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id
 ffacd0b85a97d-48dbacdc419mr18661992f8f.36.1791824630538; 
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967c03sm476208f8f.6.2026.10.12.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 398B55F9CC;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 02/16] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
Date: Mon, 12 Oct 2026 18:03:16 +0100
Message-ID: <20261012170330.1144446-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Max Filippov <jcmvbkbc@gmail.com>

Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
which matches the way it's used to store `argc + 2` pointers.

This fixes the test for me, which otherwise fails on xtensa with the
following message

  linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 6f58b090328 ("tests/tcg: Add SIGRTMIN/SIGRTMAX test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
index a7059aacd9c..b5ea65f3d39 100644
--- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -39,7 +39,7 @@ int main(int argc, char **argv)
     assert(qemu);
 
     if (!getenv("QEMU_RTSIG_MAP")) {
-        char **new_argv = malloc((argc + 2) + sizeof(char *));
+        char **new_argv = malloc((argc + 2) * sizeof(char *));
         int tsig1, hsig1, count1, tsig2, hsig2, count2;
         char rt_sigmap[64];
 
-- 
2.47.3


