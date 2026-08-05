Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729F9C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wra9f-0004db-JX; Wed, 05 Aug 2026 07:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wra9d-0004dP-HZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wra9a-0006W0-SY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7qFvaOBGHrBq31OqgSIOQkHOcPsCFwnd9QCnfLRPACo=;
 b=hbnZG5ztKWB+GneO201lTsfR8kbg9+6Dr16OMM8WcH04RTlpu4mYKZxplGODYbv0XCVTUc
 DHUdnVWMCDaJhXOXlAYe4F+eQfpNjA0kYwEk6SB4ozxiYQwV3+DweVl7SRK4iHahtkeDvt
 D1un+200lcsA4jiaAuXrQJ6zZHoDCIM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-BYFWfOGlP_yqcrBL3rdeVw-1; Wed,
 05 Aug 2026 07:51:19 -0400
X-MC-Unique: BYFWfOGlP_yqcrBL3rdeVw-1
X-Mimecast-MFC-AGG-ID: BYFWfOGlP_yqcrBL3rdeVw_1785930678
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EF3318009D3; Wed,  5 Aug 2026 11:51:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 739A63000239; Wed,  5 Aug 2026 11:51:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/27] CCID smartcard reader fixes
Date: Wed, 05 Aug 2026 15:50:50 +0400
Message-Id: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHNtawsqtyMHaHYzy0wxScu8Wh
 09f73eBIBMKVNEFjAcJLXNAEkfgBjv3qMgHQ6rTQpc6VzJZ3pxlrzo6UVTiO6MNZpmxLYRqZfy
 GENXNb9nbEd323sB9P53pYYZzAAAA
X-Change-ID: 20260805-smartcard-fixes-1df707e447ab
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Warisjeet Singh <sinxx198@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2727;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PxHjcuyWsUrRiAxSaEGuzQye+8rcM7abM9IQjI1ea2Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOrG6z2xfgq24QsW2Zx3AnE2G7bhvmRWGhz7
 ur3NGQyvfOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjqwAKCRDa6OEJdZac
 5RfID/sEWer1mGUD/76KIQTZk8Uw8W4YSKdrcnuQp2JiJEDM3NzdMMJvBwUB+V/tPDBXXuEjP0A
 8P+UWKrAr6Oj++R4AqhnekkTXa+rDjNBd5SDYWJWqwHOOrBvdCF5uiScBOaH+VspUd2qEeQ5MYD
 BfRXE8+Pdc0tDoPM4W/KOovuzzRoe9fMdhzjgKEPdXRHiv+EzNQja5guIKu2jeKMh/W31jFImaS
 opfIXG7Mge3IGR3vpbG1vrsJeA7Pob8qBMUsBsE+50YOgR1y6Mp24knbc2Hogm3vg5JtpVqpT1a
 fxELrfOJzPQ9JNx3BBtHnroCnsZfUQsfUHRXUDIFXFIG7THXGo3+FnMtzfLrD3mNXXsbwMjFccY
 tOkSUpDUEYIizTvGluvrgp1kGXh0ANpVU7jo9a5I5JG7qkrnU1XA/kGsD4VBQEiLxGtPSLpfbIK
 IlAEIqEiBSvqvZSEvGIJHyX848FheCQ9uKAcG39PfBK1S0NntYjlkEBIEG+2COzRkTIvFSE7ZVC
 GFlQ42yzHBvrxprW1FpxWxFTsrFAgwZ4K8spxlt/IQ+yM/5W91jX6dmBx/i5jL/HkpNNHhiAAGZ
 qC2h4memX7Gfd/wG9OleTK9+kRuS1FLqe1AO2w1JhBZdzgz/AEIisCQD0myJ4YamCMtygy3KFp1
 U4Lr7q3XnWVhp1w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

Hi,

While tackling some CVEs issues, I also found several correctness and
robustness improvements/fixes. The series:

- has 3 CVE fixes (OOB/assert)
- fixes xHCI compatibility
- some endianness fixes
- blocks & fixes migration
- better spec compliancy

Tested on Linux with pcscd and Windows with OpenSC.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (27):
      hw/usb/dev-smartcard-reader: validate interrupt transfer length
      hw/usb/dev-smartcard-reader: fix OOB read from pending bulk-in ring
      hw/usb/dev-smartcard-reader: fix assert on pending answers overflow
      hw/usb/dev-smartcard-reader: decode bulk-out length as little-endian
      hw/usb/dev-smartcard-reader: fix dwMaxCCIDMessageLength descriptor
      hw/usb/dev-smartcard-reader: fix OOB read in atr_get_protocol_num()
      hw/usb/dev-smartcard-reader: block migration with pending queues
      hw/usb/dev-smartcard-reader: drop needless state fields
      hw/usb/dev-smartcard-reader: validate migrated fields in post_load
      hw/usb/dev-smartcard-reader: reset all I/O state on device reset
      hw/usb/dev-smartcard-reader: apply backpressure to bulk-out
      hw/usb/dev-smartcard-reader: fix RDR_to_PC_Parameters dwLength
      hw/usb/dev-smartcard-reader: reject oversized responses safely
      hw/usb/dev-smartcard-reader: release short bulk-in responses with xHCI
      hw/usb/dev-smartcard-reader: drop current_bulk_in pointer
      hw/usb/dev-smartcard-reader: derive queue counts from start/end indices
      hw/usb/dev-smartcard-reader: fix pending queue migration
      hw/usb/dev-smartcard-reader: handle Secure, Escape and SetDataRate commands
      hw/usb/dev-smartcard-reader: reject commands for invalid slots
      hw/usb/dev-smartcard-reader: zero bChainParameter in DataBlock responses
      hw/usb/dev-smartcard-reader: report error on XfrBlock with no card
      hw/usb/dev-smartcard-reader: stop advertising PIN support
      hw/usb/dev-smartcard-reader: validate per-command dwLength
      hw/usb/dev-smartcard-reader: use usb_packet_size() accessor
      hw/usb/dev-smartcard-reader: advertise T=1 protocol support
      hw/usb/dev-smartcard-reader: correct CCID_IccPowerOff
      hw/usb/ccid-card-emulated: free libcacard context

 hw/core/machine.c             |   4 +
 hw/usb/ccid-card-emulated.c   |   2 +
 hw/usb/dev-smartcard-reader.c | 523 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 428 insertions(+), 101 deletions(-)
---
base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
change-id: 20260805-smartcard-fixes-1df707e447ab

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


