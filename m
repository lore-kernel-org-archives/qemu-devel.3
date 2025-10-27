Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EDACCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9V-00068T-U9; Mon, 27 Oct 2025 07:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9I-0005fu-UU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL98-0007aV-H2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso8919387a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563530; x=1762168330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K5oRo7LWMzZl+QpfA7sUsVfS53Gw1PvvtIAKjntjao=;
 b=gXgWuVMU/FI2ra3vVJZPW5fa5VnBGpIDFbMV/o191w87/CZ4MObZHSSpHmPBRCAKDo
 uA2MINhFLbIa+g6hUs3qFC8g85f9QBhDZqQEU0PO9G3IBMqDY/xL6kwcOLXsIAlFDGCj
 qHe5frxXa7Q+HHqdyfGTtloMBNOKOeELhRxbJmylO/lNirFtk3C7q+uXXn6SOPwRyoB5
 jWKdpoMQ5DWiACPKcLd1AAINNzPzYlnnOMZEHniCEmK3Rak6qGILODiOfbZ3whYik40t
 hAAZr2mjNO9D9InGATr1ENUeLiyAfmj1CvKuK4ph8o5YwPgpj+MbyGS4DGcGSBOtAgSy
 CVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563530; x=1762168330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K5oRo7LWMzZl+QpfA7sUsVfS53Gw1PvvtIAKjntjao=;
 b=DWYWhoR+gjyKDC78JZBweEEkbBuReVNBKA1zE1eMDewRnJK84wvEEQ1MswhL47cm0Y
 UpvU1RwIh+hUo/yKp2CPp+wsLnQOP5JRINOlX67PZ4RvU7/GaqpdTFY/wI/aIZtyGToe
 GX1DrHNza7I8FvylwEJn9BQv3GmYRdrr93ntcSOZ7f143lk0lioQ14nYGx+tmvcXfQKD
 FRS/ZXqfpajQaFwV0Udv7SXopEu/E6MiVz++fEGCaxeFD0+fCBiYyBszwEvcGRqu1Mpm
 z+QKt7QMfl5CfR2Acn4hQy0Zs+zGRWDuZl8LCBvhphV5gLIL+yTierk7O8gkzywfpTjI
 oXMQ==
X-Gm-Message-State: AOJu0YwCzOjATEi5IYOCt7NyS/QraGKGH/2wFDWj7wmaJzTcSDY9QufC
 2oiu7GaA//Vp5zTS2C3Jk0W1aK+QU86hPUHJfqp4BS4JDj+jXDhnMFqGael+bxPDoW4=
X-Gm-Gg: ASbGncuYwjxSAaLY142l3yQzznSNIny59AKRQY+B6hKPiVCm5/borQZ3buugZeGfIre
 M/Xj5ewyHMyeaCYL4gAszqb5GR/g1/iTxPQR0ASUoYiIKB8aAWDVY5ZfYbBa59D4Gwixbvb67ag
 Qgyj52aVq6UnF9xNE48lwPXVnkKE0bIBQP+VWHwmH621lOkVkQd8ljAkYWkqZem/0PMW7j8Fd9R
 V2UAIt8dCyJcanPVXaV49YUMAEuuurJ4lCMqtWdoOc9Ksuok0iAcG/nlSWi1b50JRxLXbW8BG1S
 o7kJAo07z6Ro07uTt2NBtdGPDzM3H1VlfQ0liZwRBN738YdfTPqCFz5NKrEm1Vi7+OqHPxWFSjk
 nGOUiK14T4eI2+XnqbKgu8668u39NKtV1CuMf9Mj55qFm0zj+zR/IixyZs61f7bGeqtDOXSuUlp
 FmREoH/IBt7Po=
X-Google-Smtp-Source: AGHT+IGRNtHaeBs6dkf1tkgtMQn/OMS4FTT0K2dUS+olDng6buVSaegQ/gjnJk3ecwVpMDLXGGR0GQ==
X-Received: by 2002:a05:6402:51cb:b0:62d:6601:a6cf with SMTP id
 4fb4d7f45d1cf-63e5eb18e5cmr10018586a12.9.1761563530082; 
 Mon, 27 Oct 2025 04:12:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef95cb9sm6162656a12.17.2025.10.27.04.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C36161528;
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
Subject: [PATCH 32/35] plugins/core: add missing QEMU_DISABLE_CFI annotations
Date: Mon, 27 Oct 2025 11:03:39 +0000
Message-ID: <20251027110344.2289945-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Most of the memory callbacks come directly from the generated code
however we have do have a a direct from C callback for the slow-path
and memory helpers.

There is also a reset callback that calls out to plugins.

Like the other plugin points we need to disable CFI as we are making
function calls to dynamically linked libraries.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3175
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c   | 1 +
 plugins/loader.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 35a252d2729..8f8bc7219c2 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -668,6 +668,7 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
     }
 }
 
+QEMU_DISABLE_CFI
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
                              uint64_t value_high,
diff --git a/plugins/loader.c b/plugins/loader.c
index ba10ebac993..0dbe7bea263 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -318,6 +318,7 @@ struct qemu_plugin_reset_data {
     bool reset;
 };
 
+QEMU_DISABLE_CFI
 static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
 {
     struct qemu_plugin_ctx *ctx = data->ctx;
-- 
2.47.3


