Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKqY-0004fo-3A; Wed, 27 Aug 2025 14:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqV-0004cq-7t
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqN-0005kK-Ty
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dj6C0S99+iJlZNSMVQzRclerl3uq69NIkG94+4R4VNU=;
 b=d6pz0Mn6dEaSite/qJm98k4vyBn5mmK1091/YErxsVrDdSaiEyG0cIn7fL8QeSzN/6K6qO
 XuViwpOyCykE2hdUxIqdpEVN0xT6vxLQm954MfBy1lHPWaRXq7/FpJgPFv6ACAAGSlbgq8
 b3/QmkTGcxtVAryOVGWQIE6kQUdHpfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-qQlpereiPBu4Iq_rlrGRhg-1; Wed, 27 Aug 2025 14:25:39 -0400
X-MC-Unique: qQlpereiPBu4Iq_rlrGRhg-1
X-Mimecast-MFC-AGG-ID: qQlpereiPBu4Iq_rlrGRhg_1756319138
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so499505e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319136; x=1756923936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj6C0S99+iJlZNSMVQzRclerl3uq69NIkG94+4R4VNU=;
 b=iAlsXFCEYSJ7BHmShG+M66gis+rKMaZgM9ipZzxP8cVMXIaBNyx/JVUxiGnbFcNbxq
 Qls1IkVVZa7niV13eacEowCuUE5FXXaKgbiMz73DiwVyCEKMN+YnmEXVFMtXmYFYCbY1
 ip4s6yQh2gHEtQxXYut+AikSZONITKZt8kjc8ZvuO2BE+5+G97r7nJzqxKUuWopnMP3X
 IQer8WYcqjC3/c3Ft4BnsR6KPD8SJhYduCItEBPGpQplMbQIB2N1xqLC9BXaa+2nTXhO
 /LCOVHPepcBbS5HWgjUdl3IosIyZxW6B9fp5rWDehoqCJFIfdmhknD9g5THzi+ZSp1Tm
 vv8A==
X-Gm-Message-State: AOJu0YzUnQPVAOsfQVjow2a0SI7hE9Uz2VpFhsSIKGNEzBQpZK5UMSj9
 YJ+V04Kh4tqcg2lJVzChw3ORMz263GS3JHdkHLH1pjhC/7EBS8oJ+OUmEy9Sizri+EwgYV6pZxN
 eXois30bgKpHtwmDP1kKZFje8YI4QNIywSp4eyfkjcWNyTYALYlVjgY5i+zTyoO0Ev3+HjMZgm7
 DUHlDlJKj4IXDJRgrXJFcNUs8PiYPRQFfLXv5rnG0o
X-Gm-Gg: ASbGncvBc+kz3IsmkvrvgJVJ/14iDcYL7aMjn744keutP6DcNGfgYnmws3jXhSAIkYB
 aaBW5eX3IB6EhHLKpYIUE2V/o2aU3pQ1i4CXkFv40Xgrr4CSOatENVhGMeNJ5XU+FxPKazZIZWt
 k5kUAnHXh/OngCca4pzbCos3r8hHPXnt64AdOa7i0XkBeDAhg1PMP4HeXDUmCK9n8eQH05nQTDS
 hn10z6Of8HRYEL7Ro2CEtifMmRkYDKgd1hratdxtTjPd1Ywga1i8IWMhcdPFQTeG3Kty0c//vEh
 IAuE0TmQbua0vEI9iwKU2AssXulLj2KDe7RuEVGfLyHy/feRJLZ7aqVNXiP+vX4wX7W4NT1hZTM
 7X0jB7hsIcJG05R206g8ZtH/AMzpaeIQHRt6rDhr+OGQ=
X-Received: by 2002:a05:600c:45d4:b0:458:f70d:ebdd with SMTP id
 5b1f17b1804b1-45b5179eb97mr252306665e9.16.1756319136464; 
 Wed, 27 Aug 2025 11:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGywDtTct9wPnPWUhrciozQOzIZInHhqTD0IGBshl0mILZitOhWdTAA/qWd+ip6coeyqehtyw==
X-Received: by 2002:a05:600c:45d4:b0:458:f70d:ebdd with SMTP id
 5b1f17b1804b1-45b5179eb97mr252306385e9.16.1756319135826; 
 Wed, 27 Aug 2025 11:25:35 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0e27b2sm39248705e9.10.2025.08.27.11.25.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:25:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] QEMU patches for 2025-08-27
Date: Wed, 27 Aug 2025 20:25:18 +0200
Message-ID: <20250827182533.854476-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 88f72048d2f5835a1b9eaba690c7861393aef283:

  Update version for the v10.1.0-rc4 release (2025-08-19 14:05:56 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 92dedaf169ddcf8c81fa6d21c86c60f3b82458e5:

  rust: move dependencies to rust/Cargo.toml (2025-08-27 10:57:04 +0200)

----------------------------------------------------------------
* rust: declare self as qemu_api for proc-macros
* rust/qemu-api-macros: make derive(Object) friendly when missing parent
* x86/loader: Don't update kernel header for CoCo VMs
* target/i386: Add support for save/load of exception error code
* i386/tcg/svm: fix incorrect canonicalization
* scripts/minikconf.py: small fixes

----------------------------------------------------------------
Ani Sinha (1):
      kvm/kvm-all: make kvm_park/unpark_vcpu local to kvm-all.c

Manos Pitsidianakis (3):
      scripts/minikconf.py: fix invalid attribute access
      scripts/minikconf.py: s/Error/KconfigParserError
      rust: declare self as qemu_api for proc-macros

Marc-André Lureau (1):
      rust/qemu-api-macros: make derive(Object) friendly when missing parent

Paolo Bonzini (6):
      python: mkvenv: fix messages printed by mkvenv
      MAINTAINERS: add a few more files to "Top Level Makefile and configure"
      rust: disable borrow_as_ptr warning
      rust: qemu-api-macros: support matching more than one error
      subprojects: update proc-macro2 and syn
      rust: move dependencies to rust/Cargo.toml

Xiaoyao Li (1):
      x86/loader: Don't update kernel header for CoCo VMs

Xin Wang (1):
      target/i386: Add support for save/load of exception error code

Zero Tang (1):
      i386/tcg/svm: fix incorrect canonicalization

 MAINTAINERS                                        |  4 +++-
 include/system/kvm.h                               | 17 ---------------
 accel/kvm/kvm-all.c                                |  4 ++--
 hw/i386/x86-common.c                               |  2 +-
 target/i386/machine.c                              | 19 +++++++++++++++++
 target/i386/tcg/system/svm_helper.c                |  2 +-
 python/scripts/mkvenv.py                           |  4 ++++
 rust/Cargo.lock                                    |  8 ++++----
 rust/Cargo.toml                                    |  6 +++++-
 rust/qemu-api-macros/src/lib.rs                    | 24 ++++++++++++++--------
 rust/qemu-api-macros/src/tests.rs                  |  6 +++---
 rust/qemu-api/Cargo.toml                           |  6 +++---
 rust/qemu-api/src/lib.rs                           |  4 ++++
 scripts/minikconf.py                               |  6 ++++--
 .../packagefiles/proc-macro2-1-rs/meson.build      |  2 +-
 subprojects/packagefiles/syn-2-rs/meson.build      |  2 +-
 subprojects/proc-macro2-1-rs.wrap                  |  8 ++++----
 subprojects/syn-2-rs.wrap                          |  8 ++++----
 18 files changed, 78 insertions(+), 54 deletions(-)
-- 
2.51.0


