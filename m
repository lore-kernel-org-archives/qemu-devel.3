Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4C2C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6yT-0005mH-Ld; Fri, 01 Mar 2024 12:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yQ-0005i7-CK
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:47:06 -0500
Received: from cockroach.apple.relay.mailchannels.net ([23.83.208.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6yO-0000bv-KC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:47:06 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 43E11362B12
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:47:03 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4144C362F91
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:47:02 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315222; a=rsa-sha256;
 cv=pass;
 b=K3P9UPMUdNug1JEqaNcFBhffTV68AVPcHyhyvD80m8ey7pfR5lVkbJNEEQQxL04PaEbigO
 zqiKozwYg3n3o74BM3b80g+S/RNI5eSw4Nuo0wuKYtht8m/GTVRMasE49i0TZoTYH0MTIT
 /LZ7b6s5IEF1LSuHRuKVf8SuBcPefK5obIi2vXUbVZvB3PFuVn+TZ5t8/JOnJ+JpveP18G
 A53keLzQP8cJD1DdPCOTr2kcGAIhl+LDmauwsZkFpdWKPFOQAMQevaXqVke/KVIn5OJhND
 rpHuGDSVCvJzdflK4Lwu1y9eDpHlKNctWBzStEo21CGBhYwo0e/IiDtXF1KI7g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=UXyHuOL2Zz1wN0HSN8V7hVB8CKhogOCL5fIhUH2hyss=;
 b=0yhFC+pFx62q/a3k1cPAAjo74dwVGranRmToU1VCKoQw67ShSvVuon0oDZG/ie3Wjha5TX
 7YEfVX2p9iMFgcyxamgwTTcuh6o4HKdsdJZrJ5slRMne4Xp87l6RsbtbwJV/0IG6ZEeWdH
 z0t6cqajUvbLgK+lezweKX5+Bd+e0CatgmC5ovHMxAaKBpmwET7j9nWPheRJyJbR0qEBpx
 pe7JCFsP+BT5bWYj6GgDsN+hzpHBGgCuilRDgiTuffYS0UerIeLkM4kVhWNr1/0R1zwFlf
 QZ33tH4F53KVBxkJE9ANY8BFSUPUrZdmHetll48clqwExq2KAN/QkE+fqfc9zg==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-rwchp;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Arithmetic-Spill: 0b9bb44c212e5120_1709315222770_3516816653
X-MC-Loop-Signature: 1709315222770:2772798783
X-MC-Ingress-Time: 1709315222769
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.227 (trex/6.9.2); Fri, 01 Mar 2024 17:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315168; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=eqfgD4CSOGAVLucLER65HWmmPFa1m0qWAWKBq1zs4Faoi+ApmUH7+AoOZT1zYPnBu9lr+0B3Jt/Kz
 fO55SOs6drdHALMyAcyZdBGj+zpS+jySUO9xHgFkpVMAmgHn8hIZxFIp8aGx01ZHXAbSbykgowdYjW
 YizcV9bMcwd6bBe+mIddWym+nzlZXJB/athAzkUZYJfkGXp8LrdRNhGMSaiF98/3EhZQwzlLfrsR8J
 kE90n7zI/mSMS9eLRDNHFk1Y55n5jdyaD+zXc6jUOIQRnuIPJEVKoF8qIo+DIxo5LyFPYvks83UuYU
 9WFqF0p4Zzljk6cHRiTbJo5rH0yu3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=UXyHuOL2Zz1wN0HSN8V7hVB8CKhogOCL5fIhUH2hyss=;
 b=HYbcfpg5/eiCZEJ3/xmPFJ0ZJHx4vL2gY2smhpRzVD5nZOY/xV9h89Pzvc23EqOJU3DOFGiaBI/Xx
 EkuKqGSMqF7C+Whp/qH5AqXuixDGyxJTQePB06BXJpj104lvQJqMrLtisam2gKjOUq0jRhWPdNmYCz
 d8CgP3M6mSlLDYvLih3PysjIM9LiEj+DHxl3G18a6EKR/J0Tfr6Re5obxjhx5UeWb8bA9hrMscy2fk
 gCZ4C+BJPJ1yY02th4stOmGTna3/fvdcKxL/4Ui8DoS27MuQf/iGP8o97/7c/uA3OHIj4tgxfKNzIZ
 cakAbHWpntC55S3w18RST0M6Wjishpg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=OwYfFHZR; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=UXyHuOL2Zz1wN0HSN8V7hVB8CKhogOCL5fIhUH2hyss=;
 b=p2/ot/HT+bwxUDcs8b9tdNGCPHu1sMKVNHKpkMNHXkwmIGe7lcDHX1TiadtSaF8Kgd6WdK+jrDV4S
 L1+Gc2zBX7ThKeMmWP7OdqtneVz2wk0oGthTXFNsrmvFGFCvOY+MqeYDIYZsoHYI/10IywP5hH1AYv
 sSdMmk142jBOJ6SM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=UXyHuOL2Zz1wN0HSN8V7hVB8CKhogOCL5fIhUH2hyss=;
 b=CvOs3nOgq0E0UkIq2safJ7sk/av3cS+2xhXkDBZl4eneBVK48OpaX7hSodZE9YfN2VeTgL0ay+s4u
 bn3E89LYbE65iHa6QQfKNuNd9tj4AbGRzfDmK4+fnh5PLrGXbXXnPpLAPqidnNWleN+P7Lm0yk/QH0
 Q2maki2bhXDQ7wTirpinNxSgbLyb45/GMYjq0ObzHy9ldV+A0wFCgmlM/yL/loErx6ceDxldS+XEMq
 yiNGJ0KVWEhDH5seQdvnhgt2Rv6Kp3hyf5HRvdYUbvprxJsh/Rsc5fY79dQGJ22tGEH2RCutMrFSeW
 eXyV7cJuqLLgFHnCdjPo0UUerxJxq1w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 92c79b1f-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 92c79b1f-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UXyHuOL2Zz1wN0HSN8V7hVB8CKhogOCL5fIhUH2hyss=; b=OwYfFHZRkx1Fv/MGwieuGE+kj7
 CqcA0fIlEZSvvsG2F9uqc52bVH1UNnIXIN/RKtLpMqZKGIDUdUZUQFxBbQ6VmgzBGyGvyasUjHVl9
 NCNai1AKy3VgcTxM7w6bKLuGwmgA3PIOnZkhia3apc9Ag+FwcWLglo23MQ4660CGTp03tuXxCrI70
 kgF/Kw4+9rA2Intdy6jry7I2QwdLukOhxbK+kfmTfqgtT5fZdHI4UYEq34vw0hWnHTJZsf2xkMUKp
 mhLzGQh/Vg9H6RgBE4yYPooQ+KcOz/tMJwUxsqfij0VwoKv35mUKZD5SCgZiaXUeFlde7P/b0Fo/s
 pJ00b36Q==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xn-000bs2-2D;
 Fri, 01 Mar 2024 18:46:27 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 09/12] plugins: add API to print errors
Date: Fri,  1 Mar 2024 18:46:06 +0100
Message-ID: <20240301174609.1964379-10-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.208.37; envelope-from=svens@stackframe.org;
 helo=cockroach.apple.relay.mailchannels.net
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

add qemu_plugin_error_print() which is a wrapper around
error_report_err(). This will be used by
qemu_plugin_parse_filter_ranges() to report parse failures.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 include/qemu/qemu-plugin.h   | 12 ++++++++++++
 plugins/api.c                |  7 +++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 20 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 45e2ebc8f8..5839feea4d 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -752,5 +752,17 @@ QEMU_PLUGIN_API
 int qemu_plugin_read_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+typedef struct Error Error;
+
+/**
+ * qemu_plugin_error_print() - print and free error
+ *
+ * @err: a @Error handle
+ *
+ * This function shows and and frees the supplied error.
+ */
+
+QEMU_PLUGIN_API
+void qemu_plugin_error_print(Error *err);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 81f43c9ce8..8fd3a8964a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -45,6 +45,7 @@
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
+#include "qapi/error.h"
 #ifndef CONFIG_USER_ONLY
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
@@ -465,3 +466,9 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
 }
+
+void qemu_plugin_error_print(Error *err)
+{
+    error_report_err(err);
+}
+
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 27fe97239b..b142d11e58 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -2,6 +2,7 @@
   qemu_plugin_bool_parse;
   qemu_plugin_end_code;
   qemu_plugin_entry_code;
+  qemu_plugin_error_print;
   qemu_plugin_get_hwaddr;
   qemu_plugin_get_registers;
   qemu_plugin_hwaddr_device_name;
-- 
2.43.2


