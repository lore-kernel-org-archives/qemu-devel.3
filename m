Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1739CCD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPH5-0000Fo-D9; Wed, 12 Nov 2025 23:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vJPGe-0007zI-Uq
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 23:49:12 -0500
Received: from outbound5h.eu.mailhop.org ([18.156.94.234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vJPGc-0000Qo-3d
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 23:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=xFJZm9cPE++CbelL9UTdzymV1qzYd2iOBg5UztpHlUE=;
 b=HmKKLXltbMFG24GO3MstclkdpGfJYAdHB4SnVa5v4uiVMRMOuC+7Rt3qZ38bIxqrpCIYJPeUOfljs
 xI+Fzf26F9jETTgViniGzRvATUXPWaKb2LvgrAmI+6JqL5PnpZvsbfpaJC+PEHCE+yytxmSlvLAM1p
 RXY0Mtgs04Addrm4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=xFJZm9cPE++CbelL9UTdzymV1qzYd2iOBg5UztpHlUE=;
 b=CRu1KFFojdyFgyPbMqMu6aihl5t8qwEgMu4cOaQUPjY53mFbZcWzi0SyfFi2uSZn6Mb589tRmH+ob
 vYonW3zbsZHiNI+lWNltDDJbcjHUlMbfPBm3BK1w5f0ajEoRS23UIdKG1CxornBtLkuc0cF95Lir2D
 4F225IkOOhYa5ITMxFMso1DZBEoLeytmCzTaBkR72p8NNvEKmqgrxAg1irzT4Avp4GLQMZFmDFQE3m
 VkG0FY1cnqaUV+7Jq2jHsp8UMsu4LG5TRYGSyASF0sRn4w/OjZL/k6TpzF06F0ETGl1o5uucoJzVGb
 iS45fqSaacCJm2txWGgNsX6kYmijUFA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 11a19078-c04c-11f0-a07e-310e225498a9
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 11a19078-c04c-11f0-a07e-310e225498a9:5
CFBL-Address: prvs=04127d9ad8=abuse@outbound.mailhop.org; report=arf
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 11a19078-c04c-11f0-a07e-310e225498a9;
 Thu, 13 Nov 2025 04:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFJZm9cPE++CbelL9UTdzymV1qzYd2iOBg5UztpHlUE=; b=OvAP24D4iFOySM/Wkh1CcojNXT
 wPYOIcjChyB/cAkqm+RwQZwmK7q/mV/QKW6nympRSo9A6qt/NyWVqKgF8lupzZAUmfBypcxBcQAEb
 uFpEUEUa291NQE+6tzP1PUraZUX7iUErw61eFO8oH5Uebrct9NRndrTm1DpsybVdRh/YVndOutXML
 h74ztVVLal2optRWo11/s4+3TNEbrQw5zfWvsusDfisw3v/v+kPJ9GUyT3PLnioainMuF+Fe3jQmP
 exIo9Qun+OX3LvaW55UQyCqsaSu9L/HowuKFN9W6baMyreWbMX9BS6JliEn1295qt685i7qgdG0n4
 6Gmzx7+g==;
Received: from [134.3.93.166] (helo=debian.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1vJPGV-00000006YAi-0Z9i;
 Thu, 13 Nov 2025 05:48:59 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 0/1] 64 Bit support for hppa gdbstub
Date: Thu, 13 Nov 2025 05:48:56 +0100
Message-ID: <20251113044857.67290-1-svens@stackframe.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=18.156.94.234; envelope-from=svens@stackframe.org;
 helo=outbound5h.eu.mailhop.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a rebased version of the patch(es) sent last year. In the meantime
the gdb detection patch mentioned in [1] was merged, so it should be safe to
merge this Patch now.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-02/msg06652.html

Changes in v2:
- use ldn_p() to avoid if/else

Sven Schnelle (1):
  target/hppa: add 64 bit support to gdbstub

 target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 21 deletions(-)

-- 
2.51.0


