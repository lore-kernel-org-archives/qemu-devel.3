Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C2F9D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 19:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCj5O-0004CQ-9B; Tue, 14 Apr 2026 15:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCj5K-0004CA-5C
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:06:06 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wCj5H-0002Fs-Jn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:06:05 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so2241493a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 12:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776193562; cv=none;
 d=google.com; s=arc-20240605;
 b=AFmC1GKujdjRl6IGw4kEzyR7bzJvByQ6GuDQzpgSV3VdL77XFrL0aEhD54hxmeHbqG
 qmNCNN/RHHl+HdJN/OVqyx0d0WBQuO88gIiNDFejEsOAqmC2xAk6sD30snC0GfHwJCXO
 jst0RjQUiUnTE3RonPeeaR8x6jKuznFAn4aMPvaU+vd3CVpLdpLJlpw5nqWSpdlzmg6Z
 g/KWq1Lks5qnzUbsFkdavWCjKv305dhwvrf9JLyCn7Hr8aw7GKob49EaV6+k7Sl3nX+g
 l6ghcBrxyCZBE3Iz+626Ct2oT0Z0PU0HlXevgZjYvh1uE/uAZN1kV6Jap6JdqEaZGvzk
 wibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6/qko1vr7R3DxbWV2D9HRdxI7MCEa6o9N/ckFyJVKBE=;
 fh=UNGpKgCfOypvNTHClK/7fo7nWsSpr9W9Ly/mUH/DYhg=;
 b=IVLolqaf02wTdFv81iH135sdV0Xkb9UMNUP0llwwTCDQ5lYz7T7IComM5PeN5PiO/x
 I/moyw3/Y411GvKdX4S6XN7qIPW+SUGbQKwHfSE9FrufjjtTpMU8seAD0ayh0w585ggE
 8+jfNetwHuMIhal32i4Z1kLht9tUQLSZj9ZdgP01V5QJc5H96D7Tp4AFYfL3utGttVqN
 TLpEmMTJX+1SxIQaNf+/djPVObS9d/mQrdhUcJJAKNhl8J/+T1F0Njims38ofVgQu4If
 TjTL32pTSdSv/ChPpNZJXOuQiSR1iyS4t3EeM+B+qjV0klP+r+I2ZFTClD2YO2AUSXq5
 aOgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776193562; x=1776798362;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/qko1vr7R3DxbWV2D9HRdxI7MCEa6o9N/ckFyJVKBE=;
 b=d7l8HOkZKGxt2Ix/EidMOkYFqqziryO+OP9cWnb3n++6UpU6+NcIT5if/hMn917rzI
 aLQU2H33cRuw8tGHuMeTdFDhvet6E2jTskCTqfGkhngn7X786d5cDoY8wy3AN+WMr65X
 +yhuoAjhaT0bpzb3qEXX8iK97bzWdyfSM1x9n593FhKBeIKrmY5bX8qM/fQpe2vhUYJY
 1Oh1+dY+H8Y2cKiptT3Q9tvlDJRqIQrvQxBJ2FfsEj2t4Gl3FYVdW8cfYiWR4prZedDO
 pciH0h/4sqTJIuobFznYs7MQ5XC8yZSNJZy0hXMHnkDkRzG/JezcjbcTpmfJQuKZajr0
 D/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776193562; x=1776798362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/qko1vr7R3DxbWV2D9HRdxI7MCEa6o9N/ckFyJVKBE=;
 b=g9vmLBmoauadk9iqQmfInvweErzYmMIcKfcMl/cTeHnOuf97fCaOqDcd3WbMsZIlzz
 Tenf2KohKnLojCP0lqQ4qVyXllT0VHfr4i/gdTv90JLRF60tkB8KfjT8RAsmPUU5HN9c
 ywIdUP6ukQsqD5GnYxD8LYR8nbVhEkf/Yqy70C9nwsVwPGpbV9OaFWRqhAKHiDtfOdo1
 fzDeanK8cR1S5qJKmWAYyv1BztlCL8KP9gauo5c5j3l7KCUTOeXj53dGdUiCGACEYjrG
 OvkTsegyjGt8JMIyJtTGMH+RbKp7MfjJv1YOq02V/xmx0wGfCGDjW9H3L0aFzGfqpxIt
 JHhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uxI+COwSnh1jLna1qkVWWMmD8QbiX/d7SMlQhQUHQRLhtLfIVl9D60O4dOJK9JspWptJdJ3EyO/t3@nongnu.org
