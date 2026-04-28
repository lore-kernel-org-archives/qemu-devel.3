Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB83FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfdz-0007rz-SD; Tue, 28 Apr 2026 06:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfdy-0007r6-GL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:26:18 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfdw-0004Mb-VL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:26:18 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65006c99d38so10182854d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777371976; cv=none;
 d=google.com; s=arc-20240605;
 b=RThd3Ajl+TFmQ6ej36fCuZhjKocy8TGFmSZBlCjXSj0NCVFixGH4u7KqWbmWVDRMeK
 RyVA09xG0TOkiZ+70mj0d3mB4Mi2S/Rema2oBN4RxlOgtZxctEdoGjppTao1xyKjqDxi
 +nVw4TLsa8ry9VXmFDAPSLOATFKPOMgV2vlW/s+1U30GCzXwg+aaF/NmdJtDq38GyC58
 ceWI+BsJSVnw/mx3J+TuIzKeXDph6jn72b+L2la1XQ96WlmevTUsAMtY7rIHUv+HuZ/c
 hy2zNQZxxSYs4sCQXUtCaj1frCb+SFWiorUiqSvRTKaOx8gAs8atXnxhpiLqmXixzQdy
 qUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bNYuY+mpqB9tvsQdv75FUl/u/ykE7yH04LUmseV2WuA=;
 fh=Wx9lP9KQCr/8T/aA0zVmV2r0ZF0yKqo5FrZtAofl334=;
 b=XuS4zBV5zuxHaDe47imdaRhCAu+noul7fbcrn63qYEk0fd/k3OHBMBQHsUOSTjuldn
 uTloToql6zKmCjG7w2lLQ5w/t7krDgzhtd9S2ed9konHAv94lCmDe3UOt+LpEQgS3Sq5
 /s1teH4mXZLyxQntgPOEiUeHVsERc+NgsCuRNaRr/0Voaqoo78bZFWELbkP28PfiuhDp
 01tDeZIuW9NCEsS11osm+/wCreX2fEYGr6GtVyWLQk39/NifDF58dZX9smhY6P/1Tyl+
 caoJUh7eGUkYvtjMK5Tebdv4PBqPYQAQcsESuRYzr5G2ky20+o9s2Yi+5cVUOP8C2xjz
 Iw1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777371976; x=1777976776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bNYuY+mpqB9tvsQdv75FUl/u/ykE7yH04LUmseV2WuA=;
 b=Ok+hUxiXN4yYoDdVO90FJc2Okdz3P8sYPXVArTttI5wyVdLKgpHq6rbXO9lfWWfKiw
 ZoAZM9DOcT1EZ0OeirT/HQ/mUp9pAhayx5bAQsy4I7WEedIiZhRx1Wh4kFAnb2NGZaiL
 TIrkioqIXpJcF6L9v1jUyeZ449ArzcRA0cCAczpPYILXmwlbv28N8tNyO0PkyEjKu933
 mHe9YyFKdFV9RtmpUoq4cNDxyAu703pL8KBJoJIzyJIvQax2fSCe74cOx8RsXOKsFy8W
 T9xAzuSv7hYbAbDvwjHcaQylZ/lYazgn1zUo6fQ9NPPGAsqtmlEbc0dp4Z39ywz9X4Df
 O+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777371976; x=1777976776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNYuY+mpqB9tvsQdv75FUl/u/ykE7yH04LUmseV2WuA=;
 b=InE+5M7MY6NVusXNkjkREQZZGwnZbB4pYqEaej+4D1drIBR78NEvinGWRnVnRaGejQ
 o/SD41oMTurndtSCbYOdb7KSWREJWR22eYrUCQxjmL8Bd4GVTB2A/++lw+QLjhkrD1cJ
 6DxEKh66Ac09ocTdVRUL09816MPzz2Oyu/nJMjf2g2QoOemPMoQtJJ1DpI48UzB7Yvqj
 vxgS5S40FOtYHY1iyncgW9x4/eJWyeyohRTMLNWBB7aI4PAFBnp/KV6GUXowcjJOSHtA
 0h4ZT053oV50LvmIBlFqkH8dxN8/zZRXdbBaYhZ02s4TwNB1iVyf6Aq4cN0qgwtSVFjm
 bOAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0Lfx7XhU3Nab/1hz1W8FySSdGT7mB/vzZbUOsrQSYzxzenWAIMjldwJm4x4kouo9HOBBIuL0ZI7z1@nongnu.org
