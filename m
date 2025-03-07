Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA01CC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXSo-0002lr-PD; Fri, 07 Mar 2025 08:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSj-0002i3-DB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSh-0001Fs-Pr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso11201975e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741352998; x=1741957798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zbc6tMUo3di/HoycSLWx0Ju1YVVknJoWV3wLdfwDGE=;
 b=kbBJNw1aY08EoIaB+MPJ35riK7zxM93i8AaPhjzedO1eiEIEc0a3mxHJMxLQp9/ByD
 YzA6kJ6DTckDO8HYKpo0x+5BSArRctY2JvK1b6U4hZj2DmedmZcOnco2zSpabMvXF5KN
 MGr6vEJWFCT4LXfGixlvQAaSpooRZKXvTvVDBWE9FeyQ1TirGAgsCumtBrrhHE/fz27s
 XK2P4jlY4lgJ7mZujJTWLOs1M4Pbird1JGOOtKE+ic//0iBtq/wDs0Py2pJjskv7A+c0
 XOEbK3Sc+x6Vm9c6NSgpNMGgNYmFm6LVx6OGbYDkA75sfeWvE1QQuGUoMAFGBKq+8fv/
 08BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741352998; x=1741957798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zbc6tMUo3di/HoycSLWx0Ju1YVVknJoWV3wLdfwDGE=;
 b=WMn8yQWXPVlTM9qy4DlHceRIsNoCXHtBjtx44adXXF8vLf+X8ttxBuBjF84DUPwMR9
 /+7i6Vdw9KguEcb6HizP9PDCSVLe9tVOP3of83ySZJjL4dqqdH+oi5E6MkGwZYVgwQxx
 nW4f4FON9sEIy4kFQxoM2c2QJqfbzUUBYgGKw/dEbjoqeoeI8jgCDoFgbtXgKv9YtB/e
 w1VtzgLBeLiyx724AcAPtqO96TZwzlEMkKYm9p7EgENRAMOFMIyPBQYsQ0AFnaH8HnWU
 MUG7uVjaWhHAZ95+31hbnTCBClPWBZISV0mXAHJcUWwhmu0HYzxKBSyFBUPOZVlezuOr
 0m+Q==
X-Gm-Message-State: AOJu0YxwPB4/ofZ6HY5/NQ5UUrWgT/j3OgD4NGRgUpiun5l8Nh/AK0qx
 jerW2KKG2r8cC87C9S3qsyyqPZhGZzQIME5Z799aRjJJ5ovAh1a/R9yoFjE3JdQJUaZG5FA5Uit
 O+C4=
X-Gm-Gg: ASbGnct8B2VUctcwqbmRcz7IlQOotTWan3E+8FgTalVKu7Huw3F2IG2wpMl/7H/58oy
 sXC62b84BIrRiCkBgPiIzinIwroMMLChqrIxA11FkZGOCRw6hg7pyZ2V2ASQE/JTUYlag3cs08c
 P+6NbNi0jiwWBVXmfgMXPL3gynIZSTDCqkTro6OfA4WXFjTVeVkUILx32xTUaWn0R/WxE7Qb9Cw
 wLBwIUVFvpvVf7VWR+s6fYhhxHgj44hfkj4Gvb6kbmjSXeKGKCTsiFeiKakaqqh8uo2ZyHsYt8Q
 7e30n/RqZcsV5miG84yBazBBd0Anv+BOfUH4RoCaqx8N6RgkDmy50uy84EP22dc+F9sZjArPmdC
 OAz/frVJprj7fXz87jAA=
X-Google-Smtp-Source: AGHT+IFeMnR0kALRLpDimQ00o5/f5MBN9MocDc7ERlSuozqKVr3aJJH8isg7GGTZv461JMREhiOUyA==
X-Received: by 2002:a05:600c:198b:b0:439:b7e3:ce56 with SMTP id
 5b1f17b1804b1-43c687027f5mr22709405e9.29.1741352997660; 
 Fri, 07 Mar 2025 05:09:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm69681285e9.7.2025.03.07.05.09.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 05:09:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
Date: Fri,  7 Mar 2025 14:09:49 +0100
Message-ID: <20250307130951.4816-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307130951.4816-1-philmd@linaro.org>
References: <20250307130951.4816-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Massage target_mmap(): calculate alignment once, then
unconditionally call mmap_find_vma_aligned().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/mmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 346f2cefd32..28d7e387a20 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -489,13 +489,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
      * before we truncate the length for mapping files below.
      */
     if (!(flags & MAP_FIXED)) {
+        abi_ulong alignment = 0;
+
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
-        if ((flags & MAP_ALIGNMENT_MASK) != 0)
-            start = mmap_find_vma_aligned(real_start, host_len,
-                (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
-        else
-            start = mmap_find_vma(real_start, host_len);
+        if ((flags & MAP_ALIGNMENT_MASK) != 0) {
+            alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
+        }
+        start = mmap_find_vma_aligned(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


