Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B726CF9D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCi5W-0001bu-AD; Tue, 14 Apr 2026 14:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCi5R-0001ZT-Gl
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:02:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCi5N-0000j1-Qv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:02:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso60924035e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776189721; x=1776794521; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJSw28qT4lIaIJCKrCAWX4T+WrGgCglbDv0E1IFC+QM=;
 b=Z5zpwXNf4OkwWLGB815Bb4wKN57SjwJXSzBqJmlCoLiRYtvjswp3/I5N8ZdKCdZNuv
 ss9YELbGyt9gSHJfFQoKyfbzI21Tn5bbqQdUMlDqLKUWZGo24Kr4XjQFMui6xUQugQz2
 XaA4Y9uXqoYhEppQpB6uhS5pEODIhHYk5apr6mCOf/+HibqrF7ObfIbWOiZ6K4nhNB42
 QHDko9vkm+eju4fWXzVr70s0pv1lfVGAFdy7WeR7JRhOQYUu+S0yW/CPng06A7AtYac2
 a1t0t/v/nsckkbX5mSIVIIblbSKhJsurPEpdB202HR8Tu+nPB09SSv1e4ZZ9BHUKoc5N
 kalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776189721; x=1776794521;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZJSw28qT4lIaIJCKrCAWX4T+WrGgCglbDv0E1IFC+QM=;
 b=LELsmv4ZfxYsHQEBjJy1/VwqotyJHr1y/eh/Yc1ZC5tS00BSmQrmXUW4Ro3otzVoWW
 Do6aWD27S0EpdH+kBA2ActtkESYVjHJWijsK16CR7cmwawv3rq0Ebt5Bnh7BBUygWLqK
 JA4Iym0j2m76uCZe3bYVCYxulCKcZsUzIeNBoYwaUHMMXgNgWNngSXBN52gln5gPtp6K
 Q/CY382Lq7gLDrYAv++ZPUJn77G+mYufWwFHLCuP4z2/LCbDfCn8j4V7bAGiU6p7tHzB
 RB8WaotTTXiP891cHb/kvrr4v2IIyZCvO2IgO+wT0u0qgC87268Ewr9J7UCj5RAO/tDA
 0mMQ==
X-Gm-Message-State: AOJu0Yxfr6POb6VlgxxChpR1bPeRNmEpGwChWdxNOnwhQzf56cPz47To
 EU7frdSl5bN+e0MyoNmvuzHKjDZNT6LFC7N5Ha7mtwSLT97r4/oSD5uX4CJmJ/f4krc=
X-Gm-Gg: AeBDietc7kZLoaCnZFwwMNT7xDzGqRvtzTz0jpCvvmwFys7w1wDIbl4jLQLr3GZfwVM
 nEzWGLvrufTvk+Jk5mDcjosAtKAfv5dPqp+ULPcduKlHSgZldqqTYO7BIjH2FQ6Tp+8TAbnCyLB
 85FsNwHlkg1z1VhQ8tTB/cL9Otw7m83VhqjqER1dS1sXTlgZ6LEBg7POf6PozM0j2czSMY4dR9C
 66C0L9sRAcE6MyEs2uRMu6Wh2A6vZa8ijdxzwceBx6MMe2GrJMDCeDrhPHUZm6GHHOmLlgmieJO
 9wkV/C7gfuOsv6oAmOv6BqQSp7JXq/BPqmQcmHZTqWbEOwZ540DKE5BUA+bjmrc26eCa+sN+Kfz
 7cFvBhtk9sWmIvK40SJtIBNTzLehPXG/qKXJizbLpYQ+i2c/fVzX6wenoD5sTpZh0qXYz2ZO70Q
 SwZ7xFQfGxkrMD1cHoOVB34b71lNT69rg/xju9kWlPNb2INjzaOCdQGW/BeliL1StwjfUuDb2M3
 gg3nCQloTmHJqgGFj+mpO2/2K4ZCLe5evj1glv3qkCG/4gG/SuELyy4H/IHg0hjEs7cbxHY1Ou9
 WluQwIw=
X-Received: by 2002:a05:600d:8496:10b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488db8d16aamr133354225e9.10.1776189720985; 
 Tue, 14 Apr 2026 11:02:00 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb0014114800d473b7d8f9900c70.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:d473:b7d8:f990:c70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee038752sm67139645e9.9.2026.04.14.11.01.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 11:01:59 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <5AEBB39E-A111-4678-9F28-9816D996C514@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_446220A6-E2D4-43DE-A789-AB2A929A7E5E"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Date: Tue, 14 Apr 2026 20:02:00 +0200
