Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041C1C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi0r-0002Wk-6j; Thu, 29 Feb 2024 10:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0o-0002WP-45
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:54 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfi0h-0007yS-Gm
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:07:53 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B1291C1920
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:43 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B7DE3C3CAF
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 15:07:41 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709219262; a=rsa-sha256;
 cv=pass;
 b=Je5QcYdgnd05+IZl4UYU10G40CW0uRdKWAysmkllu81oBDkC2xdczH/CBxjGMEERNif+DV
 A/WwTiIZZxOgNXQEK+FLmIyA+P+TnFl5NMmmrSvUBpmqpUb35E4t9QpCzji0QhmBJUE1+M
 TVUt4hq6IEL8SE3aisXuD7WBwaMGg0Ws17aJVFa1c8YUQiaeBaw8rmpM4ZGD3WfoWGRrxh
 Rmw/Xn5SXtaKx5xDehr8Z+/nJewYEimLJxwkGkf2EKYoboCKSVuicOmDbH344LSrZYeKtk
 BZGpQm5AtCsmExv1Jkwz89416Cpabv+anB3SQKysPW6reDvKR6/712B9HgSSPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709219262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=MmJ00cBGvci+jagYZaA6NqQRxiuTjsx3F7N2VH3Ft2w=;
 b=gFiYbmhgFozvMlGJcIEFKD3DxLNjGg71uaT3ySuAt5g5og1vmkxU2lirjt33k75vaUdLEL
 mW8uxoS1zCyuWLcexsXQoTaizNSDsJrkIfAcUXIr+orddCXDc44pWfEDZkP3A5XgpwhAwZ
 exMlMtdilMnUkLdlcZY7b1PwB2HOUh2EESsePb64RBLhdZXcrgVN6k6DofFac3yq1ZFi5n
 dlNP+6aNoZiXxVG8DT3fBK7uh6e/1wSptDPuSEvj+N/3PMTuyZ6KiAGSjGOUg9xtHuHzyr
 Srhe7eS5HJ3rF6iS+XFegwy6SZ27BJ2hcfjt3/38w9d9IU9WKI7yybabNPoxVQ==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-smqdl;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Trail-Abortive: 71bbd46852d8c217_1709219262252_1164595035
