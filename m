Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8385C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 08:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR64B-0006z1-9u; Tue, 09 Jul 2024 04:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR647-0006yV-UI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:19:12 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sR643-0006KS-1p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:19:11 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25e171122fcso1944018fac.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720513144; x=1721117944;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+3sXtB8HuOORj4ubRE+C49ZeStKiJeKeSJWvYJQpjhM=;
 b=tJgQmwMmJtsGs07C6VXeOtgF1Ib37EKsLnfzsqg2HLgC966oysgZ4edqNjqsydJaw6
 mXQPHso60TntyMssWStZ+siueII5sfRX3fdzvCtKIbPEgV1PN2Zk8LlP3H/fNI8ZFdOU
 DgnKZ4DLUrmQq0PbwwdGb7ZjmYG3H828xR08SGAEf+0mOha4+TDnYub+XNs3sxvlxKp7
 AgKlCsA7p0cKc72ecEBtSw33HxZK0UGrrMrcjnl/Vbuo54ECvV9HENT1MhOq6tOah/Bc
 7jUwc7SFZRLQoK3Q78Arc+5ahJ7BYzb8ZGZQQlph6bYRReFoYJN2oxgAi1l5kuqUcLwa
 YXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720513144; x=1721117944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3sXtB8HuOORj4ubRE+C49ZeStKiJeKeSJWvYJQpjhM=;
 b=AcAAlZWZciYnXF5hMxfv8eKnmQ7y533PIFyXeBxxdVMzpoOFh/iEOf0ajKk9kbrkuT
 M78+pQ6gBxyYVsR/Qxj6WulY6grOPzHVkTdhUEA5Z6vLPh9Je+1Lzbf7BqFPdgQC9tRg
 eVX0omd+YGIKFcjkWaUzlJOyBaKwsCghSz3do/MU5KK352hg48AuJ3aAbGIPaIAXM0IX
 ORYWnyWvBMBw3FV6xPnt5BuJOKaPSMGJKXomHp1GmFl41Q9K/62ZQUM3b+Z3yDajJvxb
 FkbBlrSEU3MUG1SM3ydTxrFyKyUMO617ByCL4Icg+el+Em2GvtVQKRuJNa2h4JVpntK+
 dMJA==
X-Gm-Message-State: AOJu0Yx8iw9oB9YjptYscU8np/pvg+PBDXzHsTIWuzc5qTOZSpj1hl7/
 f+nZGqLpS66Erx1wBpuiVnEPoP72rZ80EaX54IwNAtud6ICwrSDHfpPdTrhag9wq2tncIS3q4FA
 d+zbcq/MZdbNHk3MO8XH6y36Waf5x7faTFdA8ug==
X-Google-Smtp-Source: AGHT+IGeIaUqenLdruB9ptycq3IV47ocf4Xlo58fgVdSWWqDSkSnDWd2f5B/9P/oQgRWIbZol3fhrtme+iDHXIKPbKE=
X-Received: by 2002:a05:6870:1653:b0:25d:f950:f18c with SMTP id
 586e51a60fabf-25eafb532f5mr706211fac.26.1720513143671; Tue, 09 Jul 2024
 01:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
 <87cypzsbgd.fsf@pond.sub.org>
In-Reply-To: <87cypzsbgd.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 9 Jul 2024 16:18:47 +0800
Message-ID: <CAK9dgmZhM4cs0gPX3on1KeixYJ5geEi1kpWzJHpyr7XkMqi7kA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Add introduction to LUKS volume with detached
 header
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c2a7c6061ccc2e59"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c2a7c6061ccc2e59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> Looks like this fell through the cracks.  Is anyone familiar with LUKS
> willing to review it?
>
:) Ping?


