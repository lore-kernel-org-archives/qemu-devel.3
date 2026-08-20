Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC74BC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zG-0000Yv-2y; Thu, 20 Aug 2026 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zE-0000Y1-Ie
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zC-0005A2-Py
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso10158145e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787236997; x=1787841797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EOlP8ddaPlk71VLkEiYFvaBjk4ID6/66RcHruFcFYXo=;
 b=GqhhFv1l8liYJpvdyZEZJYEGXm4K5VpGZmnShDbYXjnITxYfU9Lb8SSR6L2D/f5442
 JIuD0SD4OfV/xUrKqBb8wjYgGoFuMB1EbY8sWB968AhNkxaaYNigG19GvHnqq7rAGixp
 Ko3smDH397akXTFfWFxjX4phOY3Y+k98Y0xRLgQD2w6zMbjIK5g34CZN/CmRbuVLGctS
 BntUv9ga15BgaAhagjMg7r4ELXs/bAREij7M673RmKcpCBdhHqAoylpkz8pRNsn6hXMu
 KH7/Hrmp/rvp30zSNARX8NjIHoBirDgJOarPmuj5KBlkleEvGeLR1ndjXczrJP7tYMIr
 zTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236997; x=1787841797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOlP8ddaPlk71VLkEiYFvaBjk4ID6/66RcHruFcFYXo=;
 b=euon2FgICFqxjvfpBGuZ6+u+Ik5fmAdkbgfGsuzqwYtJJY+lZ88pM9S7we87BVBzro
 BhxPDIpx3C83cG+wMXj7r+xuBQ+KRk1A7bu7QmmwpXvKgx1886mKL2ICZc9cQmH0W3zH
 X+U8feCFoFiAspf5UFJ6Tb7vMBUimndKO2PgyIgfgLGUOJMYVd8u297sPxPW7ZLvyPEv
 Q5Oo3xfCmlu9DZBQqg7fpwT3BC0imzJFGYEDNNFHTWaUmVrgC9NuiEMF+8ve7GGqKEn5
 sFuhlh7iKWeJDro55FjUrVsBOKyGcfIHQfrmcy/pVHyLjor8r8Ea4KkEcu70g+lbX5Ln
 qwfA==
X-Gm-Message-State: AOJu0YxkBje8+uhNPuOLVaF1gbyefwFLLmqMGYmNHCLP+NQpml342jqq
 tNdoSJ5lYl0rMjoN6ZOehG6thIm165Jg1BVPYqCzpVhZU3NxmysbVXK0cBF0Y7zkx3TfBo96c6T
 9DpC4
X-Gm-Gg: AR+sD10UEBMKYC8nwoTetA2BzC93PfOLG9JicD/ORVxK0/a2+rTNrcL/ymHwvTvJj7t
 Jq6e9RwWaYqGsnu9qcnQiVG0kff2qfwrSyfaiDVeXF7hMeAJDzoX8sBlSSS3S3hRMScVbfPgt1r
 uno+W54Q4oWx0Dq1jWMeuKZwXbqi2I1ZiBrMdHYWc6pYCnKnCRaEWCgP4DLh4oGZWPgAY8bUYd9
 901XU4WtOsvwBnSin6OCdMHK5w7gtD2wZuUd0cwtQKQT+5+lpKokvN9NrAwXr5NmAsCS9r28XYO
 5urZvXFH2X8NW2b7ZLY+K/Ky0FZQuTOhK1YQLfPJp39hNW42YzZjdx2TYSLcA8rrrrGIx26yv1X
 HkJRG3IufCL+nb8Jpjm12IUXQiXtBThTef3ujMiFyWMGEJ8UztqBUn4bQObboI2GBb7vuKY9wRN
 sWQiTASEYeOO8G0HJECF2ferD+9LFOKeQS0rgN92X+544Y9TUQnudu3ZDcy89dIuzA5Kin
X-Received: by 2002:a05:600c:3b03:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-499aa1f361emr201443685e9.12.1787236997287; 
 Thu, 20 Aug 2026 07:43:17 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:16 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 04/11] hw/ide/ahci: clear cur_cmd when the command list is
 unmapped
Date: Thu, 20 Aug 2026 16:43:02 +0200
Message-ID: <20260820144309.835173-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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

From: Denis V. Lunev <den@openvz.org>

ahci_unmap_clb_address() drops the CLB mapping but leaves cur_cmd
pointing into it. The cancel added by commit d9f78431d8 covers the
buffered reads, and ide_cancel_dma_sync() drains bus->dma->aiocb, but
neither reaches IDEState::pio_aiocb: a PIO write started before the
guest cleared PxCMD.ST completes afterwards and runs its second DRQ
phase against the stale header.

That is harmless while the CLB is direct RAM, because unmapping it
changes nothing. It is a use-after-free once PxCLB points at an MMIO
region, where address_space_map() hands out a bounce buffer that
dma_memory_unmap() then frees.

Clear cur_cmd after the cancel, so nothing reachable from a later
completion still refers to the freed mapping.

Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3719
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4043
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 995b40efd5..4c138b0c51 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -743,6 +743,12 @@ static void ahci_unmap_clb_address(AHCIDevice *ad)
     /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
     ide_cancel_dma_sync(ide_bus_active_if(&ad->port));
 
+    /*
+     * Whatever survives the cancel must not be left pointing into the
+     * mapping this function is about to drop.
+     */
+    ad->cur_cmd = NULL;
+
     if (ad->lst == NULL) {
         trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
-- 
2.53.0


