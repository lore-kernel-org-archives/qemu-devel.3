Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC726C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3poq-0005CA-H5; Tue, 08 Sep 2026 03:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3pon-00058D-Rh
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3pol-00053q-I3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788850829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVH6SBfVU6S7gvL0aVMDaClmyYxKZDRsec1qjraPg8M=;
 b=a+u5sP4Zwen2/xGmTmNWarDNMqZ80nR/IYsuIykCfFjT52+fK62Y+aHWfcKOIIfbEQgh22
 WCvwyjCjJqXoi6q1Ei8LmKWgAU/AQaVf5VqOO773Gh+9dU9UtSFvwvaMIK1ud0WotVisWF
 4kNPKEmkIvxhuxSETj+PXyAchNagGW4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-A26ryvvEOoK6qvKTU0WDog-1; Tue, 08 Sep 2026 03:00:28 -0400
X-MC-Unique: A26ryvvEOoK6qvKTU0WDog-1
X-Mimecast-MFC-AGG-ID: A26ryvvEOoK6qvKTU0WDog_1788850827
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-395543dc382so5610875a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 00:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788850827; cv=none;
 d=google.com; s=arc-20260327;
 b=fqFnUgHP6a5ezrPUoXgZtXWpnwQeanmReU9edk2v7mZ+5UD7/YeEEk/8v3QtyG/Uvr
 PzWm6pZGYb6JSBGFTnKZjzvscG7thiTWOEkdAMURHNQSpTvsw9dTXrvMpVRwC4JQzi2C
 rS9byujiv8uVGA81NEpUUDZpudNTXrO2N4qepyEWd/wNzxsvSsQzTTWnkxF/iCG/oXIJ
 Y/6X4jb3LW0gTo6los/ezlRIkjEG6rtcIVMqRP6F12prftV/cpu3eGw3Xfp075jGkIe6
 4ICmxfztArATYHu0O8tTXNY/B4XvN204QpWvj4ed9yXQB3d+qSLfhTny9YiHAcz0rhnL
 roSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BVH6SBfVU6S7gvL0aVMDaClmyYxKZDRsec1qjraPg8M=;
 fh=W6CxA2oz1yGR/6IGrxMgKl47k/4n4yGwHaf3TFfFPco=;
 b=IQV4BXn4QzDLrWNNnFlukpF0va7CVgyrmpZ6+phvVQ8oB6UFyZyOr4wIDGKQGzlp9M
 W5fW78Lv+MOAyz5BOJBFXPrqVePPSXZWRjWxupeyvsywoBWTdIluHhhIstk45ELvnddF
 PIR3idHTg2R1sgW6HIV66ULTzpoRzaA3JnNxjrUkrvqI4AdaYQ8wphQDM79NvcK8qdmX
 MOEJg9UTcUp28UTQ28y+Bag5u4qdPcuApqhnR8ZShADG0WZxM/KptAUzMVLB35BW9x3N
 izISYPWT3EN2/5x8t0uHJpOKt8j1V+u/WrSo2JmIOM1XkqpKObhPtkpSqfUvrXzG3P+c
 cPjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788850827; x=1789455627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BVH6SBfVU6S7gvL0aVMDaClmyYxKZDRsec1qjraPg8M=;
 b=a4Y7IfyAD4mOGRRHaunxdYAsli6dORQ1z/4ZQmJYKzu8FznAyMfYYW13ywj7aV49Bz
 Cj+T+RwKsN4SOKht1m661RtEteuiZ5J9umMbC5mwKal4H34pVHnFiLCzzvpPYL8v1Jly
 dOVZYX1kImRvRgCyHwHRcIpj/+308IoA4uCEEY7QKkU7KXEluWg3Ed9KCPaCht3xzrUH
 flQFxLHkyMVMUJwTbWzZmPQr/Z0VhMYPC6Tq341UnkeTqCDYGwZ3UUNobxs0KDwDZDHY
 P1Sh+R57vNGvOZBuyjI857Hqar/Eehz96okVEngnJy7rag2kDfzvcazppa67eLhleHGD
 dn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788850827; x=1789455627;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BVH6SBfVU6S7gvL0aVMDaClmyYxKZDRsec1qjraPg8M=;
 b=TGrWWPtQ+DXUBB1cxCE4Ce1dVKLv4dds6BbaEkD0rQy/zkdPlAMegMjPhUDQIVAFd/
 i60/HPZXXl1j0mRzCcoM761qOwbvalHpST+x+Q7vNN5WauhVGoS0R26CQvN8gTTM7+Bv
 p9IDC+S6gEgjJcZgBDTixchtLT9pK0gXB4ENhNGkDPZ3RkX4bOLacUMv2NSJ2/9kdo1G
 FuOTi6ui5lesMTn6addgHNWOG58XK2kR8tCDqa3BGBOsPaCZ7aRqwoHbHLfFeA/tTbQR
 hwcYrlXbGCPs67UImM97KSEmvJq1SUHinMVLlyyTXNGzQ8UaFSWoUkK7i7S+tSlH79PS
 y/+g==