>
> Hyman Huang <yong.huang@smartx.com> writes:
>
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  MAINTAINERS                         |   1 +
> >  docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++++++++
> >  2 files changed, 183 insertions(+)
> >  create mode 100644 docs/devel/luks-detached-header.rst
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a24c2b51b6..e8b03032ab 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3422,6 +3422,7 @@ Detached LUKS header
> >  M: Hyman Huang <yong.huang@smartx.com>
> >  S: Maintained
> >  F: tests/qemu-iotests/tests/luks-detached-header
> > +F: docs/devel/luks-detached-header.rst
> >
> >  D-Bus
> >  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > diff --git a/docs/devel/luks-detached-header.rst
> b/docs/devel/luks-detached-header.rst
> > new file mode 100644
> > index 0000000000..15e9ccde1d
> > --- /dev/null
> > +++ b/docs/devel/luks-detached-header.rst
> > @@ -0,0 +1,182 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +LUKS volume with detached header
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document gives an overview of the design of LUKS volume with
> detached
> > +header and how to use it.
> > +
> > +Background
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The LUKS format has ability to store the header in a separate volume
> from
> > +the payload. We could extend the LUKS driver in QEMU to support this u=
se
> > +case.
> > +
> > +Normally a LUKS volume has a layout:
> > +
> > +::
> > +
> > +         +-----------------------------------------------+
> > +         |         |                |                    |
> > + disk    | header  |  key material  |  disk payload data |
> > +         |         |                |                    |
> > +         +-----------------------------------------------+
> > +
> > +With a detached LUKS header, you need 2 disks so getting:
> > +
> > +::
> > +
> > +         +--------------------------+
> > + disk1   |   header  | key material |
> > +         +--------------------------+
> > +         +---------------------+
> > + disk2   |  disk payload data  |
> > +         +---------------------+
> > +
> > +There are a variety of benefits to doing this:
> > +
> > + * Secrecy - the disk2 cannot be identified as containing LUKS
> > +             volume since there's no header
> > + * Control - if access to the disk1 is restricted, then even
> > +             if someone has access to disk2 they can't unlock
> > +             it. Might be useful if you have disks on NFS but
> > +             want to restrict which host can launch a VM
> > +             instance from it, by dynamically providing access
> > +             to the header to a designated host
> > + * Flexibility - your application data volume may be a given
> > +                 size and it is inconvenient to resize it to
> > +                 add encryption.You can store the LUKS header
> > +                 separately and use the existing storage
> > +                 volume for payload
> > + * Recovery - corruption of a bit in the header may make the
> > +              entire payload inaccessible. It might be
> > +              convenient to take backups of the header. If
> > +              your primary disk header becomes corrupt, you
> > +              can unlock the data still by pointing to the
> > +              backup detached header
> > +
> > +Architecture
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Take the qcow2 encryption, for example. The architecture of the
> > +LUKS volume with detached header is shown in the diagram below.
> > +
> > +There are two children of the root node: a file and a header.
> > +Data from the disk payload is stored in the file node. The
> > +LUKS header and key material are located in the header node,
> > +as previously mentioned.
> > +
> > +::
> > +
> > +                       +-----------------------------+
> > +  Root node            |          foo[luks]          |
> > +                       +-----------------------------+
> > +                          |                       |
> > +                     file |                header |
> > +                          |                       |
> > +               +---------------------+    +------------------+
> > +  Child node   |payload-format[qcow2]|    |header-format[raw]|
> > +               +---------------------+    +------------------+
> > +                          |                       |
> > +                     file |                 file  |
> > +                          |                       |
> > +               +----------------------+  +---------------------+
> > +  Child node   |payload-protocol[file]|  |header-protocol[file]|
> > +               +----------------------+  +---------------------+
> > +                          |                       |
> > +                          |                       |
> > +                          |                       |
> > +                     Host storage            Host storage
> > +
> > +Usage
> > +=3D=3D=3D=3D=3D
> > +
> > +Create a LUKS disk with a detached header using qemu-img
> > +--------------------------------------------------------
> > +
> > +Shell commandline::
> > +
> > +# qemu-img create --object secret,id=3Dsec0,data=3Dabc123 -f luks \
> > +> -o cipher-alg=3Daes-256,cipher-mode=3Dxts -o key-secret=3Dsec0 \
> > +> -o detached-header=3Dtrue test-header.img
> > +# qemu-img create -f qcow2 test-payload.qcow2 200G
> > +# qemu-img info 'json:{"driver":"luks","file":{"filename": \
> > +> "test-payload.img"},"header":{"filename":"test-header.img"}}'
> > +
> > +Set up a VM's LUKS volume with a detached header
> > +------------------------------------------------
> > +
> > +Qemu commandline::
> > +
> > +# qemu-system-x86_64 ... \
> > +> -object '{"qom-type":"secret","id":"libvirt-3-format-secret", \
> > +> "data":"abc123"}' \
> > +> -blockdev '{"driver":"file","filename":"/path/to/test-header.img", \
> > +> "node-name":"libvirt-1-storage"}' \
> > +> -blockdev '{"node-name":"libvirt-1-format","read-only":false, \
> > +> "driver":"raw","file":"libvirt-1-storage"}' \
> > +> -blockdev '{"driver":"file","filename":"/path/to/test-payload.qcow2"=
,
> \
> > +> "node-name":"libvirt-2-storage"}' \
> > +> -blockdev '{"node-name":"libvirt-2-format","read-only":false, \
> > +> "driver":"qcow2","file":"libvirt-2-storage"}' \
> > +> -blockdev '{"node-name":"libvirt-3-format","driver":"luks", \
> > +> "file":"libvirt-2-format","header":"libvirt-1-format","key-secret": =
\
> > +> "libvirt-3-format-secret"}' \
> > +> -device '{"driver":"virtio-blk-pci","bus":XXX,"addr":YYY,"drive": \
> > +> "libvirt-3-format","id":"virtio-disk1"}'
> > +
> > +Add LUKS volume to a VM with a detached header
> > +----------------------------------------------
> > +
> > +1. object-add the secret for decrypting the cipher stored in
> > +   LUKS header above::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"object-add", \
> > +> "arguments":{"qom-type":"secret", "id": \
> > +> "libvirt-4-format-secret", "data":"abc123"}}'
> > +
> > +2. block-add the protocol node for LUKS header::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> > +> "arguments":{"node-name":"libvirt-1-storage", "driver":"file", \
> > +> "filename": "/path/to/test-header.img" }}'
> > +
> > +3. block-add the raw-drived node for LUKS header::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> > +> "arguments":{"node-name":"libvirt-1-format", "driver":"raw", \
> > +> "file":"libvirt-1-storage"}}'
> > +
> > +4. block-add the protocol node for disk payload image::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> > +> "arguments":{"node-name":"libvirt-2-storage", "driver":"file", \
> > +> "filename":"/path/to/test-payload.qcow2"}}'
> > +
> > +5. block-add the qcow2-drived format node for disk payload data::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> > +> "arguments":{"node-name":"libvirt-2-format", "driver":"qcow2", \
> > +> "file":"libvirt-2-storage"}}'
> > +
> > +6. block-add the luks-drived format node to link the qcow2 disk
> > +   with the LUKS header by specifying the field "header"::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> > +> "arguments":{"node-name":"libvirt-3-format", "driver":"luks", \
> > +> "file":"libvirt-2-format", "header":"libvirt-1-format", \
> > +> "key-secret":"libvirt-2-format-secret"}}'
> > +
> > +7. hot-plug the virtio-blk device finally::
> > +
> > +# virsh qemu-monitor-command vm '{"execute":"device_add", \
> > +> "arguments": {"driver":"virtio-blk-pci", \
> > +> "drive": "libvirt-3-format", "id":"virtio-disk2"}}
> > +
> > +TODO
> > +=3D=3D=3D=3D
> > +
> > +1. Support the shared detached LUKS header within the VM.
>
>

