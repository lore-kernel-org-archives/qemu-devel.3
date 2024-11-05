Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A32D2C139
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LhK-0007OW-47; Tue, 05 Nov 2024 10:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8LhI-0007NK-8x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:42:24 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1t8LhG-0005cv-HD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:42:24 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so4614782a91.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730821341; x=1731426141;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W4+7XU8wUHXa59NQyNtcKqK64rxYzrc8qg1Q8pT9uII=;
 b=yBLQLRHEapabqfRCaRIhu/h7AJXUkjZjbmEHApBY3bsBE6VgyxypPy/xJ9bkgV0Hpl
 Q8PxPJQt0fy9AjKG3nmbPTWDFM2w/7iiwkHoiSBMkBrMO2X4RRvjpL9RL11/D+r/eF1a
 nb4bY83/fCsn17bQQiiIBAEHxC1YlQ39VfIDZCZnTH8CnNQ/R4y+rPF80vKpO/+ItA0d
 8KJjG9icS3WTysNPLc1iibp80Q0UFLzulXl9rgMTpn1aHROa9+aKF5nZNsV3xkEMdnR0
 RsPcNJqcXs5lPY/g+8WuQRjxboFn1Hd3W8aUgONU9fCsZSxMCmhbwTx+bqUUsCI4eZ15
 UzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821341; x=1731426141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4+7XU8wUHXa59NQyNtcKqK64rxYzrc8qg1Q8pT9uII=;
 b=VX2utdfYRfyp/fMx8yimBJGHE+y8ENfE4tBICERc93hZp4bwKOuaMBWili15ypWh9h
 GhMPFnXi/HBnaWaAHbTrB+9fo8veAhPEOWqA2Z2BIP/rwAMX8EAc4RTsSXEJZj5hbfl3
 SdFL0dp4CFG44yfr2gn6oXFrizU7Mo21S/WwsvSOm+aem3Q5vukvCqoafYleUvQSG/ia
 cCMc7f9FLAqVEXYakbjRTUjT1B6orgnIbSGgAC4z7ZKfrVqq0iQ45yKkMCRK4Q50XKYs
 sIHN117eV9xDvHiR/F4iw4m5xGljaVZ69/TJQua9viPkiPmFFkpCTxrlRfyANrW361XH
 R1dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhNAN0aWvAmWLFmgawbXfSIIKZmuHLAfcWM51vvDDNMjw2uKOxABAGKu3ExaVRf+EgevqEqEujCcP0@nongnu.org
X-Gm-Message-State: AOJu0Ywudxb5fOcNM3RskhljDkPJ/U8Sv8Sw1UgXTdTcXPRasRvxvMEg
 4wPJAIK3Xz/nT7DT3nQtxXIYvUvSvDQNPcfypVwe/AUk7pVWZQPUVQTa+6eiXF0CGkFn6Js8IiT
 dGzHWXGkJ+d8jw0YRWd7nPqUqJWqHQrKkg+FcP7O433vEdZa7eAs=
X-Google-Smtp-Source: AGHT+IEMecD50gjFDJaxV5Q7nJn85AEmjHxjlbXBeUyvHsgVl7DzjIcq9uOQhEbtt6zwEImDIo44bqsDHIky2ZW5nEk=
X-Received: by 2002:a17:90b:1c88:b0:2e2:bd10:599d with SMTP id
 98e67ed59e1d1-2e93c18625cmr27325248a91.11.1730821340948; Tue, 05 Nov 2024
 07:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-6-iii@linux.ibm.com>
In-Reply-To: <20241024200031.80327-6-iii@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 5 Nov 2024 08:42:09 -0700
Message-ID: <CANCZdfobgZhWMuFvY1YaeJJAzfgFFBG=TFD8-FHMMT1OLFegjg@mail.gmail.com>
Subject: Re: [PATCH 5/8] osdep: Introduce qemu_kill_thread()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003289d106262c3fdf"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
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

--0000000000003289d106262c3fdf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:00=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:

> Add a function for sending signals to individual threads. It does not mak=
e
> sense on Windows, so do not provide an implementation, so that if someone
> uses it by accident, they will get a linker error.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  include/qemu/osdep.h |  9 +++++++++
>  util/oslib-posix.c   | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsidmp.com>


> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index fe7c3c5f673..2350477787a 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -626,6 +626,15 @@ bool qemu_write_pidfile(const char *pidfile, Error
> **errp);
>
>  int qemu_get_thread_id(void);
>
> +/**
> + * qemu_kill_thread:
> + * @tid: thread id.
> + * @sig: host signal.
> + *
> + * Send @sig to one of QEMU's own threads with identifier @tid.
> + */
> +int qemu_kill_thread(int tid, int sig);
> +
>  #ifndef CONFIG_IOVEC
>  struct iovec {
>      void *iov_base;
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 11b35e48fb8..32a41fa8640 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -111,6 +111,21 @@ int qemu_get_thread_id(void)
>  #endif
>  }
>
> +int qemu_kill_thread(int tid, int sig)
> +{
> +#if defined(__linux__)
> +    return syscall(__NR_tgkill, getpid(), tid, sig);
> +#elif defined(__FreeBSD__)
> +    return thr_kill2(getpid(), tid, sig);
> +#elif defined(__NetBSD__)
> +    return _lwp_kill(tid, sig);
> +#elif defined(__OpenBSD__)
> +    return thrkill(tid, sig, NULL);
> +#else
> +    return kill(tid, sig);
> +#endif
> +}
> +
>  int qemu_daemon(int nochdir, int noclose)
>  {
>      return daemon(nochdir, noclose);
> --
> 2.47.0
>
>

--0000000000003289d106262c3fdf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 24, 2024 at 2:00=E2=80=AF=
PM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Add a function for sending signals to individual threads. It does not ma=
ke<br>
sense on Windows, so do not provide an implementation, so that if someone<b=
r>
uses it by accident, they will get a linker error.<br>
<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/osdep.h |=C2=A0 9 +++++++++<br>
=C2=A0util/oslib-posix.c=C2=A0 =C2=A0| 15 +++++++++++++++<br>
=C2=A02 files changed, 24 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsidmp.com">imp@bsidmp.=
com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
index fe7c3c5f673..2350477787a 100644<br>
--- a/include/qemu/osdep.h<br>
+++ b/include/qemu/osdep.h<br>
@@ -626,6 +626,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **e=
rrp);<br>
<br>
=C2=A0int qemu_get_thread_id(void);<br>
<br>
+/**<br>
+ * qemu_kill_thread:<br>
+ * @tid: thread id.<br>
+ * @sig: host signal.<br>
+ *<br>
+ * Send @sig to one of QEMU&#39;s own threads with identifier @tid.<br>
+ */<br>
+int qemu_kill_thread(int tid, int sig);<br>
+<br>
=C2=A0#ifndef CONFIG_IOVEC<br>
=C2=A0struct iovec {<br>
=C2=A0 =C2=A0 =C2=A0void *iov_base;<br>
diff --git a/util/oslib-posix.c b/util/oslib-posix.c<br>
index 11b35e48fb8..32a41fa8640 100644<br>
--- a/util/oslib-posix.c<br>
+++ b/util/oslib-posix.c<br>
@@ -111,6 +111,21 @@ int qemu_get_thread_id(void)<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+int qemu_kill_thread(int tid, int sig)<br>
+{<br>
+#if defined(__linux__)<br>
+=C2=A0 =C2=A0 return syscall(__NR_tgkill, getpid(), tid, sig);<br>
+#elif defined(__FreeBSD__)<br>
+=C2=A0 =C2=A0 return thr_kill2(getpid(), tid, sig);<br>
+#elif defined(__NetBSD__)<br>
+=C2=A0 =C2=A0 return _lwp_kill(tid, sig);<br>
+#elif defined(__OpenBSD__)<br>
+=C2=A0 =C2=A0 return thrkill(tid, sig, NULL);<br>
+#else<br>
+=C2=A0 =C2=A0 return kill(tid, sig);<br>
+#endif<br>
+}<br>
+<br>
=C2=A0int qemu_daemon(int nochdir, int noclose)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return daemon(nochdir, noclose);<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div></div>

--0000000000003289d106262c3fdf--

