Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60920CAC59D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya6o-0006KI-3c; Tue, 16 Sep 2025 14:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya58-0003Ty-Tf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0001ei-1C
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ebf23c0d27so1158793f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046015; x=1758650815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YhTnH9wNwgFi/SzqMsXE+M8cpU3Hir6pM6j4YcAhL7s=;
 b=LO8uo1GvGtYnkFV9K+FNRmnDdYszL7NfgoMtYT0baM1x2KkCXSUs0iR9aA/8VV1FZ5
 +byx+N2U5ZA5AZKHvg5bo98f5ryLRFsZ2kBw385pSYjkinYwHwMuZxfLr3aY5BFH8hq7
 9qiSZusGmJKqCFdJuO4tVAIsiKqhcd/Q85hC5rtJqziWj+mUJwds/uyMy7a3/8fbJRFJ
 1cKjSmehNEj5DXDAXfNsVhR0NByTwUVnj1R4SbNyFK6f/7E/8A8z43ZjhVf2pDoWq+Mk
 fyh2YHa7owGo9rRDjLcDxBZHrFcS0Ideaz+ENBJZ/L/I68W/rC6hL5dBXcs4E39ZuvLh
 bHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046015; x=1758650815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhTnH9wNwgFi/SzqMsXE+M8cpU3Hir6pM6j4YcAhL7s=;
 b=dpGdUva/aAqlqtmBz1vXC6Tlksx5po6T1T10DisPDtqzGGRH4wTgw0+oY8ZXtmSbYG
 ZBmaVehpABYNh7MK/3rtSOM/a1RdsSco0cIRivkFnhLmaXMgYfFfEmedTtl3YhtNFsb0
 uZe+5TEIp7cM0ljL8PeFPYZ7k4GvGRKLftDJRfiuj4DZBnuRnIgtbLqMVE23l8LH7l+R
 1Mq75ZC2E9tbpXEQSNPK5Yjg9rddvZQX6cZvSvbCiMB37OWl+oM7uK4iWuD9bVksgVwL
 UigrRISiqqnT5PZ5YpZqslO+XwPvCSutmljkyqgxjaQ8KDMWIt+CxLHN8huOStoXijMz
 oXsA==
X-Gm-Message-State: AOJu0YzJQ4rXcPYwxxSSHEPHeVqVwNJh4+vPcgQxMzDUbVBQnBSSG8ay
 KQ33joRW/GPqyVfN5nXCnqJpfNUYLiIln4FXcrEFzWVLNBSISDFLeOD7c3bTnOuMRNKaM9Ik+bU
 Eh/EX
X-Gm-Gg: ASbGncuqKWevo8zclL8vpkwFRvWguZM00KAJzN128MRGmd+g1Vb3HWhWpIKHrxCyaiJ
 q/sQTqXv1X3qfJSrMsGAndm3JUJgKR4xuNPI/btj2msex8XZNRH6xgKgVddU+ztgDcH4g8zs6pX
 98xlA8oEf21QAsll/tLih0j1lplqGn3hBi1O0X8Ah4F86/zhDsY1H3n8lbviSlCcbAJ25yVNT9k
 LCx0k+SNc/C3do9LtrF2o3QWbkRJ9gXPSOdbwnkGmnxulk/p9zTVZMrr+oHpywA6FVmbSoUAS62
 eMtalagXCyIDmmW0gG7p1Ww0m02cl8UqfgbISOrpXfKAheyRVbmcJpbSnThmlN7xHQYvX1ZNs7k
 s5JQ9NVcAISBSv6zd0hDbrxEbhv6c
X-Google-Smtp-Source: AGHT+IHLVxow+Qy6wIDHyeTHFJswQ1vPcLVHUqyMk46fDzv83hzqs7q8c1x4epDpIi3oMABGZAUToA==
X-Received: by 2002:a05:6000:2289:b0:3e5:47a9:1c7a with SMTP id
 ffacd0b85a97d-3e765a157b7mr16345160f8f.62.1758046014766; 
 Tue, 16 Sep 2025 11:06:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] hw/usb/network: Remove hardcoded 0x40 prefix in
 STRING_ETHADDR response
Date: Tue, 16 Sep 2025 19:06:10 +0100
Message-ID: <20250916180611.1481266-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Stéphane Graber <stgraber@stgraber.org>

USB NICs have a "40:" prefix hardcoded for all MAC addresses when we
return the guest the MAC address if it queries the STRING_ETHADDR USB
string property.  This doesn't match what we use for the
OID_802_3_PERMANENT_ADDRESS or OID_802_3_CURRENT_ADDRESS OIDs for
NDIS, or the MAC address we actually use in the QEMU networking code
to send/receive packets for this device, or the NIC info string we
print for users.  In all those other places we directly use
s->conf.macaddr.a, which is the full thing the user asks for.

This overrides user-provided configuration and leads to an inconsistent
experience.

I couldn't find any documented reason (comment or git commits) for
this behavior.  It seems like everyone is just expecting the MAC
address to be fully passed through to the guest, but it isn't.

This may have been a debugging hack that accidentally made it through
to the accepted patch: it has been in the code since it was originally
added back in 2008.

This is also particularly problematic as the "40:" prefix isn't a
reserved prefix for MAC addresses (IEEE OUI).  There are a number of
valid allocations out there which use this prefix, meaning that QEMU
may be causing MAC address conflicts.

Cc: qemu-stable@nongnu.org
Fixes: 6c9f886ceae5b ("Add CDC-Ethernet usb NIC (original patch from Thomas Sailer)"
Signed-off-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[PMM: beef up commit message based on mailing list discussion]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/dev-network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 81cc09dcac9..1df24541814 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
-             0x40,
+             s->conf.macaddr.a[0],
              s->conf.macaddr.a[1],
              s->conf.macaddr.a[2],
              s->conf.macaddr.a[3],
-- 
2.43.0


