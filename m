Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xz-0005Nz-Rv; Fri, 01 Mar 2024 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xy-0005LM-37
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:38 -0500
Received: from bongo.birch.relay.mailchannels.net ([23.83.209.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0000Y5-6A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:37 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 41753C396B
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:34 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 69A95C27E3
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:33 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315193; a=rsa-sha256;
 cv=pass;
 b=3m5wCWfqr3v1yw6g5rS96qKUsxzygKqKPoZGdzVwaq7lFUmR4szngAmszx9z84pMZ5nHI9
 mJPKfzUtG+L5UnmC5gzEvTQGBB3bO7iA+GmXaD+sHG8GhyxrWyrClCKNvgG4mmdqah1YIT
 3ZGiNnj6hNVYsQPz4CmCZxcDPpvkHS+kwFkfs0GS4jGTWmQMcX7LDRipPkMPDULsNQ5r4a
 qn6CoibejZU59cojmBx2ssho/NJOUHDJvgk+iPXgl7wh8e3+1MUAHdZahO3nVert3ln3ML
 XG6y6w0dQEGN8MQX8e7JRzHoPOdSdqEu4Im8gdcfK80EwKM12CzObscyNU0DcA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=bopqUPl5QO0pq8Rv2GfWUFdNI4IyEMDQCmogGXg31WU=;
 b=WbIwnU0YDnYic0dnaO4I1IwqleXfsI5MwZ8pHT6Lo89jzGY5CtO9Nfwo0psfmbFP9RvdIn
 mQiYTJKYiekFpByLA2HrTdtnpvHFL/Hbx6UxSHxDxpf7F9GPNj/RHtEufR6E6x8EmQoMjr
 pc8ziFcK87jIU5KiisLjFbmu1ldf5GIvz7YC1/zU+kNIINDksJQ/VfsIP7Es4MtI5K4Bos
 1BEVCOTCCpBNUxwMJ0tF3DPh62AapX13wU5f/l0UggYdAXSn5OaeDi/dwQ3m0+XvHWiL/e
 gmwteOBjYvGpTbpxrizZMOVGN/4adSqYoAEMSH3laRAQfSc2sm3vlmxCFE2Ung==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-rwchp;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Drop-Turn: 656a20a44026efb9_1709315193928_2351392444
X-MC-Loop-Signature: 1709315193928:3520662604
X-MC-Ingress-Time: 1709315193928
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.58 (trex/6.9.2); Fri, 01 Mar 2024 17:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315162; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=AyalXKN2aHmRdLp29xeAuRg8IliB+63Oj3quuJwMIwT+nXKg/Aw+ltqtYLY1lID0zmkm5B70yEqrs
 oy7ZB5xHJCRbE6/G+ph30/vsgZTG76e+tqhCRtfVYfqWwD4vtqnuFiCFSwQrA77/UwN0rWkCd1o7Us
 J/ZG2JenP5ZD0ZC2otWTlBa9Vusw24i8HqVNXuKXofnDrjeOnI/u+rteVsHQ4xB1GyyZ4zEeCis5TR
 tfIVS4+l7ZHOqBU5vmofMdowHdBdyXRZ4lUXpVI9YyvtYYkYRM/R/eA+dBtm9KdWCQKXnqK8tbqo2f
 8BcQNT/cbX4XbQPgyqqduc1vPRFHAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=bopqUPl5QO0pq8Rv2GfWUFdNI4IyEMDQCmogGXg31WU=;
 b=IavVtoqX7WyRExbN8h5pLdiBaT8Ar6kvGIcntS4Wfwhz3YznFs1gbhMjp6VnhaI+bOyPn6YjTgB2C
 arC+qbhPnmkM/Hk+3RUBuaroBu2LA5Bf0HGKtUwBwuvFNyTVnbC5HcvCH/4lOPhmwMV+PTG/AyVfgR
 79xngMPPqaqkMwHTq4rm/whKsjZ3OrAVq0KFNYnaX6QNd3xyXI1o56fxXPuIxHArVI64okoTa+36TS
 yN3mtSf7fKFA+o9+/coTDmWa/gVjl3hj2a9bfqGBauPZ3rTQrdaGehrL/Xi/aAjiCzTDq62LumckIj
 wpe05DZ72lF4HKQWi72AoaRyOYn5MSg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=TUhFu2Hs; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=bopqUPl5QO0pq8Rv2GfWUFdNI4IyEMDQCmogGXg31WU=;
 b=gxHfPJ8r7sXRfU2SxrpJC/znatZ6IuvdbPDejdPax6t99JIEetJQCtz+/XYcyV+ZrQoc/4DXkCrNZ
 BGu7LFh2NIRsrAfyJUaDrWYX+BBnEYIgfgRXz+ffbeLMY+jTRhS/Iy8cD2OsZg08HGaFTTU0la7kzX
 hBgf/VZfG9Ppx2as=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=bopqUPl5QO0pq8Rv2GfWUFdNI4IyEMDQCmogGXg31WU=;
 b=aLsjPpmTOrFMxGm3wCMtrgT5FzTEOPg2bgJaUbuVWYWGG0M2ptkwpTcl/sRujbcSTwY8C9JkmfaCU
 ngfYtWmnMQJXmHJFnSvbcfcaubJr09fL14QaKE4ztqhVt57E0dHhogkazgdvhyFV2vacYL+GknqAKJ
 77SNQg0XIG7m6boPNK0VqWVbI/2DJIj0HskRI3c5ndkudCnEcvN4vwSw5PRCCzq5sVTtqjBN8p47Q1
 BoWiTeQT5jyBsDpSoI+uMtwPISPvSec9fev17Diomvf4UUGdUx8BH8Au1Mf9k2CobexOaz42rnYeqp
 nJDxM9PZCAv7BcF5zCNyC9kugcvJm/Q==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 8f443cf7-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 8f443cf7-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bopqUPl5QO0pq8Rv2GfWUFdNI4IyEMDQCmogGXg31WU=; b=TUhFu2HsvMkAGL0R8IpobMXIxG
 jQ1gorrtLcVmLfl+FA+bdIKsZI9dCDXCbIe2wDSSWQoHUBBpDzHuIGU2dt6i32sbR1WH7h2umlv8d
 3fjiTSMv6Zj/V1iBmrZyG+GZCoFCIntozDPVnHvWh6vCW/B7ImcEx+cKTWMW38cPMBfQBKIzTDNHQ
 eAmyajkFLBLFUWKdno/mxRE1YNrfA5wf3IGsBRXfmZyz34L4hbyxut2lySv3v8RC14z1i6KGhJHus
 7vwiUpgN2FeBoZokpJ1pzoI2QECOcEgJJKU/sXCnTmJ6GFyy38DzZIMTzTsVHYrZBBx98PWUeOeNe
 rI3PizGQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xh-000bs2-2i;
 Fri, 01 Mar 2024 18:46:21 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 03/12] util/range: move range_list_from_string() to range.c
Date: Fri,  1 Mar 2024 18:46:00 +0100
Message-ID: <20240301174609.1964379-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.21; envelope-from=svens@stackframe.org;
 helo=bongo.birch.relay.mailchannels.net
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 include/qemu/range.h |  7 ++++
 util/log.c           | 74 ------------------------------------------
 util/range.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 74 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 205e1da76d..530b0c7db1 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -233,4 +233,11 @@ void range_inverse_array(GList *in_ranges,
                          GList **out_ranges,
                          uint64_t low, uint64_t high);
 
+/*
+ * Parse a comma separated list of address ranges into a @GArray
+ * of @Range entries. On error @errp is set.
+ */
+void range_list_from_string(GList **out_ranges, const char *filter_spec,
+                            Error **errp);
+
 #endif
diff --git a/util/log.c b/util/log.c
index f183ea4e4d..90897ef0f9 100644
--- a/util/log.c
+++ b/util/log.c
@@ -382,80 +382,6 @@ bool qemu_log_in_addr_range(uint64_t addr)
     return false;
 }
 
