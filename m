Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6151C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxgU-0004DB-A9; Mon, 17 Aug 2026 09:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfJ-0003UH-Q3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfH-00023X-T4
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxvOSeZ368LKK/fAnlZv7h/Kqab1FwSa+jkutPOie98=;
 b=VkeORzWvykHrBs0Fp15iJ7GK/soWmAY6MDUslGSB4lKIWg8fRlUBnxfIbKD/smFKp/ftYT
 2IcLENzzmQmhEmQcrVDp/yIjVWckF9ZcLa4B4gwaQtXi077Xd1v7H39efcbkMlwNcLsWW8
 WfCGEZReqi542BHOng+DkEII5zMi6f8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-klrkTRblM2en6_cM1N1OKw-1; Mon, 17 Aug 2026 09:46:00 -0400
X-MC-Unique: klrkTRblM2en6_cM1N1OKw-1
X-Mimecast-MFC-AGG-ID: klrkTRblM2en6_cM1N1OKw_1786974359
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48000d75326so2304213f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974359; x=1787579159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xxvOSeZ368LKK/fAnlZv7h/Kqab1FwSa+jkutPOie98=;
 b=Txn+Jxg8EXqKDz0XzRYo1DgUEWoC0TPnpQy3vsNHqWwmTEmM5BbgkjYHCNmxeV5XSs
 vobjt4ylv66FE677L17OTO/YpU4r/Tzp8u2vVwZ8n2lXMqp6J9Gp88T0Cm4JUsejBX26
 HWQtfVcVMKpAU761uqsAjuWDcnABrU+nn0JNKAoD6iv28h2+R60DL5BKKpSnZu/89AvW
 nFN6AFcK5SAbvS582j9W4XxnumLv/uLtY8OXvosHhpL5gyquY1i+6UzZnA2IEixIT9Pr
 DvDmlEHq/prxenHcjbZGTQne0hZ8D2MajiAKHoJ/x8IJk+7NOf2irIE48Ey8fo0c//rz
 pPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974359; x=1787579159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xxvOSeZ368LKK/fAnlZv7h/Kqab1FwSa+jkutPOie98=;
 b=ceNG8tMbXs0gyTm3wGsRd+wfYgogP4P8OUAJWAyIJEgH0/7CKrUw7vNQP74Dn2Eor9
 LFlbXILtmc8B48IT56IKMY5dOS+3oHnj1QOjGyavZZWByMqDQmDvf9gLC7s+Fj91KvsA
 Bzx9WCqeh+7pBYPMD3eAPgFMcGz4+weiwrLQf/KwamoPfGW6BxGbG3/P0/I4ovZe5SOv
 zqYPERUBtTHuYgBXgOOTGEHAtEMXH0o6djkX4V4NmONeJlE2pb25WKW1lPOi/EWX91/w
 /nkMwpXuH79I1pwm9I+bvL3aYW2TZVZjcVkoecrhU3Mv8eiH+jzNkVac++l5XJZ7ibwP
 PMaA==
X-Gm-Message-State: AOJu0YzoSzzBQ7u66rL6RewjvYvnfWHt7pAyAnkQq2KzW/dZ4pctZ7uf
 ThUsaNdpPCyDXA1BcmueB2D1dQSiEDT+yjEPUmJGPeOYVfjWE4k4KesMPZ8POMsMU8PWRO1R0d7
 ZZwm7B/fmRdbygYSBEuEqIozfaGYFgbnfMST7Jz1Z7ShYYCgy6HR7WehH6I9v70tUOPKFEMLQAR
 MLrYcg16PmBiP3yOEnpGtU9OKSwdKI0cn4S+b+3KxK
X-Gm-Gg: AR+sD11egGouepluadwftZGyicYTtfgMtEIPrR0xLj0nmb05PUJ0MA4QVb8SeqLlVRI
 ILA2ltnPjG/X7baXZY84WwFI5igagX76TM6SAjyFR00G3qyP0jZ5cB34/K1hGaTQVI6MroYnzGw
 fnMf8DMvsrvqa4I264ML1mJqhorCgauB29PWbZ/yDZXGPfyG+T/i5iWPRbZZJO4L5VXbqLJ13R1
 XcVjyO8KknQcF4+o0hK5/LJzp+KQ35w4eFeVBw32MAu8jJNJaLbMU4DrDMzVX57g2GHcZD2/uBy
 r+EH7jbj54CDcNaUsHvi5m6sEait+miUJikQe8Fb5fAHGixfx88UioOYZE54aXD26NiCBmzWo7n
 sYU/vabuEH8Hg/ZMhyyGXbw4CWnHzovrrRGGaszFg5/Vf+XGhUKzaUQeEBKwaxHF3kzhNDdqT5t
 BLPAY=
X-Received: by 2002:a05:6000:41c4:b0:482:a36c:a5cd with SMTP id
 ffacd0b85a97d-482a36ca830mr8728110f8f.20.1786974358232; 
 Mon, 17 Aug 2026 06:45:58 -0700 (PDT)
X-Received: by 2002:a05:6000:41c4:b0:482:a36c:a5cd with SMTP id
 ffacd0b85a97d-482a36ca830mr8728007f8f.20.1786974357618; 
 Mon, 17 Aug 2026 06:45:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b660sm4240968f8f.15.2026.08.17.06.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:45:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/9] docs: rust: update for new-style build rules
Date: Mon, 17 Aug 2026 15:45:35 +0200
Message-ID: <20260817134538.924615-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134538.924615-1-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 83 +++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index af142c4a694..6ebd4d33431 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -21,15 +21,11 @@ invokes rustc directly, building static libraries that are then linked
 together with the C code.  This is completely automatic when you run
 ``make`` or ``ninja``.
 
