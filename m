Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454E8C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCyQ-0003LK-AB; Thu, 07 Aug 2025 22:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukCyN-0003IN-H1
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:36:47 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ukCyI-0000y5-Ve
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:36:47 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6199bd724e1so468841eaf.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754620601; x=1755225401;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JE7NvxfkjniiwDWYShTrOno5NULn7IdA0Fmvwp1gD+Q=;
 b=McMQjd5qvlM6cZOi3nrtwzDd+5qp1gup8ZIFsy9+1F7RLYAhne9ocRQWBiCTJtDmVe
 NzpUudrul77zBEU7u3zBddL4+UJjgcxQqE9qRWKksXaryiSNw82vDEv/+ZtHr/Acx/rE
 DKBFCO62sW5u8S7axqgrjJ6+j7mKz/exJ1pfSz5G5OcigbtvZYFkzqEkVX1DXXJsbyPu
 OSDCa/w6RQCjGdSfi2XJjDSli1FFYvCMv0h8zuYQQdIPcavfOUz1RBNLCQRGpk35VX2S
 qiJixxZCHjFGhEygZHHLhDu4oNTY5quhqtFA56EyqDxEL+dIYaN6Cg+VUgznGEE+0k9v
 QXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754620601; x=1755225401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JE7NvxfkjniiwDWYShTrOno5NULn7IdA0Fmvwp1gD+Q=;
 b=a5RC4cRFisLglhh8vSXJuz3w0WjqOYcywi3uWpnKP+0qrMqamaoMXg6VVRHznT+f7z
 RkIhdwGD8MYnUndWZAVyYeR60y7VmE5ohI2wa212rIt24jD22Y11ySV1vGjgxGdKaObR
 G3XZ3af8AedG0v6/dcRMInAET2dqwBnJMHXjMszsB/OcRHmF+moP2iRwiODHZ+J9Ok+C
 j3T6X0jjdn273aJ7P6rayz0Gxyp4IO9ReK8ws2nzX1MLcnd49gWmhGyZ+3xTcCaOzgUQ
 8k7Ab+lTE9Nsqs2w699N0YPzna9n7ShRIao6Y0OPBGokU2OishxJUteL0y+vPgIHb/eo
 XTAw==
X-Gm-Message-State: AOJu0YzZRKht+LOkDbRGQiPND2UzVldhFeQ7Ce4vcwGjp25f07RQUzpk
 u2ZG9HT0usvaEAljI6tntxq8GvfoBf0VG9JSmEFToiLyB/9vP9/hzXPYiE03ictK3quO3/+TjcI
 2HOywSOi5VCt1w7Qgyx/a/636n0TwZoydtAABu2KtdQ==
X-Gm-Gg: ASbGncue8YHc6z19pZez+bMN4Xw44MF1Qqtb2+i60wx3DjmX418M545sNwuLlzvUU72
 0V3Zd+48Zg55V4eoA8Ey1XWx7NpZ/2JGFK6MaQF5odnG55t4kzGUP2cZS+3JIYoGJfRIssJGZpC
 afn0Ihx6gZzUcO/zdZPRIycvHVGMNzOpBwIGBSft6YwRMYdXtqYoHH/Ad787/wY+dUerBIESSXb
 k6JRIrNYg==
X-Google-Smtp-Source: AGHT+IGvcpmFRqWwutP/kvnGpKbGvsEdpKANM8E6RJ6OCP7bO4sdxufTgR/l92eDkNGD8YWjpeGdSaBeuzVdfqB77cs=
X-Received: by 2002:a05:6871:887:b0:30b:b37a:6bb6 with SMTP id
 586e51a60fabf-30c2118b332mr913615fac.28.1754620600535; Thu, 07 Aug 2025
 19:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
In-Reply-To: <20250807113639.66d1c5bf@penguin>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 8 Aug 2025 10:36:24 +0800
X-Gm-Features: Ac12FXxYkW0t_zSP2Yufxfw30WdSSO37caXHmfzaIkal8pqz5TkHDeu0OdF3bpk
Message-ID: <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000009c602d063bd1712b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, NUMERIC_HTTP_ADDR=1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009c602d063bd1712b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub <lukasstraub2@web.de> w=
rote:

> On Thu,  7 Aug 2025 10:41:17 +0800
> yong.huang@smartx.com wrote:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > When there are network issues like missing TCP ACKs on the send
> > side during the multifd live migration. At the send side, the error
> > "Connection timed out" is thrown out and source QEMU process stop
> > sending data, at the receive side, The IO-channels may be blocked
> > at recvmsg() and thus the main loop gets stuck and fails to respond
> > to QMP commands consequently.
> > ...
>
> Hi Hyman Huang,
>
> Have you tried the 'yank' command to shutdown the sockets? It exactly
> meant to recover from hangs and should solve your issue.
>
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-feature


Thanks for the comment and advice.

Let me give more details about the migration state when the issue happens:

On the source side, libvirt has already aborted the migration job:

$ virsh domjobinfo fdecd242-f278-4308-8c3b-46e144e55f63
Job type:         Failed
Operation:        Outgoing migration

QMP query-yank shows that there is no migration yank instance:

$ virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63
'{"execute":"query-yank"}' --pretty
{
  "return": [
    {
      "type": "chardev",
      "id": "charmonitor"
    },
    {
      "type": "chardev",
      "id": "charchannel0"
    },
    {
      "type": "chardev",
      "id": "libvirt-2-virtio-format"
    }
  ],
  "id": "libvirt-5217"
}

The libvirt migration job is stuck as the following backtrace shows; it
shows that migration is waiting for the "Finish" RPC on the destination
side to return.

#0  0x00007f4c93d086c9 in __GI___poll (fds=3D0x7f4c50000d20, nfds=3D2,
timeout=3D-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f4c93e99379 in ?? () from /lib64/libglib-2.0.so.0
#2  0x00007f4c93e996c2 in g_main_loop_run () from /lib64/libglib-2.0.so.0
#3  0x00007f4c94aac92a in virNetClientIOEventLoop
(client=3Dclient@entry=3D0x7f4c501a3ef0,
thiscall=3Dthiscall@entry=3D0x7f4c50052a90) at
../../src/rpc/virnetclient.c:1684
#4  0x00007f4c94aacf59 in virNetClientIO (thiscall=3D0x7f4c50052a90,
client=3D0x7f4c501a3ef0) at ../../src/rpc/virnetclient.c:1952
#5  virNetClientSendInternal (client=3Dclient@entry=3D0x7f4c501a3ef0,
msg=3Dmsg@entry=3D0x7f4c501a2150, expectReply=3DexpectReply@entry=3Dtrue,
nonBlock=3DnonBlock@entry=3Dfalse) at ../../src/rpc/virnetclient.c:2123
#6  0x00007f4c94aae793 in virNetClientSendWithReply
(client=3Dclient@entry=3D0x7f4c501a3ef0, msg=3Dmsg@entry=3D0x7f4c501a2150) =
at
../../src/rpc/virnetclient.c:2151
#7  0x00007f4c94aa9460 in virNetClientProgramCall
(prog=3Dprog@entry=3D0x7f4c50066870, client=3Dclient@entry=3D0x7f4c501a3ef0=
,
serial=3Dserial@entry=3D10, proc=3Dproc@entry=3D306, noutfds=3Dnoutfds@entr=
y=3D0,
    outfds=3Doutfds@entry=3D0x0, ninfds=3D0x0, infds=3D0x0,
args_filter=3D0x7f4c94af1290
<xdr_remote_domain_migrate_finish3_params_args>, args=3D0x7f4c8487e300,
    ret_filter=3D0x7f4c94af1310
<xdr_remote_domain_migrate_finish3_params_ret>, ret=3D0x7f4c8487e350) at
../../src/rpc/virnetclientprogram.c:324
#8  0x00007f4c94acb2e4 in callFull (priv=3Dpriv@entry=3D0x7f4c5004c800,
flags=3Dflags@entry=3D0, fdin=3Dfdin@entry=3D0x0, fdinlen=3Dfdinlen@entry=
=3D0,
fdout=3Dfdout@entry=3D0x0, fdoutlen=3Dfdoutlen@entry=3D0x0, proc_nr=3D306,
    args_filter=3D0x7f4c94af1290
