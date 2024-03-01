Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA1EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xx-0005KQ-QV; Fri, 01 Mar 2024 12:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0005IV-6U
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:36 -0500
Received: from jackal.cherry.relay.mailchannels.net ([23.83.223.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xt-0000Xp-Mv
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:35 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 3ECBD2C14BC
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:32 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 886D72C0DAD
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:31 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315191; a=rsa-sha256;
 cv=pass;
 b=4lidzezoFL8tyQOlRsmqBX8/3Tj5pXXAehoqU9q1d+4rwhJdLTh6TrGOZoXeUbm3QJoulp
 Q/Wj65r8KZU0FboJA+eo8cB1irJcQZC/uLPa3yzdx/ExlOed9RhXLvP19XHtLlzXQrrK1O
 tl65C4DgoBWg75SLqQklHrtszyNviKEa7XFWDjgqfG9k93BuT5a1TgbJ+o3KljBPogXjN4
 AEssV+3I66Z7T1e+hhm7TUJIhUcy7TLLxKQvHrn1ZQ9sn9my08sDKwkWpsWy71jtcwFgae
 r9JZJCuLgk3JF+ug8FwURss77fIn49bcE9CmiWmdpKChsSyjkEKzQy5dLJbT8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=RKHlFYQEvFhYMO/SO8aNWCGjXelzy2FG8sU89hTJDvs=;
 b=GXESp/3rIUaqI3+VljMYjfIhYIRrc1UV0U6IjVvCUW4cRdVd78M7BMtexm+L7V6NKzFK9Q
 v/YZxvpusAXYs7pczjt4r8GvbjWuizdajpTl/R32/Eu28eXf+YvGOttuXUZ+tSLTQIQPIv
 /m+5sKNdXGsO0cfSd5soKXTBKPm9OnyS8mpGxaHis/lsGhnmWDgALmwS4xcLxw3lqG1u4V
 6Rm+r40b8s6ZU5dM2NWHPGmufavsR1rrdkcB7oW2Ssjqe8R+AH5N8HDeTpb3ZZjuAbIyts
 u+uVw1VmAs34RhgulVVLOfG2uw/fdOujqmx0ANMd3Q/AdsmqMDIbhVQAVlfURw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-2hzk2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Macabre-Robust: 0d0f432d4f071f35_1709315192059_589722710
X-MC-Loop-Signature: 1709315192059:3960506157
X-MC-Ingress-Time: 1709315192058
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.142.242 (trex/6.9.2); Fri, 01 Mar 2024 17:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315165; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=TXeUXZfq7NbPXOXlyfwKO0WmHXuIYhvzMH679f8amDDOMh5z17pDhy2YE5C38FoVMVgaEdLkuqPXJ
 GnvgP57atbglzHaxJUIkdSlbjFsWvFD17mPwax9sCfm+QZ8IfKMKCgB06vYcWPMXw3sqDSFamNhw3i
 C95x7HoSr+O3k79ME++3Mt0FisnwVRj622ioP8ZwQ0rpMQJ+yTerGg5KB5vfUqwKOC8s5EbsADJpND
 gFrIYuGfnyCpVphlh+SSsUfnilxE7Hu/2Tgq3r1pgW0KeoZAPA1eDhJQ+BtRqAEDu+2yYG1adb6wo7
 iJYH33FPmmk7v+1JIhTZ/6q8Df70P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=RKHlFYQEvFhYMO/SO8aNWCGjXelzy2FG8sU89hTJDvs=;
 b=lCtYwg1uBAGmT1Q4QoedWyonTf4R9894oQK/M2CR9buXk8aAVp4YH9yG0EwfazRfNONMSleGIUnIP
 EVMWcLeiA/B/fCp3zGKSC1D2A5rGQed7A35AB//WbWRa9fwbD6J5BcDGXTAHDjTWxnFmW65U2IatJr
 AZlhuCdfoM4j7D9q5WLXd3ef3iv6rLGW+4Sw0e5l6jhSoQcF3oI0k4xUFz4b5nanq5+mCp1fMGoT32
 B/inGCvdKT2bn2j09MHSAeyPgJQyyVCLLzE6XrK/0fqkHyYDj7/jl0iCWjQMsbJ4xZMee7t1P86Gtc
 ODEPRGfMOnWzd8RYXsUsyrR77Gq/9/g==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=b196JUsG; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=RKHlFYQEvFhYMO/SO8aNWCGjXelzy2FG8sU89hTJDvs=;
 b=OgFa9V+l9KnOpQN0DvVob7DiMnCoXRLlUjxr/z9KksGYt9s/2pWIG90KDyHN4Q8wL4p9QtRY0fYXv
 A/erXH10ktzrq04reJgyjVY8WjhQX47misxn5zMbi8tdFQ/QVBlk2dH0D/UnfYP2ngPD/8/N6WOSdD
 G+HZaFpaTmG59zeo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=RKHlFYQEvFhYMO/SO8aNWCGjXelzy2FG8sU89hTJDvs=;
 b=dzDbJNEX9AdUDfVDwSzXQbqrXMniv6cQKJeAdgPJzAR5HpEl/nZtX4eMpGLMeGcakttG1iT/e7WoC
 XUxT1EScyrDeukIH3jWGtPcOnkkOhUbN32VBFMYFLBK/FVpp/lFDyg7dQIOEr3Jjf/buXC0HTYIvYS
 tCJGUA01ysRqzqLJp4PLRMfpV0R0JgCbCq6fQzkBMGsJV1f0rjyMUZyZMrRK6UarHXgO19T6NUiDcq
 yC4ULHGMVLsO/0ZVMHwQnqBjctehFN6drc9iKxyUj+0vP1M959nKJpv+TZZkwr60yjdyd17eOgr4Vg
 0rPFxTLnTOk5++X2JoZm5sxCSzWvGuQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 9112721e-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 9112721e-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RKHlFYQEvFhYMO/SO8aNWCGjXelzy2FG8sU89hTJDvs=; b=b196JUsGtXak3wJy9rX5JLFc1/
 EpgTLuvrP6aNlKZCJGrOKzE4C3LN5p7uT1QnH3GvH9R2Vm18Fv7B/0NAKtSV8tC8PTNNIuDgdFCZc
 7X5w84dOMKnxzBoG5Kxop/TkQ3wWG4MV4yTA78+onzY7aN04vTC9TzKaR9BXSqwMLvVPHDFiOwQOB
 KILRJfnoN2D3rIhA5M+FRVwbt/MfetN6se1YngV5vM253/mh7clXTW4C/ux5pTZqXvcis1aixIi8t
 soroB+CATnPp+XiuKih7WhlLx0t8/fkEFnxFBIBS+qz3eNZW/lRX0+Pwz6VbagtMXdkCLSefMg+Uc
 lPLvLzIA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xk-000bs2-2p;
 Fri, 01 Mar 2024 18:46:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 06/12] util/range: split up range_list_from_string()
Date: Fri,  1 Mar 2024 18:46:03 +0100
Message-ID: <20240301174609.1964379-7-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.95; envelope-from=svens@stackframe.org;
 helo=jackal.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Makes the code a bit easier to read and maintain.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 util/range.c | 119 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 49 deletions(-)

diff --git a/util/range.c b/util/range.c
index db535de9a7..8c463995e7 100644
--- a/util/range.c
+++ b/util/range.c
@@ -124,6 +124,74 @@ exit:
     *rev = out;
 }
 
