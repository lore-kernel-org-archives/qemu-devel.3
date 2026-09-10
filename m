Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D75DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nC2-00050A-0M; Thu, 10 Sep 2026 18:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKg-0002gb-68
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lKS-0000S2-F9
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=XC3EVB6q3fwHDOG43AvzZ4zj9iYOLYmyuLWfU04pQ1YoEql/NhShngPQ1YV3oFpBAVtyLz
 Yd1II5Sdm9rEHcSRNliXF0rPlFq9Yc1Fo8tVnCPNExUsTTH7Q5Unjsr/s0WwxhBRqVaF5m
 UICIKUSsIw72MolU3X10VM0CDVfFuwQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-8oppo6ZEON-CUcA3h1GPpw-1; Thu, 10 Sep 2026 16:12:13 -0400
X-MC-Unique: 8oppo6ZEON-CUcA3h1GPpw-1
X-Mimecast-MFC-AGG-ID: 8oppo6ZEON-CUcA3h1GPpw_1789071132
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484337a63bbso55247f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071132; x=1789675932; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=Oj5tFq0Fu4D85/a49cOy926xfiVHapp5mbEaoLI+iv7S/KW2Fth4CTUqqfrzLnu8mz
 xiojhWpVucbiRzsViZ6KX3fm9J1pHrYI+VPl8GkBk8/Ti0w8YzxA6IVRoFUV69vaJEA7
 NjMyZhQGUIFWSKmwGcWf2lEzwflwaYAcykDS8kN0Z5TlADfxBr0mRlsCp4hDEf1oVY+B
 Wg5AX12xrlCsXO4BjyHpIrkYzE0K1XTP3sqJylvAgSr4kmoxd7cZ1VREGDM9ZvkWQCQ1
 NWce26a1xV+ML0YIlJbZ+ZLE3p+It2kFJHuN9y/0ZXJY+lJWgc6GVxHEh8Kk4z8DqiWh
 4ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071132; x=1789675932;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gBSHhMDPj1wNd+THvAUfp3LvU17AmLFoV6OMcA35G6I=;
 b=Rgn6LqLM5AnlrYZ84vlB7aHVb0CkQJAFwauKbwslpi1goXSA/6H8DOSwf+OP8QBxGV
 IW6HZOQnv13FXLSGCWm1RJbeusQQ+Gt9ULIRKVMlDNSkfskfO69IvZr1Zi5xShyKTyIw
 PK6naQacju4A95kcv5XqyqBmDm5uemJdj5BXTLq74mZG6RITwUqWeb9PkLq4BVaU0LPT
 WQ/sdyZ5LGh1oSea/StHquCGXK4vT5y/XsDy7DIig9aX5YMYG3OWXzBUlhTJSnKVkWE5
 t+y8AbHDUYuuUkt8BlQa5mCRngCbkwaxF7Jb1Z689X9iGQrYcf77tXMgiQ415jKFWJ4d
 gYdw==
X-Gm-Message-State: AFuF++kMmqHzQLXCs7kUSnaFuETIPDVsKUQJDTDto5A3djIdqK2TaSxA
 uOvbA2zI7Ta2aF5eTjjFVgfSHRmnbZIJZI4YKCUz4huIMk7LPtZpK5h1T0Hy4TLcLc33tTOMw8T
 ZQ4cjhly/MIsaYvENEx+5BuIEh9t7vrkVNV4cxeLZYbIxOxECSFXScsuKO6AKp6CB2jBDZbftuq
 g+4ArY1EpicSI2sS6yLXjqmR1Flfg86Fkjzw==
X-Gm-Gg: AYBFou2iqFKzWv/n2Yx2Tkg5g7ncwtw4Jq7DD2KPFdmRhpVwpBIhbyNXtxxs2XjW+wn
 jiXRZOe/eJU8RQ6POOpI1aLivGtLMJBjiqg+2/niJXQBbQ82wswpI0sS/07OeTUXQeFZ+EaQxyh
 /rtIJomb/0opiSCxOm1Fl76r+Mx0CS9oyH3KLLptIIL3o7oylRr6rNLaPPJOAVQqehFaUG+Jyb3
 JdcglGqnUZ7QhlGMYE+vAuRCcgI+jnugI2Ct5Y/m9cAQ1uZbu2lkPaqDy56EufIE7vNNCL0aUOz
 FQViuP1BOzUc1Fm2hEXYWTzIpFChtF1wnRXx3Az4k3mne5gkgPqjP2E5wI1nTnSnvNbBvYkJvC2
 b/IVIJxAzs5GZXs/QV2t2To0=
X-Received: by 2002:a05:6000:4601:b0:485:8a46:b3ce with SMTP id
 ffacd0b85a97d-486eb3465e8mr572767f8f.54.1789071131862; 
 Thu, 10 Sep 2026 13:12:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4601:b0:485:8a46:b3ce with SMTP id
 ffacd0b85a97d-486eb3465e8mr572719f8f.54.1789071131296; 
 Thu, 10 Sep 2026 13:12:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm796159f8f.37.2026.09.10.13.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 20/90] net/tap: improve script/downscript options documentation
Message-ID: <925f3dce8892f55d5760a7bba263be12f5c9460a.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Properly document defaults and special values of "" and "no".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-3-vsementsov@yandex-team.ru>
---
 qapi/net.json   | 10 ++++++++--
 qemu-options.hx |  9 +++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 85c78710fe..ab8ed9c086 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -399,9 +399,15 @@
 # @fds: multiple file descriptors of already opened multiqueue capable
 #     tap
 #
-# @script: script to initialize the interface
+# @script: script to initialize the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifup``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
 #
-# @downscript: script to shut down the interface
+# @downscript: script to shut down the interface.  An empty string or
+#     "no" disables script execution.  Defaults to
+#     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the
+#     system configuration directory at build time (typically /etc).
 #
 # @br: bridge name (since 2.8)
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 6c1713ed61..16ef7d5455 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3022,7 +3022,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use network scripts 'file' (default=" DEFAULT_NETWORK_SCRIPT ")\n"
     "                to configure it and 'dfile' (default=" DEFAULT_NETWORK_DOWN_SCRIPT ")\n"
     "                to deconfigure it\n"
-    "                use '[down]script=no' to disable script execution\n"
+    "                use '[down]script=no' or '[down]script=' to disable script execution\n"
     "                use network helper 'helper' (default=" DEFAULT_BRIDGE_HELPER ") to\n"
     "                configure it\n"
     "                use 'fd=h' to connect to an already opened TAP interface\n"
@@ -3558,9 +3558,10 @@ SRST
     Use the network script file to configure it and the network script
     dfile to deconfigure it. If name is not provided, the OS
     automatically provides one. The default network configure script is
-    ``/etc/qemu-ifup`` and the default network deconfigure script is
-    ``/etc/qemu-ifdown``. Use ``script=no`` or ``downscript=no`` to
-    disable script execution.
+    ``<sysconfdir>/qemu-ifup`` and the default network deconfigure script is
+    ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the system
+    configuration directory at build time (typically ``/etc``).
+    Use ``[down]script=no`` or ``[down]script=`` to disable script execution.
 
     If running QEMU as an unprivileged user, use the network helper
     to configure the TAP interface and attach it to the bridge.
-- 
MST


