Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121EFE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFf-0007m0-RM; Thu, 19 Dec 2024 20:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFJ-00075x-FD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:07 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFH-0004Xv-UL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:05 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728f1525565so1731978b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659762; x=1735264562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJY1Flxg9aXR92n2V8B8X5lq0zaZewnkQsTGkMNreb8=;
 b=ZaM7VMSrQFLF3vhnYqcvm3kFbzeFqBjJ9Cn0BqhqEvVwVAa36oXzzaHjC/CujLfglX
 nn0VM5V1W+alQ3KW1MwcwMiXPKcMeMXsnDG2w7WLpiMyiOD1jpEuadVdqiCOgQfYl7yZ
 ZZDk03wBePt7pu/UmlNeVHx3u0xYi/nehl+xdnjNxzZjnuavHJ0XC5m4Hm9rXiw1aTtm
 Q6tAbEBJS0gQ20HTKvM9Nj9Qx9WmgsvsHJdnV9LqIoKZfemjqeze0OX6cNjFBtN/zZ2o
 VmcWvYN9EcIgAsL8ZaU8RBFAFdGNcawZy8bG1USSeqGkS78c4rd3a7ObLYHruE1YxCqm
 xYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659762; x=1735264562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJY1Flxg9aXR92n2V8B8X5lq0zaZewnkQsTGkMNreb8=;
 b=M2eHN8UdN0g66FhnH94snFep/DyFPIlH1seoLzQs3N6FtzkrVJVeIXexSvoWvLg7nW
 07TBHkfp/q+yaxSszqW2LY976vm11pczhvemvC5ls+ZssHIb/8bJRZNFosz9Jj7dUCFW
 mRgFSQ4ut9vvgXs0cs+qUN1uCkqzKPLvwtidqcy5Fn0ShZwF1IsdnzjjksdlAglKIEVK
 +5TbgLh7ICRRecAG1tBohXnmFWDTX1cecCj++DoTjimTv8imaOa4mK/qQqIF+2gtnnEQ
 oKO7s4eJACHlMV82VBcNkealJpIpLRF5WMm7xWl7taYE8j2/aY3B9lsJGZkPI1bZTYHh
 rdSQ==
X-Gm-Message-State: AOJu0Yw2O0k3LDSEmi1Ge82MADB1JDT7keYQG8rz+TnY2+rT9MmK0tUV
 X0QDLf1ZFsNOSgOivLaY+N8/OpR2TSbx9SOcBHcPo4vThGEWm6MKhUc7413T
X-Gm-Gg: ASbGnctvQTdihXTlkG8vELarPnHUBVh7/W25tIsSgWeLunFI2IQx7V2WTl58UuCuEJ2
 CVlGvYNaBe6h37xSQIQKxIVkXJwAuerqALVspp84bP7HWXurTWlblkoqgwLtZ4TsjPkL4wJRw9A
 BWKeyUEhZdj9bWVFh8UfmErsmv9d0XnwdJ+DMlY02EMgm0GzL2SugUKQcFJ40f3QkH/jqRgUmYv
 M55rz2ko1YgGSN5dN7a8MUtEO0Z+jr2u3yUnAHNKP2nYYjdWmaIIrqPyirp7TOqlztM2doY/JIm
 AwNrsW2XsD5svmZVrQtzSh/XCZ9GlgOTB2Xv8xSnOy/Oscqvw8P53N/0Rg4bqNU=
X-Google-Smtp-Source: AGHT+IG1Am0d3QjANCGpclx0Zv5g9dRvwWP5WdNqU63qZViRAesv4HYkT0w80nhwFY1AWoCkL/c8jQ==
X-Received: by 2002:a05:6a21:3998:b0:1dc:2a02:913b with SMTP id
 adf61e73a8af0-1e5e0459dbemr2424097637.15.1734659762483; 
 Thu, 19 Dec 2024 17:56:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 23/39] MAINTAINERS: Cover RISC-V HTIF interface
Date: Fri, 20 Dec 2024 11:54:23 +1000
Message-ID: <20241220015441.317236-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The HTIF interface is RISC-V specific, add
it within the MAINTAINERS section covering
hw/riscv/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241129154304.34946-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb6a66f1f8..1076a028a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -324,8 +324,10 @@ S: Supported
 F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
 F: target/riscv/
+F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
+F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
-- 
2.47.1


