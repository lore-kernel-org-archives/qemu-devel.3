Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F05CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzLT-0002wg-JK; Fri, 12 Sep 2025 04:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwzLP-0002l7-UY
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uwzLH-0005kz-QC
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757666468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fuE1tawCEx5//+CuLx5eXAfEww9sqaa1bQBLSOdat6w=;
 b=jKu9poK39JGbyJJ62/wk+lZmQ5ccWkvnHZEbeT/gn7eNRDoq6h2PT/yjOOhCbR8gebzgGQ
 d8lsGgZCnq6b+LifAdUdHUxdttWTLEeUHDL1UIafk3PvgSGw2osFvqOuRJoL38GRljofjS
 npyyxyAWpypfBcyfjUbNG2AzuC4AGA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gwzBgoJxO_akEtwpE_cxGA-1; Fri, 12 Sep 2025 04:41:07 -0400
X-MC-Unique: gwzBgoJxO_akEtwpE_cxGA-1
X-Mimecast-MFC-AGG-ID: gwzBgoJxO_akEtwpE_cxGA_1757666466
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b986a7b8aso13144985e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 01:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757666466; x=1758271266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuE1tawCEx5//+CuLx5eXAfEww9sqaa1bQBLSOdat6w=;
 b=wiJi5ucy453eieBXBwR/z7ze9rRon+fX7ATJMFoPe2imSsGUiSo2mCgn8jS+EcEoGe
 PUEIGjOgaQi30IUu3W7AEojRM2Vk3ce2/z9jyrEOsc7uc1S5NIbXFAHo1BxHmL9c91vf
 E9Z6CRL0P0xRJdCzWEHpPkXObEHzcdFpPVQq5wDO8R8DvMJwddSF8HmOyjOJdpKqe9eS
 F26lESaDr1MvBGUnRSenGCe6KQJ3VpD2ryANaWUCC3z/cd5XI8/LiMsJ4mM3P6mCbVW5
 4Z/oR2VipmF/LaY9nj3ETDF/Pfq47ypuNs8avHmDdWEYKpK4IZmlfXXkXt1vhSxmUpJz
 +QkA==
X-Gm-Message-State: AOJu0YwlM6B74KeaIwbSsZuyejB/sbZHFB1Zk2L6MT16KsDQ78U4LYDD
 w+Qho21eplXTnwVM5dJTgUtJhOydjByH5VU5HyTaGVZ/JKIw89SWrOzZ8ufJXQ+P+9qTwGlzX0J
 KXIgKlbn0AVm77uqeOU5FTBu1FnOEIh6dv1OnITjxYZEM6THbdkz337IN
X-Gm-Gg: ASbGncsddXXZuLD3hEpurpYgbqxB8kSRbcTJNRgFoSqIpY7oZHDJgBEyYLeNA7ri7IB
 HlOocF80uXmv82ROvPDzuf1pQ7POqZq/KFcIPHKc9lOOEih94HKR3S2EUfeOFeer1iKUqZF7985
 O/IQnTDRbZ8LBToPoVN0pFPoj/L9MkaHmKqAtQdVips8MDMCQG2ZJk+R/6e4QnwuA1CDPl+iB0P
 ImaHsheYXwe217HOgPYzrqQkLXxhuZ1Ju8qcn1ooclN97DJc3eTEzuPd0KZVij6KWL0Jx8L129m
 UF40Vfwdl4UaDOkiZR/+RjmcR45cXqfq
X-Received: by 2002:a05:600c:1c9e:b0:45d:dba1:b4d3 with SMTP id
 5b1f17b1804b1-45f2556395cmr488255e9.0.1757666466144; 
 Fri, 12 Sep 2025 01:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIze/BGR9me+HqnXV+fDAfb+oIvFOcJJYIWoWSmk/aAfnFW45mR7qTui0m1J62goRQKA6W4Q==
X-Received: by 2002:a05:600c:1c9e:b0:45d:dba1:b4d3 with SMTP id
 5b1f17b1804b1-45f2556395cmr487975e9.0.1757666465644; 
 Fri, 12 Sep 2025 01:41:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156abecsm56989275e9.4.2025.09.12.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 01:41:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:41:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