--=20
Best regards

--000000000000c2a7c6061ccc2e59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 202=
4 at 2:26=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Looks like =
this fell through the cracks.=C2=A0 Is anyone familiar with LUKS<br>
willing to review it?<br></blockquote><div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default"></div><div style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">=
:) Ping?</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">=
yong.huang@smartx.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 2 files changed, 183 insertions(+)<br>
&gt;=C2=A0 create mode 100644 docs/devel/luks-detached-header.rst<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index a24c2b51b6..e8b03032ab 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -3422,6 +3422,7 @@ Detached LUKS header<br>
&gt;=C2=A0 M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" targ=
et=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: tests/qemu-iotests/tests/luks-detached-header<br>
&gt; +F: docs/devel/luks-detached-header.rst<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 D-Bus<br>
&gt;=C2=A0 M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau=
@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; diff --git a/docs/devel/luks-detached-header.rst b/docs/devel/luks-det=
ached-header.rst<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..15e9ccde1d<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/devel/luks-detached-header.rst<br>
&gt; @@ -0,0 +1,182 @@<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +LUKS volume with detached header<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +Introduction<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +This document gives an overview of the design of LUKS volume with det=
ached<br>
&gt; +header and how to use it.<br>
&gt; +<br>
&gt; +Background<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +The LUKS format has ability to store the header in a separate volume =
from<br>
&gt; +the payload. We could extend the LUKS driver in QEMU to support this =
use<br>
&gt; +case.<br>
&gt; +<br>
&gt; +Normally a LUKS volume has a layout:<br>
&gt; +<br>
&gt; +::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+----------------------------------=
-------------+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; + disk=C2=A0 =C2=A0 | header=C2=A0 |=C2=A0 key material=C2=A0 |=C2=A0 =
disk payload data |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+----------------------------------=
-------------+<br>
&gt; +<br>
&gt; +With a detached LUKS header, you need 2 disks so getting:<br>
&gt; +<br>
&gt; +::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+--------------------------+<br>
&gt; + disk1=C2=A0 =C2=A0|=C2=A0 =C2=A0header=C2=A0 | key material |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+--------------------------+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+---------------------+<br>
&gt; + disk2=C2=A0 =C2=A0|=C2=A0 disk payload data=C2=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+---------------------+<br>
&gt; +<br>
&gt; +There are a variety of benefits to doing this:<br>
&gt; +<br>
&gt; + * Secrecy - the disk2 cannot be identified as containing LUKS<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0volume since there&#3=
9;s no header<br>
&gt; + * Control - if access to the disk1 is restricted, then even<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if someone has access=
 to disk2 they can&#39;t unlock<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it. Might be useful i=