X-MC-Loop-Signature: 1709219262252:3185566249
X-MC-Ingress-Time: 1709219262252
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.40.12 (trex/6.9.2); Thu, 29 Feb 2024 15:07:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709219236; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=s7trkyr0paWomTWX74frC0suBXcBmgGn9GH1KVYiDNHD2YHxT9DoS9mlCtZBSV+zH7v5vIXS7hi8e
 tyIDWSCyYweESmGzgHCpwlShz7rvjq0onLMIgEU/IywbJP38OwkeHHSvAsBmUkGqoGiso7eRSI9gfA
 aRGG94banPYiDWkZ01ka7n95gGedlNXZW2qTAUdobaTUPVrPfRSACadCCXVRgbnl/IR0BAHkxuACIF
 OgLGIo1vfrwiRBr1K/xgrXGWtQBFGyN+gkYk7YzgDU7eFHSdp9Xq3MQIeVkG598I7wvGUSBNH79ymb
 8gFjRiu4V/01mYAWlJIr/ctbfiNH9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=MmJ00cBGvci+jagYZaA6NqQRxiuTjsx3F7N2VH3Ft2w=;
 b=NfOuRexFEZ4lHlts7GRmVZw4pSrrfU3OA4nrSCdDqQjZQS688kmDqSxbOmcw4qwUXxBAxRp8QYzGI
 ThJCgKybr/W3NHawr9apRinP8Pp26wpwm2Eu3BwX74kxViajgFoOGGeB2qiBe/Uhje8tc+fVBCuIV0
 SgKS0cKxC8WdJ+ZpSPE+AVk70URhbLvm3XpDIKiwJN357rprhC0fdo927nqcccWTTfYRrMsQL8pe4h
 iGZLK/u/OjAGuhteS0XpLKTwzoxhHN2rCbym6VX0BH60g1jv3+5eWo5D4RYx6RFHtmQlxjB/DU8duw
 F5i15EhW6Uy4F/CXCvpqlIgDiScH/KQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Ebm452D9; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=MmJ00cBGvci+jagYZaA6NqQRxiuTjsx3F7N2VH3Ft2w=;
 b=mMd92tchUqbA/n36kWyKIfGbMTQ2NxZqmiefoZBoV4UeHZhv4d+T2Uc4pkYgNKfVQTtAUSIJhLSx5
 oeBKa/37Ht37t+B8iAU620Mu/1FCGV891g+4JuH3QCrnBLCA3Q7n+Kg6nz0UzJKGzeqZWUPZ3oe64t
 qZDc2fm5j9xT1nb8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=MmJ00cBGvci+jagYZaA6NqQRxiuTjsx3F7N2VH3Ft2w=;
 b=RmzdqV0ubc53jPcnxT+E7oFzS4pLle373SMWTTllOnt3AigeoV9ollXqcUK1ArE0CyUmku5F2csQR
 2w24StRportCJpH9vnWzbzkCq0I7LBGRbi6slAIihWtLiYh+mxBnGiWcAWla6URZVfp7/ClP5uGrXG
 tvPnE3txVOVcB8c2SGcUNuHNDaUeJh4xwnT24RoAx5KgnOsDhjVHynHiaoRzAEWQJ7rsO1k7DzRz+I
 u6wPvABtMuQrtjv/dvah/3G5TK5dYM1Qn6EezHhPicaw9fvms4oyL+zW/xPlMHJjpc9Um7HDJ2CIN3
 pJjYExKWKEXbhicmSCImS+H5e2Ue1/g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 3673c5e1-d714-11ee-afb9-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 3673c5e1-d714-11ee-afb9-eda7e384987e;
 Thu, 29 Feb 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MmJ00cBGvci+jagYZaA6NqQRxiuTjsx3F7N2VH3Ft2w=; b=Ebm452D9Xm4wt9Y1kUVBPaKBzc
 3IYBRFOxXCOaesoHdaQXeuO5fM69CCAGUEEX109EwA617yF+bNCpaJ0o12ez7ZYWk/Ra0OkCA9GC7
 lpEgXhYEwye2sWFxWTCRhgJ8/0xiaKk+YY73OwsNPmqFNoiS6pJaMLoU6mIHiBYkAHc9HRumPd72T
 QPauIvx/N9UogKHKV1/kikHeN1gStnUVC5vwRilV1iUkqgTMCG4zoMNqajDuR2LstRpvc6nChUiRl
 6kH8v/L/WGsRu8ax1P3OaB9koALOgLJiV78q5A6AshuN1u12qWH77JpKoVM4wPwgbM3niQeTTSgZC
 sqUc89GQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfi0U-000Lha-1F;
 Thu, 29 Feb 2024 16:07:34 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/3] plugins/execlog: add data address match and address range
 support
Date: Thu, 29 Feb 2024 16:07:26 +0100
Message-ID: <20240229150729.1620410-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi List,

this patchset adds a new -dfilter option and address range matching. With this
execlog can match only a certain range of address for both instruction and
data adresses.

Example usage:

qemu-system-xxx <other options> -d plugin -plugin libexeclog.so,afilter=0x1000-0x2000,dfilter=0x388

This would only log instruction in the address range 0x1000 to 0x2000
and accessing data at address 0x388.

Changes in v2:
- rebased on top of latest master

Sven Schnelle (3):
  plugins/execlog: pass matches array to parse_vaddr_match
  plugins/execlog: add data address match
  plugins/execlog: add address range matching

 contrib/plugins/execlog.c | 95 ++++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 16 deletions(-)

-- 
2.43.2


