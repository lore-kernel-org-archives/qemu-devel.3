Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576011077603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vrL-00046S-7q; Wed, 18 Mar 2026 14:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrJ-00045j-SL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:09 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrH-0001kF-8G
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:09 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 114CB6C1088;
 Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (100-119-11-147.trex-nlb.outbound.svc.cluster.local [100.119.11.147])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 804206C296C;
 Wed, 18 Mar 2026 18:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773859383;
 b=BFPb69LxxmUxIO7JXfRX8pnf3qUB3OAUoNu/+1WgK27O12TF5Ul+agwuXcxmYtOfIC+iFm
 i6LoRmneZl3SShVGyzirPSZlwUpb00YisY0OoF2P/Y3d9PE08TQKrtMlXeIhEwz1JFj1lI
 siRwpQAiQLzDNDWerm1uHY8sFWJT/ZDDPFmF6javLYToQamf9MR90dS+76PeHkXEqEOM29
 3WEugL0D0fR/3e++x9wywe5t0LCziKfhQnIAl96h2Gz0RQld5QskiHdEFGk187JeRmvxCr
 0TPcG8GCMgkLxOWYxYLZHp9JlbRIooKP9p33LDrdjWSoIiBpDRodHM7OnAyJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773859383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=l3hY2N7dSCkpPwJJBTMXp/fhaMGcTJQMcRH8IzI2ikI=;
 b=u6qlwUOj79Kb1G+akK2t2auIrOMrQSqRYzUDWFQivbRR0sdkIN/Ld+DhSjidKYaiNo40lg
 5F4kLm4OrMFoI4xKIDF0b681773XDI87pX+CDvs+xr7toNBVJCLptTTfNh2oiML7R5BoB+
 VFaufbFRm4YVaOdiw14lE6hS6z+K1i3CxujigSYligf5+2j3lToQ4dQIzMmH/lR0P25QuY
 cF8H0M3LhokNwhTdqPqKv6sr366svLm/BEddEc0Qb7d5ZAjKC+2GCP5s5Kza8PYnS/0ydl
 y3xLiI+kPW3yTdLugxiH7wO7HbMrEivnTAsSHyGBo5cBrAX9TlkFyo+fZV2ufA==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-pf456;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Plucky: 048eeb8f018453ba_1773859383816_2816671567
X-MC-Loop-Signature: 1773859383816:37079076
X-MC-Ingress-Time: 1773859383816
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.11.147 (trex/7.1.5); Wed, 18 Mar 2026 18:43:03 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbd4R0ZFnz1079;
 Wed, 18 Mar 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773859383;
 bh=l3hY2N7dSCkpPwJJBTMXp/fhaMGcTJQMcRH8IzI2ikI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=qn5y0uA/PwPOEFMcQif5gM1zi/7O3PrE1TwQIHfPACGOc6bPQ/gFhfoxiiXMJYXsL
 LIGzovLuBsTLhzU6iufaMQ4ULUuVrzTlYRTDa27TkD9F0mgLn9KRS1csdCXR8wwYLv
 D2lZ4WlonOio1TA+fMP5rYi9BkzDHBfL72+NqFz5/PgZWPjCja1gQdYGGpuSScBDNr
 KlVdARINAFS47A1WpojIL1vJNPF9j14qF6BkGWVKuAEWXeHqNjZpLLx6e+0G6N0Ll7
 gpByyou5MpfkDtp6FNqsEssg5H9VV580fNl/zqCC55smIF2pEid/0gPeuC4LcO+6BX
 f8PjESJkfpceg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH -qemu 0/2] hw/cxl: Media Operation Discovery fixles
Date: Wed, 18 Mar 2026 11:42:54 -0700
Message-Id: <20260318184256.3680349-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Hello,

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Applies against 'cxl-2026-01-09-draft'.

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.39.5


