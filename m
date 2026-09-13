Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597B3C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5p4x-0004Ux-GV; Sun, 13 Sep 2026 14:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1x5p4r-0004Ug-JL
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:37:21 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1x5p4p-0006AR-1d
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:37:21 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso671849b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 11:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789324636; cv=none;
 d=google.com; s=arc-20260327;
 b=IKxx0Y8hD0shFtFtNWZDHLRarZXRU3cFNEh1lru9XZiznRtmfXGtQHlN9YMVRLr8KI
 jEyBefP8y4BYL7Q5YDOgbQurN2ix6tLHTg1q3ID9aUn9rmf6juEUzSxYzUq+U/8rJ/K1
 rKKmpVfhXU/8ZpY7WCQNkR4YAQnhyXRT+RDp4QJYpj4vCobWYzrOAlzFW7F0KAnAhZvG
 1ZBprECNWrc3rAXYIuTdmuvD46+VfKVq1mRaaeRgQ6AkFFHfm4IZ9aUt3SOZI7jvkOBf
 oYJw5gmyakgEFWc0cN4TzPpYnFpRFby7GUlsa2qjhTY1AXMoq2yNYRnEh6WiwVFc/Hzc
 wvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Rgfd6bEmkTzvbcYgbWGsx+JWGHpqWS1oGxtXYeJCSXA=;
 fh=fvbnmjizOgOnkpIRitnn9jmpn1Kh//THoGFO1lx5zxw=;
 b=gNgQerV09pN/oZ/3aLLQOBJhjHdPr/e9dT7dipruaF84DtHvbhtmBElLh5IughLmFP
 qcXmJTt797tOf84CrowVLqYsIhR90AdjMfMehrT1ZIQ8xjTHwgfDOa4SHXRNECLIn1Qe
 e6G/OcdwWLIqe8QOchCXyFFGEscAcXz2CmDtmRzCp5yeplWh2u0HvXgpfuYSo9ZtS17V
 h7B93QxjO7DmMpRt+O72de7xWz5KvVQrZ1pa6KmeMwhWzIea+W+QQ7MCzxMy0LB7yMgQ
 3cQZgJQg1LVNElBU+fWBzJHGSG660X3t80G/ZhlPNvR2+LjHOu9rOqahWc3Az6XG3uGR
 NkmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=10xengineers.ai; s=google; t=1789324636; x=1789929436; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rgfd6bEmkTzvbcYgbWGsx+JWGHpqWS1oGxtXYeJCSXA=;
 b=WYbhSv3wHLed8gdQvNVU1/s8VU2hAFrB12/028lxAdAwp52S4eIl85IwfqAAlgiqZ9
 p4TPbKrOGUPOJYwcimd6nHbFDpiZANZpiySe9wvsd31aW4Oih7AU7VdufZ1Vu4QYqXEL
 KSvN+5CUBhIhzxXOINxct2pp9H8fLJ4EiQZ3y8FefLnYxjrOqQq7hc38Gfbf9xFO8tsg
 QbuAKVnGBTBZbs/FqZ/6yDhXFoCVy5dvNJWuTSlfXc9kdqB0CeE7TkXi8NyGpK+A5Eg8
 v3LnsI8Dmq2S16V5TU4GXIifesQ7LQ1bBvlQlGEP5HcF7mGfN9p9jbZg7RhAKWUzPq99
 bJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789324636; x=1789929436;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rgfd6bEmkTzvbcYgbWGsx+JWGHpqWS1oGxtXYeJCSXA=;
 b=QCcnEB3VtiOdT0fnEXV1uUuaLvgi6acyQMa3WtPa89jDC0tIYNb5D2X9KfoMJGdDLS
 z6YsI300uDWAIRsxKNs1WOnpP4LouzLoQNdBIlP+gAXMRPLyvcNSs/IUuxR0XrEARUIF
 4v1h5eJNpJPPivuSclv1U2N2RwFvho2vPY6bXKg8+ZPJQQhoVMcbsV72UdOkHioCoyf+
 HA62bcomFp1Dq856uggrTjQPDPfY9M24y6M47Agk8RAl5IoiVfaprJhKlEtPGlHX2d2V
 W2tNqbOuwpokHW4e6mdpPzShDEhlKXVtq5h4IVXws4QHL+sDJiBpmhyZZ23S/9oM0xxe
 WLqw==
