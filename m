Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E7CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrI-0007Q7-1C; Thu, 01 Oct 2026 09:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrD-0007Pn-TZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrB-00060Y-I4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dLUZT+hBf7mF0E3ZliphrtDrD+X+zP/tCPA9AryMiYI=;
 b=M9+mSDmMtNkItBxQr/KTZkUiZ1a145BkYGUaOUBP84rzRgaplxDeBwI3o/eaNpj4KBov5v
 BxuL6NWZ2aqSRGii2sog//1xqKlHs63pordmBDmOPo1eRDo+ic7mnNCSFnVufnhad9uxYW
 2IFxXUnomeMOA6MYeryo+ucK78TLVFo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-PYiaunM_NRuFRT_N6hW6_A-1; Thu,
 01 Oct 2026 09:29:49 -0400
X-MC-Unique: PYiaunM_NRuFRT_N6hW6_A-1
X-Mimecast-MFC-AGG-ID: PYiaunM_NRuFRT_N6hW6_A_1790861389
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B121977028; Thu,  1 Oct 2026 13:29:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C892746E; Thu,  1 Oct 2026 13:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/27] smartcard fixes
Message-Id: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
Date: Thu, 01 Oct 2026 17:29:39 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EjSgDQOftgfs0SEE/K5E4+ENVRqfbNbLm0M2p2FOkWk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHPGSOE3sUpxGQbGiPi/QfmkCqUHchyA1Sw
 NlRexCO2NSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5eD1D/oDOmiC5vbEOdZTadeM6kqy/2pk0OBHMhDtttx0p0eiYmA/xMrVmvFYYZaToAyLDgChiW2
 6ERupCsBBPi/Xx2+zEdR4uhUw/4TxTRtkqRpqKh2s8JN3yaVbEKQHsfIBZYg6wokz2hIEMIRn9/
 wmCALk3mlc+ECxYETjyuFZtN2sgSxaYXykBKVqnSpUUYSDpoZARJD0p6siy5HAitnv7fZkisKlH
 32eB4WCySMVFgRtJlbc2x3R4T+/7FhMm8wBQUYOKFHqEWsrFGJmf+vVoPJI9V+hfQJ8DBcwyupu
 ANlT/XJvsVkfbL0kNkQPzGtGZWmwIjhQARI4MG9jLrJIS5CKOPljL/66+ooN2Y0O+Cv36XCgIn4
 0x3ua6oIORKLn82EVT0lTGv9HNPOcXtow5xMeszHU9PEIimfEPezuyofQyeQJDEyQTa5RLBr0dR
 w0BXpY8TImaFNdM0ofbgLdHssZD+9P+orBqZ+j4rKjKxNusHxxspmtzMbOOuBaCgAp81VnMQLVl
 kSne/eN2rouh0memZCZlLDLNgmYB+aqErguQjuT+LIlPwAct50emsfDlA2GkWIZpThE6ayzKazr
 CcXmDMwGT9ypoeTUMRAG6s6zaae83+IHwRdleB1qsBsxygkrY4lAO2EqzUfA9q8XEcBqXaFZ0DI
 0I7UHLbH+Aq3YNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit f7ada39edacaa5c26b30e98b94017b0b2ccbcf94:

  Merge tag 's390x-20260930' of https://gitlab.com/efarman/qemu into staging (2026-09-30 16:44:59 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/smartcard-fixes-pr-v1

for you to fetch changes up to 32556054616c89bfdf45573af0be381b271885ff:

  hw/usb/ccid-card-emulated: free libcacard context (2026-10-01 17:29:31 +0400)

----------------------------------------------------------------
smartcard fixes

- CVE-2026-18609: guest-triggered assert via short interrupt transfer
- CVE-2026-18204: OOB read from the pending bulk-in ring buffer
- CVE-2026-18410: assert crash when pending answers ring overflows
- various bug fixes, spec compliance and refactoring

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
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


