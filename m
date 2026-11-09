Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6C606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YddD12iM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUaX-0001Db-6P; Mon, 09 Nov 2026 13:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUaP-0001Cx-DW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUaN-0006Ba-VO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEkUBviGIGN/LAuBviM/0RLn9PfC+r83xbG4+hZ8/Kc=;
 b=YddD12iMLGYlgDk/lzvteP1vRnbRFxG7zEorSZrp0VKj2b+AHuD7ITLqDBl9X9TAlHwNlr
 wvurJV/9FEForkSS4rRFNTyQyrMKvUUaMybFhVEy4qpOH4UX2hBJmNvgv1dLLoJrfkNtFd
 se0EQ25duNLMfe0VyXO+KTElwkuwVIk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-CYWXylg7PN24OdqWNEGEtw-1; Mon,
 09 Nov 2026 13:59:15 -0500
X-MC-Unique: CYWXylg7PN24OdqWNEGEtw-1
X-Mimecast-MFC-AGG-ID: CYWXylg7PN24OdqWNEGEtw_1794250754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02C51955EB1; Mon,  9 Nov 2026 18:59:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E0131956087; Mon,  9 Nov 2026 18:59:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, John Snow <jsnow@redhat.com>
Subject: [PATCH 0/7] debug: add PR_SET_VMA_ANON_NAME support
Date: Mon,  9 Nov 2026 13:59:00 -0500
Message-ID: <20261109185907.3220584-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add PR_SET_VMA_ANON_NAME support to name mmap'd regions of=0D
memory. This is only supported on Linux >=3D 5.17, but allows QEMU to=0D
communicate names for each VMA segment to linux, where they are=0D
visible in /proc/$pid/[s]maps and utilities like pmap.=0D
=0D
John Snow (7):=0D
  debug/mem: add utility to name anonymous memory mappings=0D
  debug/mem: add tracing to qemu_vname_vma()=0D
  debug/mem: name <reserved> regions in mmap-alloc=0D
  debug/mem: name pthreads=0D
  debug/mem: name coroutine stacks=0D
  debug/mem: name qemu_anon_ram_alloc/qemu_ram_mmap pages=0D
  debug/mem: HACK add qemu_name_buffer=0D
=0D
 meson.build                |  8 ++++=0D
 include/qemu/bitmap.h      |  6 +++=0D
 include/qemu/mmap-alloc.h  |  3 +-=0D
 include/qemu/mmap-vma.h    | 21 +++++++++=0D
 include/qemu/osdep.h       |  2 +-=0D
 hw/core/loader.c           |  3 ++=0D
 hw/display/virtio-gpu-gl.c |  2 +-=0D
 hw/i386/x86-common.c       |  3 ++=0D
 migration/ram.c            |  3 +-=0D
 system/device_tree.c       |  2 +=0D
 system/physmem.c           | 15 ++++--=0D
 target/i386/kvm/tdx.c      |  3 +-=0D
 util/mmap-alloc.c          | 17 +++++--=0D
 util/mmap-vma.c            | 94 ++++++++++++++++++++++++++++++++++++++=0D
 util/oslib-posix.c         |  7 ++-=0D
 util/oslib-win32.c         |  2 +-=0D
 util/qemu-thread-posix.c   | 34 ++++++++++++++=0D
 util/meson.build           |  1 +=0D
 util/trace-events          |  3 ++=0D
 19 files changed, 213 insertions(+), 16 deletions(-)=0D
 create mode 100644 include/qemu/mmap-vma.h=0D
 create mode 100644 util/mmap-vma.c=0D
=0D
-- =0D
2.56.0=0D
=0D


