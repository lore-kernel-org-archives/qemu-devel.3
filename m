Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CE7C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60C-0001oi-E2; Thu, 20 Aug 2026 12:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx609-0001XS-05
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx607-0005oJ-1R
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXJV6GBNTPt4N5v8vOHDfcbznd+tYVvsXWykfga//54=;
 b=aN4+12cvQlXIVb3HVFXVyvC1Awgze34oAfxRXXiTfQ/Dkb1Z6RSijyfrr4eRN3SyVd/qj7
 ysfESnBqYEy3yHm/lLr1fIj8jl/C5qN2060blmrNg0X03nRqSsnlgmMo26cXmXKYS7wUTv
 h3yucwhVV6s/fOcpiBlyOkFVBbjKzCc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-5_7fhoddM1m5IhK5WCE4zA-1; Thu, 20 Aug 2026 12:52:19 -0400
X-MC-Unique: 5_7fhoddM1m5IhK5WCE4zA-1
X-Mimecast-MFC-AGG-ID: 5_7fhoddM1m5IhK5WCE4zA_1787244739
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48000d75326so66105f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244738; x=1787849538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FXJV6GBNTPt4N5v8vOHDfcbznd+tYVvsXWykfga//54=;
 b=RwvCPsha8czqY00JFYy9+txBSiI89oeAwEjnIl7dW+LwWla4+CLnQ979zZ+QSitqie
 KWFt6gYwHA31ne6wrI76BpehqtYJvl/6m7B1vsjne+YmFRQvZBDiVluQDGBo9z3spbnH
 u0gqZB14DBWtnrorcwSPFcIB0UwXVs/FU8poo9v1KYubGLn6rSEKuSatIpc+EVhSprHJ
 FcRbPSuBlVNyFYfi/uHR1t7Rafzsv12ExvyqwfnJVFIqs/rgi8Z+ooyDeQBSEaNKFQ2l
 z2HKN2/tI7+I/4UvGihg4xJ0zrLWAa6LjHgrH2jKB6gNevG5tv8QIlZQfShXABtucAzo
 Jpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244738; x=1787849538;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXJV6GBNTPt4N5v8vOHDfcbznd+tYVvsXWykfga//54=;
 b=V5a/q8ck8lk7yrvOyR15BXl/SWjJShqBg6VRRy5UL6fdNXcZsRp3M8a1Z3rWPizHkw
 hFIhPDa8y6atzzEBsPcgnFiP8shoC9+fq1PqqsX9XC1WvKpNODyekyF+87/fjOSrt2xk
 2+14TlUqyvyMM7UIbeeheP8WLbtD63ozL2ll6kzf4kYtDOfF8NVMxj/KVlY8bx38PzN3
 nXBqWHZ5oJ9COxekSlmCf5zwtdStTVoNihYDHQJw1PprEbi91mfkAcHxMyu7oFnVjRfQ
 GLBDWvmFKZYmRA/0y+cDBBgupeNbbOwxuz2S1V6w2TAjFRwp0T5lf1hp/pGsE7ojXphU
 K+EA==
X-Gm-Message-State: AOJu0Yy5giT5Vx+MeMNW2oYkQfar3puFt5Xtg9Y3s1tWN9BBnIPyra4l
 pOyfgNw33afJoYQRxACgZXP7EIR7d5F6HsRRwkC8EiUpQ1FFKBq/QUNWfMw0JqrHCr+ptHpVuXP
 ijVrXW1CqXJsWdYJeWcdWRPWgzAR9/tLxjSVg8BMnaqhf2auR42n5V90xKdrHnpkuss5Q3YifLJ
 hcOFuL09wI3HY8LBdkCsA+qroRhzgReNPshOqSBiNA
X-Gm-Gg: AR+sD10E5WFgyAWZSOEfVl+InRD+duel5+lZabTJr1UuRrjLsOeykNJQV17jg361wkY
 mu0SFuIQBIiQFNZMBzbT74Zd8zUqIzQx/PcFClpVevPUV/BB46sypMqUBiPbMR1vlq9q94ZjA5M
 c36IKldsmg9P+lHf/bD6i4WU4DcKwEyihWT0jhs24fiPsJOz0Vboqt1ttsuhgPBs9T/I/q1abxC
 clQrlAaYW/Iiop8siGkyjRDJ1QcV3p42JUUBa1+QKPN7z6L5qdUFv1KuCKh4t5chRl/arjRrzmX
 siueqd3ejxYa8We1C12iX9mdSxziY3jSt3b9Z0uoT3fcBkrdoq3l92AJw+sJNJJpXDvyTj8i+Vy
 FaYxJfFKnC17lJVTlAZi0ixv7U8yJ6bsk0Gak9F6xLZEOd7CywR75ev6oOTl8VjC73+Rq4rI7ii
 mWCbw=
X-Received: by 2002:a05:600c:4fc5:b0:499:b000:b828 with SMTP id
 5b1f17b1804b1-499b830db9fmr4390995e9.4.1787244738591; 
 Thu, 20 Aug 2026 09:52:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:499:b000:b828 with SMTP id
 5b1f17b1804b1-499b830db9fmr4390025e9.4.1787244738134; 
 Thu, 20 Aug 2026 09:52:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm94943355e9.4.2026.08.20.09.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 49/53] docs: rust: update for new-style build rules
Date: Thu, 20 Aug 2026 18:49:52 +0200
Message-ID: <20260820164957.1895963-50-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 83 +++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index af142c4a694..94c550b39b3 100644
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
+it is possible to use ``cargo`` for common Rust-specific coding
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


