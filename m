Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC40C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPebb-00018A-Il; Fri, 05 Jul 2024 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebG-0000tm-Te
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb5-0004Aa-8k
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b5f7bf3edso880706a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169232; x=1720774032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP7tDDLg44bwHUt8SqbYxvL0ekGWQNKDr20DKrRYxss=;
 b=oCRt8zXiielVnfGoVZacjZ6UYFMT3ewmaZh8tbnCS99ir/YPMpB7IKZBmTca0xLV0X
 jCEtgJftL9NF+LUE5viHwXkLYdw0ExmpvW+obOPNN9VYoxfTsrv2t8Fo52pZ/379soh4
 0zOa0Nv+Oq4G0EhmIB94/Tuvsfw3X5Utq2D5aVXbSZ8XTM1zLX3rWmU45e3kamFw5F+C
 2d3vEPiQvg2aIUQlpTY4Spk0eqNe7YWWs+x18Kayv2MhJZnOuazcpqMaxQlxZqqxDV2n
 NyxWLeWLoopiKoxbm+BCDCv6UfMsTyN+qusJFW3+FbCDY0BDUaYwPZKv9/WYKUYe0faZ
 KVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169232; x=1720774032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wP7tDDLg44bwHUt8SqbYxvL0ekGWQNKDr20DKrRYxss=;
 b=HF2IzBbvvLhGG6xPqpPcfV1I3kS2efElf0CGHGBOzfhPK6g2E+kbFGoQ5yLYJW5qBb
 BdGdpbmB2e9JNcN3XTrwC9lbwJxkeuAAZqTIxC5RNV2aKBwIvoKv+4l36dbvQFlYX+qf
 d+E2CAA5tiNdjVdVW5g1H6d+0qneohiHskwSf6qsGJLPJ+G02Yvqs3d6PdV08rQDN8uY
 0S57oGe3eGLZqgDmGWjeXZ/UbMuZSLzXFOQL56NirtYoWXByA8XrvAe4cKQiUWDKMKND
 PPznQ9gLFw6V2RqL/Ct7YJTbw0FoGSJ1zJoXfAUnvItLhCZfCM7zho4NtQ9WOstYS+KU
 3ihQ==
X-Gm-Message-State: AOJu0YwAt2YooqNFnhGpThSX+9YKKHl+OC05SoR1eaJeKpnM5yPb+Drb
 HPcJZUw1FsMxM6z2Fqs7PG7QioS0627lUoT3DXZRGkRxz7WhE/LTWvbvJVIOskA=
X-Google-Smtp-Source: AGHT+IH6pqLRN2BJry8uihFs7eo43QrE13jE3wSumHFBZkfY5J/MUYf4TRrBpTsgmSGz+kGUd0z0AQ==
X-Received: by 2002:a05:6402:5108:b0:58b:2d93:ad6c with SMTP id
 4fb4d7f45d1cf-58e5a408b30mr4002966a12.19.1720169231495; 
 Fri, 05 Jul 2024 01:47:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58eeabbf108sm1247721a12.93.2024.07.05.01.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 085AA62142;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 24/40] plugins/lockstep: make mixed-mode safe
Date: Fri,  5 Jul 2024 09:40:31 +0100
Message-Id: <20240705084047.857176-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

The ExecState is shared across the socket and if we want to compare
say 64 bit and 32 bit binaries we need the two to use the same sizes
for things.

Message-Id: <20240628124258.832466-11-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 111ec3fa27..761bcdf363 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -57,7 +57,7 @@ typedef struct {
 /* The execution state we compare */
 typedef struct {
     uint64_t pc;
-    unsigned long insn_count;
+    uint64_t insn_count;
 } ExecState;
 
 typedef struct {
@@ -148,7 +148,7 @@ static void report_divergance(ExecState *us, ExecState *them)
 
         g_string_printf(out,
                         "Δ insn_count @ 0x%016" PRIx64
-                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
+                        " (%"PRId64") vs 0x%016" PRIx64 " (%"PRId64")\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
-- 
2.39.2