X-Gm-Message-State: AOJu0Yx48hdq4KOlD/jEX+MZE9FUFhh4mHZyOPkTyfLlU+GDqZuNH+qt
 6OHXV2j+LmF4jJent0jr8q/iICrMJV84aWt5Pud5JANNDq+lv5iOw6iANC6Z5n/z3XVeakAdZh2
 dtWSFP1YQUvfu4yOK8THD2yNyNOVl/b/XSEx7WxM7XQ==
X-Gm-Gg: AeBDiev2UXBEHA2ObSxPd+ahzKNSpqi3YS7P8FC89tCHpMPDPz4x6gLJ6a+3Cth582u
 rVZx6hMyXuxsUm8Q7bgmCc4zHgZ1drcux5QR7yTJdDACmMh/Zpis1zrYZAjI83psLOvfCZiSK6i
 Ya+sM/sdJVnpU7iSU/LSbVTELhTS1xY50EoHlh9psgqd0ipvAcsZPVUc1U4r5ke7y8nReArv7b1
 qka9CTBeCBwM9kN5cENO8bGKZCu/YgE9p1sKx4V+0kIfWs9UXoJuN59yyoEeg5N5oCK1hX22mVu
 hk69AtjazazHd2uGQg==
X-Received: by 2002:a17:902:aa09:b0:2aa:d5e5:b136 with SMTP id
 d9443c01a7336-2b2d5a6de64mr136179375ad.38.1776193561577; Tue, 14 Apr 2026
 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
 <20260414175710.GA136064@fedora>
 <5AEBB39E-A111-4678-9F28-9816D996C514@minio.io>
In-Reply-To: <5AEBB39E-A111-4678-9F28-9816D996C514@minio.io>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 14 Apr 2026 13:05:50 -0600
X-Gm-Features: AQROBzDHfb0ZU5AVvAqwivH-NinhU8X3xFnNoZ-SWbei8WlOLKqB7fz1esdekCQ
Message-ID: <CANCZdfr8tAKftSnO=T_=PcfaSK_oomrtMv0LpY_PXt7ftYnNbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
To: Matthieu Rolla <matthieu@minio.io>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, mr-083 <matthieu@min.io>,
 kwolf@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004a5b59064f704a18"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004a5b59064f704a18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:02=E2=80=AFPM Matthieu Rolla <matthieu@minio.io>=
 wrote:

> Hello Stefan,
>
> 1. Correct, no AEN involved.The namespace stays attached to the controlle=
r
> throughout. Only the BlockBackend's root node changes, so from the NVMe
> protocol perspective nothing happened to the namespace topology.
>
> 2. Yes, the new storage is accessible immediately after drive_insert at
> the QEMU block layer level. The SDN is needed to reset the NVMe controlle=
r
> which may have cached an error state from I/O failures during the period
> when no backing was present. Without the reset, the guest driver continue=
s
> to see the controller as faulted. The SDN triggers the standard PCIe AER
> recovery path (freeze =E2=86=92 slot reset =E2=86=92 restart) which clear=
s the error state
> and resumes normal I/O.
>
> One thing to note: since the namespace device stays alive, the guest
> kernel's block device number is preserved (e.g. /dev/nvme0n1 stays
> nvme0n1). This avoids the ida_alloc renaming issue that occurs with
> device_del + device_add when filesystems hold references to the old
> namespace head.
>

OK. I had hoped this would let me test my FreeBSD namespace arrival and
departure messages correctly. I just added the code for AWS (and other VM)
support for attaching / detaching drives and was hoping I could turn this
into a regression test, but sounds like no.

I'll have to go look at what the Linux driver does here. Right now Surprise
Down events just increment a counter on FreeBSD...  Will thta work for a
DPC system too? Or is that not relevant for the current state of the qemu
art?

Warner


