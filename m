Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034BCCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwugp-0006y3-BC; Thu, 11 Sep 2025 23:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugm-0006xr-Nl
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugi-0007tn-HX
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45df09c7128so11040005e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648579; x=1758253379; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w9bUt/Tvj+p3SnTXLw7pcU3VuuU3mk0x0VCnm5Z8Xx0=;
 b=ET4eHBGA5utZtOlT97uoRGoaj+wqt00DDLsa/Vdu4UCqI6d+EHHnm69rYNcOKQuWoX
 eaB9w8gIL4S5RRdHGg/1jbIqoakJ38HuN1u2kLjD9Ki5Cqa8uyqvPqST6W7JYktSpf+9
 DjXevyB6xj3hUDlA6S6kqEsc/bTE/WiouFURvF68yKdEvzZFXnF2o3GrkW3zCTLNSA+7
 S6blLsgD3n+KdKD818/3Kv5VsIovEJNVuZfTIzMsKJbq8F8h1OuznXiuFgUq8gPbGbMN
 2LuZ+b928uxPKtZHj+Yv2cYvhgwxgkKOnUe+ZkRanPzckksTF7qk6bhK1lPETRfWliIa
 gYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648579; x=1758253379;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9bUt/Tvj+p3SnTXLw7pcU3VuuU3mk0x0VCnm5Z8Xx0=;
 b=R70nww/qXWC42lemla1YmEImJcKvQC/G0UM1Q8dIg6x6iEEJAenAEK1/nf2psIIIqO
 w4pVdbCHNfxJOXjOmkGTiSTzL50OOnK64eEnxD6UFY4hGFiMyF+qPznESl5/Mikz7mcW
 slWnLeHxyYlrUAYOvJmpYcPCyd9j/bK5N8sENkviJS48FkRsglvAL73hgdl3r/bsSkcF
 j0UQNHGkDd/30N9fsPTwiB5D21IvnXi/OSDxtjbUtNvAWKkRY/iwclAGePF1iLHLcOBU
 sg617xSJwYFPT7IchM6Z3wWb31qAv8/vCY4mHv57IZznCpAfO/wH0DujS+MQmd1dkvgj
 xntw==
X-Gm-Message-State: AOJu0Yx9INJigz7LsGVA4wy6F8ZMzSMDHhBj4AfK+zJ2skwQLGY7BfuJ
 TFWsVEBlDGzCOuQTyXATqpso2T1orxQ1MioVAKyoS7AcbsHvbs2lsceJ
X-Gm-Gg: ASbGncsN8Wf0H2XsBds1S8HqSHvRgMTVOLIYo7C311ozs6BKr811gRftSZQHxdDIrLN
 WmgwdBUu4kUPPmU/B2bJa9LtJlA/D8ozzSvPAhWMbCXKdGSrXtmQPYhHmU8oyBfLGRE5AI6YiVU
 unSD/a6f32xlHzzsM2OmoKFGxJnwSzq6AE6Me0iuXJnTAt56tLYNtgynWQD0rhwoBruBz3NaOHI
 L/lxpXzum2dbEjwSTrnDdKvI4HEejH3e+Gtk5VhZJB+66l+IyW93w+9tr8eu9dDaPGpvgQNHU+2
 3yLqdXXQK340lJc4CVN+A73xn8OjpirPhpHbiXOAVIACnJi07QU5Rd8YqERa/0t51hT5Mr3x/kS
 ic6h6k0k33yijMmUCTN4xNFrO/arM74eROSBx+liN6+EWABtNiXMG/Tsk7+N9Pr4=
X-Google-Smtp-Source: AGHT+IFUyAJhJSgyEodEsfKa5ucOE+luGQNzRDYYJbyE0A5wNmR0LAK6wDRBL2p2qFPaBPELodM8NQ==
X-Received: by 2002:a05:600c:1d03:b0:45b:86bb:af5f with SMTP id
 5b1f17b1804b1-45dfd5b59c2mr50974225e9.6.1757648578666; 
 Thu, 11 Sep 2025 20:42:58 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e0372aea2sm48498795e9.7.2025.09.11.20.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:42:58 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v4 00/10] virtio-console: notify about the terminal size
Date: Fri, 12 Sep 2025 05:39:45 +0200
Message-Id: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGWw2gC/zXMQQrCMBBA0auUWTslGaa1deU9xEWM02agTSQRE
 UvvbhBcvsX/GxTJKgVOzQZZXlo0xQo+NOCDi7Og3quBDHVmtIQ+xZIWwSxFP4Jj75ksm5szA9T
 okWXS9294uVZPOa34DFncf2NMT6Pt2bBt+UgdDWgxpsChlPO8Ol1an1bY9y+9neZ1nAAAAA==
