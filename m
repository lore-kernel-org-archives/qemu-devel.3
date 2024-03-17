Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C7CC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymY-0003f4-BR; Sun, 17 Mar 2024 18:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymJ-0003bw-Cs
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
Received: from cheetah.pear.relay.mailchannels.net ([23.83.216.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymF-0005jw-M7
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 06897102D53
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6A31D102CFE
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:45 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713685; a=rsa-sha256;
 cv=pass;
 b=Qkxu6V+wkb4GTy/nVLHq7VOn88mzyiGRlKaNaN/8D/k1he3nFaL7BRV8bk46Uuv5SHnisI
 CRfKXR1GjibUBntQOV0zh9+Y6GH9yVJo55fj6mST85deQnGqcHZBteDGGiRmC6ZszVYmWY
 LEaL2ukqXydkrRYxKLAatfksl3ZxRNQocoGajyMXqjjHNUHIAMEoCzbWF+HezV5PuPZqTp
 8oGXRZiogKr2yFedrRYaYwGZDcVnzefJpKvRqIRCyIdq/RzTQ9qHICoyw6F+cuEqoEmaHC
 wkLel6t21RKRe5Le9ALJ1xL9UtMvMXbbz7FqHLAP4e5rRddt5iGQLMHtBmDeeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=QCLrGkCK+xiEWzkgx+AT2kPkptcNlffHXwOeGyEBSx4=;
 b=quKtzi6bB9nj01ENI2/yINkDtuhrZiWCJ39cwcq/FqxSTFkeWe/h7IuHOJ1SxN1Dfvu8yu
 nAs7q55YuqYworE0dD/9BBoFdQQk/wCHGEZRT7VqHaNos83w7HVVcuK4UD5mYR4tVnXV5S
 wT7d2DCN7bpO2LSlmARPgkGc/Ydhdalm3WHjQtzSUD2bMzAqe/ydFNEa0YMUU0mSsz7s2B
 VvVUr4EiohO6WRJTVoOll9M4B8pYtFpH4WgUlToNXX55Mwm4ASY3QcRNKjibEJ7nLgg9uS
 qvAnyLe5hFT5PReogsy/6rXZ/YNDxe+a5Oo366xpEuU75Ut7PDILP2R11cjhCw==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-sx7pk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Shrill-Belong: 33a55f680decd55a_1710713685922_2844729222
X-MC-Loop-Signature: 1710713685922:2183214641
X-MC-Ingress-Time: 1710713685922
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Sun, 17 Mar 2024 22:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713649; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=RHQzGj6AGd2Enxcj4+hTdgKgKjQxBn2hA1KS3VpJobpUvEejkjqZWQd+7LkO0UWZwC/UbLXIGZBf8
 b27zS+NBEKy29BSeLmyCYhSdoyLrjcgrI4Xk/esUPEbq0hZ94+v9AoVvv80vZwm1CiF82jUK5Z1NG1
 CClyw/VBZ7ZaqkaIgx3S1jqESVt2IQ7cC5pCtp2Y50GyDtGxwxZ/bJPDM/VFA9Fwrv1L6CzIN5qoOi
 1rfulG555WK+TTujfLLV2tw8pNvSHVDfvwMDMbJxrSkCQl8i0rFVO6JVbiOM7Y0fnYpjn2j+/xxz6i
 n3f462+s0eUtaaHmaee3k5gfanaJVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=QCLrGkCK+xiEWzkgx+AT2kPkptcNlffHXwOeGyEBSx4=;
 b=iNFc8KnDT00Uq92va6nSnYH2q2NRf2JIchT+sOm4ue+4Md/iXs4wvE/Ttej13OcJQnmer/CDd4xlM
 DYSRWI5CqetGbnPfBgZhDFli43LKBRMuuZ63sDvQL8Xn/f4jF9W7O4cNchSEdImgTz9AkcOUQZg5x9
 a1nUISGOfRW0kE3oetpHSMxIe+AbMuvtGhuKCTVzCRJAzYdCU+FaPOXeqv53TMRPrMUCFMKxY4ITsS
 dE6+UVGzbT3eDM1+lLbC9XQSHFKh35NTk96LSor2x47XqSFyggdfa8YWO1d9lKYq8zG8HvumN9mMBR
 1tj4dQaJ4c7ZoY2wGf4jD0Zd++h27ig==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=UoRa7K7U; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=QCLrGkCK+xiEWzkgx+AT2kPkptcNlffHXwOeGyEBSx4=;
 b=GHpkYwBnbFMnkyfwXD5D1WLdr4rLm6PwsBhR+rI71Of5iZEfCEjoztLdqUmuRQ6nFQi4GWf8z+ZAm
 4/2wIxj7n9qbkH53qnVptAnmnPzpwf+TkxMQQESw6so7ZY8eof0K254n+pGx/aD5FshJhoI6jAw/AC
 Hy8lOe/h8+vX7u5k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=QCLrGkCK+xiEWzkgx+AT2kPkptcNlffHXwOeGyEBSx4=;
 b=ZYYvsPtJ5hkwziKqC1FKNXe5Qe/Ie3epeDHBqBRskP+s6UgByxkQhCXpPt38DWHlJlRQhkMN/2Xem
 JXhowewT8NDXv+vcnHEX0QFTJt3vl6m+YqllwgF1zHYgf9/AdtutaEd5NbRjt7qIdgNGgVHeAx8Kfl
 4ZSWhjSFfvs3BWfUhScoJX9xySBlesna82lM/yix7ftfu+Y+SQK1hYNytWz4R76BW82nAlT/hiRHGh
 CPvCxWJdKWaNDzIDYyncgv4UDYOa8G/84xIKBHDDudAYFCMCf8a3gYkMoBs6qm4CvT32FVHmuYqcxY
 eXPraCQ7+fEZ53OtcrqJ5iLbENOdsXw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: ab7347fc-e4ab-11ee-b1ba-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id ab7347fc-e4ab-11ee-b1ba-eda7e384987e;
 Sun, 17 Mar 2024 22:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QCLrGkCK+xiEWzkgx+AT2kPkptcNlffHXwOeGyEBSx4=; b=UoRa7K7U1pg/IKeFyQy/zFsBEW
 58aKsXkkWV0u5VD/B5HV0JmvI596dXx6FQWFyRhX3v0Vlu82t5V3E00lYjFSgldkH/k6a1Fta59B+
 jQEanY6gHDv+Zu2pTflnYdpHfWmOUFtpEnuRZifd3U05cby2tELtLCYXJeT/foeEaZRnNDCvxrtvi
 Z+g9tqp4tqLf84Fft0WP0Sg455/1r81HJXsg20qEZeWYK01fy2pDXXyifVvTvBEClHWRKT2IMQ8t5
 FxdGucz6DhNRgC6mIvBjCM3n+UVs9uWG+uDCeQ/ZD7sUDInogm4TMdPzehRlpj5BGyHTvbhCW5t4g
 GP80jXvQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym6-004C3C-17;
 Sun, 17 Mar 2024 23:14:38 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 5/7] target/hppa: copy new_spc to iasq_f on be,n instruction
Date: Sun, 17 Mar 2024 23:14:29 +0100
Message-ID: <20240317221431.251515-6-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.34; envelope-from=svens@stackframe.org;
 helo=cheetah.pear.relay.mailchannels.net
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

Otherwise the first instruction at the new location gets executed from
the old space.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 58d7ec1ade..a09112e4ae 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3777,6 +3777,9 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         }
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
+        if (a->n) {
+            tcg_gen_mov_i64(cpu_iasq_f, new_spc);
+        }
         nullify_set(ctx, a->n);
     }
     tcg_gen_lookup_and_goto_ptr();
-- 
2.43.2


