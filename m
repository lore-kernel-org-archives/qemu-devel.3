Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159AD74EDF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbr-0004Ca-Id; Fri, 23 Jan 2026 09:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbo-00047I-5n
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:00 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbm-0007kd-4V
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so1474937f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180276; x=1769785076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q29Ka5cr2xkPMxnZvD8XyQ8JiFWoGTjH3UE+LFtmkh8=;
 b=WG6qouOZ0Jk5kMu4wXlFBSSTdke0yHp1re/e2p8k5JgbbsfFXY/2Xwp5QyB8Cj1DUF
 sJ7O9COwy76Q4cddsvpqbTxnStwf9Db1rfGE0ZjWI1a5KZSYfFKq2raLEVRsY0IA+aKV
 dgnyoD5tEgpRASYVQQj9ocaUK3JhSGxNYqbYKkyR9giBb45yL55Gag+Wg6ePxoXiVUPe
 8tbUC6MnSL/N89jAC9lFbfzqBoy5TxDjtM4DwyUpvakj1yYLYg5JXuo7JQk3CiorGfbA
 bg5pC9MbmBQw2BJtG+6uYzOBviFRbYOmEevMOt2jllFmiebavPIVz75wJ8+eaAgW+ikV
 t8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180276; x=1769785076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q29Ka5cr2xkPMxnZvD8XyQ8JiFWoGTjH3UE+LFtmkh8=;
 b=lQKfxF4wuiexmzwnHXNAy+/UtCDcyNVg0iP/oJzfP5F4m3xHh4tr/fG8h+trbgQQyZ
 M9AGpPDZ8S4n39BAg8vUHc05M5Dh3TbdfeEiXX55D2haqzv8ClVLAnvzlOJPVcNP+am3
 WdwZQqHZh0TslPAgTsW4VgNG3CEfZG7v0uop+5EdoNgvkAaE7l1WcPFnh514buOb8Kb2
 cx/wqH7Dl6/ftU2AewUJ9XJYueT8sazfZtL7b4BdoywbiwMlBe0nCnIQsxRirJ/A+KLm
 fMNvOo/gB9XbBXG20+BMXZrnT9m9SUJEXAeLwyy7bi1LC4WoSDkF0Uq6fxOEIz8f5JX7
 jwnw==
X-Gm-Message-State: AOJu0YxxvNqE5iHhCFXHtiOIPSrFGMxEjVLXLbks3WjQdqbODPVCV3C5
 JjPKSFz2lKzQ/wRxVapMUnmZBpwpFxIkVZs76LXhkvs3yBxKDZzOuXPKaUxRBBat3Aw=
X-Gm-Gg: AZuq6aIps8vjunz4FvGLciu288JW3qijY+GlpZVjgzr95x0wdxgr1rDEckOKUN6M1c3
 xJWN9SRHtk+Fk/CjeDc8IZ5lrIcJC+9RArtgzTMbNrSLXiBrSsGOXoiqU9GSNt7nU3oV7YQlXs4
 6nzTPuBoDJnMhcFt9MT8RlzDB4u4uaMd7jv2TvToB6ENJ3GqRRXT/H7MuJrV6+VMhtFmfOJWvHk
 xjRga1D90vG6Q37lcta+s7g7510e8SsWbXw89z7Af/mQtPPUmSjikjk+BPrAnswze5T5Tgho037
 /gRZlsgWDyu2aOfPVyd5TW+zkjv1qaXAlKuOEGGyyY9nEXg2GrMxeSWe73SEHG6U8pYiFOMHuak
 fFlqeNG1rJXcSF1PUmmDwdUSmjETVJtsjLuCIhszLO0F6jMIrvf4J9tMDD3Ktp0dxX/gKlnU6K3
 Ah07xaRmpUGSKeLMjrFsdU7Jc=
X-Received: by 2002:a05:6000:1a8a:b0:435:9801:d393 with SMTP id
 ffacd0b85a97d-435b1603648mr5655309f8f.37.1769180276409; 
 Fri, 23 Jan 2026 06:57:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm7049902f8f.38.2026.01.23.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB5725F898;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 03/16] MAINTAINERS: regularise the status fields
Date: Fri, 23 Jan 2026 14:57:36 +0000
Message-ID: <20260123145750.1200879-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
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

Orphaned isn't a state, Orphan is. Likewise all the other "Odd Fixes"
are capitalised so fix the ones that are not.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b256835647..851fa3b3d69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2694,7 +2694,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-S: Orphaned
+S: Orphan
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -2922,7 +2922,7 @@ S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Collin Walling <walling@linux.ibm.com>
-S: Odd fixes
+S: Odd Fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
 F: hw/s390x/3270-ccw.c
@@ -3841,7 +3841,7 @@ F: tests/unit/test-uuid.c
 
 Yank feature
 M: Lukas Straub <lukasstraub2@web.de>
-S: Odd fixes
+S: Odd Fixes
 F: util/yank.c
 F: migration/yank_functions*
 F: tests/unit/test-yank.c
-- 
2.47.3