In-Reply-To: <20260414175710.GA136064@fedora>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>, kwolf@redhat.com
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io> <20260414175710.GA136064@fedora>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_446220A6-E2D4-43DE-A789-AB2A929A7E5E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Stefan,

1. Correct, no AEN involved.The namespace stays attached to the =
controller throughout. Only the BlockBackend's root node changes, so =
from the NVMe protocol perspective nothing happened to the namespace =
topology.

2. Yes, the new storage is accessible immediately after drive_insert at =
the QEMU block layer level. The SDN is needed to reset the NVMe =
controller which may have cached an error state from I/O failures during =
the period when no backing was present. Without the reset, the guest =
driver continues to see the controller as faulted. The SDN triggers the =
standard PCIe AER recovery path (freeze =E2=86=92 slot reset =E2=86=92 =
restart) which clears the error state and resumes normal I/O.

One thing to note: since the namespace device stays alive, the guest =
kernel's block device number is preserved (e.g. /dev/nvme0n1 stays =
nvme0n1). This avoids the ida_alloc renaming issue that occurs with =
device_del + device_add when filesystems hold references to the old =
namespace head.

Thanks


	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 14, 2026, at 7:57=E2=80=AFPM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>=20
> On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
>> Add a drive_insert HMP command that reconnects a host block device =
file
>> to an existing guest device whose backing store was previously =
removed
>> with drive_del.
>>=20
>> After drive_del, the BlockBackend remains attached to the guest =
device
>> but has no BlockDriverState (shown as "[not inserted]" in info =
block).
>> drive_insert opens the specified file, finds the device's =
BlockBackend
>> by iterating all backends and matching the attached device ID, then
>> calls blk_insert_bs() to reconnect the backing store.
>>=20
>> This complements drive_del for non-removable devices (such as NVMe
>> namespaces) where blockdev-change-medium cannot be used. Combined =
with
>> PCIe AER Surprise Down error injection to trigger a controller reset,
>> this enables complete NVMe disk hot-swap simulation where the guest
>> sees the same device names throughout.
>>=20
>> Example usage:
>>  drive_del drv0             # remove backing store
>>  drive_insert ns0 disk.qcow2  # reconnect backing
>>  pcie_aer_inject_error rp0 SDN  # trigger controller reset
>=20
> This approach does not delete the `--device nvme-ns` but instead
> replaces the BlockBackend's root node so that the existing NVMe
> Namespace changes the underlying storage.
>=20
> Questions about this approach:
> 1. NVMe AEN is not involved at all?
> 2. Does the guest have access to the new storage as soon as =
drive_insert
>   completes and the PCIe AER is just to kick the guest driver (e.g.
>   getting it to update the size of the guest Linux block device)?
>=20
> Stefan


--Apple-Mail=_446220A6-E2D4-43DE-A789-AB2A929A7E5E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><span style=3D"color: rgb(34, 34, 34); =
font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);">Hello Stefan,</span><br style=3D"color: rgb(34, 34, 34); =
font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);"><br style=3D"color: rgb(34, 34, 34); font-family: Arial, =
Helvetica, sans-serif; font-size: small; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255);"><span style=3D"color: rgb(34, 34, =
34); font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);">1. Correct, no AEN involved.The namespace stays attached to the =
controller throughout. Only the BlockBackend's root node changes, so =
from the NVMe protocol perspective nothing happened to the namespace =
topology.</span><br style=3D"color: rgb(34, 34, 34); font-family: Arial, =
Helvetica, sans-serif; font-size: small; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255);"><br style=3D"color: rgb(34, 34, =
34); font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);"><span style=3D"color: rgb(34, 34, 34); font-family: Arial, =
Helvetica, sans-serif; font-size: small; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255);">2. Yes, the new storage is =
accessible immediately after drive_insert at the QEMU block layer level. =
The SDN is needed to reset the NVMe controller which may have cached an =
error state from I/O failures during the period when no backing was =
present. Without the reset, the guest driver continues to see the =
controller as faulted. The SDN triggers the standard PCIe AER recovery =
path (freeze =E2=86=92 slot reset =E2=86=92 restart) which clears the =
error state and resumes normal I/O.</span><br style=3D"color: rgb(34, =
34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);"><br style=3D"color: rgb(34, 34, 34); font-family: Arial, =
Helvetica, sans-serif; font-size: small; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255);"><span style=3D"color: rgb(34, 34, =
34); font-family: Arial, Helvetica, sans-serif; font-size: small; =
font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);">One thing to note: since the namespace device stays alive, the =
guest kernel's block device number is preserved (e.g. /dev/nvme0n1 stays =
nvme0n1). This avoids the ida_alloc renaming issue that occurs with =
device_del + device_add when filesystems hold references to the old =
namespace head.</span><br style=3D"color: rgb(34, 34, 34); font-family: =
Arial, Helvetica, sans-serif; font-size: small; font-variant-ligatures: =
normal; background-color: rgb(255, 255, 255);"><br style=3D"color: =
rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: =
small; font-variant-ligatures: normal; background-color: rgb(255, 255, =
255);"><span style=3D"color: rgb(34, 34, 34); font-family: Arial, =
Helvetica, sans-serif; font-size: small; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255);">Thanks</span><br =
id=3D"lineBreakAtBeginningOfMessage"><div>
<br>
<br>
<table>
   <tbody>
       <tr>
           <td style=3D"padding: 0 50px 0 0;"><img =
