Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F18C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6y3-0005Pm-3H; Fri, 01 Mar 2024 12:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6y0-0005OD-02
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:40 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0000YS-KQ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:38 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 54F382C1FD4
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:35 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id A8E4B2C20FB
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:34 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315194; a=rsa-sha256;
 cv=pass;
 b=laAKSyBWs37E0T5KDqUOzf5I+Vp+tItvmiPydN5DjBAvvkRZUeWLT74R9tiQ+H3Ge9hAcC
 X2aqgszH5wSUJyslziusbg/6EU1UkLudcKrgLUW8V0Cwwnh8Z/wDpCLYrB5ba0NVKu2rKd
 pxUXFdiouTp3nJmaIjGqJhQ6ABXOd+SNhb7FeHYi4thQ7QlIP8pqqVlE3ieJGlWKc2CGXr
 yszsat/AFNUxxkbkQFOJUHOiPGYnxq5VsnUSn6v0NtzO+3siy431ku/JJ59VkmJSjbJSIk
 Q8cBoP3OgUbgtQ+02dM/93E66fTU4VH28RzR7WcvV1Ajs1fepM1KKHBqHKAjLw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=6qa/ABrIzNFeQmtdkh5F2jlICj/NXHjn33dee2Z9H48=;
 b=CnIDGllk0PUqwkKjh6VfcBja4wfToSbsVj/uKG+U0EuzHoJJBAlPV3J8vwDhZ7kQFbl5YT
 kop4Wen/xuMHJIddmcfQKK8uvcxkWhFd74ZLF7GLcXz3gUp9QEVndN+nX/0rvC+p4j1zef
 1BEzgM9zPzPqhecJ/RDszowtS4Ha0dOrQf1jSqvjjCPjcaTIsPXyskvSxlcLCZxApXm9hg
 3zBHxm8Tvui+bkl1994L5bz/fTESGzio90wawLZA3D4FH5tSzVvMNc36OdVZbGVYCtsIPR
 7EpPhPH6cD9+rT0ZvpSK1YpoBYUtftJXL4Q3TDhFLmlff+lj5arP5EFKw0zbvw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-d4z79;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Whistle-Name: 4629c484205e85bb_1709315195182_1839156030