f you have disks on NFS but<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0want to restrict whic=
h host can launch a VM<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0instance from it, by =
dynamically providing access<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to the header to a de=
signated host<br>
&gt; + * Flexibility - your application data volume may be a given<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size an=
d it is inconvenient to resize it to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add enc=
ryption.You can store the LUKS header<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0separat=
ely and use the existing storage<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0volume =
for payload<br>
&gt; + * Recovery - corruption of a bit in the header may make the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entire payload inacc=
essible. It might be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convenient to take b=
ackups of the header. If<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 your primary disk he=
ader becomes corrupt, you<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 can unlock the data =
still by pointing to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backup detached head=
er<br>
&gt; +<br>
&gt; +Architecture<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +Take the qcow2 encryption, for example. The architecture of the<br>
&gt; +LUKS volume with detached header is shown in the diagram below.<br>
&gt; +<br>
&gt; +There are two children of the root node: a file and a header.<br>
&gt; +Data from the disk payload is stored in the file node. The<br>
&gt; +LUKS header and key material are located in the header node,<br>
&gt; +as previously mentioned.<br>
&gt; +<br>
&gt; +::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+-----------------------------+<br>
&gt; +=C2=A0 Root node=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 foo[luks]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+-----------------------------+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0file |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 header=
 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-------------=
