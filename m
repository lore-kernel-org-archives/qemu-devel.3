Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90257CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwD-0006xP-Vt; Thu, 27 Nov 2025 08:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvj-0005dO-VQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvh-00028K-Bv
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUV5SEQ9mEN3G1RbSMj3A+PTdrIfEx77HI6Qj2cAojY=;
 b=e2yt+0ketmHIlu6aPDMkjytxcczlW8JzmtI69T9R9aDz71bv2f3/aKJso8imLxH+S+EGDL
 XQFoYtkfgtwnUkA2trXhB2kBc8GBbsbEB95NIxTJJSVxmrloUfy8s/1rQmNonvX7kLCh+w
 gyyMmEoWv87w699TN6tvcJBVUm7Yfng=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-sYIWkrgsNG-JCAukD6j8Bg-1; Thu, 27 Nov 2025 08:20:59 -0500
X-MC-Unique: sYIWkrgsNG-JCAukD6j8Bg-1
X-Mimecast-MFC-AGG-ID: sYIWkrgsNG-JCAukD6j8Bg_1764249658
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7270cab7eeso90179366b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249657; x=1764854457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUV5SEQ9mEN3G1RbSMj3A+PTdrIfEx77HI6Qj2cAojY=;
 b=ck+ZJSfG4CQnYAuP6Ietawv46VI68/FwS2mXsJKPsArtNDMXRw+oiLFVpq6w/ARaCQ
 X/U5okk2bNoXzN4y2TeGN4hyPzbT4NZbKI0i8qM/oE2IPFkpfEcSpMUo2WBdj3w0LA1W
 /FQRbgnTcRQAuAkNFlMTYtg1P3D3PfyncV9lf9zyhjLiy8RBkky63fhgnA/EjIfBCAzL
 dJ5x3PpHv4aAkHQS0C0rS6JIgUCdKnzn00o8fVbZkhf8ZKHgW02ItH0GISZeIYO2S+tX
 7mAb63hI7elAWBpUhrgU+W/DaE4Sx2LeVzu3Ru2OUpjwXxHEI0X/UHKplBPqiSRW3AId
 HvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249657; x=1764854457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iUV5SEQ9mEN3G1RbSMj3A+PTdrIfEx77HI6Qj2cAojY=;
 b=MFPq/eurhKhPR0Mge6X5SCCDgZ2//HEnoyCNNT6KUlhOEAm4G3vCAOiJ8E0A9pzRzo
 CB3tCv+tdf1rjU9LOTo1TKDz4PBuHXKmBXcUPLfkgM84UeE7XyI20t1LSh/O5zquaWDO
 Di1qgwWMKtkhDN8uJ+lCJ6m7v1jBjI6oZ2wYe1prUela3F4CyexgTBkJH2Uodb/k8uFf
 OEe6X0deGfHZhnjHY3vJgEDKQEt7lHGPDbhDvoCiQ63NRTJpIk7BHFwF4SE+bGPPi7wU
 5KEmKdP+RamH3Cj6NR+e6LnP/ObdarvhNzQNdel+J/ffru2GmQSvxBsjUTW6vyiicHtG
 yFqg==
X-Gm-Message-State: AOJu0YwML9ASFQ1fJXeto9Sr33iDem5EazsrT74gNhM6eFcNqIpqgTdA
 rctOwrZxNHYdJUMme57hMW8tBH+kigKYRAioPWr5RFtCGnJPdAsNztjP/PbHkyGvYIeOdpMMo35
 BUSntThk4T2TgZK0XiWBPBAflt0R9j/NatesfAoZxc0MOd9N0Po5PyeJPeYmyVmTEqtxFcNp2Pr
 c3hzLiCqb1xVsreQvPipVMoWbVPvwRw/TxyFfjOfWr
