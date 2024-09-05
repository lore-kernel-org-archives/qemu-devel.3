Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C96CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7E-00025M-5h; Thu, 05 Sep 2024 09:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC71-0001JC-Fc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6y-0001nF-34
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so7787415e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541278; x=1726146078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R9U4aWp8TraYxhIRkNKUBeZnraOIqezcaMpKqimPY0U=;
 b=WshvgZFcCXqZPhBpNXMhqBeWUtrLIjFGL45b3zuMu8r3HvWtKxFU5ij/1eaqHuvFP2
 zpQd9RFE5iS36UpZzeuA6qtCvYVuv28zILGBv3AD99fAQ/SmiuvHhL2xkjFRxVQEZ9Cf
 OgbLcPOfOYzdV4bVL+jrsc1Jp9h/rBDnPdu2maDMxmoNeoSgwpeDketr8HJmt8FrEWAu
 Pe37w5RXA9R5NzkayrEyK7xahvkSE5YQ7mVwFhxBIJxG4NiRjQLQUM+eWh8CUzQ3Nef/
 PXBn42lbOmvvPKpofAYMAK4VqWJDuoDj2D1L5EOvGG2eZpcboPQcg4xR9ByfCUXqKQ9F
 7JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541279; x=1726146079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9U4aWp8TraYxhIRkNKUBeZnraOIqezcaMpKqimPY0U=;
 b=bMOpGBOEvBs2KT1aW7LiaGXTgUPMcIqIMSPGKAEhZHsn05gtIBTs/TT/vSzHdCjXtv
 A/OLJQNVITuKOXI896d0MW+hN34DOA9UmK3WtU54AWOmb2je9av0ABPc5dUApNGk7InV
 eo0RP3bHVSL1bDMvtHRWLRdFxrWMwxHBMbb/s2zN/tQkcGIGvy8tvyIF6euseJ4+3m2b
 I2Z6QLD5mFQurjAsKbB5t2YYvXFL6ybeadDVbez6WE1m/n5CfNXvTR5GKILmP/Iw0BOF
 H1xNq1a/4u5RdoK8WnlzjmiiWlSAfEXIGoA86jZhgqZAfhp7Q0KTCdbl4W6l0UrB6GI8
 mFbg==
X-Gm-Message-State: AOJu0YzeZv2vJcPcL9ggD7LdXrqx47DuUhCKGt3g+JCdi2mFlcT0vih7
 tY7UDPjusPOWUSFaxNtCw+AWC3u0uDUqMA3kX3UHtbwjUNx7K87F3NFX6IJsYOTfseBnOwwmF50
 B
X-Google-Smtp-Source: AGHT+IHxyXu94qLbx6CcPouCsLXwC2oQT2UiU1Gt880JDEO4rCiZ87x3376FTRJ2jp5jfZdBNlZtdw==
X-Received: by 2002:a05:6000:124c:b0:374:c29a:a0d6 with SMTP id
 ffacd0b85a97d-374c29aa194mr13434266f8f.2.1725541278318; 
 Thu, 05 Sep 2024 06:01:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/25] hw/arm/boot: Explain why load_elf_hdr() error is ignored
Date: Thu,  5 Sep 2024 14:00:59 +0100
Message-Id: <20240905130100.298768-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

If the file is not an ELF file, arm_setup_direct_kernel_boot()
falls back to try it as a uimage or an AArch64 Image file or as
last resort a bare raw binary. We can discard load_elf_hdr()
error and silently return.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903144154.17135-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 6c895e05cbc..5301d8d318c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -799,14 +799,18 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     } elf_header;
     int data_swab = 0;
     bool big_endian;
-    ssize_t ret = -1;
+    ssize_t ret;
     Error *err = NULL;
 
 
     load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
     if (err) {
+        /*
+         * If the file is not an ELF file we silently return.
+         * The caller will fall back to try other formats.
+         */
         error_free(err);
-        return ret;
+        return -1;
     }
 
     if (elf_is64) {
-- 
2.34.1


