Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ECBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGic-0006Tx-My; Mon, 12 Oct 2026 10:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xGGiS-0006Rs-0m
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xGGiP-0006dP-W8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791814160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7To75yL0aN0FZMPtBB1EWGmZfIN4gIjETgwlEcKtk3E=;
 b=TSDUCWIuNy6VTSVG6DHQVZGyjcxzcYaiQRKS/cNUZKfqkBdF4x1ftNp6eQmUnh1ATkv90M
 YrgeENcxgoeuE/A6JMlML86/XcnDmUUjIlAE2z52AcxV5FX1Cx4VyY65OkMVjHOSNSZk/1
 vigU/3JFasGIdYMaugm5FuFmYVa+eAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-YF5-SwSSMVezOvAUQ7Q9Fg-1; Mon, 12 Oct 2026 14:09:13 +0000
X-MC-Unique: YF5-SwSSMVezOvAUQ7Q9Fg-1
X-Mimecast-MFC-AGG-ID: YF5-SwSSMVezOvAUQ7Q9Fg_1791814152
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso15697335e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791814152; x=1792418952; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7To75yL0aN0FZMPtBB1EWGmZfIN4gIjETgwlEcKtk3E=;
 b=sbfVw+fmhFzVVutXSnsqXqXd359Xt64HvVonerdpTscl5YVKXvMY7ohaVBtAM8d4uq
 dP9UC3YgN+dP2r+o4b0S+Jl7JPuNyVWKJ6CRKDVecBllLs6H2MjOrCcAKQOMr7IIyXxJ
 ykghMWfNwBkaZk4/y7GvtnEdfRnfqnsvBim49/LS2qNmzE5Nlji9O/joUhnefBivKHWd
 KCA5TdaMIvGQ4HWnXIl7J4mcKROgazrjgdwyKUf/Mv9je4EOs8CwQvKXaWekUFkQmHZL
 2nGckfJw86pcF3G96HlLzanpEPr6o3wZxIfAPlbQZ/k/3oLbIbE4TnNyMLyQ9EywuIwF
 quJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814152; x=1792418952;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7To75yL0aN0FZMPtBB1EWGmZfIN4gIjETgwlEcKtk3E=;
 b=nrM9QCrs8qoU6L4rAW1DvKcO9DV9KaIQkBzV+q/MKMMnN9Gy0iUMPL/NsIoFt6VgOb
 skyKl2Jiv/ILiObuTpIJXR+9hV2WXtDAazow4cWH6FTW9HDh7sWQ//NdeyrBP63aG7Bc
 XWXYZa/VJfnn1lvf/j5mBlt0whqiuvS1wqRWosaYPHav4dGQ7R1mBpvNp3h6xwlplCmV
 j3xiOJMqUNCaE/lB/BeBEbGwKf0f1KeC2LjCnOK1WKTF7+Ajlri8C+FbvTQ8PIYbQCDj
 VgBfLr8fSbIb7LjvjG6nhWLFrYCakfzcRbfnDxoZ5C1pTz4G2eDBX4+5xM7/6U0elCA3
 qbzg==
X-Gm-Message-State: AFq9FYJVKsLlCdaaGsFj5eniDRGlcth64XxZ1z7sfftFKMXgheTxiIW8
 gqwW4sfQvlDxNxpG7mDNsA/7kLNWN+lKxAWm99u07o4es6EWQbFMET2dLATnvPd8DTrfUIRII7D
 XovcyOs608Fx5cE9cX8JsMD4qRDfn5ffwR2BcY7cH7kBfIfdXxrHhalzr
X-Gm-Gg: AYBFou2/Z4vvJpqVnM7+FmAglF+QwzNKShdUgqiskHfIDoRHkIkggpTTp9rdp6XOncW
 pO9I3SvhxWcpcLYqPAismtuZeaq0JuFO1P1c8UdNDeh7nGtXGspz+lteepHAazVYleX5Ko74Zxz
 pWU8SiGCacGUHEZ2xI9/EYA3s64mDKdxCg0l8ZyM4RtXJaiooQZ+T4Bhoo51wxkXZhLe7Uk6afB
 //BMCQ5LAJpnPx2pXvYh/9dc2vdZxO7CxZvM8SP8kuMoQEf7LzAXc2SH8hOO+zXDQjfdFErNTJb
 QG2cWf6Z5wq1cAdW8TCQY3r8tuEyzNFu8kRwpL5fl+SQ4l6No026yLk2NFa6KmoLo34eVA==
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-4a18e4b8885mr173582345e9.31.1791814151615; 
 Mon, 12 Oct 2026 07:09:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-4a18e4b8885mr173581785e9.31.1791814151000; 
 Mon, 12 Oct 2026 07:09:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19471edd5sm353189715e9.11.2026.10.12.07.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:09:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:09:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v10 00/12] virtio-console: notify about the terminal size
Message-ID: <20261012100858-mutt-send-email-mst@kernel.org>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 12, 2026 at 04:04:59PM +0200, Filip Hejsek wrote:
> Summary of the Series
> ---------------------
> 
> This series adds terminal size support to the virtio-console device.
> The goal is to make it possible to get a resizable terminal into a guest
> without using e.g. ssh.
> 
> Support for detecting terminal size is added to stdio and vc backends,
> but not pty and serial, because for the later it's unfortunately
> impossible to get resize notifications.
> 
> A QMP command is added for notifying QEMU about the terminal size
> of any chardev. This can be used by clients to support resizing for
> devices where QEMU is not able to detect the size by itself (e.g. virsh
> console).
> 
> There was a bug in Linux versions prior to 6.15 which caused the
> dimensions to be interpreted incorrectly by the guest. The fix has
> been backported to currently supported kernels, but to avoid making the
> terminal harder to use on out of date guests, the feature is disabled
> by default and must be enabled with the console-size property.
> 
> Limitations
> -----------
> 
> There is no documentation for the virtio-serial device. I'm working on
> this and will submit it separately.
> 
> Resizing support for the spice version of 'vc' chardev is still missing.
> 
> After migration, the guest is not informed about the new console size.
> I propably won't fix this any time soon unless someone helps me with
> migration stream changes.