<xdr_remote_domain_migrate_finish3_params_args>, args=3D0x7f4c8487e300
"\004", ret_filter=3D0x7f4c94af1310
<xdr_remote_domain_migrate_finish3_params_ret>,
    ret=3D0x7f4c8487e350 "", conn=3D0x7f4c5007c900) at
../../src/remote/remote_driver.c:6754
#9  0x00007f4c94ae20f8 in call (conn=3D0x7f4c5007c900,
ret=3D0x7f4c8487e350 "", ret_filter=3D<optimized out>, args=3D0x7f4c8487e30=
0
"\004", args_filter=3D<optimized out>, proc_nr=3D306, flags=3D0,
    priv=3D<optimized out>) at ../../src/remote/remote_driver.c:6776
#10 remoteDomainMigrateFinish3Params (dconn=3D0x7f4c5007c900,
params=3D<optimized out>, nparams=3D4, cookiein=3D0x0, cookieinlen=3D0,
cookieout=3D0x7f4c8487e4e0, cookieoutlen=3D0x7f4c8487e4b4, flags=3D131611,
    cancelled=3D1) at ../../src/remote/remote_driver.c:7362 // =E8=B0=83=E7=
=94=A8=E7=9B=AE=E7=9A=84=E7=AB=AF
Finish API =E7=9A=84 RPC=EF=BC=8C=E9=98=BB=E5=A1=9E=E7=AD=89=E5=BE=85=E5=85=
=B6=E6=89=A7=E8=A1=8C=E7=BB=93=E6=9E=9C
#11 0x00007f4c74d44600 in qemuMigrationSrcPerformPeer2Peer3
(flags=3D<optimized out>, useParams=3D<optimized out>, bandwidth=3D0,
migParams=3D0x7f4c5002b540, nbdPort=3D0, migrate_disks=3D<optimized out>,
    nmigrate_disks=3D0, listenAddress=3D<optimized out>, graphicsuri=3D0x0,
uri=3D<optimized out>, dname=3D0x0,
    persist_xml=3D0x7f4c5006f720 "<?xml version=3D\"1.0\"
encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
xmlin=3D<optimized out>, vm=3D0x7f4c38257de0, dconnuri=3D0x7f4c5000f840
"qemu+tls://172.16.170.52/system?no_verify=3D1", dconn=3D0x7f4c5007c900,
sconn=3D0x7f4c0000fb70,
    driver=3D0x7f4c3814e4b0) at ../../src/qemu/qemu_migration.c:4512
#12 qemuMigrationSrcPerformPeer2Peer (v3proto=3D<synthetic pointer>,
resource=3D0, dname=3D0x0, flags=3D<optimized out>,
migParams=3D0x7f4c5002b540, nbdPort=3D0, migrate_disks=3D<optimized out>,
nmigrate_disks=3D0,
    listenAddress=3D<optimized out>, graphicsuri=3D0x0, uri=3D<optimized
out>, dconnuri=3D0x7f4c5000f840
"qemu+tls://172.16.170.52/system?no_verify=3D1",
    persist_xml=3D0x7f4c5006f720 "<?xml version=3D\"1.0\"
encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
xmlin=3D<optimized out>, vm=3D0x7f4c38257de0, sconn=3D0x7f4c0000fb70,
driver=3D0x7f4c3814e4b0) at ../../src/qemu/qemu_migration.c:4767
#13 qemuMigrationSrcPerformJob (driver=3Ddriver@entry=3D0x7f4c3814e4b0,
conn=3Dconn@entry=3D0x7f4c0000fb70, vm=3Dvm@entry=3D0x7f4c38257de0,
    xmlin=3Dxmlin@entry=3D0x7f4c50026f80 "<?xml version=3D\"1.0\"
encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
    persist_xml=3Dpersist_xml@entry=3D0x7f4c5006f720 "<?xml
version=3D\"1.0\" encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
dconnuri=3D0x7f4c5000f840 "qemu+tls://172.16.170.52/system?no_verify=3D1",
uri=3D0x7f4c501a1430 "tcp://172.16.170.52", graphicsuri=3D0x0,
    listenAddress=3D0x0, nmigrate_disks=3D0, migrate_disks=3D0x0, nbdPort=
=3D0,
migParams=3D0x7f4c5002b540, cookiein=3D0x0, cookieinlen=3D0,
cookieout=3D0x7f4c8487e8c8, cookieoutlen=3D0x7f4c8487e8bc,
flags=3D1073885723,
    dname=3D0x0, resource=3D0, v3proto=3D<optimized out>) at
../../src/qemu/qemu_migration.c:4842
#14 0x00007f4c74d44c6c in qemuMigrationSrcPerform
(driver=3Ddriver@entry=3D0x7f4c3814e4b0, conn=3D0x7f4c0000fb70,
vm=3D0x7f4c38257de0,
    xmlin=3D0x7f4c50026f80 "<?xml version=3D\"1.0\"
encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
    persist_xml=3D0x7f4c5006f720 "<?xml version=3D\"1.0\"
encoding=3D\"utf-8\"?>\n<domain type=3D\"kvm\"
xmlns:qemu=3D\"http://libvirt.org/schemas/domain/qemu/1.0\"><name>5cdd670f-=
ac55-4820-a66e-b6e3985e1520</name><uuid>dd053ff0-5e12-44f5-9b97-1826715"...=
,
dconnuri=3Ddconnuri@entry=3D0x7f4c5000f840
"qemu+tls://172.16.170.52/system?no_verify=3D1", uri=3D0x7f4c501a1430
"tcp://172.16.170.52", graphicsuri=3D0x0,
    listenAddress=3D0x0, nmigrate_disks=3D0, migrate_disks=3D0x0, nbdPort=
=3D0,
migParams=3D0x7f4c5002b540, cookiein=3D0x0, cookieinlen=3D0,
cookieout=3D0x7f4c8487e8c8, cookieoutlen=3D0x7f4c8487e8bc,
flags=3D1073885723,
    dname=3D0x0, resource=3D0, v3proto=3Dtrue) at ../../src/qemu/qemu_migra=
