Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F7FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdWG-00014U-Qb; Fri, 07 Mar 2025 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVj-0000us-Ns
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVh-0007Wr-Bc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223fd89d036so47697015ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376248; x=1741981048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=B8Uh9Tezl36dZc+AS1n7DGo1POfBnY3F6ktg6+1w7A6yGqln8LoYhwHpd7TUUZr5Bd
 tkAh6PVDVOdcrbslhRC1DX5PnJBfk+AnnKFRjzHP9xsWUH3wefL26+yFzqzhcgn5iN3y
 Mmrc/PBgdjf42qgEfGP1FPctOOE7+gxBYZ8Z5nxN4Wp0cYmKz7g2pxUb6lwNS9BRhdbE
 pSqjvB/syrCXRTpFjLZ+GxbASk/Te1lBWfJ1LOrcwARN13T0vY7Ge6CyHl9neXM0EONZ
 iSSmBLnOJmWipYDIsQ8FPlDG//vAYkV0tsn0SNg2u80QIf8d42H6aQmDl3bov/uTWOLa
 7l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376248; x=1741981048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWZd7ZFPXeg1oTJFx/lxzeskCkUEMUuswiCEr0poukA=;
 b=cjBQpTfSwVio+AJbKr/oxFxhDGYdiuo9VbpNvZoILQxeEbLjFNQmel9qo+6qwsMhrS
 uquymIScnnI1p+5TdSJUO8iMZzpM5rC9fTJm8qg/bGWgLgjh6zFwTv97HMF6S2I5IO4I
 5DMqKDSjFBbw8tlDe7ifvbYhsnUk/1wxp/FTX12Vbj922ykcmKgTVP+6ErUYdwzXXAI2
 VHDvYqb4HjAS481ang7zZJ5MM+gXZLhzBAaBqVtvaM8huXNaCKeIAhoEQKd96l1ntrm1
 Rp3jmR+VbuMz9T401ppn6YzT2qLzLqi68w0FPtxPcBdwyn8Zqs3CwkizDr62B6kenyck
 3fHQ==
X-Gm-Message-State: AOJu0YxVZ9479JaOFMGbgUKlNsKgnaxGvEoUs1gKQ1EMsRLLIP7xcB54
 bXUoJFNFihrLbAI0WiIQBW6ei/AtC8osp6T3yg1JYumA6DI7zYfgtPhOZAwot5yjt+IXXpt89f1
 H
X-Gm-Gg: ASbGnctuoMgp13EVzL1gIR8F9eQuNuQURyond6k9dQeISmUybynxTtN0rpvq5v85kJz
 fZd96LAzhpGYBlvTLLekk6YWUf+a+KK6tJEzrFc+3MCXLYUGyfrtzXlrJpGz8+w2IFPSMyEYcmY
 LpaCohWwcIYCT81xrF/sANh50Q5EimeMHkT18jPyhaQZA/8ZkE0UG89K0AX2iI5qSrD2vGKhb09
 QK8qSYqEcKPle8+Orxiv9THlLbxec+9eQC6+KxFm1J5LcuZciHKX1vbvroCH+aT7Z3je4EFYaaC
 0SwvbkWpW0QjM/CMXN9rlIsw9vimaCp1DSfsGcZJoiLs
X-Google-Smtp-Source: AGHT+IGKXR+9X4ZONBcHhkFUf7VCkwDzjzA5G8MCEve5FuXHVvZ8UObc/5ZN1Vfg6Uhf+SHMCfpo5w==
X-Received: by 2002:a17:902:e947:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22428896951mr76142875ad.15.1741376247903; 
 Fri, 07 Mar 2025 11:37:27 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 6/7] hw/hyperv/balloon: common balloon compilation units
Date: Fri,  7 Mar 2025 11:37:11 -0800
Message-Id: <20250307193712.261415-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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


