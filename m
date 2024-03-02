Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BFDC5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgTAN-0008DZ-Mg; Sat, 02 Mar 2024 12:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgTAG-0008CZ-RR
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 12:28:49 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgTAD-0001do-22
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 12:28:46 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 3D650540E25
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 17:28:40 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9FA74540C76
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 17:28:39 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709400519; a=rsa-sha256;
 cv=pass;
 b=gyPK+SQocfgLlYATNxHUx7iSFBAP2ZN5wCR6yVY4fBBzSHgZjA24N4rXCKT+zbIdcIygJC
 23W8nC17vTCRHcSmAgIu26UmtGoiyl783MneV4FfRJY1kLIBnGbptN6IobMsVYVLTO1cop
 0pFHHKkc9W/gTMLxQZ7LyjNWe9g7d1Qj0aM6m9FmnvQmN5wmfyj1cfVkI9bI8uvMQUoqhs
 4JiUOsztQO/nqR3oH1eduHX/z3M4a0pjncZnGTYKj9IWuRHrINRvGP7ZPnRFwc2DILqrUF
 QIVD7XjHmjFbmxukjZgDqgN5/nhh8NTYqhFcTyoIESloSTR8R8R1cLvgDFi2YA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709400519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=Kim9fJeSm8GpCuv4S2WNTYCyrGBGYdn8tGGSaei/t4s=;
 b=cC0Kbq1HaXEmZz65muaUrP2ideUDtedMxUVEmT26B5MAR3I/mOk+R9bVBlsFJVoqvf1N7l
 xOPKeGlczTNP04+pddKLJnBJp1cnSAkj6ZXV5InnK8d/AvQ/3x1KHkokIVeUkgCUkEVRHl
 UaecRllzIfdkqEaQsHZ6BOJVjvL2c9kVU4ZWSCyD86YQ8sHA7qeg5hUGGxoEZVlbmYFi0h
 lCrpnLVv7O7oA/jpPn9b1WiOmHKv39qmVxrDimxKZndDoAm8uG0GeWhJ8T4kb5PoG/wh6p
 3Ov3jbaqzyMbvPSL71/7R/CL1k2/xhjQQs+oVFIn7f9Zoc4JRrFr2SKAmdG69w==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-xnzjk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Hook-Suffer: 5ad84d4f19ed430c_1709400520137_283122817
