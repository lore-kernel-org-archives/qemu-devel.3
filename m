Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB35E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPa-0002JG-GO; Sat, 27 Dec 2025 04:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPY-0002Iy-VH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPX-0002Hv-CV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766826989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6li7w8a6Pitmdewj/jqAZ8JOtWEBQW+HXmh8L4sX9Wk=;
 b=Yy1CezOpi39sJ6i6yRytK1x1IR3ch8Ayr92E319mvjyyyvk039HPMgMb1r9yzO0rtmSX3C
 tY4fk5NSw3NwEu9OjFDiMNwHjwdrjuPEO9J3VJLi2euNb+MNYYtrVkAuhQQnZpFHipCNh7
 Q3xQTzqM3pUHpZnTh6jvetO80htSBdU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-NwEtvJYXOJisUmRe25p5-Q-1; Sat, 27 Dec 2025 04:16:28 -0500
X-MC-Unique: NwEtvJYXOJisUmRe25p5-Q-1
X-Mimecast-MFC-AGG-ID: NwEtvJYXOJisUmRe25p5-Q_1766826987
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso99529895e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766826986; x=1767431786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6li7w8a6Pitmdewj/jqAZ8JOtWEBQW+HXmh8L4sX9Wk=;
 b=ZZS71WJJirUbyVfCFxGWdpiq0bwTfieGrolyZndAqC3BixGB8mdqxCfnzSGg6Unad1
 gtCQtGSeuRwErsACi0KIZLywK2jRA3QqqQU078LPQLFtBlqfWwX+Y1pE//4xqbNuxPHZ
 fd5b+OZlDssFeZeJlFurHLyilqQGyLWQvwoS+CavZpRiZDPU9/ZS6rNTuSj4noufTeAu
 m+iOtVh/W7sbs0RzSfiefcO0JOdi75vmMaEbvhYbYoaIRAF3x1LoY1nEUBWpRLLqnfgS
 YQnDY+NKU3MxMJ+kdlkTqBtbk2QlRsOKN3EOA9rM6b3ZZUojgloTCITjiF0YNzdYWaEe
 PyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826986; x=1767431786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6li7w8a6Pitmdewj/jqAZ8JOtWEBQW+HXmh8L4sX9Wk=;
 b=vvUbb4cvDhrL9jfHDAzCV6uzs7BUgD9WDN3PFP0OEcv6+5Lhf23NE0fLfs1obkxfyN
 9BB+EUEr+2fWPA8+ZTw3OhjXEGGpjqqpJuhXsdKgxQqTeJotU1q7RRevmh3zZN0lHrX/
 lZDxSgOlj6jtp+ogH3kumnyLpAnTUrHA4SoIWc6orA8VmjdIQBUZlyIv1gY8h71jHeeV
 mx2JumPojdEVnG6tggrnQUmcriKOlwesYsn2ZcFLPCcTeZtuanJXUhUq1PnJVSZLzD5H
 z5knTQzqY0iUYKx8h+cwH/hbou7v7F3wtL/q/SIkqIbZkgzNsnx+CcBvWzs32FwoIoJM
 lkow==
X-Gm-Message-State: AOJu0YwGbxULVKuUOUR2KdLRnmBZv9W8hNnZ/d5F0oPHmOF8ZTCVkRta
 Ap+SX5I1LvWQLJUabH9dMTW5CqmWQoYjm4RH55Qc9Qr4DE93ALKl54K5FyXCda6je2g/fJwicyo
 /CnVNWE7Jn4NYNuuQQshIN1THrYeWQ6y2rWzxbSZG34WRVc/zMSAqDeIuJL+r+7E4WUfopy9adf
 ZbQo+Px54u7+wXbVMKS/JH9sePeMWFZwIVFnbiE4oq
