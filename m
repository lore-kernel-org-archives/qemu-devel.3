Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5B1C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSk-0005n4-CX; Tue, 01 Jul 2025 13:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSi-0005lQ-GC
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSg-0003jk-KW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so3623242f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389681; x=1751994481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EGJGSXijrkKuptWT9xhB3UrOoEMpHnMUKPvnMJKERYM=;
 b=ClQNmybHexf+y5Xap7x/VITtLGkWk8N5mDNiK00qRpfVQg0ezUiafG2KaTS6tlT0vR
 ctblPPuLKutv59gtP6gDnglFtAvFbaxMBxDsoF34J2bVTARkQcZXvSduwhymCoHUEORI
 1jRHgVSvKQ3auyk9mhLu94NTLUj3ikpBtfZrc5g8x7dnKqygGqUK4nhIYLf0R3FbBw8C
 M1INzQUECHl5Ocf5NweENW1bfYeXkmBhUu+TKyzj2k1jOJJLSGnCqjSXNx3C6ZtSSsu7
 Z5wM0N65jDv3HtxoBGsGVI7bOd8rNLmlPLu8xT3hDPbgeJ5T5dk3LcCL8SSQzaMbKa+z
 LnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389681; x=1751994481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGJGSXijrkKuptWT9xhB3UrOoEMpHnMUKPvnMJKERYM=;
 b=R9M2acXHkegKa64n40cZRH3U4PGjsYKvvlve+XQ7Zgxn5XV7QS4cFWXHwSVqXIR37a
 0ZgREYN+3pvN9nAEfLrYKVftXp9TZBdlrUcnsUrsrO2Vt/yltfN3tINbzPYoSQN0o9yf
 qUfseiJWpLPep4/iA1nLmpCDwZhDzEhIur+iWf8+BdctMfp6hqp3CnH+SQhF+wG1N2au
 ao/zVy2TE3onAlrWoeP7D0MHE+nkxn5FEsVhNBpKMKhIT9ILFzapa5FJL9IftRJjtTxF
 9quctFgz4KflL+/N0xGquAWdBh6vnOMMEo9sNUI0aYa2mAwbJtN84KSJ+0F9PlXLfc/t
 DYxg==
X-Gm-Message-State: AOJu0YzCSVX76wXhujjMZ0Ye4ctn/Bp7xZgUfL6xdz/6eSM17kYLm0mU
 EzNM7i3EJPImY25AnEiLsGeWQJPdNOFjMwgQl+vmgyMjarw5q9uh2m0oMT5+wif5wO5h6UbO9AS
 xzZUm
X-Gm-Gg: ASbGncvW+KvTYHQiUJ23GqoNd6zXdhu9exvS42LtKkZeMpRtj+OVZTkWaeX+XHipcK+
 o09jcIAldLDFjgp2jD1T18ytUMlTp5eoPr1JLIJFS2PNmol5D5EwF7IcFNuIKIaA4WvinXts4+7
 2NJ6rcNIypHHjRWjy1mL6F/tIdcAInHQ182z+IRWfhMWTGDtb8y/8a3uZjMrKK2qesnQguRvJ+p
 LJ4f0CdJ1xHoKPpksmnBAaDSH+NhktsjiADhl025C+AG+CQl+krNOrzaRXjaEjIDxF+9y8VEKgp
 JP+Ai58vxLxNryHBo0DWh6Bqme/HiNmHtF8ev2daqdbEYV0pFvx02H01CWpVkyvBelcseShlJ0K
 ZxKw=
X-Google-Smtp-Source: AGHT+IGteTB8Oar82/5wnE99Mnhrc7sz9iunpmpGaWEzwXNvQtLtUHOfS7IR1RdBq6whMlhGcH+UgQ==
X-Received: by 2002:adf:ea10:0:b0:3a5:270e:7d3 with SMTP id
 ffacd0b85a97d-3af100ae56cmr3282079f8f.13.1751389680645; 
 Tue, 01 Jul 2025 10:08:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:08:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] tests/functional: Restrict nested Aarch64 Xen test to TCG
Date: Tue,  1 Jul 2025 18:07:15 +0100
Message-ID: <20250701170720.4072660-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Currently QEMU only support accelerating EL0 and EL1, so features
requiring EL2 (like virtualization) or EL3 must be emulated with TCG.

On macOS this test fails:

  qemu-system-aarch64: mach-virt: HVF does not support providing Virtualization extensions to the guest CPU

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-24-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_xen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
index 339904221b0..261d796540d 100755
--- a/tests/functional/test_aarch64_xen.py
+++ b/tests/functional/test_aarch64_xen.py
@@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
         """
         Launch Xen with a dom0 guest kernel
         """
+        self.require_accelerator("tcg") # virtualization=on
         self.set_machine('virt')
         self.cpu = "cortex-a57"
         self.kernel_path = self.ASSET_KERNEL.fetch()
-- 
2.43.0


