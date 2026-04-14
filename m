Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED49F9D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiHF-0004iN-Ud; Tue, 14 Apr 2026 14:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCiHE-0004i6-FU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:14:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCiHC-0004Bj-CZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:14:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48374014a77so80684415e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776190456; x=1776795256; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2XjsNaPoJtS64SxncMSvw3rGRLDneNyL4kffeQY2cwo=;
 b=PIiIDEc2sl30tXcEE9BEuohvwZbGWDEMxRrVg5DTwUV/NS4hB6pBz0l9gawBDQ6l4f
 7b2+l03hW0Raa+YLISgrv067WFHhJXOBUdNIUCT9NZIizpncDKKMz3mh7AT3qOSDsqvn
 rOgWicViGkCmCCX9pYeHYMeR26wQzH6wi8dx/+f+9WbOoR0tqPTkCoPqF2rbvUff1SmU
 4u2YHt6D1dMKJ23fI9M7J9U+58i4gICsuqPMsSgxcqii6egwiwFWY+pix+QmJrM/qUEW
 er7EBNlUDscMV8aT1gPyvWhlyuPQG7P5wgGiaW+cJjLqxYZ4sBa0iETL/Zk0gO0jvvOM
 gHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776190456; x=1776795256;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2XjsNaPoJtS64SxncMSvw3rGRLDneNyL4kffeQY2cwo=;
 b=L3TRCmjTbOaLMfTYn9RbS4opVeN992LxcOLnDfzpTHFevsx+5ck3atlHEGRBvRK6wS
 XgUXO0DBMz+bALyEzmKplj9wZOIvJRSlWii/vkogcZN4RL3lznOkf7oAy9XGEUoNvzAC
 UH578PMHVfRMJHpKy7i9IEdv4AJGe6KhUxaVdgej2D1/LQVax1gWGdEm7BqdwNpgdXRM
 p5oL2Vh1j8JJng+hU/jtIEZ8hXlktfs1twWzzPRRxso045up1PUEsvk6eDJ+4D+whcG/
 o+2Y5EKE9okoFzAe98lj1VQayJfspx64mcHbVazBpYPOHgRbZPBGv5FL6poqGgFLDwa2
 limA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I4yKMmlL5LFyGQEx+jqPMy2Mp8yRkaVjQSaszHpkXVXJrKoJFWXkAYq//fIPBE9BJ2kndV0wW4+oQ@nongnu.org
X-Gm-Message-State: AOJu0YwjBJvKeTN1amIbNvqJTso/40YYIr52962l8ZQwglr5Grd/6OM2
 7L+enk21hZzqRZqVk5RTbrS2Mvivhs2imsqHikiGgun4uPEDMuQyaUuvziajTh35q6U=
X-Gm-Gg: AeBDieukeBpK17SROpLCdGxjimB5/8AGZvvx8rcTfMa6/6GeqlpP8BDoRIBp85Q+X6d
 BIbvlsPQjkL+5K37jKMa9ByEgnDUywhWv6zRXBejv5i7hd/cz70oPGQLewWWW2J9krtWljXDPQH
 1oK2yNaXfh0KawMwy0g6tGYkVvBWAiEIUIG2Mkp/ZnP1S81eUH3pZSwEYsibGhTweZPG6Us2fRZ
 4mJRx8VbeK2nIwj+ZGeNUq4+yE7SKrllpV4mSZDoUjqEo7YW6Mah7TJuRGiUeAfgwgHNnwz7eZJ
 ThENiTK9/Ok3PdxaCHO7D/ziBC+cZXxAbIQ3PsAsfn0B1EaY7yWrF5h3xCKPBmqG6PX9iZoMbQD
 MKgjuRAy1MMJH5BGcnTEZsKvkV/Bak7lAmWfRGVfnGUuQH8ii60jhD5Am0bhc0qLTtLZKGhpnET
 C2akhLRMt+BcUw/PE97aV1QtBmrzEM+yP6O46jqfLfItNYOFc71rAZEkiW6HM2GuIS4MroQBr4d
 TIZOmv3kS6kW7qxVyP6nLoly5L84NHCYu+NmiRRwyq3Xw/rMwHic0JmefyGDQgNjINYXhtX3un/
 V8rp0A==
X-Received: by 2002:a05:600d:d:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-488d67df531mr204358875e9.3.1776190456056; 
 Tue, 14 Apr 2026 11:14:16 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb0014114800f0800935eeb308ec.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:f080:935:eeb3:8ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede14d15sm67159725e9.3.2026.04.14.11.14.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 11:14:15 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <C8F5F496-2401-45AC-82D3-EE0E3E1F2B21@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_ACBD4317-7E88-48F7-B22E-4650C572ACF3"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Tue, 14 Apr 2026 20:14:16 +0200
In-Reply-To: <20260414181030.GB136064@fedora>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mr-083 <matthieu@min.io>,
 John Meneghini <jmeneghi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
To: kbusch@kernel.org
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
 <20260414181030.GB136064@fedora>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32d.google.com
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


--Apple-Mail=_ACBD4317-7E88-48F7-B22E-4650C572ACF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello Keith,=20

To clarify,  we're not swapping to a different backend. It's the same =
disk file being disconnected and reconnected, simulating a physical =
drive being pulled and reinserted.

The sequence is:
drive_del -> disconnect the backing (simulates drive pull)

User does whatever they need (test failure handling, etc.)

