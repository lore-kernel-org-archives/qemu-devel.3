Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76F7C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6y0-0005OL-Ag; Fri, 01 Mar 2024 12:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xy-0005LI-2j
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:38 -0500
Received: from kudu.cherry.relay.mailchannels.net ([23.83.223.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0000YP-G5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:37 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 1A65D2C1084
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:35 +0000 (UTC)
Received: from outbound1f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6D3662C1D98
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:34 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315194; a=rsa-sha256;
 cv=pass;
 b=NK/nXuJEYtIggWqN5LqUMXQH4/MIn6MtdVti59eC5SWDomPgUJhM5WBGn3F+INys8I5980
 22u8vobYaKPvd4x2EuTpRgYfsYV4gf8X/2LXvDr2SI4rFVZ/a7lA4tbMBr3ASS74y6bWFm
 zMZlyLid1kfBzNDaoui6+bqOjsI4hUulhdlFC4f02e1vqHkaPXVYRG3MpmKA/MWLC1q03m
 gfHWWc9z6i9in0QIdnrBN9T+U3qucpHgAchuDpjdgjIrFpErFy1/hxTV7wA7FkpDOf0FUR
 rrbZ4oxBuFxAoqTb0AKnHzGYnJQ5bVQzEieWe+3u7vVaxxZwtFRuGKX1l7tvXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=HUL4zxvHsk3QHlw5QiDCgjuSljLjXHEAHk3yu+AzSaY=;
 b=57da1J6Z/3iGJdOmXKM0Kb0od4Po7Sp4r4jQejzs4va4axEPZIatUFeYpv+0bbIv513c+f
 4OYEDaWQ5kbu8wpXhKMl10tPuWOJGapgCTVIp7+RBlBTkEcjXb5h4PQ30hTcIc5yTezhKu
 kTPJP1d/5ahRyNG4c5HcQUsK7m9yUgmAsc49KkDlVvMLIyWvvCdNSFr+LhZdizhj77FlvE
 Fm6PwDqj+pONmN8uqdAAfwHB2ZHcxoYa1muXRxDOTm2wLVEsQDPFasl9/4o4bQ8vrId4jN
 gyyrxNpb0vQHyQ303kf27JK+/N5EdCoScybPWq5AvySD9lsHPbBxNbmhomZI5g==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-9jms7;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Scare-Shade: 14ee16277f0fbd86_1709315194947_1297384744
X-MC-Loop-Signature: 1709315194947:3419211672
X-MC-Ingress-Time: 1709315194946
Received: from outbound1f.eu.mailhop.org (outbound1f.eu.mailhop.org
 [52.28.59.28]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Fri, 01 Mar 2024 17:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315101; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=bgS1bkK4T/pqbMlP8hghVXRmnl4OwbkbLmvc8x3qEfMKu9dcvLIwmomH7VOzOcXG2NHLpo88LNF+6
 MpcXsodJPxttrtyRN3zLtq9ctQ8RbzdmXnr/RkmRfca+jth9ukuoC6OJA35JD5l8fKugescLDLnE7y
 fULx2DUuiDzJ0UbnEUTZ+G3XSN6EKh18kT38yaPuccWHZ9okz5w+r/8JUdEMAfszc4VAmn7vgykHwQ
 L3+K5HAlSH3QVnmx3bu5jrKNma/yx99JKxHZCY769UI3BYrpahv6pYo0o+6RhpYhmPaPUC8vZu0bQY
 Ny5DNRLdt5llUWhNj8YYm7AU6CFLg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=HUL4zxvHsk3QHlw5QiDCgjuSljLjXHEAHk3yu+AzSaY=;
 b=MjAQ31yATOxyZzgEMXGhkajIoSdxFTa9gQd009pUC7oeFmDk8OdkJvfXHSiDHwYXtTx63mqTPTjhr
 tcS2+VXKPk70DiCd322FQuVY19PhGsSW3pGILdS1cotlv9Ve21y/KbRLfMBzXH89SQD6ncyHWisWyb
 NCZBs34kFM3rdFyBfLgR1DyOODhfCXVgZRrrvdWLwi1LPGF9bssxuv/RzAocprahXW5OKiyRJrKehs
 1IqI+0Zv//nxbfNYb8ZsKP3nyoKRxIzgmIAY8h2VEi4W0TVq3Yd4/gHldc+K2cRucKYhybS+EXmGA0
 qv57N1FY0OJZAFkc7BHr1g3vKglldUg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=CERtcaUL; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=HUL4zxvHsk3QHlw5QiDCgjuSljLjXHEAHk3yu+AzSaY=;
 b=Vy3IXlR0M2LmEn1XQUsubOcLbZcurdaAAT0x+vxaA1BG0YtASkXaeYBvPsIs6y1U+J8mpbdGncr0B
 Q1YsMtHa+FyjvHyD3B1Ts1cC0ecmZDDsJie2STsiz9qJzB552ntodBUzybBds7gHdBPp4NJpg2WzvB
 7ioxaw58Bt6qVteI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=HUL4zxvHsk3QHlw5QiDCgjuSljLjXHEAHk3yu+AzSaY=;
 b=mdutM8SGBmS9SUtGK/lhahpRpmm85GHV0QBtjZat9CKLQ7ugagpCUp1olRHVYE86CoNOpPBw09If4
 2/PZ1kygxdpClnijcRJQVfHI2Iak2ms6X6cMQ4Z+icF/OCqbeQT8QO2mNWXwmeCEH0bZe1+QQfOCRw
 /Rai4VQQPUGKDvxTC8wp90KqsCMhDrTiZCZLMq59z8iM0IhB5rc9nJE28IOxGn4s29fMZBv03oN1XG
 yiZRZRrr+20mjD0HCZeGMUUnCKuHl5p0qh/IR7GRtj2wXMaUsTcHNzkE2iNvUwFxcDFThM7F8jrl5U
 FV3LxwCnPKcWUee2K7tZA1G+WSDZ6Bw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 6b291732-d7f3-11ee-b66d-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 6b291732-d7f3-11ee-b66d-9b9d9be6ef2c;
 Fri, 01 Mar 2024 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HUL4zxvHsk3QHlw5QiDCgjuSljLjXHEAHk3yu+AzSaY=; b=CERtcaULkHpLvA4bOUu0v8vAjT
 5SLbWtTOl4NajL7YA0UX5WA8OkDiKBN0i3Ahy32+PQUaPC4xnNnNU4+h+BGnIHqLN5TaCHpsVr1An
 8017a+h3AMpOqYlRhpPJgSduBvIJYl9uW9vg7K5U2OEl03GEGr6ft9WPpPNeHHjM3TvX6uf5CQslv
 oHbKEpVlB4uawZRMubZFsmwVlurV/ab28AK4pgv5vkfOa/hytdmGRW3J1w7YFf2k1XLsRphQopw9O
 ifJiw7y8uZT1gWz1N6lgYAez64+kv+awi7tBSNhUGuPZtdVzR9OF9C18iOmjK+TRFMfSP+gmoNU30
 2oOWd+4g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xm-000bs2-2n;
 Fri, 01 Mar 2024 18:46:26 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 08/12] qemu/range: add range_list_contains() function
Date: Fri,  1 Mar 2024 18:46:05 +0100
Message-ID: <20240301174609.1964379-9-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.97; envelope-from=svens@stackframe.org;
 helo=kudu.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a small inline function to match an address against
a list of ranges.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 include/qemu/range.h | 12 ++++++++++++
 util/log.c           | 10 +---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 4ff9799d89..7ef9b3d5fb 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -57,6 +57,18 @@ static inline bool range_contains(const Range *range, uint64_t val)
     return val >= range->lob && val <= range->upb;
 }
 
+static inline bool range_list_contains(GList *ranges, uint64_t val)
+{
+    GList *p;
+
+    for (p = g_list_first(ranges); p; p = g_list_next(p)) {
+        if (range_contains(p->data, val)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /* Initialize @range to the empty range */
 static inline void range_make_empty(Range *range)
 {
diff --git a/util/log.c b/util/log.c
index 90897ef0f9..032110d700 100644
--- a/util/log.c
+++ b/util/log.c
@@ -368,18 +368,10 @@ bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp)
  */
 bool qemu_log_in_addr_range(uint64_t addr)
 {
-    GList *p;
-
     if (!debug_regions) {
         return true;
     }
-
-    for (p = g_list_first(debug_regions); p; p = g_list_next(p)) {
-        if (range_contains(p->data, addr)) {
-            return true;
-        }
-    }
-    return false;
+    return range_list_contains(debug_regions, addr);
 }
 
 void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
-- 
2.43.2


