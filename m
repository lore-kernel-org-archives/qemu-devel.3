Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE82C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vj-0002AR-6D; Thu, 06 Mar 2025 01:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vJ-00020W-Ce
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vH-0006G9-5E
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso6763075ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243292; x=1741848092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS1pyoPrhLTMjTQ7DxzuSKRnXO6pGHCc8r+hitBpHy0=;
 b=iAKIq00fwKGtSQ2brdcrzmPj48Q9O47dRbv5I3Ou7EVRru0DVJMo20num14T05ji6y
 HrYTEWkq51C0nHLRFm7VfW0MM6fP4tekdxRMxm2uppMGsaWlxZmMIAxu9RCwXqMEGURa
 HqkhjfM53vc0LPNk6te/8PDZNIp8G0lHgx0Rcr9tvJJGaCa9z3knDN082yumurmmo907
 mc+XtbkySz7T6vRdg5XWGhRfsARQeck9PKKI09QD8aEpevqS2cRwjJvdRy9D8THeaSdA
 McA76vH31FTOMf3UnV9VzuW5IhQxKi8/y4bK9A9m0SUdDGGK60Q19hIh/MKcLA05SBv3
 PFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243292; x=1741848092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KS1pyoPrhLTMjTQ7DxzuSKRnXO6pGHCc8r+hitBpHy0=;
 b=kBiTKPBaV6NAu3N6WTSHZdxCeRKhh1OgphCL9skduMjXcOPG7kK3E2rCztyRqZd0bu
 NGMXX6s01QauP1WKOhixHHqnoeeSdMOEdfmim8AzK6Xp2E/d4vXPnrwdg+IASf/KZqof
 G7zbzy4GjmwhSoi4iGviZQsc4xV1l8WSGCJDye5I4NXQy34WBfxFYByjcThc+2GvloW3
 Xz7B7fHvmkULu6muw+YqC5gjdjvDeDuWickp1Rc8syajFTiaMzgJDFfpRGrVkH4C3/bI
 op4KTg5pUog3rBYC2wMaaIGOxlgjuF4GSo8lHFIzxGMsbh99yc7VqaCxTY5i2dUr0xlo
 617w==
X-Gm-Message-State: AOJu0Yz1717YpH73bLaASVjsB8AKCCyxaxvy0yIMGLqqSbyxI39J3QgZ
 sYNg9MV/Ebkj6+jRn0s7P5cZuALJdV/CnrAxNlpzbhnmtAXWEd2QhvjvRLABmukddJj0eYnIkGA
 h
X-Gm-Gg: ASbGncuZRlKkUodvDf930buzMF+4dtrvWWkXLuo5ZFGmvyU6IspZhQmg7vYZAhCrcLt
 HysgDnsVVU7kRFIYEsowfQsIqznle5POhOCpmrgDXnBKyFqobzvZXFGyUvr2c+OYDvD/eQOIw7L
 wQUbzoLCqhsRcyWSctAYh+PxgU1rpD+RLK6P8QArkTQWxhGwjduaAxxQRakzn6+IxXNbhJ6hmEJ
 9q2C8HhdJ0LEncccaVDKVvyZnKSwPAMPx9d17CG6+zthzC6WlyvM6w38hDQH0it+U1CzvP9L2FU
 9J2jfTOLx5Za3+iEk2APiBMqk9AogSIW6EFZScGOeoXR
X-Google-Smtp-Source: AGHT+IGXDmDFVP1/sw76lEJlHoFvgFi96AID39fEf8BwL58Sfr1TKu2UoT9IxZqKvUZKhteDcaLw6w==
X-Received: by 2002:a17:902:d4c5:b0:220:ea90:1925 with SMTP id
 d9443c01a7336-223f1d20313mr105946735ad.35.1741243292659; 
 Wed, 05 Mar 2025 22:41:32 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 7/7] hw/hyperv/hyperv_testdev: common compilation unit
Date: Wed,  5 Mar 2025 22:41:18 -0800
Message-Id: <20250306064118.3879213-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index 5acd709bdd5..ef5a596c8ab 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
-specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
-- 
2.39.5


