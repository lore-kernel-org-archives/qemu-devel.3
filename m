Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB68CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99DA-0003e1-S3; Wed, 15 Oct 2025 17:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cx-0003Zj-0s
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cr-0004zQ-LU
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so84584b3a.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564327; x=1761169127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=LB87uYO88nQTqc+sLFC7VREc8Ve5kmBysGbOAJ7g6K37G7XU0gTJ8e1vWApsMxYCdy
 KidN5vtCQNagtmczq7TdE8aCqaILiXKDgfgoCBJONiNhP/ajFuMi9S5GVpMI0koTIJus
 TWb/mgeGTAPkMVUjO8J/hJxGjFPckCNZVXmKdhYVCqLCGp6FW3sBOsNKBQAQUB94rW9e
 dxVwllTSC3xfqISRG6NkpAHVDgn+1i7YnlmuF0ImfRns8g+xfSgWE6hd7EkhMzcVWZrU
 j5lC0c7SXYtGC+XivkjGZ+xQEu8/y/Yg26HWY10ky2bqIOGn2b3gIh5GEcc7DSi6KBnq
 Kpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564327; x=1761169127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+w5No0Ep1LX3XR7FDPjD+GZNr16ogOShPRDBWgvVMw0=;
 b=ghDzh74KDhe7qtFEhknuvZsckBdIrNtNOas8oE4Fe0FOKOl1uhR0INwOLlh//vVo0Q
 Vs2Zp81KSzIByBAhs+9LWV4YwutRbuDRvJrEwBoNq3eq4oqQ/35u6xv5p57nz1y+VMDY
 PV9RzzHsvPUGUdw2rXskXNQ3Ro5ikBOXs+tZ1yfe0vLANLajHWrXOhchbTNvm+4dOsaD
 vw41SDzdIKdzpXFB/6R1lv5gzoY0dtig4amWV1WDcr5pVT+suIll7fb6CXalFSvPbCtT
 CnZUsofdGLN0VCLOn1IiCb02o9G8DgCw+dVUjWOqDrlQMk3TI9Xui5I1RspEM8ml55Yt
 1I3w==
X-Gm-Message-State: AOJu0YxI16DAD+lZV+Sj5Sy8pS23+ge6Cr78PeIxQUvZckCiTkgQMvuO
 Esj/d4qt+njHHp9yUkhjmmSs9uh4EuZhau2KjKSsExE3QulvitRd3BFTsm9V+Znda2ch04chbW5
 ++2DIQ1U=
X-Gm-Gg: ASbGncv2tWgOBNBMrb1JQkEFCI9nPjDRAskP/7BQNwsxoQ95xSSIdnMG3KR8W55iSiZ
 T7WGMQpbp632whdUenWoTnK6Vxu10PNX8xRMc6njin6HSn2EgguhmZ2j2DxiPafIY0dA465EWV3
 SMmoC2wI/a6zjXkzjPS+UHlaX6w6E+o+ohdo+F8MoJ6Zc1p8fJzir4RLciSr40+quGzHFQfpWWe
 R8d1lmhHXK16BGtBS7lvGAYHwoks6ivueUG/2W4UyD1j0xC8cjz/OgS+iCy1cj+vUsbdYzARC3y
 YqlV1JT0lhHWWIGvMkenkeP6ZCQBNFINz8L0fUv+HpDJBI/2BCM2mSgsCSvw5qjBM0DQh9fE0XJ
 sU4uwOxOJvoCcVJSRszMSHxRigi9YSgcomNPy5UCSL4bhB9ak5DIZwCEwccFJ2g==
X-Google-Smtp-Source: AGHT+IFLXtTT8xkjpMMT/+twPFiZtnoqJIfi9qSDoRKMMVQusYfy1zH4otThSohMjAIzf88rLx0lRA==
X-Received: by 2002:a17:903:2a8c:b0:290:78b2:675 with SMTP id
 d9443c01a7336-29078b20b87mr113290275ad.41.1760564327125; 
 Wed, 15 Oct 2025 14:38:47 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 3/9] kvm/mips: Remove support for 32-bit hosts
Date: Wed, 15 Oct 2025 14:38:37 -0700
Message-ID: <20251015213843.14277-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-7-philmd@linaro.org>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa0172..c5710a6a47 100644
--- a/meson.build
+++ b/meson.build
@@ -295,8 +295,6 @@ elif cpu == 'ppc'
   kvm_targets = ['ppc-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu == 'mips'
-  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
 elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
 elif cpu == 'riscv32'
-- 
2.43.0


