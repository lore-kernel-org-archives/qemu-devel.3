Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF58AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tt-0002Ia-7T; Wed, 30 Apr 2025 10:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tm-0002Bl-84
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:58 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tk-0002en-Ja
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:57 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so6682988a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025135; x=1746629935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo98cnrbBzZhIVM6McCtIYbYMjUhtLO9PiS/H/WvU/o=;
 b=FGTfgQfVcXmZIjT4PgQnDU+mVzNaIREELwYG0/Cw6XW+qx23oNSjLJCPsVKLj17Qp9
 6VtaH2v9Z3gUiQdJMnQQH58UQj5hscUy0LG649mM2mx4JkfTMn8StCV74OMabWdNGHHp
 wYiSJnLjBMvMxTYyi5io0ufnokLOU8v1u1YWrezudKng/7Z17iiqeKLnJXQYo/LU9h1n
 cPD3lNeUppGss6/YvaQksqusZ59jsn/B4i8czbf8VRQ9ZWPb8loF8TzHSjb3XMS6otJG
 HqrPvBZ2S+daw9uDxiekscUXB6fQN//XHiD2ukbfgcJMSuPxcMGzObJzG+dWVp39ZmwW
 DXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025135; x=1746629935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bo98cnrbBzZhIVM6McCtIYbYMjUhtLO9PiS/H/WvU/o=;
 b=GQh1gEE2dtjvMUT+CxX/FDBH7wxELvqZ0yV2DCMs4w6L5FtIjPHfGV7WYaEclueXvm
 MOTdTEJtmJYBx3Lx0qMdVtl3XlRU/yEGPB76GbIoX9RSInKQCD4ChhKn/FRIkkWiDeBF
 ef55junVWQUCr37c+JEb32q3kzCrZUqjTaSXBSvPe+A3Qj2SxzaJmGNlLMcJ9TmULbvN
 /tiEfzz9OWSW72R+oRJNcyrjSt3H8tBhk44HrhyIPPijWSjTZt/rdsTUyQIZbV/ae8tV
 +91J89yfcvvqKE43SJxn01GKQscUKPvKdfgb9cC99R5m69AbZrHjXEQIEmSRaJ1meFRx
 DgFQ==
X-Gm-Message-State: AOJu0Yzmw7q2eSnh+NJ2XXbhPGPwVvwz/DkaAtQTpaCCaQfm/1ET0oJc
 UxJKbkPcyqVKxhiK+0UwM7DxZZsX1imv7NqJkpZFXBzoL/iZFI5vEw99avvRCkdeB7vV6eMqxhB
 6
X-Gm-Gg: ASbGncss8uKVMs6he7RlSlqh5BRvjtLpOiOFzPk0XSP8eimTCRIJ7Ed5dW04R5TRg0e
 TTrenr9qdVPexFw/77Gqjp/Xtet9fYI0L8Wb1B3DoOmcAriFj7OLJtZ24hXmxdnzFCgAAqm5kOw
 rYECKxSmk4D1zlM+Tr7ERplTI1YLlPXUqfJ/fUxBYN8TqVrYcR4TlCOv+VlOT7gpnXxmlkLHesU
 rg0/P9XAywZLxT06NvvhRo7t2pSuAsrKTTeJDAzzTFGpx0vsteQfvLH9xqPj+ZJpln0089m8NaR
 /0N/jdvbPBIXqPc8QcMK+x14thCkM036zoY7rakG6SRUUooYB28=
X-Google-Smtp-Source: AGHT+IGh+xI14t/EUkO03K5gb8Q/Zyfxn6CDYU6KjQw8SYsR7H4FRtVnj3pTQL/XPPn0r27PGqn4OQ==
X-Received: by 2002:a17:90b:2dd1:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-30a3336fa2dmr5823412a91.33.1746025135001; 
 Wed, 30 Apr 2025 07:58:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 05/12] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Wed, 30 Apr 2025 07:58:30 -0700
Message-ID: <20250430145838.1790471-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Needed in target/arm/cpu.c once kvm is possible.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..e34d3f5e6b4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


