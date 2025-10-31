Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A84CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwQ-0004JR-Q9; Fri, 31 Oct 2025 14:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwP-0004HW-DK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwE-0006BE-0l
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429bccca1e8so959464f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935596; x=1762540396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JeZCJ18nW2KfVj2kUx0tBO8E3UT79l4WIZlMywShnuA=;
 b=wnwoTY6sb4qRh/BDlfTryv9Qvtm7wYZw/tRhWEgqlIx7nLewKdSH0KHpNpIfBfLFGE
 mtqMjqZsNoy2xXJ74Z7ZPschkJf8lGw71UzcAXZdncy3HgExX/KxOa6hAy2e8wNZHimS
 +PBsyFZEbJHuqu6XcY15ZwJ8zWvOXS0tbmz3kgHxqqiuhFcgfljr2fsEp7iKz9iabaGt
 4jRlbLj5SDXb8ySWojqZLnFajYxwMswMwmECxHrnl3JWc0t7y1fkRcMIlN+UpjFE2jpP
 Yt3B6n99Gc8YzWiJiTtjZLYWvdUQy7W6CTGXMlXxsrOt8Ts6Nqe1n/N6xzAAYa/tq6ms
 Xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935596; x=1762540396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeZCJ18nW2KfVj2kUx0tBO8E3UT79l4WIZlMywShnuA=;
 b=RGMWTUu1hWEqP6b4dMX2toM998DH79W8729LRxJ6isZxmtcCJTRYy2KuRfP3LDoh6+
 0RYAcmv+GxmzVPyK6fGRIByhvJU1Eo3PMBfay1AAdQXzRSOZ+sNmFf0M5FQcw9iLdQyD
 zVi6WR9t6+nUXOSFauKFUArXMvfGvWPs51lFNp4d6+WFr7/sHfb6shO9Gj7a1T2n0GPv
 idD57ujePw+XNGrMvVqY2vRAYtOiqyaU7MJh1DlWDtt00U5Qyt5ItuONlhHP6wJ9JXtc
 4MfcvyFGWUt45hHe60Eg2JOZzrIVzQDh9t4G4iTRow4SCfDPbUjK3rwPV4yqS/YRgaHE
 afig==
X-Gm-Message-State: AOJu0Yw99ZMJhtN8++6/SDvNuU7omEu5APTvJub/nJTHrwM7JM5bUSF9
 MLI5VKnehGHvSjxZlTq+734zZ/dQoWPaDKi/zd4/LEt29S3Ucl7MwVz6BKFXHR0b4h7aJ+NWCqS
 LW8XU
X-Gm-Gg: ASbGnctrxVWzJUHySswyq/t0YMLZAeQgdzPKKh00HrbGKVLsujZgJ2ngOFp1a3beY4i
 zKIitG8H4FdWNNpUXe6k0eabcADWh0DFApyNDZrYmctBL02LZ6FP4HRxOnTZzx53QD2FlVHai1P
 0s0ddomjvbO04QsGZ81aE5x/mSvE5MqBlCDz33Vjo0BvIbwhnnT8T8fZWON8UstH4XFgzweiXjG
 G4c3BYQO0LcLBZf5404Q5tdagz6QnRRqPSlbyFFsoeFPphatbm6DyGH+YZzcDOBaY2Tor2yyTaI
 jDbMCOcLQcWZbPsTvostbGIzq93NPr07mvz31CXP+sMhvuOoQ/c0V5hMAOs8IP/surBhkk09aYD
 97W55DhwIfm402nb728BVVitBoHRtaNR5AdLL9yI2zvonilwgqQD2epMAp6GnZO5ybD1bOi/VIz
 fRc85bPah1c+BZaedy
X-Google-Smtp-Source: AGHT+IHRHveF7HXbIPzblNABwmZkeFEvKJeyD0bYkqN/gWMYdGjV5ec2N01BYU4hXFhzI9V9B74hsA==
X-Received: by 2002:a5d:64e4:0:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-429bd67242fmr4160990f8f.3.1761935596552; 
 Fri, 31 Oct 2025 11:33:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] hw/arm/virt: Remove deprecated virt-4.1 machine
Date: Fri, 31 Oct 2025 18:32:37 +0000
Message-ID: <20251031183310.3778349-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251020094022.68768-2-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b3ecd6dce36..6cf8ed58d56 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3711,14 +3711,3 @@ static void virt_machine_4_2_options(MachineClass *mc)
     vmc->kvm_no_adjvtime = true;
 }
 DEFINE_VIRT_MACHINE(4, 2)
-
-static void virt_machine_4_1_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_4_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    vmc->no_ged = true;
-    mc->auto_enable_numa_with_memhp = false;
-}
-DEFINE_VIRT_MACHINE(4, 1)
-- 
2.43.0


