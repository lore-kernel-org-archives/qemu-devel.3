Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8A1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8DL9-0004CZ-Ve; Fri, 25 Apr 2025 03:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1u8DL6-0004C3-QN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:19:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1u8DL4-00019W-GS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:19:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2295d78b433so21718735ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745565546; x=1746170346; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NbPAaoW/Cdc+NDUTtd53X+CxyNcqf/Uh9x4ru2HfWR0=;
 b=d4iRE9NKUxU/KHRVatqrMYOZqr/ULzPTmK6DO6SHmhTDEoDRzWjseAaNF+dvSW1hRu
 vKMHIGmRZxfT28t+UPCfOGC5ddAx+/tOw3g0xSpB/623d12oGUqfUj0tVrGSum8/RnLS
 k5y3HK5Kv8zkjaZtxn1WXQ9tpyeqCmgHbEH45tuF8iU/l1SKcpGP6FtoXXWkZQVVd4c5
 6/GLjwZq1Nh65GhG/RmX8R5CY4jjk56DbahB+RMNw/Qf2xl1fAi0O5dHKohA7cW78xwq
 O4hXfx4PHXddfXjrMNDyhaSJFckJpvAtBCQrilPyYf5kUggmSPLy3+Q2qyOIKDIpLAPF
 lqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745565546; x=1746170346;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NbPAaoW/Cdc+NDUTtd53X+CxyNcqf/Uh9x4ru2HfWR0=;
 b=glQ1e1FOVaemWchZ3xJzxuKejluTq8o1Sq60Y6n6d9Id+e4opEZxudlYOD6XUw2YKd
 K3jjefIFAoQiGNjE+o1ou+vmVvEYskkH9LU46SiE2tS3GMOEvyBEqEgeqi3pyCRaZZT/
 T4bG4h/ezl0g/8h53hAt99RVWVh0gw3oLbDfYwdIzCdrQgmWeb6saoE8SjKp3gUMuOhD
 b2tltnHV08CBNvBe3WZVQtkrzhx5NjJZi1fSAF20taOMfI1gwtqIsw6QCQgmtJ8fmcVu
 LbseBiTn9oc3/3OV0L4hd8rTZWEUWd4q1jX6pMVdhzyX5uN5zB91Vi3uuQz9veVRtBC7
 KRGA==
X-Gm-Message-State: AOJu0YzBd9XGaFmU6IrAkqhdk0fJdXPf3IJoejAMw/bpjoYSaLKkbIvp
 ZafXAaR17G26p7snk6sBQnts1zElbM+arSR/EvWwnqQvSns8lcRrjOqhAxrpri8=
X-Gm-Gg: ASbGncvj6q2QlSGMWkfCve6Ep7xdRQ9NBrpegAtLGbyaTQepWMjWygBv0vIHlZ6IE5C
 anS//xCh6eY409fBQtML63hgfdu44SxrQzCnCM0kS0BBCfCy36c1d8AH0wkMZAgdy685v5vUEY2
 Kv+ShAKPuhz7ljgaG0cWBTTSaUe0Zp/+qN9WWgUZwXsfar4Ug2FqTitilAqB7nLFBNWBXeK/ybt
 x821VmQLaq/mCvzPHfiXmrOE0eowHK7Cig8tXRdie1QyyVq7ULc9TRgGdngezESV7oZhGduDWPN
 cZQyU7rhIDKvGCDcf9404l9s+aG5zxeN3QJw+8EgTkBIyjT4UOq4
X-Google-Smtp-Source: AGHT+IHQdQJE9xt6LTthb+YjwOz/2LTe44wNl958yBjY1VbkvoL/SC+H5xMi896lhCrPA76Rhps83Q==
X-Received: by 2002:a17:902:f612:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-22dbf4d1a9dmr20928675ad.5.1745565545848; 
 Fri, 25 Apr 2025 00:19:05 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5102868sm25553825ad.164.2025.04.25.00.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 00:19:05 -0700 (PDT)
Message-ID: <f9c6c0bdd7a3c0aada506a62b381ba1203e41971.camel@gmail.com>
Subject: Re: [PATCH] ui/gtk: Properly apply x/y scale when rendering GL area
From: liuweife <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>, Alexander Orzechowski
 <orzechowski.alexander@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Date: Fri, 25 Apr 2025 15:19:01 +0800
