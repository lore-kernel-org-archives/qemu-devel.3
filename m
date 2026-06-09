Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F73CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxXV-0000t5-U8; Tue, 09 Jun 2026 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXU-0000si-Fl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXT-0006eV-0E
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oH20KQhH5j7nT4bZR0vd5Sm33ZQzDuERCikGlmASssg=;
 b=Z0R4ybxdhad321V6pX/dhG0qATkq999GHAZKNG8mH+KAZ0N+llifDEIlair65kToITWjdr
 O/Y6OGL8dgLoSsEAN4y9HgsUChB+gqyEGavsuPVCD4i7v6jJDymcw+IaTBasSFnCwnoejt
 a+nGdC9RSqh3vwuGDIDEA+EnjIFW2rE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-7XCPfeJaOp-b4Nnfk5HMag-1; Tue,
 09 Jun 2026 10:34:43 -0400
X-MC-Unique: 7XCPfeJaOp-b4Nnfk5HMag-1
X-Mimecast-MFC-AGG-ID: 7XCPfeJaOp-b4Nnfk5HMag_1781015682
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E919E195F14C; Tue,  9 Jun 2026 14:34:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18B9B3008B3C; Tue,  9 Jun 2026 14:34:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/17] ui: retire input-legacy.c
Date: Tue, 09 Jun 2026 18:34:19 +0400
Message-Id: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqAIBCF4VeRWSfYhYF6lWihNda0sNCMIHz3r
 JYf/OfcEMgzBejEDZ5ODry5jLIQMC7azSR5yoZKVahQtTKyZLfHQ9rGYG1xQm1ryPnuyfL1XfX
 D7xDNSuPx7iGlBw2V3glsAAAA
X-Change-ID: 20260609-ui-input-f4b63f6d6af3
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TZl/B7cotTb6veQeW5SV179FU9my26JXR33fdAeKKpM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR2spjiFiMKnwhKVLvOPcKbxT3KIgPWxZFuO
 6F/F2Ujo9qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdgAKCRDa6OEJdZac
 5eRsD/0as8fImo6hPd+pDQ1kwxrOPvnecr8RJYid3RdbviIRdHKLyIAbcl3FBG/CxkKfZ51ilZs
 pxj+E+n1N3g9s2Q57krl6Jl9V/KROR8g9ASJS74lLXK0pDvEJDtjp54gx1FLXnwE9roiW3/DJGB
 e7u+skHgrP0BqEjsDh4IR81uxTb7wLnyHqGDTRXp1bGOvU/Sqo7fvpzRgQ31/kWhauVvryaV9/W
 klAiRmB8cnY92WSjbPhxgEGMo74kEqDOVOOL1UQauwEmD/RAQWL1qfzA1eWoDGW9Zoy5ped83Ol
 s2/UIJYrLIIWHUNr4ixuFMo8GFIxog7/TCJhbM2Vr/Wkz0H9k/L7TyPXanm6On/tMLY9QiDs33o
 5mhaUbYl6Jy4Ir6dj0D22M7Nrb1yTNyyhNTTVKru47PuZim9BOz7ZVaD1/CPxpyJFC3ehLFn9gf
 m9SOoL5gp0cwNA7B8NfT/W3emMxbe789t65haA7Gj/vbxDH+dIsbmAayvp5zU6lCQDWm+gDp9S+
 H60G4IxUUvZ1eUS3OiqrgxKBkSGpRysBK/ycbyD88JM/aTGt+3Rvb6fy5DD72eNl979CYPcOLnw
 UMgKC7CP+V+DxUeqn65S0jeR3y4HTrahPYHJ/XVrcwyH/wGFqFdR39IQsSqKb0/lIF0l37rKjCH
 Qyw8AlcAE/kDaNw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

This series cleans up the QEMU input subsystem by converting the last
legacy mouse API consumers and reworking how keyboard LED state (Caps
Lock, Num Lock, Scroll Lock) flows from emulated devices to UI backends.

The first patches are preparatory cleanups and fixes. Then legacy mouse
API consummers are converted. The second half introduces per-handler LED
state tracking in QemuInputHandlerState, convert the users, and drop the
old broadcast queue in the final patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (17):
      hmp-commands.hx: fix button_state doc
      ui/hmp: move index_from_key() where it is used
      hw/i386/vmmouse: convert to QemuInputHandler API
      hw/usb/dev-wacom: convert to modern QemuInputHandler API
      ui: move LED and key utilities to input.c, delete input-legacy.c
      hw/input: replace fprint with LOG_GUEST_ERROR
      ui/input: remove double-notification on qemu_mouse_set()
      ui/input: remove dead declaration
      ui/input: add LED state tracking to QemuInputHandlerState
      hw/input/ps2: keep QemuInputHandlerState in PS2State
      hw/input/ps2: use qemu_input_handler_set_led() for LED state
      hw/input/hid: use qemu_input_handler_set_led() for LED state
      hw/input/virtio-input-hid: use qemu_input_handler_set_led() for LED state
      ui/vnc: switch LED handling to Notifier-based input API
      ui/spice: switch LED handling to Notifier-based input API
      ui/dbus: switch LED handling to Notifier-based input API
      ui/input: remove old LED handler broadcast queue

 include/hw/input/ps2.h      |   2 +
 include/ui/console.h        |  30 ------
 include/ui/input.h          |   6 +-
 ui/vnc.h                    |   2 +-
 hw/i386/vmmouse.c           | 115 +++++++++++++++------
 hw/input/hid.c              |   3 +-
 hw/input/ps2.c              |  28 +++++-
 hw/input/virtio-input-hid.c |  15 +--
 hw/usb/dev-wacom.c          | 155 +++++++++++++++++------------
 tools/qemu-vnc/input.c      |  49 ++++-----
 ui/dbus-console.c           |  11 ++-
 ui/input-legacy.c           | 236 --------------------------------------------
 ui/input.c                  |  76 +++++++++++++-
 ui/spice-input.c            |  10 +-
 ui/ui-hmp-cmds.c            |  22 ++++-
 ui/vnc.c                    |  11 ++-
 hmp-commands.hx             |   4 +-
 hw/i386/trace-events        |   2 +-
 ui/meson.build              |   1 -
 19 files changed, 352 insertions(+), 426 deletions(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260609-ui-input-f4b63f6d6af3

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