+static const char *split_single_range(const char *r, const char **r2)
+{
+    char *range_op;
+
+    range_op = strstr(r, "-");
+    if (range_op) {
+        *r2 = range_op + 1;
+        return range_op;
+    }
+    range_op = strstr(r, "+");
+    if (range_op) {
+        *r2 = range_op + 1;
+        return range_op;
+    }
+    range_op = strstr(r, "..");
+    if (range_op) {
+        *r2 = range_op + 2;
+        return range_op;
+    }
+    return NULL;
+}
+
+static int parse_single_range(const char *r, Error **errp,
+                              uint64_t *lob, uint64_t *upb)
+{
+    const char *range_op, *r2, *e;
+    uint64_t r1val, r2val;
+
+    range_op = split_single_range(r, &r2);
+    if (!range_op) {
+        error_setg(errp, "Bad range specifier");
+        return 1;
+    }
+    if (qemu_strtou64(r, &e, 0, &r1val)
+        || e != range_op) {
+        error_setg(errp, "Invalid number to the left of %.*s",
+                   (int)(r2 - range_op), range_op);
+        return 1;
+    }
+    if (qemu_strtou64(r2, NULL, 0, &r2val)) {
+        error_setg(errp, "Invalid number to the right of %.*s",
+                   (int)(r2 - range_op), range_op);
+        return 1;
+    }
+
+    switch (*range_op) {
+    case '+':
+        *lob = r1val;
+        *upb = r1val + r2val - 1;
+        break;
+    case '-':
+        *upb = r1val;
+        *lob = r1val - (r2val - 1);
+        break;
+    case '.':
+        *lob = r1val;
+        *upb = r2val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (*lob > *upb) {
+        error_setg(errp, "Invalid range");
+        return 1;
+    }
+    return 0;
+}
+
 void range_list_from_string(GList **out_ranges, const char *filter_spec,
                             Error **errp)
 {
@@ -136,60 +204,13 @@ void range_list_from_string(GList **out_ranges, const char *filter_spec,
     }
 
     for (i = 0; ranges[i]; i++) {
-        const char *r = ranges[i];
-        const char *range_op, *r2, *e;
-        uint64_t r1val, r2val, lob, upb;
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
+        uint64_t lob, upb;
 
-        switch (*range_op) {
-        case '+':
-            lob = r1val;
-            upb = r1val + r2val - 1;
+        if (parse_single_range(ranges[i], errp, &lob, &upb)) {
             break;
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
         }
         *out_ranges = append_new_range(*out_ranges, lob, upb);
     }
-out:
     g_strfreev(ranges);
 }
 
-- 
2.43.2


