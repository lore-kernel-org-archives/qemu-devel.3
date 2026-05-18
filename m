Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C20CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1A3-0006oz-C5; Mon, 18 May 2026 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP19c-0006d0-6R
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP19Z-0007uT-Sb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779122957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sBuMuiaifVvygCTV/NWaYd1gF9UQPZ6lwf2pF2teuuA=;
 b=FMq+WpgEqTvaO7+LTBzrtsHrPtweBtZhL/CrQgEbUnj+BfSKuuyKSPjAZSk82MXBXSI7fE
 W3kfWSa0qatiCLHnyZZfAaTzulS9ztUbPsgpabX8HDJJLjO8YLwTzIQGmm5grhT0EsW9hU
 a1dntTRskU+2fTZyBsyrz63EGa1c+Sc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-B4Bg_RcPOd23rcpOiLTs5w-1; Mon, 18 May 2026 12:49:14 -0400
X-MC-Unique: B4Bg_RcPOd23rcpOiLTs5w-1
X-Mimecast-MFC-AGG-ID: B4Bg_RcPOd23rcpOiLTs5w_1779122954
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fe40b61a3so20157085e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779122953; x=1779727753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sBuMuiaifVvygCTV/NWaYd1gF9UQPZ6lwf2pF2teuuA=;
 b=ctK1bCYv9AGt7uQe3CsaguLfA2KMyU0xQdWtA2OYDToPTWhjAvVVESVSF5m9rPk4Gc
 5lcuPo5WesZhIf7DYBUlLgM8wAdqFww9Q316KnLje7E85RJCfizLbI/OVyxdnD+6kg74
 0Vxo4vrAjpXMxrbM5CsE1lVanXS+oLXH9s1Dwjr3Jje8OkhwH5OGrx0QfeadWMtRtpFy
 R2FGbEy2zQCTqPbRj1QvR7dcEWzSpxXjyl5QJCXcpzovVMpNmQK0Rt4f08FkIIBIqiFq
 VkQOHzsl87dEAULoB0r/Nnm/Y5S4X3lg2TeGC7ZiP7h9KJ6XwoxiRiAzN8JbqLYVPFdb
 QR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122953; x=1779727753;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBuMuiaifVvygCTV/NWaYd1gF9UQPZ6lwf2pF2teuuA=;
 b=lpGiP21IwfD/9yKB/c8AdC6U8wWO1wPwQbO6MGzwRwr9syCw188vMsJrNPYgvl6PNI
 UXGnAyJ9vDeFTGvlzYtloH7helffHIVlDMmOmcysuERGX0pmLpyJZYE5B3LWXXqX7dkb
 oJf5n2knCrhpIhtOjId01yRwt+RzcmEqutfMXOgw82fc2wgp9VO0FmyrTUX3fi8XUHfq
 nk9cEOWQW1B83P09im/kB9Yw8NLFaa+yGF0B6NX34KvTgoArdQgeXDn7XKO/AV7BdINb
 WgKLDc97BigxwZVwt6A3JTCnxddbBH70MfJfsK24f4kTYviWdLkd2aZf4N919GPp3uzj
 JeOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QtR4jAiFS+BQOmfTEZN6G8Q42pvZq06WEwPpnDglGkucAMO1VM9NGmhimuEM4BvzchClgp9mZB/Of@nongnu.org
X-Gm-Message-State: AOJu0Yy8nWST34dR6Ru9MejqfpeaBnSFbRItgU95L2aPwvIRrL0C5cen
 N6dJyE8fj0mlxdBbWOXLBt1DuCyRu5BNf5elax1hzTnxn+H8MzW3GFTGereieh3wDTLiJCePmMZ
 j3ruaum5146DPv9Z2IqOteNor/rQVYLX6CM36EZak0awujIeBWk9fkdys
X-Gm-Gg: Acq92OEKhgl9mNZfye6NMKbPglXDBuzBVBTAAawykPGMvAJnp221sGIlIHvxJa/gngw
 mpBggyFRWjSp+7osAmSeEzwLAp0xZg+n1pUVsSY+b2a0j7xF8dWQeEPI6rnnCsSPRVV0v6dkNio
 Cq0X+lYnqIP60/Vlp1JkS1Hv+/OfijOcWIjum9Eb36LObcUiC7hz1xDFjwfMcdDE/xABvelslgk
 z9W6uW9T8hiH3Lc80WpCF8HHFc0DCy3OSK3fMclHAIrecgm7OW1kJvXSb+m+IabDpDbnQubT/PH
 Vo4v3nELCL24AVmMrvY6sShLwk2bVRMfOd6ZBsArBe+8Yf8MxuFCNhkhxaY0Btbbbmf9V37p5h8
 BSJgm1By4a5wBxVvxMw==
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-48fe6626a58mr247598865e9.32.1779122953486; 
 Mon, 18 May 2026 09:49:13 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-48fe6626a58mr247598315e9.32.1779122953027; 
 Mon, 18 May 2026 09:49:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c834besm277666255e9.3.2026.05.18.09.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:49:12 -0700 (PDT)
