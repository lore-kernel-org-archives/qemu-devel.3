Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FEEC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdZ-00023K-U5; Tue, 20 Feb 2024 11:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdY-00022I-C1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdV-0005DD-S5
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4127109686fso3420365e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445184; x=1709049984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IWfkHBkdzDSrTFv4hDCtDnmdBw30BzGt9RydlPH9ceo=;
 b=UPxudtjJEj3CdAoWlfruIRl9KscAaakgiwe1p1NV2pyitvM+JkVqxiMLC2KRpRj3zs
 m8lh1e7e99j8jPQ1uP6mACa2gY0Z+Ka5gHxET/1WTNDF4Uo52NYcsNqTHjeVmU74SkHc
 mNLSdVhfssfEVSM/YUKAMLrWQNkIRfYS24i+cm69G55n+0BwWPg/cC/L/CjsRKHnD0sW
 G/RR53FOnskZ+W8nxG0QdZT0mxGZGkswdbntVXhUz0K3CQqFg3dFstKOYGGS8+7cdnFy
 rcHDhNvbyNqgvOdIX8g2t7T+AdebU08JCutyZ7swMum4QzWf0J5u9A6vPPDNf154tE5L
 PBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445184; x=1709049984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWfkHBkdzDSrTFv4hDCtDnmdBw30BzGt9RydlPH9ceo=;
 b=N/xCYc6O/u6DkQak6ExGvXe3Xj1htjHrGiumDl/vMRCzlWbw77eyzsxJm0gnU0iQFy
 Fu12HpERoJ+rQjyjZLUFmJnEge5a3nZMa6HXdpzPGriF/NNvc3LHeLjw+XlrLe2r+jSi
 Xn+a60cbGzoDZt21SqjXsNnUac1GX28Pqt9+1KJePZybG09pWU2ZkF8qMooXAUyp2Z2E
 P1U/EswRiaOArFWBzT+6b4RHiaMzh/4Ucurg+ccocXfptAugdjqgug/7hPfYPDa5OEH7
 caShoV+OOLdIH0C9Qzxgw9Tzs2gjU9KznA5QNGV352KyuWgA6GcV0nW5+wMrY+EVh2zf
 5KXA==
X-Gm-Message-State: AOJu0YyJwIiNyEfHJ1lx09wzvkx2AW/0kso9kvPqrDq4hrEov7xUKhGu
 XyTfS4TGqDFyflIxnOX2yGNpLtqzXj7Eth/6gZ6VOTi7LXDUt8Jm5MCYnfhBl1F8Yai91Lr59BV
 G
X-Google-Smtp-Source: AGHT+IE+HoGPV0+WFqAkIl3n94FD6gbKqNxY/9CxTtqZ0NqPEmnbK9NsySqzQfrpdOytdeE768IVRQ==
X-Received: by 2002:a05:600c:1d24:b0:412:6574:c9a6 with SMTP id
 l36-20020a05600c1d2400b004126574c9a6mr5261169wms.2.1708445184039; 
 Tue, 20 Feb 2024 08:06:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 00/10] reset: Make whole system three-phase-reset aware
Date: Tue, 20 Feb 2024 16:06:12 +0000
Message-Id: <20240220160622.114437-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset is an incremental improvement to our reset handling that
tries to roll out the "three-phase-reset" design we have for devices
to a wider scope.

At the moment devices and buses have a three-phase reset system, with
separate 'enter', 'hold' and 'exit' phases. When the qbus tree is
reset, first all the devices on it have their 'enter' method called,
then they all have 'enter' called, and finally 'exit'. The idea is
that we can use this, among other things, as a way to resolve annoying
"this bit of reset work needs to happen before this other bit of reset
work" ordering issues.

However, there is still a "legacy" reset option, where you register a
callback function with qemu_register_reset(). These functions know
nothing about the three-phase system, and "reset the qbus" is just one
of the things set up to happen at reset via qemu_register_reset().
That means that a qemu_register_reset() function might happen before
all the enter/hold/exit phases of device reset, or it might happen after
all of them.

