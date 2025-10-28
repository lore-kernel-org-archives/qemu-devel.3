Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E17CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbL-0006Gf-LY; Tue, 28 Oct 2025 13:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbG-0006Ct-Fn
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbD-0004fF-EA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ad+FmvUd3eJFOz6Qx4Phgo3HGeXx5lTIOPt67H+q248=;
 b=WjwbhuzhjHBCnqNY41DZV5orBiVIFbwPUmgElBVmc5QL+24M/26gP8F1wpCTn/JjzK9zw3
 EOGwZbtEh7BO6RihwtY5VkGXYu6F8J6s08ShTRtEq6EhT0gyYUHAEqtres1ZQM7NVtWhx9
 CK6HcRxE/yk7o/DsDF8On9LAsqu/1Ac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-xgH_8C12PVqr3DKd9wPWeQ-1; Tue, 28 Oct 2025 13:35:07 -0400
X-MC-Unique: xgH_8C12PVqr3DKd9wPWeQ-1
X-Mimecast-MFC-AGG-ID: xgH_8C12PVqr3DKd9wPWeQ_1761672906
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475da25c4c4so20141675e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672905; x=1762277705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ad+FmvUd3eJFOz6Qx4Phgo3HGeXx5lTIOPt67H+q248=;
 b=JzVmZ3eF1IhOQb+Ag3FA2vg1zkSdNOXhxzSRm3O8l48cJUGUyXpoXYTUlUsmkBQF7M
 Ga6buEDCke0QdlAjPRNcRuo1snTXvPij+eczcJJLUpoEkq9R+2BcAiOZQHD9U/3iadpx
 VZ1SU/visv4zd7Fp5AdJs0d89D733fZlLMzHZzBAvxITbOn388tD8LfJf05pIR9ginaL
 JRoNcHhMCllEsaTwJrEj2U1mXt6im7ap4YWok0y6iuxHEO4rIy1FCS3CKfjr4A4tS5RR
 6s8bNUAry9GtG/8JraYirHPO993ZInFgt8oK66bi4Gv2o2ekWozJqAH5DTj3hNCcGKfG
 LKOg==
X-Gm-Message-State: AOJu0YxUNG6MEb6x28LLpJg1bmWK56FSnTSqs2Y7ufH2jhMHOuzSdWfH
 DMWtybJWSIRabsYGhZsFI8YCOL/fn12KG4BM1IB3zVmYjtFqNYFwDGdybfo/NTtcOo/LtOaUNj2
 46g18FDempUd6a1J9Rws1gzbpCFqc+HpT7Ln6SkMWeYGlZScrQqJjiNqOucTGabohHAfykdAasI
 MkaJkxNpAuaXQ/DCfjK5X/cXAWFI8jEcLQ9T0cB2FU
X-Gm-Gg: ASbGncuGW2lg7szJZdBNxEg8FaL5mwxxJuquKy+Umm6dEKcpA38qUuoPOGzDMm7gg86
 yUmSprPjVhlCDBuryN/jwURixSVtMoxfrHrYWrsIP3Pm5cNaB24FmgFtVO+T+RGf4v8Ib/Oup49
 j5m44KwhvYQYfXMl/IHWCsS4csErCzSVNxlM2WbNB/Ib0Kqj4CYbd+nc0TuVr9LYHbDdvCbLabC
 25veO32Y0l63Bwgxxb4Tz942JEa4gxqIqZGe6vLqtz/h7mJ3DRBg6fCf3ZV8iYrelZO+Dpx5jkU
 76/KTHd9XTv+w1ApbOPhwArn1PMa2mxYFlKWuXaTdkDotuUcxdeWBoehmYS3cWzXeyvrqZObf58
 l60AumISsQt+MSdSo/qkyEWZh1tfpnvrBI42ffabWMQO4m/lkBj2OjAzA3UJlfzwIqbbmrmXFEo
 amL3I=
X-Received: by 2002:a05:600c:5491:b0:475:df91:de03 with SMTP id
 5b1f17b1804b1-4771e20e433mr2383915e9.39.1761672904883; 
 Tue, 28 Oct 2025 10:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPTQwCC6GeuAs4ewCVzqLyoLXpoYBmoML0KloB53c3B2FNdViDxnIOh8TsgQgchAOahrfk8w==
X-Received: by 2002:a05:600c:5491:b0:475:df91:de03 with SMTP id
 5b1f17b1804b1-4771e20e433mr2383585e9.39.1761672904421; 
 Tue, 28 Oct 2025 10:35:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e39380dsm2183605e9.7.2025.10.28.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/18] qtest/am53c974-test: add additional test for cmdfifo
 overflow
Date: Tue, 28 Oct 2025 18:34:23 +0100
Message-ID: <20251028173430.2180057-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Based upon the qtest reproducer posted to Gitlab issue #3082 at
https://gitlab.com/qemu-project/qemu/-/issues/3082.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250925122846.527615-3-mark.cave-ayland@ilande.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/am53c974-test.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/am53c974-test.c b/tests/qtest/am53c974-test.c
index ed3ac7db20d..a3667275ac8 100644
--- a/tests/qtest/am53c974-test.c
+++ b/tests/qtest/am53c974-test.c
@@ -109,6 +109,44 @@ static void test_cmdfifo_overflow2_ok(void)
     qtest_quit(s);
 }
 
+/* Reported as https://issues.oss-fuzz.com/issues/439878564 */
+static void test_cmdfifo_overflow3_ok(void)
+{
+    QTestState *s = qtest_init(
+        "-device am53c974,id=scsi -device scsi-hd,drive=disk0 "
+        "-drive id=disk0,if=none,file=null-co://,format=raw -nodefaults");
+    qtest_outl(s, 0xcf8, 0x80001010);
+    qtest_outl(s, 0xcfc, 0xc000);
+    qtest_outl(s, 0xcf8, 0x80001004);
+    qtest_outw(s, 0xcfc, 0x01);
+    qtest_outb(s, 0xc00c, 0x43);
+    qtest_outl(s, 0xc00b, 0x9100);
+    qtest_outl(s, 0xc009, 0x02000000);
+    qtest_outl(s, 0xc000, 0x0b);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0xc200);
+    qtest_outl(s, 0xc00b, 0x1000);
+    qtest_outl(s, 0xc00b, 0x9000);
+    qtest_outb(s, 0xc008, 0x00);
+    qtest_outb(s, 0xc008, 0x00);
+    qtest_outl(s, 0xc03f, 0x0300);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outw(s, 0xc00b, 0x4200);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outw(s, 0xc00b, 0x1200);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outb(s, 0xc00c, 0x43);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc00b, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_outl(s, 0xc00b, 0x1000);
+    qtest_outl(s, 0xc007, 0x00);
+    qtest_quit(s);
+}
+
 /* Reported as crash_0900379669 */
 static void test_fifo_pop_buf(void)
 {
@@ -266,6 +304,8 @@ int main(int argc, char **argv)
                        test_cmdfifo_overflow_ok);
         qtest_add_func("am53c974/test_cmdfifo_overflow2_ok",
                        test_cmdfifo_overflow2_ok);
+        qtest_add_func("am53c974/test_cmdfifo_overflow3_ok",
+                       test_cmdfifo_overflow3_ok);
         qtest_add_func("am53c974/test_fifo_pop_buf",
                        test_fifo_pop_buf);
         qtest_add_func("am53c974/test_target_selected_ok",
-- 
2.51.1


