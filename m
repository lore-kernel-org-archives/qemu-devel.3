Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE24AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9a1-00089D-W3; Fri, 13 Dec 2024 12:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y3-0008Ha-55
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xz-0001kJ-Om
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso3210265e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111230; x=1734716030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LHYKnsZII936z/JzPGS2acHwiW7ATdMySxAu7M3/+ak=;
 b=lEXY1DNF83rdYg10DecIsEpjMbPDvk8BFAairfAK1zcxe4i6m4XvTISK9Gqs+5ShYJ
 e1k0ZdtsofSo5yWsLT1xwBw2wZl6m6U+SKFXGV/Ol1hZcgw+JQ9euzYCGxOWJODN6Krg
 KqNmL9YjQ9+2ymyEUXsEeTyaV1hyMMnOT27CS9+2tcC9NnDPE4FJcYsEzSfpkEkP9b2S
 2SEImf2qY3c73T/efX0Hx241wpDKzqk3vi2jvWEDcHqlTF8o7wMBLPsNFLlU+JeQsmbb
 rytdS5cRJXfqfGkyOQLhzbafba7uj30N5BPXTUn9iVcs+5iJ31UeSGxiGhFxuFdLnVLw
 vrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111230; x=1734716030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHYKnsZII936z/JzPGS2acHwiW7ATdMySxAu7M3/+ak=;
 b=gM2wvCD8jE1vBkNZluxpQKUs8DUwei7/vkTJPyJ3SjSbduo1gxi6+FVnt6eTCyLWtV
 N0Ho5ND9jXS0F/Q0sGs62CaTZNxyJtjq/W7HSzJFstPQ7Fi/SzpwBLRbJZaf8KMoxGpw
 XHHvZlADTI6OuMtAOMLFYP1GHgH5Lei1NGcM5ZQZlbmuOUgYAuMH1eHs66QV9LZxrGEd
 Dv+t7L6764q0bd2zBJ+HDimdfFZmj5+x7dlXw54jAF5/2jO6xskKeru0qVBS3Vade9T0
 pAjfzZEVi/I065q55J0cHgevLA5pnHEvCCSRcrZtsG9EXwdnF9PSzkMqIZY5XaCiRXIa
 g4JQ==
X-Gm-Message-State: AOJu0YyGF+WUMk3qKuNlhj9CRLraHoxrfntindbfXesLxcAvlR3alLrj
 NRjwQGqmqz56MOHVijqSD8GMzNveLh5GyHK/hfoKEgwesl207pqWBXu+GmcXUbxq+udIUotmTii
 M
X-Gm-Gg: ASbGncupv9bcABPTZlUnE34iUiiH982wE+ylCXzZuxXne6z6/Ei4zL3FlLi0h5v5nHk
 H2QIwIU0BIouF4tJTLbjXKFmqN5CZupihe932JQxGVXM84mHBCOw2NauMqMvmdcC4zc36TfujZB
 oTBR4GrQte7Tm46SZxtHgObWlkJTYDl4A+bTGOFAG1tewPTVcQAmnQdZJ4KwGf9KVGjPfpLfa8M
 7cI7uuH+wCm0twa5N2Mr/bKY+LALRI5aIzkt5oP1k1QXFoqGgR9QJeDsUEL5A==
X-Google-Smtp-Source: AGHT+IHvRqTw3Den4/0CV4VgouU4mWKCjmlhKKeGPF2vti8T12Rhp/hNMjsfkZ13u8HjzHmeqbaS1w==
X-Received: by 2002:a05:600c:83c9:b0:431:5044:e388 with SMTP id
 5b1f17b1804b1-4362aaa9a2dmr24723545e9.22.1734111230113; 
 Fri, 13 Dec 2024 09:33:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 74/85] docs/system/arm/virt: document missing properties
Date: Fri, 13 Dec 2024 17:32:18 +0000
Message-Id: <20241213173229.3308926-75-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241206192254.3889131-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c5..f87adeb444c 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -167,10 +167,18 @@ iommu
   ``smmuv3``
     Create an SMMUv3
 
+default-bus-bypass-iommu
+  Set ``on``/``off`` to enable/disable `bypass_iommu
+  <https://gitlab.com/qemu-project/qemu/-/blob/master/docs/bypass-iommu.txt>`_
+  for default root bus.
+
 ras
   Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
   using ACPI and guest external abort exceptions. The default is off.
 
+acpi
+  Set ``on``/``off``/``auto`` to enable/disable ACPI.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
@@ -184,6 +192,14 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
 
+x-oem-id
+  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
+  table header.
+
+x-oem-table-id
+  Set string (up to 8 bytes) to override the default value of field OEM Table ID
+  in ACPI table header.
+
 Linux guest kernel configuration
 """"""""""""""""""""""""""""""""
 
-- 
2.34.1


