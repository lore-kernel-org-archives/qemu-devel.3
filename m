Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DEFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8EG-0007vs-1S; Thu, 06 Jun 2024 04:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8ED-0007vi-Ia
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8E9-0007vr-H8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717661524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FA951BqnDnXSxnTsXK0JNsj4r4dzKXFOlCyH+TsIjwg=;
 b=QyxUJfXjomhoGxehDyaKqJbcWWI6gPTuKBqNdUi/uNuMcmZACXbyc6B4K6SPRJz7eg2RvR
 DJWIzy4A9EnXa5SYPAazUniT4dLVAPes6kbpqwaCpPHsyRyx4M2+PpM6oJANKALeSEFXML
 ANdEz6JrZoegoUGPMhdmtG9Us1mpn+s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-9Y0muuZFP2WotbaoP4OXrw-1; Thu, 06 Jun 2024 04:12:01 -0400
X-MC-Unique: 9Y0muuZFP2WotbaoP4OXrw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a2fb28a23so451298a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661519; x=1718266319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA951BqnDnXSxnTsXK0JNsj4r4dzKXFOlCyH+TsIjwg=;
 b=vxeKzZnaKwUBMaK7IOQ2Ril7FcB9aeWa2piOPtD7rOr4m4Htd8WU1hEkfx+S8I80eI
 3ANjSRD38P0FL5ReGgfnjpGWKNw8354Z88OJjijvR35vyoTiDAqRlK2EKS7E4y87ww/i
 J1M3FAAtjLXr3s57JV3mWleIO9VBBKwl1GKTekS49H0Au+TIZDrWn/2fmZNS6NRfnSNu
 ecG22FXAbIh5mrK3kO/e3HNhLvG8s0meAwnbANq1cU0xKlN6N4UY4g5qpb57n8GQRvmD
 YloqHqi2eAFd5QiPtlbGbKprukCMRXHTMMYjLRfDCBqjDVO/nYuWC5AEC0EwUHzVqFXr
 HNhA==
X-Gm-Message-State: AOJu0YzYhAufXKzGj0LVN0Ms4rW2lxdmO7DrhnlS/M0F48RTVRjg6Rb/
 EZY+cYKB0+JipeT4SwB3uYe4Nx3BzUKsDRTqtvRKdKiXiS0QPpK8phNLuxyjGTuz7+yjGc+8kN4
 vRVDRVBsLwhF19M+ZHs6QFhHcJlgaC7XuluLOV/A8zVQ+jIF8GxWSvrjYBy/hr+2Vco8CvrW1JE
 NIeT6sbeusJ+Pj4FpImg6kXCQTwUJNUnixlUgW
X-Received: by 2002:a50:8d5a:0:b0:57a:2780:e679 with SMTP id
 4fb4d7f45d1cf-57a8b6b1932mr2785513a12.16.1717661519276; 
 Thu, 06 Jun 2024 01:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/kdVXrklftSZvXDEaWQcsTYR0eXqwonCsoqHKHK6AGxRTYISv4USEOTP0DUxyI/sK3dPGQ==
X-Received: by 2002:a50:8d5a:0:b0:57a:2780:e679 with SMTP id
 4fb4d7f45d1cf-57a8b6b1932mr2785489a12.16.1717661518500; 
 Thu, 06 Jun 2024 01:11:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae2321e0sm666049a12.88.2024.06.06.01.11.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:11:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] Revert "python: use vendored tomli"
Date: Thu,  6 Jun 2024 10:11:52 +0200
Message-ID: <20240606081153.2457559-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606081153.2457559-1-pbonzini@redhat.com>
References: <20240606081153.2457559-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that Ubuntu 20.04 is not included anymore, there is no need to ship
it as part of QEMU; Ubuntu 22.04 includes it and Leap users anyway
need to install all the required dependencies from PyPI.

This mostly reverts commit ec77ee7634de123b7c899739711000fd21dab68b,
with just some changes to the wording.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst                |  13 ++++++-------
 configure                                  |   4 ----
 python/scripts/vendor.py                   |   3 ---
 python/wheels/tomli-2.0.1-py3-none-any.whl | Bin 12757 -> 0 bytes
 4 files changed, 6 insertions(+), 14 deletions(-)
 delete mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index f00adad3181..e01896d01c1 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -185,14 +185,13 @@ Bundled Python packages
 
 Python packages that are **mandatory** dependencies to build QEMU,
 but are not available in all supported distros, are bundled with the
-QEMU sources.  Currently this includes Meson (outdated in CentOS 8
-and derivatives, Ubuntu 20.04 and 22.04, and openSUSE Leap) and tomli
-(absent in Ubuntu 20.04).
+QEMU sources.  The only one is currently Meson (outdated in Ubuntu
+22.04 and openSUSE Leap).
 
-If you need to update these, please do so by modifying and rerunning
-``python/scripts/vendor.py``.  This script embeds the sha256 hash of
-package sources and checks it.  The pypi.org web site provides an easy
-way to retrieve the sha256 hash of the sources.
+In order to include a new or updated wheel, modify and rerun the
+``python/scripts/vendor.py`` script.  The script embeds the
+sha256 hash of package sources and checks it.  The pypi.org web site
+provides an easy way to retrieve the sha256 hash of the sources.
 
 
 Stage 2: Meson
diff --git a/configure b/configure
index 34027e3ccef..2a4d898da12 100755
--- a/configure
+++ b/configure
@@ -955,10 +955,6 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
 # Finish preparing the virtual environment using vendored .whl files
 
-if $python -c 'import sys; sys.exit(sys.version_info >= (3,11))'; then
-    $mkvenv ensure --dir "${source_path}/python/wheels" \
-        'tomli>=1.2.0' || exit 1
-fi
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
      ${source_path}/pythondeps.toml meson || exit 1
 
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 1038b14ae0c..07aff97ccad 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -43,9 +43,6 @@ def main() -> int:
     packages = {
         "meson==1.2.3":
         "4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1",
-
-        "tomli==2.0.1":
-        "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
diff --git a/python/wheels/tomli-2.0.1-py3-none-any.whl b/python/wheels/tomli-2.0.1-py3-none-any.whl
deleted file mode 100644
index 29670b98d16e2bc770d4fea718582e1dc0dd8aca..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 12757
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

-- 
2.45.1


