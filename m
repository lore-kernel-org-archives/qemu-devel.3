Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8BDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3roL-0004e0-25; Mon, 06 May 2024 02:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3ro1-0004cM-FE
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3rnl-0000LY-Pm
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714976776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPGNUcDT1ywZ5yrydxemGJ4yo0FAE4ciOBPuv/1/CKA=;
 b=Kba9D1hGo2JmysobWFGm/jg6ZBHe859rZ+IM2qa3MXuu65yWsGLAT680UG87MqoDyXUnkB
 PZnBXY/+o8UFPE5BciWqF7v7UAEV8U/hLLITPZf1B/RTGWQ//Jhs3Hx+zzSvKV0zHWr8ws
 vCCvjC9wK0x4OS58Jz4JtthxI7AUFc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-i3MrfH4ZM6aDLEKkn6qXzg-1; Mon, 06 May 2024 02:26:12 -0400
X-MC-Unique: i3MrfH4ZM6aDLEKkn6qXzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0387A101150D;
 Mon,  6 May 2024 06:26:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FCD3AC6B;
 Mon,  6 May 2024 06:26:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70AEB21E6680; Mon,  6 May 2024 08:26:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH] docs/devel: Add introduction to LUKS volume with
 detached header
In-Reply-To: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Tue, 20 Feb 2024 00:04:42 +0800")
References: <c2049499aa05758b4cf18dcec942694ed454a980.1708358310.git.yong.huang@smartx.com>
Date: Mon, 06 May 2024 08:26:10 +0200
Message-ID: <87cypzsbgd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Looks like this fell through the cracks.  Is anyone familiar with LUKS
willing to review it?

Hyman Huang <yong.huang@smartx.com> writes:

> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  MAINTAINERS                         |   1 +
>  docs/devel/luks-detached-header.rst | 182 ++++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+)
>  create mode 100644 docs/devel/luks-detached-header.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24c2b51b6..e8b03032ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3422,6 +3422,7 @@ Detached LUKS header
>  M: Hyman Huang <yong.huang@smartx.com>
>  S: Maintained
>  F: tests/qemu-iotests/tests/luks-detached-header
> +F: docs/devel/luks-detached-header.rst
>=20=20
>  D-Bus
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> diff --git a/docs/devel/luks-detached-header.rst b/docs/devel/luks-detach=
ed-header.rst
> new file mode 100644
> index 0000000000..15e9ccde1d
> --- /dev/null
> +++ b/docs/devel/luks-detached-header.rst
> @@ -0,0 +1,182 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +LUKS volume with detached header
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document gives an overview of the design of LUKS volume with detach=
ed
> +header and how to use it.
> +
> +Background
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The LUKS format has ability to store the header in a separate volume from
> +the payload. We could extend the LUKS driver in QEMU to support this use
> +case.
> +
> +Normally a LUKS volume has a layout:
> +
> +::
> +
> +         +-----------------------------------------------+
> +         |         |                |                    |
> + disk    | header  |  key material  |  disk payload data |
> +         |         |                |                    |
> +         +-----------------------------------------------+
> +
> +With a detached LUKS header, you need 2 disks so getting:
> +
> +::
> +
> +         +--------------------------+
> + disk1   |   header  | key material |
> +         +--------------------------+
> +         +---------------------+
> + disk2   |  disk payload data  |
> +         +---------------------+
> +
> +There are a variety of benefits to doing this:
> +
> + * Secrecy - the disk2 cannot be identified as containing LUKS
> +             volume since there's no header
> + * Control - if access to the disk1 is restricted, then even
> +             if someone has access to disk2 they can't unlock
> +             it. Might be useful if you have disks on NFS but
> +             want to restrict which host can launch a VM
> +             instance from it, by dynamically providing access
> +             to the header to a designated host
> + * Flexibility - your application data volume may be a given
> +                 size and it is inconvenient to resize it to
> +                 add encryption.You can store the LUKS header
> +                 separately and use the existing storage
> +                 volume for payload
> + * Recovery - corruption of a bit in the header may make the
> +              entire payload inaccessible. It might be
> +              convenient to take backups of the header. If
> +              your primary disk header becomes corrupt, you
> +              can unlock the data still by pointing to the
> +              backup detached header
> +
> +Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Take the qcow2 encryption, for example. The architecture of the
> +LUKS volume with detached header is shown in the diagram below.
> +
> +There are two children of the root node: a file and a header.
> +Data from the disk payload is stored in the file node. The
> +LUKS header and key material are located in the header node,
> +as previously mentioned.
> +
> +::
> +
> +                       +-----------------------------+
> +  Root node            |          foo[luks]          |
> +                       +-----------------------------+
> +                          |                       |
> +                     file |                header |
> +                          |                       |
> +               +---------------------+    +------------------+
> +  Child node   |payload-format[qcow2]|    |header-format[raw]|
> +               +---------------------+    +------------------+
> +                          |                       |
> +                     file |                 file  |
> +                          |                       |
> +               +----------------------+  +---------------------+
> +  Child node   |payload-protocol[file]|  |header-protocol[file]|
> +               +----------------------+  +---------------------+
> +                          |                       |
> +                          |                       |
> +                          |                       |
> +                     Host storage            Host storage
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +Create a LUKS disk with a detached header using qemu-img
> +--------------------------------------------------------
> +
> +Shell commandline::
> +
> +# qemu-img create --object secret,id=3Dsec0,data=3Dabc123 -f luks \
> +> -o cipher-alg=3Daes-256,cipher-mode=3Dxts -o key-secret=3Dsec0 \
> +> -o detached-header=3Dtrue test-header.img
> +# qemu-img create -f qcow2 test-payload.qcow2 200G
> +# qemu-img info 'json:{"driver":"luks","file":{"filename": \
> +> "test-payload.img"},"header":{"filename":"test-header.img"}}'
> +
> +Set up a VM's LUKS volume with a detached header
> +------------------------------------------------
> +
> +Qemu commandline::
> +
> +# qemu-system-x86_64 ... \
> +> -object '{"qom-type":"secret","id":"libvirt-3-format-secret", \
> +> "data":"abc123"}' \
> +> -blockdev '{"driver":"file","filename":"/path/to/test-header.img", \
> +> "node-name":"libvirt-1-storage"}' \
> +> -blockdev '{"node-name":"libvirt-1-format","read-only":false, \
> +> "driver":"raw","file":"libvirt-1-storage"}' \
> +> -blockdev '{"driver":"file","filename":"/path/to/test-payload.qcow2", \
> +> "node-name":"libvirt-2-storage"}' \
> +> -blockdev '{"node-name":"libvirt-2-format","read-only":false, \
> +> "driver":"qcow2","file":"libvirt-2-storage"}' \
> +> -blockdev '{"node-name":"libvirt-3-format","driver":"luks", \
> +> "file":"libvirt-2-format","header":"libvirt-1-format","key-secret": \
> +> "libvirt-3-format-secret"}' \
> +> -device '{"driver":"virtio-blk-pci","bus":XXX,"addr":YYY,"drive": \
> +> "libvirt-3-format","id":"virtio-disk1"}'
> +
> +Add LUKS volume to a VM with a detached header
> +----------------------------------------------
> +
> +1. object-add the secret for decrypting the cipher stored in
> +   LUKS header above::
> +
> +# virsh qemu-monitor-command vm '{"execute":"object-add", \
> +> "arguments":{"qom-type":"secret", "id": \
> +> "libvirt-4-format-secret", "data":"abc123"}}'
> +
> +2. block-add the protocol node for LUKS header::
> +
> +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> +> "arguments":{"node-name":"libvirt-1-storage", "driver":"file", \
> +> "filename": "/path/to/test-header.img" }}'
> +
> +3. block-add the raw-drived node for LUKS header::
> +
> +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> +> "arguments":{"node-name":"libvirt-1-format", "driver":"raw", \
> +> "file":"libvirt-1-storage"}}'
> +
> +4. block-add the protocol node for disk payload image::
> +
> +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> +> "arguments":{"node-name":"libvirt-2-storage", "driver":"file", \
> +> "filename":"/path/to/test-payload.qcow2"}}'
> +
> +5. block-add the qcow2-drived format node for disk payload data::
> +
> +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> +> "arguments":{"node-name":"libvirt-2-format", "driver":"qcow2", \
> +> "file":"libvirt-2-storage"}}'
> +
> +6. block-add the luks-drived format node to link the qcow2 disk
> +   with the LUKS header by specifying the field "header"::
> +
> +# virsh qemu-monitor-command vm '{"execute":"blockdev-add", \
> +> "arguments":{"node-name":"libvirt-3-format", "driver":"luks", \
> +> "file":"libvirt-2-format", "header":"libvirt-1-format", \
> +> "key-secret":"libvirt-2-format-secret"}}'
> +
> +7. hot-plug the virtio-blk device finally::
> +
> +# virsh qemu-monitor-command vm '{"execute":"device_add", \
> +> "arguments": {"driver":"virtio-blk-pci", \
> +> "drive": "libvirt-3-format", "id":"virtio-disk2"}}
> +
> +TODO
> +=3D=3D=3D=3D
> +
> +1. Support the shared detached LUKS header within the VM.


