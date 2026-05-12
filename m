Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAAFCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgX9-0002iF-RK; Tue, 12 May 2026 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWl-0001l3-Ut
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWc-0004vv-Uy
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so3767630f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567004; x=1779171804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uq3NSu7zxGyfICygwcVZLoJgdWergCj3pYPA8BG5YpA=;
 b=nO4/+qYF7BHasBCudevFsgGwgPVSVCxVn5x2FuZt6HFsTqbxtxYGZQm4AhzTjemnQC
 UG1Hh2YDxVkeiJoTTGumO0XtMrGd61JhXjY52vnc9uDVR36Pvqhjz9csDGkGokTBedAT
 fqw5Y62Jf9SMt39YpTpeWu4gCazWU4cc0gndrw1bmdmIcqhQqaSEve+K8tHc6Si5dZeZ
 aIqTCjJNwfjklv6pP3GjhogS1JQto5LaAsf+2QMz/0SSlurQhD1maldBF15jCiBzKomI
 njJlL03IiveDB8uSJUWszrYDyOTQ/ayzttXrxC9L1DzsVAat4AI0LAeEiRPqWVhqYJw9
 3e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567004; x=1779171804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uq3NSu7zxGyfICygwcVZLoJgdWergCj3pYPA8BG5YpA=;
 b=Tyu6aCdJU7Ogm7sT85PKHoUmQ9dvU0td4jZuSGgDvCeP5j4LIo3kyKTpsyuAi+iD+w
 phfVDsJHbRPL1+bONBg8JygcXYMtBhLHsmGBZ2jY3w36iY9wOo6NoERMPrkdkafWAAEv
 +1zKhtisYAfTa5mN8W2gnBiVY5Da4A2w8He8UilGZchyoKsTAiFYLvdFmybzVNBc7nK3
 GXBK9TDzheXXFG37CTlNBvXE/El4vS5J5Uh+Ky0tVet/EBf/aWvhY8Ha3EzzGBQdDZ+4
 WEsq83Le05tfmaRtJ5SDudMgzpNZh/UBsFOOGPE0Wp2G0ZDtPUbFyMqnLVEGy4JV76vu
 xNbA==
X-Gm-Message-State: AOJu0YzIq3YWmccM3KgWvAgWQA9WqVztudyEO/+z7h1I1vqib9aS/1um
 utgGC38YysTv4vJrD5aJf3kyFYjzmXdg1rMtz968ZeBcfD1PKGpKwdPJqYN3MW/aeeDOkQEeK+5
 8/Zsdp7k=
X-Gm-Gg: Acq92OGDIUbGfDYVlt6M71Jbyx21aoqVxibqApfE+uK+1cxKeZMOcppBPJxOmh4eN23
 MPVnCvFkS5xOHi4RFoxWGATiIxA2IapdZfbvqu0w4ySW7qlRffVNNJp9D1QcJjaOcd511JZCj/b
 mv1wW5nTOmReBJ3kAm1BBanHLf1rYrstr18uKIA7GtKQssO4sFMBS3/OaA87GQkL96gHkLY5pVs
 sYKnAlN6xbIMbhl4WKDCzskjqsc7XsltOZEJrn8mjDeJ5Uqvbbz9HqB/LlUVbmu9NW1bsdXo4ag
 SOVxBmP8XTxOhEOjaeLtxUK29pUz3e0v0NNOqFsFon3BYheGYezEYJRMxYOb0QvCEXdQIrX9NlK
 1InZz2aLchDEUwhT89wGmi1snmuPbRXP1jujFpvYViHamfrfl+OgLZI/Eh+IvcL8zu9/EM+aTQx
 C1SQAliu8RYlcNTACRzd5JbU9MNLL2aq+oXQZUhan0wTNVt3ecAumL73yqDYY56g/LaMk37OcS
X-Received: by 2002:a05:6000:2403:b0:43f:e9ee:5610 with SMTP id
 ffacd0b85a97d-4515df65daamr41570410f8f.43.1778567003676; 
 Mon, 11 May 2026 23:23:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm29928512f8f.17.2026.05.11.23.23.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] target/sparc: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:15 +0200
Message-ID: <20260512062142.67998-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

The sparc TLB lookup code can handle non-aligned input addresses but
will return page-aligned results.  Rather than attempting to change
the internals of the lookup code, we take the simple approach of
ORing the page offset back into the phys_addr result.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-5-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index a6f76a1ab76..25f8a85fae4 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -913,7 +913,7 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             return -1;
         }
     }
-    return phys_addr;
+    return phys_addr | (addr & ~TARGET_PAGE_MASK);
 }
 
 G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-- 
2.53.0