X-Gm-Message-State: AFuF++mXOUNUMghlpRi+t6JUhZhxUrQo0WK7WPLa2RjJltxbLNbM6iLx
 sn0pBoFSMO0Std7phGY8wEo7y69k/daQvLISju7g0IE7BAQkKE0o3s5BGLSqREbbruxlfeWeo0x
 X+yb7YKgJzr04m8S0ofr3+PzL5Z7wgr6Y0073i1Hu/Zyhrp9QWU4oxuklq+Dc6BKUxMRVG0A19v
 PTiaNTdHYXZLtHYtTjMuYOKhlSOHma4s8=
X-Gm-Gg: AYBFou36sKiKWNDxI1L43KaGreXZQ58zMFCBTM63P6QSxLSy12E9h6JuhpL6R0ekmkE
 qrGuxdtK3LJRWiJxULRvW/LV+VmBiDdm/wZDYYOpYVMXDWbTaRIj4drv9Gdjo/u7VWUe9nymlSo
 POj747npb34IKJLEhbTaOGioUXIZuNducLWVgwzJVgOYJp31YF7VqQECbIPv8hTw3+w/qOzsg3B
 sgcV3gv5D+ZBJ1MaNK5Way5FQODonrqpBFyBuzogOYf04AC0vVyp8GkzTD2oMODIJJFv0Xdk2eC
 qg==
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39b262aaeb7mr43808977a91.18.1788850826758; 
 Tue, 08 Sep 2026 00:00:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39b262aaeb7mr43808845a91.18.1788850826118; Tue, 08 Sep 2026
 00:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260907211233.501672-1-rtvernam@gmail.com>
In-Reply-To: <20260907211233.501672-1-rtvernam@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Sep 2026 11:00:12 +0400
X-Gm-Features: AcwNN1WLCFZMARCm8JV5JvpkY-3USrjbWZ5w558k_IdQr8MWC3-pOYZDI9q60e4
Message-ID: <CAMxuvazF+pGAwJvLzR_VGnACh4JgupB49Mn_xBGwmEfG-5Ji2g@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: forward guest clipboard grabs that lack a serial
To: Rick Vernam <rtvernam@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

On Tue, Sep 8, 2026 at 1:13=E2=80=AFAM Rick Vernam <rtvernam@gmail.com> wro=
te:
>
> dbus_clipboard_update_info() drops any incoming grab whose
> QemuClipboardInfo has no serial number:
>
>     if (self_update || !info->has_serial) {
>         return;
>     }
>
> For grabs coming from ui/vdagent.c, has_serial is only set when the
> guest's vdagent client has negotiated VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL
> (see vdagent_clipboard_recv_grab()). When the guest doesn't negotiate
> it, the grab is silently dropped here and never forwarded to the
> D-Bus display client via Clipboard.Grab.
>
> It seems other protocols (ui/gtk-clipboard.c, ui/vnc-clipboard.c) do not
> incorporate a validation on has_serial, so this patch matches their
> behavior.

But dbus display relies on "serial" being valid. The client has no way
to check !info->serial. Iow, the agent must support
VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL. When not supported, the clipboard
state get out of sync due to races.

>
> Signed-off-by: Rick Vernam <rtvernam@gmail.com>
> ---
>  ui/dbus-clipboard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
> index 90318384ee..1389ec0edc 100644
> --- a/ui/dbus-clipboard.c
> +++ b/ui/dbus-clipboard.c
> @@ -72,7 +72,7 @@ dbus_clipboard_update_info(DBusDisplay *dpy, QemuClipbo=
ardInfo *info)
>          return;
>      }
>
> -    if (self_update || !info->has_serial) {
> +    if (self_update) {
>          return;
>      }
>
> --
> 2.55.0
>


