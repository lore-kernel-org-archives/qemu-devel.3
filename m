Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84774C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 20:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUBfy-0000ZZ-3J; Sun, 28 Jan 2024 15:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rUBfv-0000Z6-DW
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 15:22:43 -0500
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rUBfp-0002q2-Sz
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 15:22:41 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 81F9582C74
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 20:22:32 +0000 (UTC)
Received: from outbound2p.ore.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0B7FB82BBB
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 20:22:32 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1706473352; a=rsa-sha256;
 cv=pass;
 b=CpAQ6jvZZgG36GScZ2PZVdSHxr9pRrBgICrnhVHhV3bAkbdDmVOKkn1smO6ci3fnCPca45
 Bx7Pxz9UdeSkrJNQg0GCkO9unooGKsY3gs0dH1L+yUNHVeY1/+F0CWXziyRrHW+z6RNKi8
 vYB4FSsu71eabcUh0bor2GDn51bXe+GJG4Ywcrk4NJPd5FWqyKHd1CHlsKQm8blO+rNkya
 P1Bq0riyTmwto2TMUGRbZVEULhCg3W0AVHmDfQxGnUTjiLE3WXje4Hh3R4y3KsmHmmaen8
 xfEdcs4lOCuuXUc+x6lUbbBTjHqexHt7cRnDfTlshVCvu8vs+npykI/94aSGig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1706473352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=nAuJFJmn32y/UccFegOGs/3kCR0xDJhM7Lw0oC3fG8E=;
 b=r89EtbWA3NdxPpQ+iU6KiH2CWS4IV1MDv3/WU3ussUcpNsBc+3bF1YWdhc1JXrkqcPINZM
 htCa3n7tkGlgx8HXW/XJjMn2AHvcYSpgKk5yj1Sq0vVr6gNn8FBjP0WEoay2SiB0r3zJyx
 jO51EphW88pwMlIjkEKaLQe3K9gRgUwPfImVgfVhzewOK3vQgaUpLyI2mzZMsr7dojE51Z
 smZZ0LMv9EqCqdEEyyPuvYlrjqDSKxq37JPXipw2fZPZhqYo8P9CiINOnoGv8nhb9DFiSK
 p+DF4+UY3mL1+4kSwNqa95WztK1pITqHaWD468rdZpCok3xTl7omWUAGQ9eoLw==
