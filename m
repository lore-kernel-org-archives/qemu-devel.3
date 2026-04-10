Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C113F36BA6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2QN-00029j-MC; Thu, 09 Apr 2026 23:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wB03U-0006zQ-NU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 20:49:06 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wB03S-0003w2-QM
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 20:49:04 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79d991c7b6aso15673317b3.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 17:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775782141; cv=none;
 d=google.com; s=arc-20240605;
 b=SH1aeUTpn4T2JREYRUBrnEx0VHnIK4SWN6CE8Xo5LXYCcOqdGD9URZ5GlO2wmLwbPd
 Kom0uFTVm7KfVl5mYq4VTgBVGqhTmNCH6mfkqOdmXo6H/G0F+Qb9Dd2sWia7OhwqNX6R
 anBKVY4grdLXvtMTQtvNFyWutWxRwnr9cFVwW3paFdkpGKZO2h46qmNmzYr8HVvedHu/
 uv8VuIwrOoNSzg1FwaUi28EIxuSYdKqiJAfbJusaaOiOgRzq/PquTnktmzjY3Kb3lxsu
 hN7GlMcawkpas+Q3tnGNt8Aie80iPcTCT2V7tru5BgEszmURQ1j2H4p+5L478dUvhh6/
 5adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EOgZzkmBjXoou+oVC7LsJDXZfXvkE72jYXZxbhh+XBo=;
 fh=9APC4TOqqeyK4f+hBMC/WhXBwI4zhfL25tS7yb/7n7s=;
 b=Dqkgg6+it348Ns9lu8el32doB4oST98ycSweTXpCQRw0d+8a28JwZuyhxzXuBsX5Qf
 9J8oLbSrjIUp/YaOAsEIW6fw9NZ4DmUn6rZPqNzL5tj/RHoNcUkgbzv57PUoGW3b+iOF
 U+j280BZ08Rm+zSEBz49Mo6i0n5KcoPvVzzbuvtm53Qm/lXC5o3U0DpeuOwM6RVIxaH+
 gxyVkRyvRzq0qN93cx3EswdCYTIeYvfi+ad1cO3zUXVN9OAJ3FL9kFtnVH+94ycjLOXn
 AT3yLg0qw0fik7aEYVfBvxZbOkAPmrUuQJYhg84zWr3qh3wa9epmNLjbJ+qA7tctPiSU
 AeoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775782141; x=1776386941; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EOgZzkmBjXoou+oVC7LsJDXZfXvkE72jYXZxbhh+XBo=;
 b=bq5vomI1dzCdZxbMH+oRZYkwpBn8FXn+U9z+vyxzdw3Be+ZpKNXz7GcVk3RvdSGxHu
 RQ7AmFDR03pQnYbyhQITlYmb6xUIBZN6rqo5ESclNUxEfC46jQQp5tqt2vht0aFSgDCj
 JTh3YqP1MUViMAYOAWj9HIVKoV5uedkecsLEN0sdXgS5yT200wnJ5vyCwgBBJAj7J+DB
 3H4aA5YfmOsvPnC5h1Sg5ZOw+Fxoaq/gC4AGWW/OcJ3wMRnVHfeRzgGfIA0pUPLOAKFK
 M+8qg12Uu3kkMoEzx+HdfegBb+VgbAvpOG7TPXkdLxULtghm76KAhAHbsc+qW1gNxiEe
 O+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775782141; x=1776386941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOgZzkmBjXoou+oVC7LsJDXZfXvkE72jYXZxbhh+XBo=;
 b=TzyDuQHUdx8H9wEr6lI6mw8JqTtvcj5aE7XhQ49myIxYJUa0gsxn27oBA5BgxYEdfk
 97gtJm/rHhVPOdtydwD35L88BdQt6gZSGbVbMUv3oee+GoHO7OtR31mDakvBJt9G2nJW
 2hLjihhSLqrZN+6o70ZAGUdnC9veWrTgCJ0Sf04PH3k/4F51vUAmlpIsbMBQ6OSV6DFQ
 VJOG774WcL/tzVRFVR/Gh/qgpHLXb9ROrovv7/W/OMzX8251kv57cojt69E+uGj+QImj
 sa4/gpiS9I9W+Qau+D6UX0AFTISWFMsRmAxrwj0i7XvKMMNF/xzvxbqkpNwvXRj24j+Q
 +nDg==
