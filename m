Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29003C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsWZ-0006G5-V2; Mon, 21 Jul 2025 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udsWS-0006AK-3J
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:33:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udsWQ-0000bs-3p
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:33:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso2839455f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753112024; x=1753716824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5txsamFcyhlFDYcFgElaERHKYxRAHYENtRVr/jJs6kQ=;
 b=kURRYUtMtZaB6bYQZIdWFtkil5Zk9RXeqiDcFmuI4rh/rvhPjpUpGhXLwiI/NbAsZt
 esWHx9lGo6qLFGnzvUbTdw+tLAb57KO5CPSiMfDOqfR1rVIzQNrQa8Rr5iwlYlfmdSad
 +XxBga0HU92A1rGr2pBzdtPKc2ADqEEKsFAAVVoORzI9+ornVFDgzPP9BQiTqznHUNsf
 lFKp0lTuVYpoWbNDmzQ3Uzh2aPkYwtqHj9mgJoYLEE5MpTH73w55+WyMI+8+IFGpWnUR
 Cysxj5345K2BTVTNCUkuMm6cEKvFZHwnvyq/xvtxr4SqY9BfkxTe46grncFEvqPCHDCU
 nIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112024; x=1753716824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5txsamFcyhlFDYcFgElaERHKYxRAHYENtRVr/jJs6kQ=;
 b=u9aeN3dR0aO0unBb7zgaC/R0uevmxl26+tjojA4chhI+e960MLrfshxX32nfhn/uf7
 wKgE/XSUF2/pE6HWiuXb9d7MsvGcSy3PBaR+KxU99RMB0cI6VvT9wbVh/7BUppT9xJwb
 tfMuDk0mfomM23rBA/h+4um9FGyEob0SxcMkcqqEmsh9WPO/PGu8Ad8rzyhLyIdVxpMj
 IeEFph4qkPfIonD2pLlXR1hXFAgxfiqd8Clrh/74R/SawE2fOE2COhjJRUsqSw9zGsJ2
 bx7glVpJHhcS1KNJzd86K7VJ/nS/HQutWkcDjOuJ8QMtiVo/tTNhzd+6js4cAbr3RE2V
 tpIw==
X-Gm-Message-State: AOJu0Yw9KAVlVr9V8TvZcrN5D2je/DoQ/CGDtR1JBrh3rPHfMkNPx4Ki
 7XzWJBTFz2Hsovpg8mxahYdAzrlBIEac3wi7kMhvZ7ydeW4PxFov5y6QHjNB1Pm5KAmKXAIQny6
 ITRSR
X-Gm-Gg: ASbGncvbXoewJgd8zwhAs40eVfyYYbgx3uP1Gp5ayMRYK4/Rvaq5tlYhIPrlsmytO/A
 c7HwLDKQ/yytYJrIx1IomlKHYZmu3K/yWkR7n4yqFV62BS0Ab0qz8PuGFk67zHqWqKaw15O1n9n
 Pj0E25UWWw6MzD8im+IrKAvvm8TR/UtiWIHz4yxR0xoHItJxndXzd1mcOvz2k/jHtAd3KfId6H8
 QFYeTxpr+I3DkiQu+vEePT7S3kzcUpOYMk0tv6Sa1XQdfwwWTa7SKiyARYF9hqZKTm2oaRJw3RO
 BnIUjEBv+Xl3QgePLUEyvc0LxVLrx1hbxBjFjbwEiIBk9N0wYj+IyUTlLvxnHover8cVUEM2t40
 xEOD5I5w1b93qzEpqdiqVoU236p/h
X-Google-Smtp-Source: AGHT+IGGj/btQucl9PsQeNeN+HmRtH52LhBehqLPzpwxDRUkm8gk2WB6Z0tQCJ2+CzOJEavtlrXvNA==
X-Received: by 2002:a05:6000:5c2:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b613e982e0mr12474469f8f.27.1753112024145; 
 Mon, 21 Jul 2025 08:33:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f4294sm162982295e9.3.2025.07.21.08.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:33:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] scripts/make-release: Go back to cloning all the EDK2
 submodules
Date: Mon, 21 Jul 2025 16:33:41 +0100
Message-ID: <20250721153341.2910800-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In commit bd0da3a3d4f we changed make-release so that instead of
cloning every git submodule of EDK2 we only cloned a fixed list.
The original motivation for this was that one of the submodules:
 * was from a non-github repo
 * that repo had a "SSL certificate expired" failure
 * wasn't actually needed for the set of EDK2 binaries we build
and at the time we were trying to build the EDK2 binaries in one of
our CI jobs.

Unfortunately this change meant that we were exposed to bugs where
EDK2 adds a new submodule and the sources we ship in the release
tarball won't build any more.  In particular, in EDK2 commit
c6bb7d54beb05 the MipiSysTLib submodule was added, causing failure of
the ROM build in our tarball starting from QEMU release 8.2.0:

/tmp/qemu-10.0.0/roms/edk2/MdePkg/MdePkg.dec(32): error 000E: File/directory not found in workspace
        Library/MipiSysTLib/mipisyst/library/include is not found in packages path:
        /tmp/qemu-10.0.0/roms/.
        /tmp/qemu-10.0.0/roms/edk2

(Building from a QEMU git checkout works fine.)

In the intervening time EDK2 moved the submodule that had a problem
to be one they mirrored themselves (and at time of writing all their
submodules are hosted on github), and we stopped trying to build
EDK2 binaries in our own CI jobs with commit 690ceb71936f9037f6.

Go back to cloning every EDK2 submodule, so we don't have an
untested explicit list of submodules which will break without
our noticing it.

This increases the size of the QEMU tarball .tar.xz file from
133M to 139M in my testing.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3041
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think ideally we would not ship these rom blobs in our source
tarball but instead provide them separately. Then we would definitely
have no reason to ship a huge amount of EDK2 sourcecode that
99.9% of the users of the tarball don't want. But that's an
idea that was floated at least three or four years ago now
and we don't in practice have time or effort to try to do that.
So the simple thing is to at least ship the right source...

NB: for me this can build the x86 blobs now, but it then tries
to build the Arm blobs with the x86 GCC, which obviously doesn't
work. Perhaps something needs to be set in the environment ?

---
 scripts/make-release | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/scripts/make-release b/scripts/make-release
index 4509a9fabf5..87f563ef5f7 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -62,17 +62,15 @@ meson subprojects download $SUBPROJECTS
 (cd roms/skiboot && ./make_version.sh > .version)
 # Fetch edk2 submodule's submodules, since it won't have access to them via
 # the tarball later.
-#
-# A more uniform way to handle this sort of situation would be nice, but we
-# don't necessarily have much control over how a submodule handles its
-# submodule dependencies, so we continue to handle these on a case-by-case
-# basis for now.
-(cd roms/edk2 && \
-    git submodule update --init --depth 1 -- \
-        ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3 \
-        BaseTools/Source/C/BrotliCompress/brotli \
-        CryptoPkg/Library/OpensslLib/openssl \
-        MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
+
+# As recommended by the EDK2 readme, we don't use --recursive here.
+# EDK2 won't use any code or feature from a submodule of a submodule,
+# so we don't need to add them to the tarball.
+# Although we don't necessarily need all of the submodules that EDK2
+# has, we clone them all, to avoid running into problems where EDK2
+# adds a new submodule or changes its use of an existing one and
+# the sources we ship in the tarball then fail to build.
+(cd roms/edk2 && git submodule update --init --depth 1)
 popd
 
 exclude=(--exclude=.git)
-- 
2.43.0


