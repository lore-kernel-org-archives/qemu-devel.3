Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405CDE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCqR-00070J-6o; Tue, 07 Jan 2025 11:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCpa-0005Bk-CQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCob-0005x7-1m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4368a293339so125695545e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268743; x=1736873543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp9Cb+nLjYnJ8bOQQMApTzM9CoLq9IVOBk3wtPI/KWI=;
 b=LqGDe+m1UgtZcslNmKrtV8sUsoNSWv38bdxSCmsNoCkK4ipJ7gqnEZUBF2fbS0EsnF
 U6l6vLRAHAWTCBpoQp/fmbI/t2xtoM/JgxoX1dz5Yy5/yt19s/sIGITjcBsuh7PcTYs0
 +FEIiM6itI6Y0JLCLTaHKs++my2Sao0x/y/Si/v0Ky6K6PVpNqKG2GK0qSQ2bbpo9MVl
 1fFfxKhra/kLdRtfdZXRpZRrxmXE3v4VNZtMalS7ZjpyoPp1cGbRvlKHHlDuTd7jkeKv
 i4yBXQMakUq+mFGNp66ninuO/ztKFwSEQrVIlDluMErSxq5tLSYxcFmHG6SX+UY1Ckf4
 bPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268743; x=1736873543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pp9Cb+nLjYnJ8bOQQMApTzM9CoLq9IVOBk3wtPI/KWI=;
 b=GKnS3oJPTBV+RENSv/e64KvXmc0hA6vNALnFuek8+kOb8dATvxgZ4vl5eXrnGfG858
 JDa3HcxvHIqm7meNR/Ib+I37HxN9b9rUuxRi214FBDOtjGDYfeEofLQMc6llt7JqS6bg
 ilfyy+iQTWjFopPGGSPZIBSCUIdc1btnesJjPsk0zkZZiQMeaPZ4cHXadZtRMRbqFdLl
 1JUuQNLfTOGm4nwbxj/X9Sh0HVA/7y+YYm9XXI89YjsPQhmJ5T9PPDihJTjn1A4rp2WG
 xEl+BHVoESwDL9FQOe4oMltfFYSQcZYvDr3vMe/CByUK5xS+d26SaCNE0gBBbDQXr5Nm
 GeSQ==
X-Gm-Message-State: AOJu0YzEI/Qdm5puX8fveV6pIt7YIiBCEJtmczktWNsJDQO5buIoV5kb
 n0r4LAh3jTXhlOpw+UyIwf+f41s0uXnfxtFhXibq8IU52vOQp7CEQoyndswa2Z8=
X-Gm-Gg: ASbGncv3Eq8q9kdkBrQbT89Rawecl/E0BTAXK5/9DM2FqWxPZNNt19bnlkmIx5xXj/4
 CIRniFlB/JXrL5t8rsPlgd+JGMWqoo0a37LCh/6zNzA9kk9Igr2QFIS+5eBR93WhK5C2ffnCKrA
 WvE844BXjvOST75t7rtxGAegzL4fDA04aD9mghujuo+js7Y7TbUrZekOpMnkIKxBHoOam5CI8ZK
 bJoUor3QBDcucwM2pWs9EHocd72tc8LCZk947zEd+CWGR8XoT6AQA0=
X-Google-Smtp-Source: AGHT+IEZlo7wUd2guFc1pI8Jjm0H4j47Cqk02RDV8c+BTKryqrUGFCktldufQ/0LiLhhSX36f/8lzA==
X-Received: by 2002:a5d:5e09:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a223fd417mr66713319f8f.55.1736268743552; 
 Tue, 07 Jan 2025 08:52:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4d7sm602216935e9.34.2025.01.07.08.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DF2C60571;
 Tue,  7 Jan 2025 16:52:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 28/29] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
Date: Tue,  7 Jan 2025 16:52:06 +0000
Message-Id: <20250107165208.743958-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

AMSAT closed its email service [*] so my personal email
address is now defunct. Remove it to avoid bouncing emails.

[*] https://web.archive.org/web/20240617194936/https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250102152513.61065-1-philmd@linaro.org>
[AJB: update URL to web.archive.org]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-tricore-cross.docker | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 479b4d6eba..7e00e870ce 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -11,8 +11,6 @@
 #
 FROM docker.io/library/debian:11-slim
 
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
-- 
2.39.5