X-Gm-Message-State: AOJu0YyD0u7FRCHWGkJZc5KOSY1vtgjxtrdm0nyJaREETIQHipgtN3+U
 RHaR6dh6+WK+wemxBha5nBFxqZfKXlsLzCHhi0NHmSsPLG2/RpQYf72GoTNgUfm8lI35piDgORK
 B5FtL/VwDWwa4AJIChtaAmOgRVlPQQv1jt8VBno8ZEg==
X-Gm-Gg: AeBDiesIY/JwOLa6rsYzFC8nvPjRB2omq9/mL7X0uAE+nfVVJqwhP8woZ/H1x8DeRym
 ba+tXmnCmbJJPbderSKlW6hau7d4F3mZGPTG8mccTo+vxKdOmgRY7Oeid6OFnMu1lELkMKH347v
 Q0Q73o1QWFHBhxHMzc5YdCRu2JLKm+WV9S+cJFdN/aOxjJlw6rYbFH7aJUK4nKMjHi2mgYRVu7D
 7LaG8vE7yL+ayc93C2L2WOUcfNKcBdGwkRlTH0a+In7qa8PP2qBWUJDbXwq7mXZuEeJBt9mRhVL
 HJQAAPUwWd8gRizO/SGmT7vdd+zYTqBgw36JZkW5+3/qbJSvzbrdHWcRAwePBwjFidtbOjh0Cw=
 =
X-Received: by 2002:a05:690c:d8e:b0:7a0:afb5:687d with SMTP id
 00721157ae682-7af71962847mr14309907b3.39.1775782141035; Thu, 09 Apr 2026
 17:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260409070114.11313-1-matthieu@min.io>
 <20260409210007.GA461870@fedora>
In-Reply-To: <20260409210007.GA461870@fedora>
From: Matthieu Rolla <matthieu@minio.io>
Date: Fri, 10 Apr 2026 02:49:01 +0200
X-Gm-Features: AQROBzDxmRHIc0fPSuXYC40YPnP0UyiTH5dEWqc1eruf_VMZ5m2sgSdzoKZR69Y
Message-ID: <CAPSO8Mz5EcAT2tp_jbrcrkTO3Pn+2A9awY=7t7fFBya=+4UQiA@mail.gmail.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk, 
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Content-Type: multipart/alternative; boundary="000000000000b7192d064f107f0e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=matthieu@minio.io; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 23:20:50 -0400
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

--000000000000b7192d064f107f0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!

> Is it possible to achieve this with device_del + device_add instead of
> introducing a new monitor command?

Yes, device_del + device_add works. I tested it and the AEN properly
notifies the guest kernel which rescans and adds/removes the block
device.

However, when filesystems (XFS via DirectPV in our case) are mounted
on the namespace, the old block device number is not reused on re-add.
The kernel's IDA allocator only frees the ID when all references to
the namespace head are released (nvme_free_ns_head), but the stale
XFS mount holds a reference indefinitely.

Without mounted filesystems, the ID is reused correctly (/dev/nvme0n1
stays nvme0n1).

> Is NVMe AEN insufficient to get the guest to recognize the Namespace
> change?

You're right AEN is sufficient. I confirmed that the Linux NVMe
driver processes NVME_AER_NOTICE_NS_CHANGED and rescans automatically.
The SDN was unnecessary.

I dropped Patch 2 (drive_insert) and sent v2 with just the
namespace hotplug support. The commit message now documents the
correct device_del + device_add flow.

Here is the link
https://mail.gnu.org/archive/html/qemu-devel/2026-04/msg01507.html

Thanks

