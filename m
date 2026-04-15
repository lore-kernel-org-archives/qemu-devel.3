Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E744F419B9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD4Cy-0000HI-Q5; Wed, 15 Apr 2026 13:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4Cw-0000G4-AQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:39:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4Cu-0002uM-B4
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:39:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso43390295e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776274758; x=1776879558; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4oScoIx2BqLcj3tzztPnjsvXOCIkBnEain/aaImOuac=;
 b=WdsrzZntNqScg28wm2ZOfqzKn84/B60eiFj4j+sxd2uTxEP2QKdyjS15GWTt0u/vZb
 kjdlC/2/Fm2+3bYRLdXrJY0JDvOU9661V1d0XSxaI+hAU4ROS8Zi283eEey9JAIKOE3x
 58JyxpmfRvESEL9GwqesX5B0k1tKMI80dwe6Uv52slym2JEEonSp8ZDC5IxDwhhaKOIv
 Tinm7Hf/e9Tql5GgQrF3QmzUR44ITMwOVXU1U6LXqFv3Dy6vQ78Ntomr7jaIBiy15PZS
 w2RjFY6PrlxJTD96jv4RV1PS3wwC4vYOiHKhsD4z6eZsiwtEDUTRP/LeAb4BF2/RfoPv
 ReCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776274758; x=1776879558;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4oScoIx2BqLcj3tzztPnjsvXOCIkBnEain/aaImOuac=;
 b=YoR5WVXftepE0gh89QQ1OieFfffdeSuKh7JfewiI5qNGHP5lYhNmLWiL5WZzu6qmlX
 MeXdJ47e/2oldwfA2volZGAlDA0OjYp58Hfg8/wGvMLaIHxlojK+ftHX881hZ3ejd80A
 l7ojWVvbu+PMxmDhVLHYPrwBprs+GsqviZMdxOrhRas8fZT4MHhoAIR6EsCVlvK8F4FV
 GSEQrWIUsZ4xs0hVxIEebMkshw9MBkm9pvK2PkvHXbV3WT0zfCbgKsTHm45CcfZ/bCve
 nUOh3cQLcNUQjdwN7bNhL9jCi70KPgHlMWTFqEgxGADWN4t/sFIBrbF6KWjESexie+iO
 xJlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LBWu5SCjJBoVrW4715sj8Yo4of2fyX5bswU4wQky8QZsc6rF1AHg8Mb8e18uETHPE5I4vN7J1Ks7X@nongnu.org
X-Gm-Message-State: AOJu0Yz+U+CQIHRZXoKxMvUZvYE53CbYHvgIqaYcU3ioxlV5xpUTyjIk
 hCERozIKRBjapVcABNZ96YlGPdJMWStj4LwoxsXvyCFW6307fJMETLXmaXl6URYlxaY=
X-Gm-Gg: AeBDievycBRE/HXCu1Qi5s4RVgaPj086DEEXQYHKrdED6z3uA/XpkY3qsL8tyaguZc9
 xkSwCYEt8y9D5RVz282rBDyp6het90JOVTX0ew+9EBa+oHtludVhdXX+ZL0llDExZIz8CS6vT6/
 pYR0Ys/7d7kpumy73KExzqVYBgkprdSmp/FkWw8bwwCDR+ulZfF2mQaaoGmQEPK3iQbqll4dVHy
 YK8VwEQTpjfFWMxgnR1jv7qiK5nWv6wDHXFCgBeyymzrb9tGKtBCrXopgT+ih5cVw3Jl9xv+kr+
 lOhU/upi42uaitdhQyE3QkgIkYLHlRCJraWlseWF4i8ayiI4X13VGuMLKIp+kc79nNBbjNse7dh
 tNjGFHe7jtgUwCdtvdDWXmd6zDToLrsByBbmf0EI8SqYz88aPrzIG3cV7zKgxcEBH836TvVVyA/
 b+2GmmU3Alr2/R2H/uEbrVM5V+wA9/OUb7ywAiA2EojNzBAil5yIFgZDeXSdOfDqod0Wa59u72B
 7iNftZ9a2yUaJcJBKiZXkzE/yswhCZCTbMVx7LmNFyE4i5uP8nCN+svo2eMWwaJ8ehq+Srqb5nM
 234m37k=
X-Received: by 2002:a05:600c:3f16:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-488d6894bf6mr334658165e9.20.1776274757854; 
 Wed, 15 Apr 2026 10:39:17 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb001411480010f92e9cd3b40a22.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:10f9:2e9c:d3b4:a22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1de4a2csm68563045e9.4.2026.04.15.10.39.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Apr 2026 10:39:17 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <069BD540-A4EF-4BDF-8A05-6670A9EE0C05@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1A8B0AFD-6584-45ED-97B4-88B18168C048"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Wed, 15 Apr 2026 19:39:18 +0200
In-Reply-To: <20260415124542.GB163810@fedora>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mr-083 <matthieu@min.io>,
 John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
To: mr-083 <matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
 <20260414181030.GB136064@fedora>
 <C8F5F496-2401-45AC-82D3-EE0E3E1F2B21@minio.io>
 <20260415124542.GB163810@fedora>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x330.google.com
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