ARC-Authentication-Results: i=2; rspamd-6fdd97fffb-j82sh;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Power-Chief: 04f9a33b02bee662_1706473352251_4254461769
X-MC-Loop-Signature: 1706473352251:2542914610
X-MC-Ingress-Time: 1706473352251
Received: from outbound2p.ore.mailhop.org (outbound2p.ore.mailhop.org
 [54.187.218.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.100.214.21 (trex/6.9.2); Sun, 28 Jan 2024 20:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1706473352; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=KFBVKGXgYBQQV1x9wU2RtPRTWDmimLPAZn9g520oTMfU9ndF4M1VEzaxFajrcUr8NVtWD0VOcQxtw
 mh+/W3JT+G0OZyke64E+FgbaDOFDecM4E9mNjmiWkKHdNoJF1p0+rPCopsPpjq8qp+bmnMeInI48ur
 7Dt4RwkJsPBNnsynCAq6s89i0vDjMEod7EbsD7aZfH/ylb3+YPNqCrZXAQ7SQ4Q/nQ1d6st787Cp7o
 k++bYLUeBQAIlUWCsPpo6vqp4v+4Tol0Nz+Sy1LzH2LSsBKp3AEdXU47FN/dJGKMX7PZB3y+RsNdFR
 I3sbx9WJygNj7j2emkDE+x9z2BQXmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=nAuJFJmn32y/UccFegOGs/3kCR0xDJhM7Lw0oC3fG8E=;
 b=c6iLd2dnNutatJzbAmj1H8MM94sWR2SLa//CVcceQXBvT25ePAXb5MumzG73Nz6JTGiU7M8DD2/eF
 S3sF0F2lqjABT94o4BbuhpmCvqGDbCiZXjgJewzXfK05SjT8h4j0PDJg7Cvk7OYIlRHIBn8xkOcv3J
 Vhh9HkHMrlbryIt9M11oJOPmas+Hh1k1/Xbnwv2e12tySrw4ofyJbYZTM8pW8HdgE7p5m8edipJ80G
 SvKlThyJneBXuYWICxfNjMrwKsK+ihhcWoFK/EoMIR+eBQdXn5VU8Qk9KqN0n2PMlDkdZ/YmptLY2y
 WheJCl2dcOBPPtxIiSrZaIyPoCt5kJg==
ARC-Authentication-Results: i=1; outbound4.ore.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=ZnEZRZV5; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=nAuJFJmn32y/UccFegOGs/3kCR0xDJhM7Lw0oC3fG8E=;
 b=UwAB0AtvhS35NBTgAEM5N8j/djfZKYci0/rh3OxGF0rGToVQb6vSPD6EB56ecyu8EsTh10aLsWory
 jNLG+HveLZucErRmx9lVQQ8QsDg8L2ha/8CA/8RpigsdEyb4JtPcZSAATlOfMiLVPyQNdbWijyfYQn
 M5rQHTH1oZ3QEpJ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=nAuJFJmn32y/UccFegOGs/3kCR0xDJhM7Lw0oC3fG8E=;
 b=UmWhyffDIjkC1QIq0T5bJ+9tZoBNqzZSP30zrAhENLDYF/wOSdNzqbXLvWCfXkemlHSN95NelHRdp
 BfvBCs5A7VEErrAw6ulnBAjDxOC98h042j8h2KIhlI1BLODRuQqP3PvfBEzJwo9/7m8gp83dq9csSZ
 hQRQAIpAGpxUm1z4sGCjedO9jcnZfaMcSlQqTR3DIDQcT+ulwZIjEId1LC8pDNZhyoBhzIXXBHwWyH
 g27yjiXRBl5Vg5KpxOEAevU6ue37se5x9pwSIIJXNchAKjthTnQ4Wg5dF8CjJcyarYkRFlvjJRVufC
 T4PoaIF3A3el2EVIPwTkwAVUmS1WYsQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f4b1d8ea-be1a-11ee-803a-2b2b5a144ce7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound4.ore.mailhop.org (Halon) with ESMTPSA
 id f4b1d8ea-be1a-11ee-803a-2b2b5a144ce7;
 Sun, 28 Jan 2024 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nAuJFJmn32y/UccFegOGs/3kCR0xDJhM7Lw0oC3fG8E=; b=ZnEZRZV5P9Vl5a4W+3sKiYcgjz
 Lpw/6V55hnsNeTzRlxM//q2oINbYDCW9AK1zLP5vS5+OML3FwmayIrBxT+pOOfXBvhT8HBJDAuvVN
 IzkoPYaWJi67VNYO+tsL1nqzj/Qh2+BruoguczYBryOAt2qmbCi/vi0q9IN2mG8Ep4dQ9biNnj0XC
 VXKSWA0PSTjJOV6PhZa/wWuSdwYillIhTo+lpnQGpMGcuxF4SbmYtCw7m96utR/GCyqYfHDrp+Lu9
 FjtoZ3+9KOMYkkImvtSLtbFmBZW8kwtCTox6K2nuWof4TbWbYufjbFFys4MqG/u6FBs2JOZsZOL1b
 ZqSyOMBg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rUBff-000XL5-1K;
 Sun, 28 Jan 2024 21:22:27 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Thomas Huth <thuth@redhat.com>,
	Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org,
	deller@gmx.de
Subject: [PATCH] hw/scsi/lsi53c895a: add missing decrement of reentrancy
 counter
Date: Sun, 28 Jan 2024 21:22:14 +0100
Message-ID: <20240128202214.2644768-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When the maximum count of SCRIPTS instructions is reached, the code
stops execution and returns, but fails to decrement the reentrancy
counter. This effectively renders the SCSI controller unusable
because on next entry the reentrancy counter is still above the limit.

This bug was seen on HP-UX 10.20 which seems to trigger SCRIPTS
loops.

Fixes: b987718bbb ("hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI controller (CVE-2023-0330)")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 34e3b89287..d607a5f9fb 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1159,6 +1159,7 @@ again:
         lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
         lsi_disconnect(s);
         trace_lsi_execute_script_stop();
+        reentrancy_level--;
         return;
     }
     insn = read_dword(s, s->dsp);
-- 
2.43.0


