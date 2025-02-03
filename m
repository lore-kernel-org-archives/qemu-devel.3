Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F06C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyt-000877-DK; Sun, 02 Feb 2025 22:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyr-00086D-RC
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyq-0002hO-4S
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166022c5caso57855945ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552714; x=1739157514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dkBfme6EKCsfk3FvCDsWy/MiBC6SNDbFvZSz+KhyEQ=;
 b=BxRwNHkcaEgxh8ttjoaWKX2KtQKAqwBSfFMoMLllzOwTY4WFFZnj/82QYtbC6bQXrp
 HI1mUqEz6UbrcFUF/sh/OI8T0MtFWkX3oH54rpvNRlMs6k45ucYSw4VnEluGnsr70Lt2
 n3g02vBrZmWOhVIFkGjUoWHW9+0DmOus3icFWEvzINfiN1gLqySWrNgFanOX7hhokWOm
 VzZRe6bFBXvsNMyeheIhQk2MfIXvV0GdeK3EUvg+27QcTRseUWBJgYdUIKKRwuhNph/7
 6NAIIUT9ZG+uQSltHW4D/+euixAgrOoyr+wMn4uxsuTTt2yswokxHI0D6aLZKKQxcTNX
 fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552714; x=1739157514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dkBfme6EKCsfk3FvCDsWy/MiBC6SNDbFvZSz+KhyEQ=;
 b=QFGB7vXsLI1dqI2n6JaAmp+6k1uK9/hH51df8JMO8DQ22yptEp4PLwFZCGaoCZmMmW
 ADtRvyt356D2ougBK1ExW8x5ec3PMmU8CCtUA3YKnBUoZZwx2M84nsiok/81yi8/IWjx
 5BiOqzkiCdphIGlVhPBuVO5Bsltn06LqRfy/pOa82LgVYOebr1RvhosYI8LFt3/CTHKv
 D2d9GtCmM+K1hs2Xg6k3MZrKeD7HtWh+zL7OwvfLhnA5bdGzeRN1owUQTQYYPDp0PY3l
 rzrsZ5QG/lbxyyS7xFc3ozBY8zxO1ij4A2T0lJPdJNKFI0ZpPotZVOdH0TGGLMXIZJ8h
 mnjQ==
X-Gm-Message-State: AOJu0Ywire5wP1e/vGjy11GEbFpG+vVHha1KTSyQPmV4MGuI4+ooeRWO
 TSxaJByD9HqFi6cEZBpTlZTOvOLBT72/dBwuUoNkyyDbOTZtQPUba1+Wrg73l6vlCM7E46hKlM9
 j
X-Gm-Gg: ASbGnctVawdPHhLsdopzxXZ66ydx69v1QnCs+bLm1hDI0SL8dOBHbCC1FkEJv1xHStj
 SPpqLZMXqPQjd2cjQB5OErDyR7300t+jbVBlmAO2Q7XxOdwd61JRQCWTGr+At3WNHKNTP8LYP1m
 fYbHcd4iTJJThsbe1Ur0rjiEtA+g5UhnXrLhoewH/5N8/yz/SgNMcqvrrxatN8EHuokqOm70hxm
 rfhaq8Om9QSvXZdrN2EiLmAfyJlA+95byOggWmfGbDpOywuDBZZn36hu2LWH0yewRoJ3M0pk86A
 hZ9hha7p9GmYvXLG4M/xcZ6Ah4TU4sZ/WGTgziPRNVPGIT8=
X-Google-Smtp-Source: AGHT+IEmEIyhTF5A3Q17fhQcBY/Jz5gWk8ozXRZ+LO1na6SXZRf8ZtleI4wDM0luiz2E4Zmas0pKlQ==
X-Received: by 2002:a17:902:e74a:b0:21a:82b7:feab with SMTP id
 d9443c01a7336-21dd7db8d04mr300281595ad.33.1738552713944; 
 Sun, 02 Feb 2025 19:18:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 13/14] meson: Deprecate 32-bit host support
Date: Sun,  2 Feb 2025 19:18:20 -0800
Message-ID: <20250203031821.741477-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

We deprecated i686 system mode support for qemu 8.0.  However, to
make real cleanups to TCG we need to deprecate all 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 meson.build               | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7c61d0ba16 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+32-bit host operating systems (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.  Thus QEMU will in future drop the support for all
+32-bit host systems.
+
 System emulator CPUs
 --------------------
 
diff --git a/meson.build b/meson.build
index 866b8ce477..0dae54da0d 100644
--- a/meson.build
+++ b/meson.build
@@ -4833,14 +4833,12 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
+elif host_long_bits < 64
   message()
   warning('DEPRECATED HOST CPU')
   message()
   message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
+  message('dropped in a future QEMU release.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.43.0


