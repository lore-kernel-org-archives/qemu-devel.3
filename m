Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71938C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLl-0004Cj-B2; Thu, 16 Jan 2025 11:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL6-0003Wl-QX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKy-0001Gs-It
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:24 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863494591bso622590f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043395; x=1737648195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=UZiYT8pV7CVqo3bfzEUg3KUPZQK+CrufQCr9/6MAfZqcgViw0xDhnAt2LWppA5Iu1Q
 sqBqXp3oCSk0fa41LDXWh7oUCRnr9fTK971zEpjn7QYCXeQqNJyGReCvFtwiUqjzhKVc
 fJxnZ/w97ykdEokrh6+oPeupF5lJiqJvY9OxIZ7vhcGLOGaqJICtr92oJhZ4ntKEfoux
 83gqPLyT+n/UMiAe6AAwBCpYBpitogfEg0L01ly8cn5vj7xLWcWyR5jjMNyl2jau0WlN
 Oy2e2Vzr4C7H4ww43WwPltXXwuZhn6IDoxCwgPzMOUZcj/aIHQO8w/a/rIi1jIi3l31H
 bnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043395; x=1737648195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi+ukBCOErHL45ERN6Ib1p4GgIF2LltQZlgS/5QMd38=;
 b=LHQN1S2Pwlp/EePA9dNXBW2/OtVW82hr0ESqbWdZ022OzEbqGgXOFlg1nNVYPlppV6
 gJPH251P9rDhAXGMmg9vSm8wu70mcHVoe8tLqCbLp242Pd75MLFr+pncYUpPdteSTyq5
 eMLz0UGuVkhvA6qYGQsYAojSz1e1Q0IuCQAk3iOpx+dzOV0XjvO43qTlt06FGOuEAHAd
 h0StSR3+YPlTYPRUAbjQzUlUGvNs681Infwb5qnuVkhvL6DCXuY5HAjMLPmzAQp0z0rx
 2n8kfimk1WFBGPstyv8pgk/uvl0Ym4yGJyRTY778/Yx9VJYY1Ij+/vJ+gNFwnvior/z0
 eFuA==
X-Gm-Message-State: AOJu0Yx0exYA8/sM9LBSH2shcLN0xRLpovelfdHKzP2qTDElalK292cc
 kBIwANiirAQAql04a4CvMSgkWaWy1t9SdYlmQFB+aiPJmChtr1Tff9NTFAC1OO0=
X-Gm-Gg: ASbGncvszxGnovG3eN91357WtXmXIklo7+QoVeiaplzXU81n/akXeu3youpRBPmjxol
 WT3tlw5dV3hneACCzL+N4tQz3BMKU3sxLTrG3nMcgwI95TS3qwMQtOuvfEa8UvzcJeSs+Ms0UmA
 tWfpKr2r+58gVPDeEu2bTh+E6J9ZUwxtQeMyfeLes40xsACGK0n0oCxZZAh1Kij8/PGsmWzn9LD
 hXi+/0clkiwnJCJA8CwclhlQgkIjqIF1km1TwN7SAt8kgvv5DN77L8=
X-Google-Smtp-Source: AGHT+IEM8OhDDPxCfsPHSX9ag4x0M1lRCc5ZmiRBoydBlmP/ot68uWyEOA8PSR8/WfiHQjdn6PSBrQ==
X-Received: by 2002:a5d:6d0e:0:b0:38a:a117:3da1 with SMTP id
 ffacd0b85a97d-38aa1173f70mr18502878f8f.5.1737043393558; 
 Thu, 16 Jan 2025 08:03:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322acdcsm221210f8f.55.2025.01.16.08.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1702C60865;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/37] semihosting/meson: Build config.o and console.o once
Date: Thu, 16 Jan 2025 16:02:36 +0000
Message-Id: <20250116160306.1709518-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

config.c and console.c don't use any target specific
headers anymore, move them from specific_ss[] to
system_ss[] so they are built once, but will also be
linked once, removing global symbol clash in a single
QEMU binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a19..86f5004bed 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -4,13 +4,16 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
 ))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'config.c',
-  'console.c',
   'uaccess.c',
 ))
 
 common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+  'config.c',
+  'console.c',
+), if_false: files(
+  'stubs-system.c',
+))
 
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.39.5


