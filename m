Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706AAC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQi-0006yt-9Y; Thu, 05 Jun 2025 12:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQg-0006y2-Ts
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQe-0007vu-J2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso188933366b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140815; x=1749745615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vA5SxIxLA+Xz/34QHBA8A6/byxaPtxZW/N/rmkKPYk=;
 b=uEZ7qWLz25JECCmRG1Dv0PEnbJwYYiYSd//yzthQnfyhFor5fkpjyf8ZKQKt9+yn8k
 yoQCZEjY25QiBrB1m+CDtRA6HL2TwziOeswEeuN9n0pGyDx+XWsy8GIlAyS/i35BcM1b
 Vt0wOoZGszzyjlP4n9Fhw3sJusrH+ckTsS/3wspGYoQsShclxQeHPc3k0pO43KmjNhAi
 Ri51qo3R5J4DZfg6pkJz+7/cnCEnYXt++RgHDry95aEo2/GmfNAgRGkqSwW3h1FxtzsR
 +hGdvEt9T41COnvgcdzkXwnw4bljedTzMt8osMxHV8xag7NWXUlxyws4XXK1HAhtEH01
 l7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140815; x=1749745615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vA5SxIxLA+Xz/34QHBA8A6/byxaPtxZW/N/rmkKPYk=;
 b=j/7Bwue1xMOS0NSRxnZSj5ABggPhtmXmwQnU2jTWd6KeTglmLiBCnlLHTLCmY3twqS
 HhmqIIfKOuj+M7pmPPB1bqebziqU+ZVOeVm+N4/JzV85LFRYV6OwNSCDY1/MEKD4eXKt
 p8t3PkU/FWGefdFpeRYn2AxySQiRtkiDyQC9m04QpMzamPv06wlyJfLvDwgSwtiQEh0Z
 uHTSw6pFRrDjO6BFH4XePTOQiNTZsJUIRj0C6gOLdxHlDdQ24oAcPxYp4YyyTosxUvL9
 z1i1sCT5d2OoZDGL28WjjJLfFrGaLjC7wRr0anyK1KyU2iirTSZ4dRb4EgKI2J0odktk
 QcSQ==
X-Gm-Message-State: AOJu0YybDT7b5qsf1S26uaw1Og26IKBYd8fAJ2/hO4c36QYhjvno7oeA
 mwPozjVEXlQjX7Rm4Mb1H2GzhilcCWwK2Qq7VQaGR2k8glJr2rixeCbsM83rYOzceUU=
X-Gm-Gg: ASbGncvgrMrzhgByv+X7DWp9mlDkMEu0Ge9d1LbdM4qLLtMdtk6B17VVBYGIbaYvRFg
 kR60+u/Osz97o6FRP96ms1n4PcvlZ+9TUlXD3sH1h4nulPcI7ED3veS+tdLZH7oTOPXF8jrm+pO
 6B0RWoZwWD3ZNQsZNeudmkh5mcHMLdJVFbnlC0WIft2yiN9iQ0ual2/q+6RAtYTXGhY0rxfr+Y5
 jGpNfjuyD66YOsQZ3HBJ3gaI+MkewRfqt0CFRBlChVXtXtNRv3+uqWBrDsyo5IOBa2Kds3dyhK8
 1O7uMIkMvVAF+n0Z2o2wEZsLKsel/T7FpaYU4naTHl9SskJt9RJE
X-Google-Smtp-Source: AGHT+IHzP18Nc0O524Rqx9NYOVjNye5wj1CnEZyt0L9t3ySstdf/b711TiRB03DMKBblqH6hCERv1w==
X-Received: by 2002:a17:907:1c1e:b0:add:ed0d:a56c with SMTP id
 a640c23a62f3a-addf8a813cbmr718258566b.0.1749140814716; 
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-addfae39c05sm260326266b.156.2025.06.05.09.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6EE15F7F6;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nabih Estefan <nabihestefan@google.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/17] tests/qtest: Avoid unaligned access in IGB test
Date: Thu,  5 Jun 2025 17:26:37 +0100
Message-ID: <20250605162651.2614401-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nabih Estefan <nabihestefan@google.com>

  ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment

Instead of straight casting the uint8_t array, we can use ldl_le_p and
lduw_l_p to assure the unaligned access works properly against
uint32_t and uint16_t.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
[AJB: fix commit message, remove unneeded casts]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-5-alex.bennee@linaro.org>

diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd..ab3ef6f0c3 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
     e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RA,
-                        le32_to_cpu(*(uint32_t *)address));
+                        ldl_le_p(address));
     e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
                         E1000_RAH_AV | E1000_RAH_POOL_1 |
-                        le16_to_cpu(*(uint16_t *)(address + 4)));
+                        lduw_le_p(address + 4));
 
     /* Set supported receive descriptor mode */
     e1000e_macreg_write(&d->e1000e,
-- 
2.47.2


