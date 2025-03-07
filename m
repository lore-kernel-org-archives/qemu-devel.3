Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5T-0002Ve-9T; Fri, 07 Mar 2025 14:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5Q-0002UM-3V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:20 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5O-0005u5-EY
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:19 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224191d92e4so37897045ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374617; x=1741979417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS1pyoPrhLTMjTQ7DxzuSKRnXO6pGHCc8r+hitBpHy0=;
 b=R5nPJRhBrecmz6ZfiUT/k0KattpXJexeOzTvUiv08/GQ45zdlBxeHCuSU4ZfgbcKpO
 gGFYMPEbiz4m7ulMp5VYONV1YKMfaPMftPe+SQvtxCfKmYFu4RWJtmUGvOPE3JzpG9dV
 hjB2AqoW5myKSFp63xbh0pbBwhoTddO5y5B4dz5UiBwrgvfnOYqdV5zepxMDhUsCt+7g
 W69XGjjnlLdXUBP8K9vxAtXiEpmuVnLLkL+JNMeOj1vF3gvkCwsx+tu6nsb9kISupb7k
 sjPScn6RoBPRD+vadi+7l7XU+50CL17OfjnHqXeV3DGNYLPw0qPjEyn0SfejMTXETOht
 aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374617; x=1741979417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KS1pyoPrhLTMjTQ7DxzuSKRnXO6pGHCc8r+hitBpHy0=;
 b=pLskGhp3rqNg5edIWTreYrA+d3gik4bWXnkShO1n68I8KEoa9yig+JUoCZ5PpOTww4
 E2Ocxey7/wG9r5xpLMD0iWs18k3Q4M/SkcYAmKlJzNL/dEwjO41F+97KpnNSzXOH/Aad
 YHTYxTuqleJ6N+AJod/Tn6fteXrJPR5QXHR0xxkdnaIPkuyX1zBuC1fRax7cyDumoW0z
 txM38Ozqu0He/TMwXb4pbiUj+Npw3onPC5R1265ElELT6P3y7eGDswlhcHs0yg3/YnPF
 jNQXqiprf0+xQFdg+gDp3HxMW9HZAkEj4qbLG7cc3IbPCvN5RH2iC25u058veWwpe2XD
 35Sg==
X-Gm-Message-State: AOJu0YwH/xCenPnp0p5rm5yt+GSYJ62tkkAliH2DPN3w8ygu4Dy2Le81
 4qEvj++O5vWoMk78rv3TBqNfHMLWb/bHyLThOXdp1r+Eji/Yc553pEkEIVo1DaG34sV2b6vCkx6
 g
X-Gm-Gg: ASbGncuGcDOvflrG2GvkimwK4Ju3IkbG0Vrk1JrYUaC5LAX0JgjFwt3IK1UadZPx4Zj
 mob9rlzdeo4Mpuarzdinrxn3ygZ0jwVNlU05m1l7E7P8Ln0860meY6WnswXZ777CHQrlcIrPuWr
 /Vcqeyf8TOJ3rk3SUII/4iRUhGdro++Dch1CeNo3xAA6Bq6iaazZBCyZhztRBYgK0qe8Ejd3K1w
 DwtKKFA5eit2LLMWiysdzz/EWF85n1GT32ChiyVwCmmFh0KcOVgyZT8x9uGvbR4ARCOVpZvxyuu
 UIbCZ7zKCgZ9r7+xMJxDUIiBQfAUA3kg9F4YkBLz7MVa
X-Google-Smtp-Source: AGHT+IG6FYKNJhA8fJgyJC2Shcb8wrPw9XFICBMg0Te6QK6uwGTN0bNhmb4BB9yGI8nrBiug8C0XEA==
X-Received: by 2002:a05:6a00:4b4a:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-736aaab75e8mr6208720b3a.15.1741374617086; 
 Fri, 07 Mar 2025 11:10:17 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 7/7] hw/hyperv/hyperv_testdev: common compilation unit
Date: Fri,  7 Mar 2025 11:10:03 -0800
Message-Id: <20250307191003.248950-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


