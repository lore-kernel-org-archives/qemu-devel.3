Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C49C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xw-0005J6-LK; Fri, 01 Mar 2024 12:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xu-0005I3-PY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:34 -0500
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xr-0000Xc-GP
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:34 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 36C6E801514
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:29 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 42644800FC6
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:28 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315188; a=rsa-sha256;
 cv=pass;
 b=bS8dVBFV4a8KnLxYhB8wSC06PQPy6T5Ow/twy/45jTR2qSNkRjjaA/kwL4CrjVMr0oSI/J
 I/lehyjY140AQy/P1jcUpV2wOdGtEABbcupVzYNP837t2V2VgZMCeVpxnyXIMC/8RFoJAO
 F5LDMJ3OdoEn1XnBCv/VEz/RyNXRvcTXtva+K2sVTCmMaSNhHmz7S6Mia1NGusoOIhJoGR
 Vj1VsgzxqP0QMrGEEAb3ErfiZdlNaAW7zfaLzPaP9ffsa2h/UtUnT5DxSM9WwranpPq1zE
 pYiGKEGHL4jAF4uVKdvVYAN70ibeAvi8vgh668P1z4lYXlBcXrmSIBZvgUv8cg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=ckyDvUxj1zxZs27PAO8n1Ocnl8jbS4RRgALTBGi+/So=;
 b=rPvOjbFCXeaL4+b4I/XMn2/vWygN+89B0oYzYWD4ZgG2ccGe6IHQQBhc22Qt58JHj+i7lP
 45CPeG/2UN0/LJKpKusfKIZMmLey0M9fVQR/P0mxOnNk7XsDQsghNs/n81C9D9MO6KSv6T
 +UIO9WGVQmwZH5TSE+IyiHV8+uuBjCzJZHdyKWOdVDLKV6fN0VizZLZso4FC5dEkQCmrqi
 dLO5V/thLIrraqNh2C1iItv3J8WWsphW1lAITeT+a8lYrwhJ+g99Je0An8P7oLEUAIBn/P
 Pqiyp54isN5k7DOP45PWiv/WWFr3WX6jIZqgof5JlpAJQwuvbe32nKfQefFkAA==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-lc9cj;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Soft-Plucky: 55332b4a4f7d7416_1709315188786_430695244
X-MC-Loop-Signature: 1709315188786:581606334
X-MC-Ingress-Time: 1709315188785
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.227 (trex/6.9.2); Fri, 01 Mar 2024 17:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315160; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=PFZqw39QRK/hSgJPFGhAu+fNcmOc1PhyeeZGWfk5M0LrjaKUMIztEvJhFQLyV/gBPmpTxe5Z61Qaj
 RmrZQQzMA8GVV8Q5IjtgPnKKuzZwjLrBFoO2eCJxnhMk7YqY1KKsYbtTPXgXMpApys79ng/7FEntib
 4rv0MuXK13jrjK7NAF2SlPnNxpM9j9k1/aqotrCOLTuNtlHT2XgnbH8FoyiTGbntjxmglOevZVrcpP
 hnumYOUMUndekDS/vy7saQKGIPgClCYf3ZhAvegX27pzWsBdNudGO5FMyO47jpC+V1o1Ygh9cISXbt
 rU/zjlQmDHEUoy05f7TRASu6I+fwp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=ckyDvUxj1zxZs27PAO8n1Ocnl8jbS4RRgALTBGi+/So=;
 b=RYG76jqBLnOr8Q1B7QbvJHe9AUvLyxiu8QIr1OddmD3S+5kH0XX5aWRhoaSdZrUs3OWA8cmwfvDRE
 PvuHRsIUH1rMVGRqErRbikGAn+LpjcAan3ehlppHmnPj3qZssNvmgoxJJFEvvxJ69L8tw49HBV7sv2
 4CpElxjl85UDT7N7pOr4jY4SNe9Ui+Ak3k2QrvL7Ixku3znVjX4aYoTr23pmJyVy0h4Vydr2wcGXBV
 bEKKy/nkUqEf+pA1+PHYXhmU+nS2oT6VMXfqP10vtEEpNFLyQzXz5SbN1suO3CgOUmSdiRuEhnbdGW
 qnTF263ALGfLrCjj3UDpd3rMPhbs+9w==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Zl6mXkUB; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ckyDvUxj1zxZs27PAO8n1Ocnl8jbS4RRgALTBGi+/So=;
 b=m2a4aLqVDnpapOB8YikrH0ovq90hId/auWIRbdY6ysyHNjL8j6yUW0lrVh/CccEUiuB5gglXkOszE
 UV2nOgli6ucf2eoubxA0GIqM1zwm6EWK9xPyJUavZlyshNODhlbJNG1bJ3MvLiMuCypfoZym+Z3e7o
 WDAUWCe8kzDQ+8MA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ckyDvUxj1zxZs27PAO8n1Ocnl8jbS4RRgALTBGi+/So=;
 b=kEn2FaTD1oMcuQQD4RwDgxDoffRmwvRJXXG8RMBDgOLKX3jWVWcw4FJrIQhrGt6Sa8fbJQvqeoepG
 2d2L2IjCIivtMhyqrCLUrC9mrZItxCVjNywfHXX8f8vFpZsmagZ6ykhPhm7cd5LTeBQGZOKTEi2vjP
 yD6Vw77BWaCExioNV/7LYlHqns/QUya7HpdH3KvItTZ8wSRayyzaLdwUM01Gi7n2nSJzxPs2oBDMOy
 5occkwVJmbqK0uwwXtjq/KNs6347b0Dc66ULJ84IPIkM3UEt7WISHbKPQfAp2ki2VItoQf/XIIAreh
 A7XZ+zvr9pOE7WCm9R2KRyC37ePamQw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 8dbb11fc-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 8dbb11fc-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ckyDvUxj1zxZs27PAO8n1Ocnl8jbS4RRgALTBGi+/So=; b=Zl6mXkUBSuZHawGP6RpaN3KCrN
 VzkS1ma4k+R7Yr47BHbLDkubRs9iqx1s796pq+WFYupJxNXdMStXzSg769Qn+zbwJWVKHqbek6sIB
 9NIdau4uEkwr3Lb0f3P/pA5BCkM5D45Na5s8ALdSUPdafjMGvnr5fQyOWJIjf7k8J68i5c55lA1aH
 qdlIFmCFrnwbqXfiImsujLZ0cTOE4BXXXreCNktqtij0OPQebNP6LCru1sXaHWI6fO21wOsXg4/te
 D9AloLhSzvqiX6Zto2f/Wr1tMDMuUffJMkMGBCsW3vCppdxZ9+qHuV/ygxwCmoyCW3p3/F3OmGytM
 sFzmH3kQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xf-000bs2-0d;
 Fri, 01 Mar 2024 18:46:19 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 01/12] util/log: convert debug_regions to GList
