Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0F1E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdk4-0005wY-2U; Fri, 06 Dec 2024 14:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdk2-0005w9-TT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdk1-0001f7-DN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434a2033562so22877105e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512311; x=1734117111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd/n06KQPsRfxFeQobyHwXgQczMYXIkFQbqkcOigBrk=;
 b=yB6I9kHDEnNlOQhz6Q+ukyMhfwXLMeS19PZGJ5DP18qSxy2L2ovtPp13XuD7ekWujf
 5Z9GaOuIT2LK0Pk+k8fVFKY0hJXer7PH+XcpKlUXO3dMLwoVvBRXsGgAnQ/UD3eabufC
 P+Lo2pvwMC4qzdXl+mPmmIzDSzEW55IjHvNbA52tFf2kfEcnNVHOwSUH34ifOjp+JCmv
 4B25V0LINBDLfLr/zqo24c7+0K53edCCZ0dXUDWmWTxH/54iiZng/1DSi4eO4HGtSNYj
 2O618ac7cPgUbFg6NqUFfg8KhhRroiY0itL1HJYM1dS41JgScaMm5JfuZ1KaAoL2ZSOR
 SUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512311; x=1734117111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dd/n06KQPsRfxFeQobyHwXgQczMYXIkFQbqkcOigBrk=;
 b=VyT9poYYusMynkHhrpTxr5UYFiYx6j2O9JlKZPp4QLMjS/d+8oJjriqMNDFr9ku/RQ
 3hqcmYJow2Zf3BNN7QuBgL5n8Lfv0obdxpoEIRGFZsQ4Himky1G7VxD6ZslnH79R5k6P
 nB2y0+NntQoXmnTKM+KyqhZb/i8024wgdHOyG6T0TeBrg8nhRI7X4bxI3kT7S6IRhbxm
 cPwCZ3MlykAQt/djO7Oivvoa6LxmAhi/mOp6ZkXaMkiZlXwG9zN73oeE8EAtGlH7qSID
 1PofwIJlBk2I4LETM2uZqMpd7QKWpb1ilEffMyl6w3nN5Z6lJRrwhIzL+u6ZpsP31j4C
 2k8w==
X-Gm-Message-State: AOJu0YxiKVcrtOKiXosAv88Li03/O00VXd3288PPTa2tFim3rKKXlM3l
 pJasJNMgOP0kFz44Qe4FKtEWNd7QsYx5czkS0HIv1iU5XZMFF8OYqIkItbr55MxPtrKtTYSTbuS
 Bleo=
X-Gm-Gg: ASbGncunhNU5kSFQAn0+vxOXQdiOSDw+nqXxvqihY6R2fAblW8/L4By/MWsb87DfuFt
 H6gbhVyjf78JxizwocPWl/jK4hB6w1vahgrjyTIg6Isv6fQwcjyeKanfM/8YXyUidaajWFdeJHf
 eYbGWOLufygyvcrY9agJVpEnH8a8fB7R0wckRgQ7OwKEJXA8uwee537QK77xZ28ktpAYbpsoait
 ZFTBQuZYE6lS6j8bMBlPpACBhmXpJPQoDnYy+cFsvyKq2HqHrAKBmPDCmf3RjTXW/c=
X-Google-Smtp-Source: AGHT+IElJnFcdcT/LB4j0hruCQiZPgjW4ukUbtLNpF4pGMAG0Gh/qVjGVv8Ya/oidsrZ2JHWPv/hZQ==
X-Received: by 2002:a05:600c:1e1e:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-434ddeb51c4mr35959325e9.8.1733512311712; 
 Fri, 06 Dec 2024 11:11:51 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5281229sm102098015e9.26.2024.12.06.11.11.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 11:11:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/timer/hpet: Have hpet_find() return an Object
Date: Fri,  6 Dec 2024 20:11:23 +0100
Message-ID: <20241206191124.9195-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206191124.9195-1-philmd@linaro.org>
References: <20241206191124.9195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/timer/hpet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index 2a95799a679..d11cdff0347 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -64,7 +64,7 @@
 
 #define HPET_INTCAP "hpet-intcap"
 
-static inline bool hpet_find(void)
+static inline Object *hpet_find(void)
 {
     return object_resolve_path_type("", TYPE_HPET, NULL);
 }
-- 
2.45.2


