Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28D3C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2ak-00012x-68; Wed, 02 Jul 2025 14:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2af-00012G-GD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ad-0001U7-Ug
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a522224582so3819595f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482430; x=1752087230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxv4WhKLwrx5svsx0yY+vpPljgpJNa1VqbPNSHemHI8=;
 b=d7m+xiFYqb2VKn/Geed5pHctQ54NIgg9N5weqoL+NWgvni453eeFokv9vlvHWjDtkD
 aLcdbzTVvoEN2LTkwjBG5M8mgaCjTBRgNfSKU2YSnv5QfnNpYwOB3BWOjgO3hTPFdRZQ
 XLZS+z/lO5Qgt1/OgAUJCIz9MyYFmibk++OFo8Y42Py+xtTj3rUvTpLVREkSwsBjAwQN
 9HCVD3wWgiRtgBvsjj/ucv2JZZlr+IH3rY9yYCaYWXGNG9pIDVN1nuUyEEezltQ9LjHg
 J2p1C4vtSW0AsLbXiz6msxcjn9LEbCC/y9wpS+ErfS3kyrj4e7dvKLvKnGsaD9d4Y2Ob
 /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482430; x=1752087230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxv4WhKLwrx5svsx0yY+vpPljgpJNa1VqbPNSHemHI8=;
 b=UBAGJOnm8TOOMBi1uCYHc+FI6QNGrVKQruGk/blqz9CC7ivsiEZ0y9bUkKwZNvweat
 1TNroBaMBf5uxkm+W+sDkRQAYE4SO9W87sWYcnpaWz77usj/F6mITt0viM6Ggfe41OgR
 e+QcK0nLUPraV08QrcHaKUMDKDQ26bGiT+HAZDyMBn58KkYVzfnJVCL/fqCeZgFTr566
 4s2ECA+Vet0GMutAQxKCh9PEdCqXy4bub8jZqaitqmdLBl0eeu9mvzGdVa33jwJAYGG6
 9DIoTwweXUva6BNhM2XuE+4t+J1x7aM1ejve+eoFOcL8Cbtax+7UHjr87kLULj8xQ9aV
 J9ag==
X-Gm-Message-State: AOJu0Yw/S48iSTpdCuOc+naEWv2IqNxcECcFHXL/PWqnnpCgdo/qcHyl
 AEwr+qpOQs8DO3Z/MHx5lIGTTJxDR385pyfSBpb+DYfSqf9vxfaqerwE4lqhSXzUOYVDjcWIwCH
 Rp5d+
X-Gm-Gg: ASbGncv2Fn3fLHfnnbQLbYeM7bzSR7qs73yVo9J0YxUKcYMDAnsQEhoaU167ItuDhE8
 ngz+lEO18BsqdKGMOmYocHscphH0QpnJII3FsOjhdkMlg/0QAkr2/E1SLTpjeVESx3a+Dg6Caic
 fsS2nZGBJzvRrvquhbZIK0nR1HmJoKLhNnGWLgTnowXCBPbXoJvJt9f/Rc9YqqpZR2LGdVChH5P
 OvMSWJfB4rnVS16z+NeG0vPYbsV8kfrPmwokBTmjB8CGGR0oFOWdKq5UzqRE/3EMZodGdXPx8EU
 iJsDCUq9Jz0ZL6NxVygFZ3eP9n9Zn5DIBH9TAP1Q9UaJgH8CMYfu0MrGvdk177/RIDPcUOm00E8
 /rqSNUdA2ekY+ANgjJ/12wLkfJcN4VzkUQa9h
X-Google-Smtp-Source: AGHT+IGcmwYN+MpWdIpNTatRzjNKDuK0lyDW5kg9Alf/zuEkVNEtjog/LyMzy9DLe0gfYEDQLYpxKg==
X-Received: by 2002:a5d:5e88:0:b0:3a9:16d5:cacc with SMTP id
 ffacd0b85a97d-3b32f666188mr200862f8f.49.1751482429694; 
 Wed, 02 Jul 2025 11:53:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ca4sm16833767f8f.58.2025.07.02.11.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:53:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 02/65] system/cpus: Defer memory layout changes until vCPUs
 are realized
Date: Wed,  2 Jul 2025 20:52:24 +0200
Message-ID: <20250702185332.43650-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

vCPUs are not really usable until fully realized. Do not attempt
to commit memory changes in the middle of vCPU realization. Defer
until realization is completed and vCPU fully operational.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index ff0ca40222d..8b2be31fa7e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2792,6 +2792,14 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
     /*
      * Defer changes to as->memory_dispatch until the cpu is quiescent.
      * Otherwise we race between (1) other cpu threads and (2) ongoing
-- 
2.49.0


