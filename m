Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13E8CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rur3F-0006ln-4g; Thu, 11 Apr 2024 05:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3D-0006lc-PK
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur3C-000380-0J
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712828936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o1v1K0CmQ40+EW0VELKjSxYUsEiCfyKNJapsqmpTKdw=;
 b=DbNCtOrSONFvFAwiOVvucM+h+4ln9U3749bngrMsZaWfGgtQOri9Ws6OUf0Ao/KrX7zAES
 OJUkkvCdsih+moZ6A+ZfEiPziSEWHvGeluD6w+8fBDi6uDbciIVfthImkubYeyHFUOnn/b
 yGt+kRP/SkoBTcl+GMEI3AJVfRVdPts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-yr8CGKGYO3emLMSdbqpyew-1; Thu, 11 Apr 2024 05:48:52 -0400
X-MC-Unique: yr8CGKGYO3emLMSdbqpyew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75E9B806603;
 Thu, 11 Apr 2024 09:48:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 438513C24;
 Thu, 11 Apr 2024 09:48:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3DE1D180063D; Thu, 11 Apr 2024 11:48:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/5] x86/loader: secure boot support for direct kernel load
Date: Thu, 11 Apr 2024 11:48:24 +0200
Message-ID: <20240411094830.1337658-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

This series allows to boot linux kernels and other efi binaries via
direct kernel load with secure boot enabled.

The series adds two new fw_cfg files: 'etc/boot/kernel' contains the
kernel without modifications (no setup header patching), and
'etc/boot/shim' contains shim.

The path to the shim binary can be passed to qemu using the new '-shim'
command line switch.

This needs a companion patch series for tianocore which will put the new
fw_cfg files into use, a draft of that series can be found here:

https://github.com/kraxel/edk2/commits/devel/direct-secure-boot/

With everything in place it is possible to use direct kernel load with
secure boot enabled.

take care,
  Gerd

Gerd Hoffmann (5):
  vl: fix qemu_validate_options() indention
  x86/loader: only patch linux kernels
  x86/loader: read complete kernel
  x86/loader: expose unpatched kernel
  x86/loader: add -shim option

 include/hw/boards.h |  1 +
 hw/core/machine.c   | 20 ++++++++++++++++++++
 hw/i386/x86.c       | 32 ++++++++++++++++++++++++++------
 system/vl.c         | 25 +++++++++++++++++--------
 qemu-options.hx     |  7 +++++++
 5 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.44.0


