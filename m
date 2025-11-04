Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B660CCFA0C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbd-0006gt-3m; Tue, 04 Nov 2025 11:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbV-0006fp-Jd
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbT-0007Jp-DK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:52 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4775a52e045so1477235e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272589; x=1762877389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjdCF4UgNd4SZkh6SP1qLa1Jn8mI7bzwm8Kk/HbIkE8=;
 b=cFLiz4uWzzII04lqo4dEXgGk8Yp6CCtNQlwc7yWfneW4HG8CnAzwimNXSz8uf0KdB/
 2Zax+sfcEoTp7tcpPg4JBECwcmmCrIP9SsMUUuVPyws0iFoP44QrNKdVwJJ6tQKP0TjQ
 KPpyF95H4sBy81BlWQlxkdCrozyhiDpkGnm+k0eVlSYriPBHRjZZTt7kdylCyGSZRG8C
 eU4XRsgBSCPqsgOsTG6PhSK28WWaFWtBVuU9z6JxWQXg4W302T0f4pw+wppk2nMRBi59
 BhoqMJ4x8+SGtmmmbDmJINKEkxBP/wwrnafyLSx++BPzVeZpSgRjrvjLBSMGHvDHbmDV
 3EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272589; x=1762877389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjdCF4UgNd4SZkh6SP1qLa1Jn8mI7bzwm8Kk/HbIkE8=;
 b=mAXBJjIDZ9/MIfli0Avp/apNygy3hLk9SDtciTVxh8FVIM5uk8igvmuVJAGpRIlYWN
 I7rwLb/6cMGKC+lF0iyY+XrGHPzRNpFGr1MuPQyWGtTZ3FYpeW5VeJYq4WsAPhqM6C+U
 t+6XcU5I+mtBG4947p9ftdyymeK903aV3UU+eO622itkzA+X3u9dGv4IfbvXjPCh1HOY
 +Sf8ctBYnrl5kXzgFotwwA0K6WzPzuoaXrLLYvdL28/q27vjqHKk/FxStdhqduaG6UMw
 7GEiczDxkSAds+HjTXd+pVsLgSeXA8Jv+LPY0G8+/tSXCdyTJNXVegz2/mBOoa6EiZnU
 GV6w==
X-Gm-Message-State: AOJu0YysCb9NXi7OuhuJ/DFKnwm3AnTXCH06915WhqGrSXjBi2MsXD9k
 LyijXfyE1ekIJvcYJ53aELOEVvutpusjda4eEt/4bX49C5tNN0buLf82m8y/NMBpCYOwxdOlJWc
 6wSRW
X-Gm-Gg: ASbGncv9pqkgRUR2R9I4/mig046ExyGozWzggqTxAFSreBD/thcRmX34P1gvYYJz7vy
 rh3UhlwAks6PqxqmrikA7Cb6LnKhbD/ypMmpg16aBcLDgbRzIpOQo6XFlHpmgJxwl05KGTTKN7Q
 0qnWI9iotGpExYNkiw9PTOLPcz3Rew4ZVjWmxC3I4ZHHhhuveszKiql163Qs78dy3uH4IMBaEol
 U1raxITYM85a+J/Iep94wJkp6G9ps93fnl4PrnDE5Xm8HOboHweW6OF9bHjZ/w5AmCW73Vj/08R
 9Z+3n2fZsHoDxcM6KWwT69SK4PuP+y10OoPWFTYttIZUwUgVr/p+B0GlnTntiEiVkPzM/j8ZYcs
 Pjv8lXuBaUEfsDyHNNvUG5j3MaEA9TOKkQrNe4WPQOz2nb6PjVo392x5YJ958WczdjkEUpp6ytf
 NiwIZ7wA==
X-Google-Smtp-Source: AGHT+IHJ62yJOviHbRJJN3pTb5mDsFv4TuJup00cA8TE/7rVS6cNhwgGnmHDoUxNyTLddE/r5704Ig==
X-Received: by 2002:a05:600d:634c:b0:477:5c45:8117 with SMTP id
 5b1f17b1804b1-4775c45824fmr2078785e9.41.1762272589263; 
 Tue, 04 Nov 2025 08:09:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 3/9] scripts/clean-includes: Make ignore-regexes one per line
Date: Tue,  4 Nov 2025 16:09:37 +0000
Message-ID: <20251104160943.751997-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently we have a single extended regular expression defining
files that clean-includes should ignore. This is now very long
and awkward to read and edit.

Switch to having a list of newline-separated EREs that we write
to a file for grep's -f option, so we can express them more
legibly in the shell script. We allow for comments in the
regex list, which lets us document why we have put the
exclusions in.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index 568033ee9c1..5ab3b071967 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -42,8 +42,6 @@
 GIT=no
 DUPHEAD=no
 
-# Extended regular expression defining files to ignore when using --all
-XDIRREGEX='^(tests/tcg|tests/multiboot|tests/fp|tests/plugin|tests/uefi-test-tools|pc-bios|subprojects|contrib/plugins|tools/ebpf|ebpf/rss.bpf.skeleton.h|linux-user/(mips64|x86_64)/(cpu_loop|signal).c)'
 
 while true
 do
@@ -83,15 +81,33 @@ if [ "$1" = "--all" ]; then
     set -- '.'
 fi
 
-# We assume there are no files in the tree with spaces in their name
-set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v "$XDIRREGEX")
-
 # Annoyingly coccinelle won't read a scriptfile unless its
 # name ends '.cocci', so write it out to a tempfile with the
 # right kind of name.
 COCCIFILE="$(mktemp --suffix=.cocci)"
+REGEXFILE="$(mktemp --suffix=.regex)"
 
-trap 'rm -f -- "$COCCIFILE"' INT TERM HUP EXIT
+trap 'rm -f -- "$COCCIFILE" "$REGEXFILE"' INT TERM HUP EXIT
+
+# List of extended regular expressions defining files to ignore
+# Comments starting with '#' are permitted
+grep -v '^#' >"$REGEXFILE" <<EOT
+# These tests are generally standalone binaries
+^tests/(tcg|multiboot|fp|plugin|uefi-test-tools)
+# BIOS sources and third-party subprojects don't follow our rules
+^pc-bios
+^subprojects
+# plugin binaries are standalone
+^contrib/plugins
+# the ebpf tool is standalone, and the skeleton header is autogenerated
+^tools/ebpf
+^ebpf/rss.bpf.skeleton.h
+# These files just include some other .c file and have no content themselves
+^linux-user/(mips64|x86_64)/(cpu_loop|signal).c
+EOT
+
+# We assume there are no files in the tree with spaces in their name
+set -- $(git ls-files "$@" | grep '\.[ch]$' | grep -E -v -f "$REGEXFILE")
 
 cat >"$COCCIFILE" <<EOT
 @@
-- 
2.43.0


