Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121E4CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wh4-0007qk-1m; Thu, 09 Oct 2025 15:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgz-0007qQ-Bp
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgw-0004Wk-0c
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso971948f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039563; x=1760644363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gQ12MII2GLnuki7x5AAjpC96M2oGPwQzmOCT2f1vbI=;
 b=ZrdpoQvVikQJzACAj3yHQKvKx7+mOLyYgTDWKaDuvMBi7KnV09vr55d3bjS7iZQK06
 aQr+1uJthliVf5+27rar/GNulA17o7IdqXIeQFvlLXswr71EtZRb7I12jPq1B62iV2zP
 jGI8u1Pj8BdVC6XXEUyctMe/mJpd6nG84EgKpfMlz9Ot96Pdf/C6v1vzlVqfXWQ1Jx/p
 fPAHsjT52zbD5qpmi6EIBxfavhOUy0UErPxhtsAQUMvZmEC7vl53sFdTBLIuxJpJBA0O
 BBcXwUnpMleJ1m1dEDaSfnM2c6YmtcZ2rasLQElCM4IyA1EYLk5rD/MGPmaw/0uzD/CA
 s0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039563; x=1760644363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gQ12MII2GLnuki7x5AAjpC96M2oGPwQzmOCT2f1vbI=;
 b=h28u6ULyaDTZirKfyeiSFcLqvVSzbOdrjh4LcdOlANe8xzJtXdFlviIuY+mLS6Q3a5
 FAL7SpisB42AoOIAMPg/Y2Fhffnhiok8oL161hbiyOl4fCUJIXl4YyYI32zWG0zxSjwV
 hDsRM5KLLFhZWW+F8ulkR9S6oM32LYnz6sV3ChkLgHZPU14sahLOr786R54tebDc9KDe
 x4unlQGPo81T18EhvuBprsP2+FRVj6mG+sD70ieFUSQnaf5NebnngwCHfCdaN8ED9YSf
 uFK420rWhxwZwkOZUGb9i6XrGUumRPWMSVWMrBLiEREEQqfFavOHcDhdOgVvz2RROJmh
 o5RQ==
X-Gm-Message-State: AOJu0YxGqGcWSvrtW990BNo3ZN4Yp1Ov5D7MlkKnwts8isIiXhKe6DRx
 Pr/Ac7vQOZ8pETomwUrRd7TOfj+1dTm6kMGcH+vtr4VqsHJQlReNYxgn14oU0NYIYonlZv+UyXm
 v5TOixaZT+w==
X-Gm-Gg: ASbGncubZQ8grip+xL70q0tK4X5SjncJ8jQldRrgP+WwZQkSQQqtoR9cOn+lSBGYUqS
 Mo0Gqou7PzOAZQl50LdHYJirQA56Rsdp6jPgXSlvOmzGzdPNVweS1KSsBjbQ7tCmwkdoxMTbpNL
 5781lemun+w2CdjEtrA26eELlpbtbISFebGmSVc7XDLbtO4ZqX+LtZgTi3hIWHEDR4m41B7ztuI
 0SOBdlMonbyftV8J3IuQWl29ID+7TEFQZkCgHtd+tCWDV9Mxb+RQlExkvSTzHmwIEl3jT0vp/+V
 idramF7PzFC3k4BlDfh2yUIi41k7+jfRVEyU4XT03hZ7FiFOn07pT76bcxpEmcvu/iDvwpVjFEU
 Tri7xNtmqVNuzPJzCXnjD90aZ0wEMVvgtvHOWTCN3eNey3oV4vphdWG/+P99wRAlcLIowNR132q
 XEREtYjN3d7JSEoWEL5iQnQmvqKCozpubnf5Y=
X-Google-Smtp-Source: AGHT+IFsLGoXbsYR08mA/J7zMYuTGJYlCuWRyYXNWO5dzqkaRQ1xRCbIwbhvB5u4yD1uEb6uAwXKyg==
X-Received: by 2002:a05:6000:18a9:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-4266726dceemr6167426f8f.14.1760039562701; 
 Thu, 09 Oct 2025 12:52:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce589a21sm587753f8f.23.2025.10.09.12.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 6/7] kvm/mips: Remove support for 32-bit hosts
Date: Thu,  9 Oct 2025 21:52:09 +0200
Message-ID: <20251009195210.33161-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meson.build b/meson.build
index afaefa01722..c5710a6a47c 100644
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
2.51.0


