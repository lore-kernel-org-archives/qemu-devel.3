Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C799C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxj-0005HF-5n; Wed, 28 Aug 2024 09:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxh-00059W-4U
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:49 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxS-0002Kf-0H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8696e9bd24so730146666b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852612; x=1725457412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mC/R0iUzS3U5dDJtHLFRDcpd8CGk4MJdW7/QshJswmQ=;
 b=Q/yYljDuIrM8CNfSdyGDq+BBqmNI2ZuyhEnOrWekekncpr2TTL2TUYiPoeEs4UJFYp
 gh4BDIF6UGmvgXPwE8iN3YvopvqyhHSiTkaR6bsPXB6ySocq2GQjAD3DvJvGObClgXfa
 3oB8vcVY/zvkkocZglt9DFQEUbIRcCe1vZFWtannsd1q6oAVCEwEMCecNlgjDlx7zHYz
 hG9N2JRznz1xWDN2zyNwU/Av7soPBp4V+JjpPaycVgBBrQMJmiRE8EcaaCpSItOZRn2h
 YoCTrdSslT5fIZm0GdXWjdZHnLaTuQ06s1ShH0y2EtMRt4TSkQR1yxm6rL7G8d+uMF3E
 qz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852612; x=1725457412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mC/R0iUzS3U5dDJtHLFRDcpd8CGk4MJdW7/QshJswmQ=;
 b=pBkJA3TNucLaaESmw5qksgue8nCe2x741Y8oOYeLi4luxUh0eEZpM94US+EYAKryUk
 kU2rd9Cp44NDrX+IdoG8Nr50w7U+IVZgbZkOwL/e9aMdGuXGA1hIjt3q69lt0YM1XbGe
 meTdWoCwE8DVL6aeqdYqruVHPC5ZWh+G8H8EvxXQrNLr0wL2T/doYe8JcG5KAxPiNPCj
 pp4prdJ9Up0RS/C8V+4GuktAFeH/iyfkMn1YaBp1ESEYLZ5vsfjwuizm+6/GHTj20Mnr
 qRUIbwWyE/lbhkUpMxKydbqZTyzmjggNBKNkpP7Z07DTo0xntzAXFSFyZCxc6SUn8IAY
 tpVQ==
X-Gm-Message-State: AOJu0Yya92smulEuuBXh6uLBG1VdouJLLeLZYmeJBzfNxQjJpxrRh0XL
 3BueKkpf55/OxkFYZpjQxbYExr01dCr4dYfcLacNJ0UMYJNvGAiXkPZJ3A==
X-Google-Smtp-Source: AGHT+IFl5ufe5lc5+AxSZc8renlRAcaLlu3Iy1RYSE9OjabX+cYGde14Gw07caU9xhilCcw7teCDOQ==
X-Received: by 2002:a17:907:6d25:b0:a80:7ce0:8b2a with SMTP id
 a640c23a62f3a-a870a9b9a42mr154156666b.19.1724852612007; 
 Wed, 28 Aug 2024 06:43:32 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:31 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 2/7] vfio/igd: support legacy mode for all known generations
Date: Wed, 28 Aug 2024 15:43:23 +0200
Message-ID: <20240828134328.94528-3-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We're soon going to add support for legacy mode to ElkhartLake and
TigerLake devices. Those are gen 11 and 12 devices. At the moment, all
devices identified by our igd_gen function do support legacy mode. This
won't change when adding our new devices of gen 11 and 12. Therefore, it
makes more sense to accept legacy mode for all known devices instead of
maintaining a long list of known good generations. If we add a new
generation to igd_gen which doesn't support legacy mode for some reason,
it'll be easy to advance the check to reject legacy mode for this
specific generation.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 650a323dda..d5e57656a8 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -416,7 +416,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * devices maintain compatibility with generation 8.
      */
     gen = igd_gen(vdev);
-    if (gen != 6 && gen != 8) {
+    if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
         return;
-- 
2.46.0


