Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53888C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQKL-0008HJ-Hm; Wed, 28 Feb 2024 15:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKJ-0008FG-Mn
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:14:51 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKG-00042Z-Jt
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:14:51 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 31C9C7A2E72
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:45 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 8068C7A2B63
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:44 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709151284; a=rsa-sha256;
 cv=pass;
 b=rryxHoLhjaODJg+zzxsCcF+8cnAu7WgvkuFnKSEgBSAZXLuxYM25YhidRB2N4aanfjG8w3
 oxPzpJvBjjdXqV3NziZfm37wZ0uwjOGISCylgTipbM3mdLnDQvWOdk7nTBd0Yo/n+1rGEp
 w32YrXavDRPcFUAOxV+Gm/LI3068D5KL9ENhfdAxsWu7G+JdKfbQOv3u0R/5ky5Ji826t4
 cyONdE4Lrq1yETFTYqii96SmAw08TBFNd/bR7D7sds2bT9DmcEe70EVBw9Gr1jMr+wglK0
 BvMyc5d2MrgGg/rUpvfcuBIvQIZQHWPrPia0bHGTIXMkrpLUqtex1Db602mNiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709151284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=6t9Gh83qSa5TezDyFMSHpS4CAtQHMiLefyxulOjpcHw=;
 b=W8boryd1YY/9k/k5eRs62bgPmVSZZ295O2mufYpsjY1XgF/I6LX6jxptadSata4PTWYe5j
 ok4xDXjTd97WWRAJOKulbd3vNKMkzTUUXAdB5mlp2Yxo8FFEXmfL2CI8hxZScKFB9jsCkL
 I6FPytcvZ7xtsNIG1IC6biN1hmcDTDbW92vWYqmhKLI8uN8kfOfylZA9i410fL9g7+y53n
 M3FgkkwATpaa8BtN2tUIcuJZK1soFzFbe3M48q1IngEfl6rniMRb/usfyxxOIbzt/PTMVH
 HK5lVc9ajVaQvmPfIN2zfIoXBduKFeyq4pJy6CZCD+87Mf/BIGwfkpZ3RRQtIw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-tpd2r;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Macabre-Skirt: 3e05eeca7d217945_1709151285016_1601699768