On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> On Thu, Apr 09, 2026 at 09:01:09AM +0200, mr-083 wrote:
> > This series adds two features that together enable transparent NVMe dis=
k
> > hot-swap simulation in QEMU, matching the behavior of physical NVMe
> > drives being pulled and reinserted in the same PCIe slot.
> >
> > Problem:
> > Currently, hot-swapping an NVMe disk in QEMU requires removing the
> > entire NVMe controller via device_del, which causes the Linux guest to
> > assign a new controller number on re-add (e.g. nvme2 becomes nvme4).
> > This breaks storage software that tracks drives by device name.
>
> Hi mr-083,
> Neat, I was looking for something like this recently!
>
> > Solution:
> > Patch 1 adds hotplug support for nvme-ns devices on the NvmeBus, with
> > proper Asynchronous Event Notification (AEN) so the guest kernel detect=
s
> > namespace changes. This allows namespace-level hot-swap without removin=
g
> > the NVMe controller.
> >
> > Patch 2 adds a drive_insert HMP command that reconnects a host block
> > device file to an existing guest device after drive_del. This is the
> > counterpart to drive_del for non-removable devices where
> > blockdev-change-medium cannot be used.
> >
> > The recommended hot-swap sequence is:
> >   1. drive_del <drive-id>          # disconnect backing store
> >   2. drive_insert <device> <file>  # reconnect backing store
>
> Is it possible to achieve this with device_del + device_add instead of
> introducing a new monitor command?
>
> device_del nvme-ns2
> blockdev-del nvme-ns2-blk      (or drive_del)
> ...
> blockdev-add nvme-ns2-blk,...  (or drive_add)
> device_add nvme-ns,id=3Dnvme-ns2,nsid=3D2,drive=3Dnvme-ns2-blk
>
> >   3. pcie_aer_inject_error <port> SDN  # trigger controller reset
>
> Is NVMe AEN insufficient to get the guest to recognize the Namespace
> change? I looked at the Linux NVMe driver code recently and got the
> impression it would process changes to the Namespace list upon receiving
> the NVMe AEN.
>
> > After this sequence, the guest sees the same controller and namespace
> > names (e.g. /dev/nvme2n1 remains /dev/nvme2n1), and the NVMe driver
> > recovers transparently via the standard AER recovery path.
> >
> > Tested with:
> > - Linux 6.1 guest on QEMU aarch64 with HVF (macOS)
> > - NVMe subsystem model with multipath disabled
> > - DirectPV and MinIO AIStor storage stack
> >
> > mr-083 (2):
> >   hw/nvme: add namespace hotplug support
> >   block/monitor: add drive_insert HMP command
> >
> >  block/monitor/block-hmp-cmds.c | 59 +++++++++++++++++++++++
> >  hmp-commands.hx                | 18 +++++++
> >  hw/nvme/ctrl.c                 | 85 ++++++++++++++++++++++++++++++++++
> >  hw/nvme/ns.c                   |  1 +
> >  hw/nvme/subsys.c               |  2 +
> >  include/block/block-hmp-cmds.h |  1 +
> >  6 files changed, 166 insertions(+)
> >
> > --
> > 2.50.1 (Apple Git-155)
> >
>

--000000000000b7192d064f107f0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the review!<br><br>&gt; Is it possible to achie=
ve this with device_del + device_add instead of<br>&gt; introducing a new m=
onitor command?<br><br>Yes, device_del + device_add works. I tested it and =
the AEN properly<br>notifies the guest kernel which rescans and adds/remove=
s the block<br>device.<br><br>However, when filesystems (XFS via DirectPV i=
n our case) are mounted<br>on the namespace, the old block device number is=
 not reused on re-add.<br>The kernel&#39;s IDA allocator only frees the ID =
when all references to<br>the namespace head are released (nvme_free_ns_hea=
d), but the stale<br>XFS mount holds a reference indefinitely.<br><br>Witho=
ut mounted filesystems, the ID is reused correctly (/dev/nvme0n1<br>stays n=
vme0n1).<br><br>&gt; Is NVMe AEN insufficient to get the guest to recognize=
 the Namespace<br>&gt; change?<br><br>You&#39;re right AEN is sufficient. I=
 confirmed that the Linux NVMe<br>driver processes NVME_AER_NOTICE_NS_CHANG=
ED and rescans automatically.<br>The SDN was unnecessary.<br><br>I dropped =
Patch 2 (drive_insert) and sent v2 with just the<br>namespace hotplug suppo=
rt. The commit message now documents the<br>correct device_del + device_add=
 flow.<br><div><br></div><div>Here is the link=C2=A0<a href=3D"https://mail=
