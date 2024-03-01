Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39984C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xy-0005NX-SN; Fri, 01 Mar 2024 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0005Ip-Cw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:36 -0500
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xu-0000Xo-MT
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:36 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BEA6E4C269C
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:31 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B0A254C2310
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:30 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315191; a=rsa-sha256;
 cv=pass;
 b=or1XBgRA6cHrzLpilgL98aOTnuWOzOYJcFDf1oQ1zQaGGVmiOjOHSPte8MOpUEyhF/25y0
 bbo/E3HQ6X4eh1o6FgStRue/NomKkcYCZne7b5qiip/I6aURNeKH2lHEfV4tHtfDWPFwsQ
 kkaQkerBAW9NHyyAbK+ABkJUFDnT6dg3Uw7eacVT3VA9rqvfOqQZmSm9jrWVCXmmIptCry
 Fhq1JJLTIaFjOLdvKFDg9c4CFBtFlYX4lPG9RYgW7ngHJUyHdr0GMbKsHYjn1uKiY0CJDv
 uBRKKc8XC4GC9p8AzWn+eSLPXCOlovZBGvJe+heI4np7RbdNxYN2p2qz8SAe8A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=s0rD/E55eu1dy3gy9zrqMvtlkoGP/2RyTrDaNAJAFP4=;
 b=i4sDhkxH/v36/qDe00atWCpa6lhyuHdA0P7APC/V3SCyVbvhV0vXZg+KfFubYepSHidv/B
 fEQ9Jw+kNBHsIH70+9DWwGR7yXqgt4lwz4T0ygNlJDm/dxY+AzUgzvW5ZMidiCPAE5qh1W
 n7UGTqknnVfDEgElZZBvip7zDVp9O2nGr7mrK5fmwK83LZEAlOsFCMvuaBSHwOJHRAMjPB
 PJAlrYRbmVQI8HN5kjMwBSFHrT36ElUwe3Bq1YGEBBvQHcqtsUYU40OnriyOpmkrtpyGJS
 ZxXhVALQ4mqpGwN0l92NqwuZmeopZ00RH9WJXthNKf52WKf3cspMHMXAp1EKQA==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-jmwb2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Decisive-Battle: 03028bf9029b2e1a_1709315191227_2501781902
