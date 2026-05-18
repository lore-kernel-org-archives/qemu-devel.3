Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D93CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsVA-00012s-EQ; Mon, 18 May 2026 03:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUO-0000gA-UO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUM-0000JS-4P
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so20437025e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089648; x=1779694448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JNG0WpLJF3nkTQNm/OVMSOxMuYSpcxBZJPbT2YaBCM=;
 b=VQIaSU8DQ9EPNuTg9FBpR3c71Zml22mVrrRk/mB74W7wreio2esRZc+09Hu7nlQu9l
 +8UaB/Of5Elf5/p6UqFBF19L9ja73XofyQELu4l+qyblP3+bTgN9pLURbXdeDzAqrEYA
 bOuOJLsOxRaHhEs9Qi4ep6iVNfbjnfA3qdXCw/D83t/s0QgftP1TINqmDFFoYHDkNyGg
 9y74nP52qyfd5R+ma6Am25GV8Vi1A0BZ7Qm9//htZzs5A7EpSZt4jbsZ6Sva2I6cf0Cb
 DZeztHEWcbVoS1FKrtR0dFBZ1/rYtayk5ch789uoMuXOadWfgGoWlykySOUcr+WSq57e
 trMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089648; x=1779694448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1JNG0WpLJF3nkTQNm/OVMSOxMuYSpcxBZJPbT2YaBCM=;
 b=pMEHq580P6MundS+YIZM3xC2PczbXpwD3Fu8U1qdhtE0hjgWQzYVOHbDWi0C4VK1O/
 GkSih95NGQtunJaRMCPcHCUJH/rYeW036Sc2E+0yokknyxc5P6x+94k7zhFnUQ0jYZi2
 KKJtFvBfnwvPeQTaE5yOmfHcUb9GLMXXeSKikO9+nQjlmVLlQug3H1nQWTD+yLvheMeE
 qYHf08OrDcqRuI+t5TFKGI2N7EcRzPNSJSXvOT/b7alFh8o1yLTGTP2ON8Mi4Wp8DA5s
 1cY9S2w9tCmQPlqJkLLTsJUg3uZc+rMBYiOXBG4dtvGrp8hA0a/nu7oMtC/iO4/7NWKU
 OsoQ==
X-Gm-Message-State: AOJu0YxIuYKI+5OtTnpyvHIgMAWwGz4Ex0C9DC121tNmGNjvUZ59a0qR
 AU84hiB7+oscZ0Dq48hf0WLk6A7rwKMUICdM2cHKvc9QbyDHizv4WntlIpyICkIl
X-Gm-Gg: Acq92OHrkZvrzKZ3CgIq9KvBUWz9mlEL/43FSWLcb77xqUxRETnTWngQFU591jrGVyZ
 F1uy/rgqGO4eCvLCQBi2Du6Kek1c6Iis5RxWaEXIJuOZ+lfk+HWFK93aqqls6bKvqB5J/LrdehI
 oCwfxIbS+TKU9GyQWQ8fBX5STATuw+ucuiAkN7O5kC8yK53P9W8TF6aayESWf/7Pa4JQhzNCTUD
 sblKmoE/bjv3f1SYwicuT/UAkTh6oTDkYRs+K6gfh+3iNWgjElVv0U4qm3Ljep0Vxc7H4/MJ/cy
 0joZlY/gQuzxxNziHC647Pend47asRHh/8Bc7uKmky+0/OgYwyLSpS13B8pWc2S8LCFWR3vpR5H
 pvkXAN/86ljkH22mQ1JJxUM1ndnYO+3jN5wtIGqoVNB5fBE8R0rkcJFH1h73yJXsVoRMPXllhJZ
 TDHuSmprpPAtCBRQgglXg/2MbbyGXkT8TRO1w+YjZ/uwbXWA==
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr233326225e9.21.1779089648389; 
 Mon, 18 May 2026 00:34:08 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:07 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v7 05/16] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Mon, 18 May 2026 09:33:50 +0200
Message-ID: <20260518073401.11279-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32a.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

It is assumed, that the programmable logic (PL) is always powered
during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
is set.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 6b1d96ff80..5608460dc7 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -333,7 +333,8 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
        /* Silicon 3.0 for version field, the mysterious reserved bit 23
         * and QEMU platform identifier.
         */
-       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
+       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 |
+                R_MCTRL_PCFG_POR_B_MASK | R_MCTRL_QEMU_MASK,
        .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
        .rsvd = 0x00f00303,
     },
-- 
2.47.3


