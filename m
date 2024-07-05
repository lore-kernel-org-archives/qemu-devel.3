Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B51C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVp-0001xP-L8; Fri, 05 Jul 2024 04:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVD-00008O-Ri
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV8-0003H8-W8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e37feeso1909379a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168865; x=1720773665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnXg+HsT3zKonIJOFIVyarDg9njum4HQEtwWGbAQUUg=;
 b=aaYtWWiRKdFMOIdK1e9Xp6hwbd5H4eAXmpamesPTHTUTlvjWsAfTXkFjf3p8ASCKGv
 0SX1DpMrob7FRpK3BBnR/XoYTOnK4qcy5gYZZ3/O9Y6pGOEHcVT/ooqITU/lM2hqx/Ek
 Ny8RdaHDeeJvYsAfT8GzZuAdR3kW2u7dhXcJ69u5y869v7vXH0Mo97cUeiJ6Rn8ucz/H
 uP07QMVmkfwfLOVKjb+X9l34IX6av09kcsjAoUeAqMVrRZq77kn2LBoXyT1n7umo9fI1
 jiuB6yhVwJB1cvr6eIgFZWUH0f/bS5Ah5wcFMnqusUhi74xXGDaK7T4OgAebJQvy9dux
 l8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168865; x=1720773665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnXg+HsT3zKonIJOFIVyarDg9njum4HQEtwWGbAQUUg=;
 b=H7G4Zcbg7DeksTGaFHUZcqyYfkkTQOTsxDSgvJdDpqcNc8UP0n8DX2QZ7E3tEmDh1V
 3LUax1fJThNkFr1gQCdsefGbaGpdih5Dnz/BcbvUnDu8Ou/c2sddGRxkeIxYu1bsk2Ip
 cFPx8encSgLqjvRDaRBWwfpo69h18XZR5Lul4NYn91DH/RtN8ePbadcXfs6KCSRAclPc
 GQi0ThAISG0NG0aIsp6AMYSGkcdJ3Asd63t2vFTRDy/jSR2LsRhV1nYHL4aiyDosJ8XM
 CLUthUdpAwL5NP3pD75ZcYLcxMkGi0JyQwZLsHNFnJto6alkCc5CYCeadGQePUP08Gqt
 v2Cg==
X-Gm-Message-State: AOJu0Yw3YzQKxlUeuxOBk4mDjV/QeN/lUJDZL9AI89/WIrk1Ve4ilrJW
 SwcRbuJPagmUvB+I0sLODCh3cE+207QhEgZbYvHs319GrfLcxwcqGbGb0nfezoM=
X-Google-Smtp-Source: AGHT+IFSSIbUcVdXgZp8yK2AWZCWQeltbYQ1mRgfBAYE/Pdm2b1OFf1TJephjonlDcK0naIC81q5zQ==
X-Received: by 2002:a17:906:d8c8:b0:a77:daa9:402 with SMTP id
 a640c23a62f3a-a77daa9052bmr11171666b.35.1720168865014; 
 Fri, 05 Jul 2024 01:41:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf61f69sm662766266b.67.2024.07.05.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:41:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CA5E5F92B;
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
Subject: [PATCH v2 27/40] plugins: Ensure vCPU index is assigned in init/exit
 hooks
Date: Fri,  5 Jul 2024 09:40:34 +0100
Message-Id: <20240705084047.857176-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since vCPUs are hashed by their index, this index can't
be uninitialized (UNASSIGNED_CPU_INDEX).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9d737d8278..a864275ae7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -245,6 +245,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
 
+    assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
     plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
@@ -263,6 +264,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
 
+    assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     qemu_rec_mutex_lock(&plugin.lock);
     success = g_hash_table_remove(plugin.cpu_ht, &cpu->cpu_index);
     g_assert(success);
-- 
2.39.2


