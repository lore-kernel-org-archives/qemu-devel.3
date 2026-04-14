Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C11DF9D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 21:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCktZ-0004Ie-18; Tue, 14 Apr 2026 17:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCktU-0004Ho-E7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:02:01 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCktP-0004qV-Ak
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:01:57 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7b23713eac9so31191187b3.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 14:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776200513; cv=none;
 d=google.com; s=arc-20240605;
 b=IySbJQBS/ip9FA5JinZZQM0PA/ptaOHZxd4qWJwA7jA3F7wCQXZDiX9z1/wHy/0e0O
 sN6e2GxHmjyWZZv/iQqqQWOTRlRh45AJ97KgGIAGmQyzrAXZ0IZceC743K/UIE03bw4+
 uxfQdK5MwaRDmjxdec2Hbxh3M6cd10vjJgzos7b8Ob/1GX7KNjVOKYWgh5G95HhF3ks0
 /8Z0qFju8P1wPwRP3h7Ubbz6TEXrzfsYkvQphvyzO27o6BffbaF8YTQ8T/BneLJsOZOT
 8Ja/pxMyGqAa8lNL/DjEp2COcppdF2onFvbqaCjxMKcNuDfEAFjofgw4d+cZlYvc8A0u
 7tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nrLEAsoFzCT4mGl2KRPskFhNJtF+K8l1gQqBaeTGvnE=;
 fh=dl3H0Uh/+JDLigo3gHW270F+79HcigvNv60tX4GQ3oc=;
 b=iq3dLqGm35YNnC21OY3OLAQE/8y5aqJX5KCXXpF0YcZ9G5W9ZNTZyb3QXWp9hXYP3z
 I28fSYyFp/6tNF1RKcC6JwPt1t2s5GRT/wM4r2T9wVGl1eJmK2BaYS4fC8KSdWpNMRKc
 o4KdX8vND+qVjnLUNgceTuC6FPy57Qaw4epzVg+yrcXNHyEsdz9GbXwOgs3fyU5alho4
 KFgjnTmWTWxWEma1jvp2n9RSDN78+nSWVRBdScxqt0rEBz9tLfwMVg+nYoeNsQjS2SOs
 PEuOwSioXQ6cofuVdM6rXGpG8OjZaS0l3qOoT3PQtJd4JpGSVAwlPhGq2TVoVSshzod9
 rc5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776200513; x=1776805313; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nrLEAsoFzCT4mGl2KRPskFhNJtF+K8l1gQqBaeTGvnE=;
 b=sH6CI52Zp36wl0oxUWwdee+XpTj+9LI+Y2R6ChPML9fPKS6DmzxE8W5msbpUVlQNao
 k8raF7xxjWrngk9BaNMZpOMs1To42SwROKNgH/gDiR5rI1lWPhxg5JKUJxHave+lb0Ll
 l4lk75uLbObtYUAtbPuSLcMhyhHkKLSJvtdllKzw6wJKbFmc0AOeWFkPMnlyTa2JVDV0
 CcGeLvkjF92adbX4Skef7L9shj9SIPedRHrL6Q11Yy3eF6ION617qaTG0n3d5aPjVyv1
 Hr35r1Y0NzsPgd09yhvRLxWLn3yzrKxwA5PTg3ZDjRP4uNEWW+hPnZuB+uJ4IF5L84x6
 TNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776200513; x=1776805313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrLEAsoFzCT4mGl2KRPskFhNJtF+K8l1gQqBaeTGvnE=;
 b=haE+s10aA8FMoJaQBnf7y1r6HUlt6hbMmLDJvEcyXZgjZzeouW0n74oKMuiVFR3kxS
 mtebsfneKJht00pFKjI776i0jsNnEO1nlwgHN5bVqGsXpWSy+BiO1iCQ85d57tQibrEU
 Pva/RF0aFXYU8rvqAvCyNlRiI8Xpld/IxQIpKP9nELmwm/+PpZm5Wv79slTIXrCR4PWO
 8zjXo/GX+VnIkupjn52NqL+uFoJpoEYVcBCLPbJFmrDVvsejhke0j5KSM9BTq9vXnljz
 V/Sh4deJjsmUEH3iOR/Wv9gsxyR+Dar2Noq6YzOgcjm20HYozIEbdlxQzXOzQW9MALlW
 xnog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ByPIiIaiWyr15vbTdCvVP0+pa4MP0kRCvudQusLfrg3Y41oxMjmdul/6ALg4yhtgePWNECNir+mxO@nongnu.org
