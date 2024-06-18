Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C416C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJb5j-0003DG-KS; Tue, 18 Jun 2024 11:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5h-0003Ct-Pw; Tue, 18 Jun 2024 11:49:49 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sJb5f-0004st-2R; Tue, 18 Jun 2024 11:49:49 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cc9b887f1so246816e87.3; 
 Tue, 18 Jun 2024 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718725784; x=1719330584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPLZtK0QeERyzwGrC6JZXHapbKvTNkLQ3lh1zZectkY=;
 b=buszedKbezBEYyFs6Ul7GIxWkaM1cjUsVzZUxDkV+N4ezlmaBCps6Mu1f//J2L+8IY
 sWeptqhrlu3oINXf+QVo3RMZ8Z3WOl5zZvidvBtfBonrPAO9KWyvxH3P9/zTYbEpBO7y
 ko40U7KBpvugWhg9MAbnMe7BGYrSi6Uuu3wWf6WMmEMLMoqYBOtU+aoCKFUAFu7FggRY
 BA/iNmKNWyE/5lV0kL10mx3HE6vpkwVXP16rzoNj6hhsyZE1nykKj00cVOezTZ764AGs
 Crmy1XLLhAqA2Hc9vyk3EqDTcafMgV7piDg/owQq0iDdJzN6d/6U+t++JWAxNjbChLVm
 Yo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725784; x=1719330584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPLZtK0QeERyzwGrC6JZXHapbKvTNkLQ3lh1zZectkY=;
 b=P8+wRtMyeiw93Go8zTalDP9RK21LWHHHbrQfRAAON3cFiMn1RhV1spsj+3hN/OzBXK
 vrcCyc0EBqcj73wdvutOP7GTaRVULNZ0zOLEsnmS8S+RlDNfo/GvWypfs85iifBI0nSZ
 ELl5VBS3eagbSkPxUJ2FzzgeGyZBJMAg0XZu+AgtYuKCupDW2QlZ4xqQKDPXIMUkfWdx
 nO0h0v2qL03nX/VJRtve26IMbnZKwuK6VyptlwaFx873bXgJ1Dx3fO2OioPnc6PLxuta
 6RDmTB8bh2YOP5OsSJrdTd30GVzzZygaAiOG/9OVs2TdIG3tmetbVcGZfFk1qk4oyUk2
 EBXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6yx3w//KLhlL/lnEWB+mQPBpxRKLhIUQymVhasL3xQ1+bywA2sK+ZWKW0Km/F0AMKui7htd6nt4our/WEyFyT5vAg
X-Gm-Message-State: AOJu0YxRwQBKDlT10FbNxE0mJXV7LqSDDQK7OlaFRyAd60bda+XHzWZ4
 3F8uE4xjS80LEfo/U0qvHnacRtEfHnJgf5YERVbKuHwIiftwP8L1rTwb2SNimrx3AQ==
X-Google-Smtp-Source: AGHT+IG7YEzuWGosWrlq3mMTt+qdW7+EvYK3ZdhAEPYYxDL0nm+l9m7R5Pvno2weHZ6KQrhGvBAVtw==
X-Received: by 2002:a05:6512:3d0b:b0:52c:a8d8:4519 with SMTP id
 2adb3069b0e04-52ccaa92680mr5441e87.53.1718725784051; 
 Tue, 18 Jun 2024 08:49:44 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ca287240asm1543182e87.177.2024.06.18.08.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:49:43 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PULL v1 3/3] hw/net: Fix the transmission return size
Date: Tue, 18 Jun 2024 17:49:35 +0200
Message-ID: <20240618154935.203544-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618154935.203544-1-edgar.iglesias@gmail.com>
References: <20240618154935.203544-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Fea.Wang" <fea.wang@sifive.com>

Fix the transmission return size because not all bytes could be
transmitted successfully. So, return a successful length instead of a
constant value.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 7d1fd37b4a..05d41bd548 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -847,7 +847,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     axienet_eth_rx_notify(s);
 
     enet_update_irq(s);
-    return size;
+    return s->rxpos;
 }
 
 static size_t
-- 
2.43.0