tion.c:5030
#15 0x00007f4c74d769e0 in qemuDomainMigratePerform3Params
(dom=3D0x7f4c5019bfe0, dconnuri=3D0x7f4c5000f840
"qemu+tls://172.16.170.52/system?no_verify=3D1", params=3D<optimized out>,
nparams=3D<optimized out>,
    cookiein=3D0x0, cookieinlen=3D0, cookieout=3D0x7f4c8487e8c8,
cookieoutlen=3D0x7f4c8487e8bc, flags=3D1073885723) at
../../src/qemu/qemu_driver.c:12730
#16 0x00007f4c94b072e8 in virDomainMigratePerform3Params
(domain=3Ddomain@entry=3D0x7f4c5019bfe0, dconnuri=3D0x7f4c5000f840
"qemu+tls://172.16.170.52/system?no_verify=3D1", params=3D0x7f4c500926d0,
nparams=3D4,
    cookiein=3D0x0, cookieinlen=3D0, cookieout=3D0x7f4c8487e8c8,
cookieoutlen=3D0x7f4c8487e8bc, flags=3D1073885723) at
../../src/libvirt-domain.c:4989
#17 0x000055b881c3fb1e in remoteDispatchDomainMigratePerform3Params
(server=3D0x55b881dbba70, msg=3D0x55b881df23d0, ret=3D0x7f4c50054210,
args=3D0x7f4c5019ff10, rerr=3D0x7f4c8487e9c0, client=3D<optimized out>)
    at ../../src/remote/remote_daemon_dispatch.c:5736
#18 remoteDispatchDomainMigratePerform3ParamsHelper
(server=3D0x55b881dbba70, client=3D<optimized out>, msg=3D0x55b881df23d0,
rerr=3D0x7f4c8487e9c0, args=3D0x7f4c5019ff10, ret=3D0x7f4c50054210)
    at ./remote/remote_daemon_dispatch_stubs.h:8805
--Type <RET> for more, q to quit, c to continue without paging--
#19 0x00007f4c94aa242d in virNetServerProgramDispatchCall
(msg=3D0x55b881df23d0, client=3D0x55b881e0f740, server=3D0x55b881dbba70,
prog=3D0x55b881dc8750) at ../../src/rpc/virnetserverprogram.c:430
#20 virNetServerProgramDispatch (prog=3D0x55b881dc8750,
server=3Dserver@entry=3D0x55b881dbba70, client=3D0x55b881e0f740,
msg=3D0x55b881df23d0) at ../../src/rpc/virnetserverprogram.c:302
#21 0x00007f4c94aa73c2 in virNetServerProcessMsg (msg=3D<optimized out>,
prog=3D<optimized out>, client=3D<optimized out>, srv=3D0x55b881dbba70) at
../../src/rpc/virnetserver.c:137
#22 virNetServerHandleJob (jobOpaque=3D0x55b881de8140,
opaque=3D0x55b881dbba70) at ../../src/rpc/virnetserver.c:154
#23 0x00007f4c949bbf80 in virThreadPoolWorker (opaque=3D<optimized out>)
at ../../src/util/virthreadpool.c:163
#24 0x00007f4c949bb5b7 in virThreadHelper (data=3D<optimized out>) at
../../src/util/virthread.c:233
#25 0x00007f4c93dfbf1b in start_thread (arg=3D0x7f4c8487f700) at
pthread_create.c:486
#26 0x00007f4c93d131a0 in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:98


While at the destination side, Libvirt shows a "paused" VM:

$ virsh list
 Id   Name                                   State
-----------------------------------------------------
 31   fdecd242-f278-4308-8c3b-46e144e55f63   paused

Libvirt is stuck with the following backtrace. It means Libvirt is querying
the VM status by issuing the QMP "query-status" before killing the VM. The
piece of code is:

qemuMigrationDstFinish=EF=BC=9A
    if (retcode !=3D 0) {
        /* Check for a possible error on the monitor in case Finish was cal=
led
         * earlier than monitor EOF handler got a chance to process the err=
or
         */
        qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN);
        goto endjob;
    }