>
> Thanks
>
>
> .
> *Matthieu*
> www.min.io
> matthieu@min.io
>
> On Apr 14, 2026, at 7:57=E2=80=AFPM, Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
>
> Add a drive_insert HMP command that reconnects a host block device file
> to an existing guest device whose backing store was previously removed
> with drive_del.
>
> After drive_del, the BlockBackend remains attached to the guest device
> but has no BlockDriverState (shown as "[not inserted]" in info block).
> drive_insert opens the specified file, finds the device's BlockBackend
> by iterating all backends and matching the attached device ID, then
> calls blk_insert_bs() to reconnect the backing store.
>
> This complements drive_del for non-removable devices (such as NVMe
> namespaces) where blockdev-change-medium cannot be used. Combined with
> PCIe AER Surprise Down error injection to trigger a controller reset,
> this enables complete NVMe disk hot-swap simulation where the guest
> sees the same device names throughout.
>
> Example usage:
>  drive_del drv0             # remove backing store
>  drive_insert ns0 disk.qcow2  # reconnect backing
>  pcie_aer_inject_error rp0 SDN  # trigger controller reset
>
>
> This approach does not delete the `--device nvme-ns` but instead
> replaces the BlockBackend's root node so that the existing NVMe
> Namespace changes the underlying storage.
>
> Questions about this approach:
> 1. NVMe AEN is not involved at all?
> 2. Does the guest have access to the new storage as soon as drive_insert
>   completes and the PCIe AER is just to kick the guest driver (e.g.
>   getting it to update the size of the guest Linux block device)?
>
> Stefan
>
>
>

--0000000000004a5b59064f704a18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 14,=
 2026 at 12:02=E2=80=AFPM Matthieu Rolla &lt;<a href=3D"mailto:matthieu@min=
