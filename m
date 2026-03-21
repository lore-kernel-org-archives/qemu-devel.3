Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC7D1094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3yc3-0006Gc-LC; Sat, 21 Mar 2026 11:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w3yc1-0006GG-Ks
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:51:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w3ybx-0003ym-5a
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:51:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1578512b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 08:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774108295; cv=none;
 d=google.com; s=arc-20240605;
 b=dVRz7JT1xhOEQNOQfJycW/eqg7Pg5cmWIRnuwyLsTyWc19HWUCeNrKwRNcJfIvCIpI
 AltACHtih93talLL8Id7ycSYdnkmq3q8pVfavp3CyjM7ds1K4YfiX8kPvcR3YZhmBD1y
 LMk8WeI+uvqFFf3f/Q4TDEq8Ms8g2c9t+GvUh+eM2Pl23a2EKO46gYhzUr+N1RsXecfR
 +xnMdX737/Dcj7oy9pug62OE/Vyr81GLtHdHNpAaoqUrETDecY3/n7Stu/6Kc/0j0hYS
 53FMPFl91g6fyThISpCfkZ7AgnClglc78TgOsXmvAuBVmBpKiLkLTe2GAh5rptoHe3tZ
 fzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZXV7nf4iG2DAmm/KYcefJDB4RAuyVTKoCSyXyRx7ENI=;
 fh=DFQdyJwGvZUwth7T/WKqdvqDS27hKnpFmHOLvp6mSSM=;
 b=Mm9D1gIQbXGwoY2kW18LkXeSoNFFXelWByrn7apecgnb6Fiu78LUG/jg1wNhszsKUX
 zQCLwmx05scotHFdKJbPSxTzFxznWb8muu3T5/jkxAtyjxUZCeKh0nFYyYZvc0BT8rr2
 F1v2fdE6Noj4dAlV6vECm4xGt/rsZTmxJVCsftUhCiXC/PGyKaoRLbN72mUGogoDhIVS
 GIR226ffQ95JeqkCgIksCW8pyJ4mCT78kMJwzlI+Pypva4zEXJxAocAgkcdPbMkU2M+s
 Lfbnci/f0LfTjJaFyAMPE5nHQq9IEvuOjF4Cn+uAGAkMaX68fyroazKLh4+9fjlLleLJ
 lY+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1774108295; x=1774713095;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXV7nf4iG2DAmm/KYcefJDB4RAuyVTKoCSyXyRx7ENI=;
 b=Eo2Wyyha+ynDctuab9i1zKC2Jc6BOY3A4RIk3Ogcfz+ZuBRLs7kjOnq1HPZcRLzg1s
 hvq7rbwe0ErdNYy6wET0zi/xHFnhytS7Gq+n14Fli5iz40vOTO/l8/F67OnrO49SWZuM
 w/inbyDWh0VpJoiytgZL+1XKCkra7LjTKxq+SXSZhclrvl9daSVGHRLKqmChHPl8mh8D
 bQXgOkvseTEDqIPQuGpXqn8ObIcnCax7OQ8zFABkYiI+g5/am/ttqM2SvZ4AOccUvdga
 zOM5k+K0k3fWNa78VKFXZNDipOFxh4Hz8E7NHvIyeJNJ2q+4HMPeRHVqPMaVRLitF/f9
 r4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774108295; x=1774713095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXV7nf4iG2DAmm/KYcefJDB4RAuyVTKoCSyXyRx7ENI=;
 b=BJL3CAp3JcNICIOdie/OsOScbuzcDNAX9aZ3vKPygT3lXo6yuLTtwu80FDISZb6RlN
 8p4NgyvprRM/lnOgGh1bctIqFBJcwcMar+t2N5czPtCuYLr0uaU/GLmQ+8aW7jDmIl6T
 V78m8v1jUzln3YaDVcyeVvewLmkZE6NgnmIViwprlqz+Wh+ZKXB3FDCHDeU4vRR0Uhdj
 kG6PGjBUeFv+ZJJ26uMcbx5WN1oakVO+WVTBwSHXDNsjluov8cNBkqhqk/4HeJ+Yr+0t
 CTkjAgZcn5R5dIpn3MUfK8HN6J/UnjXkQjn825QFB0E90WB0gsLFOa4EZOjQAOZHhq2a
 31uw==