Thread 2 (Thread 0x7f1161c6c700 (LWP 3244)):
#0  0x00007f116f9eba0c in futex_wait_cancelable (private=3D<optimized
out>, expected=3D0, futex_word=3D0x7f1138068550) at
../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  __pthread_cond_wait_common (abstime=3D0x0, clockid=3D0,
mutex=3D0x7f1138068500, cond=3D0x7f1138068528) at pthread_cond_wait.c:508
#2  __pthread_cond_wait (cond=3Dcond@entry=3D0x7f1138068528,
mutex=3Dmutex@entry=3D0x7f1138068500) at pthread_cond_wait.c:638
#3  0x00007f11705a5476 in virCondWait (c=3Dc@entry=3D0x7f1138068528,
m=3Dm@entry=3D0x7f1138068500) at ../../src/util/virthread.c:148
#4  0x00007f116013fbfc in qemuMonitorSend
(mon=3Dmon@entry=3D0x7f11380684f0, msg=3Dmsg@entry=3D0x7f1161c6b600) at
../../src/qemu/qemu_monitor.c:953
#5  0x00007f116014fde5 in qemuMonitorJSONCommandWithFd
(mon=3Dmon@entry=3D0x7f11380684f0, cmd=3Dcmd@entry=3D0x7f115c0512e0,
scm_fd=3Dscm_fd@entry=3D-1, reply=3Dreply@entry=3D0x7f1161c6b680) at
../../src/qemu/qemu_monitor_json.c:358
#6  0x00007f1160152025 in qemuMonitorJSONCommand
(reply=3D0x7f1161c6b680, cmd=3D0x7f115c0512e0, mon=3D0x7f11380684f0) at
../../src/qemu/qemu_monitor_json.c:383
#7  qemuMonitorJSONGetStatus (mon=3D0x7f11380684f0,
running=3D0x7f1161c6b6c7, reason=3D0x0) at
../../src/qemu/qemu_monitor_json.c:1740
#8  0x00007f1160141a80 in qemuMonitorCheck (mon=3D<optimized out>) at
../../src/qemu/qemu_monitor.c:1633
#9  0x00007f11600f0d87 in qemuDomainCheckMonitor
(driver=3Ddriver@entry=3D0x7f11141273b0, vm=3Dvm@entry=3D0x7f1138135920,
asyncJob=3DasyncJob@entry=3DQEMU_ASYNC_JOB_MIGRATION_IN) at
../../src/qemu/qemu_domain.c:14393
#10 0x00007f1160133d18 in qemuMigrationDstFinish
(driver=3Ddriver@entry=3D0x7f11141273b0, dconn=3Ddconn@entry=3D0x7f11340120=
00,
vm=3D<optimized out>, cookiein=3Dcookiein@entry=3D0x0,
cookieinlen=3Dcookieinlen@entry=3D0,
cookieout=3Dcookieout@entry=3D0x7f1161c6b8f0, cookieoutlen=3D0x7f1161c6b8e4=
,
flags=3D131611, retcode=3D1, v3proto=3Dtrue) at
../../src/qemu/qemu_migration.c:5211
#11 0x00007f116016a436 in qemuDomainMigrateFinish3Params
(dconn=3D0x7f1134012000, params=3D0x7f115c05e9e0, nparams=3D4, cookiein=3D0=
x0,
cookieinlen=3D0, cookieout=3D0x7f1161c6b8f0, cookieoutlen=3D0x7f1161c6b8e4,
flags=3D131611, cancelled=3D1) at ../../src/qemu/qemu_driver.c:12827
#12 0x00007f11706f15bb in virDomainMigrateFinish3Params
(dconn=3D<optimized out>, params=3D0x7f115c05e9e0, nparams=3D4,
cookiein=3D0x0, cookieinlen=3D0, cookieout=3D0x7f1161c6b8f0,
cookieoutlen=3D0x7f1161c6b8e4, flags=3D131611, cancelled=3D1) at
../../src/libvirt-domain.c:5033
#13 0x000055ffa89cf8c0 in ?? ()
#14 0x00007f117068c42d in virNetServerProgramDispatchCall
(msg=3D0x55ffaa6a3ec0, client=3D0x55ffaa6b4840, server=3D0x55ffaa682030,
prog=3D0x55ffaa68f760) at ../../src/rpc/virnetserverprogram.c:430
#15 virNetServerProgramDispatch (prog=3D0x55ffaa68f760,
server=3Dserver@entry=3D0x55ffaa682030, client=3D0x55ffaa6b4840,
msg=3D0x55ffaa6a3ec0) at ../../src/rpc/virnetserverprogram.c:302
#16 0x00007f11706913c2 in virNetServerProcessMsg (msg=3D<optimized out>,
prog=3D<optimized out>, client=3D<optimized out>, srv=3D0x55ffaa682030) at
../../src/rpc/virnetserver.c:137
#17 virNetServerHandleJob (jobOpaque=3D0x55ffaa669af0,
opaque=3D0x55ffaa682030) at ../../src/rpc/virnetserver.c:154
#18 0x00007f11705a5f80 in virThreadPoolWorker (opaque=3D<optimized out>)
at ../../src/util/virthreadpool.c:163
#19 0x00007f11705a55b7 in virThreadHelper (data=3D<optimized out>) at
../../src/util/virthread.c:233
#20 0x00007f116f9e5f1b in start_thread (arg=3D0x7f1161c6c700) at
pthread_create.c:486
#21 0x00007f116f8fd1a0 in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:98
Thread 1 (Thread 0x7f116e9a1580 (LWP 2925)):
#0  0x00007f116f8f26c9 in __GI___poll (fds=3D0x55ffaa65f130, nfds=3D14,
timeout=3D4982) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f116fa83379 in ?? () from /lib64/libglib-2.0.so.0
#2  0x00007f116fa8348c in g_main_context_iteration () from
/lib64/libglib-2.0.so.0
#3  0x00007f117054cdc0 in virEventGLibRunOnce () at
../../src/util/vireventglib.c:533
#4  0x00007f117054c085 in virEventRunDefaultImpl () at
../../src/util/virevent.c:344
#5  0x00007f1170690bcd in virNetDaemonRun (dmn=3D0x55ffaa680d60) at
../../src/rpc/virnetdaemon.c:852
#6  0x000055ffa89c03bc in ?? ()
#7  0x00007f116f82ab27 in __libc_start_main (main=3D0x55ffa89be930,
argc=3D2, argv=3D0x7ffe19beea78, init=3D<optimized out>, fini=3D<optimized
out>, rtld_fini=3D<optimized out>, stack_end=3D0x7ffe19beea68) at
../csu/libc-start.c:308
#8  0x000055ffa89c06ba in ?? ()

IMHO, the key reason for the issue is that QEMU fails to run the main loop
and fails to respond to QMP, which is not what we usually expected.

Giving the Libvirt a window of time to issue a QMP and kill the VM is the
ideal solution for this issue; this provides an automatic method.

I do not dig the yank feature, perhaps it is helpful, but only manually?

After all, these two options are not exclusive of one another,  I think.


>
> Best regards,
> Lukas Straub
>

Thanks,
Yong

--=20
Best regards

--0000000000009c602d063bd1712b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Aug 7, 2025 at 5:36=E2=80=AFPM Lukas Straub &lt;<a href=3D"mail=
to:lukasstraub2@web.de">lukasstraub2@web.de</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">On Thu,=C2=A0 7 Aug 2025 10:41:17 +0800<br>
<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smart=
x.com</a> wrote:<br>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; When there are network issues like missing TCP ACKs on the send<br>
&gt; side=C2=A0during the multifd live migration. At the send side, the err=
or<br>
&gt; &quot;Connection timed out&quot; is thrown out and source QEMU process=
 stop<br>
&gt; sending data, at the receive side, The IO-channels may be blocked<br>
&gt; at recvmsg() and thus the=C2=A0main loop gets stuck and fails to respo=
nd<br>
&gt; to QMP commands consequently.<br>
&gt; ...<br>
<br>
Hi Hyman Huang,<br>
<br>
Have you tried the &#39;yank&#39; command to shutdown the sockets? It exact=
ly<br>
meant to recover from hangs and should solve your issue.<br>
<br>
<a href=3D"https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#yank-=
feature" rel=3D"noreferrer" target=3D"_blank">https://www.qemu.org/docs/mas=
ter/interop/qemu-qmp-ref.html#yank-feature</a></blockquote><div><br></div><=
div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gma=
il_default"><span style=3D"color:rgb(0,0,0)">Thanks for the comment and adv=
ice.</span><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default"><p style=3D"color:rgb(0,0,0)">Let me give=
 more details about the migration state when the issue happens:</p><p style=
=3D"color:rgb(0,0,0)">On the source side, libvirt has already aborted the m=
igration job:</p></div><div style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">$ virsh domjobin=
fo fdecd242-f278-4308-8c3b-46e144e55f63<br>Job type: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Failed<br>Operation: =C2=A0 =C2=A0 =C2=A0 =C2=A0Outgoing migration<b=
r></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cla=
ss=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default">QMP query-yank shows that there=
 is no migration yank instance:</div><div style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">$ =
virsh qemu-monitor-command fdecd242-f278-4308-8c3b-46e144e55f63 &#39;{&quot=
;execute&quot;:&quot;query-yank&quot;}&#39; --pretty<br>{<br>=C2=A0 &quot;r=
eturn&quot;: [<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 &quot;type&quot;:=
 &quot;chardev&quot;,<br>=C2=A0 =C2=A0 =C2=A0 &quot;id&quot;: &quot;charmon=
itor&quot;<br>=C2=A0 =C2=A0 },<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 &=
quot;type&quot;: &quot;chardev&quot;,<br>=C2=A0 =C2=A0 =C2=A0 &quot;id&quot=
;: &quot;charchannel0&quot;<br>=C2=A0 =C2=A0 },<br>=C2=A0 =C2=A0 {<br>=C2=
=A0 =C2=A0 =C2=A0 &quot;type&quot;: &quot;chardev&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0 &quot;id&quot;: &quot;libvirt-2-virtio-format&quot;<br>=C2=A0 =C2=A0=
 }<br>=C2=A0 ],<br>=C2=A0 &quot;id&quot;: &quot;libvirt-5217&quot;<br>}<br>=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default"><br></div><div class=3D"gmail_default"><span style=3D"co=