-However, QEMU's build system also tries to be easy to use for people who
-are accustomed to the more "normal" Cargo-based development workflow.
-In particular:
-
-* the set of warnings and lints that are used to build QEMU always
-  comes from the ``Cargo.toml`` workspace file
-
-* it is also possible to use ``cargo`` for common Rust-specific coding
-  tasks, in particular to invoke ``clippy``, ``rustfmt`` and ``rustdoc``.
+However, Meson is able to consume ``Cargo.toml`` files and tries
+to be easy to use for people who are accustomed to the more "normal"
+Cargo-based development workflow.  In the case of QEMU, in addition,
+it possible to use ``cargo`` for common Rust-specific coding
+tasks, in particular to invoke ``clippy``, ``rustfmt`` and ``rustdoc``.
 
 To this end, QEMU includes a ``build.rs`` build script that picks up
 generated sources from QEMU's build directory and puts it in Cargo's
@@ -466,63 +462,38 @@ Adding dependencies
 Generally, the set of dependent crates is kept small.  Think twice before
 adding a new external crate, especially if it comes with a large set of
 dependencies itself.  Sometimes QEMU only needs a small subset of the
-functionality; see for example QEMU's ``assertions`` module.
+functionality; see for example QEMU's ``assertions`` module.  Also,
+choose a version of the crate that works with QEMU's minimum supported
+Rust version (|msrv|).
 
 On top of this recommendation, adding external crates to QEMU is a
 slightly complicated process, mostly due to the need to teach Meson how
-to build them.  While Meson has initial support for parsing ``Cargo.lock``
-files, it is still highly experimental and is therefore not used.
+to download them.  While QEMU uses Meson's support for parsing ``Cargo.toml``
+files, it ships ``.wrap`` files instead of using ``Cargo.lock``; this way,
+distros can adjust the set of dependencies to the exact versions they use.
+The versions specified in QEMU's ``Cargo.lock`` must be the same as the
+one in the wrap file.
 
-Therefore, external crates must be added as subprojects for Meson to
-learn how to build them, as well as to the relevant ``Cargo.toml`` files.
-The versions specified in ``Cargo.lock`` must be the same as the
-subprojects; note that the QEMU source tree forms a Cargo `workspace`__,
-and therefore there is a single lock file for the whole build.
-
-__ https://doc.rust-lang.org/cargo/reference/workspaces.html#virtual-workspace
-
-Choose a version of the crate that works with QEMU's minimum supported
-Rust version (|msrv|).
-
-Second, a new ``wrap`` file must be added to teach Meson how to download the
-crate.  The wrap file must be named ``NAME-SEMVER-rs.wrap``, where ``NAME``
+The wrap file must be named ``NAME-SEMVER-rs.wrap``, where ``NAME``
 is the name of the crate and ``SEMVER`` is the version up to and including the
 first non-zero number.  For example, a crate with version ``0.2.3`` will use
 ``0.2`` for its ``SEMVER``, while a crate with version ``1.0.84`` will use ``1``.
 
-Third, the Meson rules to build the crate must be added at
-``subprojects/NAME-SEMVER-rs/meson.build``.  Generally this includes:
+Usually, Meson is able to figure out how to build the crate, and also handles
+cross compilation correctly.  For crates that have a ``build.rs`` file,
+equivalent rules must be added to
+``subprojects/packagefiles/NAME-SEMVER-rs/meson/meson.build``.
+The file can modify the ``extra_args`` and ``extra_deps`` variables,
+which contain respectively the compiler arguments and external dependencies
+for the crate.
 
-* ``subproject`` and ``dependency`` lines for all dependent crates
+After every change to the ``meson/meson.build`` file you have to update the
+patched version with ``meson subprojects update --reset ``NAME-SEMVER-rs``.
+This might be automated in the future.
 
-* a ``static_library`` or ``rust.proc_macro`` line to perform the actual build
-
-* ``declare_dependency`` and a ``meson.override_dependency`` lines to expose
-  the result to QEMU and to other subprojects
-
-Remember to add ``native: true`` to ``dependency``, ``static_library`` and
-``meson.override_dependency`` for dependencies of procedural macros.
-If a crate is needed in both procedural macros and QEMU binaries, everything
-apart from ``subproject`` must be duplicated to build both native and
-non-native versions of the crate.
-
-It's important to specify the right compiler options.  These include:
-
-* the language edition (which can be found in the ``Cargo.toml`` file)
-
-* the ``--cfg`` (which have to be "reverse engineered" from the ``build.rs``
-  file of the crate).
-
-* usually, a ``--cap-lints allow`` argument to hide warnings from rustc
-  or clippy.
-
-After every change to the ``meson.build`` file you have to update the patched
-version with ``meson subprojects update --reset ``NAME-SEMVER-rs``.  This might
-be automated in the future.
-
-Also, after every change to the ``meson.build`` file it is strongly suggested to
-do a dummy change to the ``.wrap`` file (for example adding a comment like
-``# version 2``), which will help Meson notice that the subproject is out of date.
+Also, after every change to the file it is strongly suggested to do a dummy
+change to the ``.wrap`` file (for example adding a comment like ``# version 2``),
+which will help Meson notice that the subproject is out of date.
 
 As a last step, add the new subproject to ``scripts/archive-source.sh``,
 ``scripts/make-release`` and ``subprojects/.gitignore``.
-- 
2.55.0


