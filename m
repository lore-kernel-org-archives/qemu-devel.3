Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F21D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkvC-0001Io-0i; Thu, 28 Nov 2024 15:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv9-0001Ft-5M
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:27 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv6-0001mJ-KI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:26 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so131938a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732824923; x=1733429723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw+i/RTnE1TOqvWRDHCHN95wIYPbil6+hZz5wFKKxjY=;
 b=JgoxDV4WyTSsbUyHbjbeA4eV9g0A6v+lWKpsUMZcsrJDxgBxL8eLqLuWi3wTvEDAoW
 ropXzZj5X64w4h8838Kqmp7Jkx98SHIJEmsG7j4OnMOKBEa2/1AxFXbIJJTkLxqMdV6E
 h1pvFGJI8BThcNSSIRTt7sRxfm5lU8HhdXmJBfkWlTIjiZ9tRSs5m80JflGH47OBXML0
 UqdEmv9vkNvtGc98qkpOzPJQ++A6wxMttGCXrlQVM5uhVb5OflKQWoILcn8t+hlTIeuR
 EGtnySWJU22ariCQRAHKKlbJ4ecmRbv4VQuBgEvZ0k/OOuxTXAC4BqCxPLP5B8Ed0uoq
 74HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732824923; x=1733429723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw+i/RTnE1TOqvWRDHCHN95wIYPbil6+hZz5wFKKxjY=;
 b=FfDPfCXvLwvbx+FCFJ2Mz38jmwhFBNlv/9s8ESdM/Caonn6BgCD9ZFIxSbBUKQOzxA
 eBqf+4chG8oSmz7q6t91nbbKS/vVy0CxPhIBRFjuVL92TvVU5zX+WDnT+lnAccEWJjWg
 QK1ymXMTWow/ainp9WTywXpORzAgpN1htv051MJcCS13GqKeTkDyYPAdbwmxxpflLWNJ
 eY242cCOWHv9SZB6O8CzGiRG3V7oQDzsfh72KlieVyZ7cIhMbJTbKob94TwTxz60NEfJ
 oAStHs6HaGlOpMNIxwvNHk/Um2GOKcWl3myI9JvZVAQTO/Vv7o2Ly5++VdNv7KrfANce
 x8TA==
X-Gm-Message-State: AOJu0YzYr69NpbOiKQ0AgcBbcDIMfxy3AnVjGe5S7llIv5s1FwRPKodE
 mih0cd/XNpXMVR8bUdfPZ864pIjGmATkXbrI+nUUC8COdy/Khzh/X3qRVHxKy8iWRitJZ38TPfm
 xUMY=
X-Gm-Gg: ASbGncvKGRdFIxlVa+TFGkINtRcCRf4rXcTwWSlrFKsmmT1VFkyA/porlfceaco9vvN
 xUe4KSYkC7o3R4wNgu4TkUpBN3jf1OX0Yx1r3ZJwmUMekxF7zK52Aj8tMs8P7HTa0CFfT9KC/hQ
 FppQ71JDxj1An2bIBICUeTCN5gG/z1T0rArE+1w4Q+uZ0UTj5vj8RTAqda00aFavMhw7fDxTTw1
 fcnSSHEDhhnurYC6Qb7TAXxMXY3S16sKyqDjgJUeNnM8LVUxlYSf/fTUHpTYOSUjfFWjv/izBcK
 i/3Fg1eU2xATHg==
X-Google-Smtp-Source: AGHT+IGUkkRsIWbgqIrl/CWoZkmRUDQipCAzO3Uwq7QfeYmDRCedAnnRp7cVFOEB3h6Du0O6hLImGg==
X-Received: by 2002:a17:90b:38cd:b0:2ea:8f02:719d with SMTP id
 98e67ed59e1d1-2ee25b0875amr6470479a91.16.1732824923125; 
 Thu, 28 Nov 2024 12:15:23 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fb10049sm3912861a91.43.2024.11.28.12.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 12:15:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Thu, 28 Nov 2024 12:15:09 -0800
Message-Id: <20241128201510.869974-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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
 docs/devel/style.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b500798..2d73e6a8f7a 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to lay them out than gcc
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, and on big and
+little endian hosts.
+
+For this reason, we disallow usage of bitfields in packed structures and in any
+structures which are supposed to exactly match a specific layout in guest
+memory. Some existing code may use it, and we carefully ensured the layout was
+the one expected.
+
+We also suggest avoiding bitfields even in structures where the exact
+layout does not matter, unless you can show that they provide a significant
+memory usage or usability benefit.
+
+We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+for bitfields.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5