--Apple-Mail=_1A8B0AFD-6584-45ED-97B4-88B18168C048
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

Thanks everyone for the reviews.
I just sent v4 of the namespace hotplug patch (Series 1) with the I/O =
drain fix and nvme_ns_unrealize symmetry as discussed.
As suggested by Stefan, the backend reassociation is sent as a separate =
series (Series 2).=20

Per Daniel's feedback, it is implemented as a QMP command =
(blockdev-attach) that pairs with the existing blockdev-add, with an HMP =
wrapper. This allows reconnecting a block node to a non-removable =
device's backend after drive_del, without the removable media =
restriction of blockdev-insert-medium.

Both patches tested with Linux 6.1 guest under DirectPV/MinIO AIStor =
storage stack. Scenarios covered:
Namespace attach/detach via device_del + device_add (Series 1)
Backend disconnect/reconnect via drive_del + blockdev-add + =
blockdev-attach + PCIe AER SDN (Series 2)
Same device name preserved across detach/attach cycles
Detach under heavy I/O (warp benchmark, 16 concurrent uploads)
Short disconnect (<3s): XFS mounts intact, DirectPV Ready, MinIO 12/12
Long disconnect (60s+): XFS journal shutdown, recovery via kubectl =
directpv repair, full 12/12 recovery (minio trigger healing on disk)
Multiple disks across multiple nodes (6 disks, 3 nodes)



	.=09
Matthieu

matthieu@min.io <>=20

> On Apr 15, 2026, at 2:45=E2=80=AFPM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>=20
> On Tue, Apr 14, 2026 at 08:14:16PM +0200, Matthieu Rolla wrote:
>> To clarify,  we're not swapping to a different backend. It's the same =
disk file being disconnected and reconnected, simulating a physical =
drive being pulled and reinserted.
>=20
> Is it necessary to drive_del to simulate PCIe Surprise Down? Can you
> perform just the PCIe actions without removing the drive from the NVMe
> device? That way the drive_insert command is not necessary.
>=20
> Stefan


--Apple-Mail=_1A8B0AFD-6584-45ED-97B4-88B18168C048
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><p style=3D"white-space: pre-wrap; =
margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, 64); =
font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, =
sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">Hello,</p><p style=3D"white-space: pre-wrap; margin-top: 0.1em; =
margin-bottom: 0.2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;"><br></p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;">Thanks everyone for the reviews.</p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;">I just sent v4 of the namespace hotplug =
patch (Series 1) with the I/O drain fix and nvme_ns_unrealize symmetry =
as discussed.</p><p style=3D"white-space: pre-wrap; margin-top: 0.1em; =
margin-bottom: 0.2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;">As suggested by =
Stefan, the backend reassociation is sent as a separate series (Series =
2).&nbsp;</p><p style=3D"white-space: pre-wrap; margin-top: 0.1em; =
margin-bottom: 0.2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;"><br></p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;">Per Daniel's feedback, it is =
implemented as a QMP command (blockdev-attach) that pairs with the =
existing blockdev-add, with an HMP wrapper. This allows reconnecting a =
block node to a non-removable device's backend after drive_del, without =
the removable media restriction of blockdev-insert-medium.</p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;"><br></p><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">Both patches tested with Linux 6.1 guest under DirectPV/MinIO =
AIStor storage stack. Scenarios covered:</p><ul =
style=3D"padding-inline-start: 2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;"><li>Namespace =
attach/detach via device_del + device_add (Series 1)</li><li>Backend =
disconnect/reconnect via drive_del + blockdev-add + blockdev-attach + =
PCIe AER SDN (Series 2)</li><li>Same device name preserved across =
detach/attach cycles</li><li>Detach under heavy I/O (warp benchmark, 16 =
concurrent uploads)</li><li>Short disconnect (&lt;3s): XFS mounts =
intact, DirectPV Ready, MinIO 12/12</li><li>Long disconnect (60s+): XFS =
journal shutdown, recovery via kubectl directpv repair, full 12/12 =
recovery (minio trigger healing on disk)</li><li>Multiple disks across =
multiple nodes (6 disks, 3 nodes)</li></ul><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;"><br></p><div>
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
                   <div style=3D"height: 6px;"><br></div>
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
<div><br><blockquote type=3D"cite"><div>On Apr 15, 2026, at 2:45=E2=80=AFP=
M, Stefan Hajnoczi &lt;stefanha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Tue, Apr 14, 2026 at =
08:14:16PM +0200, Matthieu Rolla wrote:<br><blockquote type=3D"cite">To =
clarify, &nbsp;we're not swapping to a different backend. It's the same =
disk file being disconnected and reconnected, simulating a physical =
drive being pulled and reinserted.<br></blockquote><br>Is it necessary =
to drive_del to simulate PCIe Surprise Down? Can you<br>perform just the =
PCIe actions without removing the drive from the NVMe<br>device? That =
way the drive_insert command is not =
necessary.<br><br>Stefan<br></div></div></blockquote></div><br></body></ht=
ml>=

--Apple-Mail=_1A8B0AFD-6584-45ED-97B4-88B18168C048--