X-Gm-Message-State: AOJu0YzBrzd8sajOU3uRc2fZ9lWXIZMXD3BwK4zZwCRlxv1q756s7Csa
 3ub5U+je20HGnGSJpoPN1sBIJ9XNQvVWfatcpAEyCJd2EnC17Q+dgvkTdxNjelOb0BnTzLgb7wA
 G25JgoniRrKG1w4zZzq4FWEgv6zTHV/7jn8BjIcxDgw==
X-Gm-Gg: ATEYQzw+1Ah4y0e5q6RYCH0vWPDGGBxeMkxxssgHMANU/UEn1ezr60Fqhi1FomwtxPc
 0dVpR8ahohlpxH0UNFeFjri2wQt/NV4Ee7Nc+TDNY7M4GydNkIhsrhHd1tqAi88VALz3goLCLbA
 GlE4dWodPQ7cfaOryKY+HAQy2NWPn5lbvdpt/Ud/7elSqvP0q1v1x+vvdiQOvv3EjbSYqelonWw
 kyHV+YZH7ABKmSv8dwfw+ES+L6JBLJqy92ldw91hn1SeDvL/2Cn3U3AcrX4v3ZYmKS8lNUYzKNT
 N+3sefYXJRd8fdctXGtasjFiM/mdr6WFUv0V
X-Received: by 2002:a05:6a20:7f9f:b0:398:b178:a53f with SMTP id
 adf61e73a8af0-39bceb427b1mr5921093637.40.1774108295301; Sat, 21 Mar 2026
 08:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <20260321135624.581398-3-npiggin@gmail.com>
In-Reply-To: <20260321135624.581398-3-npiggin@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 21 Mar 2026 09:51:24 -0600
X-Gm-Features: AaiRm53TYxAkgqjZKIAF8_QYBYkiJd3uDXtIKXlCCHH6svwy7xBl-IRqDHxN2Wk
Message-ID: <CANCZdfoOwgUJZP3Do4Vgj5cN_NRK2_cacorK8LXKjZ=TbBdCsQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] bsd-user, linux-user: signal: recursive signal
 delivery fix
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bc1a39064d8ac667"
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000bc1a39064d8ac667
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 7:56=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> Synchronous signals must accommodate a synchronous signal being
> raised during delivery, as asynchronous ones do. For example
> badframe errors during delivery will cause SIGSEGV to be raised.
>
> Without this fix, cpu_loop() runs process_pending_signals() which
> delivers the first synchronous signal (e.g., SIGILL) which fails
> to set the handler and forces SIGSEGV, but that is not picked up.
> process_pending_signals() returns. Then cpu_loop() runs cpu_exec()
> again, which attempts to execute the same instruction, another
> SIGILL.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  bsd-user/signal.c   | 10 ++++++----
>  linux-user/signal.c |  9 ++++++---
>  2 files changed, 12 insertions(+), 7 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Interesting edge case...

Warner


> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index dadcc037dc..3e5e41e1b1 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -998,7 +998,12 @@ void process_pending_signals(CPUArchState *env)
>                  sigdelset(&ts->signal_mask, target_to_host_signal(sig));
>                  sigact_table[sig - 1]._sa_handler =3D TARGET_SIG_DFL;
>              }
> +            /*
> +             * Restart scan from the beginning, as handle_pending_signal
> +             * might have resulted in a new synchronous signal (eg
> SIGSEGV).
> +             */
>              handle_pending_signal(env, sig, &ts->sync_signal);
> +            goto restart_scan;
>          }
>
>          k =3D ts->sigtab;
> @@ -1008,10 +1013,7 @@ void process_pending_signals(CPUArchState *env)
>              if (k->pending &&
>                  !sigismember(blocked_set, target_to_host_signal(sig))) {
>                  handle_pending_signal(env, sig, k);
> -                /*
> -                 * Restart scan from the beginning, as
> handle_pending_signal
> -                 * might have resulted in a new synchronous signal (eg
> SIGSEGV).
> -                 */
> +                /* Restart scan, explained above. */
>                  goto restart_scan;
>              }
>          }
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index e4b8b28bfe..9d43e080ce 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -1385,6 +1385,11 @@ void process_pending_signals(CPUArchState *cpu_env=
)
>              }
>
>              handle_pending_signal(cpu_env, sig, &ts->sync_signal);
> +            /*
> +             * Restart scan from the beginning, as handle_pending_signal
> +             * might have resulted in a new synchronous signal (eg
> SIGSEGV).
> +             */
> +            goto restart_scan;
>          }
>
>          for (sig =3D 1; sig <=3D TARGET_NSIG; sig++) {
> @@ -1395,9 +1400,7 @@ void process_pending_signals(CPUArchState *cpu_env)
>                  (!sigismember(blocked_set,
>                                target_to_host_signal_table[sig]))) {
>                  handle_pending_signal(cpu_env, sig, &ts->sigtab[sig - 1]=
);
> -                /* Restart scan from the beginning, as
> handle_pending_signal
> -                 * might have resulted in a new synchronous signal (eg
> SIGSEGV).
> -                 */
> +                /* Restart scan, explained above. */
>                  goto restart_scan;
>              }
>          }
> --
> 2.51.0
>
>