virtio things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Full Changelog
> --------------
> 
> v10:
> - Fix build error on win32
> - Link to v9: https://lore.kernel.org/qemu-devel/20261012-console-resize-v9-0-8db78320ba81@gmail.com
> 
> v9:
> - Clean up SIGWINCH notifier when stdio or curses chardev is destroyed
> - Link to v8: https://lore.kernel.org/qemu-devel/20260929-console-resize-v8-0-2ff9183f8750@gmail.com
> 
> v8:
> - Rebased
> - Fixed uninitialized buffer in send_console_resize
> - "Since: 11.1" -> "Since: 11.2"
> - Link to v7: https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com
> 
> v7:
> - Rebased
> - Renamed some functions
> - Made virtio size support disabled by default
> - "Since: 11.0" -> "Since: 11.1"
> - Dropped "must exist" from chardev id param description in qmp docs
> - Link to v6: https://lore.kernel.org/qemu-devel/20260119-console-resize-v6-0-33a7b0330a7a@gmail.com
> 
> v6:
> - Rebased (renaming CharBackend -> CharFrontend)
> - Virtio resize message code rewritten to fix corner cases
> - Updated version numbers ('Since: 11.0', hw_compat_10_2)
> - Added note to CHR_EVENT_RESIZE definition comment, explaining
>   that only the focused frontend gets the event
> - Fixed checkpatch warning (line length)
> - Link to v5: https://lore.kernel.org/qemu-devel/20250921-console-resize-v5-0-89e3c6727060@gmail.com
> 
> v5:
> - Rename chardev-resize -> chardev-window-size-changed
> - Improve chardev-window-size-changed documentation
> - Add partial implementation for 'vc' chardev
> - Config space now returns port 0 size if multiport
> - Console-size property completely disables size support
> - Fix misnamed variables in char-win-stdio
> - Link to v4: https://lore.kernel.org/qemu-devel/20250912-console-resize-v4-0-7925e444afc4@gmail.com
> 
> v4:
> - Changed order of rows and cols fields
> - Added support for terminal size on Windows
> - Trace event is also emitted for legacy (non-multiport) drivers
> - Minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
> - Updated version numbers ('Since: 10.2', hw_compat_10_1)
> - Link to v3: https://lore.kernel.org/qemu-devel/20200629164041.472528-1-noh4hss@gmail.com
> 
> v3:
> - Add resize messages over QMP, as suggested by Daniel
> 
> v2:
> - Fix adding a new virtio feature bit to the virtio console device
> 
> ---
> Filip Hejsek (4):
>       char-win-stdio: add support for terminal size
>       ui/console-vc: forward text console size to vc chardev
>       ui/gtk: forward gtk console size to vc chardev
>       virtio-serial-bus: add terminal resize messages
> 
> Szymon Lukasz (8):
>       chardev: add cols, rows fields
>       chardev: add CHR_EVENT_RESIZE
>       chardev: add qemu_chr_resize()
>       char-mux: add support for the terminal size
>       main-loop: change the handling of SIGWINCH
>       char-stdio: add support for the terminal size
>       qmp: add chardev-window-size-changed command
>       virtio-console: notify the guest about terminal resizes
> 
>  backends/cryptodev-vhost-user.c   |  1 +
>  chardev/char-fe.c                 | 13 +++++++
>  chardev/char-mux.c                | 19 ++++++++-
>  chardev/char-stdio.c              | 33 ++++++++++++++++
>  chardev/char-win-stdio.c          | 19 +++++++++
>  chardev/char.c                    | 26 +++++++++++++
>  hw/block/vhost-user-blk.c         |  1 +
>  hw/char/terminal3270.c            |  1 +
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-console.c          | 35 +++++++++++++++--
>  hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
>  hw/display/vhost-user-media.c     |  1 +
>  hw/ipmi/ipmi_bmc_extern.c         |  1 +
>  hw/scsi/vhost-user-scsi.c         |  1 +
>  hw/usb/ccid-card-passthru.c       |  1 +
>  hw/usb/dev-serial.c               |  1 +
>  hw/usb/redirect.c                 |  1 +
>  hw/virtio/vhost-user-base.c       |  1 +
>  hw/virtio/vhost-user-scmi.c       |  1 +
>  include/chardev/char-fe.h         | 10 +++++
>  include/chardev/char.h            |  9 +++++
>  include/hw/virtio/virtio-serial.h |  7 ++++
>  include/qemu/main-loop.h          |  5 +++
>  monitor/hmp.c                     |  1 +
>  monitor/qmp.c                     |  1 +
>  net/passt.c                       |  1 +
>  net/vhost-user.c                  |  1 +
>  qapi/char.json                    | 31 +++++++++++++++
>  ui/console-vc.c                   |  8 ++++
>  ui/curses.c                       | 21 +++++++---
>  ui/gtk.c                          | 28 ++++++++++++++
>  util/main-loop.c                  | 33 ++++++++++++++++
>  32 files changed, 382 insertions(+), 12 deletions(-)
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20250912-console-resize-96c42140ba08
> 
> Best regards,
> --  
> Filip Hejsek <filip.hejsek@gmail.com>


