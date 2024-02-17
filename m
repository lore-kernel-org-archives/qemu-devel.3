Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C40EC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 16:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbN7p-00016A-L8; Sat, 17 Feb 2024 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rbN57-0000W2-BD; Sat, 17 Feb 2024 10:58:25 -0500
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rbN55-00020F-KH; Sat, 17 Feb 2024 10:58:25 -0500
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6AA89902562;
 Sat, 17 Feb 2024 15:58:19 +0000 (UTC)
Received: from mailclean11.thundermail.uk (unknown [127.0.0.6])
 (Authenticated sender: thundermail)
 by relay.mailchannels.net (Postfix) with ESMTPA id E37AC902122;
 Sat, 17 Feb 2024 15:58:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708185498; a=rsa-sha256;
 cv=none;
 b=tLFvHDc0bBByh4l65cagDabkOG1/1ekdhsvuVZKKsDyx2j6XzUeAPuQeKFD7jm5NLsPcw+
 F0Rp2vx5Gy2YPpWBmbipqXWeGLokjfEcvTXM3SjoXrGitmrtdQIc1Yr7PgKcpQF5RBn7bo
 5oGhiVj0gyUqG5eyQ5zfbM31TSBx75LQjjcN2bXyUw3ZE2YjnzsKqAjqo907+xoir090hw
 ugLh6hPgbIfsGIXTX8RB9UDzHKx+gEuFdFJxbSlW7qF/XX8/zGY9B90S0Mv9b8oXiNVtkT
 o94mF5MXT2SebkWoGVZRNiz/AHMUkfUqRDAnjQTNRpd80Fagf3BilZcRm+VeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1708185498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=ibmswVGgLNO8hq7MqmREZ9UF84lwpqFS1JQSVs1K58g=;
 b=NxDD8CRVR9cMYHj9SWg/ntfqJIDnsG9fZF9CLyPH9aD9qGT1TaKXAvOXZvqhKoJYXi2wmV
 Fg+Fdl0BSeVRsnCDgc8dHus86SPejcFy9J/JHD9voRZymrYq8PR1oy0AJlAfNOzT2hL1WL
 VSfxoJFt2f5UEHXJIdJqwELPJ/ZLFnlk5i9XZn3888/Z/OekrkRVPNjrPW3XUwgvgG0zRO
 bNRWLUiIimKFo0veiL9NTKo9xsH2oL1Z5LzfUbzhAY8/4L9kXrtmcexvVk2e0/Ebu8zC+0
 6wZUvk0Tjq0eDDfclxuxcH6MIA2BF0mfr/dEhzTp1+Rd3Ie75tg4zFg2MNFasQ==
ARC-Authentication-Results: i=1; rspamd-6bdc45795d-lxxw5;
 auth=pass smtp.auth=thundermail smtp.mailfrom=dave@daveparsons.net
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: thundermail|x-authsender|dave@daveparsons.net
X-MailChannels-Auth-Id: thundermail
X-Wiry-Towering: 6e9dc7d3784a52eb_1708185498983_1488885165
X-MC-Loop-Signature: 1708185498983:2138584531
X-MC-Ingress-Time: 1708185498983
Received: from mailclean11.thundermail.uk (mailclean11.thundermail.uk
 [149.255.60.66]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.153.94 (trex/6.9.2); Sat, 17 Feb 2024 15:58:18 +0000
Received: from cloud227.thundercloud.uk (cloud227.thundercloud.uk
 [149.255.62.108])
 by mailclean11.thundermail.uk (Postfix) with ESMTPS id ED13D40260;
 Sat, 17 Feb 2024 15:58:12 +0000 (GMT)
Received: from smtpclient.apple
 (host109-149-93-149.range109-149.btcentralplus.com [109.149.93.149])
 (Authenticated sender: dave@daveparsons.net)
 by cloud227.thundercloud.uk (Postfix) with ESMTPSA id 8E0AF101FB4;
 Sat, 17 Feb 2024 15:58:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daveparsons.net;
 s=default; t=1708185527;
 bh=ibmswVGgLNO8hq7MqmREZ9UF84lwpqFS1JQSVs1K58g=; h=From:Subject:To;
 b=qws+EYCMF/y0kkGZM16lb8BlHoB1l5UOpgiTR4CfCNhHdY2OXZx/0ZhXXFoJj39dS
 UN0gHrVzpn++2IS89CThx4QocZHWdBeRPvO3SCWDKp6OtXOiSMymjrxMZA+MUhsYTM
 F77XnOuVNcFYKCuZHKRx5wPESxeGJP+H+lMi7Y4k=
Authentication-Results: cloud227.thundercloud.uk;
 spf=pass (sender IP is 109.149.93.149) smtp.mailfrom=dave@daveparsons.net
 smtp.helo=smtpclient.apple
Received-SPF: pass (cloud227.thundercloud.uk: connection is authenticated)
From: David Parsons <dave@daveparsons.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: [PATCH] ui/cocoa: Fix incorrect window clipping on macOS Sonoma
Message-Id: <DDADA9A9-DED4-4510-A532-7600C0233467@daveparsons.net>
Date: Sat, 17 Feb 2024 15:58:02 +0000
Cc: qemu-trivial@nongnu.org,
 peter.maydell@linaro.org,
 philmd@linaro.org
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3774.400.31)
X-PPP-Message-ID: <170818552782.773145.12447335006264330645@cloud227.thundercloud.uk>
X-PPP-Vhost: daveparsons.net
X-Rspamd-Queue-Id: ED13D40260
X-Rspamd-Server: mailclean11
X-Spamd-Result: default: False [-0.01 / 999.00]; ONCE_RECEIVED(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_TLS_ALL(0.00)[]; DMARC_NA(0.00)[daveparsons.net];
 APPLE_MAILER_COMMON(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:34931, ipnet:149.255.60.0/22, country:GB];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; NEURAL_HAM(-0.00)[-0.999];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 R_SPF_SOFTFAIL(0.00)[~all]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 R_DKIM_ALLOW(0.00)[daveparsons.net:s=default];
 DKIM_TRACE(0.00)[daveparsons.net:+]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=23.83.212.47; envelope-from=dave@daveparsons.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Feb 2024 11:01:04 -0500
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

macOS Sonoma changes the NSView.clipsToBounds to false by default where =
it was true in
earlier version of macOS. This causes the window contents to be obscured =
by the window
frame. This fixes the issue by conditionally setting the clipping on =
Sonoma to true.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
Signed-off-by: David Parsons <dave@daveparsons.net>

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064bee..c9e3b96004 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -365,6 +365,9 @@ - (id)initWithFrame:(NSRect)frameRect
         screen.width =3D frameRect.size.width;
         screen.height =3D frameRect.size.height;
         kbd =3D qkbd_state_init(dcl.con);
+        if (@available(macOS 14, *)) {
+            [self setClipsToBounds:YES];
+        }
=20
     }
     return self;