lor:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">The libvirt migrat=
ion job is stuck as the following backtrace shows; it shows that migration =
is waiting for the &quot;Finish&quot; RPC on the destination side to return=
.</font></span></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><pre style=3D"box-=
sizing:border-box;font-size:13.6px;font-family:SFMono-Regular,Consolas,&quo=
t;Liberation Mono&quot;,Menlo,monospace;margin-top:0px;margin-bottom:16px;o=
verflow:auto;padding:16px;line-height:1.45;background-color:rgb(246,248,250=
);border-radius:3px;color:rgb(36,41,46)"><code style=3D"box-sizing:border-b=
ox;font-size:12.92px;font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,monospace;padding:0px;margin:0px;border-radius:3px;backgrou=
nd-image:none;background-position:0% 0%;background-size:auto;background-rep=
eat:repeat;background-origin:padding-box;background-clip:border-box;word-br=
eak:normal;border:0px;display:inline;overflow:visible;line-height:inherit;c=
olor:rgba(0,0,0,0.65);white-space:pre-wrap">#0  0x00007f4c93d086c9 in __GI_=
__poll (fds=3D0x7f4c50000d20, nfds=3D2, timeout=3D-1) at ../sysdeps/unix/sy=
sv/linux/poll.c:29
#1  0x00007f4c93e99379 in ?? () from /lib64/libglib-2.0.so.0
#2  0x00007f4c93e996c2 in g_main_loop_run () from /lib64/libglib-2.0.so.0
#3  0x00007f4c94aac92a in virNetClientIOEventLoop (client=3Dclient@entry=3D=
0x7f4c501a3ef0, thiscall=3Dthiscall@entry=3D0x7f4c50052a90) at ../../src/rp=
c/virnetclient.c:1684
#4  0x00007f4c94aacf59 in virNetClientIO (thiscall=3D0x7f4c50052a90, client=
=3D0x7f4c501a3ef0) at ../../src/rpc/virnetclient.c:1952
#5  virNetClientSendInternal (client=3Dclient@entry=3D0x7f4c501a3ef0, msg=
=3Dmsg@entry=3D0x7f4c501a2150, expectReply=3DexpectReply@entry=3Dtrue, nonB=
lock=3DnonBlock@entry=3Dfalse) at ../../src/rpc/virnetclient.c:2123
#6  0x00007f4c94aae793 in virNetClientSendWithReply (client=3Dclient@entry=
=3D0x7f4c501a3ef0, msg=3Dmsg@entry=3D0x7f4c501a2150) at ../../src/rpc/virne=
tclient.c:2151
#7  0x00007f4c94aa9460 in virNetClientProgramCall (prog=3Dprog@entry=3D0x7f=
4c50066870, client=3Dclient@entry=3D0x7f4c501a3ef0, serial=3Dserial@entry=
=3D10, proc=3Dproc@entry=3D306, noutfds=3Dnoutfds@entry=3D0,
    outfds=3Doutfds@entry=3D0x0, ninfds=3D0x0, infds=3D0x0, args_filter=3D0=
x7f4c94af1290 &lt;xdr_remote_domain_migrate_finish3_params_args&gt;, args=
=3D0x7f4c8487e300,
    ret_filter=3D0x7f4c94af1310 &lt;xdr_remote_domain_migrate_finish3_param=
s_ret&gt;, ret=3D0x7f4c8487e350) at ../../src/rpc/virnetclientprogram.c:324
#8  0x00007f4c94acb2e4 in callFull (priv=3Dpriv@entry=3D0x7f4c5004c800, fla=
gs=3Dflags@entry=3D0, fdin=3Dfdin@entry=3D0x0, fdinlen=3Dfdinlen@entry=3D0,=
 fdout=3Dfdout@entry=3D0x0, fdoutlen=3Dfdoutlen@entry=3D0x0, proc_nr=3D306,
    args_filter=3D0x7f4c94af1290 &lt;xdr_remote_domain_migrate_finish3_para=
ms_args&gt;, args=3D0x7f4c8487e300 &quot;\004&quot;, ret_filter=3D0x7f4c94a=
f1310 &lt;xdr_remote_domain_migrate_finish3_params_ret&gt;,
    ret=3D0x7f4c8487e350 &quot;&quot;, conn=3D0x7f4c5007c900) at ../../src/=
remote/remote_driver.c:6754
#9  0x00007f4c94ae20f8 in call (conn=3D0x7f4c5007c900, ret=3D0x7f4c8487e350=
 &quot;&quot;, ret_filter=3D&lt;optimized out&gt;, args=3D0x7f4c8487e300 &q=
uot;\004&quot;, args_filter=3D&lt;optimized out&gt;, proc_nr=3D306, flags=
=3D0,
    priv=3D&lt;optimized out&gt;) at ../../src/remote/remote_driver.c:6776
#10 remoteDomainMigrateFinish3Params (dconn=3D0x7f4c5007c900, params=3D&lt;=
optimized out&gt;, nparams=3D4, cookiein=3D0x0, cookieinlen=3D0, cookieout=
=3D0x7f4c8487e4e0, cookieoutlen=3D0x7f4c8487e4b4, flags=3D131611,
    cancelled=3D1) at ../../src/remote/remote_driver.c:7362 // =E8=B0=83=E7=
=94=A8=E7=9B=AE=E7=9A=84=E7=AB=AF Finish API =E7=9A=84 RPC=EF=BC=8C=E9=98=
=BB=E5=A1=9E=E7=AD=89=E5=BE=85=E5=85=B6=E6=89=A7=E8=A1=8C=E7=BB=93=E6=9E=9C=
=20
#11 0x00007f4c74d44600 in qemuMigrationSrcPerformPeer2Peer3 (flags=3D&lt;op=
timized out&gt;, useParams=3D&lt;optimized out&gt;, bandwidth=3D0, migParam=
s=3D0x7f4c5002b540, nbdPort=3D0, migrate_disks=3D&lt;optimized out&gt;,
    nmigrate_disks=3D0, listenAddress=3D&lt;optimized out&gt;, graphicsuri=
=3D0x0, uri=3D&lt;optimized out&gt;, dname=3D0x0,
    persist_xml=3D0x7f4c5006f720 &quot;&lt;?xml version=3D\&quot;1.0\&quot;=
 encoding=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=3D\&quot;kvm\&quot; x=
mlns:qemu=3D\&quot;<a href=3D"http://libvirt.org/schemas/domain/qemu/1.0\">=
http://libvirt.org/schemas/domain/qemu/1.0\</a>&quot;&gt;&lt;name&gt;5cdd67=
0f-ac55-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&gt;dd053ff0-5e12-44f5-9=
b97-1826715&quot;..., xmlin=3D&lt;optimized out&gt;, vm=3D0x7f4c38257de0, d=
connuri=3D0x7f4c5000f840 &quot;qemu+tls://<a href=3D"http://172.16.170.52/s=
ystem?no_verify=3D1">172.16.170.52/system?no_verify=3D1</a>&quot;, dconn=3D=
0x7f4c5007c900, sconn=3D0x7f4c0000fb70,
    driver=3D0x7f4c3814e4b0) at ../../src/qemu/qemu_migration.c:4512
