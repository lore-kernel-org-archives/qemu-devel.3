Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5A7C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:36:56 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9xM-0001Lg-KB; Tue, 25 Jun 2024 13:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yj-0003VB-SH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:13 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yh-0003FM-Ty
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so5938725a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719327249; x=1719932049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BolIY5TOEfeGTeNF4c4dvE9NC9ut6CgmsKTCt2WtDnM=;
 b=G2ka4foccKqgVLrSN9TO6tepoGtSQv03lEH12d22Ufi2ZYTGU+Absmie/7Rl0CDDm5
 3Pa/tiw0MXvdUwfjBjlxEBDmZwqes+VJPOWs8xc35EldwZmccy3eiGu13qH8xUcaZnpO
 jXN85m20+pfGCqJ3u6N4vmJ2FrOzToQqnocl6xQD8Vpn04QY6kfIJuKb88tZM8mtCu7H
 OB2PDjXfS+mTLnfQU7xyrc+wu+gBtDfnUQk4u+C0HlQXK2Wy4Z+vLlHbP7XW7cwxoKMK
 jVvadKD2JdoXcilTdPPiHN18skZCfb6EERJSK5TWoStl2PYMaUacEtaPbULTbOXSSxOH
 V/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327249; x=1719932049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BolIY5TOEfeGTeNF4c4dvE9NC9ut6CgmsKTCt2WtDnM=;
 b=wTbYHCowv5IuHSCNQgysroDbkcadHt7QOaHrFFUw7tQu/5ZDxzsuopX87IeY6BB7gp
 6EKh1GVe6IkFbQGAKoFa+PRik2RVrbVW+f1SuDi47SFLL5uPHaHlvgwp47yi7aS+verJ
 f2CIqs/W1Lw9kRXexK4tZ1ArmF8iT5SkN3dC1aEY9j7decd9DoJPmNgSrJ1YvaP2/kbS
 JJodd7/TKoibMXQZBXFMvK8TOVWxZlT0JFTy/qZCLEHORqku3X2D9qYsGi3LGA9zhI7E
 lIQcBQrVbEezqVem6BbsWuUDdN6Y4Bq1DSxUnIgz2Shqq1MF4B3vGOoawVGjTcH5Y4Ic
 85jg==
X-Gm-Message-State: AOJu0YyarwA99iL+KHdZ5Fx1GuRpV6yGT+DAFJBXI0LV2J4egr0NwK5p
 fPA2Oo+qxAcnWaAJHFDpetwTWI7a8ROc7MA/zG9yEzV1G8G3p+tC2xVedQ==
X-Google-Smtp-Source: AGHT+IElRqXGWfhGNIc6lHI3FeV9hD+2nW703lHkyxW3jJEobTYKsPHQZfiY4T6IhKUdPYjqOvPVKw==
X-Received: by 2002:a50:d7d4:0:b0:57c:7599:2c67 with SMTP id
 4fb4d7f45d1cf-57d4580ac7dmr5960675a12.37.1719327248975; 
 Tue, 25 Jun 2024 07:54:08 -0700 (PDT)
Received: from 41414141.home (84-82-177-210.fixed.kpn.net. [84.82.177.210])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d421sm6092740a12.42.2024.06.25.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:08 -0700 (PDT)
From: David Bouman <dbouman03@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Bouman <dbouman03@gmail.com>
Subject: [PATCH 0/4] hw/usb/u2f-passthru: U2F keepalive fixes
Date: Tue, 25 Jun 2024 16:53:46 +0200
Message-Id: <20240625145350.65978-1-dbouman03@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=dbouman03@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 13:25:45 -0400
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

Hello,

The u2f-passthru device is currently broken for (at least) the Yubikey 5.
(gitlab: https://gitlab.com/qemu-project/qemu/-/issues/2293)

This patchset aims to fix the issue by properly handling the
U2F keepalive response in the u2f-passthru device.

I initially suspected the hidraw chardev handle management to be the
culprit, so I also implemented a more efficient strategy where the host
hidraw chardev is only opened as long as the guest actually needs it to be opened.

This turned out to not be the root cause, but regardless, it's probably the 
right way to be doing it. Hence, I also included these patches here.

The patches were tested with `pamu2fcfg` in an x86_64 Linux guest
with the u2f-passthru device backed by a physical Yubikey 5 (type C model). 

---

I apologize for any anticipatory errors, I'm not really acquainted with the
USB/HID/U2F protocols, nor with QEMU. Happy to hear your feedback!

David Bouman (4):
  hw/usb/u2f: Add `start` and `stop` callbacks to U2F key class
  hw/usb/u2f-passthru: Do not needlessly retain handle to hidraw chardev
  hw/usb/u2f-passthru: Clean up code
  hw/usb/u2f-passthru: Implement FIDO U2FHID keep-alive

 hw/usb/u2f-passthru.c | 163 ++++++++++++++++++++++++++++--------------
 hw/usb/u2f.c          |  23 ++++++
 hw/usb/u2f.h          |   5 ++
 3 files changed, 138 insertions(+), 53 deletions(-)

-- 
2.34.1