--000000000000bc1a39064d8ac667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 21,=
 2026 at 7:56=E2=80=AFAM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Synchronous signals must accommodate a synchronous =
signal being<br>
raised during delivery, as asynchronous ones do. For example<br>
badframe errors during delivery will cause SIGSEGV to be raised.<br>
<br>
Without this fix, cpu_loop() runs process_pending_signals() which<br>
delivers the first synchronous signal (e.g., SIGILL) which fails<br>
to set the handler and forces SIGSEGV, but that is not picked up.<br>
process_pending_signals() returns. Then cpu_loop() runs cpu_exec()<br>
again, which attempts to execute the same instruction, another<br>
SIGILL.<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0| 10 ++++++----<br>
=C2=A0linux-user/signal.c |=C2=A0 9 ++++++---<br>
=C2=A02 files changed, 12 insertions(+), 7 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Interesting edge case.=
..</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
index dadcc037dc..3e5e41e1b1 100644<br>
--- a/bsd-user/signal.c<br>
+++ b/bsd-user/signal.c<br>
@@ -998,7 +998,12 @@ void process_pending_signals(CPUArchState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigdelset(&am=
p;ts-&gt;signal_mask, target_to_host_signal(sig));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigact_table[=
sig - 1]._sa_handler =3D TARGET_SIG_DFL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Restart scan from the be=
ginning, as handle_pending_signal<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might have resulted in a=
 new synchronous signal (eg SIGSEGV).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_pending_signal(env, =
sig, &amp;ts-&gt;sync_signal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto restart_scan;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k =3D ts-&gt;sigtab;<br>
@@ -1008,10 +1013,7 @@ void process_pending_signals(CPUArchState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (k-&gt;pending &amp;&amp=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!sigismember(=
blocked_set, target_to_host_signal(sig))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_pendin=
g_signal(env, sig, k);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Restart sc=
an from the beginning, as handle_pending_signal<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might have=
 resulted in a new synchronous signal (eg SIGSEGV).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restart scan, e=
xplained above. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto restart_=
scan;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/linux-user/signal.c b/linux-user/signal.c<br>
index e4b8b28bfe..9d43e080ce 100644<br>
--- a/linux-user/signal.c<br>
+++ b/linux-user/signal.c<br>
@@ -1385,6 +1385,11 @@ void process_pending_signals(CPUArchState *cpu_env)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_pending_signal(cpu_e=
nv, sig, &amp;ts-&gt;sync_signal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Restart scan from the be=
ginning, as handle_pending_signal<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might have resulted in a=
 new synchronous signal (eg SIGSEGV).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto restart_scan;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (sig =3D 1; sig &lt;=3D TARGET_NSIG; =
sig++) {<br>
@@ -1395,9 +1400,7 @@ void process_pending_signals(CPUArchState *cpu_env)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!sigismember=
(blocked_set,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_to_host_signal_table[sig]))) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_pendin=
g_signal(cpu_env, sig, &amp;ts-&gt;sigtab[sig - 1]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restart scan fr=
om the beginning, as handle_pending_signal<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* might have=
 resulted in a new synchronous signal (eg SIGSEGV).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restart scan, e=
xplained above. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto restart_=
scan;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000bc1a39064d8ac667--

