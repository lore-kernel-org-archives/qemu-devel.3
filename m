Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0CBC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xy-0005NI-Ob; Fri, 01 Mar 2024 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0005JF-QA
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:36 -0500
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xv-0000Xr-4b
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:36 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B88F336221A
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:32 +0000 (UTC)
Received: from outbound1a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 091643620D3
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:31 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315192; a=rsa-sha256;
 cv=pass;
 b=4O0pnmecDo6f6w248d0ypIbE+9PM7hnEApbwDGuR4GejT+em0M8ZOh0lpM9ulxPMdeOupq
 zzC0thl5/87HKPRsReS6ieLSMrIQeK8w3bZPw6nUHKV6VORrNVfATQwyQske4W19+VNHl/
 7KSVM7cdZTUiQau1bzD/rkhuc5vIJSAOrp9bZA+Wg373a5RBTI4PuT5TRrIQIBveWA/QcX
 IMjtsZ1fIHXndbg3DocB4QI1h8Ag+COt+b+hMOw19X3arQJd9F8ZF7Pn4iEG9tyKelnTZP
 CEFlENqSMvRdNlc4llsnYtZYtCIlbHM8uHUw3WAmh/kbnjc36H4qdfwUsXBKQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=suldy6Pm53qRnmnMjTrVoAOvBs33/kELVHo74PC4+Gc=;
 b=p0KBmWeg4iPJXuhWwiwGfZWmPDGhhczHI1njKoqBr0H6CsdMUVjuxflttN20cz6ePZ/2nV
 5bcGqnDtdf0pcqKWff4u4MRP14/OJd7cXx0ejXn3pcqPc72ZDWueq6t9Jt90WQ7AF3T2B5
 1MLQTrr6aXVD83J5f6ahiWOqnJNPhMZNTBJ2j36NA7Ie5048Shx/x5mqsMmu2lLmhq67F3
 +tJ/QYGoen5PMnbvLMMMdtJuNNDBL462KQ9dOYMt2KjO2oDM7GF2q31knw1Og82pFBGXnB
 l5oi1t1rZVtWze4ayMsmIlTGCwTCfw1utSqnAw+w+GOsEXjKSkzaRTqu9s5yIw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-tqm9s;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Cooing-Print: 097c24fc0ca33073_1709315192539_2281873587
