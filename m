Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6FBC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQ8s-0003iu-Oh; Wed, 28 Feb 2024 15:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8p-0003hH-PC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:59 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQ8j-0008HP-Cl
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:02:57 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E2195361FE3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:51 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 30E3E361296
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:02:51 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709150571; a=rsa-sha256;
 cv=pass;
 b=gtj77va2s/LeL2kgChk6PHmtnCNKsRRGfXmb/SmiAlCHP/ftUtZq/IkpOR8vHmNJiYZgCH
 BkZESO7XKUXKUXbcCi/3u/fU7HUB3WTn4wGUxW5DzsGcdZZD5blH++g3eV3jRVxBDJluwu
 qxDpEy2XlVxp7LGFNm4T9WXYfsiM5K0HhuIPQcIw0Ya2YCW6h7hw6624/HgrYQznfFxDm8
 ReQj4RYKCSEkJQ+Cqe9S61kGyYnGxqj1OYTwrMb2ihkGERoQal99Fcyb0WQAOOlpm+7ES+
 C/tN7eeq9Co0VKLpFq09uyLzjZXGiw+WC02Kjqv36BuWzQXkQx8v3u1LjAQz3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709150571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+4BO8V8Ci+BOZk6T4aIijzbqHUwsqEFz95/F59VNM+M=;
 b=ebSqZerwWuwBAw5R7qxXRpsIKWqiTXdEuj0+al7dU48k4Px2D+Sm+gDiuuLJMJ85iyDNkU
 bfWrMDDfjBVDskHU3/3WnL9nw0sJtmYl3M0R+FNr/puzi1dL6jng7ZmyMYrAgy9wH6cMNZ
 pm0ouPlNR5eeyKwBjYDvHHPi4/xHJxtR68yfME/A6cjyj7RcuGivNomWElvwVhrC6ORVHu
 FjIyWm1/VJZDOc8cvVri4p36LOSYuXty53Khx7sU3qutignVqpUszEFZRnj8SoVzZX2K+4
 4juMu+TUNu/kRQU87hnMsp7dzVeyQFt8JB9hLTXHKBwDQ9gOKw99kE1tnuUNlQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-jlpd4;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Wiry-Robust: 4fde0a5d3612acad_1709150571750_1144819986