X-Gm-Gg: AY/fxX5iGHE18ARDBA0SMUHPVSCAbtD0LmiLunAzBwmlc9Sg0FvC9/oqSSAhXWfmK9z
 Okp9OwPv9h9/AW4n2SKuEONq2sKnIMcBZ6mw9Kz4tENrAWuOABAhsppJ/AthE08S4gCS+u4RjHC
 oN2599J8z/FybmAGqJ71eglUQChmaltX8Md2QIXIxC+EZbj/yEPNxhePYs34BWfesyaQgOJbDGp
 7BCDlQvfDlaD16dzs8dueZlbl5ciUtjW5SLZmzr7gIZitwqtwrTNFSrA454cFkTSsOgdPUrL2Ts
 bDCmFjo8PJMHM9c5R/cfTJJHo2WRb7axamTuTEnOonrDeS4Tg3hmUKko8AY1YYKh1AVuU2sWLDv
 77S9OvPCU6937u9YtP+lZZqqMv61KPGiADdHzkX3+lgtBn37GBEBbuesgtK77ujUW6/27Hc5k2y
 TjXatetpC82nXEllQ=
X-Received: by 2002:a05:600c:4711:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d1959fadbmr274504005e9.29.1766826986307; 
 Sat, 27 Dec 2025 01:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyizsLRdbfRzlQf+wRMT6D2DEexzkzFAUwowxiiOduuHWvo9gGN1/jXtaLMyrsJ1Axkhta6w==
X-Received: by 2002:a05:600c:4711:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47d1959fadbmr274503805e9.29.1766826985893; 
 Sat, 27 Dec 2025 01:16:25 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a7c609sm200881415e9.5.2025.12.27.01.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 001/153] tests/qtest: Do not use versioned pc-q35-5.0 machine
 anymore
Date: Sat, 27 Dec 2025 10:13:48 +0100
Message-ID: <20251227091622.20725-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

As of QEMU v10.2.0, the v5.0.0 machines are not usable anymore.

Use the latest x86 q35 machine instead, otherwise we get:

  $ qemu-system-x86_64 -M pc-q35-5.0
  qemu-system-x86_64: unsupported machine type: "pc-q35-5.0"
  Use -machine help to list supported machines

See commit a35f8577a07 ("include/hw: add macros for deprecation
& removal of versioned machines") and f59ee044067 ("include/hw/boards:
cope with dev/rc versions in deprecation checks") for explanation
on automatically removed versioned machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/qemu-devel/20251224085714.83169-1-philmd@linaro.org
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fuzz-e1000e-test.c | 2 +-
 tests/qtest/lpc-ich9-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz-e1000e-test.c b/tests/qtest/fuzz-e1000e-test.c
index 5052883fb6a..b66a2e2313b 100644
--- a/tests/qtest/fuzz-e1000e-test.c
+++ b/tests/qtest/fuzz-e1000e-test.c
@@ -17,7 +17,7 @@ static void test_lp1879531_eth_get_rss_ex_dst_addr(void)
 {
     QTestState *s;
 
-    s = qtest_init("-nographic -monitor none -serial none -M pc-q35-5.0");
+    s = qtest_init("-nographic -monitor none -serial none -M q35");
 
     qtest_outl(s, 0xcf8, 0x80001010);
     qtest_outl(s, 0xcfc, 0xe1020000);
diff --git a/tests/qtest/lpc-ich9-test.c b/tests/qtest/lpc-ich9-test.c
index 8ac95b89f72..460d459c701 100644
--- a/tests/qtest/lpc-ich9-test.c
+++ b/tests/qtest/lpc-ich9-test.c
@@ -15,7 +15,7 @@ static void test_lp1878642_pci_bus_get_irq_level_assert(void)
 {
     QTestState *s;
 
-    s = qtest_init("-M pc-q35-5.0 "
+    s = qtest_init("-M q35 "
                    "-nographic -monitor none -serial none");
 
     qtest_outl(s, 0xcf8, 0x8000f840); /* PMBASE */
-- 
2.52.0


