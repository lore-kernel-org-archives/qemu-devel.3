Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D303BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrr-00041F-E5; Tue, 06 May 2025 08:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrU-0003SH-Q4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:28 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrQ-0003rB-Hk
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:28 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ace98258d4dso816661866b.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536242; x=1747141042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrjj3Vr6gOoPCa7cX1AnD90niEKE+Tpmh8nhs9K2Ooc=;
 b=r6ddQtZQi1xG5GF1vJaRa5mYn1XLjoVhMke5QvTS02g5TgF2snznSPcEJeeLlojs3l
 PcRbtYhVzFzsxlq+JTj2djTWXD6pV8ZSdyC96gNHHq5lkrNoeci6bVi/qwrK5NQOVxAA
 DXQx6Vqw0TFRgGEK0EI2QOUddKA/lpoDXARdkTQW7z+YZrvwt7rXf422bzQmUuky7POq
 401hJmzsohEOhKjC+wC4hyQzlo5+hr9BsiNGUsEL8UF1XbFQDzXfhzXxAHfOJQ9rvn4H
 A4eWCvQ9uvbN2RSWJJB9WinChzbq4dCLuJFNp2IO0TbB3JNVFGkEdifRYfUvNvVsogLL
 /C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536242; x=1747141042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrjj3Vr6gOoPCa7cX1AnD90niEKE+Tpmh8nhs9K2Ooc=;
 b=ta/E+/84zZU/wbQGAPUlqBhno/g1dQbaE+RBJA8Tk/V7CevgnDkVwP5SA64PnufRoz
 lOTHmoSs2kvw+zYlySQh/OyF1ahijxGvR0PL6P2ShJc8ef9j5rly/0/xMvCOiERGzGMb
 C6JvotwpTpwawXW+xfwsdTWyUGe6zbYRauL1XqaaXQTHxAC9gH2WRtfHn1oBpG0XEVtU
 qlun4aIiaXu+Mot/JMwo//TSRIk+X9UV+QT3VOCl+p1ulJgDNtu7nxJUTsMd6je6Q32R
 hWOJ0FlUJus48e7ztAGYsNp5Rzp5FkXZpkhJx87aj26NTLo1JnriNczbCtdeZzJ7H5EB
 jn3g==
X-Gm-Message-State: AOJu0YwsmHadshgRfTi0q4zw5tAIa4TiJp8/2lC8fpzgI3/i++HAVzVd
 rqSyFDPX+hkOu7mAryGs0NXnHXQ7mvnAH0q6Gsur7lH8X0hOOGH1Z775T+x851U=
X-Gm-Gg: ASbGncsJBMcoUqlj6hd5Ds2guwlhdSttEhhePcmScqhDEZgQpuy119IRaf7vePLN53w
 5UzRiHZMpjnfgrscy29E0P9jLk2WqbiolR9qxe4YNIgdUaRB+oix7OiS2R1kB89H+9narmmd4gE
 idxQtLmToI+A2lWOGhTw/f78ognGWyA/UevlF/D1veaTabi7C6cULNv0fMJhg/GYKK8xrSAnLl2
 pozbUAySBqJausLM2WIBGLo4JhoUZs7vPP3JfQH5ei9bsvkJKqjWHZZp6KSkgrtt/oeqNV6TPy1
 fP/H5rPzaZusFG/wigQ53zeS4tOk7kXtG9OxSohTbOs=
X-Google-Smtp-Source: AGHT+IH+0RDV8upsjEAe9pEslX0E7jSkACAoPDuGlHIw2M8gjWgm2pNmWxCZCT+thIL7UQS3PnqLIg==
X-Received: by 2002:a17:907:c789:b0:ace:3ef4:2964 with SMTP id
 a640c23a62f3a-ad1d46dd5cbmr251389266b.49.1746536241926; 
 Tue, 06 May 2025 05:57:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa99f321ffsm6857154a12.49.2025.05.06.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B86895FABD;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 07/14] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Tue,  6 May 2025 13:57:08 +0100
Message-Id: <20250506125715.232872-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - s/M:/S:/ for the maintainer entry
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3f9f2680b..d11f8ac18c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2644,7 +2644,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.39.5


