Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32803C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzTgV-0006QN-Gc; Thu, 27 Aug 2026 02:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzTgU-0006QF-9r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 02:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzTgS-0006Oo-12
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 02:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787812434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlEzQRTbqSzgD3EGaM7i1P31WxVFYksqqp3IuoQymog=;
 b=iiqHYLWzpqUAitvf89veHRqBa5kh+GGVukeaA07MWxpI+/zLnifhhFwYeQWfXfGPy0puDB
 1sen/5hiFs+hg1thdbrgTACRSN8g6LtSb3qz1F0t1emrifKQFD7hpX0kT/1sMIVeWv/DFu
 BWqTf0rkREofB0sfbFGOQDmmPfDCDWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-OiZzo6klM_-fEfqdvYQ5Ww-1; Thu, 27 Aug 2026 02:33:52 -0400
X-MC-Unique: OiZzo6klM_-fEfqdvYQ5Ww-1
X-Mimecast-MFC-AGG-ID: OiZzo6klM_-fEfqdvYQ5Ww_1787812431
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso15429945e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 23:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787812431; cv=none;
 d=google.com; s=arc-20260327;
 b=gFGxdRpPJpKyZhbl7p3xww0Cpz9rtCnsnn6AUo3Z0zLqiiRDDFhbfppCNKfg3wUHLP
 70s3OMQRgYj2H7YYiT660Amzk8I4vRN02Al/09H6gcz9Sb0qhk54njqf3HGy6dU73BUK
 xLU8rCh0AfgaP421wwM8f4QzV7orXRgSvVp7ALJmCZGT3eNsPpeF5X+r3NdBx9i/hwNv
 TKiLFmKpf6cAul1V5AJ7MH9McG+ZPjBerYbEbVIPNHikDQ+ZZ2P0eCp4G1ot+BM1zQCj
 /NwksG6uotEiK7jIaLQvuLf78yzHuy8j5xVvu4ZWhZKuLnwT3fKR8Q62ieutYfqyiqOu
 0faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dlEzQRTbqSzgD3EGaM7i1P31WxVFYksqqp3IuoQymog=;
 fh=aFyggM+vyEpkumngkZSAxzM0X2BIIJIDRk0BPTs9m5I=;
 b=MIVWr7lfv+wWbVoK4e85j3e7Ctj17UD40URYB6E8oc4/hkGMkiiK7ayYUMN3/pEfta
 4JqQxXh008Z1+5rMo3s4AvJgWl8+1aZKjuIDb1oy16xtXpzkA8BegOaDmGHnEFM8lzs8
 KbOIJaO9FzyW5ClcF/PlfvFW8MiNhpT2Gi4Gk6EioYn5eebCsGsQqZLbd17hm7phcUbN
 qweRjjw5rcj19HPSYJAvvWAXvoPzKneOX+CcTzXiubhoUlHIFesldt/Oc3XOEuyJ7tXi
 LhMSlDf0glaZOlXwFRJ5W9e/h5yL2lE84CmbRaqwpAeFkBsDXSCemEhEtiReUruTzQJb
 Fplg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787812431; x=1788417231; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dlEzQRTbqSzgD3EGaM7i1P31WxVFYksqqp3IuoQymog=;
 b=WS69Cnc2F46JkKI0iAnaSOYfL6V4C4W9O6p9kDHwC3xgCEBJs35ZnAeTkce3xkCbp1
 /tf4uulpzCHAAOiI8ZupwqMshhNibS/mf+IuA2DuOZKL71STPKBL1f++XNKmLRmu/bha
 VdlqOVEkk5pnjljctH9z6NLzEtSGSSycxyy/Na83XUCPlHEGjkD2oqfBDH+91sNQlmL+
 OYp5UcIgO+o2+qQyq71Fu2ejrcvgFlaO0KRk/xz9gRQYV6fgM3LvKo4FitjqDj813CBB
 yLgPFFkp1cHyXWm2OydcHlSGm84QU8e3r47N+KoEbijoS3t7p+Jf2JVSTWORnA5iUPgB
 OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787812431; x=1788417231;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dlEzQRTbqSzgD3EGaM7i1P31WxVFYksqqp3IuoQymog=;
 b=m77SsJVJgnkl1hHa3XSKvAVoeNROFysngRpvw1uL7NKBU0eB9WlGWYh8ZRfzjmMboX
 bT6KdflidoLyUKKgiC6nwn4rtNoc4cabc+/ktQYCxtV+OeBLAhDTAHnghjK7ATHHIYWY
 WxMV8oYXshcnLlIb5OuG1Kdpr6IUeTzhu5d6i53aXhSkDpV1iizd46xNPkX2DE2wqiS0
 wFo9yofUV8yg9LMrLucVxFA4hIiA3O2nu43ImWRy+m0W1d4JcCBvW38o+laYXUx1wDk+
 422BxW+b02HTYoxq0mABnJwkPaGWwJN6QGNYjVc+/G3gaSu1FptTk1A/EGXtOISF5K0Z
 MGvQ==
