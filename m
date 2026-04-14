Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994F5F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdwJ-0007U6-4j; Tue, 14 Apr 2026 09:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCdwH-0007Td-RC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:36:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCdwF-0006Ha-8v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:36:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so39070035e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776173781; x=1776778581; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v9YXMZlN1JDF3HcSlUVMZeVnrkvK6GhZ2/SaIcOtM4g=;
 b=iw7cMVbwSv9+pjFqk3/Cmmg8s3e9ej0yKBkts32gSMRWumwF6hJkcgR0NqGopifxTg
 xUmTaG4mEgJab06qgWQ7SL4+Oxz220RKHdJCPk18TLLRQTDBzZC4R3NXroDXWDqoug/p
 C6wEc6sIx1jcTY7YYxD30FvockkAKQ7KE8CchAW3iHUBn67hQDpOPHq/kNo/2E3vUVP9
 RUfLWWJTDp6VTGm8/x6LX7YbCLp0ajtc1TVScniLYJihMVkNE9Q0jKZMRBfAsdM4SW5r
 wYxFfo6tV/Q141tx/9ArVN0XApa5vGD9YJE7v+RSIiCD0Y9kBh3CdLWGFqjleOAOTBn/
 5nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173781; x=1776778581;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9YXMZlN1JDF3HcSlUVMZeVnrkvK6GhZ2/SaIcOtM4g=;
 b=eF/nNafUt5IpJ7FGyXC6mztkDqH/yX9QxJLDT1r9HYZgpMKuN7L+QtbUDYHPHDl6Oy
 W7m2xfXIwqKPzbzizbY2wiNritD7qm59pnBGOG2x2heXGwmzAM9/pT+GX9Puy3Tw0hWn
 LViSsuit+9y0mZ8dJ543U8S98oKLn5Xnlvk5b1m/dVjjVWOdS4DYYKhFFPFCURCE3WGr
 Vr9UV99h7WG286mpM9RRrXQkUC2l3MMfLXLuorxi7NH1Fwv5jnoe9zqYEegj7HlExi9u
 rkAxDjZMXqvhbbPeHmDhac+GRvDXCmJsj3Vkdc0IHOyea6ifcn0AczaCPhlQqLrB393z
 rFRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7roUjm/ByWslwTOowGGeFRVNcpzoNwPuXguzW4GRYqwwkF2tIkuOVuNi+eJltNfKJ/x16M24xrMz5@nongnu.org
X-Gm-Message-State: AOJu0Yy7i2gKkr53eK+1ie6+uF1ph8J3r82Fa64IzRg9+5lwKHbXoPVP
 IRerB5kOXwiBiUIQYl1aZHFyXVJrJugUenHhTVw9ZdOINKqSJU+ZS1KuSbqL2/9WIFE=
X-Gm-Gg: AeBDietcUC+z6GVJNaFfrBuqrO5eah93tn9I9osrCSUqTkLJXzLxXK4WbrXdmkjErYb
 x/KBWUBdOIyzfwfPOirSQ9z5pp5tIVDT0f73GNKXVI4BY9ZAHYOMj9/uyJnJUm3wwQqE3NpVcPS
 3SofKW/59pRtSQHV4v7CkVfNBsg+2TJ1191wgPXTxUOzgQlUh3dpgem0IGUoQGRh3+FEuaMzHQs
 oLWJdXBjqYpJhxNe/2i6hmFQWEFGYRSlprkdVaTpiY85LoNJVjy6KOImqc4qHi3K6oBZd78aVlm
 Fiajf9KtevtuC7jtHtkyZzR+GLgu/PtRu1bJTzmK5uwpF9FONRxbLBARYwY/bHHkqQ5+TuVg6Eb
 KGeTMP+cvYJ4Er/TKuZS9SdtFCRORpfh7wmgVjX8KWB9ed2DasCekP4x7z6R4qPJ1fpuFdAT3jl
 HQFno/E8xb63MHJIbvfrOt0ge6tqoc4TmBvUxPGvQ1UqY3wscc1X1qX3pPiOK5hB5DkXmmnvHhI
 m7OQihHh8hauYRV9F/+RMZwR/d+MCz69ROk5AwR1hSS6Gwf+oQEfaoGn1BA4tfRaz5BRi+b
