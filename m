Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DEBC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1X0-0004B8-A9; Fri, 16 Aug 2024 14:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwc-0003D9-JN
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:54 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwb-0002KV-2I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d3d486d8bdso251140a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826212; x=1724431012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXryEFEA7lHJuOcvJ0eJXPDARQuNMSDNxcV14dvqN78=;
 b=d0GqBKRtoaTCNLivq0lRpT4CCGMYk7DRCsew2uhH2tgS5PLWx6qdZutkEAB7+H5K/b
 AL/K87ntTi/UWEpBwIJnE4ueA0A2E6jnAuIma2NKn65AamgPn0DJTOkSEuckv7lBJC7q
 aePjlDQepZVe79g+dM+JtZZTZ4ha9eD7ThNqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826212; x=1724431012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXryEFEA7lHJuOcvJ0eJXPDARQuNMSDNxcV14dvqN78=;
 b=uhtVLT0/0JstRtU4wz15bIA6KYPOOcH5WoeAFGuBeC8EEAwOx0/5gFVerxkQFaTvH+
 8HeEnvWFEm+RVURKaiPKC/ZUMovNAWa0At+8xpx7OkdVxrojMN085mg30dWDQySLHMJa
 sIywBr45b1S+RB1DDdI5DdsOYnDfieRH9hKhlb+zRJXaMuZFMo26R8Ld1flMYPi5yq7t
 eh8tjGCWdJhs49/PW4w1tVzK6uTi3OYlCxr9E3W4ClbBRweL/7qkomJpYUIdPsfKHhP9
 LIB5yLPOiEh03cwF4g/ikAzs2jp+PTCQKrP83+JknE5bdTyA9TlB+B0IOrdPi3UTUypU
 4DNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbnd7IGyrx5XMgPv711+emrdM+Y7AsIzvRVh7mpevOePBxDYxvDISd38wEx3FuBpLPTsLwzMIGDYx2niP1D1iJh908B6w=
X-Gm-Message-State: AOJu0YzixDAt/J+r1GJJ2O3zHn6SgnELFOMyX07QAz18bKBfulmqLhfo
 ueCaRvZiNr32sI8xdXV0V2uw0pIxc4Yai1wakZxW1WFE4PE0cZT/26LehXmNU+s=
X-Google-Smtp-Source: AGHT+IG1xMWqUlrBaBAM2Ig1Zy3oH2zeBxbPZinOUbKwoliYaJUy1oxjBTWzR1J+iAELeEsTT6ugXQ==
X-Received: by 2002:a17:90a:9a9:b0:2c4:cd15:3e4b with SMTP id
 98e67ed59e1d1-2d3e086417amr2226352a91.4.1723826211670; 
 Fri, 16 Aug 2024 09:36:51 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:51 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Fri, 16 Aug 2024 09:35:02 -0700
Message-Id: <20240816163504.789393-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816163504.789393-1-doug@schmorgal.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:29 -0400
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

When checking the QEMU_CAN_FRMF_TYPE_FD flag, we need to ignore other
potentially set flags. Before this change, received CAN FD frames from
SocketCAN weren't being recognized as CAN FD.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index ad0c4da3c8..8968672b84 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1003,7 +1003,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
 
         dlc = frame->can_dlc;
 
-        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
+        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
             is_canfd_frame = true;
 
             /* Store dlc value in Xilinx specific format. */
-- 
2.34.1


