Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0A6C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDXS-0006K8-TK; Mon, 13 Jul 2026 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDXM-0006JF-40
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjDXK-0006RO-86
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783937117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=smXRNmIobHT+PzvirzhoAg9BKEYHtr0phoO/vcsc8tQ=;
 b=d6gjUt7Pe5VQT3ue2WprFCaztzuoOOjfuFiNvnjbcFBYM0El8/m7DJhTrWGZxjqymBwVMr
 Vdo6ICZ/T2DjF3pJmNoPLr6fG53zH4rTkqLUDhOdxYM8qC5xgfs4aGsfbv9Rzlq37bJyVT
 MD6Sf9HF/stWHMe0txGcttTVVkWPWDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-s8GAFqPMM2qulRuwcQzHCw-1; Mon,
 13 Jul 2026 06:05:15 -0400
X-MC-Unique: s8GAFqPMM2qulRuwcQzHCw-1
X-Mimecast-MFC-AGG-ID: s8GAFqPMM2qulRuwcQzHCw_1783937114
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DC3A1800658; Mon, 13 Jul 2026 10:05:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F1C71686; Mon, 13 Jul 2026 10:05:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Rework FIXMEs and fprintfs in hcd-xhci.c
Date: Mon, 13 Jul 2026 12:05:05 +0200
Message-ID: <20260713100508.123623-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Replace the local FIXME macro and fprintf statement with
qemu_log_mask() and g_assert_not_reached().

Thomas Huth (3):
  hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
  hw/usb/hcd-xhci: Remove the FIXME macro
  hw/usb/hcd-xhci: Use qemu_log_mask() instead of fprintf() statement

 hw/usb/hcd-xhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.55.0