X-MC-Loop-Signature: 1709151285016:2146234804
X-MC-Ingress-Time: 1709151285015
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.114.53.127 (trex/6.9.2); Wed, 28 Feb 2024 20:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709151259; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=hFbzWf+eIwcWwXWVsQLM6h+3ut4YB3g4vv1f7AN9cvrSOnIB6Pp7vwnXMuVNgXOBhVHlUwy1ypMHy
 MEcUSjm5PPej+6eIyalU/OxkowS2Vm/vBCajLinyK3zrtMgubm0wkc+lJQDqd4Ibcldax9/64/ergH
 8oJ9ywiZaxsOKo8aSqlA0deVRG4IyHhFRHA27tu301cZmYvcjuR/k6fNBLrCzKVeYFmAucEjRhyLCb
 5ORpInmwIxfZKcKKVWsMSVpL2P6v7g7GYHxh+upeCCX43++gdleeF2XXGzcm6PfAm8D5wnGcBGMpXM
 kWg1UsaaZU1hohbySOTGWVpGb6Ge2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=6t9Gh83qSa5TezDyFMSHpS4CAtQHMiLefyxulOjpcHw=;
 b=dSmTRR9SfpsxHFqMid/GtgIeghJ/UhrzAEoU5pO4GO7XVzIvuNzVwxxOcqvqkZ2a+ap5Pzm0KG6PG
 IWqc89f77trIYNiH/NN5H4TwuBk6+kLWGPSxkaiIifmcpekIXpOq6gSfQdhrj9v+Bt2a/HqsWjL5cg
 u57EfH8xW/JrdiKL5My+bGmhuWShS0nDNtqkb+tstIaEKTUhMrQUN5bbwy/6d4mm78NgC9xX8EAZKQ
 I92JpFS4itX0RE4DX50PA35gZ1JGgjZ0g2cmC3xGtQa33Pg3fAMwYxA+OYYNOjZztZ4epUe6jXNASp
 TErBjUWC6+T5s68BOZeGBxP54PnEROw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=SAYUAhQp; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=6t9Gh83qSa5TezDyFMSHpS4CAtQHMiLefyxulOjpcHw=;
 b=ikrdiaFj6Q+0eJ45VaFCMkw6kfsiEIwQLRIo8t7YqBz8MFzMKWZVAIuVKLhnNZb7vbA1myDQQmJG6
 bOPZjWSIrkxknq8A7RadQ0ttO8ZnmnWeKW8n8hHmes9Ga4ScOPbTPbVu28ouBSCtrYAtr/N8x2499p
 UBG8OduyKx/7FXQk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=6t9Gh83qSa5TezDyFMSHpS4CAtQHMiLefyxulOjpcHw=;
 b=I5nH3eeEwy1Iqw+2oP+fxrXXfeKpeKr1GDILHlrqu5DUt4zQ/kXXvymG9ENxllzL8R44Nw75S5bDN
 IhA9UM9xmGJTBhR4YGD6kJ2b4e3GL6wRbYdOZ+kwJ3iMvXqdbqr7m7QrgcoHYJLogMX65ttpJzoyDN
 ZFfkeasITeWOB/ffHXECjpSEzEdAYOM2BU6X2JHbz+UWW/p79GIAllmykIyzKWja7CwGdZzdvXVp3H
 roCfBk63FQs9bjmibVmMoxD3KJeJwKpzPeb9SHHd0H8/P3ikfu8JqjuFFFicUopz8y7Avxp7S1aMQO
 iorEYtlEq06yJFKez9cdBX6gqBH8Fbg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f2940ff4-d675-11ee-af94-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f2940ff4-d675-11ee-af94-eda7e384987e;
 Wed, 28 Feb 2024 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6t9Gh83qSa5TezDyFMSHpS4CAtQHMiLefyxulOjpcHw=; b=SAYUAhQpD4ZP17+AvudOzHJbCE
 6/ABruv6pntgg8RZiFyuhLjSFLBKUav9ZonjZnuaMCQ61W7InWT/w2VyG+E5/9eIPfK4ZCCk6+Ljm
 QnMtNdsRbsLk93iG5rJHd48+8MvqbmxbnZ+GrNEVO+Q5IchGjkZwITCttamKsnCSa3LF0dkk04JoK
 xV0aCIcXwTbGK4pQ7c2KlOLxhICiHHFzJ9dp/avMN/FtKsKn4O5K72IURSFayQP3izd8C6RloVrY0
 fBvB5aPQ8JIDiGtZjj1/B3Ob/jYxUN9RgqdZgpxNVCpHmHwld7eITzawCuRD5PyCf/3RFSAUtHDNV
 xG2d+poA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQK7-000Dka-2a;
 Wed, 28 Feb 2024 21:14:40 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/3] 64 Bit support for hppa gdbstub
Date: Wed, 28 Feb 2024 21:14:30 +0100
Message-ID: <20240228201434.1515893-1-svens@stackframe.org>
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

Hi List,

this patchset allows to debug the hppa target when running in wide (64 bit)
mode. gdb needs a small patch to switch to 64 bit mode. I pushed the
patch to https://github.com/bminor/binutils-gdb/commit/fd8662ec282d688d1f8100b4365823e57516857b
With this patch gdb will switch to the appropriate mode when connecting
to qemu/gdbstub.

Sven Schnelle (3):
  Revert "target/hppa: Drop attempted gdbstub support for hppa64"
  target/hppa: add 64 bit support to gdbstub
  target/hppa: mask CR_SAR register writes to 5/6 bit in gdbstub

 target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 21 deletions(-)

-- 
2.43.2


