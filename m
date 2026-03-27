Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E301110ED661
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67U9-0005fD-DT; Fri, 27 Mar 2026 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67U8-0005ev-AH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w67U5-000617-89
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774619059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XAV0D7HY/jIQN3ktUQpKSm/qYS5OD62NK49YaY8qs5w=;
 b=PrtdqtalObPfjXusX9xl6fy9mfzUPoIfYRNJNRPkVDmryaCirMfXAbm/o6m4g8bUswpFm1
 B/zY/XEU3Az1DURB377RnqmV7OBSbvUnHEfO179UJHnCJCjgGzHxXFDZ3VfhBeDHlN8D0s
 3djMsievNn6iVJVQSODXSKHz6d7pK6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-l3b1Ow2dOZSVVCQGMlUYow-1; Fri,
 27 Mar 2026 09:44:15 -0400
X-MC-Unique: l3b1Ow2dOZSVVCQGMlUYow-1
X-Mimecast-MFC-AGG-ID: l3b1Ow2dOZSVVCQGMlUYow_1774619053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082B0195608E; Fri, 27 Mar 2026 13:44:12 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D6521800671; Fri, 27 Mar 2026 13:44:04 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/15] Misc changes to allow building with Windows Clang
Date: Fri, 27 Mar 2026 15:43:46 +0200
Message-ID: <20260327134401.270186-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2 -> v1:
 - Added additional commits to remove strcasecmp/strncasecmp usage in
   favor of g_ascii_strcasecmp/g_ascii_strncasecmp
 - Don't remove dirent.h from util/drm.c since it's used there
 - Updated commit messages with more explanation

v1: https://patchew.org/QEMU/20260326160033.68318-1-kkostiuk@redhat.com/

Kostiantyn Kostiuk (14):
  meson: Use stddef.h instead of unistd.h
  qom: Use g_ascii_strcasecmp instead of strcasecmp
  block: Use glib2 instead of strcasecmp/strncasecmp
  io: Use glib2 instead of strcasecmp/strncasecmp
  hw/arm: Use glib2 instead of strcasecmp/strncasecmp
  target/sparc: Use glib2 instead of strcasecmp/strncasecmp
  target/riscv: Use glib2 instead of strcasecmp/strncasecmp
  target/ppc: Use glib2 instead of strcasecmp/strncasecmp
  target/xtensa: Use glib2 instead of strcasecmp/strncasecmp
  hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
  osdep: Remove unused strings.h
  util: Remove unused dirent.h
  util: Remove unused sys/param.h
  meson: Don't require nm for non-modular builds

Paolo Bonzini (1):
  storage-daemon: use same link arguments as other tools

 block/curl.c               |  4 ++--
 hw/arm/xilinx_zynq.c       |  8 ++++----
 hw/ppc/spapr_caps.c        |  2 +-
 include/qemu/osdep.h       |  1 -
 io/channel-websock.c       |  4 ++--
 meson.build                | 35 +++++++++++++++++++----------------
 qom/object.c               |  4 ++--
 storage-daemon/meson.build | 16 ++++++++--------
 target/ppc/kvm.c           |  2 +-
 target/riscv/monitor.c     |  4 ++--
 target/sparc/cpu.c         |  8 ++++----
 target/xtensa/xtensa-isa.c |  4 ++--
 util/path.c                |  2 --
 13 files changed, 47 insertions(+), 47 deletions(-)

--
2.52.0