X-MC-Loop-Signature: 1709315191227:2238914392
X-MC-Ingress-Time: 1709315191226
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.58 (trex/6.9.2); Fri, 01 Mar 2024 17:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315162; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Rg2NSP2/jvvNAQQffUTYLAqbtrQCk/AzlWCZBRiljkA2u7JneMHFsGCPmmxXMgl4nDWAGGQ2Id8l2
 su8zmdJ1otDHcaXZecwna3IRPwH1buO0mowDQaYqgH9HSAbz7oTwFEo3UDHR6IhYlKc+5/GkHvHu5E
 yH3eVlYB4LseqoXFRm62uM7jFlW32UJtnMnags+Si53D9OqeCTz2uF0u7HFYr0rUS9weLQCRnu/lra
 rzpe2GKNo6frvUWuLxkUs3wISeWvA9rbD6gDcvSlIEgPDwmu70H4MbOhPrddxw71D88sonEe58AeRG
 SUN5bowYiQVjv9TbOhwDmdKuc8nlipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=s0rD/E55eu1dy3gy9zrqMvtlkoGP/2RyTrDaNAJAFP4=;
 b=DmLdQLU4aAydo//5MvfKI8vBxOWdx+uM9Khu8KAoXhEnWGHgVZv09DyfTw4TBkBWXYWBDeCcnY6ci
 CzMENkRmkOACQDajIdcmVrxUsv60clopWhhGReqtjlvwl60NmE0HjBkRB6o+82tt9rPIWrO2gAohx9
 U7bswUirvF6d5+FjvLWJuCSNRa7rjVhq7nUWA+sBBHgy3fklucJ78kceodRWjW0guOvqlhiCV/oiBB
 CnBd2e2yecFEXIZQpJV9Ef8/bdQx7vAHcD7Wn3IG0P7YZRr+LbVzgWQjhkoiPxf3EXKF7ARxGWJxbM
 vurCbbh32+M1FUJaW1hGHwyQcSGmeMw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=aX8A+CUW; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=s0rD/E55eu1dy3gy9zrqMvtlkoGP/2RyTrDaNAJAFP4=;
 b=WpsmVCXuJopxtiIvdot/boTgpAPamJR+RqfPObJS9xEZqGMF173YjBAsseVGdwkC3pKLI8/CroSIf
 iYNTx7dfVZyd8vREmOqu66raGXQ0/EOPSVSLQtu3rKrVNDXmk7AwLps/Y3xD1wZfIlybf0L58R1GCD
 4+VNALHhG4dpL5LE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=s0rD/E55eu1dy3gy9zrqMvtlkoGP/2RyTrDaNAJAFP4=;
 b=PZnL0JTGKbR1ZiKUZl58FjhwGHVEHxeA40nFjrTAvkFBvs39cyMRIZ9svwV/GNmXiHB+v757Tj1wE
 /cyyV7ATyHU7u8EkI1CJYHdsJco5HOtAL+6TqLcaTE2h+2fEAEPo+4wkunzV6m+MZ2+RZTTpoeSVYE
 pUs9yIi+XGs5ckZPPcLzI3gXWaSgoiDykR8/qPOvRl1+8p2uGdNuCCze/wXXaDgORGZk6t1aJU6u8I
 kZZPrizNGZV+x2TnR68DtJas/iigXJ1ILIQf1+HIJ3/muNL8kY4mp9jRrG58aQIMKws7/kL8houjM8
 f2ngu6ewf596Gdp54gJ8SwWo4bTkErA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 8eb5151e-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 8eb5151e-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s0rD/E55eu1dy3gy9zrqMvtlkoGP/2RyTrDaNAJAFP4=; b=aX8A+CUWuWb6t9UA7ZNV37sg5t
 i5Haels4MPKPuFIgMy/At9xFTndRO6Vlf3ell4XF1BjGWDdQkseX1BSUOSvCC95R0umWsAc2CHGXv
 AIXEqvNt1u3wqdbNfUlEDzkr/AQg/PK4ukg+85zjoradanZ8jpYKVlUzJj/tniF40u6p7AHLorIC9
 +zpAL9XVtstVmgo8EMRWW/ebs8yoGUX47R/0C+PSisBZWI7Ff7o6WyxpuCahKfQrhzJ6c1gUhaOQP
 X7vkCHkD+rJhXcN60JiccuYnAlGI0IIH7FwtaFC8Hc5H4Gio/y2o5dtpXiDl4+byg46xC664F65IY
 BErOusJw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xg-000bs2-21;
 Fri, 01 Mar 2024 18:46:20 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 02/12] util/log: make qemu_set_dfilter_ranges() take a GList
Date: Fri,  1 Mar 2024 18:45:59 +0100
Message-ID: <20240301174609.1964379-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
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

In preparation of making qemu_set_dfilter_ranges() available
to other users, move the code to a new function range_list_from_string()
which takes an additional GList argument.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 util/log.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/util/log.c b/util/log.c
index 779c0689a9..f183ea4e4d 100644
--- a/util/log.c
+++ b/util/log.c
@@ -382,15 +382,16 @@ bool qemu_log_in_addr_range(uint64_t addr)
     return false;
 }
 
-void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
+static void range_list_from_string(GList **out_ranges, const char *filter_spec,
+                                   Error **errp)
 {
     gchar **ranges = g_strsplit(filter_spec, ",", 0);
     struct Range *range = NULL;
     int i;
 
-    if (debug_regions) {
-        g_list_free_full(debug_regions, g_free);
-        debug_regions = NULL;
+    if (*out_ranges) {
+        g_list_free_full(*out_ranges, g_free);
+        *out_ranges = NULL;
     }
 
     for (i = 0; ranges[i]; i++) {
@@ -447,7 +448,7 @@ void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
             goto out;
         }
         range_set_bounds(range, lob, upb);
-        debug_regions = g_list_append(debug_regions, range);
+       *out_ranges = g_list_append(*out_ranges, range);
         range = NULL;
     }
 out:
@@ -455,6 +456,11 @@ out:
     g_strfreev(ranges);
 }
 
+void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
+{
+    range_list_from_string(&debug_regions, filter_spec, errp);
+}
+
 const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_OUT_ASM, "out_asm",
       "show generated host assembly code for each compiled TB" },
-- 
2.43.2


