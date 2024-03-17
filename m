Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC0C54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymQ-0003cg-EL; Sun, 17 Mar 2024 18:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymJ-0003bo-40
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymF-0005jR-M1
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:50 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 76D70941591
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:42 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id AEBA2941797
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:41 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713682; a=rsa-sha256;
 cv=pass;
 b=ZZV7pjPcFO7FwC8u6tV3eMrYRsnjbFfZBndGM9ZeYLAlBRtgkPuBkTS1Nm/WT1d8dm74Nx
 NgAaJAuJSldK4xRTaT//cPO/IKfpdTLvxE/0BF7MPoJMjWKt9IlJBNUbFsE7oOweltHr33
 mYCCpBaIyI448yxx1JVEmPddAR7XYpRzP33on0+59py9xPJyHyo4ZIAfH6tufB/2vTiyQ0
 Omj5UV+LTUchslfW1bGAqVoUKVi+EQH2htEghQzhK7BsOI3c7eJAwC0ug8/mJ11elWZXIT
 Dly4H4MojLeLG+6liDONq3JfcFnGMcPh3TLQwtTAoANl2wNLSPE/E8plY7sxKA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=YwG8RKKowsYV3omc6o+Z8lijeUzieRfpLCia9vjxzgE=;
 b=nSy5whcsAvZDpvv+QxIr7hu34zfF+EcC7OxwCwtG1kyw7H5auMWy5cNQRuGVJrIRpxcC8f
 /LtbblYijSFBZy0b+X2KCDZwKWRDd8p1sxzC1N6IJFb0SEpnhMGjD6Q50uhi1hv50SaNgB
 MISdi5FDm+nyONQXOgV+Rx7CLg8HFXA4dgnys+wOjLSglXcnwukIDHSlf2n5zNOWcqt1OO
 P8aGHgYZBGQ9ZvFtGII56a17X3KIZ5i9i+nFYo8qDcTjvUXt6j9Vi+Ebk4mgPb8TKRto7c
 tPHmpul9+qNfyW5PT5Jo2dixYep9C+6kHXnm6pqoZEhNZOyPcNJol9n13A9PXg==
ARC-Authentication-Results: i=2; rspamd-b46fcdc5-9b7lh;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Illegal-Obese: 21a265813c4be00e_1710713682213_2189913773
X-MC-Loop-Signature: 1710713682213:599319948
X-MC-Ingress-Time: 1710713682213
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.130.139 (trex/6.9.2); Sun, 17 Mar 2024 22:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713571; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=JvFWSAywv4Adh/phxX/e9PidlGQ7qR9fK8q+ghxiaY+NPAZaYD5DwAlElrJcezMLC6geLwwbcnuff
 1wUE1Ya1Ow3faoW4xetkL8HMzpcX1G+sN1wZp8Zo4KyHP03RFSpc9KvcfVJl4OLsGNwBqUAAxaIjfM
 yR0XnOrbIcwzOz1Emz4gxbZPszefq6ZR1Q8jMHKQk10nh5c6JcAUeD8jS6A6yx1I0nnRqAF2QjjJ+h
 u635Iq9WwKaULCoLOLny1uXyVIHdYQKBML+RCGNLTFoYbpUiB6jAXOjBsNVw4sZznnv80+MLnPXBdm
 +QPtL3kz15eQgvYky48FbAdTDTu2MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=YwG8RKKowsYV3omc6o+Z8lijeUzieRfpLCia9vjxzgE=;
 b=q9muyNuh/BNDS/2ceN2+LPZ3d6EG63XctKmqbiPuQhO79ZfGaXxBswUTGVcnURzRgMTWQn2dsQDFr
 gbSNnjR8wzTo3FRia9TtiUiyUNJD+fhj3xmOQ0tYAH/KWZp/BhERwJSBraDXF4K7hX0yNVs7yo4MYl
 AomoK5NtKKvqzhGSURvcV91udPoInJFapQzs7fT5B71ylOSDU+ya/5+tnA2MVUTzom9PiPGa+iLY8h
 aFX/qpj/fI7yPhYgYH1H9SW5fs5CP1PtoETd2dikASPDtbMcQzPzUFRf7YpZaR3He/BwrTEbeplu4a
 YJORFqh0Pm952xhG2clH92HneVhJ0bQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=K3ROhvFh; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=YwG8RKKowsYV3omc6o+Z8lijeUzieRfpLCia9vjxzgE=;
 b=ZmlQTpMfXeVUNUcFoALjvCjmTWXwqfMs38vvNR/Q07Ea3Bni5Q7WgUQbwseF8TQ/zftm/ZGln2pmw
 3mp8+DNu/bZi5WsBy3NjZGoG6IjfptKGg9P1IToftr3QDqru8SDj/JVLrwnUP62efKLpJqWI/jm1wX
 nSLdeGfPuzp4G7jg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=YwG8RKKowsYV3omc6o+Z8lijeUzieRfpLCia9vjxzgE=;
 b=wJ3LWM5VwrPY0378QlWEwx+NjJSRfwwG8uzY+DeS78LhGHhdjwSyrUHI6fXY3o1fV6SWe0YB7sjqJ
 2S1WSZmSqM0nZdo6nsN5BBtwKnZi8cJhC3SbYg+knCUeneaYWeEQUFsRktE46VC+KbSBxv7TxTUs8z
 ZYsO0SJrPxI4wq3vnFf0IL/HW3RT+p3waf5j0Ia4k5K451yYcchSt444XpTwGTRKAWcpTX+0WA7sgC
 EKRFQsfGlIdz4VLAXTNS6DjqH8fvTjeP/nnpWTRnPPFAVXJlrKtJUzAvdiBroqwQyJ/OqmchNFGo4r
 25Z9T9S4v4BPDFkB8m+tLSAqi6pKd4g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 7cc3abaa-e4ab-11ee-b7ba-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 7cc3abaa-e4ab-11ee-b7ba-9b9d9be6ef2c;
 Sun, 17 Mar 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YwG8RKKowsYV3omc6o+Z8lijeUzieRfpLCia9vjxzgE=; b=K3ROhvFhYHCyqDlULrqacuZ4qp
 cDgnE8jI0RSWDsHSQAraFiqWDlDoubJo1HD4BIVjmnDuWnEagdaTWDblR3uWgUt/RkaI3wI8QLr3n
 2rDGoCjdq5HMB5p82X8hdYmmujXKmFM7TZBgtMh2T8kvQn9ieJaufh1b358bIa0B+codJo9JkdBxH
 S/of7jyKNFB1kq2Wfy+0GXafHto3ILN3Rtlw90GSnUQuyUr91W+pdiWPDX2s3nLxMBqYF2qeQEYmS
 PrAnvGnu7CGLjo1UFHafbMven1ZC9Jod02LIJJl40vAmhjEh87BMtXAboQ0W9ROUg8jvjmZO3GV+W
 Y0+Nbp9w==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym4-004C3C-3B;
 Sun, 17 Mar 2024 23:14:37 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/7] target/hppa: ldcw,s uses static shift of 3
Date: Sun, 17 Mar 2024 23:14:25 +0100
Message-ID: <20240317221431.251515-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index eb2046c5ad..6a513d7d5c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3085,7 +3085,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
         dest = dest_gpr(ctx, a->t);
     }
 
-    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
+    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? 3 : 0,
              a->disp, a->sp, a->m, MMU_DISABLED(ctx));
 
     /*
-- 
2.43.2


