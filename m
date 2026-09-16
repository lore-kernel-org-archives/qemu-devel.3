Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82238C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ri0-0001oF-Uv; Wed, 16 Sep 2026 11:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rhz-0001mp-8d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:38:03 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rhx-0003NX-Fp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:38:03 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso10021905e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789573080; x=1790177880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5ZkOZ2c5yMGDlE1TB5Cp+fPuQbHl7TzaWx2TA+LzciY=;
 b=QopxOg/l39ZFi7Y7rJhgSoedHKBXGrruL3bIV2NawDDnj1iftzxmLDao68w2+1xErs
 Duc2DfvQ7OJFuXc8xBpFLl5ivoup/Fbtd3M4LagFFXqmxaDZP92w4DrcbPtTFZRRY5g5
 bm1GkUnJvqDzFT3USCRYniJ4xmqKU6v8QYIJ4S14ESz1inYAwWc7aaIQnZPuN/GGpMaX
 eJzSJZBx5zxsD+VnYM3QEfuejlNorRXMlogEyBE0N8JPvLexNtbZcJO561oapfj1xeVp
 EXQqe2WsGIKHkxXy68N866PDGn3KYe1L3ga90eIlE10GZKC9V31cIVJIhTyjIYV6T+DB
 xuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573080; x=1790177880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ZkOZ2c5yMGDlE1TB5Cp+fPuQbHl7TzaWx2TA+LzciY=;
 b=Jd3srkzNLpDc8kYy0Q1TT080ECZFINfQTKsELrl3pzy9j47aNvFf4xNi4LamQz35K0
 y6KX4f/TB/sGh8q8GEbTB+/VLQcf6kXmmrnsHgG9szmHGNzb23ceza7edI6cDhHhA1BL
 o3FB9Bvh/8kvpq8+8pWPqoRtyabSVXpNrTTsmuCtP/1ApNJoGfuL35KWdtgIpf7wpoNa
 uqeg89xQKA3BXI+ZRHygHaGTzXaPzOIAUcK6vMQ+E04sa7ki8o1l4YNLtockENZpRLo6
 SGVa2cHrSd9pdyBmf51M/xw3ILQz/xnYQ2JzevawrPbrRdIxgs0whxZx8bArLKqFv38h
 +DYA==
X-Gm-Message-State: AFuF++lXTMb0TsAEDSs76bnxTpNGReyIRrQ1iD6Id21hOFYU72OX0PZC
 S4VNuE/wDKBF9yVIJP6Lz0gttGahX/Aaj3lCU6CHbYTHjF8MU79Hu7+IzoSWI0F5rR8=
X-Gm-Gg: AYBFou2LBJe+JoPHji7AZviGxXKbOWJZZoBaXybGr8fCbdOv368v7PYsXiW6uZJKF9E
 2I3oILb0owtjr79NHPDntr1JFhyBli9DaD1SwxSDxZ/+FMW6Lch8jdaAnbyUdH7aEABBQSljRKR
 EdXFC4/FctLuToQ15wQsaxSjZF7V5RhzjbTrI7n850ewiTfYgOJzi0SIaQMprJIgyu45MfXsDTk
 GRlK8GU/YNA1yBAwqG2AaSzahlv7m729SIdIsJSbE9L9YJjjdWGOZS/Zq11zOIenig3CFcIdF7I
 +KbVoShh6fClMhO13AcUgCCObGrAKvnug21mV85lCDeMQx0+7RxkZ/+KEtzo/tV37cY9DHado1n
 t1QdIEeNcGg1PZlx4La+a//vfmBajOPzNT/s0UyfFqLd3OaBdm/AkvyqGTj0AWRhP5wGJF/LVZ3
 d6+8X5+slI4nGSKiWPXNx0zZbcHqDpUCPnTXqV/zOq3ysZZJNYGO3vGdmqcdkxQ5eU4fuUhF4=
X-Received: by 2002:a05:600c:1d25:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-49fbd1ddf87mr245265e9.22.1789573079668; 
 Wed, 16 Sep 2026 08:37:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1b0e9bsm585365e9.9.2026.09.16.08.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:37:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 156E961AE2;
 Wed, 16 Sep 2026 16:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 18/19] tests/tcg: add console property to docker image
 custom target
Date: Wed, 16 Sep 2026 16:30:11 +0100
Message-ID: <20260916153013.2134555-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the meson docs this serialises the target in a special
"console" pool which also disables the buffering of stdout. This helps
avoid the appearance of a massive stall when a docker image is built.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 80205f6f98a..6c675a554cf 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -247,6 +247,7 @@ foreach target, plan: tcg_tests
       endif
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
+                        console: true,
                         output: 'no_output_' + image_name)
       image_targets += {cc_dockerfile: t}
     endif
-- 
2.47.3


