Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF92C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 02:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpcyv-00054B-GG; Thu, 30 Jul 2026 22:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpcyu-000542-0J
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:28:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wpcys-0005v3-GY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 22:28:15 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so746269a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 19:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785464892; cv=none;
 d=google.com; s=arc-20260327;
 b=YJ4JYkflkRygGIps3UhzvlaUaaIAGPscZlc32aM4iWVQZeEdz0bKs+hX8MAnFmzwr3
 uhqBriPVr1ZclnwFlLLBBWqinemr5j/8CCCgTGf3T4XGimOntttzCvT2pSwcnMs9ks8K
 jFOHzJ9uWFNFTJ+tPjHGSaLZDFaOxiU9XdLv5Vqq8TLsGsA8mvDrdOftGECPKVVAFtzq
 5/mOC/tdACgeY5J9b66SLx7dS4hzJP9ZS+4SJCx5XpHkfhvzvYj5hyeeFPU9pf9evGyE
 sOVlHK15XVoU6I1fBs1NN9mARrNs1aoZBy1jIV2PdHFbgyGvjmWOsMFdHKfg6Z+/gsMb
 6hcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uHL5kbkeRzJyUZjxEky6OnYQKMFa8T1vQFuEyt5BqSI=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=lDS1y1BCTJNY5IR79XWlAtHKvX/rQ5e4kfcdCli3znWuAg4h8vXYSAckFRr7AdABBE
 G/HVVXUINJ8rPDPHKEQakB8aa3dC6uFlwoqxAzbRD9ok9JCPuXdBU3h9kwpvTIcHr8ep
 y4Ak4ITdbeMwAoNRM01sIVzHUIzNGRk4CMLhbz1tJWccjDQbgsfslOhcW8zmXuHCFjLP
 rbBNzl14FwDtSRqcfBNZHdiGtfDYQ449lxcHHD5AnfVXLJjKHYjF2si4V0oWb6kpD7J2
 tyJEl6SuJc6j7FD0PDYUpHvIKIeA/dYoy0owDRtXwQd3wkgVgVpiYXWklghg+atB7q5V
 A8aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785464892; x=1786069692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uHL5kbkeRzJyUZjxEky6OnYQKMFa8T1vQFuEyt5BqSI=;
 b=V83rwjyQ00reGVAcE9rRGa/XwoshxcCSGOYMawRNKwxkvFRLwWwpfFQMtMxV7RZFwI
 6GmZWVzk1nziqq7rNm5/UU5tH2cNgjWfxOb7geiqUdVrj+hT7Iq21640cTF8ubtD45KR
 Hd5d4djHaehIJI5VT4Cgo4KNoSLrLMkfR6zKUU7wCXlViEK6r1Z1mEOahbBQVtHVgNir
 FgT5hrJVTgtfKkLXYvq2FuvI9FkZqRasYPCU9kwq3azAQgE9LrBM3+4ovILGFUdtjPmE
 MlK/2ZVNASetdO6C9hKSHUREtF40WJ7eNpecp+pyL1xxJXocu7SmSNhkIW+hScE1yKKI
 fBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785464892; x=1786069692;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHL5kbkeRzJyUZjxEky6OnYQKMFa8T1vQFuEyt5BqSI=;
 b=HcCT7DpVjw/Ls+s8vyVC9ujCbDwu96ZDZm+CCfuc7+88LKC6snVlnlSuwqcf6N2AtC
 Ob22ODCafEN0r8pxfOI6r9JO1TvtjReh9lkO79HrVkwuOFyAD4NCbuqDHIQTSStnAc7i
 Z1gmFFjofMC3ccNius2viefWGW5W/IClwJub1TQkf8EQzP7h7ZKhi6GGXBGBxoNs8m9x
 5bz/Cec5GIoHJBIFqgxrp2KYQTCj2v9NgzdKZH7g/4zFaSxDyj2PJhrN9/g7uYRo4Bq8
 CY0R7Vr6Mov9j/I0XYQsNBG8p3XGOnmbyTO/sJRvJBRk3WmAJN0ssSP1mFrKkS3G7sn5
 Kqfg==
X-Gm-Message-State: AOJu0YzO+1vnOhWUTWvYv84wHzO8oV/b4SWs2RUZ67Vyw5Lvwxjcey1n
 TOoM/Ava7gLkQ9E/XMlhl8R3FqTdm8TpQldhpLDqUAXamrDLTilp/u+4k/0Pby8zOxzh/VoIotg
 RUalKqcxDH/uPjn4xWXvnNoR6GdEsvoU=
