Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D2EC113D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyy-0006d4-JZ; Mon, 23 Feb 2026 15:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyx-0006cP-Sq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:43 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyw-00082U-9O
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:43 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso4308430a34.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880201; x=1772485001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAluVMYKeWfHKHjN37UGG1wr+/XyqdD3i5t7V6iE0KE=;
 b=XLzcYvCkWu0O1vi/43TmYn4H6oFJ/oRA7W0xHUjQjP5tcr9c1CzJoDwVuZpjQo5B0D
 qIdnl5cE2L3wZ+MSCFNy2ZOwdLfQbdakliUdu2ayvJbsyx7j4Xg/FXK5EAl5JXm/VIEa
 7dKfOfExx3XLMb0WzaA9Qt/WSHE+zRr2vEiGDZFByDOnqXEfiHLNufF6h9DWSoPlPrPX
 gBYndyYVVxQW25/IpNvvAi/e1A5GK7w/B/D6F7SceITUJMHuJKgyRWDNvKlVmbjVn1+m
 NbIck4J4dooA7+CmRp13TcX8z766HGWt7X8eNr46KIn5lL5DRfjLJKVW771cR8NqBb2Q
 C1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880201; x=1772485001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rAluVMYKeWfHKHjN37UGG1wr+/XyqdD3i5t7V6iE0KE=;
 b=r8GChemlD9zOlTgjqQVmvj3eQcGkfd7jRhcsWhnkEvPMOsGFTifLsZZzdrvSxsdAKN
 L/HTBOVaDjQ19LAYCT0PcwW0h8Vi/155ntvAodp4Dd7RtVTIjz/ZgCju067RKTdEvvdI
 lddaQ94IDiwIubXLdTXu8mOsYojx2x4iyhn2V7EZRE93+aEjQtC2EHSq5wNQy90SXGVZ
 IfMYathn+mHeG0QTekgOsBMaB7La2pvf+cuk3sXBaBUm6wX6p8miJnbKlH8IuNBMSEDh
 Vujig6oEHVrsjx1TNCLdt60L3AmNv2RShIGwb4PVNN3d+OhqX7BdQyIBYz+ivdgRSes1
 i4jA==
X-Gm-Message-State: AOJu0YwD7FZx8hdVtXdiDNysbXMtnAMmb4tutEZ08pKncJi7hWiogYco
 8SDb9wcxYpGOqd/vMcftN0h5jx1123b1TDNRokGdLwcoyIBozlB5/+byBiw7eQ==
X-Gm-Gg: AZuq6aI1GMSTN8pyPibhhoO2W+zYNeatMD0s9plANyXa1G8+31jp1QBr5+ZHRYh/oP/
 ie7+vj/7Dhxeg8bUsL1BbRerw8F8esJgQNHowN63GH5jfGsiiZ5vv9MD8q/q7RzXp3jpgyLqt0T
 KptSN+tA1x9Bn4oqJfKOOD89Ld02xwpZW11AAC8VMOEGuhpRdBOzQ2l04O7IR520rjtWwe7wAaT
 M/auxbOVIY0NhG7StBgAps+NwmBJsfV+GQUfEgqvEUI6mIV/boFDrtg22s+nNiAg1AELZsgdjKA
 L0vAgcBo/3waJ9/NBx84ocZ8Fl6nks9pwy1kN0epUsAdcpCOwcH0HuYnHNwLV9YUDCo9YcQ776N
 /TVOOia+mMYRDH3/02mNVJEq5BEhaXOfkERMC1AIVnRKHK4TkNhGuAvtQX74WpQbfK3G0lVH0MN
 joVIIpu0dcSzWqIXZDJgsLGrjXhpOBVuh2k4y+jniDYKJPC0u0w0ZFNXH74u+wzxmGgKye2Iwj3
 GhUzZQh37MCxuu5dI7V2Ncv8EXto4HeJLzJPw==
X-Received: by 2002:a05:6830:82d5:b0:7d4:c276:7484 with SMTP id
 46e09a7af769-7d52c459383mr5850981a34.7.1771880200707; 
 Mon, 23 Feb 2026 12:56:40 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:40 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 7/8] Hexagon (tests/tcg/hexagon) Add tests for qreg multiple
 writes
Date: Mon, 23 Feb 2026 13:56:31 -0700
Message-ID: <20260223205632.223714-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index b93f2ab32e..86adc1331f 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -242,6 +242,27 @@ static int test_vreg_illegal(void)
     return sig;
 }
 
+static int test_qreg_illegal(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "{\n"
+        ".word 0x19a14048    /* { q0 = vand(v0, r1) */\n"
+        ".word 0x19a0c044    /*   q0 = vsetq(r0) } */\n"
+        "}\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -270,6 +291,8 @@ int main()
     assert(test_vreg_legal_predicated() == 23);
     assert(test_vreg_illegal() == SIGILL);
 
+    assert(test_qreg_illegal() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
-- 
2.43.0


