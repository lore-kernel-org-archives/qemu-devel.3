Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704ECCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMRj-0008Nz-9V; Tue, 19 May 2026 11:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wPMRY-0008NL-Ih
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wPMRS-0002dr-6c
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779204789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnATSBk0bvP9BtnX8U1I0BwY79V747kAVKA+6C4mRbQ=;
 b=YtWFyhE9iiQY8RnJDn7nfp3ARA2SUFCQRQV+NLYQIFWb04mvhewFKJz3rapQ8aYvlgXzV7
 xOQ+ozMxg0cfkmNoux1jBG8Jei3envqdjQBSM4SdRSX8wfbxvql7b4a6DGVDvvrA/SHdOX
 zhwDvu6J4CPveCdEabVELaMj1/A7MYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-ifozgJEeONS5dezSctuaug-1; Tue, 19 May 2026 11:33:07 -0400
X-MC-Unique: ifozgJEeONS5dezSctuaug-1
X-Mimecast-MFC-AGG-ID: ifozgJEeONS5dezSctuaug_1779204786
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44cc3c9b2feso3761507f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204786; cv=none;
 d=google.com; s=arc-20240605;
 b=dNtSRay39PkE5q+fnvd2Bca7N1C6TXY71mAI918EH2WTape8tg3AOxJUFbea8kfP/V
 6dLc1w3W+aqE7gdKk3zG2/xIu9cMPd5KcpTxKQh5u2F4GNm8G2EZKISNPP/j2WXS0ho1
 rWcmsDOO2aUKlkPDisngm4N1empkIRx/WtvhyzEWCfAEksCKLe1gz/PQmkMPrfFIV1Gz
 yelcp9qFdn5BCh+U8cK7eH6mYepF/wTHX3ossC052gGUEdIWAVwx6wFQszXpQfYZSt/O
 C6sY5gFROjqUr9GbSOsSPUelOIuDYxHsIs9DrZsUCGsC/dNghy41eR26J+gyC7pOJFZZ
 rZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vnATSBk0bvP9BtnX8U1I0BwY79V747kAVKA+6C4mRbQ=;
 fh=tfRW2JVGN0mtnmpB38tAGHiGExtt7AXjeH8KZoPyjIE=;
 b=LYAdzRnISsqCor0fBAOzAl/a1yck8v3kgrixAH6rk61adxuQMrbWwvF+TscqIjIdjV
 12ufaJIhrrlGb1ILSH/gubv1tMX9zcIBxe3PJ8WJRxHyPx00VNUnez2h/v7jirvUpIUU
 /RDiFhRH7tuRjhDA1V2XRzRu6vOFAkWmwXAVsUu95guMcQbU+ZRL8UnWHImblO9n05Ib
 IIB1sbskvS3eVm7DbGvSt1VyXD5pqQuxwkZn0SHztzJXAWFn3sMaDkcgwU2pvWFANxVD
 H2dmi8Hjme2s99VxwJQYNUfqDd6p9dmosohhGqlpRg8vfihzwppMPAzMD4UnHGdBSj8N
 f64Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779204786; x=1779809586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnATSBk0bvP9BtnX8U1I0BwY79V747kAVKA+6C4mRbQ=;
 b=FzGklAb31X8Ou7y5q9mcynJNTc5xrqpnljDnLXl+GSYCfSKS2v6xSv+r3INxVrh81y
 75Qm/ZbFqsgG66bGQ3dQ5n8RshcDVr6RqTXK0q7HnzHbyJcC5Dpsfee/ffS3eupBdq60
 HD/OLhFfjyJ6/K9yp8E2DsjtWYhi5udiiFWKjbymJY67PPd/FAugOpPEceOWYMmNsE+H
 se6BAYseuVVR85EBfnBnJOqeDLKbqkG7WMMjE1rRTUDKLbfUsj6BVzL7cq48Km3avrv2
 CKkHDo3+r456m3Ptx70da8UYf03oPztRaMwu/tKrpH/453aTjuWxZHPz5M3PLsSi97Ae
 oFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204786; x=1779809586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnATSBk0bvP9BtnX8U1I0BwY79V747kAVKA+6C4mRbQ=;
 b=eEQTXSiUzXuklwpCB4+YeR7K8NacfwqSqHCSaY0VdXD6VcFLUsLI+gCP2cxu90vyIR
 xxHesYZnhEBd73UWl2UEdiS+Ukn+2W45uSV8UxBV7greBsdq9Qnm7gBLaLh/jYHJvWcd
 HUJVMj94y6ENsWq+0KIjerSYbPTDU3OQLFBtoF1cgDD+IA8d84+OsDYNRrFyXEASbGwG
 +EKki1G+2mf7j8/Dgoxrvsfmyjd+WOUfVrFsRKmviuM1of4jwXBA6j9mxLRHVyjhu+9R
 CqdekcEZ/FjkmsDzTUpIeWKdYZcermoiqrFV7HQ+SOvEp3wPhC2OP1hJM40orOqlt98/
 JN+w==