#12 qemuMigrationSrcPerformPeer2Peer (v3proto=3D&lt;synthetic pointer&gt;, =
resource=3D0, dname=3D0x0, flags=3D&lt;optimized out&gt;, migParams=3D0x7f4=
c5002b540, nbdPort=3D0, migrate_disks=3D&lt;optimized out&gt;, nmigrate_dis=
ks=3D0,
    listenAddress=3D&lt;optimized out&gt;, graphicsuri=3D0x0, uri=3D&lt;opt=
imized out&gt;, dconnuri=3D0x7f4c5000f840 &quot;qemu+tls://<a href=3D"http:=
//172.16.170.52/system?no_verify=3D1">172.16.170.52/system?no_verify=3D1</a=
>&quot;,
    persist_xml=3D0x7f4c5006f720 &quot;&lt;?xml version=3D\&quot;1.0\&quot;=
 encoding=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=3D\&quot;kvm\&quot; x=
mlns:qemu=3D\&quot;<a href=3D"http://libvirt.org/schemas/domain/qemu/1.0\">=
http://libvirt.org/schemas/domain/qemu/1.0\</a>&quot;&gt;&lt;name&gt;5cdd67=
0f-ac55-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&gt;dd053ff0-5e12-44f5-9=
b97-1826715&quot;..., xmlin=3D&lt;optimized out&gt;, vm=3D0x7f4c38257de0, s=
conn=3D0x7f4c0000fb70, driver=3D0x7f4c3814e4b0) at ../../src/qemu/qemu_migr=
ation.c:4767
#13 qemuMigrationSrcPerformJob (driver=3Ddriver@entry=3D0x7f4c3814e4b0, con=
n=3Dconn@entry=3D0x7f4c0000fb70, vm=3Dvm@entry=3D0x7f4c38257de0,
    xmlin=3Dxmlin@entry=3D0x7f4c50026f80 &quot;&lt;?xml version=3D\&quot;1.=
0\&quot; encoding=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=3D\&quot;kvm\=
&quot; xmlns:qemu=3D\&quot;<a href=3D"http://libvirt.org/schemas/domain/qem=
u/1.0\">http://libvirt.org/schemas/domain/qemu/1.0\</a>&quot;&gt;&lt;name&g=
t;5cdd670f-ac55-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&gt;dd053ff0-5e1=
2-44f5-9b97-1826715&quot;...,
    persist_xml=3Dpersist_xml@entry=3D0x7f4c5006f720 &quot;&lt;?xml version=
=3D\&quot;1.0\&quot; encoding=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=
=3D\&quot;kvm\&quot; xmlns:qemu=3D\&quot;<a href=3D"http://libvirt.org/sche=
mas/domain/qemu/1.0\">http://libvirt.org/schemas/domain/qemu/1.0\</a>&quot;=
&gt;&lt;name&gt;5cdd670f-ac55-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&g=
t;dd053ff0-5e12-44f5-9b97-1826715&quot;..., dconnuri=3D0x7f4c5000f840 &quot=
;qemu+tls://<a href=3D"http://172.16.170.52/system?no_verify=3D1">172.16.17=
0.52/system?no_verify=3D1</a>&quot;, uri=3D0x7f4c501a1430 &quot;tcp://<a hr=
ef=3D"http://172.16.170.52">172.16.170.52</a>&quot;, graphicsuri=3D0x0,
    listenAddress=3D0x0, nmigrate_disks=3D0, migrate_disks=3D0x0, nbdPort=
=3D0, migParams=3D0x7f4c5002b540, cookiein=3D0x0, cookieinlen=3D0, cookieou=
t=3D0x7f4c8487e8c8, cookieoutlen=3D0x7f4c8487e8bc, flags=3D1073885723,
    dname=3D0x0, resource=3D0, v3proto=3D&lt;optimized out&gt;) at ../../sr=
c/qemu/qemu_migration.c:4842
#14 0x00007f4c74d44c6c in qemuMigrationSrcPerform (driver=3Ddriver@entry=3D=
0x7f4c3814e4b0, conn=3D0x7f4c0000fb70, vm=3D0x7f4c38257de0,
    xmlin=3D0x7f4c50026f80 &quot;&lt;?xml version=3D\&quot;1.0\&quot; encod=
ing=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=3D\&quot;kvm\&quot; xmlns:q=
emu=3D\&quot;<a href=3D"http://libvirt.org/schemas/domain/qemu/1.0\">http:/=
/libvirt.org/schemas/domain/qemu/1.0\</a>&quot;&gt;&lt;name&gt;5cdd670f-ac5=
5-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&gt;dd053ff0-5e12-44f5-9b97-18=
26715&quot;...,
    persist_xml=3D0x7f4c5006f720 &quot;&lt;?xml version=3D\&quot;1.0\&quot;=
 encoding=3D\&quot;utf-8\&quot;?&gt;\n&lt;domain type=3D\&quot;kvm\&quot; x=
mlns:qemu=3D\&quot;<a href=3D"http://libvirt.org/schemas/domain/qemu/1.0\">=
http://libvirt.org/schemas/domain/qemu/1.0\</a>&quot;&gt;&lt;name&gt;5cdd67=
0f-ac55-4820-a66e-b6e3985e1520&lt;/name&gt;&lt;uuid&gt;dd053ff0-5e12-44f5-9=
b97-1826715&quot;..., dconnuri=3Ddconnuri@entry=3D0x7f4c5000f840 &quot;qemu=
+tls://<a href=3D"http://172.16.170.52/system?no_verify=3D1">172.16.170.52/=
system?no_verify=3D1</a>&quot;, uri=3D0x7f4c501a1430 &quot;tcp://<a href=3D=
"http://172.16.170.52">172.16.170.52</a>&quot;, graphicsuri=3D0x0,
    listenAddress=3D0x0, nmigrate_disks=3D0, migrate_disks=3D0x0, nbdPort=
=3D0, migParams=3D0x7f4c5002b540, cookiein=3D0x0, cookieinlen=3D0, cookieou=
t=3D0x7f4c8487e8c8, cookieoutlen=3D0x7f4c8487e8bc, flags=3D1073885723,
    dname=3D0x0, resource=3D0, v3proto=3Dtrue) at ../../src/qemu/qemu_migra=
tion.c:5030
#15 0x00007f4c74d769e0 in qemuDomainMigratePerform3Params (dom=3D0x7f4c5019=
bfe0, dconnuri=3D0x7f4c5000f840 &quot;qemu+tls://<a href=3D"http://172.16.1=
70.52/system?no_verify=3D1">172.16.170.52/system?no_verify=3D1</a>&quot;, p=
arams=3D&lt;optimized out&gt;, nparams=3D&lt;optimized out&gt;,
    cookiein=3D0x0, cookieinlen=3D0, cookieout=3D0x7f4c8487e8c8, cookieoutl=
