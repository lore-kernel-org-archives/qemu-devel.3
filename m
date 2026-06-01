Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135F3CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5M3-0007uU-T6; Mon, 01 Jun 2026 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5M1-0007nJ-AE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5Lz-0002RK-6d
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so78934405e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780330741; x=1780935541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tBJt5VPSYuw0us/un+O4AjEAIk1KpaEgPJsoctN17w=;
 b=ZR349BFvM5rcgtNmS95sL9uOD3+7ylTJB2QBhoI3Z/k4NeGoZCU2IHup51gvx0ht7U
 z6pfwODnr84b/EiY/z/7Fp6kxXKaAGTyfKWrT15OeBAzYLiBr00s1amoq2WRCIDg8/Jg
 WvcKyXbHidGbLvcM/IpAb/5UOOXHWUsEmpzyVPZKLkTMHVWRuMVLh4X7+/kkWevvx4vB
 7UyYMxy3KczJhA7iSh0Zgq65ZwyS9cqqSERVgF1Oq0gIX4a4ebRL9c9bupx8tAWObigV
 byjqXqbj7j1uN2P+DLEeQqQXlLCWEFWOzUTaRWpWApDRPduLtwLi+n0zN1zNzLy63wDX
 BhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330741; x=1780935541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+tBJt5VPSYuw0us/un+O4AjEAIk1KpaEgPJsoctN17w=;
 b=GlMkPf0ZIuIyUskvwQOoEctiLMf6zJKodVPWaXKcdwSoltmiTdHhGHZhgaIUDbM7z6
 FDI3xs5iAcbF+A4lGpf5j+B7X0l1eCB5Cdi9zOITU6uuC4jjhPXCngAN459EGHkEFuJ7
 JlP3DihHvPP6zbKrHo8Ora7Z3XIGHfNdGOrWPpuZjU26HzU+QhucQXhOppTsACLXDqzB
 8A2Pb9OyLTGERTGykF8iiGJk+lVDmelP4oPAheFWVPrCn+4tP9WgW3649n9rYmcAAN/1
 WWfuStvPMBPFAQE+tRWJJwInGjGLuncNHgFF6jsT4WeDxVppTWh5yJ3eQ6Dcs/VYdtVV
 mp7w==
X-Gm-Message-State: AOJu0YxBMdROjcQVycnRSCrpnOLwACuWHyPB1WJWGdqMaHORkF1PYrc1
 4jSC/8rI3K0w26/cv4PP8j9fd500CoHxzbPa8MmUovAysr/oLfKWqrxHU4f9eHyODQ0=
X-Gm-Gg: Acq92OGvO40E7UWhYNgLkmap+K0imHQgXmhn9sM5PZk2HcA5HQfZljOKiWAPaoihtsf
 8SNoh43/iStZ2vit0Utt/771QVUE48KwP20TorSHWm7hBZ7fTsQNtw+DrFYEBUrXg4unRkNF7/e
 ezzALF0CcqOfnPrvLra8zyQAzNKGnwQJ27nsVoAYBk/R7G1/fOoV9FN9GSRP8P/Yzg1QcXHY6C9
 sYe20zMbSiz9iu/+bhmyGgyymoxeejtKdP9m4Yk84kOComGiRfNV8wsfTrZ/XOH2UkwoGrnxOak
 P7ywVUFmlW1mHADU3MN97yOJNCLQlOsJJDbZZ8UTnr9RPXML91O7TLn7OVvDA+orlY4wz+tOtp+
 U1gTFuAUc8UHu27vLpsfa0evH2V+wq5W6ky/1LMjYZffRo7x5J3/8j7DdO400mOWRwW5OFh8Bi9
 8X+7dpXESeVRO867kup8mrzflrTniFS3koEp/KdiQK3Gtk
X-Received: by 2002:a05:600c:1d07:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490a294e7d4mr207027585e9.24.1780330741438; 
 Mon, 01 Jun 2026 09:19:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490afc41a61sm14234625e9.2.2026.06.01.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:18:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7ECE602F7;
 Mon, 01 Jun 2026 17:18:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 3/3] configure: use debian-all-test-cross for mipsel tcg tests
Date: Mon,  1 Jun 2026 17:18:58 +0100
Message-ID: <20260601161858.182286-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601161858.182286-1-alex.bennee@linaro.org>
References: <20260601161858.182286-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Although we have had the mips compilers in all-test-cross for a while
we had been surviving using the mipsel cross compiler image. However
when that was removed we missed updating the container to use.

Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> # running tests on an s390x
Message-ID: <20260601143129.144786-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index e138d83bc9f..1ceb4d7ecc4 100755
--- a/configure
+++ b/configure
@@ -1430,7 +1430,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
-      alpha|hppa|m68k|mips|riscv64|sh4|sparc64)
+      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
         container_image=debian-all-test-cross
         ;;
       mips64)
-- 
2.47.3


