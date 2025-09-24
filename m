Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425D7CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OK5-0006HN-4F; Wed, 24 Sep 2025 08:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OHx-0003HV-Rh
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OHp-0006Me-TC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceU5G3FTw2aKcj2aUtgK14fEBUcEZq8MIHAJ8aZb8PU=;
 b=ZkZu1u4lvvMjbABPxqWR10eyLASyvxU9LBB6zA1OEV00+w5mUePllOV6cXdRhAbN1MjnwQ
 mlAM6DKaJ8ubajY2I2PfBb9ep7ol8yK/8CdQgUAsr+SpJi73lgN2CHYXXwlKdFyfNvYQby
 txBmIhCNHpF75Sw2iiaiHAbqh7SLzoo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-Doq-a5ZpN9CFTzSLKkmI0w-1; Wed,
 24 Sep 2025 08:07:36 -0400
X-MC-Unique: Doq-a5ZpN9CFTzSLKkmI0w-1
X-Mimecast-MFC-AGG-ID: Doq-a5ZpN9CFTzSLKkmI0w_1758715654
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43854180034F; Wed, 24 Sep 2025 12:07:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E3921955F19; Wed, 24 Sep 2025 12:07:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PATCH v2 25/27] RFC: build-sys: deprecate mips host
Date: Wed, 24 Sep 2025 16:04:22 +0400
Message-ID: <20250924120426.2158655-26-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/about/build-platforms.rst | 2 --
 docs/about/deprecated.rst      | 9 +++------
 meson.build                    | 8 ++++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 0160d3adb8..798cb4631d 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -44,8 +44,6 @@ Those hosts are officially supported, with various accelerators:
      - Accelerators
    * - Arm
      - hvf (64 bit only), kvm (64 bit only), tcg, xen
-   * - MIPS (64 bit little endian only)
-     - kvm, tcg
    * - PPC
      - kvm, tcg
    * - RISC-V
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index aa300bbd50..285a8354f6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -172,8 +172,8 @@ This argument has always been ignored.
 Host Architectures
 ------------------
 
-Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
 MIPS moved out of support making it hard to maintain our
@@ -181,10 +181,7 @@ cross-compilation CI tests of the architecture. As we no longer have
 CI coverage support may bitrot away before the deprecation process
 completes.
 
-Likewise, the little endian variant of 32 bit MIPS is not supported by
-Debian 13 ("Trixie") and newer.
-
-64 bit little endian MIPS is still a supported host architecture.
+Likewise, MIPS is not supported by Debian 13 ("Trixie") and newer.
 
 System emulation on 32-bit x86 hosts (since 8.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''
diff --git a/meson.build b/meson.build
index cf154fe67e..2f134c9e75 100644
--- a/meson.build
+++ b/meson.build
@@ -5039,6 +5039,14 @@ elif host_long_bits < 64
   message()
   message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
   message('to be dropped in a future QEMU release.')
+elif host_arch == 'mips'
+  message()
+  warning('DEPRECATED HOST CPU')
+  message()
+  message('Support for CPU host architecture ' + cpu + ' is going to be')
+  message('dropped as soon as the QEMU project stops supporting Debian 12')
+  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
+  message('that QEMU will compile or work on this host CPU.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.51.0


