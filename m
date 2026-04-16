Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F56BF8DFCD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUlz-00011W-Dv; Thu, 16 Apr 2026 18:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDUlf-00010Y-Un
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:01:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wDUld-0003ln-Mk
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:00:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48374014a77so263815e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776376854; x=1776981654; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXI04NMFSSTWOtM3ULIgE7tuoWA2OYu7gaVH4mAExpQ=;
 b=KAQkMciVl9owYhf5LZmPZmAW7M4b7PFXUGCwiZruG1wJCMxtUtYPlr37DaczROMeUV
 Bcp510mBkn8Gn3D+7daRdEapFdOHarnPZSAxFcmE+FdAGO9Ig54QvjgpZnSGPUFjIaxS
 Qs86VHwuaXIjl0zEX7qY7fg3lOZmr6iR9FOScXbA/E1bPVFe+0yJDBOc3Xm/bOq1rWRB
 sP60ZFa/9YLJxf9JktpQ8Dj8JUB6JuLOBnLTAYnpUfm4Y7opTIpopZ9beeDBscXWNzKj
 uPf3f7n8qX4GyIhGkfTtHQvIxrtNh/N4AFItNMCwwbnGofzVMKuEmwIiRcxXGSculvBF
 ckaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776376854; x=1776981654;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXI04NMFSSTWOtM3ULIgE7tuoWA2OYu7gaVH4mAExpQ=;
 b=aHx1ARrIw5fqE7YzkgPZpaaOLUAqK4cHlw9D5aW07Rjmaa3KdjgOTKSwYtMayn+iA3
 yQeX80m2CmFyX+QW03qGGAkx1/9PK/KCnxZsPtRqZWbpRt0293gypDqEl8QoD6bTSVc/
 RdG95alctY1WU3WaunCo1JFLfDJrx7rudYLuHXkvQzZhFeb9k2jKv7vRnCha6WX+J4SR
 CJgP0GQa0LexH9X15GNcTfeOS1zScnQ8wQKNbRCUkAtVEqpXXzzSH1XqKDPXyUKjwGYM
 VaJU7jMHjPTfJQOwRJ3FdfskyBSiGZN/rJ6Po/Y72jbHWOzH8ElX+ZKU9Y84BpT2qt3+
 zlvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9981UV5ENjxq8bk4rOJ/Uh1g+wwNf9W1YEGU8kI5QXv2aY7ScrJLUw4nUojm3lJlrgWzEaYmPN8GKp@nongnu.org
X-Gm-Message-State: AOJu0YzirwltbQyyX7RG3kpdfY27pwVejNnekw1YKhPIGaf856TrQ0+Y
 PRe/RFzSgr9CbPalsyqMa/BrWeMmR391fETbmhA5fbIq6vxxK5LDtXumZYESDfw5HTM=
X-Gm-Gg: AeBDievOkJDCgBU0KcD3slrD1j0yp46CVDXDqKlkxPE1VE9ky+RSKXDRhG98YvbBSsh
 b7q2xAvkF55PcBCqeBmCopuCHAlbakq8zWtCT5Zp9a2pok3I8oXB01QF8C14JOfINbRafbq8g3C
 MOvDSMWbmafkype57aO5dWjVWKcz5HNWsN7NAkes3cURiambmk3FuJcGgQKqbqOPRZhdZ7AP1u+
 ouYKFvdDzvo2GGvshm2iLxm8jAcszUV7VsdNC6Vp9XwJrMdQfkUfBDdsEaml7FyPtJzuuOQxOVD
 gIvIuIODc5oZJmg5DrNXyY8e/u3XlwT8kFDkH7GidmHnDhEuswAKz2KKJ4yTLYYNy0hPHu/vJ6/
 xnXvCav6hk7RE3uzQsLRBtthdk1sMv+0DZrmCEqbO2+Fu92qohwkC6rVUgM8FDT+8SPl32MXspL
 ZMJJci14dFI/WKEQ8es16hzwOV3V1w3mXdZ+sX12pgimMn8fX1aKkGvl88N6h+iBnbb4o/KmV0U
 ZyiCgeTIfHhGVkeUVa8a/5/0miSSX0XiJMvb4f93hRGUu3BdtEDddj8+aYphFo5sevhx6PHCthp
 MPlFyYDG5dkCCoYXHFE=
X-Received: by 2002:a05:600c:8909:b0:488:e6cf:671a with SMTP id
 5b1f17b1804b1-488fb789f3fmr3006885e9.25.1776376854287; 
 Thu, 16 Apr 2026 15:00:54 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb001411480028ecb5ca8086bc4b.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:28ec:b5ca:8086:bc4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75a279sm2041025e9.10.2026.04.16.15.00.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:00:53 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <644BFF29-7432-4F01-866E-7CA099EEEEFD@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_18338BC0-A49C-402C-B3DC-04A1C89A09C8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Date: Fri, 17 Apr 2026 00:00:54 +0200
In-Reply-To: <20260416195208.GB258343@fedora>
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, mr-083 <matthieu@min.io>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io> <ad9s9CRT0niUAPQn@redhat.com>
 <7E17AD80-CF52-44FC-A0FE-29B481EF5B40@minio.io>
 <20260416195208.GB258343@fedora>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32a.google.com
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


--Apple-Mail=_18338BC0-A49C-402C-B3DC-04A1C89A09C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks Stefan.

