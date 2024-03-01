Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0505C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6y3-0005PQ-3V; Fri, 01 Mar 2024 12:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6y0-0005OO-T4
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:40 -0500
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xy-0000Yt-6J
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:40 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6B93B142AC3
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:36 +0000 (UTC)
Received: from outbound5d.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B4557142846
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:35 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315196; a=rsa-sha256;
 cv=pass;
 b=zn2V8JZAhgaOvWMkgutFeUBAxVPwV1wVyUQ4wet+WYpro2Pvh5puRYRChKiH9GnNbymAo7
 S8Qb0bB9XCdOAjJOL1LaY8dZm8NQPXaZ5X9sh4PfGSIL3435aMVXmarjNiEGy+EeRJkZtt
 eD76pzPPEMHvjsMvyokn0ARhoPuWleprJFHuXFgzxUlzLCdUEuyuTc9EsGqS2E0vJnIQUl
 2zwQdk4YAEsl3NqwnZ+d210eGX6N/2NCa/+aqr3l0dfivTLdIpN9OGswf1OOP2143Nfpaq
 XtuAt3VM2nBDbtEy5e1M6/Ix8sg/odt15oNR903/BjYxZFDsbajLQjaOrPtEqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=lF1TQZ6vVTcGlia7ncIRF5s8q9DWQ/f7QQ+9EL+vjCc=;
 b=5y8C2rzuuPvJQ2Wg3BCMcDcCelDjnmmcqtRM7uGIEwuDYQ8opahp2XwCPtxrzeaCBDiU5I
 MFqTFl+ogdkUhoDw91yH5dxH+9jVXsuio8zfg1v6G8CdHcxPqh0xuPKvMLBNhS+uKF4XZ/
 TGIdlsCt01GZEbkhSVDoqK8k1URJV+QRthLSX5VmOH9nZU9vOzTSleJvBK4t8XdM+Fi52z
 aIIg7gGCCawmyrnmeAxz2MzUVTtC5Q++zmQ7xeeNLIbEeqIwcx4BaRwMjoP5DDnAy9jdFB
 Y7WHYSmfltFn1h1Z2O/PoIDMzuUkP33xaLUQS+l7D31Dc/yXXfpkmHFWDVoLtw==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-jmwb2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Tangy-Shrill: 64b9ba6b20b56e44_1709315196260_3703453385
X-MC-Loop-Signature: 1709315196260:775692329
X-MC-Ingress-Time: 1709315196259
Received: from outbound5d.eu.mailhop.org (outbound5d.eu.mailhop.org
 [3.121.156.226]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Fri, 01 Mar 2024 17:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315169; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=dC3UPaTCcZW/yUcPbkU0PESgHyhKgsWYGXkmmn+cgAjnCDgQrU94/K2wHjEc+iSfi5MlaCr7Isp8K
 ZspY/X7scE9PJo7315nEYMQdS2JciAcj0xjG+bHjc345Hdo8b+gKtBAieajo72rh4FS5uDVwUyPq13
 dgZghf7FPuX1u/85hOVH0Pu9I+cYTvtLmIdvnHHPpVMnCR/DsrK3clkkJlxeKMU7swtkDDPZ9DhTTl
 Cw3Wf5z+eg7aiX6YEZoir+pbCQ6hljypHc0UhecFZDmHcPLijA9JaUW7i4sEtidEKmPJMiQ4BNJFFM
 S2ACceOv0EfyYXGftIcxFHjHcwnBceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=lF1TQZ6vVTcGlia7ncIRF5s8q9DWQ/f7QQ+9EL+vjCc=;
 b=BNvhfbpg5PV6smKojuhR2qd2BXQYZFsjgBJM8Y9DT2PgR/BlNBDZyr6xiRb4QGb1DNR97A9B+UVoB
 GvTgVBY4TC7rvKePL/RW6WDb8WkJhYjd85RxhkVQRLoNS70KnARqpZHJv92KeoVImCILchagdEQOXK
 tz1L1oJuIBEITcC9zTiGzTHPAr8TfncqUMjq14+dwgZp/QTFuHoMflCxLi3OVANPeLR+1kkjp2qF2y
 ZaZ4gNYmJo23si6lHAFdS5Jf0tTEETF3O+1jER3EBDXbuTf+4tNqWP8BpF/ZCO9VemkwTwi+wxkNpp
 KKBZo/v7Ed3ptnPTA3Mrzbzc5i9mj7g==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=BS1vLZa2; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=lF1TQZ6vVTcGlia7ncIRF5s8q9DWQ/f7QQ+9EL+vjCc=;
 b=NhnL8g0buQct0VKx2jcN3QyybvUiFYnpmZaglh6/tAuxvp+8YZQedWRdo7a9jp2AVGuqoI8P9QMDw
 ePLpO5YMX+SJPbhqgFvawgD+8Bf55+5XM6fVdNeo1Cp7NkXcsMKFlLvZZKk9ddX3Yr1sGE551JwMls
 YaWWdjPOwa9C5YAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=lF1TQZ6vVTcGlia7ncIRF5s8q9DWQ/f7QQ+9EL+vjCc=;
 b=t/YCMnMyYV62/Gc/VirF83TIuJPk29xKt6TDFZ/Abx5jw96yIzY81bMVvRags4MW39g6e89DPhYo1
 Qohgo1Hrhul82+1PUphJA5UebzKij2WdBgck7trqRJ9VeIgoUsgnZZGw+mPreUK4VU1dS4Zgda8kxA
 fVBQdQXD5WVa06WDuiTiPGnHXMxnRy9ou42WRDXszq0XBfOGmtm3TLS6i9AUlDfLkfedmPQoDsZemx
 7oXPdVl6DAFXWwI1kVV1ZoNsR73RWyhN4ajbTy4rCm11PrSru2cS2TJmWTvH9Vd+mwwkndqZQOdJCd
 D51mU3KncWhne8jGv9r4KYQJoiW0ssA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 93473682-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 93473682-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lF1TQZ6vVTcGlia7ncIRF5s8q9DWQ/f7QQ+9EL+vjCc=; b=BS1vLZa2vMoh/w1V1MuAwLX2cS
 DlMNKtcR1OQ3QtqZEcfg48DkJdVsHuVYPHE4yzC+F8JbcSUngw4ApAMXOTdj9FadQtqAMrPOy/8Yo
 +KXJCjNMdHIBjVIiG7qAcBIj8fkTYXIBCgv4Z78EOQPpAzmyeGaij5XTMRQtvLDEzD6AOmSoNO6gT
 DhBgFjdEdRwWA1VpZ0l3o+Nnoez4SDB9rClZS7Hr/XXgJ1h/GU2aU5ZG6vtWt03uG4fwBc66wvFK4
 1lxf63iV5+Ijeib+/uS91QCXXVb6JQYEyom2yFoVR+MD/UbaAbi+xlyU3KnaDiGIf4okZ95WKQqa5
 uTRpv9AA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xo-000bs2-1o;
 Fri, 01 Mar 2024 18:46:28 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 10/12] plugins: add range list API
