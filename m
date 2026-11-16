Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D15606A336
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVCjFs3v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzue-0007Yx-Ff; Mon, 16 Nov 2026 11:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xSzuM-0007QD-E3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xSzuK-0006xo-Th
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794847814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0H7h3dD+FYCquqmvRELFnnaLqe/RA8GxwPB3bX0pxX4=;
 b=fVCjFs3vnZyNEi7n7ItZ0OV1whKEpQ9cMPc/ouMUCvBKQbij1Gm9JWxE6HCG2Sz2VeK9ae
 ueVp5we1n5mUiGsk4o0A8kUXmxs1fW6U3RxAMrl4pOfMs1lcd8iXwtaZ+hhMcO8sOddi1U
 qm8Rv7k48sOgxfrUC6hJJyaFvq2PpVs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-XqLVgs7aMNG8__016epJAA-1; Mon,
 16 Nov 2026 11:50:11 -0500
X-MC-Unique: XqLVgs7aMNG8__016epJAA-1
X-Mimecast-MFC-AGG-ID: XqLVgs7aMNG8__016epJAA_1794847809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CA2019560A2; Mon, 16 Nov 2026 16:50:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E593195B3C8; Mon, 16 Nov 2026 16:50:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/7] debug: add PR_SET_VMA_ANON_NAME support
Date: Mon, 16 Nov 2026 11:49:55 -0500
Message-ID: <20261116165002.30939-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
v2:=0D
 - add va_end()=0D
 - fix commit message on 1/7=0D
 - remove redundant call in 4/7=0D
 - remove RFC comment in 5/7=0D
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
 include/qemu/mmap-vma.h    | 21 ++++++++=0D
 include/qemu/osdep.h       |  2 +-=0D
 hw/core/loader.c           |  3 ++=0D
 hw/display/virtio-gpu-gl.c |  2 +-=0D
 hw/i386/x86-common.c       |  3 ++=0D
 migration/ram.c            |  3 +-=0D
 system/device_tree.c       |  2 +=0D
 system/physmem.c           | 15 ++++--=0D
 target/i386/kvm/tdx.c      |  3 +-=0D
 util/mmap-alloc.c          | 17 +++++--=0D
 util/mmap-vma.c            | 98 ++++++++++++++++++++++++++++++++++++++=0D
 util/oslib-posix.c         |  7 ++-=0D
 util/oslib-win32.c         |  2 +-=0D
 util/qemu-thread-posix.c   | 30 ++++++++++++=0D
 util/meson.build           |  1 +=0D
 util/trace-events          |  3 ++=0D
 19 files changed, 213 insertions(+), 16 deletions(-)=0D
 create mode 100644 include/qemu/mmap-vma.h=0D
 create mode 100644 util/mmap-vma.c=0D
=0D
-- =0D
2.56.1=0D
=0D


