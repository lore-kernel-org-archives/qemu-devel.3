Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F6AC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGlm-00031c-Gw; Wed, 31 Jul 2024 17:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZGlj-0002zs-SJ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:22:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZGlh-0000Ym-PM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:21:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ab34117cc2so4104933a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722460915; x=1723065715;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4gWDI3hbSIuCO3hV2zJ/Jwi1EvlSwkpuTtPQ6xXktS0=;
 b=oIgnpoYWHzCwRzYedLCTQAVJqIiuraArGwH9SmENQQxKv0JgGtm1FW0IJLi9O9I477
 YGm/N+m3XmanoktwkJt/+TXITbfdKoqZIUzalCOZw6UjUsGVRUeeglp1P5nzJ3U5UENR
 OHImkoCxwmkd+Q5iOJmjL8mwV5lkH08maYoooMkKc35/rFmO+75Y/nb2PG+NOUJHEiF7
 EEqiH8LAw6i1IE5gv/O+QiOBIXJk6XGL7/rlBOz2LBLS1AmirKvyToWwRQ1ciL76CcFG
 O9QjhGu9b/LVhLXecRgLQGoI5TFLM4LV8Ej/OIu5rWD+bOCkJ+VJ6ttP2FCVgxcdOx9P
 9aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722460915; x=1723065715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gWDI3hbSIuCO3hV2zJ/Jwi1EvlSwkpuTtPQ6xXktS0=;
 b=gWeKXhxdTM9H6Dawxut9V8SlLu0ZCJqAgPJudfqzdt5w14S0xyEO/lEFasU6jLnjPL
 0EowYl0MSYfcUS5Ea0q+63EVAd3uM+0bcecWW4KE1G5J7BvN5We9JCWMyRO30QmHfZLd
 Ybxyd6TR8H5Dqp00eWVocYr7jGSxLu40IdEomzZee76ZhHFadhjUe6fjOc25LHJdzFVK
 YU0BOLbW33nnxX46PUQatg3EyDkaVgOPT2OspuJVQRSAYCnKonxD4lGoFVUfklkpuXLQ
 amSEgyNe6tnu+MSUtFaB3pUrOxZsBHM1wTlyd0PRr3IkcDAKvZAVBtEqQTfif3sUPbSh
 MQPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCcgIEVpxXSw20NzUoiOuss1UYibbq9XgnDbwcKbjqVLKO0dIvrv92m4F3B1t/Uq/Q2GPnjoBoeGLE+D+4Sz4tIIHd5hQ=
X-Gm-Message-State: AOJu0YxCAxmRnjKpvnX0Vu/nxwwqbgGCYQl8M14O1qyxltnScNcO1bMV
 KqevyXcUBXTgCxO4CediRPGTGzgjQ1K0ZHkeqNjm2cPOBynqb4953XpMEIYONZyKI1q9KZDsmke
 gCMPIgaJQ18av29ZHqv9xj7xyU+FqqhDleT9inL/XHcsVYB9wGpg=
X-Google-Smtp-Source: AGHT+IGgbtG8xu4IEvo8ooKHs0DRuF2BXcW39qBVG2ceaYnSNi6D7xAzc5eA7as6C9N/5JmFc0TlkN7ywwgOK5fSRTk=
X-Received: by 2002:a05:6a21:1304:b0:1c4:9cf9:195b with SMTP id
 adf61e73a8af0-1c68d05670bmr589467637.48.1722460915277; Wed, 31 Jul 2024
 14:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240731144532.5997-1-iii@linux.ibm.com>
In-Reply-To: <20240731144532.5997-1-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 31 Jul 2024 15:21:44 -0600
Message-ID: <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000febbca061e91ae9b"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52e.google.com
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

--000000000000febbca061e91ae9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> While qemu-system can set tb-size using -accel tcg,tb-size=3Dn, there
> is no similar knob for qemu-bsd-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
>

Cool! Are you using bsd-user and need this for some reason? Or is this
purely theoretical? Is there a larger context I can read about somewhere?

I'll merge it either way (so none of the above is a criticism, I'm genuinel=
y
curious) , but I don't get too many bsd-user fixes and this one is unusual.


> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index cc980e6f401..7c230b0c7a5 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -60,6 +60,7 @@ uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>
>  static bool opt_one_insn_per_tb;
> +static unsigned long opt_tb_size;
>  uintptr_t guest_base;
>  bool have_guest_base;
>  /*
> @@ -169,6 +170,7 @@ static void usage(void)
>             "                  (use '-d help' for a list of log items)\n"
>             "-D logfile        write logs to 'logfile' (default stderr)\n=
"
>             "-one-insn-per-tb  run with one guest instruction per emulate=
d
> TB\n"
> +           "-tb-size size     TCG translation block cache size\n"
>             "-strace           log system calls\n"
>             "-trace
> [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\n"
>             "                  specify tracing options\n"
> @@ -387,6 +389,11 @@ int main(int argc, char **argv)
>              seed_optarg =3D optarg;
>          } else if (!strcmp(r, "one-insn-per-tb")) {
>              opt_one_insn_per_tb =3D true;
> +        } else if (!strcmp(r, "tb-size")) {
> +            r =3D argv[optind++];
> +            if (qemu_strtoul(r, NULL, 0, &opt_tb_size)) {
> +                usage();
> +            }
>          } else if (!strcmp(r, "strace")) {
>              do_strace =3D 1;
>          } else if (!strcmp(r, "trace")) {
> @@ -452,6 +459,8 @@ int main(int argc, char **argv)
>          accel_init_interfaces(ac);
>          object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
>                                   opt_one_insn_per_tb, &error_abort);
> +        object_property_set_int(OBJECT(accel), "tb-size",
> +                                opt_tb_size, &error_abort);
>          ac->init_machine(NULL);
>      }
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

I'll queue this to my bsd-user-2024-q3-2 branch. I hope to land it, just
after 9.1.0 release.

Warner

--000000000000febbca061e91ae9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich &=
lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.com</a>&gt; wrote:<di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">W=
hile qemu-system can set tb-size using -accel tcg,tb-size=3Dn, there<br>
is no similar knob for qemu-bsd-user. Add one in a way similar to how<br>
one-insn-per-tb is already handled.<br></blockquote><div><br></div><div>Coo=
l! Are you using bsd-user and need this for some reason? Or is this</div><d=
iv>purely theoretical? Is there a larger context I can read about somewhere=
?<br></div><div><br></div><div>I&#39;ll merge it either way (so none of the=
 above is a criticism, I&#39;m genuinely</div><div>curious) , but I don&#39=
;t get too many bsd-user fixes and this one is unusual.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/main.c | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index cc980e6f401..7c230b0c7a5 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -60,6 +60,7 @@ uintptr_t qemu_host_page_size;<br>
=C2=A0intptr_t qemu_host_page_mask;<br>
<br>
=C2=A0static bool opt_one_insn_per_tb;<br>
+static unsigned long opt_tb_size;<br>
=C2=A0uintptr_t guest_base;<br>
=C2=A0bool have_guest_base;<br>
=C2=A0/*<br>
@@ -169,6 +170,7 @@ static void usage(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (use &#39;-d help&#39; for a list of lo=
g items)\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-D logfile=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write logs to &#39;logfile&#39; (default stderr)\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-one-insn-per-tb=C2=A0 run =
with one guest instruction per emulated TB\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-tb-size size=C2=A0 =C2=A0 =
=C2=A0TCG translation block cache size\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-strace=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0log system calls\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-trace=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 [[enable=3D]&lt;pattern&gt;][,events=3D&lt;file&gt;][,=
file=3D&lt;file&gt;]\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 specify tracing options\n&quot;<br>
@@ -387,6 +389,11 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seed_optarg =3D optarg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!strcmp(r, &quot;one-insn-per-=
tb&quot;)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt_one_insn_per_tb =3D tru=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(r, &quot;tb-size&quot;)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D argv[optind++];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_strtoul(r, NULL, 0, &am=
p;opt_tb_size)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!strcmp(r, &quot;strace&quot;)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_strace =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!strcmp(r, &quot;trace&quot;))=
 {<br>
@@ -452,6 +459,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_init_interfaces(ac);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(accel), &=
quot;one-insn-per-tb&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt_one_insn_per_tb, &amp;err=
or_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(accel), &quot;t=
b-size&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt_tb_size, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ac-&gt;init_machine(NULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Reviewed-by: Warn=
er Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><=
div><br></div><div>I&#39;ll queue this to my bsd-user-2024-q3-2 branch. I h=
ope to land it, just after 9.1.0 release.<br></div><div><br></div><div>Warn=
er<br></div></div></div>

--000000000000febbca061e91ae9b--