X-Gm-Gg: AR+sD13HC/apadifmKNap0DboDjxdvBwUmCwLDtN8lvFB2RQ188o/EU25OmOmJNefcv
 RtnrEKCFojfOeo6WJmyZz3QPi312v+xkSUXP6RMRxsuiLENPrsyaMGX1mqMRuqLbFdB9nZdQrH1
 ypG3xkN4crbfOoeybR7spESewcF0dMlesqxgEHdDsvifa9y+NulDnQi+mmHPKRIcvx5PNOlSBTA
 oxSP6GPz8zgCwTQRU5uxi6dthtmHtS8R5tk9LlK1eiBgUcO5wnNZu6WS0aBKXCtBZDT+wl4ITl4
 ClNSWkcHbT47hNJ2/awOAVERfpouspLzLUWphqhj61y5
X-Received: by 2002:a05:6402:3224:b0:698:351c:97ae with SMTP id
 4fb4d7f45d1cf-6a098cdf166mr106826a12.23.1785464892272; Thu, 30 Jul 2026
 19:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <87v7a8o6fp.fsf@pond.sub.org>
In-Reply-To: <87v7a8o6fp.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 31 Jul 2026 10:27:35 +0800
X-Gm-Features: AUfX_mx4tX0sI1SsE-2fkZLb6AcS9rVvYU_7Ia59MFPmZuuabD0GVTEgP8ECE-k
Message-ID: <CAK3tnv+40pv7-MQMhreivBwv+FrWpjpx9dSKSQ=6fKRxq3w=fA@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 00/15] iothread: Support tracking and querying
 IOThread holders
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 21, 2026 at 8:47=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> With this series applied:
>
>     $ qemu-system-x86_64 -S -display none -chardev id=3Dchr-mon0,backend=
=3Dstdio -object monitor-hmp,id=3Dmon0,chardev=3Dchr-mon0 -chardev id=3Dchr=
-mon1,backend=3Dsocket,path=3Dtest-hmp,server=3Don,wait=3Doff -object monit=
or-qmp,id=3Dmon1,chardev=3Dchr-mon1
>     QEMU 11.0.90 monitor - type 'help' for more information
>     (qemu) q
>     **
>     ERROR:../iothread.c:99:iothread_unref: code should not be reached
>     Bail out! ERROR:../iothread.c:99:iothread_unref: code should not be r=
eached
>     Aborted                    (core dumped) qemu-system-x86_64 -S -displ=
ay none -chardev id=3Dchr-mon0,backend=3Dstdio -object monitor-hmp,id=3Dmon=
0,chardev=3Dchr-mon0 -chardev id=3Dchr-mon1,backend=3Dsocket,path=3Dtest-hm=
p,server=3Don,wait=3Doff -object monitor-qmp,id=3Dmon1,chardev=3Dchr-mon1
>
> Stack backtrace:
>
>     #0  0x00007f182873832c in __pthread_kill_implementation () at /lib64/=
libc.so.6
>     #1  0x00007f18286de15e in raise () at /lib64/libc.so.6
>     #2  0x00007f18286c56d0 in abort () at /lib64/libc.so.6
>     #3  0x00007f182ac53482 in g_assertion_message[cold] ()
>         at /lib64/libglib-2.0.so.0
>     #4  0x00007f182acc1447 in g_assertion_message_expr ()
>         at /lib64/libglib-2.0.so.0
>     #5  0x000055ffa06cb50e in iothread_unref
>         (iothread=3D0x55ffdb3bd740, holder=3D0x7ffc6152d8c0) at ../iothre=
ad.c:99
>     #6  0x000055ffa06cc13a in iothread_put_aio_context
>         (iothread=3D0x55ffdb3bd740, holder=3D0x7ffc6152d8c0) at ../iothre=
ad.c:444
>     #7  0x000055ffa07d9af6 in monitor_cleanup () at ../monitor/monitor.c:=
679
>     #8  0x000055ffa047ca8c in qemu_cleanup (status=3D0) at ../system/runs=
tate.c:1046
>     #9  0x000055ffa07fccb7 in qemu_default_main (opaque=3D0x0) at ../syst=
em/main.c:51
>     #10 0x000055ffa07fcd64 in main (argc=3D12, argv=3D0x7ffc6152da98)
>         at ../system/main.c:93
>

Oh~ Thanks for the hmp and qmp monitor case test. I didn't trigger it
in the basic monitor test.
The root cause is monitor_cleanup unconditionally unregisters all monitors
if the global mon_iothread exists. I will fix it in next version.

Thanks
Chen