X-MC-Loop-Signature: 1709150571750:102229620
X-MC-Ingress-Time: 1709150571750
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.142.242 (trex/6.9.2); Wed, 28 Feb 2024 20:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709150543; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=VOnMD/S2PTFtD4pVmrjdLq0PUtmPsHt5R31DTZnn/vdLWiv0fHINIz0IyjKoMeNhVGdEzvbYONrzs
 /ca/luRM/0uemqbICJCJ2ny7gg3YFZMDWNJmUwE8ogCn4ks1UUIB+OMLgxVJqzBkTbuAIK0ze2dtSj
 PaeqEpJPuKMsbkH88swrPp6iyNFJo72FKE7OVK8+kMj5hhzAbRGR3cA9DAeAlBey+dDyG8rHXeBmjF
 WgmFGzsRlzxXGSwArblF8n7oc3/Z2AMVzvMii9d6Wqs9GSfNZzLuRIcRJRl/j6U8oJ8zHb/7VcqlRz
 IfwDpVMBNkRjgEj3k0zedqSoqt6UfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+4BO8V8Ci+BOZk6T4aIijzbqHUwsqEFz95/F59VNM+M=;
 b=igzGFhVCbyWnWFMT5A5Sxj+35jdwsuG1INFXFVW70I59sp0nKlAd6ArG0n8eXBjbCeB4alBm/HOCL
 iAhP5AMN6N8gPIdakpbHqZ6ZxtJx+sVim5rbV176LZ8/cbfFPqGJ869RKR0wroq5ML2Lytc2tX5QPf
 UxxUupcLy4dg1LZdB+V9trfp/Yci4+En76s5gYd08mQGL3fzIknJsz2/XznLw4HaVYBpFPdxTP9l1O
 FMSZ9sLgQzDE4GSx7k0+FJAj+JbvUIxIETl2Kq0wi8prmm/Zl9lHTnKwPfhrN4gfX11Act1Tg/2XNP
 eswSPS+yrYOuSIXzoLxdDYytCdwQexg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=OsovQkKB; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+4BO8V8Ci+BOZk6T4aIijzbqHUwsqEFz95/F59VNM+M=;
 b=fUdAUvWzE1J/jQ3uDDWP1qkcuWiXZSkGIFyq2kJ3+4p8/AUmUaX4ZsqjFSiygmCzD87UES3SPK4sf
 VZDvVIv1h29aIIKGqw8FZ6UMkjLYS8oHf17T1fwn3TB/BlAePRDxeUXprttFQiIB0rRHzBS/sAsrjf
 XE5gMyQw2U4/YNE4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+4BO8V8Ci+BOZk6T4aIijzbqHUwsqEFz95/F59VNM+M=;
 b=mU2c5JXEGreQ/txAkiX5tJSROQ0irJ0UCrW5TuDCHJ4EtJDibkPrz7onBgpzo+ohNzvjKv/6C5fns
 7G+Owlex3Y8UL9SsOy3WjRp/c3h4x1RfOWYau84IrXd7tSr0bZ0ZAIesORbBKkByimNe3w06l2JJn2
 8RYc25Muinsc8RxB15aPQiaA1AKqV+oaOtEPCcryJawGC90L9WPlrXzL3LF9spob3uD7fWsRvy6kxn
 oaPqSYu0caQobe4OZNOEO4Qw7DWRH/PDJSpzd24xFh5Gc3pzWyTsTj9DsWjcvALxWz164gv0l6sbnq
 GphkfxC6ajsRBwo4knd6ed5RAERs5SA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 46992af1-d674-11ee-af93-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 46992af1-d674-11ee-af93-eda7e384987e;
 Wed, 28 Feb 2024 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+4BO8V8Ci+BOZk6T4aIijzbqHUwsqEFz95/F59VNM+M=; b=OsovQkKBl7dGeDrGVtO5mswLHe
 6p9ALMnQdxUy9RwYiFDQ9/SlieJLcP4aHjaedg9oqZdyINWC/taUpTq1zGlS0W+RyKu5kxZ8KTN/S
 j/NKFX5FFwGTKYQFvshAQdldl4hPpocu7VfkYl9wsqVqTQTQG4dtAE3lxHQ11A4RbW6Lj/ZH6LPe0
 wyPk2qVf0BqV4TSnHjCGCWyAOCxeE4pcQXZp4/ma3numjj3qmMKiirAcaI9wkSnmdGkk2W9EbeLyZ
 9dWRsqlXeVFb8xEDFkk5OnmBdQxdnblNv8T/qE4cDKExlfDg1G3UeDA4rNOzKbbFA0ocl8kL/2l9b
 wJLhA8TQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQ8Y-000DfK-05;
 Wed, 28 Feb 2024 21:02:42 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/4] plugins/execlog: pass matches array to parse_vaddr_match
Date: Wed, 28 Feb 2024 21:02:09 +0100
Message-ID: <20240228200211.1512816-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228200211.1512816-1-svens@stackframe.org>
References: <20240228200211.1512816-1-svens@stackframe.org>
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

Pass the matches array to parse_vaddr_match(), so future address
matches can reuse that function.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 contrib/plugins/execlog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 90da1911b2..b4b5ba113c 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -206,14 +206,14 @@ static void parse_insn_match(char *match)
     g_ptr_array_add(imatches, match);
 }
 
-static void parse_vaddr_match(char *match)
+static void parse_vaddr_match(GArray **matches, char *match)
 {
     uint64_t v = g_ascii_strtoull(match, NULL, 16);
 
-    if (!amatches) {
-        amatches = g_array_new(false, true, sizeof(uint64_t));
+    if (!matches) {
+        *matches = g_array_new(false, true, sizeof(uint64_t));
     }
-    g_array_append_val(amatches, v);
+    g_array_append_val(*matches, v);
 }
 
 /**
@@ -239,7 +239,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         if (g_strcmp0(tokens[0], "ifilter") == 0) {
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
-            parse_vaddr_match(tokens[1]);
+            parse_vaddr_match(&amatches, tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.43.2


