Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC03C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSE33-0000Co-8l; Fri, 12 Jul 2024 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE30-0008VM-NZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:42 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sSE2y-0003ax-Sq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:02:42 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e9b9fb3dcso2270514e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720782158; x=1721386958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKWnt4ssz7MnpyKuRbBIUzzN45FF59afh9GBgWcO174=;
 b=aldrw8BfOlQXmbgluuBysNfZOXFTG39l5DJ0IK+pm2drXUdDH1PAEcUuJLTSnZkDnr
 +nJZH2PXocX2kBWHnE3S0wqEzXhI6OXOoNp/YJdSSVil3gomuykrj3vSXAioL1wCgbuF
 y7+DWJES1ajUM8ylE2E8rvb5AE/Z0mY/9JWwKcSxwq/RR6DQXRWLJtkNHnsK8OeMnJXf
 zAvARoFMdsam23JCGds/PkBI2zm+TXywRIss0/LS+IeMKnZdx3stDcSmGVZ5JkhtD3na
 W9zxqvBfg6NpkH8tmksyKi6ygDQaDZrlD5jPhzyjREtfNSquIK2VxBy85K0AnIreqkgu
 XPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720782158; x=1721386958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKWnt4ssz7MnpyKuRbBIUzzN45FF59afh9GBgWcO174=;
 b=dIMNpw7jrf5TpeUYiJQQ0HaDptq7TNga+hh0/+Cm7hb/Tb26o/L01l9cfJsTJswhYt
 lXjjuVrTwCELMIJqymoSM8nc82lUIctd7rD3T8wYPs4ClASn1caSQVfYsFKvbQeyvQ0x
 X/3FQWps+hbl0E+pnV8rBXGpP4rV5LsvRphw2PXSv8S4jBniS7NePvBHZAQ2UM1gimnD
 4Rv8Z15mD+3fzk4wSchxBcHn5jIqqINM93ScfLlRq9H2/13odm325gkn9eRJfEBcTntR
 oE7H737yTlMKua1natq/8VG52+p+PdaVvLdp5MfWUgNRNKBA9YQlycV0rdwqnYb6okvD
 K/aw==
X-Gm-Message-State: AOJu0Yy0a8rUIPL9wKP+cNlyGJw6iC2kwTBNbW4KmtUmazx5wUjBOVzl
 +nZQkeCgwAu1fK0wtslYFJG+2ElQy+Az86rWJW8SPPQk8YeWSVg8SCCve8v+
X-Google-Smtp-Source: AGHT+IGOZ+IbhxesDx8p6m1dAos6T8JaI42mOJvjxpfDN/gOvfWbf+1UhmiRI32EsKvzgaPEKTNk0A==
X-Received: by 2002:a05:6512:2107:b0:52e:9d6c:4462 with SMTP id
 2adb3069b0e04-52eb99978d9mr5526109e87.23.1720782157305; 
 Fri, 12 Jul 2024 04:02:37 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52eb9079cbasm1233898e87.309.2024.07.12.04.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:02:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, edgar.iglesias@amd.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v1 2/3] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
Date: Fri, 12 Jul 2024 13:02:29 +0200
Message-ID: <20240712110230.4098056-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
References: <20240712110230.4098056-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Bail out in qemu_ram_block_from_host() when
xen_ram_addr_from_mapcache() does not find an existing
mapping.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 system/physmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 14aa025d41..2154432cb6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
         ram_addr_t ram_addr;
         RCU_READ_LOCK_GUARD();
         ram_addr = xen_ram_addr_from_mapcache(ptr);
+        if (ram_addr == RAM_ADDR_INVALID) {
+            return NULL;
+        }
+
         block = qemu_get_ram_block(ram_addr);
         if (block) {
             *offset = ram_addr - block->offset;
-- 
2.43.0


