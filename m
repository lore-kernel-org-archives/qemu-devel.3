Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDA1C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2RP-0005X7-AT; Thu, 08 May 2025 10:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD2RL-0005Vo-C9
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD2RI-0004xi-TQ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746715292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7rOrt0arOj0AsEmDcAxQS8lpsa38MnnGCY/U+gFk0Dg=;
 b=Iq/qnasWIu8f/kxafEf/I0vDLIJHc9uhPQxhAnGxAbBF5iW90yn7u+NmK8WbRexECLrPFV
 xlc8vUlSxJODDzQEJqUpTEysM7zA6/3CIBdbPnCbtWp5RkUAcO8sqUxAWDR9QQQmk+chqb
 6uJ1mHj1bkwkqZeA3TRT+mHTGBzfvLk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-noSU3-3iO8-S5KTVh1gacg-1; Thu,
 08 May 2025 10:41:29 -0400
X-MC-Unique: noSU3-3iO8-S5KTVh1gacg-1
X-Mimecast-MFC-AGG-ID: noSU3-3iO8-S5KTVh1gacg_1746715288
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159A2180899E; Thu,  8 May 2025 14:41:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.200])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0685219560AE; Thu,  8 May 2025 14:41:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH RESEND 0/5] Fix dependencies in arm machines and update
 OpenBSD to 7.7
Date: Thu,  8 May 2025 16:41:15 +0200
Message-ID: <20250508144120.163009-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I accidentally only sent this to qemu-arm, not to the qemu-devel mailing
list, so this is a resend, sorry if you've got it twice.
Note that there was already some discussion on the qemu-arm mailing list,
see the archive here (i.e. I'll try to rework the third patch and
postpone the last one):

 https://lists.libreplanet.org/archive/html/qemu-arm/2025-05/msg00549.html

Original cover letter message follows:

At the end of April, OpenBSD 7.7 has been released, so we could update
our test VM to that version now. However, I noticed that some arm machines
now fail to compile since they fail to include the <epoxy/gl.h> header.
This header resides in /usr/X11R6/include instead of /usr/include in
OpenBSD, so we have to make sure that the machines are compiled with the
right CFLAGS (or don't include the header at all if it is not really
necessary). Thus the first patches of this series clean up this first
before we can finally switch to OpenBSD 7.7. The last patch then
also reverts a hack for OpenBSD in the main meson.build file since the
related problem has finally been fixed there.

Thomas Huth (5):
  include/hw/dma/xlnx_dpdma: Remove dependency on console.h
  hw/display/bcm2835_fb: Move inclusion of console.h to the .c file
  hw/arm: Compile musicpal and the xlnx machines with the right CFLAGS
  tests/vm: Update OpenBSD to 7.7
  Revert "meson.build: Disable -fzero-call-used-regs on OpenBSD"

 meson.build                     | 6 +-----
 include/hw/display/bcm2835_fb.h | 1 -
 include/hw/dma/xlnx_dpdma.h     | 1 -
 hw/display/bcm2835_fb.c         | 1 +
 hw/arm/meson.build              | 4 ++--
 tests/vm/openbsd                | 4 ++--
 6 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.49.0


