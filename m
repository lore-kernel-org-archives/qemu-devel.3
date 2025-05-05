Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31353C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl10-00040l-Va; Sun, 04 May 2025 21:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0f-0003tu-NJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0U-0002UW-TM
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so3409486b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409953; x=1747014753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=W7ntu4a5Tj+5Trm1lPa/7fCKpr+KbVUJZJoBFxd62mUmkDlpMea78PAEzrkVEk2KFo
 sEK5/AgEwpz2BQub2T3f9+EFxB2OSQpZHFHsetJK7tsBHB3pBqcZ6QN9G8KBH2xZU9CA
 zm24qTJFy3EpkcclKaATUHzd+twboGYeVSuv9kL0RPZcCUh8EgeVPSCp0rX1GmJyJ6LP
 cKLU3LUa4faxcDwYGBSC8MS793T21tQl03T2gZlvkW3EjNhyL0XpiFAsAJhUm3q/aSwi
 Qp9E8wKemcVjacvMBfivrBIYM4SjK6zx6jLoFszR0eVz0LK2iA9qAMb/Az3JwVBK5QpQ
 vX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409953; x=1747014753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=Ent4LWdbhXqjYA8HgIn92vwBh27ajXxtwkUC4bDGnD+FUCYWrdFrbpami7iDE6kLdp
 KJk/WwCFJcJqdtTZJnBPoP08SRDeWxc+Idb4V9mwioh4WjEjCp21WnACEpRohk2b6E8m
 rIEum7lfLToJUzmCVh2b17NGpqEkNlnENbxoJR3CD3765RSa/UfW/YsnJcW4VZOj2TR4
 jlapPKj2tI3HgO+hgWXN0Lx3fXedyL2yfPPzqU42tIMU3vBRPoHUgVKsL/BFQYrEALzo
 Bv4Ad34yiQBd0lzI2MopfG6TaObWmWWyM4Fm6l1Q/dGGMY+SVovLbUK0VQTB0z4aLhrf
 1RMg==
X-Gm-Message-State: AOJu0Yz43jNkxU4uEI/+EtewqwaF3dRvASmShztykrm/wvzfkBQO741A
 3quSN5HruaxJfp+KQSNyHTFO+1lDd7u8rQVGaWZ6gdNpThS4fMrPye7Wln8R5EkT1eJ+w5M5ZZU
 O2Qc=
X-Gm-Gg: ASbGnctzzVwOGIovp7CkgN4hVO5vGRpz+mxxKtabswvC8Udbp/VkzdBM+2Wl7NMe3XH
 ZdEGU3ut3Tktmgdk+AcsMc46StabRj8W4A8YAD/uHi9eZIWrV9mKqB/XzHc/oWRtwi06nYveSA2
 IK5VVnqY/3TAkxm0C0EKyqvWJFGnfR9wKgRkViXzr4A88wuPKUWBOlvZVt5EKP+f0e2uOSkFKVM
 zEl1SGY8yR0QIcFwol6JeAzMOpRI0s8/DRj2TnuJ+ZNnQ9XIl+gxIqSe7rHedMha2VN9p8v6klR
 9vJjKcGqPES7vdCgPLm0SW7ATO630u8UdiVYC2zb
X-Google-Smtp-Source: AGHT+IFwncbL/3OpuXVRzOUuTtFA0UcYGtHTDKFtJ5+PikCCokHOgPA7NXr+7+rU55xaMgEVDb7NZQ==
X-Received: by 2002:a05:6a20:d049:b0:204:4573:d855 with SMTP id
 adf61e73a8af0-20e9610a742mr7965931637.9.1746409953485; 
 Sun, 04 May 2025 18:52:33 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 06/48] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Sun,  4 May 2025 18:51:41 -0700
Message-ID: <20250505015223.3895275-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


