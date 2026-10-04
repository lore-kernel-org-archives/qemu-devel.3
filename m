Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A2DCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJo-0006VX-BD; Sun, 04 Oct 2026 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJm-0006UO-3r
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJk-00078R-Hd
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so347322f8f.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116867; x=1791721667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2l+Auy4ScM7gXk2vevj8YZ1+8P1Y9lWsrpDBhQ01iOA=;
 b=dWEAD6eFo4A7VmJs4ancBuRGdUN/xYOfsY/Im7Vmgu1ngar3LY0tv+QkKskL6Hz2Lp
 12fChtPj/lkA1QLIsm+P3ve8FRv0ycsnOZcaKHlQyn8fmWaIjIXveU0HBhrv01sZl0By
 GjO7v2ijM2aEbQhYLBaIKzndCr1gCAvyBSut3aEVlLzeQz0itIj8c4g40XwgKlEbtCaJ
 bY5F95WQHqXwBOyaMfMT3MakghALKABxLEKvPgk0eQqlqSxAuxzPEstwNyEdXLUw3Vva
 xErzi/wrRD4x2e9a3ag+wmE5avAz86fMl+IEhZK2BSHgnMlOj79foy5WsmCFreZij5kR
 SDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116867; x=1791721667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2l+Auy4ScM7gXk2vevj8YZ1+8P1Y9lWsrpDBhQ01iOA=;
 b=djSjj14a9TK2nOnm1c3CeejlGkLFnx709XNEXkE9wX3JH7qE+h+akAFNmQDTl7dfFt
 vkAc1P59KPDhUndy1KOqCxL9gPbs43y/OTnZGELLzRdiGz/ReaqgM0IBHeX1ixvwQNgU
 0/mb5r8XurLgiCy7tBXq7lWp7P6jER76zf6G2O7rykdf6cnETbJrAxjIpfHh6O5Y320p
 u6j55tgJauwhL8qBztrknD0XHmc/FcRUEDWa/asG9rxE5bbi0Oued+1kowOnKOfs5ViN
 oKFcwAlHyr+20zKji1t9bVsn95oygpygX+FwaIfs2ivGw05oNUcQbqbPq8sbMcya68kz
 rWQg==
X-Gm-Message-State: AFuF++n5AKN1YcPUZWz/f/ZuDmFS3j4/bEhNY4S6I885+gD+G6Jv2VMT
 DRfjc0OcCMnnxhKHmkHphoSd+EDApslzvNzA0NIKIacTHNBihfkpVEE1Rc/lgQ==
X-Gm-Gg: AYBFou0kUWDvFKFD0fU90WcZYwEflkvwgN9+YW3cmLLWx1w2AJQIwznqQJva72K2KAf
 OCKnYt3/1S54Ch+1g5WOqikLtBCFUYhGfvEXydlbkpTtgT6mfmPcxtKTL6Tmyi6uoGMwYy3Nbtm
 xywWWGGuEfWfWE/lRVXpGe6jjgzaYZQvPmgDbUGq0BWdtnY+cSIjlXBmniwbrszV85HrnpB/rEt
 6V6ijXgmShglLdgrQ5YsMXv7So7NeKr7v0cE5xI7d7U/IqjzJ0Ml4dbeIOdRmfM721RBie7Yniz
 AlNnyVZ1g1NOEuT7Haqj1nQUEns8nTQTmdYQODe+CrCdSh7gXgSEOfLzsHYZcPTTvI7jgOmT2d4
 ukW0aPsA+9r6net0ddQuWzAN3JUX1IMLBF5DVbZIIVTadI4jNtXb8L7l3AC49KIZepOCnHO8jxK
 yUEGqLzpAwqMW9Q7fAJubzhCO6ViyAok7GMqa4lUHFEGr35XwmlxvIcUf6M4YfnZABVoi0WqDew
 SwvdmsFDm+7JquOtQe4hz2iiQPoR/cnJJrgAg==
X-Received: by 2002:a05:600c:c490:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-4a1681018f7mr73472785e9.27.1791116866790; 
 Sun, 04 Oct 2026 05:27:46 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 09/30] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM
 by default
Date: Sun,  4 Oct 2026 14:26:25 +0200
Message-ID: <20261004122647.3913-10-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx7d-sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 65fdb19c06..47744e66a4 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -81,6 +81,8 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


