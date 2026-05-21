Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABBFCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Zc-0005d0-2D; Thu, 21 May 2026 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZX-0005Qb-Vt
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZW-0003aQ-57
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jsXBMxppuYqb59pZAIDEayTCiC/mL8eAo1U1SzX0jVw=;
 b=UDG1ipwUhLHJAXCabbtTRsGi/1cBwIecqEC1lO3mol1KIsU9E7pa0pxTU6Pd9eMkdqGLfs
 mqQROCqliSigReMeDs70c16RxtLPtXckny8vANI4T+rgqbt3tQNDkLqfICsm0KsGEQiIfZ
 OjnhYOSx9TAQSzaiwOzu7p/spjCSfsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-iFuFEMUTNoS3aN9x9FOVnQ-1; Thu,
 21 May 2026 07:28:09 -0400
X-MC-Unique: iFuFEMUTNoS3aN9x9FOVnQ-1
X-Mimecast-MFC-AGG-ID: iFuFEMUTNoS3aN9x9FOVnQ_1779362888
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08E0918005B9; Thu, 21 May 2026 11:28:08 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.32.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58AE119560A3; Thu, 21 May 2026 11:28:07 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 2D3A37DC642; Thu, 21 May 2026 13:28:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/3] hw/arm: add support for shim loading
Date: Thu, 21 May 2026 13:28:03 +0200
Message-ID: <20260521112806.504961-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Also little refactoring in preparation
to avoid code duplication.

Gerd Hoffmann (3):
  hw/nvram: add load_image_to_fw_cfg_file()
  hw/i386: switch shim loading to load_image_to_fw_cfg_file
  hw/arm: add support for shim loading

 hw/arm/boot.c             |  6 ++++++
 hw/i386/x86-common.c      | 15 ++-------------
 hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
 include/hw/arm/boot.h     |  1 +
 include/hw/nvram/fw_cfg.h | 15 +++++++++++++++
 5 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.54.0


