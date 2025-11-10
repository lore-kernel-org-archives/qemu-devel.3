Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D050FCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 22:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIaLo-00047Y-RV; Mon, 10 Nov 2025 17:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vIaLn-00044T-Us
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:27:03 -0500
Received: from outbound5d.eu.mailhop.org ([3.121.156.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vIaLm-00009L-23
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=Kc8SY4c0K9JEbVfZ3F+mwfEAOOStnHKhZ3RmAc+4dsI=;
 b=Jc3T+/FkYylfs1k+Gssj8kd7t2wlMvrNZ/aRxqsqcpPesYiK66uMIwrK+L4m1pgP9xQj0lC0kUcC6
 WB736XMJYRHi+GjP3gLVBqqTbhdgKargF3YLkNizu00p1TRdEedxuDhM3NJIRRP+buoGUem7dvTtP1
 yo4Y6xIHtaP6oclE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=Kc8SY4c0K9JEbVfZ3F+mwfEAOOStnHKhZ3RmAc+4dsI=;
 b=RXfTPpcY/fTN8eZ5WDNpXF0c6t5MCc+cMDx9ArMGitMJKtleF8d5JQ+VDdeC5takvvzEwMaST5SJc
 ktsXY7nPKVTho7seB/GUWFSRv9mNmSZ23umHJraJTQhaELfEy7ee15c52Fd0fhePMbNPhVPk6dDqBR
 D5IbyAeqLPsiM6/n/VG1+vXYWhceCWm7xUclF4UYYnEWWNIZ3EwczQL7PtWkUaGZLitvWvD4/pOQEA
 ilwasabUjU+0y7zKwNN5NEd8cMLL1qwU82B5KeKwo9X4jdoh/tQzGZMhFbMfUAJ4Nn+xUTFv2LSQfW
 Eg2te41UDNWABcJmXBFgh9Y5LJgTHpw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 5b4acac7-be84-11f0-b95e-5f56af36decb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 5b4acac7-be84-11f0-b95e-5f56af36decb:5
CFBL-Address: prvs=040923d279=abuse@outbound.mailhop.org; report=arf
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 5b4acac7-be84-11f0-b95e-5f56af36decb;
 Mon, 10 Nov 2025 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kc8SY4c0K9JEbVfZ3F+mwfEAOOStnHKhZ3RmAc+4dsI=; b=l76lOjMs+gAmCPeYd9j6PsUnM/
 FJpRwUb/7ylm4GwZXZg+sbHtiu74L6bBHLGVJBdlV5KdDyMJmtagDb5E1OZdgDiZOyYXtjjzBIaiD
 t0UH3L+9ylkyys62NXBKMpZGCHDlrWOaK5gPae0GPglLa+xxtl1Mui4GSRqR5zPZbMAx/kgr54/nH
 zVcD2GdTU69/b3gR9XLGVJIrRVOEAOXzMxKcverIl0mm8f5JlZe1sEqLrjiy64Je5SntI5/SRtEDU
 NP9pRS+aKD9vnQtChikKU3359f3mPqWOtXFjWrDIb8sMvziucYacQ1S5t4bOsXd/Qps5N476qNeRm
 L05+/A+Q==;
Received: from [134.3.93.166] (helo=debian.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1vIaLc-00000005qEU-11sK;
 Mon, 10 Nov 2025 23:26:52 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/1] 64 Bit support for hppa gdbstub
Date: Mon, 10 Nov 2025 23:26:44 +0100
Message-ID: <20251110222646.180265-1-svens@stackframe.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=3.121.156.226; envelope-from=svens@stackframe.org;
 helo=outbound5d.eu.mailhop.org
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

Sven Schnelle (1):
  target/hppa: add 64 bit support to gdbstub

 target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 21 deletions(-)

-- 
2.51.0