X-Gm-Message-State: AFuF++mX9d4HcRfJ4EKFF0C3SQhg+qOXnUItWLIeWm1B+XWLN4aP8B4b
 g+97mr4AMOc5FQnVys+LI/bGo/3Jbrccv+EPEoWNiaATMnTQIEhmu7i+gtRAqmmJmRYad1RvTnb
 Wm2kILqaMwqwEecOZWtAVka8iHieXQ5UhJevRVdmTIuhSOI7hNFX+f4/wqw==
X-Gm-Gg: AYBFou2vO3s4k5q0EQybrsdllVseJQx/Osq5wJFl97iyUtMFnuqzoq9IC+YkNog5GMa
 itxxL3fO6TEm3lpre/ZSAlC239JlcSPl6LooMjTs/XoXW9J4wi83BTzqemq2GgPL8wqkTra88Y8
 wFuSu+RP78ky4CxGU5mAF49Ggmn2LGRy1jDh3REPMf2g4y5cEPtnuFKQdqcePZLY4b5HVV3etzL
 7YrpnbGv+KdofqG2zlie1P1/aSTqD4NusQ+7s3NCT7W18uOBzcAYZjG4k3gg96VRMiHTuVkb6JK
 JEbmlLFZ6Dhq4cZPfHutl5day+wgJS6jfUdkFmFujw8KoU5xuxCmBsaU8T+y5oKKz/idxEwuy5Z
 GoZI5pEeWB15JxbaJrwyMBQ8JN6Gs351T6plzOFvL709/5JbygP5Gb4+VcSWeJjczop6VjOxmsu
 L9XHkgHn3FUwhucg==
X-Received: by 2002:a05:6a00:1889:b0:86a:8d1:8f18 with SMTP id
 d2e1a72fcca58-86ccbc4e7d7mr13756960b3a.15.1789324635869; Sun, 13 Sep 2026
 11:37:15 -0700 (PDT)
MIME-Version: 1.0
From: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Date: Sun, 13 Sep 2026 23:37:04 +0500
X-Gm-Features: AcwNN1UXT3sv9e51-Q8SfVoQG9Uw6n7rRUYX3QMkJMr_q_SF7YrvTfD6HF0VFUY
Message-ID: <CAPF+SGdq9yngvDxCM+YeeaF0HKSkN4TgE0KK09DpCdEqPczYOw@mail.gmail.com>
Subject: Deferring FD read/write to worker thread while vCPU remains halted
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Content-Type: multipart/alternative; boundary="0000000000004f2684065b619b5f"
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=irtaza.hyder@10xengineers.ai; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000004f2684065b619b5f
Content-Type: text/plain; charset="UTF-8"

