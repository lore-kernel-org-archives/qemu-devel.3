Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbp-0006nc-7n; Tue, 04 Nov 2025 11:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbb-0006gs-Bo
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbV-0007Kb-Ub
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477442b1de0so19493335e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272592; x=1762877392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ8xqxIo4Z4GSnuU1F/D5K+ZGMDOJ+2wlLbVuuSt0QQ=;
 b=lJs/atpzrsvl4WFrt6Rmfvy/TVEFivsZCNOw9RC/FzfjK3GwFwSZHH6RRr/usNHidg
 Qd45skgBEWLPtCYheKybhQlUJ+bICXBwM3DfQBkFlgb7L7P/S1CSO+SpAlhj8/rZ+62e
 JQcyenhMY129jfSxV6h3v/vCkrwYrmKyaFA/ivlZ4kCSxHkzBtDASHR6+EU28B0SHlsu
 7zhvu+yVUfPQNoRZcXp11SlRkjx5hk51InNLxwPpINJOX0NG6zn0HjW++kjZMXf+wV8+
 POAwMn0j0S1qw4pUT/hMzEwt1AewoFnRYh9wBlv55bOYjlg2M2852K1KmURITsqOsvZ0
 nomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272592; x=1762877392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ8xqxIo4Z4GSnuU1F/D5K+ZGMDOJ+2wlLbVuuSt0QQ=;
 b=PMQCNlE/quydktlXOkkn5N4tuUACBbtAL+rFOpiDXLqWoxX8wwtngR79+VMidUuKWg
 n55/k1Gs3ZjbKwGGlIUei3SLVdNYSPw3G7qRAwgxlnRrqVhjIJNViMRKQ+natSnQYnc6
 DTy4pL0ep0IXMDqqWUmTTL5ZwsPomaz352UD8hU53YuGfmav1FToSzA81R/F5DnBouwb
 Nsf2AIcVvriMjv5GHcQVpOQN24Quh/ig8FbBzw9YK233xJVPGN2RmbkSN30jbJh4FORL
 fYibmrHMLheLt1WsKDO4dyKIgThx2nNGdIQl0JiHjgG38l3z7z+lb1ogWzQG/InJC74/
 /L8g==
X-Gm-Message-State: AOJu0YwCHZxLloj0r6UnuN67meAocxVZAZ/BgMTnH+dz9ra2JmLm/O+w
 l21OYX4hdaid21kqB/ilk5eQxnr9sAAff+FWJOoXNagFkQIrCil0klpyroY0V/yW7oe1aPnsW/3
 TPzrS
X-Gm-Gg: ASbGncuJ7wlDSFavt/G/hyfFd2EwnDbuwRGgteAkDJmZPh8EyquHgMAkW8d4XDAgtnJ
 Dr/GkrtTJ7VsV2VVI8ky7rNLDpoFOzkEi/b7dTOSX8x1tibnT5Uh0HXi9IjYw+1mvonfLmOx4O3
 GIQYpb2WAyIJtLAjSYcliokgdyoBdDCmODwx6s+ca+WbIREK7Iq6nZQyEBQKeZOQYv9z3LFDhKR
 VP7POS2ppu1p04uDGaY5O3Birv+SDWIvel79v1UgLRj3kV8BAjkoRp5AVJO1Np8/obZnhCkGnih
 a8Mv32j4cGlutRSpYzIzY0JQ+0KkFQ/2Ig3L1SHNb8Aiu4/yo5sBrJ2Duw5nh8fk5v2FL1wyS9B
 D5ugNMjn1wZJX/2++QVSERPAxziVIq4H4rz5y3POpbzuvueEQNRWBhHq7P2BtPg/uXHVudCNy9C
 E8H2OfXA==
X-Google-Smtp-Source: AGHT+IGk1gKa08nlqPCZgi0XcgjZv8+HX7TF1+VVlbSzoxj1aWiBlgy+Y59OGW/LjGzj+oOliOnWnA==
X-Received: by 2002:a05:600c:3485:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4773bfb51f8mr128886035e9.30.1762272592414; 
 Tue, 04 Nov 2025 08:09:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 6/9] scripts/clean-includes: Update exclude list
Date: Tue,  4 Nov 2025 16:09:40 +0000
Message-ID: <20251104160943.751997-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Remove from the exclude list:
 * tests/plugin, which is a non-existent directory. This was
   probably intended to exclude tests/tcg/plugins/, which is caught
   by the tests/tcg exclude pattern anyway
Add to the exclude list:
 * rust/ -- the headers in here are purely for input to bindgen
 * target/hexagon has some standalone tools used at build time
 * linux-user/gen-vsdo.c -- another standalone tool
 * linux-user/mips64/elfload.c just includes mips/elfload.c
 * scripts/xen-detect.c is feature-detection code used by meson.build
 * tests/tracetool/simple.c is autogenerated
 * tests/unit/ has some "C file just includes another one" files
 * include/system/os-wasm.h is like os-posix.h and os-win32.h and
   shouldn't be adjusted

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 694e12f062c..256ff5b5faa 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -96,10 +96,12 @@ trap 'rm -f -- "$COCCIFILE" "$REGEXFILE"' INT TERM HUP EXIT
 # Comments starting with '#' are permitted
 grep -v '^#' >"$REGEXFILE" <<EOT
 # These tests are generally standalone binaries
-^tests/(tcg|multiboot|fp|plugin|uefi-test-tools)
+^tests/(tcg|multiboot|fp|uefi-test-tools|qtest/migration/s390x)
 # BIOS sources and third-party subprojects don't follow our rules
 ^pc-bios
 ^subprojects
+# headers under rust are only used for input to bindgen
+^rust
 # plugin binaries are standalone
 ^contrib/plugins
 # the ebpf tool is standalone, and the skeleton header is autogenerated
@@ -107,15 +109,28 @@ grep -v '^#' >"$REGEXFILE" <<EOT
 ^ebpf/rss.bpf.skeleton.h
 # These files just include some other .c file and have no content themselves
 ^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+^linux-user/mips64/elfload.c
 # These are autogenerated headers
 ^include/standard-headers/
 # osdep.h itself and its friends are expected to include system headers
 ^include/qemu/osdep.h
 ^include/qemu/compiler.h
 ^include/glib-compat.h
-^include/system/os-(posix|win32).h
+^include/system/os-(posix|win32|wasm).h
 # This is for use by plugins, which are standalone binaries
 ^include/qemu/qemu-plugin.h
+# standalone tools used in building the hexagon target code
+^target/hexagon/(idef-parser|gen_semantics.c|gen_dectree_import.c)
+# standalone tool
+^target/s390x/gen-features.c
+# gen-vdso is a standalone tool
+^linux-user/gen-vdso.c
+# feature-detection code used by meson.bulid
+^scripts/xen-detect.c
+# autogenerated by tracetool
+^tests/tracetool/simple.c
+# these just include another C file
+^tests/unit/test-rcu-(simpleq|slist|tailq).c
 EOT
 
 # We assume there are no files in the tree with spaces in their name
-- 
2.43.0


