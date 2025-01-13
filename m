Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56C5E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKuP-0005s7-VN; Mon, 13 Jan 2025 08:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKte-0005Yd-GT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKta-0007gS-Ey
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso30013685e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776461; x=1737381261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bdXp5MXnTPFsp7BfsgfQJ16h4dh9YOVZw5yJW/TGR84=;
 b=c51LVue+NiD77Lse5QadPi2rYIUjKeMOFMt2TGDQJa9bEbSPfvV6Bu4hdL7kmQ3rub
 TAiuCo3tEvovYhJ4eAPy3OASbj2fnzGPCECmjRxLcVdFnU8FAt+gMlR14xodIyfcP/VF
 jSlnwnnRMMFoZz2od/ddu9uq+CBpXXT93LUWYerDwMbRS/kDGme9uDlG06pZ3iEIeffK
 7UgTIN+1ZBpskKvVAoK45x/liWN3aSCIzSyUK1AZeyP2zAImvjtk2WrNaLG0SOM6mic1
 Nsg6SpAa+rQBQL1yerg9Kzfq48V06jRFdxMciwsGVzv6xZuxkaeqCIyjwRi39S4IwqJ2
 qzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776461; x=1737381261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdXp5MXnTPFsp7BfsgfQJ16h4dh9YOVZw5yJW/TGR84=;
 b=CmyHG9eR+dIRznDYSo44Cs4i92Fayykuxg/FtVj3iBDRbcr+dH+tBulcHFnjjVD04A
 vcXfpilmqm8UTbKw1f3+VwbMCfdxLMR5yBpTTqs0qeJIbWGsKTgzpkxhPvH3I3nurLK1
 34OiTXYy6j9agE3dQOdjF9v3rFBBxi6sPRLgZRzACjzXmzuUUMkIn8zgcXuSk+9s92rr
 22GiT3GK34cXm3tVTtXjB1hm6GIZoVkDnkeNnu02ClHdA5CNkogTfPFep2pkRevNmJFN
 9Yf3xwfF84P/Xh9z/lkHObQ3VOv+lJBhDH8NVUSeHoEpKKiYYt9El43/K2HImLrGyTfV
 6DBA==
X-Gm-Message-State: AOJu0YzpfX2NH/ht47Q9p6BfMgSSS6U1oS+IhIQZ/uEqh9hBZkF0qbID
 kaVd3SY5uGPhz/8N5WL/mcEBMpXKhVQvzU1RlYboGv3cqsH/qm9kg32bY5dM4SQNfap12p2mPBp
 6
X-Gm-Gg: ASbGncte51Juvs37rSPuTUu+hIJjyqLvSIdMsvJJaU5r53o3FDFsrs/ARbqghI+k6vq
 s/lxGd7MGBPpWssr9bd+GXrPNGbQyv9/obcxFszzDn3HLJtvG9C7jR/BdR5Z4kD9151ZJccP8r/
 gkGGiwWsYVfUhibHWQ/pzOZEi+0K7jOq9UG8DYHdGP+Yg+r5ienfztqIqCeIF7pKrf9yC4gefHw
 8CfMb2LzB1wmI1VU0K3EfY7D4ELTcCFp0PevUCEncF7tUNjkmFKkGSU2nP38wA=
X-Google-Smtp-Source: AGHT+IFUq6z6zgoXGsvO41sNoCrbFwVwP0Gwr7zBLD1i6yDIfUXV1vuEnu7H5MeMdxS3b1bOq9gyQA==
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-436e26d946cmr159786465e9.21.1736776460933; 
 Mon, 13 Jan 2025 05:54:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] docs/system/arm/virt: mention specific migration
 information
Date: Mon, 13 Jan 2025 13:54:08 +0000
Message-Id: <20250113135408.3164401-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20241219183211.3493974-4-pierrick.bouvier@linaro.org
[PMM: Removed a paragraph about using non-versioned models.]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f87adeb444c..766a7455f03 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -19,6 +19,10 @@ of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
 is not guaranteed to work between different QEMU releases for
 the non-versioned ``virt`` machine type.
 
+VM migration is not guaranteed when using ``-cpu max``, as features
+supported may change between QEMU versions.  To ensure your VM can be
+migrated, it is recommended to use another cpu model instead.
+
 Supported devices
 """""""""""""""""
 
-- 
2.34.1


