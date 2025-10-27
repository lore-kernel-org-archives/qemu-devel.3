Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F087CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNJX-0005su-7U; Mon, 27 Oct 2025 09:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNJN-0005gr-9m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:31:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNJA-0006Vl-Sg
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:30:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475c9881821so29128455e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571841; x=1762176641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ISfvytDL9JaFpO5GyERVyJ5N7+zNtsWsjpvSbfaaFQE=;
 b=qVyAilefKYi3Xt3rqaznkaihJXWyB0smGWhDiXZU45GHVscZHeYiHeGtB+sU/PM84g
 5hnQvW52L2tQ3UNMAf4nJr+Y/6QLo203Lx5sbEckE1pKUk88vSgBWZez6CyiuRc7DNzF
 CYCBMulo14br3uUInfrzJFW2I4to8ENPzB+Jp6nGrFU8PmsSeHH5W/5YTYNbsr72RcjL
 02veTLzU6zUbMbyFIMBOskB80jP7z82k//z6UM8rY135QpOWl0cDhOCqWo74ht1FwCGv
 676VBsl/nFtSxmHBtiarHPapZxMVuNCpa0e36VQXnfXWkkIhQ0SJ2UY6Z3W/KjgArNyH
 b95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571841; x=1762176641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISfvytDL9JaFpO5GyERVyJ5N7+zNtsWsjpvSbfaaFQE=;
 b=KQorlYXz/vNlQ+Yyhp6n8XUe4ezeHAedwfjft74Av6g4yjJVi7M/B7IxOcaeTlHOi1
 j0e6DAd5i3Wr9CbLZwwDuLg3duwraVjnLB2id9OfpDihCZkNnuVa1NrbEr9Ky1h/Iji/
 ykbd+tJxB1Iq1IpKdsOl6/Bg8jvoS7SKHd8mwz/R66URbvUIDmWNsRz6hFPOOR6s1Zyb
 x1jarRscQeZzBzFvg+g//EvAocgV9gysr2fg+NLZFoA4OTjx5YB5+9sowKGDeHfQqjhD
 yUWNzWsRVqmUt79/u68JaNsNKz5qb5QtWyi8XuSC+ZNsh3fUYHqT8jByrrJDK5A8Y1x1
 Om+w==
X-Gm-Message-State: AOJu0YzErQCiILmbI1ha/FgpNcudpyPQlOL+nQ4qTi+BA6cqag+a8jKC
 UebN7vKQtDw6YvfkDwEDUs9KaVLzMNLFCgk+RviQf93Xuw0RCh0HOuSMnvOJ2AVmi9323MGho04
 HFAc8imw=
X-Gm-Gg: ASbGncuALt0EfchmC7BUOUI+QgypywN9uGaTF5+LQw07xChcmBzf7aiOfRHepqf4Yxe
 jPdzhPjqp71Q9Gt56Gb6mJmgbxURme1A0bdyVhZrj5WtzZQkxrndKA4JV61t1BdjDMGNnaWc/tv
 vmwV9GBws4qs9VjID5MWosb6rCWsbl2I4oX2rk9o0MQTlm6O6P47LPh0CauwcXwjwYjf63nUL+W
 gDCEqH4j5JTBP+XPqBtz6SgmmyrpFbF8a04ha9nKTVfyeYjFfBwqpaP0w+ORvz+nPs/nZYFwZAm
 CDOVw04EmmHDE6mS/q+QumPvS5q0/qiKq3ddvqCc9dHSFdMZeFEIhDZ0m6eDHlFGT0rVD+SbjKb
 TRK02b1zmP2ui+cT2by4EMjUyHLeQ4+Uo/k4nKmdluX82NhcSK6PdHm0AXRSUsOsyJ44Pfof02J
 mU0k3ACBjlZrjsvQI96NXkz7+wHVo+aNV5RnMuu+xyuZLatySJtA==
X-Google-Smtp-Source: AGHT+IF7OF5MPcrm4JXMpX+7svHLSot2fTXpWbIqIuKu+VCCRd8L+9iq6+jl1/m8JeuZWlNbb4HWQQ==
X-Received: by 2002:a05:600c:41c3:b0:46f:b42e:e363 with SMTP id
 5b1f17b1804b1-475d244d75emr64063985e9.20.1761571839482; 
 Mon, 27 Oct 2025 06:30:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca979sm14525438f8f.14.2025.10.27.06.30.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 06:30:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/pci-host: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 14:30:33 +0100
Message-ID: <20251027133037.70487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Add the 'config-reg-check-high-bit' property in order to re-use
the generic pci_host_data_le_ops MemoryRegionOps.

Philippe Mathieu-Daudé (4):
  hw/pci/pci_host: Add 'config-reg-check-high-bit' property
  hw/pci-host/astro: Re-use generic pci_host_data_le_ops MemoryRegionOps
  hw/pci-host/dino: Re-use generic pci_host_data_le_ops MemoryRegionOps
  hw/pci-host/sabre: Re-use generic pci_host_data_le_ops MemoryRegionOps

 include/hw/pci/pci_host.h |  1 +
 hw/pci-host/astro.c       | 35 ++++++++---------------------------
 hw/pci-host/dino.c        | 30 ++++++++----------------------
 hw/pci-host/sabre.c       | 34 +++-------------------------------
 hw/pci/pci_host.c         | 10 +++++++---
 hw/pci-host/trace-events  |  4 ----
 6 files changed, 27 insertions(+), 87 deletions(-)

-- 
2.51.0