X-Change-ID: 20250912-console-resize-96c42140ba08
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648576; l=5563;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=cepkGRsyCr/hmbPwQfFODYBL5dLHQlIAzX5rLnCaMVw=;
 b=uOUvzZx3KN9ZvCTEs1TtN79Vt7IgZXa07ovZRmLqjiZjdrsHLfYG4Da8m8ZPM0PwPVbI6EQwp
 M5LIiDgduZ4AhWI2TL5PtJDQwV3YDdmsrTjTqD4wYOwghN6IUHRrpQH
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The goal of this series is to have a resizable terminal into a guest
without having to set up networking and using, e.g. ssh.

The virtio spec allows a virtio-console device to notify the guest about
terminal resizes in the host. Linux Kernel implements the driver part of
the spec. This series implement the device part in QEMU.

This series adds support for a resizable terminal if a virtio console
device is connected to the stdio backend.

This series also introduces resize messages that can be sent over QMP to
notify QEMU about the size of the terminal connented to some chardev.
In the libvirt setting, it will allow to implement a resizable terminal
for virsh console and other libvirt clients.

This patch series was originally authored by Szymon Lukasz and submitted
to qemu-devel about 5 years ago. The previous submission can be found at
<https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09591.html>.
I have updated the patches to be compatible with latest master and made
a few small changes of my own, including the addition of Windows support.

Probably the most important change I made is the swapping of rows and
cols fields in resize messages. I would like to hear some feedback on
this change from reviewers. The problem is that for a long time, the
Linux kernel used a different field order from what was specified in the
virtio spec. The kernel implementation was apparently merged around 2010,
while the virtio spec came in 2014, so when a previous version of this
patch series was being discussed here on this mailing list in 2020, it
was decided that QEMU should match the Linux implementation, and ideally,
the virtio spec should be changed.

However, recently, the Linux kernel implementation was changed to conform
to the spec: <https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c7056ddd>.
As a result, to be compatible with latest kernel releases, QEMU needs to
also use the field order matching the specification. I have changed the
patch to use the spec-compliant order, so it works correctly with latest
kernels now.

That leaves the issue of older kernels. There are about 15 years' worth
of kernel versions with the swapped field order, including the kernel
currently shipped in Debian stable. The effects of the swapped dimensions
can sometimes be quite annoying - e.g. if you have a terminal with
24 rows, this will be interpreted as 24 columns, and your shell may limit 
line editing to this small space, most of which will be taken by your
prompt. The patch series in its current form provides no way to disable
the console size functionality, so users may end up worse off than if
the functionality were not implemented at all.

PS: One of the patches adds one additional noop switch case
    to a bunch of files. I didn't include the maintainers of these files
    in the Cc list. I hope that's OK. :)

v4:
changed order of rows and cols fields
added support for terminal size on Windows
trace event is also emitted for legacy (non-multiport) drivers
minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
updated version numbers ('Since: 10.2', hw_compat_10_1)

v3:
add resize messages over QMP, as suggested by Daniel

v2:
fix adding a new virtio feature bit to the virtio console device

---
Filip Hejsek (1):
      char-win-stdio: add support for terminal size

Szymon Lukasz (9):
      chardev: add cols, rows fields
      chardev: add CHR_EVENT_RESIZE
      chardev: add qemu_chr_resize()
      char-mux: add support for the terminal size
      main-loop: change the handling of SIGWINCH
      char-stdio: add support for the terminal size
      qmp: add chardev-resize command
      virtio-serial-bus: add terminal resize messages
      virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 ++++++++
 chardev/char-mux.c                | 18 ++++++++++-
 chardev/char-stdio.c              | 30 +++++++++++++++++++
 chardev/char-win-stdio.c          | 19 ++++++++++++
 chardev/char.c                    | 26 ++++++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 63 ++++++++++++++++++++++++++++++++++++---
 hw/char/virtio-serial-bus.c       | 43 ++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 ++-
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/vhost-user-base.c       |  1 +
 hw/virtio/vhost-user-scmi.c       |  1 +
 include/chardev/char-fe.h         | 10 +++++++
 include/chardev/char.h            |  7 +++++
 include/hw/virtio/virtio-serial.h |  5 ++++
 include/qemu/main-loop.h          |  4 +++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 22 ++++++++++++++
 ui/curses.c                       | 11 +++----
 util/main-loop.c                  | 21 +++++++++++++
 30 files changed, 298 insertions(+), 13 deletions(-)
---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250912-console-resize-96c42140ba08

Best regards,
-- 
Filip Hejsek <filip.hejsek@gmail.com>


