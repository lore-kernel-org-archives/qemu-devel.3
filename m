Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E8DE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBwD-00048w-PH; Mon, 16 Dec 2024 09:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwB-0003yP-2X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:07 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw9-0000DJ-Jv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:06 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725f4025e25so3437558b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358744; x=1734963544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HQZLxuE4WkAz/upxnqd/naLC4R7g7qP4fmEdN0Xxm8=;
 b=vjJFGzbPsQf7wb9AnM/vHzvlwrEndAUlTEc0rjLcPwQ1d9BadHb2JryCDzO7Nyc/cM
 HuwZbGqdcj5uk0spBENymx7hgVNzc9UYAFABBQaP9r2mRBs8piHSIVNRtrAEEO6/Ka2q
 oZr3JFr6yaOG02bsZTNNji7z4lZi/Kak24KvaWOWKIWs/H/cenaslLqNVJnb/wr+yzLD
 q6TbOYUfHGFaXTz+bE6n3g8LTX91h3PnIJoYCFOssOxVUVPKplB7vWkhfRXXVdc/5XTf
 Mt6vi3CdvhnlJ/nsAaH30i7bfslSaae4OATI9IMNUr/B8Es7ECt5BTqKmtGu+Vxg0qmr
 yahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358744; x=1734963544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HQZLxuE4WkAz/upxnqd/naLC4R7g7qP4fmEdN0Xxm8=;
 b=Clu16shpvcowtCdMRC9tikGJ0W5pziZ12t3obIi42pE2O4pw+vDJrAqZjkLbGRiT9Q
 OMWsPTWzqUaTypJpO5h8cYr+oWiYaBR6/wN2RnCoBhrEz8frrF2RbN7gcA65ZIUTVcIx
 OiG2tR39/X0oN6ofjMUDzuZvkr/CMKZj8QQd3iZmwfXKD9pYUh+prVs0BmYttUZzfRd7
 l5BvEORoAPZZjxK7Y1d5uIDxTkyc5On4LtWAVLK9OPZdeYrQUnqKwg3L2FgvkUaF4REG
 awsLXj8KnBYI3+32xly6BZqITZVH7mdVt6LdKzghBQCkt/9Veu6VjnPZbrZZ9DdcgeBm
 qVmw==
X-Gm-Message-State: AOJu0YxourFBzdgFznyOH9hyQTCfLC4Nhkp6syuAbkBFoGUo0jP9IxC0
 i8AYV2yfkvIA+ze6DiCzenZap0cvHk8HLxhcnSjecRmbVaqh/g8Ae8yg0lDARiSdidan6B87KQk
 i
X-Gm-Gg: ASbGncuOjXWCq5IkjtQP4Ds4srG6G72zUy7I00Cwetrh7Vq6/xu+aTT27p4GbQDouDm
 8RjHy+DPXZ8uZWh6eLimg6/J7nE73PnWTZ7PcB6FBYbYOwURKup4p6pQ7W0JwcTSnNfYOxj0VS6
 q7LDWgdPS+qys7Cz6VvqSC6MjbVIGhokm7OwzrsAUcYPMiNDxstbAp3YdPGfhrnBBktR2mRkEpo
 DV35YhsqR4jKxJ//PjTC1fGtMpY3tj0JcwffkTj9+G4kfvmr0nL4ewofZ3btmU=
X-Google-Smtp-Source: AGHT+IHRWlwIJ6YYbgzPlkrSZls2CmBKN59/V5uHJeQwJs/LetMVl3O2riyc8t5uS1xEqQMhJPFkbw==
X-Received: by 2002:a05:6a20:6a11:b0:1e1:a211:bb4b with SMTP id
 adf61e73a8af0-1e1dfdda89dmr23782802637.31.1734358743818; 
 Mon, 16 Dec 2024 06:19:03 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:19:03 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 4/7] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Date: Mon, 16 Dec 2024 14:18:15 +0000
Message-Id: <20241216141818.111255-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231127052024.435743-5-gustavo.romero@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
 hw/misc/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem-pci.c
similarity index 100%
rename from hw/misc/ivshmem.c
rename to hw/misc/ivshmem-pci.c
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7a16ddb1dc..55f493521b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -38,7 +38,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
 system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
-- 
2.34.1