X-MC-Loop-Signature: 1709315192539:4189527769
X-MC-Ingress-Time: 1709315192539
Received: from outbound1a.eu.mailhop.org (outbound1a.eu.mailhop.org
 [52.58.109.202]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.227 (trex/6.9.2); Fri, 01 Mar 2024 17:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315099; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=ONdFBcFDqDy33n+VwroYjdS6t68l82mqqF6dnZVbJp3MvX/m/70OwdKjEs2Bog6c7b53S0nfYCxpk
 gKJgttgxdxadxNRIIfqYOvmkM1/n4BZFEjpVb2Q2hmNwz4sSklooH6UpNkt1i0Z60GAiMRrZJ532i8
 /cBG1MGAvNfClQj2ryRZVwwMaaz6OJ2e8w6iHSLXbkxP59pGvijhLEkkCfsqbUNAZwogXcNCXPd15u
 iHBHvfHDrNtxzZlOaY8RDcCOerNAz03wuyDfJZhckGrKeheFuVKL4aITrJqx998jTy1pY7wMEIQdFl
 6SucBtI0aYMOgRo40zrffogZzVO9EQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=suldy6Pm53qRnmnMjTrVoAOvBs33/kELVHo74PC4+Gc=;
 b=rYw5B2TqrpoJS2oU8MPNoSkQM87NEyXc11BXeJAf652Yt+h38aI3zy8C7tBzNTGbvFhzspv0zvHeG
 SHJflt2IjjKrg7tGQeVTF5z3JEIMTkbE8jUtdbfuOHNj4yf2hfdOTVxA9YU445VgX/ZClC5k0P/5Rg
 5y6eEt0GT2A0hkw+WkBMke9QuugDuEai+TVUfp2hydoeh0CkDj9ph7mjXkV2ZCK4OcsMSrWDlEnMcW
 N2gxAPFCjLV6SS4tPycUuwAeLY+MmnAW3CAu1a+3BXy1ibC/TQtyGBfgAysSogbsa1mplm/NJ68cEI
 I/2Mz+bbVpeetSOjjKdGMCBfhMEtYlw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=ldM9/7FX; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=suldy6Pm53qRnmnMjTrVoAOvBs33/kELVHo74PC4+Gc=;
 b=FKTdafPYn35vXsfauBV77f6QmlNxMcfGtNj3AGtlJy6/fUL99aH9tFC2aKiqtau/zqfP/XLVa2/tN
 Qa9jwLr5ddxxZPSFHFRmvXlv2BhOo28LWdbomc+3OUr91pPKECWiIOlNY3mDDaEiMEbTdhGPqhDTF9
 kz6Jle7o7HRwpnyM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=suldy6Pm53qRnmnMjTrVoAOvBs33/kELVHo74PC4+Gc=;
 b=epNtBOzj5SnqZ5hPAd1qnENdyeYo1iEGiEaTh0beUezB+0/NrWc+6Vun+OIHvc7+JLcYHHxieMhwc
 EtxmTBjGtXQwVftOc1q26Asf1F7+8IMrNZ+J7lN6JKeWF5jBR5yiTiK1Cti2Q/nG7BhSNxyLb/486Q
 gFX/4kmiVDb8Kbm9L1JRj/khmvFbx6vAsYpZtyF+KboZERjymb//pK5Gdmc9CwfLg6ZfeuX5RKrZAg
 69HkYuA9daeDCvt9baaXXRhe406SshoTAZZXnrdrkFYIgGh8iOMVV4hvvem5iq45L6Z/2VJU3u5Bz5
 1+Quon2WYsjE1wYP8ufhTGuMUbp7uUg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 696857e2-d7f3-11ee-b66d-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 696857e2-d7f3-11ee-b66d-9b9d9be6ef2c;
 Fri, 01 Mar 2024 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=suldy6Pm53qRnmnMjTrVoAOvBs33/kELVHo74PC4+Gc=; b=ldM9/7FXpzwsTp40SajH5+8QP7
 9skIO0VH4KbUetj1lFD4bRL8poczpTJjK3giAcbSqDdhptRmC0EbTVEGu2UU5U1QVBaDJ4eg9QGgU
 ebKKy/asrQbuxg78T2hVaouFBbLnWPf46MRQvY8zzXZgmPs9cwIhH6omfc3oSn6Yj1ReB+7cXOyqq
 3Dlo34vKwucRkB8x8/JLstTdA+BesMgz4OmWSlmFAGd5sXvidRCDCGCnnlTaNMgD8w/8PCutyu9Mk
 nqqpkRtGjBiGBG3b6J2jsLbpQJ0KMFQUdr5a1XWByyaQw/lPLSx5C6KLVUuNE17Loynd3Qv8+7p1F
 +zh5mk/Q==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xj-000bs2-35;
 Fri, 01 Mar 2024 18:46:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 05/12] util/range: use append_new_range() in
 range_list_from_string()
Date: Fri,  1 Mar 2024 18:46:02 +0100
Message-ID: <20240301174609.1964379-6-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
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

Use append_new_ranges() instead of manually allocating and
filling the new range member.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 util/range.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/util/range.c b/util/range.c
index 7234ab7a53..db535de9a7 100644
--- a/util/range.c
+++ b/util/range.c
@@ -128,7 +128,6 @@ void range_list_from_string(GList **out_ranges, const char *filter_spec,
                             Error **errp)
 {
     gchar **ranges = g_strsplit(filter_spec, ",", 0);
-    struct Range *range = NULL;
     int i;
 
     if (*out_ranges) {
@@ -140,7 +139,6 @@ void range_list_from_string(GList **out_ranges, const char *filter_spec,
         const char *r = ranges[i];
         const char *range_op, *r2, *e;
         uint64_t r1val, r2val, lob, upb;
-        range = g_new0(struct Range, 1);
 
         range_op = strstr(r, "-");
         r2 = range_op ? range_op + 1 : NULL;
@@ -189,12 +187,9 @@ void range_list_from_string(GList **out_ranges, const char *filter_spec,
             error_setg(errp, "Invalid range");
             goto out;
         }
-        range_set_bounds(range, lob, upb);
-        *out_ranges = g_list_append(*out_ranges, range);
-        range = NULL;
+        *out_ranges = append_new_range(*out_ranges, lob, upb);
     }
 out:
-    g_free(range);
     g_strfreev(ranges);
 }
 
-- 
2.43.2


