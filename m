Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7737CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gUs-0004nY-Il; Mon, 22 Sep 2025 09:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gUr-0004mi-4Z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:22:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gUo-0004zA-TY
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:22:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso39014545e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758547339; x=1759152139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nA+vEyRlq4qMf3Z0VRY3CTpQQA0tpC0BXepPUkFb/eM=;
 b=qTfvbysMF2y9HHQ+bkA740sE5ByfNE9Lfd4TZjIVp0+M0BaUvnhFm2mZ/uL4nM3g32
 bySiDcnQ6bu991uIG1M2VcvN+yZduIlzyuhH+2dPLA93jtPlEiJidW0TJBCDQI2GCzHd
 rnOB7eIR1oyPy0mpHWBPAB6URGNcKvUkifphsZ3ReCGSsY8TPyDgzJMT6lGGCdJNnAFE
 dDRl3CO1GBfZ84kWSOl7zGnHrSvSqNkUsYAIRaiOrWWg2I/L3LdNZPMkXTB2ZN8NfSaw
 Y402r5P+/gbQCgILywATRgZW5duefJ3RLXXJey8nRfepKnBmq1fzw3nWLcVDq6563Svy
 f0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547339; x=1759152139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nA+vEyRlq4qMf3Z0VRY3CTpQQA0tpC0BXepPUkFb/eM=;
 b=WSf2+GAUmVKOAEi79jZRGlUHmqmgQGL/5DKImfdL5ALGiJihwJsZvZtLYG7NBePVUX
 7DPnCKGRPGOmsAfPWHUzqDjB+1FGrgekLtPjRNvWQXo/jKNMQmsANB/i/BUK5mnli7ZR
 Dt5GSFSyop2XWjzzivoAp+9vWdnmJjwOUbxLki99ntX21QMrjbyOtA+LTcaTF8NSSxbD
 eK/u+Qfi4aTLLX7txxon+Kt5qdEJroXSTb4ZiyeO2zJQMd0wbHSFYc5/CzM2JUlxH518
 MMINw6tZ9b++aOeq9nSQwwPA/9OQfDRqi2wVgjepqzmqTjlzHAEnkm+SISrt31EicYhp
 +RBw==
X-Gm-Message-State: AOJu0Yyn40hQA9J51SHndKs9QTdOiWaEjiwOZoHOWx2H9lGvW6c0q/1t
 XfbNYS+VyKY8wPhESK6tYGv01ZkbGjdva7fjVRDCZUQ3Im93dQE9RNpeZxOZdlL7EcfL10NtDo8
 v/JwA
X-Gm-Gg: ASbGnctLarZ54Hu1nz6LrpFV8PT/BQUAACSLrK7m3oQ45a8iBEwvxKT/g+NO9HQKMeY
 nBm9wt4K5vX8/fQvi25/UAefjIDAB7lc/DTluBAa4fCFOUYt52jpiLYZQCVF9nAKuuW7knz4Vaf
 ejoY32lPVbnVmobJ+v1j+A09kd16IQW20fpvIKRbj+oT/p6Go/qGQeMSnOtJkKBHKa3L52ajLnn
 Nvp3kznbvcJbOOCPIaQ45bDYvZlZ+2QwbVF/C2FJs5BiNg9ff2QFf/aWe1jPh7t+MrNL7eA5d2A
 sASJgouBX0w2XKLaZoQCxiLa/sO43OlPqQ+pIFbkF0fOxfwsPdIfTMCM1oTWTRW031Tgh1v1tHB
 bnAIYoxosfHEdKIELfzxRSYTSAMwr
X-Google-Smtp-Source: AGHT+IHCG/23wtPT9OSdgl+rdcp3TSJE+RTO+RE4eVLBq4Fau+iX5FfEH7Yj3cZjIVUSQ6UrMmtv+A==
X-Received: by 2002:a05:600c:c4ab:b0:45f:2919:5e91 with SMTP id
 5b1f17b1804b1-467e7f7e36dmr148557195e9.16.1758547339440; 
 Mon, 22 Sep 2025 06:22:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fd84338ca2sm4944524f8f.42.2025.09.22.06.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:22:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] passt: Declare dependency on gio
Date: Mon, 22 Sep 2025 14:22:17 +0100
Message-ID: <20250922132217.680404-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The passt network backend uses gio; declare this dependency in
meson.build, so we don't try to build it if configured with
--disable-gio or if gio is not present.

Cc: qemu-stable@nongnu.org
Fixes: 854ee02b222 ("net: Add passt network backend")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 6ade30f36ad..c5a56ba5deb 100644
--- a/meson.build
+++ b/meson.build
@@ -1279,6 +1279,7 @@ if not get_option('slirp').auto() or have_system
 endif
 
 enable_passt = get_option('passt') \
+  .require(gio.found(), error_message: 'passt requires gio') \
   .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
   .allowed()
 
-- 
2.43.0