This patchset provides a new way to register a three-phase-aware reset
in this list of "reset the whole system" actions, and reimplements
qemu_register_reset() in terms of that new mechanism. This means that
qemu_register_reset() functions are now all called in the 'hold' phase
of system reset. (This is an ordering change, so in theory it could
introduce new bugs if we are accidentally depending on the current
ordering; but we have very few enter and exit phase methods at the
moment so I don't expect much trouble, if any.)

The first three patches remove the only two places in the codebase
that rely on "a reset callback can unregister itself within the
callback"; this is awkward to continue to support in the new
implementation, and an unusual thing to do given that reset is in
principle supposed to be something you can do as many times as you
like, not something that behaves differently the first time through.

Patch 4 is an improvement to the QOM macros that's been on list as an
RFC already.
Patches 5 and 6 are the "new mechanism": qemu_register_resettable()
takes any object that implements the Resettable interface. System
reset is then doing 3-phase reset on all of these, so everything
gets its 'enter' phase called, then everything gets 'hold', then
everything gets 'exit'.

Patch 7 reimplements the qemu_register_reset() API to be
"qemu_register_resettable(), and the callback function is called
in the 'hold' phase".

Patch 8 makes the first real use of the new API: instead of
doing the qbus reset via qemu_register_reset(), we pass the
root of the qbus to qemu_register_resettable(). (This is where
the ordering change I mention above happens, as device enter and
exit method calls will now happen before and after all the
qemu_register_reset() function callbacks, rather than in the
middle of them.)

Finally, patch 9 updates the developer docs to describe how a
complete system reset currently works.

This series doesn't actually do a great deal as it stands, but I
think it's a necessary foundation for some cleanups:
 * the vfio reset ordering problem discussed on list a while back
   should now hopefully be solvable by having the vfio code use
   qemu_register_resettable() so it can arrange to do the "needs to
   happen last" stuff in an exit phase method
 * there are some other missing pieces here, but eventually I think
   it should be possible to get rid of the workarounds for
   dependencies between ROM image loading and CPUs that want to
   read an initial PC/SP on reset (eg arm, m68k)
I also think it's a good idea to get it into the tree so that we
have a chance to see if there are any unexpected regressions
before we start putting in bugfixes etc that depend on it :-)

After this, I think the next thing I'm going to look at is whether
we can move the MachineState class from inheriting from TYPE_OBJECT
to TYPE_DEVICE. This would allow us to have machine-level reset
(and would bring "machine as a container of devices" into line
with "SoC object as container of devices").

thanks
-- PMM

Peter Maydell (10):
  hw/i386: Store pointers to IDE buses in PCMachineState
  hw/i386/pc: Do pc_cmos_init_late() from pc_machine_done()
  system/bootdevice: Don't unregister reset handler in
    restore_boot_order()
  include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{,_WITH_INTERFACES}
    macros
  hw/core: Add documentation and license comments to reset.h
  hw/core: Add ResetContainer which holds objects implementing
    Resettable
  hw/core/reset: Add qemu_{register,unregister}_resettable()
  hw/core/reset: Implement qemu_register_reset via
    qemu_register_resettable
  hw/core/machine: Use qemu_register_resettable for sysbus reset
  docs/devel/reset: Update to discuss system reset

 MAINTAINERS                      |  10 ++
 docs/devel/qom.rst               |  34 ++++++-
 docs/devel/reset.rst             |  44 +++++++-
 include/hw/core/resetcontainer.h |  48 +++++++++
 include/hw/i386/pc.h             |   4 +-
 include/qom/object.h             | 114 ++++++++++++++++-----
 include/sysemu/reset.h           | 113 +++++++++++++++++++++
 hw/core/machine.c                |   7 +-
 hw/core/reset.c                  | 166 +++++++++++++++++++++++++------
 hw/core/resetcontainer.c         |  76 ++++++++++++++
 hw/i386/pc.c                     |  40 +++-----
 hw/i386/pc_piix.c                |  16 ++-
 hw/i386/pc_q35.c                 |   9 +-
 system/bootdevice.c              |  25 +++--
 hw/core/meson.build              |   1 +
 15 files changed, 587 insertions(+), 120 deletions(-)
 create mode 100644 include/hw/core/resetcontainer.h
 create mode 100644 hw/core/resetcontainer.c

-- 
2.34.1


