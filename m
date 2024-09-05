Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E7ECD5BCA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 14:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDDv-0001Bk-42; Thu, 05 Sep 2024 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1smDDq-00012N-Fv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1smDDo-0007cY-Ca
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725545541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uoZGYkypj9+ZQe6NihGP7x8ZV8jf/K+lX4pyc2pqw2A=;
 b=eLoayMVC+ujisjnhAWI8n8K9fmi7zsfxteNSTccarXS3R1vsfuv2bUdvUNbEZuU1tfnJh2
 5ktEV6Yk6xH1N46h+Csqy7Cc+PJ8RZWgTesbQJi5gf3JYycj1YvTLuhuVnS+J6aWNRGrbr
 xPyuy/ohRynaD3zxG++O3J/28+tTNj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-WkmjVEhpOB6LSLob_X82tQ-1; Thu,
 05 Sep 2024 10:12:17 -0400
X-MC-Unique: WkmjVEhpOB6LSLob_X82tQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02420193E8C5; Thu,  5 Sep 2024 14:12:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD55F19560AF; Thu,  5 Sep 2024 14:12:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4DD211800937; Thu,  5 Sep 2024 16:12:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/5] x86/loader: secure boot support for direct kernel load
Date: Thu,  5 Sep 2024 16:12:05 +0200
Message-ID: <20240905141211.1253307-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

 include/hw/boards.h  |  1 +
 hw/core/machine.c    | 20 ++++++++++++++++++++
 hw/i386/x86-common.c | 32 ++++++++++++++++++++++++++------
 system/vl.c          | 25 +++++++++++++++++--------
 qemu-options.hx      |  7 +++++++
 5 files changed, 71 insertions(+), 14 deletions(-)

-- 
2.46.0