X-Gm-Message-State: AOJu0YyHf7KgXGoNvuBNeb4BS8wW9uozF/121ech0CQQA9yIkGUnEWox
 eJKUrNpjq7GVgeJhUB/hhuCVGT491E2obwu6vqmk+kqeK4DaOXwr1upm1u6nH0VEUJ4IVfHw0xC
 geD+3GROcdZDFuPyU1YcAxx1gHGGLlsP/jtGLOddHpg==
X-Gm-Gg: AeBDietC7/1lnQBmuIMxwPqy7h08ghT1Y6KJKQweiNZo2zBV4SLgtAOwxTTgjQltuU9
 5Tx9u6df5eTz0UUGp8+qRnkOIOSndKrsL1t2BSbVe3gF7sU+Y1HcUWcp9X07hyyIIGih1Xga8M7
 8zZivZV4iQNKHYEHJ5w0Tod2g5iCmlxe9DYfo/cm4eEeKenN/kBYF5JAIJZtNLFO0vgAzCXy7H+
 jwFIiOXKUXvqbn2y7vKCRtdq1oV1VR5OFPQFpNoaHs7+x9urvSUoRHnXBhl+hi2pLdZxBoDiYYL
 yshg6BrcaW58t6yvR9RdVJyHSUVMpt0N5PKOBhjYWoUnzi9WsCuA8eAONl1qPizrAzOzKHQEvZH
 PPyK2TA==
X-Received: by 2002:a05:690c:e04e:b0:79a:b440:5c77 with SMTP id
 00721157ae682-7af6fa0205fmr169681247b3.17.1776200513449; Tue, 14 Apr 2026
 14:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
 <20260414175710.GA136064@fedora>
 <5AEBB39E-A111-4678-9F28-9816D996C514@minio.io>
 <CANCZdfr8tAKftSnO=T_=PcfaSK_oomrtMv0LpY_PXt7ftYnNbw@mail.gmail.com>
In-Reply-To: <CANCZdfr8tAKftSnO=T_=PcfaSK_oomrtMv0LpY_PXt7ftYnNbw@mail.gmail.com>
From: Matthieu Rolla <matthieu@minio.io>
Date: Tue, 14 Apr 2026 23:01:53 +0200
X-Gm-Features: AQROBzCadZDPrEf8x_SIDXyHBRR_j68pF0lduO3zU4Yajk5tWzaY5asHHMnSGO8
Message-ID: <CAPSO8MwzatW_gVdLsjpEbQEtPjoAOgpdNH-NbMKYCbVBemrTPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
To: Warner Losh <imp@bsdimp.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, mr-083 <matthieu@min.io>,
 kwolf@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a78104064f71e8b5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=matthieu@minio.io; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a78104064f71e8b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Warner,

For testing namespace arrival and departure, Patch 1 (nvme-ns hotplug with
AEN) is what you want. That properly executes device_del + device_add which
triggers a Namespace Attribute Changed AEN, the guest sees the namespace
disappear and reappear.

drive_insert is specifically for reconnecting a backing store after
drive_del without the guest seeing a namespace topology change. This is
useful for simulating disk removal and reinsertion, or replacing a disk,
while preserving the guest's block device name, as on a real system.
Different use cases, expected behavior.

Regarding FreeBSD and SDN, the SDN triggers PCIe AER recovery at the root
port level. If FreeBSD just increments a counter for Surprise Down events
without initiating a slot reset + controller restart, then the controller
won't recover.

Linux handles SDN by freezing the device, resetting the link, and
restarting the driver. FreeBSD would need similar handling for the
drive_insert + SDN flow to work. But again, for namespace arrival/departure
testing, you don't need SDN at all, you can use device_del/device_add and
the AEN from Patch 1.