X-Gm-Gg: ASbGncvTshMgzYCwqN+fquCHPJhTW2duF7gKCqyQqfDbOvYbtzrbWujFqE/0F9Mb3p1
 X2YA8aIhjTYF0BokAeBMluGCYt5iPJVaziT353E2AIn4mOGm48ZTKp+H8mWWLiUcMPCzbv/UHH+
 mijMpKaACYTYz70nGyNEenk5HlP41Deq+cSK4M1oc3YMLBlqzSSa3JQHoxm+tIKMMCyHhwK4siL
 5HoB1Ne/2zZRCrr8f3Dt/AULMUJHsyp2RLzHqXVL6C9D6ndRhrv3puZ4VE+1bFJ2cHLxo5jehaY
 UA0rlTk+8+oKPKqfQsl9i+ea7rllDmZ5oqZmUNOhH5VcXatLfr3lyHOJy7pNm5+PK5OqkRkZM+h
 BlQiIIjyrfAcxGnwWTh5g3NM0fpPaJk1BIB7uWWX+x+77mQ40Rh27f2rfpqU2UU/pn5RcMnMyYZ
 GMmPFzsDXkXl0lawk=
X-Received: by 2002:a17:907:7ba1:b0:b73:870f:fa37 with SMTP id
 a640c23a62f3a-b76c53c0113mr1186024066b.17.1764249656825; 
 Thu, 27 Nov 2025 05:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZRLMjVS3P31UKowE8cLVJSwT3V+bkmHCJ5N6QhidTUMTgSj+FjO2zyhhHDioI1+miZLEgDQ==
X-Received: by 2002:a17:907:7ba1:b0:b73:870f:fa37 with SMTP id
 a640c23a62f3a-b76c53c0113mr1186019866b.17.1764249656301; 
 Thu, 27 Nov 2025 05:20:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f519d828sm164664866b.18.2025.11.27.05.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Martin Kletzander <mkletzan@redhat.com>
Subject: [PATCH 8/9] rust: Do not link qemuutil into Rust rlibs
Date: Thu, 27 Nov 2025 14:20:35 +0100
Message-ID: <20251127132036.84384-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

Commit de037ab8d83d removed qemuutil dependency from chardev and util
rust crates.  However it stayed in the _util_rs static library.  The
dependency is also defined as `link_with`, which is fine for C targets,
where the resulting archive gets linked as another parameter on the
command line when it is a static library.

However, when a C library is linked into a Rust rlib, rustc remembers
the dependency into the metadata and adds the library to the linker
command line.

Unfortunately, static libraries are sensitive to their
position on the command line and rustc does not always get it right.
Fortunately, simply removing it from dependencies of any rust libraries
and instead adding them into the dependencies of executables and
doctests fixes the behaviour.

Without this patch the error I get is:

  FAILED: [code=1] rust/tests/rust-integration
  ...
  = note: rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          rust-lld: error: unable to find library -l:libqemuutil.a
          rust-lld: error: unable to find library -l:libvhost-user-glib.a
          rust-lld: error: unable to find library -l:libvhost-user.a
          collect2: error: ld returned 1 exit status

Meson could work around it itself by never adding these static libraries
to the rlibs (after all, Meson tracks the transitive dependencies already
and knows how to add them to dependents of those rlibs); at least for now,
do it in QEMU: never link C libraries into Rust rlibs, and add them to the
final build products only.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/chardev/meson.build | 2 +-
 rust/qom/meson.build     | 2 +-
 rust/util/meson.build    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 6b681c609ad..204977ca47c 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -37,4 +37,4 @@ _chardev_rs = static_library(
   dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 551c4f0bf5f..dda26c3f981 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -30,7 +30,7 @@ _qom_rs = static_library(
   dependencies: [common_rs, glib_sys_rs, qemu_macros],
 )
 
-qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 18d67a4b374..95aa211ef0b 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -38,10 +38,10 @@ _util_rs = static_library(
     ],
     {'.': _util_bindings_inc_rs}
   ),
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs])
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
-- 
2.51.1