.gnu.org/archive/html/qemu-devel/2026-04/msg01507.html">https://mail.gnu.or=
g/archive/html/qemu-devel/2026-04/msg01507.html</a><br><br>Thanks</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Apr 9, 2026 at 11:00=E2=80=AFPM Stefan Hajnoczi &=
lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Apr 09=
, 2026 at 09:01:09AM +0200, mr-083 wrote:<br>
&gt; This series adds two features that together enable transparent NVMe di=
sk<br>
&gt; hot-swap simulation in QEMU, matching the behavior of physical NVMe<br=
>
&gt; drives being pulled and reinserted in the same PCIe slot.<br>
&gt; <br>
&gt; Problem:<br>
&gt; Currently, hot-swapping an NVMe disk in QEMU requires removing the<br>
&gt; entire NVMe controller via device_del, which causes the Linux guest to=
<br>
&gt; assign a new controller number on re-add (e.g. nvme2 becomes nvme4).<b=
r>
&gt; This breaks storage software that tracks drives by device name.<br>
<br>
Hi mr-083,<br>
Neat, I was looking for something like this recently!<br>
<br>
&gt; Solution:<br>
&gt; Patch 1 adds hotplug support for nvme-ns devices on the NvmeBus, with<=
br>
&gt; proper Asynchronous Event Notification (AEN) so the guest kernel detec=
ts<br>
&gt; namespace changes. This allows namespace-level hot-swap without removi=
ng<br>
&gt; the NVMe controller.<br>
&gt; <br>
&gt; Patch 2 adds a drive_insert HMP command that reconnects a host block<b=
r>
&gt; device file to an existing guest device after drive_del. This is the<b=
r>
&gt; counterpart to drive_del for non-removable devices where<br>
&gt; blockdev-change-medium cannot be used.<br>
&gt; <br>
&gt; The recommended hot-swap sequence is:<br>
&gt;=C2=A0 =C2=A01. drive_del &lt;drive-id&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # disconnect backing store<br>
&gt;=C2=A0 =C2=A02. drive_insert &lt;device&gt; &lt;file&gt;=C2=A0 # reconn=
ect backing store<br>
<br>
Is it possible to achieve this with device_del + device_add instead of<br>
introducing a new monitor command?<br>
<br>
device_del nvme-ns2<br>
blockdev-del nvme-ns2-blk=C2=A0 =C2=A0 =C2=A0 (or drive_del)<br>
...<br>
blockdev-add nvme-ns2-blk,...=C2=A0 (or drive_add)<br>
device_add nvme-ns,id=3Dnvme-ns2,nsid=3D2,drive=3Dnvme-ns2-blk<br>
<br>
&gt;=C2=A0 =C2=A03. pcie_aer_inject_error &lt;port&gt; SDN=C2=A0 # trigger =
controller reset<br>
<br>
Is NVMe AEN insufficient to get the guest to recognize the Namespace<br>
change? I looked at the Linux NVMe driver code recently and got the<br>
impression it would process changes to the Namespace list upon receiving<br=
>
the NVMe AEN.<br>
<br>
&gt; After this sequence, the guest sees the same controller and namespace<=
br>
&gt; names (e.g. /dev/nvme2n1 remains /dev/nvme2n1), and the NVMe driver<br=
>
&gt; recovers transparently via the standard AER recovery path.<br>
&gt; <br>
&gt; Tested with:<br>
&gt; - Linux 6.1 guest on QEMU aarch64 with HVF (macOS)<br>
&gt; - NVMe subsystem model with multipath disabled<br>
&gt; - DirectPV and MinIO AIStor storage stack<br>
&gt; <br>
&gt; mr-083 (2):<br>
&gt;=C2=A0 =C2=A0hw/nvme: add namespace hotplug support<br>
&gt;=C2=A0 =C2=A0block/monitor: add drive_insert HMP command<br>
&gt; <br>
&gt;=C2=A0 block/monitor/block-hmp-cmds.c | 59 +++++++++++++++++++++++<br>
&gt;=C2=A0 hmp-commands.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 18 +++++++<br>
&gt;=C2=A0 hw/nvme/ctrl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 85 ++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 hw/nvme/ns.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 hw/nvme/subsys.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 include/block/block-hmp-cmds.h |=C2=A0 1 +<br>
&gt;=C2=A0 6 files changed, 166 insertions(+)<br>
&gt; <br>
&gt; --<br>
&gt; 2.50.1 (Apple Git-155)<br>
&gt; <br>
</blockquote></div>

--000000000000b7192d064f107f0e--