I tested SDN alone on 6 disks across 3 nodes,  controllers freeze, =
auto-recover via AER in ~200ms, and resume I/O. This works well for =
simulating transient PCIe errors and as you noted, it should be generic =
across device types.

However, SDN alone can't simulate a prolonged disk outage,  the =
controller recovers immediately. The test scenarios need to cover:

- Transient disk failure: brief I/O disruption, automatic recovery (SDN =
alone works here)
- Prolonged disk failure: disk offline for minutes/hours, filesystem =
corruption, manual recovery required
- Disk replacement: failed disk swapped for a new one, storage stack =
heals data

For the last two scenarios, we need the disk to actually stay =
disconnected. This requires drive_del to disconnect the backing store, =
and blockdev-attach to reconnect it later, preserving the guest device =
name since drive_del has no existing counterpart for non-removable =
devices.

So the two series address different scenarios:
- Series 1 (namespace hotplug): namespace topology changes via =
device_del/device_add with AEN
- Series 2 (blockdev-attach): prolonged disk disconnect/reconnect while =
preserving the guest device name

Please let me know if you have any questions


	.=09
Matthieu
www.min.io <>
matthieu@min.io <>=20

> On Apr 16, 2026, at 9:52=E2=80=AFPM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>=20
> On Wed, Apr 15, 2026 at 02:32:39PM +0200, Matthieu Rolla wrote:
>> Thanks Daniel,=20
>>=20
>> It makes sense Thanks.=20
>>=20
>> Looking at the existing code, blockdev-insert-medium already does the =
backend/frontend association via blk_insert_bs(), but is restricted to =
removable devices.=20
>> A new QMP command like blockdev-attach could reuse the same logic =
without the removable restriction, paired with blockdev-add for creating =
the block node.
>>=20
>> Would that be a better approach ?
>=20
> Hi Matthieu,
> I was wondering whether the blockdev needs to be changed at all. Since
> the disk image remains the same, is it sufficient to inject the PCIe =
SDN
> and then recover the NVMe PCI controller?
>=20
> I don't understand the test scenario well enough, but it seems like
> you're testing at the PCIe level here rather than nothin NVMe- or
> blockdev-specific. Therefore blockdev commands may not be necessary.
>=20
> If the testing can be done completely at the PCIe level then that =
would
> also allow other device types to be tested in the same way, which =
would
> be nice.
>=20
> Stefan


--Apple-Mail=_18338BC0-A49C-402C-B3DC-04A1C89A09C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div><div>Thanks =
Stefan.</div><div><br></div><div>I tested SDN alone on 6 disks across 3 =
nodes, &nbsp;controllers freeze, auto-recover via AER in ~200ms, and =
resume I/O. This works well for simulating transient PCIe errors and as =
you noted, it should be generic across device =
types.</div><div><br></div><div>However, SDN alone can't simulate a =
prolonged disk outage, &nbsp;the controller recovers immediately. The =
test scenarios need to cover:</div><div><br></div><div>- Transient disk =
failure: brief I/O disruption, automatic recovery (SDN alone works =
here)</div><div>- Prolonged disk failure: disk offline for =
minutes/hours, filesystem corruption, manual recovery =
required</div><div>- Disk replacement: failed disk swapped for a new =
one, storage stack heals data</div><div><br></div><div>For the last two =
scenarios, we need the disk to actually stay disconnected. This requires =
drive_del to disconnect the backing store, and blockdev-attach to =
reconnect it later, preserving the guest device name since drive_del has =
no existing counterpart for non-removable =
devices.</div><div><br></div><div>So the two series address different =
scenarios:</div><div>- Series 1 (namespace hotplug): namespace topology =
changes via device_del/device_add with AEN</div><div>- Series 2 =
(blockdev-attach): prolonged disk disconnect/reconnect while preserving =
the guest device name</div></div><div><br></div><div>Please let me know =
if you have any questions</div><div>
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
<div><br><blockquote type=3D"cite"><div>On Apr 16, 2026, at 9:52=E2=80=AFP=
M, Stefan Hajnoczi &lt;stefanha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Wed, Apr 15, 2026 at =
02:32:39PM +0200, Matthieu Rolla wrote:<br><blockquote =
type=3D"cite">Thanks Daniel, <br><br>It makes sense Thanks. =
<br><br>Looking at the existing code, blockdev-insert-medium already =
does the backend/frontend association via blk_insert_bs(), but is =
restricted to removable devices. <br>A new QMP command like =
blockdev-attach could reuse the same logic without the removable =
restriction, paired with blockdev-add for creating the block =
node.<br><br>Would that be a better approach ? <br></blockquote><br>Hi =
Matthieu,<br>I was wondering whether the blockdev needs to be changed at =
all. Since<br>the disk image remains the same, is it sufficient to =
inject the PCIe SDN<br>and then recover the NVMe PCI =
controller?<br><br>I don't understand the test scenario well enough, but =
it seems like<br>you're testing at the PCIe level here rather than =
nothin NVMe- or<br>blockdev-specific. Therefore blockdev commands may =
not be necessary.<br><br>If the testing can be done completely at the =
PCIe level then that would<br>also allow other device types to be tested =
in the same way, which would<br>be =
nice.<br><br>Stefan<br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_18338BC0-A49C-402C-B3DC-04A1C89A09C8--

