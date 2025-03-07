Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52693C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgS-00050t-A7; Fri, 07 Mar 2025 16:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgQ-0004zr-Gi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:42 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgO-0001k8-Qp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224191d92e4so40006435ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384599; x=1741989399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=xKXrKAzwsA6OSQ6iJ6w1/M0w3++4VeUqjQKQBpM5T5V/PMAY6Xnf4WyW05lV38Cdik
 VRAAjT/KbMUDuJV97UEKdOT3cPcekwoyekPAnAbjWCcCNmp0ey3WuKgPI2/OS1yasTkF
 fJyHHpPfWMCiA+/Ic+1UnWi1l0PxVf8zOtGjRN4Q4iwoZFcwWz+Oy7bmu/x55HoBM739
 lxIotwTHJlnJoOaEmWTJC3AF2e88pAjFNcwJ3PYWi+1dE7bgZs4iowFba7A79/6kP3UQ
 NxSo8uE6P8Ig7i7iAAjDm4x4qkIAdpg4U66djVa+2gOzHb8RKYMCR45bAmknuVdxpvAo
 6ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384599; x=1741989399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=K503f6k2HfXxxY775f0q9TAAOccChJ/PntO0Y1veFySEGDql1/dgamhts1ddz4Fslk
 JRIsbT9VszqCy9kmpzmDTOnklZA2dcqvf7sKa9mExw+pg0rNHtiGgO4hT2d0X8qnmuDM
 4peIov3tKAaJAvt4gIUzQRrooJbI4W4/tWM18o8TeEqqhTkIu22F75P5TLljAwzsm0hF
 spgPi8jjLyTzJqKFEkShlMJwgqmmFJvk1ZwtrCnX6xzpSEv0/S1XnJGWsMx6+rwzNLlb
 wLVA2jkoDhM8BeSbEE9TPRYRJF9nz8VBTD7Q8i4L8aTDHN8qWWV02hBvS2LDoBGetXI3
 hG7Q==
X-Gm-Message-State: AOJu0YxqvlaGscqKzYDx1L0XwctE7DbRFO/07bsvtD63VMmgxJQddsD0
 NLn6Z7jmXEfTAyM4LcpnjPg/9oWSrWunYJY33mzYbp7Cvm89S9SYOS71ouRtBLiQpbllVX2WQAU
 0
X-Gm-Gg: ASbGncu/GCOEgCZl+MMYoBdtHLkgHs29BDSfgX2+91Wqv3eWm02Z9HLxXhUADW3D9MC
 JWvVqK9ZVevwPlgdIRv7/4kQ33CoxorttcD9pT8ZEr+KnJn6Ha9G/j9Ke78X1n9EDBMQr+Nulxh
 d3FAm8DJYpd27SQL9AXL6b9f7HxluPdOvP9JT5drVTJ8BC5BdAIJCYsIANKRryiKN1vVLhvvUvQ
 Pi0pFCqNkJMR1EeOymK2vfthxPGtv4uFUcPDTxSSA+1KMI6ZirpoMt362ecYQn7ojBOhiwLggyl
 CEu9Su4G2JmAk3g5UxPO2OzbXMJ6BO/TI+6Svmk/rlHK
X-Google-Smtp-Source: AGHT+IEf0nDxCbA48uVWT5RLLhww+kYNc7RKaulJqeeGh65HDYuCmuub/N7o5BoUJW92oxv3wqHUOw==
X-Received: by 2002:a05:6a00:2351:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-736aaa079e4mr7096514b3a.11.1741384599320; 
 Fri, 07 Mar 2025 13:56:39 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 6/7] hw/hyperv/balloon: common balloon compilation units
Date: Fri,  7 Mar 2025 13:56:22 -0800
Message-Id: <20250307215623.524987-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index a9f2045a9af..5acd709bdd5 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,5 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


