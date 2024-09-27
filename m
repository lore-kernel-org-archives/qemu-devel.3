Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E85CF6483
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIaI-0007if-5C; Fri, 27 Sep 2024 17:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaF-0007hy-Nn
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaE-0002Aj-7d
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cc60c9838so1506751f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727472779; x=1728077579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKBasu/qwstNMCkaYsJNHzojroDLlrGD1uq6uVGqcGI=;
 b=yvOQ19hIhIPctajjogTgdRqwDUGyZ1V1u4V+IOYB106omtRrQWXh5iW9fnRW/s+U2U
 RNBtJtZLeiUSsXzDvcTz/Xhjl9qcP1c4GzPD8kwpcUNFPFaKuW+ny8tVsdCh1nYoi4/i
 3UyO+1Gk9DfbEouemn630WNsGmJYiQ6nANlAT1bC5zhNFnov2F65mUwFzfdWTwtt6pqp
 8TpSY8DH/QylwtsVoM/fINPHD5r2FOQ6/fQkYKZQgMBhg7RKMRUzTfLOUfJ+UMpB7oFj
 jPseS6xmaOMj3awFV5+L9yUDdb0nOD41HupieA+B5dY21J/hixraJI1cWDKT0DkPsmAD
 HwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727472779; x=1728077579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKBasu/qwstNMCkaYsJNHzojroDLlrGD1uq6uVGqcGI=;
 b=samppA8YeXBg8vqppxwdATWhOW9RXl2JAM9R3t3jC+qRQMtGPo6MfTd3/KJnYJ6jJR
 sGcypoVbMZtKz2RTbNPyk5h0Az+lBeGdg4qyo7Xtww5BpH+l4YzW7GcGuBHljGTLp/6C
 jj/ALZX1vZCFkXFvK1rxDhG0NPk40M2iaF4Ziw2X5rujR3t0IU0/mGLpkfYp6hN9GLTo
 XfwXxfU6GXOqqXuESxR5J5FIcYhTN3ZpTyBXrYBqgeQztmwhNewf92xnwo3UPcd7BkcQ
 E1WA3XqOKqtKrVfQjjE5U1ZhOWhDl70r87hXIzMaQNMxb4JoFokHujfTaDhB7tIuseVo
 gteg==
X-Gm-Message-State: AOJu0YzL08+3jBfiR8R/s8Z5kftrxXIVMNkmCyXN3Rkce+tSE7Tdczj5
 9GCgg1pyGEY6kFNvYnXnCTo2+u9zzqCFeSE6IC6dIMXTawzoV3I0G8qC+rLo+0xKrhPtQhQMQ2I
 Y
X-Google-Smtp-Source: AGHT+IEg0/BbEW2p78Mbm7GbEw4svQprxWs0p7rW0jJvAX4leqcs9M1brqCG3j7bjYIjpbMfcPrxFw==
X-Received: by 2002:adf:f710:0:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-37cd56750c5mr3113340f8f.2.1727472779380; 
 Fri, 27 Sep 2024 14:32:59 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5730e6fsm3357571f8f.83.2024.09.27.14.32.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:32:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/loongarch: Build fw_cfg.c as common object
Date: Fri, 27 Sep 2024 23:32:52 +0200
Message-ID: <20240927213254.17552-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

LoongArch fw_cfg.c doesn't use target specific declarations,
build it as common object.

Philippe Mathieu-Daudé (2):
  hw/loongarch/virt: Remove unnecessary 'cpu.h' inclusion
  hw/loongarch/fw_cfg: Build in common_ss[]

 include/hw/loongarch/virt.h | 1 -
 hw/loongarch/meson.build    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.45.2