X-Received: by 2002:a05:600c:45c6:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488d6ac2226mr203402335e9.28.1776173781347; 
 Tue, 14 Apr 2026 06:36:21 -0700 (PDT)
Received: from smtpclient.apple
 (2a01cb0014114800d473b7d8f9900c70.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:d473:b7d8:f990:c70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee049333sm52294685e9.15.2026.04.14.06.36.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:36:20 -0700 (PDT)
From: Matthieu Rolla <matthieu@minio.io>
Message-Id: <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_09379C7A-EBA5-45B8-A1BF-CBB30B53049B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Tue, 14 Apr 2026 15:36:19 +0200
In-Reply-To: <20260414124221.GB111076@fedora>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kbusch@kernel.org, mr-083 <matthieu@min.io>,
 John Meneghini <jmeneghi@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_09379C7A-EBA5-45B8-A1BF-CBB30B53049B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks for testing Windows, Stefan!=20

Great to have confirmation on both Linux and Windows.


Regarding `drive_insert`,  I found that `device_del` + `device_add` =
works well when no filesystem is mounted on the namespace.=20

However, when XFS is mounted (e.g. via DirectPV/CSI), the Linux kernel =
doesn't reuse the block device number (nvme0n1 becomes nvme0n2) because =
the stale mount holds a reference to the old `nvme_ns_head`, preventing =
`ida_free()`.=20

This causes XFS "duplicate UUID" errors on remount.

`drive_insert` avoids this by keeping the namespace device alive which =
means no ida cycle, same block device name.=20

Should I send it as a separate follow-up patch, or keep it in this =
series?

Matthieu

> On Apr 14, 2026, at 2:42=E2=80=AFPM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>=20
> On Mon, Apr 13, 2026 at 07:17:37PM +0200, Klaus Jensen wrote:
>> On Apr  9 08:01, mr-083 wrote:
>>> This series adds two features that together enable transparent NVMe =
disk
>>> hot-swap simulation in QEMU, matching the behavior of physical NVMe
>>> drives being pulled and reinserted in the same PCIe slot.
>>>=20
>>=20
>> I don't understand this. =46rom an NVMe perspective you can't hotplug =
a
>> namespace. You can hotplug a PCIe-based NVM Subsystem.
>=20
> Hi Klaus,
> It would be great if someone with more NVMe experience than myself can
> find a definite answer, but I think the Namespace List can change
> asynchronously even on a NVMe PCIe controller as long as it supports
> Namespace Management commands.
>=20
> There are instances in the NVMe Express Base Specification 2.0b like:
> - 8.3.1 Capacity Management Overview
>  "a Namespace Attribute Changed event is generated for hosts other =
than
>  the host which issued the Capacity Management command"
> - 8.11 Namespace Management
>  "If Namespace Attribute Notices are enabled, any controller(s) not
>  processing the Namespace Management command that was attached to the
>  namespace reports a Namespace Attribute Changed asynchronous event to
>  the host."
>=20
> I imagine this functionality would be useful in storage offload cards
> (IPUs/DPUs) that present as NVMe PCIe controllers instead of as
> NVMe-over-Fabrics. This makes sense when the host is not supposed to
> manage the storage itself. When the card's control plane configures a
> new volume, the NVMe Namespace List changes and the host is notified.
>=20
> Linux and Windows NVMe PCI drivers support this according to the =
testing
> that Matthieu and I have done.
>=20
> Thanks,
> Stefan


--Apple-Mail=_09379C7A-EBA5-45B8-A1BF-CBB30B53049B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><p style=3D"white-space: pre-wrap; =
margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, 64); =
font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, =
sans-serif; font-size: 13px; font-variant-ligatures: normal;">Thanks for =
testing Windows, Stefan!&nbsp;</p><p style=3D"white-space: pre-wrap; =
margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, 64); =
font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, =
sans-serif; font-size: 13px; font-variant-ligatures: normal;"><br></p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;">Great to have confirmation on both =
Linux and Windows.</p><p style=3D"white-space: pre-wrap; margin-top: =
0.1em; margin-bottom: 0.2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;"><br></p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;"><br></p><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">Regarding `drive_insert`,  I found that `device_del` + =
`device_add` works well when no filesystem is mounted on the =
namespace.&nbsp;</p><p style=3D"white-space: pre-wrap; margin-top: =
0.1em; margin-bottom: 0.2em; color: rgb(64, 64, 64); font-family: =
-apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, sans-serif; =
font-size: 13px; font-variant-ligatures: normal;"><br></p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;">However, when XFS is mounted (e.g. via =
DirectPV/CSI), the Linux kernel doesn't reuse the block device number =
(nvme0n1 becomes nvme0n2) because the stale mount holds a reference to =
the old `nvme_ns_head`, preventing `ida_free()`.&nbsp;</p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;"><br></p><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">This causes XFS "duplicate UUID" errors on remount.</p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;"><br></p><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">`drive_insert` avoids this by keeping the namespace device =
alive which means no ida cycle, same block device name.&nbsp;</p><p =
style=3D"white-space: pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; =
color: rgb(64, 64, 64); font-family: -apple-system, system-ui, =
&quot;Segoe UI&quot;, Roboto, sans-serif; font-size: 13px; =
font-variant-ligatures: normal;"><br></p><p style=3D"white-space: =
pre-wrap; margin-top: 0.1em; margin-bottom: 0.2em; color: rgb(64, 64, =
64); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, =
Roboto, sans-serif; font-size: 13px; font-variant-ligatures: =
normal;">Should I send it as a separate follow-up patch, or keep it in =
this series?</p><div><br></div><div>Matthieu</div>
<div><br><blockquote type=3D"cite"><div>On Apr 14, 2026, at 2:42=E2=80=AFP=
M, Stefan Hajnoczi &lt;stefanha@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Mon, Apr 13, 2026 at =
07:17:37PM +0200, Klaus Jensen wrote:<br><blockquote type=3D"cite">On =
Apr &nbsp;9 08:01, mr-083 wrote:<br><blockquote type=3D"cite">This =
series adds two features that together enable transparent NVMe =
disk<br>hot-swap simulation in QEMU, matching the behavior of physical =
NVMe<br>drives being pulled and reinserted in the same PCIe =
slot.<br><br></blockquote><br>I don't understand this. =46rom an NVMe =
perspective you can't hotplug a<br>namespace. You can hotplug a =
PCIe-based NVM Subsystem.<br></blockquote><br>Hi Klaus,<br>It would be =
great if someone with more NVMe experience than myself can<br>find a =
definite answer, but I think the Namespace List can =
change<br>asynchronously even on a NVMe PCIe controller as long as it =
supports<br>Namespace Management commands.<br><br>There are instances in =
the NVMe Express Base Specification 2.0b like:<br>- 8.3.1 Capacity =
Management Overview<br> &nbsp;"a Namespace Attribute Changed event is =
generated for hosts other than<br> &nbsp;the host which issued the =
Capacity Management command"<br>- 8.11 Namespace Management<br> =
&nbsp;"If Namespace Attribute Notices are enabled, any controller(s) =
not<br> &nbsp;processing the Namespace Management command that was =
attached to the<br> &nbsp;namespace reports a Namespace Attribute =
Changed asynchronous event to<br> &nbsp;the host."<br><br>I imagine this =
functionality would be useful in storage offload cards<br>(IPUs/DPUs) =
that present as NVMe PCIe controllers instead of =
as<br>NVMe-over-Fabrics. This makes sense when the host is not supposed =
to<br>manage the storage itself. When the card's control plane =
configures a<br>new volume, the NVMe Namespace List changes and the host =
is notified.<br><br>Linux and Windows NVMe PCI drivers support this =
according to the testing<br>that Matthieu and I have =
done.<br><br>Thanks,<br>Stefan<br></div></div></blockquote></div><br></bod=
y></html>=

--Apple-Mail=_09379C7A-EBA5-45B8-A1BF-CBB30B53049B--