X-MC-Loop-Signature: 1709400520137:2326666491
X-MC-Ingress-Time: 1709400520137
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.58 (trex/6.9.2); Sat, 02 Mar 2024 17:28:40 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709400433; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=tt2PYj0fh9C299TFW1wF3qLSZMB9UKb7TlYplWGPU7ccIOKNk5qTDTBxvVih4U8lN2YESgx6Lvn31
 5bOv6qRORgQk+wTgnCmUP0HvOF8xNF8GAL+Hfnz0T1/GLF7tWboOLS04EH9z0CA25vtnOyKKbvyKBz
 ADdMMHkJLODktvPyrqj3xqHPQ5aE7EbXdbY8AvOAqqB++Y77NvvHnJocUjWCraa8R7wL730yRJpmss
 M0QtYfYUF0Vbc422MyrlXjvSQAcIlgPkbV5J61T9KwuxM3QvJoiS203NWyVW8Vuv9ev5tzLA6KtkqV
 IHjuYVZb1R3Eu5fRJXjhWnrZj7WawaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=Kim9fJeSm8GpCuv4S2WNTYCyrGBGYdn8tGGSaei/t4s=;
 b=fm7/QD2+PIUZM+RLv3l3z/W068+PCKkeAn19lUw4c7oMKo5m6TAfeGMbC+xX/VhIbbr6LB5LY5a0J
 WCcYy5lkcpUHEp07jbXR+sxJ7sTUzZCgnEkObL7yFfxJEhMIMSxvFBdHsWPrnVMUmGCDWneVfWv14/
 JtWEZz89LyiCcHz5xe9aCoSkAKmU4KouklGD6HmOLORmpGPy5S87pVbkZbtbR6Tal1IXljC2YO7u+w
 3osbwha2dpgX41Cfkr/Sum+kYFnLAxatyKJdS9yAh8bbnCplUkK5o+DyRS5NEX4bEnjVQqnSF9o3Z7
 KhTK5+uWKr/DE91Dimyz3I37206v/5g==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=IObTByc8; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=Kim9fJeSm8GpCuv4S2WNTYCyrGBGYdn8tGGSaei/t4s=;
 b=QpoUHxNf2/P1as+0v5GxdpVSTtUubWPDrjMCI7lOfVFJQx7iGHTykcCsi2+1KkQknjVNXJYM9sp+V
 dRXQMAXVuA6Tn/rGrDNRjgiI8P3PG0WIJfVAOo6L9z1Tsk4XEmdgZucYHBC5zqLr9f/eTGcU0s6Oxf
 w6mTbUGaRvRQMGVY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=Kim9fJeSm8GpCuv4S2WNTYCyrGBGYdn8tGGSaei/t4s=;
 b=iwHuEjAtJWx4d4ZD6Ji8vDuyL0QUlV1k2RKMgeVYGrw6sV9BOPPIPGwpNzUtybu6HCRqRjfplXnmp
 xgi9LwPqrdTz40O2MDm7/2CudUqb/DxxYaZ1IYc3fWmMkzgtVeEOd+ni42WM2i0p1N9wjo+qdUwa2A
 H6tI1cvRGJqIRMN+lPnzCZlNfOKbYcW6yyp6oltHud3dJJiMzr6DcTnQfoQzSA4uxQYaSJGIGe9ZIX
 jE47iUyunbbCpMALkRoTeF80+AgTo4evw+qYhjxw08k5eL0t9/AtcmOH4uwfCumpil/TvIUktzI3BI
 DVxzx+WnsDQ696sspKv1yo141x0EwbQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 1982b304-d8ba-11ee-afef-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 1982b304-d8ba-11ee-afef-eda7e384987e;
 Sat, 02 Mar 2024 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kim9fJeSm8GpCuv4S2WNTYCyrGBGYdn8tGGSaei/t4s=; b=IObTByc8mlLVrOgZKbuzAxDvm4
 Yg2+xAKIQtFuxbFWs0iz9xSYHDVxb9yrJWMZUNS0OiCGdiaQj9a5RdCAWVz67zkgrXuPoPfB+vSBf
 SRab+bKA8gLK9r+JGTRTuhPlEce8tYmVFBFzB1FZC9OuvzeKd8IOXzCm7PdFH2LDhcb3cvi4pMtfs
 4JZw/BEppHJ75W7rdXGlmWouu8hOW0QxYdjRk+otkRPSNnThFnTSztFnfe/bYuT8FC1SpUbXc9A1W
 lEkVWV/GkadDXbSKNlHgxf9Tv2Pa4MFTlCGhP6BJU29ZbOcHpUdryv8hGkStZUhiuusLu7XW/GyW5
 TaKy1+4g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rgT94-000ljk-1u;
 Sat, 02 Mar 2024 18:27:34 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de,
	qemu-devel@nongnu.org
Subject: [PATCH RFC] hppa: assemble_16() in wide mode 
Date: Sat,  2 Mar 2024 18:21:54 +0100
Message-ID: <20240302172727.2035011-1-svens@stackframe.org>
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

Hi Richard,

while looking into a HPPA tcg issue i noticed that the current
tcg code doesn't do the special wide mode handling described in the
Parisc 2.0 specification, Chapter E -> assemble_16(). In wide mode,
assemble_16() adds two more bits to the immediate value/displacement
of certain instruction like ldo(ldi), st[bhwd] and ld[bhwd] and some
others.

I wonder what the easiest way to implement this is - it has to be xor'd
and is dependend on the W bit, so i don't think it will be possible to
implement this with changing only insn.decode. I came up with the
attached patch, do you think there's a better way?

Thanks!
Sven