io.io">matthieu@minio.io</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div><span style=3D"color:rgb(34,34,34);font-family=
:Arial,Helvetica,sans-serif;font-size:small;font-variant-ligatures:normal;b=
ackground-color:rgb(255,255,255)">Hello Stefan,</span><br style=3D"color:rg=
b(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-var=
iant-ligatures:normal;background-color:rgb(255,255,255)"><br style=3D"color=
:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-=
variant-ligatures:normal;background-color:rgb(255,255,255)"><span style=3D"=
color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;=
font-variant-ligatures:normal;background-color:rgb(255,255,255)">1. Correct=
, no AEN involved.The namespace stays attached to the controller throughout=
. Only the BlockBackend&#39;s root node changes, so from the NVMe protocol =
perspective nothing happened to the namespace topology.</span><br style=3D"=
color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;=
font-variant-ligatures:normal;background-color:rgb(255,255,255)"><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-variant-ligatures:normal;background-color:rgb(255,255,255)"><span =
style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-si=
ze:small;font-variant-ligatures:normal;background-color:rgb(255,255,255)">2=
. Yes, the new storage is accessible immediately after drive_insert at the =
QEMU block layer level. The SDN is needed to reset the NVMe controller whic=
h may have cached an error state from I/O failures during the period when n=
o backing was present. Without the reset, the guest driver continues to see=
 the controller as faulted. The SDN triggers the standard PCIe AER recovery=
 path (freeze =E2=86=92 slot reset =E2=86=92 restart) which clears the erro=
r state and resumes normal I/O.</span><br style=3D"color:rgb(34,34,34);font=
-family:Arial,Helvetica,sans-serif;font-size:small;font-variant-ligatures:n=
ormal;background-color:rgb(255,255,255)"><br style=3D"color:rgb(34,34,34);f=
ont-family:Arial,Helvetica,sans-serif;font-size:small;font-variant-ligature=
s:normal;background-color:rgb(255,255,255)"><span style=3D"color:rgb(34,34,=
34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-variant-lig=
atures:normal;background-color:rgb(255,255,255)">One thing to note: since t=
he namespace device stays alive, the guest kernel&#39;s block device number=
 is preserved (e.g. /dev/nvme0n1 stays nvme0n1). This avoids the ida_alloc =
renaming issue that occurs with device_del + device_add when filesystems ho=
ld references to the old namespace head.</span></div></blockquote><div><br>=
</div><div>OK. I had hoped this would let me test my FreeBSD namespace arri=
val and departure messages correctly. I just added the code for AWS (and ot=
her VM) support for attaching / detaching drives and was hoping I could tur=
n this into a regression test, but sounds like no.</div><div><br></div><div=
>I&#39;ll have to go look at what the Linux driver does here. Right now Sur=
prise Down events just increment a counter on FreeBSD...=C2=A0 Will thta wo=
rk for a DPC system too? Or is that not relevant for the current state of t=
he qemu art?</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div><br style=3D"color:rgb(34,34=
,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-variant-li=
gatures:normal;background-color:rgb(255,255,255)"><span style=3D"color:rgb(=
34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-varia=
nt-ligatures:normal;background-color:rgb(255,255,255)">Thanks</span><br id=
=3D"m_759518745627216812lineBreakAtBeginningOfMessage"><div>
<br>
<br>
<table>
   <tbody>
       <tr>
           <td style=3D"padding:0px 50px 0px 0px"><img src=3D"https://cdn.b=
fldr.com/Q955TODV/at/f5h9pjj8f8t3ng5t6vxs2n/emailsignature-logo-standalone.=
png?auto=3Dwebp&amp;format=3Dpng" height=3D"34"></td>
           <td style=3D"width:1px;padding:0px;background-color:rgb(214,218,=
225);color:rgb(214,218,225);font-size:1px">.</td>
           <td style=3D"padding:0px 20px 0px 50px">
               <div>
                   <strong><span style=3D"font-family:Geist,Arial,Helvetica=
,sans-serif;font-size:1.1em;color:rgb(53,54,56)" color=3D"#353638">Matthieu=
</span></strong><br>
                   <div style=3D"height:6px"></div>
                   <a style=3D"font-family:Geist,Arial,Helvetica,sans-serif=
;font-size:1em;color:rgb(53,54,56);text-decoration:none;line-height:118%" c=
olor=3D"#353638">www.min.io</a><br>
                   <a style=3D"font-family:Geist,Arial,Helvetica,sans-serif=
;font-size:1em;color:rgb(53,54,56);text-decoration:none;line-height:118%" c=
olor=3D"#353638">matthieu@min.io</a>
               </div>
           </td>
       </tr>
   </tbody>
</table>

</div>
<div><br><blockquote type=3D"cite"><div>On Apr 14, 2026, at 7:57=E2=80=AFPM=
, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" target=3D"_bla=
nk">stefanha@redhat.com</a>&gt; wrote:</div><br><div><div>On Thu, Apr 09, 2=
026 at 08:01:54AM +0200, mr-083 wrote:<br><blockquote type=3D"cite">Add a d=
rive_insert HMP command that reconnects a host block device file<br>to an e=
xisting guest device whose backing store was previously removed<br>with dri=
ve_del.<br><br>After drive_del, the BlockBackend remains attached to the gu=
est device<br>but has no BlockDriverState (shown as &quot;[not inserted]&qu=
ot; in info block).<br>drive_insert opens the specified file, finds the dev=
ice&#39;s BlockBackend<br>by iterating all backends and matching the attach=
ed device ID, then<br>calls blk_insert_bs() to reconnect the backing store.=
<br><br>This complements drive_del for non-removable devices (such as NVMe<=
br>namespaces) where blockdev-change-medium cannot be used. Combined with<b=
r>PCIe AER Surprise Down error injection to trigger a controller reset,<br>=
this enables complete NVMe disk hot-swap simulation where the guest<br>sees=
 the same device names throughout.<br><br>Example usage:<br> =C2=A0drive_de=
l drv0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0# remove backing store<br> =C2=A0drive_insert ns0 disk.qcow2 =C2=A0# =
reconnect backing<br> =C2=A0pcie_aer_inject_error rp0 SDN =C2=A0# trigger c=
ontroller reset<br></blockquote><br>This approach does not delete the `--de=
vice nvme-ns` but instead<br>replaces the BlockBackend&#39;s root node so t=
hat the existing NVMe<br>Namespace changes the underlying storage.<br><br>Q=
uestions about this approach:<br>1. NVMe AEN is not involved at all?<br>2. =
Does the guest have access to the new storage as soon as drive_insert<br> =
=C2=A0=C2=A0completes and the PCIe AER is just to kick the guest driver (e.=
g.<br> =C2=A0=C2=A0getting it to update the size of the guest Linux block d=
evice)?<br><br>Stefan<br></div></div></blockquote></div><br></div></blockqu=
ote></div></div>

--0000000000004a5b59064f704a18--