Date: Fri,  1 Mar 2024 18:45:58 +0100
Message-ID: <20240301174609.1964379-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
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

In preparation of making the parsing part of qemu_set_dfilter_ranges()
available to other users, convert it to return a GList, so the result
can be used with other functions taking a GList of struct Range.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 util/log.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/util/log.c b/util/log.c
index d36c98da0b..779c0689a9 100644
--- a/util/log.c
+++ b/util/log.c
@@ -46,7 +46,7 @@ static __thread Notifier qemu_log_thread_cleanup_notifier;
 
 int qemu_loglevel;
 static bool log_per_thread;
-static GArray *debug_regions;
+static GList *debug_regions;
 
 /* Returns true if qemu_log() will really write somewhere. */
 bool qemu_log_enabled(void)
@@ -368,38 +368,36 @@ bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp)
  */
 bool qemu_log_in_addr_range(uint64_t addr)
 {
-    if (debug_regions) {
-        int i = 0;
-        for (i = 0; i < debug_regions->len; i++) {
-            Range *range = &g_array_index(debug_regions, Range, i);
-            if (range_contains(range, addr)) {
-                return true;
-            }
-        }
-        return false;
-    } else {
+    GList *p;
+
+    if (!debug_regions) {
         return true;
     }
-}
 
+    for (p = g_list_first(debug_regions); p; p = g_list_next(p)) {
+        if (range_contains(p->data, addr)) {
+            return true;
+        }
+    }
+    return false;
+}
 
 void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
 {
     gchar **ranges = g_strsplit(filter_spec, ",", 0);
+    struct Range *range = NULL;
     int i;
 
     if (debug_regions) {
-        g_array_unref(debug_regions);
+        g_list_free_full(debug_regions, g_free);
         debug_regions = NULL;
     }
 
-    debug_regions = g_array_sized_new(FALSE, FALSE,
-                                      sizeof(Range), g_strv_length(ranges));
     for (i = 0; ranges[i]; i++) {
         const char *r = ranges[i];
         const char *range_op, *r2, *e;
         uint64_t r1val, r2val, lob, upb;
-        struct Range range;
+        range = g_new0(struct Range, 1);
 
         range_op = strstr(r, "-");
         r2 = range_op ? range_op + 1 : NULL;
@@ -448,10 +446,12 @@ void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
             error_setg(errp, "Invalid range");
             goto out;
         }
-        range_set_bounds(&range, lob, upb);
-        g_array_append_val(debug_regions, range);
+        range_set_bounds(range, lob, upb);
+        debug_regions = g_list_append(debug_regions, range);
+        range = NULL;
     }
 out:
+    g_free(range);
     g_strfreev(ranges);
 }
 
-- 
2.43.2


