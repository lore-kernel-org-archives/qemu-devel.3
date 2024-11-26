Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C63CD6555B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2wh-0001Vn-0x; Tue, 26 Nov 2024 16:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wf-0001VD-Ek
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:05 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wd-0001b1-SR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:05 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fc41dab8e3so1137320a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732655882; x=1733260682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elyeMJQumM/ae9b99n9BARezLApCIDcQzZJOkDjnTNE=;
 b=XXHjQ2jZtUpl1ahosr/fXlvZW8eXLI34jaSg+2V4tQ+WEakH+GQlggcLWV6H2ctdgK
 KVj8d8UaDaM4aCjgXeEZqSw+fjE9T+ipTdoiHCmBJmV/IFh3NbikoCZ1aqO4rxf+JDKP
 V3p536iRlCYolsVausdLRIMnNj746pFuqO4fWA+cpnJtAwVR0hKJDaNa2Jk2SycihW/O
 Xw/HNMLBdG4hv1HpQ17mThw0QdyYHSDXgCZV7zEexJym1iKm6wgki6q/3WtUtipyZ8ss
 lsQ0AUgzXWdj4wNA26/Z1ad/6HCzF92kC6uKQrgphSNcPVKOzUgWP4vKsZ8xyOGFeY8k
 S95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655882; x=1733260682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elyeMJQumM/ae9b99n9BARezLApCIDcQzZJOkDjnTNE=;
 b=SKzmjpQMPS++j1D1CYixg9jocAQJwAgQQZz4+Ij4tOCQ8uor5p+XjD8iRBeJw3fHsA
 xtHQ6ikmVWMhnq09I3rKW046r0vm5e3QvbEQStgdSclnrAc/3z2ue2/50Rk6/471BdI4
 RXrgxwrHbeF+sayzDGYbD4COec7eKBoAW0Ciz7eAvjWP2HKqxSn0Mc91zuTicTnv7MS7
 0vzSHezSDZt9PIf0h4ZmS+cRX3/j1K/ofAoCEyNT5Qv7CbpLir+kKfBPxTyw8LE0gNfw
 mUILYa9KnD/uGLOu/DNNxpbumsH9L+fQSz0yIJ7V75I8/BTlxkSzvdNDwRh1lZc6KlQo
 r4MQ==
X-Gm-Message-State: AOJu0Yzbt5ZpxJLWPWGXvFYpiDfc8xxZGDsqOu2jGIXF/ofZhm5QVmMY
 izUkTo/UH0AdLAuZbTwpNaE1wHtPKo4QdqA885seifKLDCSA4uhFkuswAvwQfGxrrFh6omGQ9Mm
 vIqo=
X-Gm-Gg: ASbGnctdlO0JzPAFQoi1ZaezPjj9a3mXj/DhChLrUn5cZYZn1SQd90KIcO+OU+Dj/kV
 3Lo0dqVbzvDVsE3nZbBlMlO5A2TEaMF8bvU91DEQSZc1V4r/r+Z1xk9sBp4gsw65blH6D578yka
 6hjTB4PBWZ6fcaeDagA6U/Xxoz1Q4wX4Dk2qyZeRRCYXu6soky/5kA3ViMc2Y0iKfLgoy00R5n2
 wmG+mtcsxPuburRqHL40p8hFS4jXO59sv6vC55FCU6Z/BbKGd8vNLBm3E8r+09AFY3rtuu5jRA5
 ottXMUmPnq7K0Q==
X-Google-Smtp-Source: AGHT+IHxB6iWZ2q4QtORdnkudYobbXohaNknCVP0sUkiJ/TLF3obdZNTBwp+OzaY4I7WZuaVNCBn4A==
X-Received: by 2002:a05:6a20:2451:b0:1dc:bdbd:9017 with SMTP id
 adf61e73a8af0-1e0e0b6c85amr1532603637.40.1732655882476; 
 Tue, 26 Nov 2024 13:18:02 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724fd95ed01sm5811766b3a.8.2024.11.26.13.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 13:18:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Tue, 26 Nov 2024 13:17:35 -0800
Message-Id: <20241126211736.122285-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/style.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b500798..13cb1ef626b 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,16 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to layout them than gcc
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_.
+For this reason, we disallow usage of bitfields in packed structures.
+For general usage, using bitfields should be proven to add significant benefits
+regarding memory usage or usability.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5


