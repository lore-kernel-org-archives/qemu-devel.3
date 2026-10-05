Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678E0CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfol-0003a1-0I; Mon, 05 Oct 2026 06:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmA-0002Eu-OM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: from mail-wr2-x0d.google.com ([2a00:1450:4864:30::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm9-0000v8-2r
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-48c58132824so416531f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195507; x=1791800307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUBUYMm1004qLffoBCfnxHxkOtu1Deu7Cd7SJnpSF68=;
 b=rbjHqhuJYZnnT2wTRZj4gaWLMhdoYVkfaF3zA3gMLunXk+f6R8HpM5u+mK9Ef21+fc
 WF77SkHFOd7bJRAGVtSxTG9RqmhzoDTmVryJcpK2LAjUn70L4GmMpVB+Y8DHECczpbIE
 od40MTQgr5ow6sKzg3KuzVsTzuJoS4XTC+twn6xUvMkOszH+fIlx7VyKZPJ+i1bKLjji
 68W7fk8ZO90jKu3u8QXleQOdJz/ZQ0AZ6d8h7a87qMGwjP0leE8yjfSB22/RlKvL/kgv
 b6qGJy+6/QndzWxOTLrRJ6EQKlXGKhY+UajYqoSZMYPoTTgrpZXFKRpPrDRLa0uEbM5L
 PcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195507; x=1791800307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUBUYMm1004qLffoBCfnxHxkOtu1Deu7Cd7SJnpSF68=;
 b=UKXJl3JtsxX8Vds1C42/+7xkPgkRIyLivez+QbqLpfyaH4a2rXY6eveyl/r590cvbn
 gQ3JpgfX7Crj0sBZ2VncehJ6QpfDpYx+BcwPQ2ouMxI+YzJL8bOkY83LN3LSBJYwpv34
 Y3INcezUqUtkhiuF9T0CyiyAyqETCLMpdbePOLn9LTYnG8EefnPnPW6nh5vuhoVZaNAm
 U2yq/cbUrymHTyAJFXDGDYcF820U/m0jHRzMrFWbMybrcKDtqWLYaRkhEzITmiW4VL0j
 ciXx/Qy/E0WzL9vOPrEyen0X5Sr+DA0ThsP3Kbt3DuuD6U6mgkP4LDaBj6vVi3fm9v37
 lDFg==
X-Gm-Message-State: AFq9FYLjN62QWvpILuu3gbmkmRod/ooIs7329HNi0SuEDMZZ10GB4+t3
 6/JY56n7NctDoBSyQfG8P89e0YJka78lMvFhpcTzDn3eiT2tSpS81unz1C79qA==
X-Gm-Gg: AYBFou16NI6Dq7WnAEVgrSG+JQ3V/D4jytghHHQVZhakqI/REjj5g+EmGJAqkMcQIY0
 xpRktINGzPxcdlLmmndXXAKWVOJvtjpxDbN7CuKC+SEXh6pv7K8+QnaGv0JoflP1xIqSskhDtFP
 8XLDxNX0+M3Mm21C6hk8BYXMnsseEcnjP7k7eEbFyrY/AV8CEucBLNV66pnatkWIwQ6r9pOn/jn
 drGV/xco+CxWswR77REvbSc4VMJqspOCDD8vqTntfC9UZtB0RZchUaNwAZ3u8ysU46A5HzaN3V3
 14Wgu3i8nh+SCHZMeWFnYyr+F0HFi0C0dG3Tm3VQw/0mIIdWidUJYPddTjFEbvnwCCFFv1H7WYw
 +dOihRMeD2eORPIoQrjkvrCJ4uvl5SQp+9WkKJXcJlyXE4rC68DSxp6Tg2Sips773byHtwUiRSd
 ujMMHg5SRX81hLuqmAgYxjPSXTdbQ1G0w1az6m2YS4SJw00Nndn9xtlkJT2SEpbQPpDjxxG1b0v
 BbGKXjfnSlcu4DU16vC6wPZD20ofGspZrXrDXI=
X-Received: by 2002:a5d:5f56:0:b0:48c:43e1:a332 with SMTP id
 ffacd0b85a97d-48c43e1a741mr18398087f8f.7.1791195507382; 
 Mon, 05 Oct 2026 03:18:27 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 05/31] hw/arm/imx8mm-evk: Fix reference count of SoC object
Date: Mon,  5 Oct 2026 12:17:32 +0200
Message-ID: <20261005101800.10821-6-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::d;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Using sysbus_realize_and_unref() requires object_new() rather than
object_new_with_props(), otherwise the initial reference count is
subtracted twice, i.e. ends up being one too low.

Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit)
board")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mm-evk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index c3215b11cb..6de0d9c4a2 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
     ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
-    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
-                                         "soc", &error_fatal, NULL));
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-- 
2.56.0