en=3D0x7f4c8487e8bc, flags=3D1073885723) at ../../src/qemu/qemu_driver.c:12=
730
#16 0x00007f4c94b072e8 in virDomainMigratePerform3Params (domain=3Ddomain@e=
ntry=3D0x7f4c5019bfe0, dconnuri=3D0x7f4c5000f840 &quot;qemu+tls://<a href=
=3D"http://172.16.170.52/system?no_verify=3D1">172.16.170.52/system?no_veri=
fy=3D1</a>&quot;, params=3D0x7f4c500926d0, nparams=3D4,
    cookiein=3D0x0, cookieinlen=3D0, cookieout=3D0x7f4c8487e8c8, cookieoutl=
en=3D0x7f4c8487e8bc, flags=3D1073885723) at ../../src/libvirt-domain.c:4989
#17 0x000055b881c3fb1e in remoteDispatchDomainMigratePerform3Params (server=
=3D0x55b881dbba70, msg=3D0x55b881df23d0, ret=3D0x7f4c50054210, args=3D0x7f4=
c5019ff10, rerr=3D0x7f4c8487e9c0, client=3D&lt;optimized out&gt;)
    at ../../src/remote/remote_daemon_dispatch.c:5736
#18 remoteDispatchDomainMigratePerform3ParamsHelper (server=3D0x55b881dbba7=
0, client=3D&lt;optimized out&gt;, msg=3D0x55b881df23d0, rerr=3D0x7f4c8487e=
9c0, args=3D0x7f4c5019ff10, ret=3D0x7f4c50054210)
    at ./remote/remote_daemon_dispatch_stubs.h:8805
--Type &lt;RET&gt; for more, q to quit, c to continue without paging--
#19 0x00007f4c94aa242d in virNetServerProgramDispatchCall (msg=3D0x55b881df=
23d0, client=3D0x55b881e0f740, server=3D0x55b881dbba70, prog=3D0x55b881dc87=
50) at ../../src/rpc/virnetserverprogram.c:430
#20 virNetServerProgramDispatch (prog=3D0x55b881dc8750, server=3Dserver@ent=
ry=3D0x55b881dbba70, client=3D0x55b881e0f740, msg=3D0x55b881df23d0) at ../.=
./src/rpc/virnetserverprogram.c:302
#21 0x00007f4c94aa73c2 in virNetServerProcessMsg (msg=3D&lt;optimized out&g=
t;, prog=3D&lt;optimized out&gt;, client=3D&lt;optimized out&gt;, srv=3D0x5=
5b881dbba70) at ../../src/rpc/virnetserver.c:137
#22 virNetServerHandleJob (jobOpaque=3D0x55b881de8140, opaque=3D0x55b881dbb=
a70) at ../../src/rpc/virnetserver.c:154
#23 0x00007f4c949bbf80 in virThreadPoolWorker (opaque=3D&lt;optimized out&g=
t;) at ../../src/util/virthreadpool.c:163
#24 0x00007f4c949bb5b7 in virThreadHelper (data=3D&lt;optimized out&gt;) at=
 ../../src/util/virthread.c:233
#25 0x00007f4c93dfbf1b in start_thread (arg=3D0x7f4c8487f700) at pthread_cr=
eate.c:486
#26 0x00007f4c93d131a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:98</code></pre></div><div style=3D"font-family:&quot;comic sans ms&quo=
t;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">While at the =
destination side, Libvirt shows a &quot;paused&quot; VM:</div><div style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">=
<br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default">$ virsh list<br>=C2=A0Id =C2=A0 Name =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 State<br>----------------------------------=
-------------------<br>=C2=A031 =C2=A0 fdecd242-f278-4308-8c3b-46e144e55f63=
 =C2=A0 paused<br></div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default"><br></div><div class=3D"gmail_default"=
><span style=3D"color:rgb(0,0,0)"><font face=3D"comic sans ms, sans-serif">=
Libvirt is stuck with the following backtrace. It means Libvirt is querying=
 the VM status by issuing the QMP &quot;query-status&quot; before killing t=
he VM. The piece of code is:</font></span></div><div style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_=
default"><pre style=3D"box-sizing:border-box;font-size:13.6px;font-family:S=
FMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;margin-t=
op:0px;margin-bottom:16px;overflow:auto;padding:16px;line-height:1.45;backg=
round-color:rgb(246,248,250);border-radius:3px;color:rgb(36,41,46)"><code s=
tyle=3D"box-sizing:border-box;font-size:12.92px;font-family:SFMono-Regular,=
Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;padding:0px;margin:0px=
;border-radius:3px;background-image:none;background-position:0% 0%;backgrou=
nd-size:auto;background-repeat:repeat;background-origin:padding-box;backgro=
und-clip:border-box;word-break:normal;border:0px;display:inline;overflow:vi=
sible;line-height:inherit;color:rgba(0,0,0,0.65);white-space:pre-wrap">qemu=
MigrationDstFinish=EF=BC=9A
    if (retcode !=3D 0) {
        /* Check for a possible error on the monitor in case Finish was cal=
led
         * earlier than monitor EOF handler got a chance to process the err=
or
         */
        qemuDomainCheckMonitor(driver, vm, QEMU_ASYNC_JOB_MIGRATION_IN);
        goto endjob;
    }</code></pre><pre style=3D"box-sizing:border-box;font-size:13.6px;font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace=