-static void range_list_from_string(GList **out_ranges, const char *filter_spec,
-                                   Error **errp)
-{
-    gchar **ranges = g_strsplit(filter_spec, ",", 0);
-    struct Range *range = NULL;
-    int i;
-
-    if (*out_ranges) {
-        g_list_free_full(*out_ranges, g_free);
-        *out_ranges = NULL;
-    }
-
-    for (i = 0; ranges[i]; i++) {
-        const char *r = ranges[i];
-        const char *range_op, *r2, *e;
-        uint64_t r1val, r2val, lob, upb;
-        range = g_new0(struct Range, 1);
-
-        range_op = strstr(r, "-");
-        r2 = range_op ? range_op + 1 : NULL;
-        if (!range_op) {
-            range_op = strstr(r, "+");
-            r2 = range_op ? range_op + 1 : NULL;
-        }
-        if (!range_op) {
-            range_op = strstr(r, "..");
-            r2 = range_op ? range_op + 2 : NULL;
-        }
-        if (!range_op) {
-            error_setg(errp, "Bad range specifier");
-            goto out;
-        }
-
-        if (qemu_strtou64(r, &e, 0, &r1val)
-            || e != range_op) {
-            error_setg(errp, "Invalid number to the left of %.*s",
-                       (int)(r2 - range_op), range_op);
-            goto out;
-        }
-        if (qemu_strtou64(r2, NULL, 0, &r2val)) {
-            error_setg(errp, "Invalid number to the right of %.*s",
-                       (int)(r2 - range_op), range_op);
-            goto out;
-        }
-
-        switch (*range_op) {
-        case '+':
-            lob = r1val;
-            upb = r1val + r2val - 1;
-            break;
-        case '-':
-            upb = r1val;
-            lob = r1val - (r2val - 1);
-            break;
-        case '.':
-            lob = r1val;
-            upb = r2val;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        if (lob > upb) {
-            error_setg(errp, "Invalid range");
-            goto out;
-        }
-        range_set_bounds(range, lob, upb);
-       *out_ranges = g_list_append(*out_ranges, range);
-        range = NULL;
-    }
-out:
-    g_free(range);
-    g_strfreev(ranges);
-}
-
 void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
 {
     range_list_from_string(&debug_regions, filter_spec, errp);
diff --git a/util/range.c b/util/range.c
index f3f40098d5..bd2d0961bd 100644
--- a/util/range.c
+++ b/util/range.c
@@ -19,6 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/range.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
 
 int range_compare(Range *a, Range *b)
 {
@@ -121,3 +123,77 @@ void range_inverse_array(GList *in, GList **rev,
 exit:
     *rev = out;
 }
+
+void range_list_from_string(GList **out_ranges, const char *filter_spec,
+                            Error **errp)
+{
+    gchar **ranges = g_strsplit(filter_spec, ",", 0);
+    struct Range *range = NULL;
+    int i;
+
+    if (*out_ranges) {
+        g_list_free_full(*out_ranges, g_free);
+        *out_ranges = NULL;
+    }
+
+    for (i = 0; ranges[i]; i++) {
+        const char *r = ranges[i];
+        const char *range_op, *r2, *e;
+        uint64_t r1val, r2val, lob, upb;
+        range = g_new0(struct Range, 1);
+
+        range_op = strstr(r, "-");
+        r2 = range_op ? range_op + 1 : NULL;
+        if (!range_op) {
+            range_op = strstr(r, "+");
+            r2 = range_op ? range_op + 1 : NULL;
+        }
+        if (!range_op) {
+            range_op = strstr(r, "..");
+            r2 = range_op ? range_op + 2 : NULL;
+        }
+        if (!range_op) {
+            error_setg(errp, "Bad range specifier");
+            goto out;
+        }
+
+        if (qemu_strtou64(r, &e, 0, &r1val)
+            || e != range_op) {
+            error_setg(errp, "Invalid number to the left of %.*s",
+                       (int)(r2 - range_op), range_op);
+            goto out;
+        }
+        if (qemu_strtou64(r2, NULL, 0, &r2val)) {
+            error_setg(errp, "Invalid number to the right of %.*s",
+                       (int)(r2 - range_op), range_op);
+            goto out;
+        }
+
+        switch (*range_op) {
+        case '+':
+            lob = r1val;
+            upb = r1val + r2val - 1;
+            break;
+        case '-':
+            upb = r1val;
+            lob = r1val - (r2val - 1);
+            break;
+        case '.':
+            lob = r1val;
+            upb = r2val;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        if (lob > upb) {
+            error_setg(errp, "Invalid range");
+            goto out;
+        }
+        range_set_bounds(range, lob, upb);
+        *out_ranges = g_list_append(*out_ranges, range);
+        range = NULL;
+    }
+out:
+    g_free(range);
+    g_strfreev(ranges);
+}
-- 
2.43.2