Message-ID: <59f45360-5676-41a7-8c4a-577c3e645aa7@redhat.com>
Date: Mon, 18 May 2026 18:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Implement -run-with exit-with-parent=on
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com
References: <20251009161526.140497-1-rjones@redhat.com>
 <20251009161526.140497-2-rjones@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251009161526.140497-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2025 18.12, Richard W.M. Jones wrote:
> Libguestfs wants to use qemu to run a captive appliance.  When the
> program linked to libguestfs exits, we want qemu to be cleaned up.
> Libguestfs goes to great lengths to do this at the moment: it either
> forks a separate process to ensure clean-up is done, or it asks
> libvirt to clean up the qemu process.  However this is complicated and
> not totally reliable.
> 
> On Linux, FreeBSD and macOS, there are mechanisms to ensure a signal
> or message is delivered to a process when its parent process goes
> away.  The qemu test suite even uses this mechanism on Linux (see
> PR_SET_PDEATHSIG in tests/qtest/libqtest.c).
> 
> In nbdkit we have long had the concept of running nbdkit captively,
> and we have the nbdkit --exit-with-parent flag to help
> (https://libguestfs.org/nbdkit-captive.1.html#EXIT-WITH-PARENT)
> 
> This commit adds the same mechanism.  The syntax is:
> 
>    qemu -run-with exit-with-parent=on [...]
> 
> This is not a feature that most typical users of qemu (for running
> general purpose, long-lived VMs) should use, so it defaults to off.
> 
> The exit-with-parent.[ch] files are copied from nbdkit, where they
> have a 3-clause BSD license which is compatible with qemu:
> 
> https://gitlab.com/nbdkit/nbdkit/-/tree/master/common/utils?ref_type=heads
> 
> Thanks: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   include/qemu/exit-with-parent.h |  57 +++++++++++++
>   qemu-options.hx                 |  13 ++-
>   system/exit-with-parent.c       | 140 ++++++++++++++++++++++++++++++++
>   system/meson.build              |   1 +
>   system/vl.c                     |  13 +++
>   5 files changed, 222 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/exit-with-parent.h b/include/qemu/exit-with-parent.h
> new file mode 100644
> index 0000000000..c00b863fe9
> --- /dev/null
> +++ b/include/qemu/exit-with-parent.h
> @@ -0,0 +1,57 @@
> +/*
> + * SPDX-License-Identifier: BSD-3-Clause
> + * Originally derived from nbdkit common/utils/exit-with-parent.h
> + * Copyright Red Hat
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + * * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * * Neither the name of Red Hat nor the names of its contributors may be
> + * used to endorse or promote products derived from this software without
> + * specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY RED HAT AND CONTRIBUTORS ''AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RED HAT OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +#ifndef NBDKIT_EXIT_WITH_PARENT_H
> +#define NBDKIT_EXIT_WITH_PARENT_H
> +
> +/* Test if the feature is available on the platform. */
> +static inline bool can_exit_with_parent(void)
> +{
> +#if defined(__linux__) || defined(__FreeBSD__) || defined(__APPLE__)
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +/*
> + * --exit-with-parent: kill the current process if the parent exits.
> + * This may return -1 on error.
> + *
> + * Note this will abort on platforms where can_exit_with_parent()
> + * returned false.
> + */
> +extern int set_exit_with_parent(void);
> +
> +#endif /* NBDKIT_EXIT_WITH_PARENT_H */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cc2ef4424e..bf745f354d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5467,15 +5467,18 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
>   
>   #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
>   DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
> -    "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
> +    "-run-with [async-teardown=on|off][,chroot=dir]\n" \
> +    "          [,exit-with-parent=on|off][,user=username|uid:gid]\n"
>       "                Set miscellaneous QEMU process lifecycle options:\n"
>       "                async-teardown=on enables asynchronous teardown (Linux only)\n"
> +    "                exit-with-parent=on causes QEMU to exit if the parent\n"
> +    "                  process of QEMU exits (Linux, FreeBSD, macOS only)\n"
>       "                chroot=dir chroot to dir just before starting the VM\n"
>       "                user=username switch to the specified user before starting the VM\n"
>       "                user=uid:gid ditto, but use specified user-ID and group-ID instead\n",
>       QEMU_ARCH_ALL)
>   SRST
> -``-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]``
> +``-run-with [async-teardown=on|off][,chroot=dir][,exit-with-parent=on|off][,user=username|uid:gid]``
>       Set QEMU process lifecycle options.
>   
>       ``async-teardown=on`` enables asynchronous teardown. A new process called
> @@ -5493,6 +5496,12 @@ SRST
>       immediately before starting the guest execution. This is especially useful
>       in combination with ``user=...``.
>   
> +    ``exit-with-parent=on`` causes QEMU to exit if the parent process of
> +    QEMU exits.  This can be used when QEMU runs a captive appliance,
> +    where the lifetime of the appliance is scoped to the parent process.
> +    In case the parent process crashes, QEMU is still cleaned up.
> +    This only works on Linux, FreeBSD and macOS platforms.
> +
>       ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
>       before starting guest execution. QEMU will use the ``setuid`` and ``setgid``
>       system calls to switch to the specified identity.  Note that the
> diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
> new file mode 100644
> index 0000000000..df65d2231a
> --- /dev/null
> +++ b/system/exit-with-parent.c
> @@ -0,0 +1,140 @@
> +/*
> + * SPDX-License-Identifier: BSD-3-Clause
> + * Originally derived from nbdkit common/utils/exit-with-parent.c
> + * Copyright Red Hat
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + * * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * * Neither the name of Red Hat nor the names of its contributors may be
> + * used to endorse or promote products derived from this software without
> + * specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY RED HAT AND CONTRIBUTORS ''AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RED HAT OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +/*
> + * Implement the --exit-with-parent feature on operating systems which
> + * support it.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/exit-with-parent.h"
> +
> +#if defined(__linux__)
> +
> +#include <sys/prctl.h>
> +
> +/*
> + * Send SIGTERM to self when the parent exits.  This will cause
> + * qemu_system_killed() to be called.
> + *
> + * PR_SET_PDEATHSIG has been defined since Linux 2.1.57.
> + */
> +int
> +set_exit_with_parent(void)
> +{
> +    return prctl(PR_SET_PDEATHSIG, SIGTERM);
> +}
> +
> +#elif defined(__FreeBSD__)
> +
> +#include <sys/procctl.h>
> +
> +/*
> + * Send SIGTERM to self when the parent exits.  This will cause
> + * qemu_system_killed() to be called.
> + *
> + * PROC_PDEATHSIG_CTL has been defined since FreeBSD 11.2.
> + */
> +int
> +set_exit_with_parent(void)
> +{
> +    const int sig = SIGTERM;
> +    return procctl(P_PID, 0, PROC_PDEATHSIG_CTL, (void *) &sig);
> +}
> +
> +#elif defined(__APPLE__)
> +
> +/* For macOS. */
> +
> +#include "qemu/thread.h"
> +#include "qemu/error-report.h"
> +#include "system/runstate.h"
> +#include <sys/event.h>
> +
> +static void *
> +exit_with_parent_loop(void *vp)
> +{
> +    const pid_t ppid = getppid();
> +    int fd;
> +    struct kevent kev, res[1];
> +    int r;
> +
> +    /* Register the kevent to wait for ppid to exit. */
> +    fd = kqueue();
> +    if (fd == -1) {
> +        error_report("exit_with_parent_loop: kqueue: %m");
> +        return NULL;
> +    }
> +    EV_SET(&kev, ppid, EVFILT_PROC, EV_ADD | EV_ENABLE, NOTE_EXIT, 0, NULL);
> +    if (kevent(fd, &kev, 1, NULL, 0, NULL) == -1) {
> +        error_report("exit_with_parent_loop: kevent: %m");
> +        close(fd);

So in case of errors, fd is closed here ...

> +        return NULL;
> +    }
> +
> +    /* Wait for the kevent to happen. */
> +    r = kevent(fd, 0, 0, res, 1, NULL);
> +    if (r == 1 && res[0].ident == ppid) {
> +        /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
> +        qemu_system_killed(SIGTERM, ppid);
> +    }
> +
> +    return NULL;
> +}
... but if everything goes well, fd does not get closed? Should there be a 
close(fd) after the kevent() here?

  Thomas