drive_insert -> reconnect the same backing file (simulates drive =
reinsertion)
SDN -> reset controller so guest resumes I/O

The filesystem on disk is unchanged, same data, same UUID, same format. =
The guest's in-memory state realigns with the on-disk state after the =
controller reset, just like it would after a physical drive reinsertion =
on real hardware.

The use case is a storage integration lab where we need to simulate disk =
failures and recoveries without the guest block device being renamed, =
which is what happens with device_del + device_add due to the kernel's =
ida_alloc behavior.

Thank you


	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 14, 2026, at 8:10=E2=80=AFPM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>=20
> On Tue, Apr 14, 2026 at 03:36:19PM +0200, Matthieu Rolla wrote:
>> Regarding `drive_insert`,  I found that `device_del` + `device_add` =
works well when no filesystem is mounted on the namespace.=20
>>=20
>> However, when XFS is mounted (e.g. via DirectPV/CSI), the Linux =
kernel doesn't reuse the block device number (nvme0n1 becomes nvme0n2) =
because the stale mount holds a reference to the old `nvme_ns_head`, =
preventing `ida_free()`.
>=20
> Can you use the stable device names in /dev/disk/by-*/ instead of the
> /dev/nvmeCnN names to access the new namespace? Then it won't matter
> that ida_free() hasn't been called yet.
>=20
>> This causes XFS "duplicate UUID" errors on remount.
>=20
> (I have to admit that using stable device names doesn't solve this
> because the guest kernel still potentially has multiple XFS mounts for
> the file system.)
>=20
>> `drive_insert` avoids this by keeping the namespace device alive =
which means no ida cycle, same block device name.
>=20
> Are you sure this is safe? Even if PCIe AER somehow kills the old XFS
> mount, then there is still a race condition between drive_insert and
> PCIe AER injection when the guest kernel sees the new underlying =
storage
> through the old XFS mount.
>=20
> Getting this wrong could cause data corruption, so it needs to be well
> understood. I don't really understand and would need to look at the
> guest kernel code path. Can you describe what happens to the guest
> kernel blkdev and the XFS mount in the drive_insert workflow?
>=20
> Thanks,
> Stefan


--Apple-Mail=_ACBD4317-7E88-48F7-B22E-4650C572ACF3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Hello =
Keith,&nbsp;<div><br></div><div><div>To clarify, &nbsp;we're not =
swapping to a different backend. It's the same disk file being =
disconnected and reconnected, simulating a physical drive being pulled =
and reinserted.</div><div><br></div><div>The sequence =
is:</div><div>drive_del -&gt; disconnect the backing (simulates drive =
pull)</div><div><br></div><div>User does whatever they need (test =
failure handling, etc.)</div><div><br></div><div>drive_insert -&gt; =
reconnect the same backing file (simulates drive =
reinsertion)</div><div>SDN -&gt; reset controller so guest resumes =
I/O</div><div><br></div><div>The filesystem on disk is unchanged, same =
data, same UUID, same format. The guest's in-memory state realigns with =
the on-disk state after the controller reset, just like it would after a =
physical drive reinsertion on real =
hardware.</div><div><br></div><div>The use case is a storage integration =
lab where we need to simulate disk failures and recoveries without the =
guest block device being renamed, which is what happens with device_del =
+ device_add due to the kernel's ida_alloc =
behavior.</div><div><br></div><div>Thank you</div><div>
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
<div><br><blockquote type=3D"cite"><div>On Apr 14, 2026, at 8:10=E2=80=AFP=
M, Stefan Hajnoczi &lt;stefanha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Tue, Apr 14, 2026 at =
03:36:19PM +0200, Matthieu Rolla wrote:<br><blockquote =
type=3D"cite">Regarding `drive_insert`, &nbsp;I found that `device_del` =
+ `device_add` works well when no filesystem is mounted on the =
namespace. <br><br>However, when XFS is mounted (e.g. via DirectPV/CSI), =
the Linux kernel doesn't reuse the block device number (nvme0n1 becomes =
nvme0n2) because the stale mount holds a reference to the old =
`nvme_ns_head`, preventing `ida_free()`. <br></blockquote><br>Can you =
use the stable device names in /dev/disk/by-*/ instead of =
the<br>/dev/nvmeCnN names to access the new namespace? Then it won't =
matter<br>that ida_free() hasn't been called yet.<br><br><blockquote =
type=3D"cite">This causes XFS "duplicate UUID" errors on =
remount.<br></blockquote><br>(I have to admit that using stable device =
names doesn't solve this<br>because the guest kernel still potentially =
has multiple XFS mounts for<br>the file system.)<br><br><blockquote =
type=3D"cite">`drive_insert` avoids this by keeping the namespace device =
alive which means no ida cycle, same block device name. =
<br></blockquote><br>Are you sure this is safe? Even if PCIe AER somehow =
kills the old XFS<br>mount, then there is still a race condition between =
drive_insert and<br>PCIe AER injection when the guest kernel sees the =
new underlying storage<br>through the old XFS mount.<br><br>Getting this =
wrong could cause data corruption, so it needs to be well<br>understood. =
I don't really understand and would need to look at the<br>guest kernel =
code path. Can you describe what happens to the guest<br>kernel blkdev =
and the XFS mount in the drive_insert =
workflow?<br><br>Thanks,<br>Stefan<br></div></div></blockquote></div><br><=
/div></body></html>=

--Apple-Mail=_ACBD4317-7E88-48F7-B22E-4650C572ACF3--

