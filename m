Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C99EC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsfx-0003Co-CH; Sat, 24 Feb 2024 09:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rdsfm-00039C-SQ; Sat, 24 Feb 2024 09:06:40 -0500
Received: from hamster.birch.relay.mailchannels.net ([23.83.209.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rdsfj-0004Kf-Cb; Sat, 24 Feb 2024 09:06:38 -0500
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A194E802DA4;
 Sat, 24 Feb 2024 14:06:31 +0000 (UTC)
Received: from mailclean11.thundermail.uk (unknown [127.0.0.6])
 (Authenticated sender: thundermail)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1E3868033A5;
 Sat, 24 Feb 2024 14:06:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708783590; a=rsa-sha256;
 cv=none;
 b=uT08J277UT8z+8EHQxgeQ/PJYYza7L8zLa1+fP7hF4lzPIOZOUvFJZvdohurG3swmfT167
 rEAZ+qgcrhRo9APVMi/fjwvALURHQzmCa7FkEMC0q0WivhvicYEE/t+/DJBEUiQ14/FRGe
 BW9We6ax7vYOdBympa0ozH3YnGfuF1Dm8DtVOCs8MrhQcVLqdWKGh1sBI9qMgaKStzjfNL
 9KCb7Es0Ui6zxlVGGRKhmQk/v9b0bGztKUjbSr+JW2IBOx/k4NEwLYdPa6Z3b0gL3249+h
 9chTx1ADuv1cqj2i/ggiqg+wRC2VfWzALiMjdfGrcMJznfWRV7hIhUVFhDLx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1708783590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=Z9X1HZr3mu0mTTUfwzTQhmsSc2asmpSe1PaQrzRDq60=;
 b=pZAAIkM+6hrpPorE4eE+rMXJ9JP5y6kaqH6E82ZoAf3v57JREmrFzIo1zXWjUmMkpefllm
 2WMqQZDuhkdP90LTfw52v66xkapWcr3skvHI4XRjHAiZPQSpzgIv5hWkqU9ynZ8uaMtUZl
 jPuZb6AMfUaMsYfX5QNjjloyEf2bcBYU1xKxydi1BAUk7pQ5VG2X8SVj3OcONlCFKarhM3
 zGlxPE1Ik79nztv5fTdKGn7n728N8kWaXTcJSEEGenFT1oXR66IUxIgLpDmEfpnL9C7vxu
 f0TTrc7cMvR7AHIV8Shu1qho7yO3FJGhjecFxcYRi92ZjESpZh6ZFvvT9Y078A==
ARC-Authentication-Results: i=1; rspamd-55b4bfd7cb-pb77f;
 auth=pass smtp.auth=thundermail smtp.mailfrom=dave@daveparsons.net
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: thundermail|x-authsender|dave@daveparsons.net
X-MailChannels-Auth-Id: thundermail
X-Drop-Army: 459133923eb00e63_1708783590758_2107120092
X-MC-Loop-Signature: 1708783590758:696577549
X-MC-Ingress-Time: 1708783590758
Received: from mailclean11.thundermail.uk (mailclean11.thundermail.uk
 [149.255.60.66]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.245 (trex/6.9.2); Sat, 24 Feb 2024 14:06:30 +0000
Received: from cloud227.thundercloud.uk (cloud227.thundercloud.uk
 [149.255.62.108])
 by mailclean11.thundermail.uk (Postfix) with ESMTPS id B82DE402E9;
 Sat, 24 Feb 2024 14:06:23 +0000 (GMT)
Received: from localhost.localdomain
 (host109-149-93-149.range109-149.btcentralplus.com [109.149.93.149])
 (Authenticated sender: dave@daveparsons.net)
 by cloud227.thundercloud.uk (Postfix) with ESMTPSA id 4B52F104073;
 Sat, 24 Feb 2024 14:07:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daveparsons.net;
 s=default; t=1708783632;
 bh=Z9X1HZr3mu0mTTUfwzTQhmsSc2asmpSe1PaQrzRDq60=; h=From:To:Subject;
 b=TrE1bDrEANirvipotOnFB13aBTbwQAkhf5lOkLLlCflbY3Vl1s3EWd7o9i+sdp2I4
 t/Ql8JqiSEHQNt9ycCmDAXDPl1b7VM2VA64ix3TJAB2fsCMzCACOsRoudst0jAsU6k
 FQBheqzRHxg5+96JEIPN2DEPN4IXmF8ywBfI9M8g=
Authentication-Results: cloud227.thundercloud.uk;
 spf=pass (sender IP is 109.149.93.149) smtp.mailfrom=dave@daveparsons.net
 smtp.helo=localhost.localdomain
Received-SPF: pass (cloud227.thundercloud.uk: connection is authenticated)
From: David Parsons <dave@daveparsons.net>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, akihiko.odaki@daynix.com, mjt@tls.msk.ru,
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 David Parsons <dave@daveparsons.net>
Subject: [PATCH v2] ui/cocoa: Fix window clipping on macOS 14
Date: Sat, 24 Feb 2024 14:06:20 +0000
Message-Id: <20240224140620.39200-1-dave@daveparsons.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <170878363277.3104394.709066910959988231@cloud227.thundercloud.uk>
X-PPP-Vhost: daveparsons.net
X-Rspamd-Server: mailclean11
X-Rspamd-Queue-Id: B82DE402E9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.49 / 999.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; ONCE_RECEIVED(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:34931, ipnet:149.255.60.0/22, country:GB];
 ARC_NA(0.00)[]; DMARC_NA(0.00)[daveparsons.net];
 RCPT_COUNT_SEVEN(0.00)[8]; NEURAL_SPAM(0.00)[0.956];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_TRACE(0.00)[daveparsons.net:+];
 R_SPF_SOFTFAIL(0.00)[~all];
 R_DKIM_ALLOW(0.00)[daveparsons.net:s=default];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=23.83.209.80; envelope-from=dave@daveparsons.net;
 helo=hamster.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

macOS Sonoma changes the NSView.clipsToBounds to false by default
where it was true in earlier version of macOS. This causes the window
contents to be occluded by the frame at the top of the window. This
fixes the issue by conditionally compiling the clipping on Sonoma to
true. NSView only exposes the clipToBounds in macOS 14 and so has
to be fixed via conditional compilation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
Signed-off-by: David Parsons <dave@daveparsons.net>
---
 ui/cocoa.m | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064bee..bbf9704b8c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -54,6 +54,10 @@
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
 
+#ifndef MAC_OS_VERSION_14_0
+#define MAC_OS_VERSION_14_0 140000
+#endif
+
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -365,6 +369,9 @@ - (id)initWithFrame:(NSRect)frameRect
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
         kbd = qkbd_state_init(dcl.con);
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
+        [self setClipsToBounds:YES];
+#endif
 
     }
     return self;
-- 
2.39.3 (Apple Git-145)


