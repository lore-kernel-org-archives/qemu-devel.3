Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F8DC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4Q-0000Nb-IC; Wed, 19 Mar 2025 14:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4L-0000Ex-0D
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4D-0006Nx-Lp
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so5959288f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408580; x=1743013380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrj2FOEziPdE/G6thO0Deku8uOYah5JXjO/VOAIZNSw=;
 b=TryTdMWcybzRbOlnHlM11Bkl6VlK+jGQi9mJ75yASZ2AsjAJA5qtMh/yDNAYDsJyJO
 pBsyPkXouUBWsbhNDmz2t1s5KWilC5EAVTWO/c8iihc374NTMjr4BcMxJWLhn3R8Gou/
 c9JutERmseSbjqck+vCrSbNzBY7uTpBl55rqOBEIkhxB+3rG+KTZCHy+PX9O8U1/UJId
 fvAqIFhUQhMjHZ7je4BOqz8sEKuakwfIc5hXs2QQAW6qeBVPuH1KGEBiAjpmea52EqTK
 oSO9w8V4Diphh23irqMiXu4GQy6COBPAUciPb3yQ8UJTtyetrpocabxW8/FFjevjJJY9
 YokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408580; x=1743013380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrj2FOEziPdE/G6thO0Deku8uOYah5JXjO/VOAIZNSw=;
 b=jZ1x85aO3Ho3jyD97fVbiC1wbBnkeRrsanv2cOiTLp+LVoeccfZEY2M+u64JHe8hYM
 K8003nxAcCvijXlhb67RxHzH7Dew8eW2KGUE2+KKJSyArVflH2v6EVJtlQkx3+IEYijM
 3YcUVFA63WgvZkASSHGVy2VdIrLDGMb/rk2d4uSyXRylyAAScywC552WO+cY2uGspJ6Y
 3G/qRGD4vR9GSUFZEsSQ6nAeXs/Q2fCmdULrpoJv9B+WDsKOMCpuv6h4OsZvftE1e38a
 /CRZrKzUVP1Xd5PPjW+3yyYTpwmNcQBz348qK3bHe843/GHSGgj7hwyWGYX2RPuxHKeI
 lP5w==
X-Gm-Message-State: AOJu0Yzxr+LLAy2Awj8em/KX8XLr2CvtrbdUReiGaoWbYdqr/vRW2zKa
 M07RRlp3q6nZ4Xf/hrgpxK0lDW2Go3t+xzgteUPfFP/Dnmlb+aXJZYnp4BxIkoU=
X-Gm-Gg: ASbGncum/9Djk8iUt19T2MJO8aS4EGuCjwnK90NipwJ6NDLKGoPMq4gRHG4OTBPHfHO
 ZEwbcCAy0OcLApUHk+0pLnRLZz784hDefGG390Sm9klFs0B9MRBRzvXi8kiRhR6LIRPsddCQWu8
 B/7qGBTQ6SyTou0AywDC2iB4c98xNasET4Y07gh8acU1RMe3UkHQEeXz8fJrLHvrE6Mz7vItLNO
 V+/NORe3MiWKzbceSQ69qvGlcg3W5YSWKv2C1E7KZLHqpT3fkeh9luEMuh3XYzgd5CbpystF+We
 Z9FzKevI1SeJmsGky9M8NxfGhpODn0H8SDJ6CIgN5NUIHlQ=
X-Google-Smtp-Source: AGHT+IEVCN/e6Xj9f6lEJbpLVeodU3hENIueCOrnve5cG/PNwBsYheZ1AWSIHuIzVdeQUsBmAYjDaQ==
X-Received: by 2002:a5d:47c6:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-3997383b6famr2952116f8f.0.1742408579791; 
 Wed, 19 Mar 2025 11:22:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cd78sm21633137f8f.78.2025.03.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB86E6038D;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 08/10] gdbstub: assert earlier in handle_read_all_regs
Date: Wed, 19 Mar 2025 18:22:53 +0000
Message-Id: <20250319182255.3096731-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

When things go wrong we want to assert on the register that failed to
be able to figure out what went wrong.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 3d7b1028e4..8561d9d527 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1350,8 +1350,8 @@ static void handle_read_all_regs(GArray *params, void *user_ctx)
         len += gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  reg_id);
+        g_assert(len == gdbserver_state.mem_buf->len);
     }
-    g_assert(len == gdbserver_state.mem_buf->len);
 
     gdb_memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     gdb_put_strbuf();
-- 
2.39.5


