Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496BDC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClfw-0005cO-Td; Thu, 30 May 2024 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfv-0005be-5d
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:59 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClft-0006HL-02
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a626777f74eso125709766b.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098172; x=1717702972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32yQbNKYA/0QpYwGyLEbfW3tqRcvc30vIF3lo+QmN14=;
 b=WvH2LWEQpYp8Q5bSeGBHdDeAgwfgbgSh9s94/RIvygnDz6krOZRgc7hlod6t6GRarT
 ouf/fYcPnbiK6mOuex1lzb1FlB8e45rDhtsUVmlIN2kMwl8xvaUHXpcmrmP8N95aLx1t
 7c2vilNx65mBHxm1McXKWoRjeRDi2IITcqxhvRJchwoLHWzfdD+shhqwu+EYUH6p8sps
 DGsOiL71Sx6qeskWsFPiW8b2HVkC04ebccCNsHc8pPaWxji9hSylrTSM8SkwkonCi8Mc
 GLEPuA6pYgdUKcIgMwgMJaxBlHrgHrnn18uMSDfduZ/0TqvsvfxpgVGK9hsWOBH5EiRn
 cOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098172; x=1717702972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32yQbNKYA/0QpYwGyLEbfW3tqRcvc30vIF3lo+QmN14=;
 b=u42D9S0YXCKzhTtC5q5W0hkX9Gwa9BKY3x989wQPLKtjApiWMB7BF1F4cGOtcHMM/U
 +SfaJgiPGaEqNQDC5CXymj/tFptV7IZX65HMkNyrjEWLQthOHoY/dfT1i8sJulXgygh9
 a1o5MB3G1RKS/UpCL62Ib5886DgC3pS7EXgKNPF4oLiRbBGFQ/5PZDQ/sI4yZYsAlW28
 H9rD1wNYjW/tStl/JfjxzKOr9Dr9+kVYUqWL8/Jzw654QhltmhtkFAHFhsu1y9/dnwSr
 9o/NbbABK8XPMyDkZoqXH6eUANHAVcsropntNhvxol93EGsAi7/0NrrE8gafbP17ELOY
 FJDQ==
X-Gm-Message-State: AOJu0YxkraqBGYKfTtiG4h9Fk8o1GbcRJvgPuCHxeIEcyXVCs40ad1s7
 2nrOEdrZzcFCvI1OhlKqhNlnQ/vcJ2YBIve1YjJ+eqQ7xju2/klCHHTjvXeai2o=
X-Google-Smtp-Source: AGHT+IFTafnXNuDoHGvLjw9aFZh+7U9j0vtTJAyWKnYBLNX81Afkye3DJvtDOKRgz1AGcECBR87nFQ==
X-Received: by 2002:a17:906:f2d9:b0:a61:42ce:bbe4 with SMTP id
 a640c23a62f3a-a65e8e507f0mr301550166b.27.1717098171970; 
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb34204dsm7560266b.191.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA9075F8E5;
 Thu, 30 May 2024 20:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 3/5] cpu-target: don't set cpu->thread_id to bogus value
Date: Thu, 30 May 2024 20:42:48 +0100
Message-Id: <20240530194250.1801701-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The thread_id isn't valid until the threads are created. There is no
point setting it here. The only thing that cares about the thread_id
is qmp_query_cpus_fast.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpu-target.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5af120e8aa..499facf774 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -241,7 +241,6 @@ void cpu_exec_initfn(CPUState *cpu)
     cpu->num_ases = 0;
 
 #ifndef CONFIG_USER_ONLY
-    cpu->thread_id = qemu_get_thread_id();
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
 #endif
-- 
2.39.2