;margin-top:0px;margin-bottom:16px;overflow:auto;padding:16px;line-height:1=
.45;background-color:rgb(246,248,250);border-radius:3px;color:rgb(36,41,46)=
"><code style=3D"box-sizing:border-box;font-size:12.92px;font-family:SFMono=
-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;padding:0px;m=
argin:0px;border-radius:3px;background-image:none;background-position:0% 0%=
;background-size:auto;background-repeat:repeat;background-origin:padding-bo=
x;background-clip:border-box;word-break:normal;border:0px;display:inline;ov=
erflow:visible;line-height:inherit;color:rgba(0,0,0,0.65);white-space:pre-w=
rap">Thread 2 (Thread 0x7f1161c6c700 (LWP 3244)):<br>#0 =C2=A00x00007f116f9=
eba0c in futex_wait_cancelable (private=3D&lt;optimized out&gt;, expected=
=3D0, futex_word=3D0x7f1138068550) at ../sysdeps/unix/sysv/linux/futex-inte=
rnal.h:88<br>#1 =C2=A0__pthread_cond_wait_common (abstime=3D0x0, clockid=3D=
0, mutex=3D0x7f1138068500, cond=3D0x7f1138068528) at pthread_cond_wait.c:50=
8<br>#2 =C2=A0__pthread_cond_wait (cond=3Dcond@entry=3D0x7f1138068528, mute=
x=3Dmutex@entry=3D0x7f1138068500) at pthread_cond_wait.c:638<br>#3 =C2=A00x=
00007f11705a5476 in virCondWait (c=3Dc@entry=3D0x7f1138068528, m=3Dm@entry=
=3D0x7f1138068500) at ../../src/util/virthread.c:148<br>#4 =C2=A00x00007f11=
6013fbfc in qemuMonitorSend (mon=3Dmon@entry=3D0x7f11380684f0, msg=3Dmsg@en=
try=3D0x7f1161c6b600) at ../../src/qemu/qemu_monitor.c:953<br>#5 =C2=A00x00=
007f116014fde5 in qemuMonitorJSONCommandWithFd (mon=3Dmon@entry=3D0x7f11380=
684f0, cmd=3Dcmd@entry=3D0x7f115c0512e0, scm_fd=3Dscm_fd@entry=3D-1, reply=
=3Dreply@entry=3D0x7f1161c6b680) at ../../src/qemu/qemu_monitor_json.c:358<=
br>#6 =C2=A00x00007f1160152025 in qemuMonitorJSONCommand (reply=3D0x7f1161c=
6b680, cmd=3D0x7f115c0512e0, mon=3D0x7f11380684f0) at ../../src/qemu/qemu_m=
onitor_json.c:383<br>#7 =C2=A0qemuMonitorJSONGetStatus (mon=3D0x7f11380684f=
0, running=3D0x7f1161c6b6c7, reason=3D0x0) at ../../src/qemu/qemu_monitor_j=
son.c:1740<br>#8 =C2=A00x00007f1160141a80 in qemuMonitorCheck (mon=3D&lt;op=
timized out&gt;) at ../../src/qemu/qemu_monitor.c:1633<br>#9 =C2=A00x00007f=
11600f0d87 in qemuDomainCheckMonitor (driver=3Ddriver@entry=3D0x7f11141273b=
0, vm=3Dvm@entry=3D0x7f1138135920, asyncJob=3DasyncJob@entry=3DQEMU_ASYNC_J=
OB_MIGRATION_IN) at ../../src/qemu/qemu_domain.c:14393<br>#10 0x00007f11601=
33d18 in qemuMigrationDstFinish (driver=3Ddriver@entry=3D0x7f11141273b0, dc=
onn=3Ddconn@entry=3D0x7f1134012000, vm=3D&lt;optimized out&gt;, cookiein=3D=
cookiein@entry=3D0x0, cookieinlen=3Dcookieinlen@entry=3D0, cookieout=3Dcook=
ieout@entry=3D0x7f1161c6b8f0, cookieoutlen=3D0x7f1161c6b8e4, flags=3D131611=
, retcode=3D1, v3proto=3Dtrue) at ../../src/qemu/qemu_migration.c:5211<br>#=
11 0x00007f116016a436 in qemuDomainMigrateFinish3Params (dconn=3D0x7f113401=
2000, params=3D0x7f115c05e9e0, nparams=3D4, cookiein=3D0x0, cookieinlen=3D0=
, cookieout=3D0x7f1161c6b8f0, cookieoutlen=3D0x7f1161c6b8e4, flags=3D131611=
, cancelled=3D1) at ../../src/qemu/qemu_driver.c:12827<br>#12 0x00007f11706=
f15bb in virDomainMigrateFinish3Params (dconn=3D&lt;optimized out&gt;, para=
ms=3D0x7f115c05e9e0, nparams=3D4, cookiein=3D0x0, cookieinlen=3D0, cookieou=
t=3D0x7f1161c6b8f0, cookieoutlen=3D0x7f1161c6b8e4, flags=3D131611, cancelle=
d=3D1) at ../../src/libvirt-domain.c:5033<br>#13 0x000055ffa89cf8c0 in ?? (=
)<br>#14 0x00007f117068c42d in virNetServerProgramDispatchCall (msg=3D0x55f=
faa6a3ec0, client=3D0x55ffaa6b4840, server=3D0x55ffaa682030, prog=3D0x55ffa=
a68f760) at ../../src/rpc/virnetserverprogram.c:430<br>#15 virNetServerProg=
ramDispatch (prog=3D0x55ffaa68f760, server=3Dserver@entry=3D0x55ffaa682030,=
 client=3D0x55ffaa6b4840, msg=3D0x55ffaa6a3ec0) at ../../src/rpc/virnetserv=
erprogram.c:302<br>#16 0x00007f11706913c2 in virNetServerProcessMsg (msg=3D=
&lt;optimized out&gt;, prog=3D&lt;optimized out&gt;, client=3D&lt;optimized=
 out&gt;, srv=3D0x55ffaa682030) at ../../src/rpc/virnetserver.c:137<br>#17 =
virNetServerHandleJob (jobOpaque=3D0x55ffaa669af0, opaque=3D0x55ffaa682030)=
 at ../../src/rpc/virnetserver.c:154<br>#18 0x00007f11705a5f80 in virThread=
PoolWorker (opaque=3D&lt;optimized out&gt;) at ../../src/util/virthreadpool=
.c:163<br>#19 0x00007f11705a55b7 in virThreadHelper (data=3D&lt;optimized o=
ut&gt;) at ../../src/util/virthread.c:233<br>#20 0x00007f116f9e5f1b in star=
t_thread (arg=3D0x7f1161c6c700) at pthread_create.c:486<br>#21 0x00007f116f=
8fd1a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:98<br>Threa=
d 1 (Thread 0x7f116e9a1580 (LWP 2925)):<br>#0 =C2=A00x00007f116f8f26c9 in _=
_GI___poll (fds=3D0x55ffaa65f130, nfds=3D14, timeout=3D4982) at ../sysdeps/=
unix/sysv/linux/poll.c:29<br>#1 =C2=A00x00007f116fa83379 in ?? () from /lib=
64/libglib-2.0.so.0<br>#2 =C2=A00x00007f116fa8348c in g_main_context_iterat=
ion () from /lib64/libglib-2.0.so.0<br>#3 =C2=A00x00007f117054cdc0 in virEv=
entGLibRunOnce () at ../../src/util/vireventglib.c:533<br>#4 =C2=A00x00007f=
117054c085 in virEventRunDefaultImpl () at ../../src/util/virevent.c:344<br=
>#5 =C2=A00x00007f1170690bcd in virNetDaemonRun (dmn=3D0x55ffaa680d60) at .=
./../src/rpc/virnetdaemon.c:852<br>#6 =C2=A00x000055ffa89c03bc in ?? ()<br>=
#7 =C2=A00x00007f116f82ab27 in __libc_start_main (main=3D0x55ffa89be930, ar=
gc=3D2, argv=3D0x7ffe19beea78, init=3D&lt;optimized out&gt;, fini=3D&lt;opt=
imized out&gt;, rtld_fini=3D&lt;optimized out&gt;, stack_end=3D0x7ffe19beea=
68) at ../csu/libc-start.c:308<br>#8 =C2=A00x000055ffa89c06ba in ?? ()</cod=
e></pre></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f" class=3D"gmail_default">IMHO, the key reason for the issue is that QEMU =
fails to run the main loop and fails to respond to QMP, which is not what w=
e usually expected.=C2=A0</div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Giving t=
he Libvirt a window of time to issue a QMP and kill the VM is=C2=A0the idea=
l solution=C2=A0for this issue; this provides an automatic method. </div><d=
iv style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmai=
l_default"><br></div><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default">I do not dig the yank feature, perhaps it=
 is helpful, but only manually?=C2=A0</div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt">After all, these two options are not exclusive of one another, =C2=A0I =
think.</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"=
 class=3D"gmail_default"><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
Best regards,<br>
Lukas Straub<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</=
div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">Yong</div><br></div><span class=3D"gmail_signature_prefi=
x">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><font face=3D"comic sans ms, sans-serif">Best regards</font></div></div><=
/div>

--0000000000009c602d063bd1712b--