src=3D"https://cdn.bfldr.com/Q955TODV/at/f5h9pjj8f8t3ng5t6vxs2n/emailsigna=
ture-logo-standalone.png?auto=3Dwebp&amp;format=3Dpng" height=3D"34"></td>=

           <td style=3D"width: 1px; padding: 0; background-color: =
#D6DAE1; color: #D6DAE1; font-size: 1px;">.</td>
           <td style=3D"padding:0 20px 0 50px;">
               <div style=3D"margin-top: -6px; margin-bottom: -4px;">
                   <strong><span =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: =
1.1em; color: #353638;" color=3D"#353638">Matthieu</span></strong><br>
                   <div style=3D"height: 6px;"></div>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">www.min.io</a><br>
                   <a =
style=3D"font-family:'Geist',Arial,Helvetica,sans-serif; font-size: 1em; =
color: #353638; text-decoration: none; line-height: 118%;" =
color=3D"#353638">matthieu@min.io</a>
               </div>
           </td>
       </tr>
   </tbody>
</table>

</div>
<div><br><blockquote type=3D"cite"><div>On Apr 14, 2026, at 7:57=E2=80=AFP=
M, Stefan Hajnoczi &lt;stefanha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Thu, Apr 09, 2026 at =
08:01:54AM +0200, mr-083 wrote:<br><blockquote type=3D"cite">Add a =
drive_insert HMP command that reconnects a host block device file<br>to =
an existing guest device whose backing store was previously =
removed<br>with drive_del.<br><br>After drive_del, the BlockBackend =
remains attached to the guest device<br>but has no BlockDriverState =
(shown as "[not inserted]" in info block).<br>drive_insert opens the =
specified file, finds the device's BlockBackend<br>by iterating all =
backends and matching the attached device ID, then<br>calls =
blk_insert_bs() to reconnect the backing store.<br><br>This complements =
drive_del for non-removable devices (such as NVMe<br>namespaces) where =
blockdev-change-medium cannot be used. Combined with<br>PCIe AER =
Surprise Down error injection to trigger a controller reset,<br>this =
enables complete NVMe disk hot-swap simulation where the guest<br>sees =
the same device names throughout.<br><br>Example usage:<br> =
&nbsp;drive_del drv0 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# =
remove backing store<br> &nbsp;drive_insert ns0 disk.qcow2 &nbsp;# =
reconnect backing<br> &nbsp;pcie_aer_inject_error rp0 SDN &nbsp;# =
trigger controller reset<br></blockquote><br>This approach does not =
delete the `--device nvme-ns` but instead<br>replaces the BlockBackend's =
root node so that the existing NVMe<br>Namespace changes the underlying =
storage.<br><br>Questions about this approach:<br>1. NVMe AEN is not =
involved at all?<br>2. Does the guest have access to the new storage as =
soon as drive_insert<br> &nbsp;&nbsp;completes and the PCIe AER is just =
to kick the guest driver (e.g.<br> &nbsp;&nbsp;getting it to update the =
size of the guest Linux block =
device)?<br><br>Stefan<br></div></div></blockquote></div><br></body></html=
>=

--Apple-Mail=_446220A6-E2D4-43DE-A789-AB2A929A7E5E--

