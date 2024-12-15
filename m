Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786A7E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu06-0003jk-CK; Sun, 15 Dec 2024 14:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzs-0002DM-Vn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:45 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzr-0001VW-Cc
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:44 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e157a79c8so707627a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289782; x=1734894582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+Op5PfQl1E1j+B2tl78vi65dSufB6++mDTLqDV5QuM=;
 b=oTEU0Nc6Sly6FU40O3hPpbHdbkgmXp8CSOwCub+6GMMOkeJAAybxOmNl0SAx1yglav
 nlsy0aBLOxK/n6hNOnSri3w26D2ZK58UTmBwCvBYxl2eDEGqSWHJ63P6y2ARu9TnHPS9
 yhfwn8NIN5ok02tfqNU9lphs2KkMpjWsDOGCCyyUds+2IN0meAbteGwHvqqOG+1sO2C4
 fbG0EW4EqdVwSiPhBRj/SEAgx0s/rtZzb2/+1xVae32VlFIcBceOry3yExdI4abAekBH
 OR3Cesm9PxLYViAggwdrjbw7EC+vVhXtjwHTcA0ooSONe5Y1Nl0cJ87bnqHXCHzKlopX
 7diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289782; x=1734894582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+Op5PfQl1E1j+B2tl78vi65dSufB6++mDTLqDV5QuM=;
 b=OMfWZMnyMXLCwZLOdqxTro3cLAHVC+tajzqYo3FqDSBn6XqyfqktPDTYABdLXEjjWx
 9tCZ+bNQ7n0ORCrRkgNx3xmdq4dIgL7lMXKD9fhsYP1+Z/48Vx9hhZc3nx7+yl/zWtNc
 9vxijmVqh2gFTi/M71jQeTTlHKobOiTpXFWsbGJNaEUs8zIyUfnOSZn1HElYHkJBtDJE
 Bw0qKyCRlBoknh8TieQ5VkFXszMjkWqs/Y2atiL+/3bgCXr9c2thD35+fI3YjhO+dCb5
 I4/DuWYKtPdNaymMDUaXAyjkDFaZ08F5VB996cXnDEdOWB0Vtj9du1dkNOE2C8j8kpKt
 GAOA==
X-Gm-Message-State: AOJu0YzO8LWJ/Lsv4knQhgxWRYlpQgjM7V569npeSMcgHolAKG0OmIw4
 2rIbfd1rS8D49ua+6PzB5NnGN5LS9VXf7H7IdN3yms9/swjcmA34fPaqWUPnWFSUNbIY0MLDSx5
 6fQWn1kEB
X-Gm-Gg: ASbGncumUL4G9yP9HFQmPFbAfovills7zlcUih/0Z/lrFx3DZDUk6MFtcdp4ReLRnB2
 bLqGqbf8zq4gw2+zb7M7OK68Gkeeo6+x0zbf/9cjMdGhZ/gZieH+c1ZgM0wvNEofulqWoFdQRqR
 3qljoKZsFqeUIm6VDC/eJSeCwKQS5N1HRgPHaSIEBcftMCMkG9NscYnvoVMICpNVVh+NOMJdzCt
 73z0EQRivXkl+4qmmlHgMXTo1e8jng0DHqvDfTMzS1cvdPCdbY7Lenlva82barYGf5hbc5yKKbM
 jzazLINFI67Ppa7y1j69AuPyRylg/phCexE0zkytzMc=
X-Google-Smtp-Source: AGHT+IENrG6H8hUmsBmoKJ02c78XLSjA0rTLMsuZN42QcoPmD8wCtfMroaaLTJKxXxGLJt+RDx3jrA==
X-Received: by 2002:a05:6830:3695:b0:710:ec4a:b394 with SMTP id
 46e09a7af769-71e3ba498a1mr6814359a34.29.1734289782136; 
 Sun, 15 Dec 2024 11:09:42 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/67] hw/remote: Constify all Property
Date: Sun, 15 Dec 2024 13:05:14 -0600
Message-ID: <20241215190533.3222854-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/remote/proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 302a0a4d4d..6f84fdd3fa 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -191,7 +191,7 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
     config_op_send(PCI_PROXY_DEV(d), addr, &val, len, MPQEMU_CMD_PCI_CFGWRITE);
 }
 
-static Property proxy_properties[] = {
+static const Property proxy_properties[] = {
     DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