X-Gm-Message-State: AFuF++luc9Tf/RFmMkXp710BxIJYFOoOgr2Xw7kLqunMttSVbLA5k5NR
 VA+zr2wA7K8LtPrjCaLVehhitaG+Ht3l9mDkc17eF6udIk//8CDSwCSuxtWBa0/XpVRkyfQSzRk
 6vNXe/HVBmEcQUfypJjRPeY7jOVmhl3mxIjSKq/xQm2FNT6svvMUxPPL3nHseGIx38QiPqG2n5S
 SgJyuNabpWrTzCnFUvG8Bkfssjx5gly5w=
X-Gm-Gg: AR+sD13z2zZ/sL2JNsAESkUdONLqowTXPKriZWTgjgDs54CaRl2DidvKICLD5nd23cA
 Cthv8x8bX/7IpCrR2fuvH1aiRn3Gj/l9yf/41hsnVfl66j2hTiA3TwvBALFlFSKHd7r7A/X6lfn
 xPVftrbMEbasZcfMVllelzm53SiFi2JOBkev9BC+iIEfGpbbunH8jERlsIEQSBWdDT2mXjbfkG5
 rVma4lj01Ys/BiIFRbhGA2CAX04i/ckjQ/KcuwDIQPDSxcKRAUB+aG8zlS5
X-Received: by 2002:a05:600c:698c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499dc6f5dcdmr148048485e9.5.1787812430933; 
 Wed, 26 Aug 2026 23:33:50 -0700 (PDT)
X-Received: by 2002:a05:600c:698c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499dc6f5dcdmr148047385e9.5.1787812430521; Wed, 26 Aug 2026
 23:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-11-pbonzini@redhat.com>
 <ao74cFO91SLv9WVB@intel.com>
In-Reply-To: <ao74cFO91SLv9WVB@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2026 08:33:38 +0200
X-Gm-Features: AcwNN1VCW-5K4qPznoV17Q9zsEiesjos6u7yVXQ9OLmqL0G1-M4W_3i_AbAgCE4
Message-ID: <CABgObfbNcFKjF7HXsfR_uZU9+RSZO6D8Y=vVWSuuSN-=zP6hBg@mail.gmail.com>
Subject: Re: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d8ba7a065a01843c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000d8ba7a065a01843c
Content-Type: text/plain; charset="UTF-8"