X-MC-Loop-Signature: 1709315195182:1736634380
X-MC-Ingress-Time: 1709315195181
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.52.242 (trex/6.9.2); Fri, 01 Mar 2024 17:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315098; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Qh1gDycCYdELK21o356rmV5Tm9Bai0YtO3euqgO1QO5sZofl8z55ls9iO1QqkWmCn9DdIByqRFk7s
 WKWyDauNd6YIIwgGTw7WXLkiE/TGwsVL9E3ZHh1jSkgccRW0svirtNycf5XXZRlh5y81Zyp0hvvM6z
 BLETqXxGBxnHES8wUj5Dp5QPJjG8OG7aTghmrMy0+1p/PxFPbz3Gt4oDItHpYMWJ5Wlke+ccZex9Iz
 WdwaUY/dM9bxagP7OGbUHKAp3+PhK5HK4za2eTeYAmzGMW4oNKO3lcEThb8Mmt/TXEbznSi/4OUM8m
 /sGEdkQZZN3SrKnMnReR7dAjBKhwqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=6qa/ABrIzNFeQmtdkh5F2jlICj/NXHjn33dee2Z9H48=;
 b=o5G1FOVyKpL49SO9LgH+/yNW8oHT2LVk+gz37XaEov9hU4F0vwBBF/JY6VNPvFwO3AhHJLRTFebT7
 992bxsf+fsdXWyMRf0TC+DUY4lxZWNwViZINyNPLo7UN5RMUeDIDO7OSUr8HfT5MSBlX4KllZPjla+
 YVtKG1f9GS6a9cT5A9BCwZCzy6Sav//dbaUJCnBywZucQ9MxnRv4SNzOtlKJAN9HLri3bRh5yobU3O
 Wa8BVw3S23Z1PuGjnDMNNK2OeQqIF3O9+nY8MeII6hr038DskXVEFJjmdvYWhW4ClbXgASLFbjsYAx
 P4rId7XIRp6Cj0wgeNmZpYuaSjUJADw==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=as0lzJGo; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=6qa/ABrIzNFeQmtdkh5F2jlICj/NXHjn33dee2Z9H48=;
 b=XJCL6aPMDKv3x1fkHAIUnGGr9p0ziS8asFZnF81juXXxvZn7+v9fi7VrpAzDsgEDHvoDBRhEAxo0+
 5CYEU2qAiMxs5xwQRNMi0aYbrjePyy4Oif8DJHwna4X7PlDSJ2M7bpMv5Ls4aVR502o6rlEUZH051o
 T7/X/tBivpEECVHg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=6qa/ABrIzNFeQmtdkh5F2jlICj/NXHjn33dee2Z9H48=;
 b=LquhqCVmLNmh1PcNZVRjeeId+t4oJpFcJnFjtRlFim7hsCJym21wn0CXP0yVCbvG+AcUNDMrRUtHW
 J9BI8jByct83oi96hIK0ub0+PRG+VlOY84o4tnKvX0Y+qD4AWUxVV0d2Fsuq+rtfW84Wi2MdynJ9cB
 5V7RMpy19681hqGbiSl/PEcC1yiUwgsiFaNRtwKvUb7QGd6b8PL7pzZKyfCOMwmE87RPparTxgM/fz
 8M6Q7USINx2YsenkL488HjbI+2wd9za3CLPjANxC61YaUjAvzXERofCff5BnhZX8/bhBB+FIDdKu83
 GGZoA7NfOWP5ZxpnY9ONUvjo3Jw/3wQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 68dd22f3-d7f3-11ee-b66d-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 68dd22f3-d7f3-11ee-b66d-9b9d9be6ef2c;
 Fri, 01 Mar 2024 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6qa/ABrIzNFeQmtdkh5F2jlICj/NXHjn33dee2Z9H48=; b=as0lzJGoPkMQXbZGj0fXfwxvJI
 bi1r6gg4MtrTvxNcMVOz3CtO3kPClxE5l4md3zfJEipJ+jNf6nOkjPnfG3/COK4m4Uah0w5Qaw8/z
 55uAWqgIu/IRoiKC82ucSla0ysaDAlbrDAdrS7UeEkW2PUJ+FbVJIZXWJJ5Xl9j8fwQhTTCCR9eit
 bLGAxM0iEgmCRqnbJ76HJVyjHrTeEE5D53qEuWQ1fbzUE1ORM+5eD3mF4Q/GEyQxXnpT4k9ix66/D
 hnIvCpx6hqLZQFqP0gQ/voP3ZI33Ps3KoG/iIt5EfZXyct14cj/B93/0FNO6aRlSwBXMIpp955oIs
 pI5ZfZZQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xi-000bs2-32;
 Fri, 01 Mar 2024 18:46:23 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 04/12] util/range: add range_list_free()
Date: Fri,  1 Mar 2024 18:46:01 +0100
Message-ID: <20240301174609.1964379-5-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
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

Introduce range_list_free(), which takes a GList of ranges
and frees the list and each range.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 include/qemu/range.h | 5 +++++
 util/range.c         | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 530b0c7db1..4ff9799d89 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -240,4 +240,9 @@ void range_inverse_array(GList *in_ranges,
 void range_list_from_string(GList **out_ranges, const char *filter_spec,
                             Error **errp);
 
+/*
+ * Free a list of ranges.
+ */
+void range_list_free(GList *ranges);
+
 #endif
diff --git a/util/range.c b/util/range.c
index bd2d0961bd..7234ab7a53 100644
--- a/util/range.c
+++ b/util/range.c
@@ -197,3 +197,8 @@ out:
     g_free(range);
     g_strfreev(ranges);
 }
+
+void range_list_free(GList *ranges)
+{
+    g_list_free_full(ranges, g_free);
+}
-- 
2.43.2


