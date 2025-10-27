Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DAECCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL9f-0006ar-Kj; Mon, 27 Oct 2025 07:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9X-0006Aq-5D
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL99-0007bw-W8
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:42 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d6c11f39aso616708166b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563534; x=1762168334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OP5xRq/2+HQuKT/1mrxcUI8zA2gE9pSdxS9XYDeOM4Q=;
 b=Vq4IhoB3ssYO5rGQHt0zbCHxfC6kIzLo18Us1c/JPBymcOl5jx9f0hrQNndg7i0B/s
 3agt2nZ6E+Wef4wB4n6hSOGnS/GGfTuMUpvMsK+4onX8DrC8GZ2W0Ig9rNQpO7rpZPjh
 7wSaGtKke0bY0S3Mfds1ecXVs6qTZMyPMowZYPPVyWfp4NkuAKmLOK47Q01GrASIDPSJ
 roQ+bbGyAsSW/LnYq4mqGOZHVpecKprs8gJp+k8riHxeJ7VIhrbuuW9XadoHn0/vYrrt
 ZBSVL3n2W3YcNwgEJWe1Xm9JyJBCaQtuaP/z5X8+By5Fh3z3INMqPPa3zhEe+r1oq+2E
 12uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563534; x=1762168334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OP5xRq/2+HQuKT/1mrxcUI8zA2gE9pSdxS9XYDeOM4Q=;
 b=QrlEeA5NW680TPkH0Qjb0f4galzPHe3OwxCMbBHPQafwgKRjuajOv7shdb4puYNe0a
 oJoAvHXbzoBNYWo92vgWznFjTw7bcjLBmSPqNJ+zBdC8vBBJHiXY58AwWG6gq1d6TFl/
 SCo31rFhMnejM8e/1x4SaWASB71eDa3AQdqbeg0ep4dRv4TV/mIsGUz/PzBe20DPsxKD
 1Cqihscn+yAmyTtDjoJqne6XNygi/NY4h7mpvF8gAKGbeG3N4vHJXadIqX6nOXrjfqRH
 qEurfroAj1rf/yh7QwapOAY5/BwEkwS+vR7NYFgUM1l3zBPlT/i7R/fvVGoylKpF7BO8
 YqTA==
X-Gm-Message-State: AOJu0Yyq9jSH2rQw4HsXE7z6hQ1GswWa3lRTB2ujbKDTen6xtLjD2qux
 MIX10EZiUfZetiwwRuUFruZ8N8U8gac3mxZGORxMOtdmQI642/GLIW5ga2otV/OLBzw=
X-Gm-Gg: ASbGncvgjZemHT0RI3A/W/KwinPT94iWYkMGUVXUQ4pwmibCxeOz7MuHv33IGoU+E0r
 g1Q34NS0R8mYBJiVRU3QooSCUrhnlOSV2vUVAcL20ex7ViB4Mxde5JvGDlKFnP+dh/JCDD8PnC/
 8niK75FxyNp5daqBTLqKO6URmmAxLIkoM7niJjZcIZV8x9b7Zt69QH0hRePgjgZVnhLIjR1g0ad
 PJzjTzg5bSAApCesQfwQDJ/svK8T9h5SRsI2D4jB9Oev9gK7ag1wov7J/RIBN7GC0jRDQuW8n6y
 sh4zWQdhKq0fPSgke0/+Z7OsNn80R2R+uYdF6IBwVY2INnaVMFHqZBd9Hte7k8XAA/CbyP/hy4T
 AF2qzMjaMJ0cyOllXHVav/vWglGSvp7UpuuZfUvtuGCUOx7L8recM31Y9rNY6kGewdds5qnrT83
 gZ
X-Google-Smtp-Source: AGHT+IFf1e5BUD3bGIAW80hEOc4A/ZMLN+6c91S7j0DbPYjB69Ht/8CPBBkQ+pHOyAdD1COvmtiQuw==
X-Received: by 2002:a17:907:7f07:b0:b3f:9e3d:daa4 with SMTP id
 a640c23a62f3a-b6d51c50982mr1328725066b.65.1761563533351; 
 Mon, 27 Oct 2025 04:12:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541e99fsm728060866b.61.2025.10.27.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7247B61534;
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
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 35/35] semihosting: Fix GDB File-I/O FLEN
Date: Mon, 27 Oct 2025 11:03:42 +0000
Message-ID: <20251027110344.2289945-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Sean Anderson <sean.anderson@linux.dev>

fstat returns 0 on success and -1 on error. Since we have already
checked for error, ret must be zero. Therefore, any call to fstat on a
non-empty file will return -1/EOVERFLOW.

Restore the original logic that just did a byteswap. I don't really know
what the intention of the fixed commit was.

Fixes: a6300ed6b7 ("semihosting: Split out semihost_sys_flen")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 61001267965..c5a07cb947b 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -316,10 +316,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
                                 &size, 8, 0)) {
             ret = -1, err = EFAULT;
         } else {
-            size = be64_to_cpu(size);
-            if (ret != size) {
-                ret = -1, err = EOVERFLOW;
-            }
+            ret = be64_to_cpu(size);
         }
     }
     common_semi_cb(cs, ret, err);
-- 
2.47.3


