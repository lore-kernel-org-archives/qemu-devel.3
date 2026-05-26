Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840A0CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ3-0002go-RS; Tue, 26 May 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYo-0002al-D0
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-00066k-7f
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso88791575e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793371; x=1780398171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxcKqoYGT56UThLLQ8nq8BYxr3paAETNRWypqwIxJZ8=;
 b=wq+TAOgFvoxftiLLSE7e2nmu0dq8PASCsqx/0ENIIO4tppvDfEsl+MT/foXI+feC7y
 FMXSumgJ18KF0AhmRWo+7JmkIPpc/heJxrpY3CRr21/8RMaY8zSLcYduFJu7BPEyHCnW
 umgeq/6Aq6x1XZh3QMPl3bLqNCI57JMKTcOAoX46yAc7nlo1ucUahRiVQYuYQVKm7ivI
 xOL0TKMGPw56W7tzmrNLv3LaJcPAqC83j+J7cs710hlRF9JSURZAq6Dhuzj6cbC0XBAT
 t+ES6Kv8jzfU+Pns1ZZzkOleA29T1Bnj6bVAWCSlnwPEY41Wj3Wrz80aRG7B9Li4D2Tp
 4yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793371; x=1780398171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uxcKqoYGT56UThLLQ8nq8BYxr3paAETNRWypqwIxJZ8=;
 b=M7HzxINz0Q9vejQo4TknfjZsQLlP2s2n7iI8Ldvp1t9eKvWy4Nj6DGNNVii8ZBxzhM
 5SzVR6DBtGjZFJNvFVRi8wEMgg019R3Ap1BwKFO4ebSM5frWxnjhZwNok0syOVSvxjqx
 T8jMJArLIRd/lpghZ4HBnwLbhWwowFz7MKi7I+t1U1JeMoeeduxreMlGB3IH6xLqz/ba
 1ymJ4ZyE434CNpi7iRvIr0MgYX+Me1qzV04I7w5i/vmBVbqQj6dp3SIWIxt6nbbtwulN
 D6edS6uQQN4qBlAQZaMfh/j4oQGRwsJsLHlIoBO+LIJyb1DSXjT8xQAIfOF7hjvTbXae
 iimA==
X-Gm-Message-State: AOJu0YxiG/Xzq63+0gU39jGY4/pZxVOtS1OC/ZdvaAXdWuP32gTVh9/A
 2ZdDyokQdkWRdNePe7v0swhQshcU28cljBfLzqLYBNh0bHH9zOmdCB3y7wMP09Chn92PR8GDZs5
 PXrNk
X-Gm-Gg: Acq92OHTRakXhrfxDzvK8jcBiT2eXtPuWj0cDKHDEoVIrFTCu/L9ec8D7e8xd7tsTJM
 pmkpmXZtyw3iiF8JM/C0iq2HnIyD7QYRyRGxQoLda+r4jUW27wZ5Av8ilQKFsBdAvPExE/hZcxp
 OmLYCcn6zfSEm/kWE1qwKCsXy11jU+RiRXoeNAFoXvmFceKsBoe+A7FqkC+yvyT2O+xNkP4SvoA
 YvuDfPD69eeyIRWipD0J7Q6xsJRkJJYdgLrMEZzKbb107wci6VyqB9Kb8sK84KF2t6u/hyqvqn0
 2M5otCa99JvEQRV0PRG6mQOEgM/OfeAXBPfveF+gVntLQYjFIPApv/GHtLit96mcHGiIyYr4M54
 xs0b/cu0GKpfOrGKosXhrSdMo8402hipduLOVVWx5ep8kbjegN4a3WfjzIW85ToocG/S6QLbDHQ
 bTcamqeqxqwR5tTXOE6ya4fhU=
X-Received: by 2002:a05:6000:2f81:b0:45e:a0ab:8bd1 with SMTP id
 ffacd0b85a97d-45eb3688839mr31116058f8f.7.1779793370954; 
 Tue, 26 May 2026 04:02:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4741bsm36069874f8f.22.2026.05.26.04.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7780A60484;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 10/14] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
Date: Tue, 26 May 2026 12:02:38 +0100
Message-ID: <20260526110243.470002-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fixes: afbdf0a44ea ("docker: Add Hexagon image")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520f7678287..506f8d62467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -257,7 +257,7 @@ F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
-F: docker/dockerfiles/debian-hexagon-cross.docker
+F: tests/docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/quic/qemu.git hex-next
 
-- 
2.47.3


