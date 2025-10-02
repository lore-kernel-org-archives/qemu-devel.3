Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0515CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eu0-0006lO-Hu; Thu, 02 Oct 2025 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etj-0006g7-GR
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EtN-0000rl-FT
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:42:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so481111f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394529; x=1759999329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=nd/eDek43FlGf2auihg1NWL5c14KlCeCgsv37SWbNr8WCyHcyTOu6DUVoUQxRCzaU5
 uIeT6rTc6btr1HzfGHGfk8+u5GlajWcMI2DSm8lim67WrZ3yCfOrB4SPzwhgIFvpVpdK
 vUupIqd9ARCf0pOxweDTKaB7QHD2eIb9rP0L25t/ahR/Gxneh7zjCBO5mnPUia/gioLE
 xHt7zpHwUp/qUS73+5r6NznVDTc5vg/GgeJF53i2s427V+w+4GfaLErIpJZW5SiI5scK
 fGB8KuVDgDI+FOGhrIRqytHkLbVZoPo1ank87JWMbzU4BB5WQzSEs5qQmlM5oE9Ug4BR
 0h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394529; x=1759999329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=Y7OFccj8JxfQYHlPpQddQQnLOWDzJv7TcSOZSgbYz1y20/LnDjYHeQUV4K1jWfYNpm
 c4JdYRct+4KTYGLPAOUt0Prse8m4umZaa5FYIqhBI/p8xN7kld4nf9JR3HaSXKSe9tyP
 5bdaJApCIaPDI/YABJlKjrryCX5i0lsV/LXl5a1odXMZfuI+S+pBmSRmxhq/fBvuqTPH
 SqKi/4kqbb6nnhD2ieJph+C9qQtWqz6ZGCj6Tu1E4IdZD7uSLQt5vAO8XTMVaK9yxCNE
 nIZ3a8KUjhzN7lQcB28XY7RBVNH8NOMoAnde6Lj4qellMMhy+Ypq+oyJCO5Vtu5nWbdG
 c2vA==
X-Gm-Message-State: AOJu0YzzFEpGdS5pPR16wxAA3cP6JVrKYyXJ09zf8VeUBCvivvgkXYIX
 ZIko+aGF2T7t6vA72g7f1cAxSHEMa/SaH1XxmH+yAVmai8ysNBzkWct4F9Lf18nG4kEEsneIEG0
 ACLPScMvGAg==
X-Gm-Gg: ASbGnctxwklghyR5ZMvgHMDm2D9w/mlCV9Xol4AXpeVhR8gF9HsSHC5i/oM7MhZERgK
 vqoYbmJ99t/aJh903FYtxBxWb9n4PD43g4uNh50BxruIoxAzYoLFswBqU5iR1vuqDP5lMkssgMv
 LTuC8YAaDS6zBgv1x2pnFGenly+opUNW3irXRCMGvPYZPZueZHtXB4+i9BOcRchpXjoG7AA3c2T
 iLx6LEzjyhGx304yOc1DJdL5PBcKKP4OaDGvqsL3AmtmaiG+0ZZ0O8suinL05RodtxbYyvny8OP
 cyNYb5IogG+PMfusnB9bgmxkd53vuqDWUSbAI0Gdt/AXkrsSLVOqN9Dx5foj92mBCSFj1S/wIea
 RsxHHbNyLy8sxn/TSu6KRRCNpsYWfdL4/H0KeYMgZbNgv/lZ71zkosGqpPABY6n1qzEpDHbqKJp
 0MfvIoNZQszv/MY79oK7BN4246aNRpLw==
X-Google-Smtp-Source: AGHT+IE1u3COjNq+oE6xio5GRW1A/vqSgcySFumrJ67RNAp4nOAK/5HZJkMzy+g6L+RiVVekcEJmKw==
X-Received: by 2002:a05:6000:400c:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42557807a65mr5230357f8f.14.1759394529461; 
 Thu, 02 Oct 2025 01:42:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b40sm2649068f8f.2.2025.10.02.01.42.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 01/17] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
Date: Thu,  2 Oct 2025 10:41:46 +0200
Message-ID: <20251002084203.63899-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Update the documentation after commit 3c8133f9737 ("Rename
cpu_physical_memory_write_rom() to address_space_write_rom()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..f9b565da57a 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -474,7 +474,7 @@ This function is intended for use by the GDB stub and similar code.
 It takes a virtual address, converts it to a physical address via
 an MMU lookup using the current settings of the specified CPU,
 and then performs the access (using ``address_space_rw`` for
-reads or ``cpu_physical_memory_write_rom`` for writes).
+reads or ``address_space_write_rom`` for writes).
 This means that if the access is a write to a ROM then this
 function will modify the contents (whereas a normal guest CPU access
 would ignore the write attempt).
-- 
2.51.0


