Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F055CCA463
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 07:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHz1P-0006Km-04; Sat, 17 Oct 2026 03:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHz1N-0006Jv-2w
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 03:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHz1K-0000Gb-V4
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 03:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792222797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HtljW4DmVGbgU/K5oim3BhKj8uBEOHaHFFbooZ/PVtA=;
 b=Rbx1oU4UK3PptJes2f030KYavjElZaxyyXqkNaDKOkOWdt64+yXRKyQKEkQKsouLhpfnFm
 a+Zcl7Z4AQAGjYIhv/ws3Ux9LIoEY0/LxGOyr4xadsUzaIlxx99wSOynLY2mOLKf5N9rPv
 3IGIlVczfZVUtKxchhWj5Eer+HE/IcE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-O6nc-1pVN6G8XjqCYX1NZA-1; Sat, 17 Oct 2026 07:39:55 +0000
X-MC-Unique: O6nc-1pVN6G8XjqCYX1NZA-1
X-Mimecast-MFC-AGG-ID: O6nc-1pVN6G8XjqCYX1NZA_1792222794
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso3877805e9.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792222794; x=1792827594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtljW4DmVGbgU/K5oim3BhKj8uBEOHaHFFbooZ/PVtA=;
 b=Qw7kbOA0luMshulpqHfB373J8uZbo12EI34yD/q16TRQxe/MRcjGd1UYxZU3pSrhVu
 bA4UxIifhvgylHEp6zpMjwBsKDv8Ei2IXxi2rg+zPiaM5Gynw42t5dXoh5wOrFriNQqh
 MHaiHjJwwMh/9MRF4mfwTV227cuVLJXxNQtkzhhcrputBDdvqz6w4UOfuPPT8TqqsBjF
 iSEa4iBoMXMBtjCERaDOrcgq40dJF2m46FRhVztnhvskIxiQW+RO1+of+9sK59mQZMQO
 VQngGG6dXq/PrgqnOfTvv/SS5ElJJzzpR7Y2xVXpO0WIcG3vtSpNd3sHfyICMAeW4PlZ
 O8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792222794; x=1792827594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtljW4DmVGbgU/K5oim3BhKj8uBEOHaHFFbooZ/PVtA=;
 b=1sWXa5UDuRoezpi+sUafAeDp4jsyYiTL/fY48sZ89JtdCVK1qb8FOfAHvdiApL0Bjl
 jeT1Pr17qRUkYy/ZCzE7ilViDoN4e6FnaKC0iklzd0DrwreOzEMb8Fl4i+Ut9ucK2r64
 PT554q3BU4pQu8CRDhBdVM0isDZIepY671EWQpAHysfTM8L2kT9GpJuE3S1A5Teeqo9s
 7DSWWTr4tZglUmuorkNaOCthdz6HZjb5t1oQg6BRU+Tp7eo3RfRydTmpjy6zO1H4lndR
 61MG9Vu8yZQcwhxW7MhlbBXR2xlyFCbNKh/i1bYx3zVXezbf20UIgs3e0KAktp/pao/w
 mHfA==
X-Gm-Message-State: AFq9FYKEkY+VU3Cl7t3+WMxzSybL1K63n+blnumt9X18a9tdIjTB8lQd
 V/C4ETspfxfsmDpcx6BoK2ygzLUOMcYkjOnzkNq/04ktf7G2dnhqOBYs5x49K1YrLJ7ny3wcZEb
 T0YXu5MtuUL1tsitFYuxlmqq+DuK011dBqIpjuSVU9tpTFIjRmtcr0RGqDtYQA0BJdoPEKgDqUP
 TZwQj4QVoJhMhF6ADqmU1LDjFkQo5r2AhZV8MnqUvp
X-Gm-Gg: AYBFou1dzkBxDrNp9ZwQsZ8L/GAAFvx//IUWrlDzmzoIHGGjVRX9ixlMBIlowcE1BFA
 DfhD8oSC1jvs91Ic3tw10OUvL0DSevtZ/MLr+y/43HQTAYxy12a1QNv7yAqi6REEtLExdQ5536a
 qOQvEybdhSNx5g58LoRSPIxHtXvSRhvFCkM4JIAO1lib/K/xUBxAjtVmDbDDJSlPtx7mf23GhSb
 Ut15kxKr3jSk8c2otbZfEgxFxbqZMxAPjFVEXJoamq3XeI7OmJT1E2v7tK1HUOujbT/MpXTZW6d
 MCg+O9GP5yD2KyTaCoq51dbVuISetPPLf310C+NCgJz983dDafQdMeOI11MkAd1PJNPTs4LILLL
 yg+Br3bfkE16GSlWeLU23RA5COr44FEbVVujpXbctX79kcdHvvZziNuL/1v/oVSk3iN3gtBLVZ0
 f9BuQl
X-Received: by 2002:a05:600c:c8d:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-4a1d75f2bacmr47477705e9.6.1792222794275; 
 Sat, 17 Oct 2026 00:39:54 -0700 (PDT)
X-Received: by 2002:a05:600c:c8d:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-4a1d75f2bacmr47477415e9.6.1792222793944; 
 Sat, 17 Oct 2026 00:39:53 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8de7230sm112672775e9.14.2026.10.17.00.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 00:39:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH] tcg/tests: add an alias for all TCG tests of a target
Date: Sat, 17 Oct 2026 09:39:52 +0200
Message-ID: <20261017073952.1346449-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow building (without running) all the TCG tests that are available
for a target, so that they can be run manually.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/testing/main.rst | 6 ++++--
 tests/tcg/meson.build       | 8 +++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index fadb376eaf0..b0ca37fe2ba 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -1035,12 +1035,14 @@ See :ref:`container-ref` for more details.
 Running subset of tests
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-You can build the tcg tests using::
+You can build and run the TCG tests using respectively::
 
   make tcg-tests
+  make check-tcg-$TARGET
 
-And run them for one target with::
+Or for a single target::
 
+  make tcg-tests-$TARGET
   make check-tcg-$TARGET
 
 Adding ``V=1`` to the invocation will show the details of how to
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4c0e30756d5..43886ac9269 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -197,6 +197,7 @@ image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
+  target_exe_targets = []
   if target.startswith('multiarch-')
     # those tests are included by architecture files if needed
     continue
@@ -451,7 +452,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
-        exe_targets += exe
+        target_exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -538,6 +539,11 @@ foreach target, plan: tcg_tests
       added_tests += {test_name: true}
     endforeach
   endforeach
+  if target_exe_targets.length() > 0
+    # finally create a top level target to rebuild all tests for this target
+    alias_target('tcg-tests-' + target, target_exe_targets)
+  endif
+  exe_targets += target_exe_targets
 endforeach
 
 if exe_targets.length() > 0
-- 
2.56.0


