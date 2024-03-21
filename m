Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196DDC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnNNR-0003Z3-7S; Thu, 21 Mar 2024 14:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNNK-0003Wr-IR
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:50 -0400
Received: from bongo.birch.relay.mailchannels.net ([23.83.209.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNND-0006ab-Hm
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:49 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id CD3C98024C8
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:37 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2860A8028C0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:37 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711046557; a=rsa-sha256;
 cv=pass;
 b=MF70Xd5RR2TLcmNrpKqnx1bJ9ikRvX2dFehQXdadH15qss3/Wzn/uVbdshPoxuoT1oalzS
 nSjG7r0eFxDOMNbQMi96REJ0a9W0WNdd0cfbsXs2jJ2LcyVHcb3hHXPaV9COB2ZEF73F6m
 SW1b7ky7Wl4KOaIMN6gHkVL9WM80gxnofw0fNJS82AzbFDu+EIieNowbzqGgSYz4+Tg/na
 bm3C1yu4ulCQ08d84w5YdRJj1OwNOKpW6HFj3Efs2xTHHbkKgDlT8R7rH9I8BEeyjHiRB5
 cxRc9VxXbRaaidfal46+6s0bIExqFtDF38RPEBL8Nmo9D6cVD0VuirZa+xlijg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711046557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=gHGV5SgvqHeNS9xh1GUyC449L2SojVmx7K511KJSCsI=;
 b=Et3ZfwhT1eCDSgzg1WR6TLXrzbo8F/IlKA530d5sliq4YznJuWOr+ct6PyBoIXHhbLbuNm
 pOsvlt+GVyjiB4eby/ANs5ubPRS3KgGEmQCjLqD8VFYPPm7ulVSeRNm/iNes8hHARp2ZmL
 4Ku/8i3y2dmQNFrVACZ/7qVEXqAmjQRjiUK0qmMNLrLC4C1bKSijWSJtLIorOnuWlCwIdR
 OVhuem+kwJGB3QLM4QbtmXJ7++LW0P9MOXL2EK5W46R5wSqKpTcD8vtE76RGvd0A80C0HA
 6UVteDRKoyV+74vIW8UPSw3KuuUlZWse7Qt0+znZ+f/tgT/lx7W2R2xHXH00Gg==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-nszwx;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Attack-White: 1fdf19323505d928_1711046557671_4060175928
X-MC-Loop-Signature: 1711046557671:1115423673
X-MC-Ingress-Time: 1711046557670
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.122.162.95 (trex/6.9.2); Thu, 21 Mar 2024 18:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711046521; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=uAkiHyl8EK7mPwo/F1zT1rTZWx+eGziHuFU7u25otvbz72AeUP663/bMs9Z2vfYbSHUOVI7Xa8l5m
 HIhl0iOuPlDp/OPrue7w5Bpd51BrTs0+UmurgiOfNgZamlwvBHMQoWWmwrC7uspPQBeGvVHlRKtLWJ
 fpy1OUtDPnltcUCYvthnCECnNJbOrnKjMhkbt8tMH77fvoE+OA3vJposR5TiprNwGmOgAbwNaKZEG4
 thgbNhDOaq/8InbhTuVfqHltUKY4JQGIEF2pdjp2Y1Q04zzlCvlCN6u9UnTW1L9HIPIx1UqDlYmQAS
 IqBphMxXG7aOiXGVnTLtAy+Mzb/cauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=gHGV5SgvqHeNS9xh1GUyC449L2SojVmx7K511KJSCsI=;
 b=Gc7P3dclVi+YX+JgbIV2rdfLycWP59oIIM2Rs/RAhM8Xe+aIUdmEEJFA7LZ18TL2V+p3XBZ9EBAhQ
 WwuVlCV5BNhnDAe9wAZMqmYCZKisft98SlGi3E0CxM7KWbsGF3KcTEX1mxmaXCSSriHdyf129Qvci1
 n5sKm4ObEjC2GVZxJ7zGkbgfRXsULFP2zb+3xGa6e0SgF2j7oG4IZUdHjWIs6qBPmpj0en0AaEkci0
 /WxySE3jSNii7PL1nQuLWyvxt94z6aDCAZTzakm3H9k2qimmyrA6tfLbOP24qzXLzTuZUP84nYoYJK
 fdvRy13u4CI0sTVxWb+ZBk1SaZU20EA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=KaYYwptn; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=gHGV5SgvqHeNS9xh1GUyC449L2SojVmx7K511KJSCsI=;
 b=On0TTWg5OIHJZ3wzOeKF6o1xyOdIbMfArAOTVu5b5LMOb/f1wbvEX/DEz4Z0SwWcyTpGKSbXYQ9Eq
 DLDz5VqdYqwl6qzuDlrTwXEY6R+egSPzHWvEpet9Y1g0/WJg4wZQQQ5YtcM8EbZHD4aIKgxMudxAHZ
 4bUZLLJoGz4IPWnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=gHGV5SgvqHeNS9xh1GUyC449L2SojVmx7K511KJSCsI=;
 b=GNkN0Lkh/DCYRp0ezz4zR1hsUaZid2YdQqMmi8EyAoPJr7RPCd6MNqIAfqt+taKrj3mzp2JKFRX56
 7J3GqcyxGLtFXbywSaRPMBzr6Cb3id8zXy+RlejnlHjAKfNqB/QJb/0isCv+ufPd19qgdrK4okdzMD
 qzVRZDX8fYNSpYacDXEJxD4pNWRtWXUdSXpXcQVest5/cLXCG5lO03HJGDExMMyQEpmgp8cbpEUQwW
 JR+UJkOKvN9Q73OqrMcSb7qCEFGZzymb0J5TinuowTshB51JCJZRNrHhuzuITbcNhUR0LvlsxeJ/z0
 pzNjscB6t7WUwNNM8yKua+Z3x8JeYQg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: b2e00c35-e7b2-11ee-b21b-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id b2e00c35-e7b2-11ee-b21b-eda7e384987e;
 Thu, 21 Mar 2024 18:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gHGV5SgvqHeNS9xh1GUyC449L2SojVmx7K511KJSCsI=; b=KaYYwptnRoZZglRstSHfSPApED
 E5Ea8Mmbkt4h33lnjIpg9FNH/pNrBaP+XV12KMXt72gMFvGpYnqDWvjGbs5+66J2HAnGgdjaCbfzM
 ks/orvJ09m+wYeOyB8aQwMXg7xyzKP+TBAb7fR/NOMasIMuyLep6v9VewUoCSqeBKVROAolnVJJA2
 kAwjFG8+MJUuPON19Qi1QJ9y83tERkfhz+n7T5Rz6hd8SRfVwyVJDunLmOFEkgyLooc9zOTHJEceo
 FQLzpkCyhiIjVU8iHEZtaN1Gj5XHu1IJBlYV7ybo9lWxFMOuJNWg3t8Tb3pIS6qzqmXKAowh0PIUP
 6ttN8gag==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnNN2-004uGo-2G;
 Thu, 21 Mar 2024 19:42:32 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/3] target/hppa: add: fix trap on overflow for narrow mode
Date: Thu, 21 Mar 2024 19:42:28 +0100
Message-ID: <20240321184228.611897-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321184228.611897-1-svens@stackframe.org>
References: <20240321184228.611897-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.21; envelope-from=svens@stackframe.org;
 helo=bongo.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4d2b96f876..74a9ea0cd8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1122,6 +1122,9 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             /* ??? Need to include overflow from shift.  */
             gen_helper_tsv(tcg_env, sv);
         }
-- 
2.43.2