Il mer 26 ago 2026, 16:31 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> On Tue, Aug 25, 2026 at 02:29:11PM +0200, Paolo Bonzini wrote:
> > Date: Tue, 25 Aug 2026 14:29:11 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction
> > X-Mailer: git-send-email 2.55.0
> >
> > This is the same as an indirect jump, just with immediate operand.
> > The requirement of W=0 and 0x67 are already available in the decoder.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  target/i386/tcg/decode-new.h     | 3 +++
> >  target/i386/tcg/decode-new.c.inc | 4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> > index c974ca9d7c5..4998712e86d 100644
> > --- a/target/i386/tcg/decode-new.h
> > +++ b/target/i386/tcg/decode-new.h
> > @@ -184,6 +184,9 @@ typedef enum X86InsnCheck {
> >
> >      /* No REX2 prefix allowed */
> >      X86_CHECK_no_rex2 = 8192,
> > +
> > +    /* No 0x67 prefix allowed */
> > +    X86_CHECK_no_adr = 16384,
> >  } X86InsnCheck;
> >
> >  typedef enum X86InsnSpecial {
> > diff --git a/target/i386/tcg/decode-new.c.inc
> b/target/i386/tcg/decode-new.c.inc
> > index 1f59fd665f7..d215d28cec5 100644
> > --- a/target/i386/tcg/decode-new.c.inc
> > +++ b/target/i386/tcg/decode-new.c.inc
> > @@ -1991,6 +1991,7 @@ static const X86OpEntry opcodes_root[256] = {
> >
> >  #ifdef TARGET_X86_64
> >  static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
> > +    [1] = X86_OP_ENTRY1(JMP_m,   I,q, p_00 chk2(W0, no_adr)),
> >  };
>
> Maybe it should use X86_OP_ENTRYr? since JMPABS doesn't need to write
> back.
>

Absolutely, thanks Zhao!

Paolo


> Just a simple test:
>
> #include <stdio.h>
>
> int main(void)
> {
>     __asm__ volatile (
>         /* JMPABS: REX2(M0=0,W=0) = D5 00, opcode A1, then imm64 target */
>         ".byte 0xd5, 0x00, 0xa1\n\t"
>         ".quad  1f\n\t"
>         "ud2\n\t"          /* this should be skipped */
>         "1:\n\t");
>     puts("JMPABS -- OK");
>     return 0;
> }
>
> And this hits an abort():
>
> $ ./build/qemu-x86_64 /tmp/jmpabs
> **
> ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code should not be
> reached
> Bail out! ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code
> should not be reached
> Aborted (core dumped)
>
> more GDB backtrace:
>
> Thread 1 "qemu-x86_64" received signal SIGABRT, Aborted.
> __pthread_kill_implementation (no_tid=0, signo=6,
> threadid=140737352460800) at ./nptl/pthread_kill.c:44
> 44      ./nptl/pthread_kill.c: No such file or directory.
> #0  __pthread_kill_implementation (no_tid=0, signo=6,
> threadid=140737352460800) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=140737352460800) at
> ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=140737352460800, signo=signo@entry=6)
> at ./nptl/pthread_kill.c:89
> #3  0x00007ffff7242476 in __GI_raise (sig=sig@entry=6) at
> ../sysdeps/posix/raise.c:26
> #4  0x00007ffff72287f3 in __GI_abort () at ./stdlib/abort.c:79
> #5  0x00007ffff76e3b57 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #6  0x00007ffff773d70f in g_assertion_message_expr () from
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #7  0x0000555555664f37 in gen_writeback (s=s@entry=0x7fffffffd240,
> decode=decode@entry=0x7fffffffd0b0, opn=opn@entry=0, v=<optimized out>)
> at ../target/i386/tcg/emit.c.inc:380
> #8  0x0000555555677778 in disas_insn (cpu=0x55555593e780,
> s=0x7fffffffd240) at ../target/i386/tcg/decode-new.c.inc:3682
> #9  i386_tr_translate_insn (dcbase=0x7fffffffd240, cpu=0x55555593e780) at
> ../target/i386/tcg/translate.c:3608
> #10 0x00005555555d7962 in translator_loop (cpu=0x55555593e780,
> tb=0x7fffe80d0700 <code_gen_buffer+853715>, max_insns=0x7fffffffd4cc,
> pc=<optimized out>, host_pc=<optimized out>, ops=ops@entry=0x5555557dc5a0
> <i386_tr_ops>, db=0x7fffffffd240, addr_type=TCG_TYPE_I64) at
> ../accel/tcg/translator.c:178
> #11 0x000055555567b212 in x86_translate_code (cpu=<optimized out>,
> tb=<optimized out>, max_insns=<optimized out>, pc=<optimized out>,
> host_pc=<optimized out>) at ../target/i386/tcg/translate.c:3699
> #12 0x00005555555d6644 in setjmp_gen_code (env=env@entry=0x5555559427f0,
> tb=tb@entry=0x7fffe80d0700 <code_gen_buffer+853715>, pc=pc@entry=4198710,
> host_pc=0x401136, max_insns=max_insns@entry=0x7fffffffd4cc, ti=<optimized
> out>) at ../accel/tcg/translate-all.c:251
> #13 0x00005555555d6b0e in tb_gen_code (cpu=cpu@entry=0x55555593e780,
> s=...) at ../accel/tcg/translate-all.c:324
> #14 0x00005555555cec1a in cpu_exec_loop (cpu=cpu@entry=0x55555593e780,
> sc=<optimized out>) at ../accel/tcg/cpu-exec.c:973
> #15 0x00005555555ced99 in cpu_exec_setjmp (cpu=cpu@entry=0x55555593e780,
> sc=<optimized out>) at ../accel/tcg/cpu-exec.c:1019
> #16 0x00005555555cf381 in cpu_exec (cpu=cpu@entry=0x55555593e780) at
> ../accel/tcg/cpu-exec.c:1045
> #17 0x0000555555622c80 in cpu_loop (env=env@entry=0x5555559427f0) at
> ../linux-user/x86_64/../i386/cpu_loop.c:217
> #18 0x00005555555a1d17 in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>) at ../linux-user/main.c:1010
>
> Regards,
> Zhao
>
>