Date: Fri,  1 Mar 2024 18:46:07 +0100
Message-ID: <20240301174609.1964379-11-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
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

Export range_list_from_string(), range_contains() and range_list_free()
to allow plugins to parse filter ranges and match them to avoid
reimplementing this functionality.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 include/qemu/qemu-plugin.h   | 41 ++++++++++++++++++++++++++++++++++++
 plugins/api.c                | 18 ++++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 3 files changed, 62 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5839feea4d..4910a63d70 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -765,4 +765,45 @@ typedef struct Error Error;
 QEMU_PLUGIN_API
 void qemu_plugin_error_print(Error *err);
 
+typedef GList qemu_plugin_range_list;
+
+/**
+ * qemu_plugin_ranges_from_string() - parse a filter range string
+ *
+ * @out_ranges: a pointer to a @qemu_plugin_range_list pointer
+ * @filter_spec: input string
+ * @errp: @Error string on parse failure
+ *
+ * This function parses a filter specification string and stores the
+ * parsed adress ranges found in @out. On parse failure a @Error pointer
+ * is stored in @errp. The function accepts a comma-separated list
+ * of start and end addresses or single addresses.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_range_list_from_string(qemu_plugin_range_list **out_range,
+                                        const char *filter_spec,
+                                        Error **errp);
+
+/**
+ * qemu_plugin_range_list_contains() - match a value against a list
+ * of ranges
+ *
+ * @ranges: a pointer to a @qemu_plugin_range_list
+ * @val: the value to match
+ *
+ * This function matches @val against the adress range list in @ranges.
+ * On success, true is returned, otherwise false.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_range_list_contains(qemu_plugin_range_list *ranges,
+                                     uint64_t val);
+
+/**
+ * qemu_plugin_range_list_free() - free a list of ranges
+ *
+ * @ranges: a pointer to the list to be freed
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_range_list_free(qemu_plugin_range_list *ranges);
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 8fd3a8964a..8dbd14c648 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -472,3 +472,21 @@ void qemu_plugin_error_print(Error *err)
     error_report_err(err);
 }
 
+void qemu_plugin_range_list_from_string(qemu_plugin_range_list **out,
+                                        const char *filter_spec,
+                                        Error **errp)
+{
+    return range_list_from_string(out, filter_spec, errp);
+}
+
+bool qemu_plugin_range_list_contains(qemu_plugin_range_list *ranges,
+                                     uint64_t val)
+{
+    return range_list_contains(ranges, val);
+}
+
+void qemu_plugin_range_list_free(qemu_plugin_range_list *ranges)
+{
+    return range_list_free(ranges);
+}
+
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index b142d11e58..472b29fc5f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -21,6 +21,9 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_range_list_contains;
+  qemu_plugin_range_list_free;
+  qemu_plugin_range_list_from_string;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
-- 
2.43.2