In the [QEMU Internals Overall Architecture Blogpost](
https://blog.vmsplice.net/2011/03/qemu-internals-overall-architecture-and.html),
the following is stated:
> Although many I/O operations can be performed in a non-blocking fashion,
there are system calls which have no non-blocking equivalent. Furthermore,
sometimes long-running computations simply hog the CPU and are difficult to
break up into callbacks. In these cases dedicated worker threads can be
used to carefully move these tasks out of core QEMU.

The blog stated example implementations are no longer available in QEMU 11
to gain insight on how worker threads are used.

For my use case, I am trying to trigger external file descriptor writes and
wait for the corresponding read based on vCPU instructions (i.e.
register/MMIO rmw operations). In my current implementation register
read/write operations are redirected to the following function:
``` C
MemTxResult fd_mmio_rmw(hwaddr addr, bool is_write, int bytes,
                        uint64_t wdata, uint64_t *rdata,
                        CharFrontend *fe)
{
    int chardev_status;

    if (!qemu_chr_fe_backend_open(fe)) {
        /* Charbackend is not open */
        return MEMTX_ERROR;
    }

    chardev_status = qemu_chr_fe_write_all(fe, (uint8_t *)wdata, bytes);
    if (chardev_status == -1) {
        /* Unable to write to socket */
        return MEMTX_ERROR;
    }

    chardev_status = qemu_chr_fe_read_all(fe, (uint8_t*)rdata, bytes);
    if (chardev_status < 0) {
        return MEMTX_ERROR;
    }
    return MEMTX_OK;
}
```
But this function blocks the main event loop due to the blocking chardev
frontend APIs. How can:

1. The function be deferred to a worker thread as mentioned in the blog,
while keeping the vCPU triggering this request halted but the main event
loop running?
2. The worker threads be synchronized with the main loop (i.e. how would it
inform the main loop to give control to vCPU executing instructions ONLY
after the FD read is completed)?

Regards,
Irtaza

--0000000000004f2684065b619b5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In the [QEMU Internals Overall Architecture Blogpost](<a h=
ref=3D"https://blog.vmsplice.net/2011/03/qemu-internals-overall-architectur=
e-and.html">https://blog.vmsplice.net/2011/03/qemu-internals-overall-archit=
ecture-and.html</a>), the following is stated:<br>&gt; Although many I/O op=
erations can be performed in a non-blocking fashion, there are system calls=
 which have no non-blocking equivalent. Furthermore, sometimes long-running=
 computations simply hog the CPU and are difficult to break up into callbac=
ks. In these cases dedicated worker threads can be used to carefully move t=
hese tasks out of core QEMU.<br><br>The blog stated example implementations=
 are no longer available in QEMU 11 to gain insight on how worker threads a=
re used.<br><br>For my use case, I am trying to trigger external file descr=
iptor writes and wait for the corresponding read based on vCPU instructions=
 (i.e. register/MMIO rmw operations). In my current implementation register=
 read/write operations are redirected to the following function:<br>``` C<b=
r>MemTxResult fd_mmio_rmw(hwaddr addr, bool is_write, int bytes,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t wdata, uint64_t *rdata,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CharFrontend *fe)<br>{<br>=
=C2=A0 =C2=A0 int chardev_status;<br><br>=C2=A0 =C2=A0 if (!qemu_chr_fe_bac=
kend_open(fe)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Charbackend is not open =
*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return MEMTX_ERROR;<br>=C2=A0 =C2=A0 }<br=
><br>=C2=A0 =C2=A0 chardev_status =3D qemu_chr_fe_write_all(fe, (uint8_t *)=
wdata, bytes);<br>=C2=A0 =C2=A0 if (chardev_status =3D=3D -1) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Unable to write to socket */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return MEMTX_ERROR;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 char=
dev_status =3D qemu_chr_fe_read_all(fe, (uint8_t*)rdata, bytes);<br>=C2=A0 =
=C2=A0 if (chardev_status &lt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return M=
EMTX_ERROR;<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 return MEMTX_OK;<br>}<br>``=
`<br>But this function blocks the main event loop due to the blocking chard=
ev frontend APIs. How can:<br><br>1. The function be deferred to a worker t=
hread as mentioned in the blog, while keeping the vCPU triggering this requ=
est halted but the main event loop running?<br>2. The worker threads be syn=
chronized with the main loop (i.e. how would it inform the main loop to giv=
e control to vCPU executing instructions ONLY after the FD read is complete=
d)?<br><div><br></div><div>Regards,</div><div>Irtaza</div></div>

--0000000000004f2684065b619b5f--