--------+=C2=A0 =C2=A0 +------------------+<br>
&gt; +=C2=A0 Child node=C2=A0 =C2=A0|payload-format[qcow2]|=C2=A0 =C2=A0 |h=
eader-format[raw]|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-------------=
--------+=C2=A0 =C2=A0 +------------------+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0file |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
file=C2=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-------------=
---------+=C2=A0 +---------------------+<br>
&gt; +=C2=A0 Child node=C2=A0 =C2=A0|payload-protocol[file]|=C2=A0 |header-=
protocol[file]|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-------------=
---------+=C2=A0 +---------------------+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Host storage=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Host storage<b=
r>
&gt; +<br>
&gt; +Usage<br>
&gt; +=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +Create a LUKS disk with a detached header using qemu-img<br>
&gt; +--------------------------------------------------------<br>
&gt; +<br>
&gt; +Shell commandline::<br>
&gt; +<br>
&gt; +# qemu-img create --object secret,id=3Dsec0,data=3Dabc123 -f luks \<b=
r>
&gt; +&gt; -o cipher-alg=3Daes-256,cipher-mode=3Dxts -o key-secret=3Dsec0 \=
<br>
&gt; +&gt; -o detached-header=3Dtrue test-header.img<br>
&gt; +# qemu-img create -f qcow2 test-payload.qcow2 200G<br>
&gt; +# qemu-img info &#39;json:{&quot;driver&quot;:&quot;luks&quot;,&quot;=
file&quot;:{&quot;filename&quot;: \<br>
&gt; +&gt; &quot;test-payload.img&quot;},&quot;header&quot;:{&quot;filename=
&quot;:&quot;test-header.img&quot;}}&#39;<br>
&gt; +<br>
&gt; +Set up a VM&#39;s LUKS volume with a detached header<br>
&gt; +------------------------------------------------<br>
&gt; +<br>
&gt; +Qemu commandline::<br>
&gt; +<br>
&gt; +# qemu-system-x86_64 ... \<br>
&gt; +&gt; -object &#39;{&quot;qom-type&quot;:&quot;secret&quot;,&quot;id&q=
uot;:&quot;libvirt-3-format-secret&quot;, \<br>
&gt; +&gt; &quot;data&quot;:&quot;abc123&quot;}&#39; \<br>
&gt; +&gt; -blockdev &#39;{&quot;driver&quot;:&quot;file&quot;,&quot;filena=
me&quot;:&quot;/path/to/test-header.img&quot;, \<br>
&gt; +&gt; &quot;node-name&quot;:&quot;libvirt-1-storage&quot;}&#39; \<br>
&gt; +&gt; -blockdev &#39;{&quot;node-name&quot;:&quot;libvirt-1-format&quo=
t;,&quot;read-only&quot;:false, \<br>
&gt; +&gt; &quot;driver&quot;:&quot;raw&quot;,&quot;file&quot;:&quot;libvir=
t-1-storage&quot;}&#39; \<br>
&gt; +&gt; -blockdev &#39;{&quot;driver&quot;:&quot;file&quot;,&quot;filena=
me&quot;:&quot;/path/to/test-payload.qcow2&quot;, \<br>
&gt; +&gt; &quot;node-name&quot;:&quot;libvirt-2-storage&quot;}&#39; \<br>
&gt; +&gt; -blockdev &#39;{&quot;node-name&quot;:&quot;libvirt-2-format&quo=
t;,&quot;read-only&quot;:false, \<br>
&gt; +&gt; &quot;driver&quot;:&quot;qcow2&quot;,&quot;file&quot;:&quot;libv=
irt-2-storage&quot;}&#39; \<br>
&gt; +&gt; -blockdev &#39;{&quot;node-name&quot;:&quot;libvirt-3-format&quo=
t;,&quot;driver&quot;:&quot;luks&quot;, \<br>
&gt; +&gt; &quot;file&quot;:&quot;libvirt-2-format&quot;,&quot;header&quot;=
:&quot;libvirt-1-format&quot;,&quot;key-secret&quot;: \<br>
&gt; +&gt; &quot;libvirt-3-format-secret&quot;}&#39; \<br>
&gt; +&gt; -device &#39;{&quot;driver&quot;:&quot;virtio-blk-pci&quot;,&quo=
t;bus&quot;:XXX,&quot;addr&quot;:YYY,&quot;drive&quot;: \<br>
&gt; +&gt; &quot;libvirt-3-format&quot;,&quot;id&quot;:&quot;virtio-disk1&q=
uot;}&#39;<br>
&gt; +<br>
&gt; +Add LUKS volume to a VM with a detached header<br>
&gt; +----------------------------------------------<br>
&gt; +<br>
&gt; +1. object-add the secret for decrypting the cipher stored in<br>
&gt; +=C2=A0 =C2=A0LUKS header above::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;objec=
t-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;qom-type&quot;:&quot;secret&quot;, =
&quot;id&quot;: \<br>
&gt; +&gt; &quot;libvirt-4-format-secret&quot;, &quot;data&quot;:&quot;abc1=
23&quot;}}&#39;<br>
&gt; +<br>
&gt; +2. block-add the protocol node for LUKS header::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;block=
dev-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-1-sto=
rage&quot;, &quot;driver&quot;:&quot;file&quot;, \<br>
&gt; +&gt; &quot;filename&quot;: &quot;/path/to/test-header.img&quot; }}&#3=
9;<br>
&gt; +<br>
&gt; +3. block-add the raw-drived node for LUKS header::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;block=
dev-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-1-for=
mat&quot;, &quot;driver&quot;:&quot;raw&quot;, \<br>
&gt; +&gt; &quot;file&quot;:&quot;libvirt-1-storage&quot;}}&#39;<br>
&gt; +<br>
&gt; +4. block-add the protocol node for disk payload image::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;block=
dev-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-2-sto=
rage&quot;, &quot;driver&quot;:&quot;file&quot;, \<br>
&gt; +&gt; &quot;filename&quot;:&quot;/path/to/test-payload.qcow2&quot;}}&#=
39;<br>
&gt; +<br>
&gt; +5. block-add the qcow2-drived format node for disk payload data::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;block=
dev-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-2-for=
mat&quot;, &quot;driver&quot;:&quot;qcow2&quot;, \<br>
&gt; +&gt; &quot;file&quot;:&quot;libvirt-2-storage&quot;}}&#39;<br>
&gt; +<br>
&gt; +6. block-add the luks-drived format node to link the qcow2 disk<br>
&gt; +=C2=A0 =C2=A0with the LUKS header by specifying the field &quot;heade=
r&quot;::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;block=
dev-add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-3-for=
mat&quot;, &quot;driver&quot;:&quot;luks&quot;, \<br>
&gt; +&gt; &quot;file&quot;:&quot;libvirt-2-format&quot;, &quot;header&quot=
;:&quot;libvirt-1-format&quot;, \<br>
&gt; +&gt; &quot;key-secret&quot;:&quot;libvirt-2-format-secret&quot;}}&#39=
;<br>
&gt; +<br>
&gt; +7. hot-plug the virtio-blk device finally::<br>
&gt; +<br>
&gt; +# virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;devic=
e_add&quot;, \<br>
&gt; +&gt; &quot;arguments&quot;: {&quot;driver&quot;:&quot;virtio-blk-pci&=
quot;, \<br>
&gt; +&gt; &quot;drive&quot;: &quot;libvirt-3-format&quot;, &quot;id&quot;:=
&quot;virtio-disk2&quot;}}<br>
&gt; +<br>
&gt; +TODO<br>
&gt; +=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +1. Support the shared detached LUKS header within the VM.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000c2a7c6061ccc2e59--