In-Reply-To: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
References: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x62c.google.com
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

Sorry, just realized that I forgot to cc Marc-Andr=C3=A9 :D.

Here is a description of the issue this patch is trying to solve:

--------------------------
How to reproduce the issue
--------------------------
Launch the guest with gtk backed virtual display using command like

IMAGE_FOLDER=3D$HOME/workspace/images/fedora
DISK_PATH=3D$IMAGE_FOLDER/rootfs.qcow2
UEFI_CODE_PATH=3D$IMAGE_FOLDER/OVMF_CODE.fd
UEFI_DATA_PATH=3D$IMAGE_FOLDER/OVMF_VARS.fd
ISO_PATH=3D$IMAGE_FOLDER/Fedora-Workstation-Live-42-1.1.x86_64.iso
MEM=3D4G
$QEMU \
    -enable-kvm                                                    \
    -M q35                                                         \
    -object memory-backend-memfd,id=3Dmem1,size=3D$MEM                 \
    -machine memory-backend=3Dmem1                                   \
    -smp 4                                                         \
    -cpu host                                                      \
    -boot order=3Dc,menu=3Don,splash-time=3D3                            \
    -cdrom $ISO_PATH                                               \
    -drive if=3Dpflash,format=3Draw,readonly=3Don,file=3D$UEFI_CODE_PATH   =
\
    -drive if=3Dpflash,format=3Draw,file=3D$UEFI_DATA_PATH               \
    -hda $DISK_PATH                                                \
    -display gtk,gl=3Don,show-cursor=3Don                              \
    -device virtio-vga-gl,venus=3Dfalse,blob=3Dtrue,hostmem=3D$MEM       \
    -usb -device usb-tablet

When guest GUI is ready, click the guest display and we are likely to
find that the cursor coordinates are incorrectly reported to the guest
with an offset.

------------------
Cause of the issue
------------------
There is a mapping from the gtk glarea widget coordinates to the guest
display coordinates, and the scale factor plays an essential role in
the calculation. However, the scale factor defaults to 1 and is not
updated to reflect the fact on startup, rendering incorrect cursor
coordinates.

Best regards,
Weifeng

On Sat, 2025-04-19 at 17:48 +0800, Weifeng Liu wrote:
> On startup, scale_x and scale_y were set to 1 that didn't reflect the
> real situation of the scan-out, resulting in incorrect cursor
> coordinates to be sent when moving the mouse pointer. Simply updating
> the scales before rendering the image fixes this issue.
>=20
> Cc: hikalium <hikalium@hikalium.com>
> Cc: Alexander Orzechowski <orzechowski.alexander@gmail.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> ---
> =C2=A0ui/gtk-gl-area.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2c9a0db425..01235f876a 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -42,6 +42,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
> =C2=A0#ifdef CONFIG_GBM
> =C2=A0=C2=A0=C2=A0=C2=A0 QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> =C2=A0#endif
> +=C2=A0=C2=A0=C2=A0 int fbw, fbh;
> =C2=A0=C2=A0=C2=A0=C2=A0 int ww, wh, ws, y1, y2;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!vc->gfx.gls) {
> @@ -53,6 +54,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
> =C2=A0=C2=A0=C2=A0=C2=A0 ww =3D gtk_widget_get_allocated_width(vc->gfx.dr=
awing_area) * ws;
> =C2=A0=C2=A0=C2=A0=C2=A0 wh =3D gtk_widget_get_allocated_height(vc->gfx.d=
rawing_area) * ws;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 fbw =3D surface_width(vc->gfx.ds);
> +=C2=A0=C2=A0=C2=A0 fbh =3D surface_height(vc->gfx.ds);
> +=C2=A0=C2=A0=C2=A0 vc->gfx.scale_x =3D (double)ww / fbw / ws;
> +=C2=A0=C2=A0=C2=A0 vc->gfx.scale_y =3D (double)wh / fbh / ws;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (vc->gfx.scanout_mode) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vc->gfx.guest_fb.fr=
amebuffer) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return;

