Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8882C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsj-0004F3-Hd; Sun, 09 Mar 2025 13:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrs-0002I4-75
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrq-0005Ki-56
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so2908010f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542912; x=1742147712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2j5qozhrVzu1N/G2xhrynmmN+iXrSfQjBnt5OGaKis0=;
 b=GvI0Ujt2npP7/UttoWZnw6RYLEq2giSO23+qdkVPEqbery5fSWGttrgNHAJ8mi+cKu
 BVxAVa+K2qovef2bFJRGozuxsUomEnQdum92QoSbrTF4IG6Bgl2kRREdbOzVOjiTv77m
 okXN/O6Rnc5p1psOffiQ+u7rXQBWJvsOanXLLVfogceLCkQFK7hO0D/kefKgT/DhUCVz
 cmrtnOy2BFnbNVQsow9Aiabmo2hEgE5qFBdrU+TEAfwOj5TdL8UoeCOj6VBtCeQB4orQ
 nP941icqw8BZC5uTSEGZePiKD+GhrfgP8QmtBynWNI+7X/ZWo+egxtMPjQ6p/we4KUPg
 1Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542912; x=1742147712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2j5qozhrVzu1N/G2xhrynmmN+iXrSfQjBnt5OGaKis0=;
 b=CjrqrkXSSw0meZrVpcMdpRfMJ4DJwQDyNGxo+0gb6x5VbWo3ky0sLgnmYpDmBhY1M+
 0N5pUQBSzUr73wKzBzc6xE9tSolRQj2bW+gmWdpInPjppX2FlaiLns23iUg7JJb/P7df
 doVNG2hEJZZPMCsVi/9WoxXvsPtUK/cbKne1u1XuRqugsX0A7rhqa0Eu4mQ9/8ZcceFS
 qzMVPhRup1blsZEae1rAGMpn6CjsFzVejzxtP9b63pz+gAurbjMmTQCOGw/UGnGouYwy
 MTXxiEU9z5/acet16mRi09Js9cKAcVlbCDFxPNuVQB51yT6Sh0iHV5jDvkdOhCZFo2T0
 S1ZA==
X-Gm-Message-State: AOJu0YyauyfOWTvjCIWuU3JjwjiZ1kHOkgGZaBjqUqrTpeMlMiWqKC5L
 /DSBae3seJwMis39EWjL2LT60rEjSWMuryH9rEALnoWd0ab5VqwEwI581PtO5ExZ4VJ4hgpax1w
 YjN0=
X-Gm-Gg: ASbGnctt9Y+tbVzkxEJ8RUrY07m+ipPraiHl0qLuMJYUljrH+nw/3fvoUcw1kmJib5k
 k0ZSj4LE+K4b4Ys5Bd9TBI5EKuu1fCUjkhdWhdJ9AHYo2nXsbwsyOuqSkMn6pRaoSOeiwKROvK6
 /ivuQxpvZyWjQhEcVgBejVP/SOhtGpUDBcAyyHrDyZb5jC3v+KHDodMW2RXB37P+kpcsPufcvx/
 s4G253b6LoOtQthRsblBMVg6Kd37P1Ax4dc4PC0LTWuS03fQOomQC+LPrCpFOAHNLSjE5cM2BUj
 bJr2FTfqTEdwKGlhB2O+/bKa2lyj8Z5h7a4Apdr6O18jbZaDmzLwg/0oMwQBhX8II2Vv8WXa7vp
 10dO36Kv9kCQFxCMMc7Tqa5iQqjS+LA==
X-Google-Smtp-Source: AGHT+IHn8ymPcOdNexeqY2AHI6YHdUmx0UOPzoIT4955j6ZHIkadod/sxewDU+pJ5K2Y8PB29cC3/Q==
X-Received: by 2002:a5d:588b:0:b0:391:3f64:ecfe with SMTP id
 ffacd0b85a97d-3913f64f09cmr3227884f8f.10.1741542912024; 
 Sun, 09 Mar 2025 10:55:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102b62sm12228970f8f.84.2025.03.09.10.55.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:55:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/38] MAINTAINERS: Consolidate core exec/vCPU handling section
Date: Sun,  9 Mar 2025 18:52:07 +0100
Message-ID: <20250309175207.43828-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Some common cpu/exec files are listed under the 'TCG CPUs'
section. Move them to the generic 'Overall Guest CPU Cores'
one where they belong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250308134938.77267-1-philmd@linaro.org>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ac04f35201..618d75f087e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -152,10 +152,7 @@ Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: system/cpus.c
 F: system/watchpoint.c
-F: cpu-common.c
-F: cpu-target.c
 F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
@@ -165,15 +162,11 @@ F: util/cacheflush.c
 F: scripts/decodetree.py
 F: docs/devel/decodetree.rst
 F: docs/devel/tcg*
-F: include/exec/cpu*.h
-F: include/exec/exec-all.h
 F: include/exec/tb-flush.h
-F: include/exec/target_long.h
 F: include/exec/helper*.h
 F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
 F: include/exec/page-protection.h
-F: include/system/cpus.h
 F: include/system/tcg.h
 F: include/accel/tcg/cpu-ops.h
 F: host/include/*/host/cpuinfo.h
@@ -497,12 +490,19 @@ Overall
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
+F: include/exec/cpu*.h
+F: include/exec/exec-all.h
+F: include/exec/target_long.h
 F: include/qemu/accel.h
 F: include/system/accel-*.h
+F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
 F: accel/accel-*.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
+F: cpu-common.c
+F: cpu-target.c
+F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
-- 
2.47.1