X-Gm-Message-State: AOJu0Yy/lFDMExaau1PMn3KSANhRqi5LpNfyYNuXvQ3I6T4gailYbHOE
 SDJ/7Q3n/l5INVUpVQIdu8//aLZz6T8sFjSxBHLreXs9P6Jv2ke8xXiKi4yKzZnSh7YXPzDFRSC
 Iln1vSHnGby9wj9NacXRHTa2IKJaN5lwor5gPy3/uVIVs9rri84uzWpxqtJ3SPq3cNoO87xWCCH
 b63ueCt5NL6S28ZS/6eW6A6L4Nev4M2E4=
X-Gm-Gg: Acq92OFzr1+X4DxUzHEAtaotBlyhuTIpVN337RXZT/GVuiPBJSieoX5viEgjK5UC0on
 N/qHULidAB/orUZUv+uzUJ7nEPGdoyMcBQOEXgZ3i3RU2X9kquzXBVq8pgvhJlJ5xtNPz+aoX6R
 d8zGQcHxz3q70OZjW4K3QVq96O1TctPA40a3ybVHj8C/TXWrXEJ7ApsdLs4XRRzDG0Shk+bsJNd
 NLaS3hQL0rbmVcjIzfJ0RpDPNwFuBuNXb0MQGf76h9dH+8LqNAZdOtxF750UEXA29zAVXv8XpYf
 oYwSOg==
X-Received: by 2002:a5d:5f45:0:b0:455:7e5d:9142 with SMTP id
 ffacd0b85a97d-45e5c5953ccmr31920837f8f.32.1779204785829; 
 Tue, 19 May 2026 08:33:05 -0700 (PDT)
X-Received: by 2002:a5d:5f45:0:b0:455:7e5d:9142 with SMTP id
 ffacd0b85a97d-45e5c5953ccmr31920781f8f.32.1779204785421; Tue, 19 May 2026
 08:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260519145859.91999-1-philmd@linaro.org>
In-Reply-To: <20260519145859.91999-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 May 2026 17:32:54 +0200
X-Gm-Features: AVHnY4KvMHuQ2czQF8sS7TIiwHAmWfK-LMzjl9QgFMqDK79-w1EFnfQF2xpD_2I
Message-ID: <CABgObfYh0k=Cp-1zfg-EDSMRobbDkW0OpR1QD1tGAYmHDSuorw@mail.gmail.com>
Subject: Re: [RFC PATCH] buildsys: Stop checking for ESA/390 host
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000037e64706522d65aa"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000037e64706522d65aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 19 mag 2026, 16:59 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> We still build QEMU tools on 32-bit hosts (see commit
> cf634dfcd8f), however no OS supported by QEMU still runs
> on ESA/390 (Linux dropped support in release 4.1 in 2015).
>

If Linux still supports 31-bit *userspace binaries*, I would keep the
configure check, so that 32-bit s390 is properly detected as an unsupported
CPU:

elif check_define __s390__ ; then
>   if check_define __s390x__ ; then
>     cpu=3D"s390x"
>   else
>     cpu=3D"s390"
>   fi
>

and perhaps keep the CPU_CFLAGS only from the other hunk:

  s390)
>     linux_arch=3Ds390
>     CPU_CFLAGS=3D"-m31"
>     ;;
>

   s390x)
>      host_arch=3Ds390x
>      linux_arch=3Ds390
>

The rest is fine.

Paolo

diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
> index 8c64b878145..0618966ddde 100644
> --- a/include/qemu/cacheflush.h
> +++ b/include/qemu/cacheflush.h
> @@ -19,7 +19,7 @@
>   * mappings of the same physical page(s).
>   */
>
> -#if defined(__x86_64__) || defined(__s390__)
> +#if defined(__x86_64__) || defined(__s390x__)
>
>  static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_=
t
> len)
>  {
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index b931181f53d..fc021f8f966 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)
>      return val;
>  }
>
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>
>  static inline int64_t cpu_get_host_ticks(void)
>  {
> diff --git a/tests/tcg/multiarch/nop_func.h
> b/tests/tcg/multiarch/nop_func.h
> index f714d210000..26d3a76eb62 100644
> --- a/tests/tcg/multiarch/nop_func.h
> +++ b/tests/tcg/multiarch/nop_func.h
> @@ -15,7 +15,7 @@ static const char nop_func[] =3D {
>      0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
>  #elif defined(__riscv)
>      0x67, 0x80, 0x00, 0x00,     /* ret */
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>      0x07, 0xfe,                 /* br %r14 */
>  #elif defined(__i386__) || defined(__x86_64__)
>      0xc3,                       /* ret */
> diff --git a/block/file-posix.c b/block/file-posix.c
> index e49b13d6abb..5019ddade9b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -79,7 +79,7 @@
>  #include <linux/hdreg.h>
>  #include <linux/magic.h>
>  #include <scsi/sg.h>
> -#ifdef __s390__
> +#ifdef __s390x__
>  #include <asm/dasd.h>
>  #endif
>  #ifndef FS_NOCOW_FL
> diff --git a/disas/disas-host.c b/disas/disas-host.c
> index 7cf432938e0..d41235250a0 100644
> --- a/disas/disas-host.c
> +++ b/disas/disas-host.c
> @@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)
>      s->info.print_insn =3D print_insn_little_mips;
>  #elif defined(__m68k__)
>      s->info.print_insn =3D print_insn_m68k;
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>      s->info.cap_arch =3D CS_ARCH_SYSZ;
>      s->info.cap_insn_unit =3D 2;
>      s->info.cap_insn_split =3D 6;
> diff --git a/util/cacheflush.c b/util/cacheflush.c
> index c043c5f881a..77440ddb478 100644
> --- a/util/cacheflush.c
> +++ b/util/cacheflush.c
> @@ -223,7 +223,7 @@ static void __attribute__((constructor))
> init_cache_info(void)
>   * Architecture (+ OS) specific cache flushing mechanisms.
>   */
>
> -#if defined(__x86_64__) || defined(__s390__)
> +#if defined(__x86_64__) || defined(__s390x__)
>
>  /* Caches are coherent and do not require flushing; symbol inline. */
>
> --
> 2.53.0
>
>

--00000000000037e64706522d65aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 19 mag 2026, 16:59 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">We still build QEMU tools on 32-bit hosts (see com=
mit<br>
cf634dfcd8f), however no OS supported by QEMU still runs<br>
on ESA/390 (Linux dropped support in release 4.1 in 2015).<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">If Linux still su=
pports 31-bit *userspace binaries*, I would keep the configure check, so th=
at 32-bit s390 is properly detected as an unsupported CPU:</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">elif check_define __s390__ ; then<br>=
=C2=A0 if check_define __s390x__ ; then<br>=C2=A0 =C2=A0 cpu=3D&quot;s390x&=
quot;<br>=C2=A0 else<br>=C2=A0 =C2=A0 cpu=3D&quot;s390&quot;<br>=C2=A0 fi<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">an=
d perhaps keep the CPU_CFLAGS only from the other hunk:</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">=C2=A0 s390)<br>=C2=A0 =C2=A0 linux_arch=
=3Ds390<br>=C2=A0 =C2=A0 CPU_CFLAGS=3D&quot;-m31&quot;<br>=C2=A0 =C2=A0 ;;<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
=C2=A0 =C2=A0s390x)<br>
=C2=A0 =C2=A0 =C2=A0host_arch=3Ds390x<br>
=C2=A0 =C2=A0 =C2=A0linux_arch=3Ds390<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">The rest is fine.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h<br>
index 8c64b878145..0618966ddde 100644<br>
--- a/include/qemu/cacheflush.h<br>
+++ b/include/qemu/cacheflush.h<br>
@@ -19,7 +19,7 @@<br>
=C2=A0 * mappings of the same physical page(s).<br>
=C2=A0 */<br>
<br>
-#if defined(__x86_64__) || defined(__s390__)<br>
+#if defined(__x86_64__) || defined(__s390x__)<br>
<br>
=C2=A0static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, si=
ze_t len)<br>
=C2=A0{<br>
diff --git a/include/qemu/timer.h b/include/qemu/timer.h<br>
index b931181f53d..fc021f8f966 100644<br>
--- a/include/qemu/timer.h<br>
+++ b/include/qemu/timer.h<br>
@@ -889,7 +889,7 @@ static inline int64_t cpu_get_host_ticks(void)<br>
=C2=A0 =C2=A0 =C2=A0return val;<br>
=C2=A0}<br>
<br>
-#elif defined(__s390__)<br>
+#elif defined(__s390x__)<br>
<br>
=C2=A0static inline int64_t cpu_get_host_ticks(void)<br>
=C2=A0{<br>
diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_func.=
h<br>
index f714d210000..26d3a76eb62 100644<br>
--- a/tests/tcg/multiarch/nop_func.h<br>
+++ b/tests/tcg/multiarch/nop_func.h<br>
@@ -15,7 +15,7 @@ static const char nop_func[] =3D {<br>
=C2=A0 =C2=A0 =C2=A00x1e, 0xff, 0x2f, 0xe1,=C2=A0 =C2=A0 =C2=A0/* bx lr */<=
br>
=C2=A0#elif defined(__riscv)<br>
=C2=A0 =C2=A0 =C2=A00x67, 0x80, 0x00, 0x00,=C2=A0 =C2=A0 =C2=A0/* ret */<br=
>
-#elif defined(__s390__)<br>
+#elif defined(__s390x__)<br>
=C2=A0 =C2=A0 =C2=A00x07, 0xfe,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* br %r14 */<br>
=C2=A0#elif defined(__i386__) || defined(__x86_64__)<br>
=C2=A0 =C2=A0 =C2=A00xc3,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ret */<br>
diff --git a/block/file-posix.c b/block/file-posix.c<br>
index e49b13d6abb..5019ddade9b 100644<br>
--- a/block/file-posix.c<br>
+++ b/block/file-posix.c<br>
@@ -79,7 +79,7 @@<br>
=C2=A0#include &lt;linux/hdreg.h&gt;<br>
=C2=A0#include &lt;linux/magic.h&gt;<br>
=C2=A0#include &lt;scsi/sg.h&gt;<br>
-#ifdef __s390__<br>
+#ifdef __s390x__<br>
=C2=A0#include &lt;asm/dasd.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#ifndef FS_NOCOW_FL<br>
diff --git a/disas/disas-host.c b/disas/disas-host.c<br>
index 7cf432938e0..d41235250a0 100644<br>
--- a/disas/disas-host.c<br>
+++ b/disas/disas-host.c<br>
@@ -74,7 +74,7 @@ static void initialize_debug_host(CPUDebug *s)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;info.print_insn =3D print_insn_little_mips;<br>
=C2=A0#elif defined(__m68k__)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;info.print_insn =3D print_insn_m68k;<br>
-#elif defined(__s390__)<br>
+#elif defined(__s390x__)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;info.cap_arch =3D CS_ARCH_SYSZ;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;info.cap_insn_unit =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;info.cap_insn_split =3D 6;<br>
diff --git a/util/cacheflush.c b/util/cacheflush.c<br>
index c043c5f881a..77440ddb478 100644<br>
--- a/util/cacheflush.c<br>
+++ b/util/cacheflush.c<br>
@@ -223,7 +223,7 @@ static void __attribute__((constructor)) init_cache_inf=
o(void)<br>
=C2=A0 * Architecture (+ OS) specific cache flushing mechanisms.<br>
=C2=A0 */<br>
<br>
-#if defined(__x86_64__) || defined(__s390__)<br>
+#if defined(__x86_64__) || defined(__s390x__)<br>
<br>
=C2=A0/* Caches are coherent and do not require flushing; symbol inline. */=
<br>
<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div></div>

--00000000000037e64706522d65aa--


