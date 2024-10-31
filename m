Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A371D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZMm-0002V1-8y; Thu, 31 Oct 2024 13:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMJ-0001fz-0B
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMG-0007Oh-Vm
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7Fdor97tnlwQ2zdg1al40gegEzidDhCv9+QxCS+LQo=;
 b=DE9D7AlukfVuaGAZuF7em0Fonjzc5VDpMIoIWXIlLyUz9JLIYC8yfBm2w6BgDvm+HSwfCL
 lw/8ZoJbVg2+GUGuZWxN1sNMGbZswRWLnF4HHMlIFu3WpZU4sk+YICDTUreo8opbQ3Zyh1
 34MiSecS+rtfDr23Q7esURYixHi20zU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-mb3ffKuPPECbmDyCgiiwMg-1; Thu, 31 Oct 2024 13:53:18 -0400
X-MC-Unique: mb3ffKuPPECbmDyCgiiwMg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-53b1eef7359so961530e87.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397196; x=1731001996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7Fdor97tnlwQ2zdg1al40gegEzidDhCv9+QxCS+LQo=;
 b=Xkc5f16XYojWg+QVncCfdD4Cv2Q0ojCTq95ASOOM13Qw8boUl/dz9MY4UqNDiiioCT
 2NYV/fD5K8K17UUDAXJLbEEHhgOnDxKTqJkypjyu4KFIVLhWCpbagCoOjTXUr8zRqX7o
 FTWnP6eQ/peyeDnMGI5g0DMV9Da281QYyIW0zlKTNEPbEAoyUezgw2v92YNjwMqSVWVm
 QVjdmR72OaenjdhU2rLC1KKH9NWLbsoIQWFxdNbdOjaf4h+LRZ7D/7oFRxQemevHvn1f
 dZhPTIcaVUAKBQM/ZT2NkutrZYSBNfwNm9T2sWXktSi7E7PMlCqMdHWuptAKHmwmmf5C
 3mwA==
X-Gm-Message-State: AOJu0YwaVmNHolQCKFW3jnVl4Xo6/RlGgmqkcM8wYSTynWUrnzkasIdk
 vH8i0yG0nk1A13FEDa2L9WoF8FR1cZVlHTPrYa3kRZAOVq0ePp7P+zreDb/kJzjIY4Kv8wrnhCW
 C406XqIfo1ECKxHyWP9icmmQqW/WuCNpWDt7W1snFy6UYHrR058t+PdcbCvdwSb94rPVhxKjJ6K
 YX0TAwDSWSbUrXneuPj/CZ4qw8rol03pltqFoZ1cc=
X-Received: by 2002:a05:6512:2341:b0:539:ec1a:5873 with SMTP id
 2adb3069b0e04-53b3490f0c8mr10598839e87.28.1730397196195; 
 Thu, 31 Oct 2024 10:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzWPJ8zJRxwSbKvb8oFWmVYASAKLc3hack8O7Cr+mzWZXUMLmA2gfVHSkadcr+tOMhpjll6g==
X-Received: by 2002:a05:6512:2341:b0:539:ec1a:5873 with SMTP id
 2adb3069b0e04-53b3490f0c8mr10598818e87.28.1730397195704; 
 Thu, 31 Oct 2024 10:53:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49d4sm2821849f8f.34.2024.10.31.10.53.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/49] ci: always invoke meson through pyvenv
Date: Thu, 31 Oct 2024 18:51:51 +0100
Message-ID: <20241031175214.214455-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not assume that the distro-installed meson is compatible with the one
in the virtual environment.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8c69c60d215..39da7698b09 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -66,7 +66,7 @@
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
-    - meson subprojects download $(cd build/subprojects && echo *)
+    - build/pyvenv/bin/meson subprojects download $(cd build/subprojects && echo *)
     - cd build
     - find . -type f -exec touch {} +
     # Avoid recompiling by hiding ninja with NINJA=":"
-- 
2.47.0