--000000000000d8ba7a065a01843c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 26 ago 2026, 16:31 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, Aug 25, 2026 at 02:29:11PM +0200, Paolo Bonzini wrote:<br>
&gt; Date: Tue, 25 Aug 2026 14:29:11 +0200<br>
&gt; From: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Subject: [PATCH 10/20] target/i386/tcg: implement JMPABS instruction<b=
r>
&gt; X-Mailer: git-send-email 2.55.0<br>
&gt; <br>
&gt; This is the same as an indirect jump, just with immediate operand.<br>
&gt; The requirement of W=3D0 and 0x67 are already available in the decoder=
.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/tcg/decode-new.h=C2=A0 =C2=A0 =C2=A0| 3 +++<br>
&gt;=C2=A0 target/i386/tcg/decode-new.c.inc | 4 ++++<br>
&gt;=C2=A0 2 files changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new=
.h<br>
&gt; index c974ca9d7c5..4998712e86d 100644<br>
&gt; --- a/target/i386/tcg/decode-new.h<br>
&gt; +++ b/target/i386/tcg/decode-new.h<br>
&gt; @@ -184,6 +184,9 @@ typedef enum X86InsnCheck {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* No REX2 prefix allowed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 X86_CHECK_no_rex2 =3D 8192,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* No 0x67 prefix allowed */<br>
&gt; +=C2=A0 =C2=A0 X86_CHECK_no_adr =3D 16384,<br>
&gt;=C2=A0 } X86InsnCheck;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef enum X86InsnSpecial {<br>
&gt; diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode=
-new.c.inc<br>
&gt; index 1f59fd665f7..d215d28cec5 100644<br>
&gt; --- a/target/i386/tcg/decode-new.c.inc<br>
&gt; +++ b/target/i386/tcg/decode-new.c.inc<br>
&gt; @@ -1991,6 +1991,7 @@ static const X86OpEntry opcodes_root[256] =3D {<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifdef TARGET_X86_64<br>
&gt;=C2=A0 static const X86OpEntry opcodes_rex2_map0_A0toAF[16] =3D {<br>
&gt; +=C2=A0 =C2=A0 [1] =3D X86_OP_ENTRY1(JMP_m,=C2=A0 =C2=A0I,q, p_00 chk2=
(W0, no_adr)),<br>
&gt;=C2=A0 };<br>
<br>
Maybe it should use X86_OP_ENTRYr? since JMPABS doesn&#39;t need to write<b=
r>
back.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Absolutely, thanks Zhao!</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Just a simple test:<br>
<br>
#include &lt;stdio.h&gt;<br>
<br>
int main(void)<br>
{<br>
=C2=A0 =C2=A0 __asm__ volatile (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* JMPABS: REX2(M0=3D0,W=3D0) =3D D5 00, opcode=
 A1, then imm64 target */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.byte 0xd5, 0x00, 0xa1\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.quad=C2=A0 1f\n\t&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ud2\n\t&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* this should be skipped */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;1:\n\t&quot;);<br>
=C2=A0 =C2=A0 puts(&quot;JMPABS -- OK&quot;);<br>
=C2=A0 =C2=A0 return 0;<br>
}<br>
<br>
And this hits an abort():<br>
<br>
$ ./build/qemu-x86_64 /tmp/jmpabs<br>
**<br>
ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code should not be r=
eached<br>
Bail out! ERROR:../target/i386/tcg/emit.c.inc:380:gen_writeback: code shoul=
d not be reached<br>
Aborted (core dumped)<br>
<br>
more GDB backtrace:<br>
<br>
Thread 1 &quot;qemu-x86_64&quot; received signal SIGABRT, Aborted.<br>
__pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D1407373524=
60800) at ./nptl/pthread_kill.c:44<br>
44=C2=A0 =C2=A0 =C2=A0 ./nptl/pthread_kill.c: No such file or directory.<br=
>
#0=C2=A0 __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D1=
40737352460800) at ./nptl/pthread_kill.c:44<br>
#1=C2=A0 __pthread_kill_internal (signo=3D6, threadid=3D140737352460800) at=
 ./nptl/pthread_kill.c:78<br>
