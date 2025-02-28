Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65704C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcI-00047U-WE; Fri, 28 Feb 2025 05:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxba-0002WC-Gp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbZ-00031Y-4n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdSj+vCGbdl3bKMKoQg0ouCLj1DLpLcwF+3HN8EJRjk=;
 b=WQ9VJkYaXidRz+Ec+M9sTb8LpuA+xrJJV1BYjSGSULXVR12KNZdXZbCfj/q2zOowYOZMA9
 yz4J6lQqnBi0CE0FE6edlfvWW9/4ZgaQI15nCuoqTW04Fax3uF3UAOZ7wbLtg01Fs57q/i
 Q+Wj4Je5LHPJUlZDFhwc1jmKHT3qteM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-idIBVladOM6L6FE3PyC2ww-1; Fri, 28 Feb 2025 05:28:27 -0500
X-MC-Unique: idIBVladOM6L6FE3PyC2ww-1
X-Mimecast-MFC-AGG-ID: idIBVladOM6L6FE3PyC2ww_1740738506
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ab4563323so10541465e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738504; x=1741343304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdSj+vCGbdl3bKMKoQg0ouCLj1DLpLcwF+3HN8EJRjk=;
 b=xGRodTaTaA2kk2U2LRk3u9kiN5tlfbc11a8TtvW8USgfZSG61WVBV0Us9xk9spXOb3
 jvhXuic/zZD7A63HrI5Ts93Fy11N9814UNU3eE9vc4FlwerPcnVJ4FNePhgROc77IQpW
 icWN+2LXwPzjalK7Jakil5OVLCcOlzazJXcXhQlb9vV232dvURMe/zrU8L/VRqpBFtLG
 BJLuvVpmykWR2pubGGBUfVaYLUmzTtXNgCj0O7omPXmOc97EByjKTt2t3A6SHreClzst
 diydLHMx6Aj/co6x2+YtvjJnw0ri8zlGBVSMj4mR6Jvis0asmEDnpNwi0uVmKzZayJrz
 Ip8g==
X-Gm-Message-State: AOJu0Yyf95hWYG0/WyQZYwc6EsfsCxoChW5ErTfQjnovfv5TB6I04okP
 3JulEesdiv+mVJMN6TSEZIZzA7a9Ux/gcXBvSZgtNu4SM9/fXZtzD7wTK38L8PTG8k9gXl6TBPf
 natseK8m5/kVrVPWQS1cVHk82HCuTuJ5RweIF0dyQ/yd+wGwRMWW5S3qw54AQw96oX/6Sl6GoFQ
 hqPvahiwzESnDYHTafh7pEUAkX68HhwZIyYlAVG0c=
X-Gm-Gg: ASbGncvSAKSWBfVo0IbAqzWEaOwoZhxdm7wF+9exiwjc+VUFxDUxTAdmJwSCGUdjrd8
 iB88G+Q4twKMpSIPqgiHkao0+ExIXpzI+T4so9Ob9PItGX9DzLyghi5m6sIRTwFrPDUY1qDEG4l
 EhsP1jY/xvtiOBRSSwE9YIitUhmCVAIbtl1+IAonSmSD5pDESnc3ipH7m/6kNYVUetmK3a03qmz
 WBJM6QaQ9onulxjylJIZizOEk5XmYCuRIKY/nR2Q8sxuIW2J85BgFVd2jrJxEgGAHfEduQP4N89
 o6GjFdinXOuHfC0tue0Z
X-Received: by 2002:a05:6000:1844:b0:390:db1a:15a9 with SMTP id
 ffacd0b85a97d-390ec9be589mr2412361f8f.31.1740738504707; 
 Fri, 28 Feb 2025 02:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkh40ndJntB61dd50ebybyS+a9wUx90QccGh/thlYKffHatCtD/W/x2y4XC5BESHAka67ZRQ==
X-Received: by 2002:a05:6000:1844:b0:390:db1a:15a9 with SMTP id
 ffacd0b85a97d-390ec9be589mr2412334f8f.31.1740738504263; 
 Fri, 28 Feb 2025 02:28:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a28b285sm52506505e9.33.2025.02.28.02.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 16/22] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Fri, 28 Feb 2025 11:27:40 +0100
Message-ID: <20250228102747.867770-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..969a9fe3c80 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -29,7 +29,7 @@
 
 typedef struct {
     int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
+    bool (*insertion_test)(RISCVCPU *cpu);
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.48.1


