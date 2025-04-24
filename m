Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0833C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85zp-0003B4-4K; Thu, 24 Apr 2025 19:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zm-0003Am-EF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zk-000865-MD
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso2110123b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537319; x=1746142119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=mbsnahsraMcExbEbLhahqEDd2ACVJIlBpJx5g9cuVpbOaLoNpkA0PxW+/IEt7fAuZN
 hIcFE5KIFBaoXp1NR1CKS93teRjC0QiYNZYtEgipLIBx71dAlh3awpfGd0Dgk7IqmD8T
 kcyhGzhABcC1y/cDOWfpgVHfPg/PjDgi322/V6dh94M/kPMpdAmyKrG/GwoV8A3tRnmF
 Q/zTZI3EVW4U7U/wHwKzkpSYdAUN2GNzwagRrxrWptOx6dXu8fMsys4Sxo+h7V3TZ0MG
 uKFgRxiSyUhFDveveFqB2imOFhi/xfFg/Swe4F3VWE2HVCiZ0oUZLjY12oOuqR0/MGd5
 1xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537319; x=1746142119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=iajYs4jxoFCZGNLdp3oY+u4AoDkA7Pp0AgJba9DCteE38L4K1jpe8HC9McRl1vpfvp
 SJWVYiuYJKs0wMrbWcD3XOV65bHAv8JTAhbMu7SmPSSPwnmTRtnD6xaMIDzuO1tCx89d
 CWGXQEkBtj/oabH50zLB/6DEk+Zv3e5vnuAukrAn2IEG0SpO5dLkh4mi/eP+CP35S4kk
 +U9YDzcumEZA592+bF04+daJbo2kD57X1Wbl2PLIdoUaFAtRYrlfTKrYzmgcHkWyNXvJ
 p9Ho4N7JvmwLiv9mZLOrAQBuJBuHCFu8qCBryOt4onJ3l54Ctc20gBBMZwRyzVJY7BOv
 deLA==
X-Gm-Message-State: AOJu0YyrF0S0LxrtGQmij5NUOazOZoQ8lwWIuPkk6el0NW4ekATBObAX
 Eqk73YHToEUoYjS3ngr5OkZruh1ldKTYErrJAa732JfteG27UJaKW+dTd6fZKt1OVqXrar9fXAH
 j9Ds=
X-Gm-Gg: ASbGncvuMo3aFAN85eQYqylQ6YTxCN4CrPz7D7M7jtPUddbIcWOdDb5B/Gd7SHFmNuE
 l6BMb4ZXlpmWUZHNI0QcKA+IJdUbUNbEq5jx8IfW4YHf62NsrpyMQ2/t8zLBphAKFWNpfCUGc9R
 ca/VP/J3aHkLj4/afnMGsbjlv1Fl489DFcpl93CYd5Q89KDAFoTKTpm6+GJZSN70ZnFTatJ52jb
 HwkuPlDOJXxRNK86E1ftoVJpuBj1QT5IzMPzC5poFPZRkgZGi4S4dRx2zM1aWCEjM8jxm/hLyM9
 1AMPa0AIISYcpZIMiulIDY8ClAQNQzHPIceS+Qx3
X-Google-Smtp-Source: AGHT+IGDAv7ZRPZK24JuZysSUxJD9eScszeTRLJf5rTSeNILzKD9xtRP+HXWEcWxmzdyLHweaX0IQQ==
X-Received: by 2002:a05:6a00:a8b:b0:73d:b1ff:c758 with SMTP id
 d2e1a72fcca58-73fd89776a2mr123943b3a.18.1745537319295; 
 Thu, 24 Apr 2025 16:28:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 1/8] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Thu, 24 Apr 2025 16:28:22 -0700
Message-Id: <20250424232829.141163-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
 hw/hyperv/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index d3d2668c71a..f4aa0a5ada9 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,4 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'), if_false: files('hv-balloon-stub.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


