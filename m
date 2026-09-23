Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8B7C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MGc-0007jM-Ti; Wed, 23 Sep 2026 08:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxv-0004F4-9E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:49 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxr-0007A2-UU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:47 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d76so759496e87.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166031; x=1790770831; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ixAl6sKVptNbY5W9wtErOjtS2ajVLYqJQO6XYGsZnSY=;
 b=iFEJGH5/vSJfYI4FRd9yiPOPkmRxiEkPlNNP6Bjoip9lqti+92mJ4wg/tjeAc36f0A
 wbV4U27ugOLxc+wRe1beDQ4o5W2Zp8QDSRKkC9GEWF/RkwJARjgfg+kAd9+VAHNr1LlA
 pzkibMqjfRa3o6OB6SwEnDRrHL+AmxIsIG84eUhtpYwBKF6I+yS1imeJ0EcFhkZqSqab
 1/Rg/8pxUNqDAfyRCCAG6a4cRgfRnYHUSb5mcWVsktFjyw+i3JleGwFu5x5DZmMj71NF
 vB8gpb83Y+LXK6nClgLdmZQ2Tz/j3DffUsd84O1QRugGbVwcIR2l54Vdgu3ypF4osMHf
 HZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166031; x=1790770831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ixAl6sKVptNbY5W9wtErOjtS2ajVLYqJQO6XYGsZnSY=;
 b=WEjc6hym1Tm7vUTOHriY1SNHwaIG+ixmfoLWX+LaxMz2nloL3eWS7/PjWgrKmfon4h
 kA7rUD7Y0eOAfEOGqpw4GqQwWyIDF2HJ8Q32mrLtcGHvnilRr5QobgvZzGUl9sb90XUB
 6hd1+kzkDuYGHP+Y4Npj60JTFD3TZIUR3i9uk1o5SGQJe6m16wpPBkbOT50S0KntkKiJ
 LifabBMy6Ddzh2fNKi8MTyGfrEoAaZicf0rrnrUrnnqdKEDLaZwOYH++m91uxEp20LBL
 JdMYp0Y9vXmC742UTxN3zD7JrNX4u/j25F19jwhk9YkTZ4r2dSMou19GTGy5LmnSbgb+
 yhvQ==
X-Gm-Message-State: AFuF++nq/qBDoYO9dTvrWVQXvYj4U8pifFmQfIF6CSNs4koM221wJVwB
 anMGoBl170avYA2UiMyGO00UepM7UdsMRRnCSLejlOfIDTBvjMHaSFXS
X-Gm-Gg: AYBFou0BjEE5Ggsdwy8WZOnsuqlsQzL/iRVRq7ZzvCengB03SZrQyfR4YffzeuMxUx7
 fhYDNpxv83003+BV7YGhl+Xw6SzqfmPmQpoTFTwozLpXdpZSZckoBBgz/66lasFLfVO08Jpo7aL
 FaSOn9pHigsilgObAvXCT9/XVramsYLU9U2UvBM7CcrtsPor8mbyj8GGIt/6x1sWFkWfPFmUU5w
 K6ukGQ5xbqOu5Zjz6rOG8iGZTtD7igBPQofaBjaZu82FNVEJlksfFwMe5bxWs2hJrR3l5ZR6n28
 ypOP/WmAFAOcDtL7xlj/wyQRuyWCDj3niaMotfgEF53VL/fU3cudDF2wGmlFOElM00w5fHt8JKB
 SMff6gxyRj4VYeA2eyGFntA8i1iLgmc9TbBiEBAmP7BOdQSnhY0QkxLxsYAAfy6FukMAB2EdP87
 h8+SCTS1piSV8hjwj3ZZXywVWxRwze74AwjKafoHB7TPqAJVe37WdKlz04UZy5LNY97jRw6tYY6
 M+UFVElf8nGiyjVl81T
X-Received: by 2002:a05:6512:3f26:b0:5b6:4ae:5b83 with SMTP id
 2adb3069b0e04-5b8d89b6f07mr793983e87.33.1790166031229; 
 Wed, 23 Sep 2026 05:20:31 -0700 (PDT)
Received: from [127.0.0.2] (109-204-139-9.dhcp.ossk.fi. [109.204.139.9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d85897aesm552138e87.50.2026.09.23.05.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:31 -0700 (PDT)
From: =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Wed, 23 Sep 2026 15:20:04 +0300
Subject: [PATCH 3/3] hw/nvme: clear interrupts on controller reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nvme-intx-fixes-v1-3-fbf0e4e567a5@gmail.com>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
In-Reply-To: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790166028; l=757;
 i=mankku@gmail.com; s=20260923; h=from:subject:message-id;
 bh=qeH6QjBMRyEEjSqLx4JYFMxOLGBoKhwW7m8WsHv+XdA=;
 b=A+Kc81TYHeLJr0GFrzXLS1Pncl9Y0blMDerrllcybStRef+b1F9z9NyjavMZbrOqpRrNLG4Ip
 yXyLYcMO7J0Bo8Tm4Dh4KCZAM1Ybg3ouR1G4+c9qXJaEnWW3i+RWXwo
X-Developer-Key: i=mankku@gmail.com; a=ed25519;
 pk=vdAiS3IZFixKCwRmc+wfwUSPQWpEMkFYPH8m9evJZPc=
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 08:40:05 -0400
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

Clear stale CQ interrupt state and ensure the interrupt line is
deasserted when resetting an NVMe controller.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4142
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
---
 hw/nvme/ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 3545a3de236d..1de6a0e7f487 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8126,6 +8126,10 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     stl_le_p(&n->bar.intmc, 0);
     stl_le_p(&n->bar.cc, 0);
 
+    n->cq_pending = 0;
+    n->irq_status = 0;
+    nvme_irq_check(n);
+
     n->dbbuf_dbs = 0;
     n->dbbuf_eis = 0;
     n->dbbuf_enabled = false;

-- 
2.55.0


