Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD06FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW96-00025W-I8; Tue, 16 Jun 2026 11:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW95-00025E-9A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZW93-0003j7-Im
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781625368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1YrnfDC33CKgg29yE8hR2on1O90rlwgGa4KfhNq5xK8=;
 b=cc2jah8xdJRJncQ067iUJPMzmDO4WGu3HrI0l+qfnw1niHr5gQXDI94nlBa/7Ko3q0v/Uy
 vNJFX8lSYug5vhTS0SKF/fWK3LShni7Jt7CQ8vhhk4JMtgxdaG4eGPidvzevakfGAE+Y6l
 VFxUUKxrT5VqaB0AugHQ5tCcRJZs+kY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-zgbDK-CyPi2fpI2hWN48_Q-1; Tue,
 16 Jun 2026 11:56:05 -0400
X-MC-Unique: zgbDK-CyPi2fpI2hWN48_Q-1
X-Mimecast-MFC-AGG-ID: zgbDK-CyPi2fpI2hWN48_Q_1781625363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D7F118007E9; Tue, 16 Jun 2026 15:56:02 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12CDC195419E; Tue, 16 Jun 2026 15:55:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 0/7] qom: deprecate embedded objects and instance properties
Date: Tue, 16 Jun 2026 16:55:47 +0100
Message-ID: <20260616155554.264412-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

QOM has two rather unusual / surprising features historicall

 * The ability to embed a QOM instance's memory inside another
   struct
 * The ability to register properties against the instnce
   instead of struct

While they both look convenient on the surface, they also
have significant undesirable side effects (see the commit
message for each patch for details).

The premise of this series is that their convenience does
not outweigh their downsides, and we would be better off
long term by eliminating their usage, rather than trying
to add more hacks on top to mitigate their downsides.

This comes out of two separate conversations this week

 * Migration series where Peter proposed changes that
   make use of instance  properties. When I commented,
   Peter rightly pointed out that our docs do not
   discourage use of instance properties:
   
    https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg02368.html

 * QOM series where Akihiko proposed some funky hacks
   to reference counting to better track object lifecycle
   when embedding structs. We had a short discussion about
   discouraging QOM embedding, so this is a real world
   proposal:

     https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03459.html

This is not likely to be a quick task, so this series
starts small

 * Adds a "QEMU_DEPRECATIONS" annotation for internal APIs
 * Deprecate the QOM instance embedding
 * Deprecate the QOM instance properties
 * Deprecate the memory region embedding APIs
 * Deprecate the IRQ embedding APIs
 * Convert PIIX to eliminate embedding as a
   demonstration.

The QEMU_DEPRECATIONS idea is an effect to improve our our
historic practice where we introduce a new preferred API
and never really tell anyone the old APIs is bad to use.

If --enable-deprecations is given to configure, every use
of a deprecated API emits a compiler warning. This is not
enabled by default in this series, since we have -Werror
by default.

Note that the proposal to stop embedding memory regions has
been made by Zoltan earlier this year and was rejected by Paolo:

  https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg05435.html
  https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg06665.html

I don't really agree with the analysis there. IMHO,  the
concept of embedding objects is to horrendous to allow to
live any longer. Yes, that's a big job, but long term it
is worth it.

Daniel P. Berrangé (7):
  meson: add --enable-deprecations configure flag
  qom: deprecated embedding object structs within other objects
  qom: deprecate use of instance properties
  system: add memory_region_new / memory_region_new_io
  system: add qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
  hw/isa: convert PIIX embedded QOM objects to heap allocated
  qom: improve error message for invalid ID values

 hw/core/irq.c                 | 35 +++++++++++++
 hw/isa/piix.c                 | 65 ++++++++++++++---------
 include/hw/core/irq.h         | 75 +++++++++++++++++++++++++--
 include/hw/southbridge/piix.h | 12 ++---
 include/qemu/osdep.h          | 19 +++++++
 include/qom/object.h          | 98 ++++++++++++++++++++++++++++++-----
 include/system/memory.h       | 76 +++++++++++++++++++++++----
 meson.build                   |  1 +
 meson_options.txt             |  2 +
 qom/object.c                  | 36 ++++++++++++-
 scripts/meson-buildoptions.sh |  3 ++
 system/memory.c               | 85 +++++++++++++++++++++++++-----
 12 files changed, 433 insertions(+), 74 deletions(-)

-- 
2.54.0