X-Gm-Message-State: AOJu0YxdBgLlWG7C44d/wFqyfjyIF2tXvkGsp2eQZavzyRxQPvhSZ9h8
 gBpoLzzDauyfLP3g4OXSoVZ/NfH5dk1Gttr/r7D8/6TmyGIgelTulR4YtLqeIlgb5lQpHcpyrQG
 C1AryH2Yvgg/7Ow3Wf8fFKToG/bZxILqWrlMmdWYl4w==
X-Gm-Gg: AeBDieukt09H29BGk1vMoSAId8nXqgROfiSj8jwu1dhmjM6qFGPOSabUDqEb9K3njqs
 NL+pAkBJAPBs2CqnllstfeIEC56wD1lV5eI7gMTNOKYupIYB6FKLww0+iGVXSUuQq4DE6rjuxMS
 a/0ZHAq6I6RMKhn+wGGMw1CiTUKCw0nvBEsnyT3gQevriMpNIM0Qy7F1qnkcjklOl71NyJnCa0h
 5I+g4pPRiEdmpTliZqUKC03rUtmlheELRhLbcfPH+phE3oT/YOwPL4YloOaN891JPCjjqRjmwMP
 GCB+K6MxrZDrEvJkQywpNj5iGkivwVmEfFBe80Hwm0TMNZiBiOtp9c1iZTPbknwsoU5mI4EdPxX
 Bxg==
X-Received: by 2002:a05:690e:1406:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-65beeba511amr1996675d50.0.1777371975587; Tue, 28 Apr 2026
 03:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-17-peter.maydell@linaro.org>
 <44df274b-6179-4e63-aee4-1e29ad5f4b23@linaro.org>
In-Reply-To: <44df274b-6179-4e63-aee4-1e29ad5f4b23@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 11:26:01 +0100
X-Gm-Features: AVHnY4JOrdpIlO27eYt75ZDtPg1k4zS9uDE0SB4DBSEbiX4Ru8l4hWpH_ip6_yQ
Message-ID: <CAFEAcA8fXkUmcLd0D09GWR66fnDEe_PdnFnUvvvctCaqma8iRQ@mail.gmail.com>
Subject: Re: [PATCH 16/17] target/arm: Implement translate_for_debug
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 23 Apr 2026 at 04:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/18/26 03:31, Peter Maydell wrote:
> > @@ -3935,25 +3936,30 @@ static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
> >       GetPhysAddrResult res = {};
> >       ARMMMUFaultInfo fi = {};
> >       bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
> > -    *attrs = res.f.attrs;
> >
> > -    if (ret) {
> > -        return -1;
> > +    if (!ret) {
> > +        /* translation succeeded */
> > +        result->physaddr = res.f.phys_addr;
> > +        result->attrs = res.f.attrs;
> > +        result->lg_page_size = res.f.lg_page_size;
> >       }
> > -    return res.f.phys_addr;
> > +    return ret;
> >   }
>
> Inverted return value.
> This would be obvious with s/ret/fault/.

This function returns true on fault, matching the other
get_phys_addr functions in this file, so "return ret" is
what I intended here.

arm_cpu_translate_for_debug() returns true on success, which
is the opposite convention, so it does:

     if (!arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
         return true;
     }
so as to return true if arm_cpu_get_phys_addr returns false
(the successful-translation case).

I agree that this is confusing, but that's why I put the comments
in and the commit message. I had a choice of making the
translate_for_debug() function follow the existing
tlb_fill_align() convention or the one we use here in ptw.c,
and I picked the former. That leaves us having to do a
flip-the-sense-of-the-boolean somewhere, unless we want to
redo all of ptw.c to use true-for-success instead.

-- PMM