Message-ID: <20250912042910-mutt-send-email-mst@kernel.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 05:39:45AM +0200, Filip Hejsek wrote:
> The goal of this series is to have a resizable terminal into a guest
> without having to set up networking and using, e.g. ssh.
> 
> The virtio spec allows a virtio-console device to notify the guest about
> terminal resizes in the host. Linux Kernel implements the driver part of
> the spec. This series implement the device part in QEMU.
> 
> This series adds support for a resizable terminal if a virtio console
> device is connected to the stdio backend.
> 
> This series also introduces resize messages that can be sent over QMP to
> notify QEMU about the size of the terminal connented to some chardev.
> In the libvirt setting, it will allow to implement a resizable terminal
> for virsh console and other libvirt clients.
> 
> This patch series was originally authored by Szymon Lukasz and submitted
> to qemu-devel about 5 years ago. The previous submission can be found at
> <https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09591.html>.
> I have updated the patches to be compatible with latest master and made
> a few small changes of my own, including the addition of Windows support.
> 
> Probably the most important change I made is the swapping of rows and
> cols fields in resize messages. I would like to hear some feedback on
> this change from reviewers. The problem is that for a long time, the
> Linux kernel used a different field order from what was specified in the
> virtio spec. The kernel implementation was apparently merged around 2010,
> while the virtio spec came in 2014, so when a previous version of this
> patch series was being discussed here on this mailing list in 2020, it
> was decided that QEMU should match the Linux implementation, and ideally,
> the virtio spec should be changed.
> 
> However, recently, the Linux kernel implementation was changed to conform
> to the spec: <https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c7056ddd>.
> As a result, to be compatible with latest kernel releases, QEMU needs to
> also use the field order matching the specification. I have changed the
> patch to use the spec-compliant order, so it works correctly with latest
> kernels now.
>

Well this is not in any release yet. If you want me to revert that
one, let me know ASAP. Maximilian?

> That leaves the issue of older kernels. There are about 15 years' worth
> of kernel versions with the swapped field order, including the kernel
> currently shipped in Debian stable. The effects of the swapped dimensions
> can sometimes be quite annoying - e.g. if you have a terminal with
> 24 rows, this will be interpreted as 24 columns, and your shell may limit 
> line editing to this small space, most of which will be taken by your
> prompt. The patch series in its current form provides no way to disable
> the console size functionality,

Well I see the console-size property, no?

> so users may end up worse off than if
> the functionality were not implemented at all.

If we want to keep the Linux patch, the straight forward way is to send
the fix to stable@ then poke at Debian at al to fix their kernels.

Another option is to make the property default to off, have
management turn it on when guest is up to date.

But it really sounds like we should revert that Linux patch.
I posted a revert, pls comment.

> PS: One of the patches adds one additional noop switch case
>     to a bunch of files. I didn't include the maintainers of these files
>     in the Cc list. I hope that's OK. :)
> 
> v4:
> changed order of rows and cols fields
> added support for terminal size on Windows
> trace event is also emitted for legacy (non-multiport) drivers
> minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
> updated version numbers ('Since: 10.2', hw_compat_10_1)
> 
> v3:
> add resize messages over QMP, as suggested by Daniel
> 
> v2:
> fix adding a new virtio feature bit to the virtio console device
> 
> ---
> Filip Hejsek (1):
>       char-win-stdio: add support for terminal size
> 
> Szymon Lukasz (9):
>       chardev: add cols, rows fields
>       chardev: add CHR_EVENT_RESIZE
>       chardev: add qemu_chr_resize()
>       char-mux: add support for the terminal size
>       main-loop: change the handling of SIGWINCH
>       char-stdio: add support for the terminal size
>       qmp: add chardev-resize command
>       virtio-serial-bus: add terminal resize messages
>       virtio-console: notify the guest about terminal resizes
> 
>  backends/cryptodev-vhost-user.c   |  1 +
>  chardev/char-fe.c                 | 13 ++++++++
>  chardev/char-mux.c                | 18 ++++++++++-
>  chardev/char-stdio.c              | 30 +++++++++++++++++++
>  chardev/char-win-stdio.c          | 19 ++++++++++++
>  chardev/char.c                    | 26 ++++++++++++++++
>  hw/block/vhost-user-blk.c         |  1 +
>  hw/char/terminal3270.c            |  1 +
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-console.c          | 63 ++++++++++++++++++++++++++++++++++++---
>  hw/char/virtio-serial-bus.c       | 43 ++++++++++++++++++++++++--
>  hw/core/machine.c                 |  4 ++-
>  hw/ipmi/ipmi_bmc_extern.c         |  1 +
>  hw/scsi/vhost-user-scsi.c         |  1 +
>  hw/usb/ccid-card-passthru.c       |  1 +
>  hw/usb/dev-serial.c               |  1 +
>  hw/usb/redirect.c                 |  1 +
>  hw/virtio/vhost-user-base.c       |  1 +
>  hw/virtio/vhost-user-scmi.c       |  1 +
>  include/chardev/char-fe.h         | 10 +++++++
>  include/chardev/char.h            |  7 +++++
>  include/hw/virtio/virtio-serial.h |  5 ++++
>  include/qemu/main-loop.h          |  4 +++
>  monitor/hmp.c                     |  1 +
>  monitor/qmp.c                     |  1 +
>  net/passt.c                       |  1 +
>  net/vhost-user.c                  |  1 +
>  qapi/char.json                    | 22 ++++++++++++++
>  ui/curses.c                       | 11 +++----
>  util/main-loop.c                  | 21 +++++++++++++
>  30 files changed, 298 insertions(+), 13 deletions(-)
> ---
> base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
> change-id: 20250912-console-resize-96c42140ba08
> 
> Best regards,
> -- 
> Filip Hejsek <filip.hejsek@gmail.com>