#2=C2=A0 __GI___pthread_kill (threadid=3D140737352460800, signo=3Dsigno@ent=
ry=3D6) at ./nptl/pthread_kill.c:89<br>
#3=C2=A0 0x00007ffff7242476 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26<br>
#4=C2=A0 0x00007ffff72287f3 in __GI_abort () at ./stdlib/abort.c:79<br>
#5=C2=A0 0x00007ffff76e3b57 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0=
.so.0<br>
#6=C2=A0 0x00007ffff773d70f in g_assertion_message_expr () from /lib/x86_64=
-linux-gnu/libglib-2.0.so.0<br>
#7=C2=A0 0x0000555555664f37 in gen_writeback (s=3Ds@entry=3D0x7fffffffd240,=
 decode=3Ddecode@entry=3D0x7fffffffd0b0, opn=3Dopn@entry=3D0, v=3D&lt;optim=
ized out&gt;) at ../target/i386/tcg/emit.c.inc:380<br>
#8=C2=A0 0x0000555555677778 in disas_insn (cpu=3D0x55555593e780, s=3D0x7fff=
ffffd240) at ../target/i386/tcg/decode-new.c.inc:3682<br>
#9=C2=A0 i386_tr_translate_insn (dcbase=3D0x7fffffffd240, cpu=3D0x55555593e=
780) at ../target/i386/tcg/translate.c:3608<br>
#10 0x00005555555d7962 in translator_loop (cpu=3D0x55555593e780, tb=3D0x7ff=
fe80d0700 &lt;code_gen_buffer+853715&gt;, max_insns=3D0x7fffffffd4cc, pc=3D=
&lt;optimized out&gt;, host_pc=3D&lt;optimized out&gt;, ops=3Dops@entry=3D0=
x5555557dc5a0 &lt;i386_tr_ops&gt;, db=3D0x7fffffffd240, addr_type=3DTCG_TYP=
E_I64) at ../accel/tcg/translator.c:178<br>
#11 0x000055555567b212 in x86_translate_code (cpu=3D&lt;optimized out&gt;, =
tb=3D&lt;optimized out&gt;, max_insns=3D&lt;optimized out&gt;, pc=3D&lt;opt=
imized out&gt;, host_pc=3D&lt;optimized out&gt;) at ../target/i386/tcg/tran=
slate.c:3699<br>
#12 0x00005555555d6644 in setjmp_gen_code (env=3Denv@entry=3D0x5555559427f0=
, tb=3Dtb@entry=3D0x7fffe80d0700 &lt;code_gen_buffer+853715&gt;, pc=3Dpc@en=
try=3D4198710, host_pc=3D0x401136, max_insns=3Dmax_insns@entry=3D0x7fffffff=
d4cc, ti=3D&lt;optimized out&gt;) at ../accel/tcg/translate-all.c:251<br>
#13 0x00005555555d6b0e in tb_gen_code (cpu=3Dcpu@entry=3D0x55555593e780, s=
=3D...) at ../accel/tcg/translate-all.c:324<br>
#14 0x00005555555cec1a in cpu_exec_loop (cpu=3Dcpu@entry=3D0x55555593e780, =
sc=3D&lt;optimized out&gt;) at ../accel/tcg/cpu-exec.c:973<br>
#15 0x00005555555ced99 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x55555593e780=
, sc=3D&lt;optimized out&gt;) at ../accel/tcg/cpu-exec.c:1019<br>
#16 0x00005555555cf381 in cpu_exec (cpu=3Dcpu@entry=3D0x55555593e780) at ..=
/accel/tcg/cpu-exec.c:1045<br>
#17 0x0000555555622c80 in cpu_loop (env=3Denv@entry=3D0x5555559427f0) at ..=
/linux-user/x86_64/../i386/cpu_loop.c:217<br>
#18 0x00005555555a1d17 in main (argc=3D&lt;optimized out&gt;, argv=3D&lt;op=
timized out&gt;, envp=3D&lt;optimized out&gt;) at ../linux-user/main.c:1010=
<br>
<br>
Regards,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--000000000000d8ba7a065a01843c--


