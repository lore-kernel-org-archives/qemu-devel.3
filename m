Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6102C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLGv-0005eQ-GO; Fri, 26 Jul 2024 09:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLGC-0004mS-RY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sXLG9-0001ub-Fv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722001520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OvDLu3KIbWHiu6ZxO0CUx4o4QNDavrUPXIZjllUrVA=;
 b=GIErtOyV3mhmXvfCTU2IAvzDYurWTEPX/9AhscDdry9JzUJsTM2VXBqlQZk4dUXzGZ3GaW
 y+qm+PiQUlO/Nw+uKY6wgxdMIusluuZ5ZL92OjoALMhTgE4T0+w3EcenT5QXXJ4f9f5b5Q
 SfiHL90dRCoJiVZ8Zg/qmJViQbdzSLg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-X4q3-WUWMgibfuwHxzfhaQ-1; Fri,
 26 Jul 2024 09:45:19 -0400
X-MC-Unique: X4q3-WUWMgibfuwHxzfhaQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 920EF1944AA6; Fri, 26 Jul 2024 13:45:16 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.22.17.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2BD61955D42; Fri, 26 Jul 2024 13:45:12 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 06/13] tests/avocado: use more distinct names for assets
Date: Fri, 26 Jul 2024 09:44:31 -0400
Message-ID: <20240726134438.14720-7-crosa@redhat.com>
In-Reply-To: <20240726134438.14720-1-crosa@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avocado's asset system will deposit files in a cache organized either
by their original location (the URI) or by their names.  Because the
cache (and the "by_name" sub directory) is common across tests, it's a
good idea to make these names as distinct as possible.

This avoid name clashes, which makes future Avocado runs to attempt to
redownload the assets with the same name, but from the different
locations they actually are from.  This causes cache misses, extra
downloads, and possibly canceled tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/kvm_xen_guest.py  | 3 ++-
 tests/avocado/netdev-ethtool.py | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index f8cb458d5d..318fadebc3 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
         url = base_url + name
         # use explicit name rather than failing to neatly parse the
         # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+        return self.fetch_asset(name=f"qemu-kvm-xen-guest-{name}",
+                                locations=(url), asset_hash=sha1)
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index 5f33288f81..462cf8de7d 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -27,7 +27,8 @@ def get_asset(self, name, sha1):
         url = base_url + name
         # use explicit name rather than failing to neatly parse the
         # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+        return self.fetch_asset(name=f"qemu-netdev-ethtool-{name}",
+                                locations=(url), asset_hash=sha1)
 
     def common_test_code(self, netdev, extra_args=None):
 
-- 
2.45.2