On Tue, Apr 14, 2026 at 9:06=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Tue, Apr 14, 2026 at 12:02=E2=80=AFPM Matthieu Rolla <matthieu@minio.i=
o> wrote:
>
>> Hello Stefan,
>>
>> 1. Correct, no AEN involved.The namespace stays attached to the
>> controller throughout. Only the BlockBackend's root node changes, so fro=
m
>> the NVMe protocol perspective nothing happened to the namespace topology=
.
>>
>> 2. Yes, the new storage is accessible immediately after drive_insert at
>> the QEMU block layer level. The SDN is needed to reset the NVMe controll=
er
>> which may have cached an error state from I/O failures during the period
>> when no backing was present. Without the reset, the guest driver continu=
es
>> to see the controller as faulted. The SDN triggers the standard PCIe AER
>> recovery path (freeze =E2=86=92 slot reset =E2=86=92 restart) which clea=
rs the error state
>> and resumes normal I/O.
>>
>> One thing to note: since the namespace device stays alive, the guest
>> kernel's block device number is preserved (e.g. /dev/nvme0n1 stays
>> nvme0n1). This avoids the ida_alloc renaming issue that occurs with
>> device_del + device_add when filesystems hold references to the old
>> namespace head.
>>
>
> OK. I had hoped this would let me test my FreeBSD namespace arrival and
> departure messages correctly. I just added the code for AWS (and other VM=
)
> support for attaching / detaching drives and was hoping I could turn this
> into a regression test, but sounds like no.
>
> I'll have to go look at what the Linux driver does here. Right now
> Surprise Down events just increment a counter on FreeBSD...  Will thta wo=
rk
> for a DPC system too? Or is that not relevant for the current state of th=
e
> qemu art?
>
> Warner
>
>
>>
>> Thanks
>>
>>
>> .
>> *Matthieu*
>> www.min.io
>> matthieu@min.io
>>
>> On Apr 14, 2026, at 7:57=E2=80=AFPM, Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>>
>> On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
>>
>> Add a drive_insert HMP command that reconnects a host block device file
>> to an existing guest device whose backing store was previously removed
>> with drive_del.
>>
>> After drive_del, the BlockBackend remains attached to the guest device
>> but has no BlockDriverState (shown as "[not inserted]" in info block).
>> drive_insert opens the specified file, finds the device's BlockBackend
>> by iterating all backends and matching the attached device ID, then
>> calls blk_insert_bs() to reconnect the backing store.
>>
>> This complements drive_del for non-removable devices (such as NVMe
>> namespaces) where blockdev-change-medium cannot be used. Combined with
>> PCIe AER Surprise Down error injection to trigger a controller reset,
>> this enables complete NVMe disk hot-swap simulation where the guest
>> sees the same device names throughout.
>>
>> Example usage:
>>  drive_del drv0             # remove backing store
>>  drive_insert ns0 disk.qcow2  # reconnect backing
>>  pcie_aer_inject_error rp0 SDN  # trigger controller reset
>>
>>
>> This approach does not delete the `--device nvme-ns` but instead
>> replaces the BlockBackend's root node so that the existing NVMe
>> Namespace changes the underlying storage.
>>
>> Questions about this approach:
>> 1. NVMe AEN is not involved at all?
>> 2. Does the guest have access to the new storage as soon as drive_insert
>>   completes and the PCIe AER is just to kick the guest driver (e.g.
>>   getting it to update the size of the guest Linux block device)?
>>
>> Stefan
>>
>>
>>

--000000000000a78104064f71e8b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Warner,<br><br>For testing namespace arrival and dep=
arture, Patch 1 (nvme-ns hotplug with AEN) is what you want. That properly =
executes device_del + device_add which triggers a Namespace Attribute Chang=
ed AEN, the guest sees the namespace disappear and reappear.<br><br>drive_i=
nsert is specifically for reconnecting a backing store after drive_del with=
out the guest seeing a namespace topology change. This is useful for simula=
ting disk removal and reinsertion, or replacing a disk, while preserving th=
e guest&#39;s block device name, as on a real system. Different use cases, =
expected behavior.<br><br>Regarding FreeBSD and SDN, the SDN triggers PCIe =
AER recovery at the root port level. If FreeBSD just increments a counter f=
or Surprise Down events without initiating a slot reset + controller restar=
t, then the controller won&#39;t recover. <br><br>Linux handles SDN by free=
zing the device, resetting the link, and restarting the driver. FreeBSD wou=
ld need similar handling for the drive_insert + SDN flow to work. But again=
, for namespace arrival/departure testing, you don&#39;t need SDN at all, y=
ou can use device_del/device_add and the AEN from Patch 1.</div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Apr 14, 2026 at 9:06=E2=80=AFPM Warner Losh &lt;<a href=3D"mai=
lto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Apr 14, 2026 at 12:02=E2=80=AFPM Matthieu Rolla &lt;<a href=3D"mailto:=
matthieu@minio.io" target=3D"_blank">matthieu@minio.io</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div><span style=3D"c=
olor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;f=
ont-variant-ligatures:normal;background-color:rgb(255,255,255)">Hello Stefa=
n,</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-variant-ligatures:normal;background-color:rgb(25=
5,255,255)"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sa=
ns-serif;font-size:small;font-variant-ligatures:normal;background-color:rgb=
(255,255,255)"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helveti=
ca,sans-serif;font-size:small;font-variant-ligatures:normal;background-colo=
r:rgb(255,255,255)">1. Correct, no AEN involved.The namespace stays attache=
d to the controller throughout. Only the BlockBackend&#39;s root node chang=
es, so from the NVMe protocol perspective nothing happened to the namespace=
 topology.</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helveti=
ca,sans-serif;font-size:small;font-variant-ligatures:normal;background-colo=
r:rgb(255,255,255)"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helv=
etica,sans-serif;font-size:small;font-variant-ligatures:normal;background-c=
olor:rgb(255,255,255)"><span style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-variant-ligatures:normal;backgro=
und-color:rgb(255,255,255)">2. Yes, the new storage is accessible immediate=
ly after drive_insert at the QEMU block layer level. The SDN is needed to r=
eset the NVMe controller which may have cached an error state from I/O fail=
ures during the period when no backing was present. Without the reset, the =
guest driver continues to see the controller as faulted. The SDN triggers t=
he standard PCIe AER recovery path (freeze =E2=86=92 slot reset =E2=86=92 r=
estart) which clears the error state and resumes normal I/O.</span><br styl=
e=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:s=
mall;font-variant-ligatures:normal;background-color:rgb(255,255,255)"><br s=
tyle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-siz=
e:small;font-variant-ligatures:normal;background-color:rgb(255,255,255)"><s=
pan style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fon=
t-size:small;font-variant-ligatures:normal;background-color:rgb(255,255,255=
)">One thing to note: since the namespace device stays alive, the guest ker=
nel&#39;s block device number is preserved (e.g. /dev/nvme0n1 stays nvme0n1=
). This avoids the ida_alloc renaming issue that occurs with device_del + d=
evice_add when filesystems hold references to the old namespace head.</span=
></div></blockquote><div><br></div><div>OK. I had hoped this would let me t=
est my FreeBSD namespace arrival and departure messages correctly. I just a=
dded the code for AWS (and other VM) support for attaching / detaching driv=
es and was hoping I could turn this into a regression test, but sounds like=
 no.</div><div><br></div><div>I&#39;ll have to go look at what the Linux dr=
iver does here. Right now Surprise Down events just increment a counter on =
FreeBSD...=C2=A0 Will thta work for a DPC system too? Or is that not releva=
nt for the current state of the qemu art?</div><div><br></div><div>Warner</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-variant-ligatures:normal;background-color:rgb(255,255,25=
5)"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-ser=
if;font-size:small;font-variant-ligatures:normal;background-color:rgb(255,2=
55,255)">Thanks</span><br id=3D"m_5282747878019367271m_759518745627216812li=
neBreakAtBeginningOfMessage"><div>
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
</blockquote></div>

--000000000000a78104064f71e8b5--

