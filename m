Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A548CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 00:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG3Vq-00074f-GE; Sun, 11 Oct 2026 20:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xG3Vj-000739-3S
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 20:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xG3Vg-0002i6-Fh
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 20:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791763397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jb8035J+llImyYwQKUAuCTpXCQElyZYTaxv1sXeqoM=;
 b=Zbsc1+Ge5zrF4spVgUDO0C/BYlppC6b/plakBHr7RzEN4+6SpMms6L70cdWN6Rog/Mgjyd
 9BhGKg4ePWTKFEJ1XL+ePoS6C4jokmI9sbc6TY5HKCU9XZT8CvZJSEZ3gkICpP14STfSYi
 VWXvTGp0VqqEUtX+KlLTAzwRJyMZQ3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2PFoLnDPMCqtDFqO0IvIog-1; Mon, 12 Oct 2026 00:03:16 +0000
X-MC-Unique: 2PFoLnDPMCqtDFqO0IvIog-1
X-Mimecast-MFC-AGG-ID: 2PFoLnDPMCqtDFqO0IvIog_1791763395
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b028d93c5so908629f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 17:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791763395; cv=none;
 d=google.com; s=arc-20260327;
 b=du4cODt8587Vj42h6RbSnyJhFS10McQrE0A0gFmnBkVwrtYL0Jna69U+X7wJ72HxJT
 5zDLpPEaPK/kFqpO30G1VYOeTWlyN1jDLb2CdmGITakT4iYw4C65xk8W9du85uFzX+1g
 SVnBOcJ+ZeqdPwlGjb5rEmGYjXncfuQy8oM4L4tJHYcevruzPwJt6kMhHRKFApTwmqY9
 dOvAyI3+ZCVwHHcG00hEN391fg1kkX7UvD80CsbIydjoBXWZAyAbJHsfK3z2levoSRcM
 7jy9v9ttn0zvqZoRmML3/UX2cYADG7XgGS5a62c/rVNuYDDRKIisTzw2dGexNudu3J9o
 gyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/jb8035J+llImyYwQKUAuCTpXCQElyZYTaxv1sXeqoM=;
 fh=LrIvmb3DIlMHuFKK2BJCAp+COKfuDr6etANSdFTdSus=;
 b=jSRaDMZ5Jzhyc2cZtkAD779Zi7g8SYNKPImjlgBL7louQw5cRNSbPXZVai8Wi3RVqM
 iKrv56OqxabTzFFUik0GImGzNMERT8OPFv+Hb0DwlIq+K7jdLUz99JbTxnzcX7ve5BKm
 EaqVF/BW+sjK9W+GFL6N91zOkG7BV+gPOkFTn8vDAGx89HP+WPvHEsFC2EdGPbyBD7wO
 yVUjq4XUfYuGm18ZPc+l2k5asWntQgMdGhx8O7S0pkFNzfTtW8HxEu+dpPuI++pgO52D
 A2P6GpxXyzWQQR8vxg9/Z4sP0ecjGMkYwFMJlapPh8LqR+qP4C3Lcbg+iYy3t8caWwVc
 0B8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791763395; x=1792368195; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/jb8035J+llImyYwQKUAuCTpXCQElyZYTaxv1sXeqoM=;
 b=tSP2GGXCxN7+Q4+AY8WODy5nxaOvW+YavQAojFi4DMxnJUptJ8h9N9C/iCQi6rhZUl
 s8fWThdsp38bQxZUNnjORK+iQBrPCb5/c7a22T1UqiXxPReOtGooIVu6uTEzjir2UJzy
 KM1iKYyeG+FYJEwRTUfLU3vJbyXPvRLRAGMoST/RxIW3AHvMoj14ZRm3iXz6dwTNKx8R
 5gy4auOutDtRLGNBDzgQskcJdi7ObXe2+rGZrkzcjAoIEIh58JNzoUbjYGLNCBHUTYyf
 qv0SIw+ka1QO616ZthsFWkb4fUlEU+6fsVWIbergangc7FNXyV+8e3MvaY5ab+qomVWU
 MHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791763395; x=1792368195;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/jb8035J+llImyYwQKUAuCTpXCQElyZYTaxv1sXeqoM=;
 b=dSHyJPzvB+62T2hmg75H5kPy+3CouHrpL/hwP16Zn5axlNRbogWWX2n0k9cgi62d05
 /O/G7zKA8D5kDRRBK3wq8Yn/dpLHp7nx1YiTuZem5tYsuqpyXxge6neLJwNfd5FieU8p
 b6n+jPrMy1rrfzQIGiNgy7dmoFdFuUIx4jZ6jYl9wMMJvNhdDERg1Xt0C+iXb8eUdQhw
 E6Zel55fDd7G5XQm+u7yokIR0c3ekzCiNgg5M2l6HYQQCOAJToJ9fEHrnL2+5Zkfq4fY
 XCvoZgUdhZPv5+sFsQxUeR91sKRuV9q3C334zk1IhpYSZLMwy6z9TG3WwxWgFIzO9T/Q
 a7Eg==
X-Gm-Message-State: AFq9FYJkB7z2AIx6Enjp2aZIgDu+jfj2ULYua6NTlhfs5EN6prakwhMk
 iuNXej/8720VHyr4gMLs8lPCR6fbYUEBlP+ZNY8bmLlNmPOf2N07Ock65HVSkaU7ZumoZ9wQ6GA
 uorR3jGZ+obG+T7LbZLBm/1n6PkviOVBQj58NfISY54R+RMuZgBJSv+EKe6hanEn1c96KLwqODh
 wgk9reQT1hfAYA3hoE6ww/dfnpMEn9wio=
X-Gm-Gg: AYBFou3x+/IjQGXFKlW/bT+bFhzWOtJ5rF4REk+sVxIendkTBBnAf4g0L1/ZsSKDkyX
 T7rz7Upvrju01atwfpRTovmIaPjgSTyG2sKJX4LWwMDG6toEWBMK0lbUdwaCCTPyx4jzvXqITZT
 hoDP/Y3hkGMcLCMNDKnm4wVkMNpFoeyjjTzfPgpIKiJ2XfrtdPphAH1MeF8aRZAyhCKgicnVFbX
 1GVp0S3viOp1FAAASGkDkMY7za06hv/M6NEWBErrx78FUzBVHhsSHE7qwkVUw==
X-Received: by 2002:a05:600c:1d0e:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-4a18e4e9db3mr149954475e9.33.1791763394949; 
 Sun, 11 Oct 2026 17:03:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-4a18e4e9db3mr149954015e9.33.1791763394328; Sun, 11 Oct 2026
 17:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261009122832.348427-1-pbonzini@redhat.com>
 <311ad69d-a4b7-473f-b556-99a24fcf098c@tls.msk.ru>
In-Reply-To: <311ad69d-a4b7-473f-b556-99a24fcf098c@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Oct 2026 02:03:02 +0200
X-Gm-Features: AclHuK81fPRrnW65_wstQF1M5gdV_WqQgE0-XnZtbfRV1jEe_igXQHa7pIobJTI
Message-ID: <CABgObfZDyfFo4ZCQisxAeWgJKfa5-VmQGaEtqyr2CRQ+SaYwTg@mail.gmail.com>
Subject: Re: [PULL v3 00/32] target/i386 and misc changes for 2026-09-28
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, 
 Yuxuan Li <liyuxuan.darfux@bytedance.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Artemii Mashanov <ralerrdirsardx@gmail.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Andrey Polivoda <apolivodaa433@gmail.com>, 
 Jordy Zomer <jordyzomer@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a40d6f065d996c56"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000a40d6f065d996c56
Content-Type: text/plain; charset="UTF-8"

Il sab 10 ott 2026, 08:34 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> On 09.10.2026 15:28, Paolo Bonzini wrote:
> > The following changes since commit
> 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> > j
> >    Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu
> into staging (2026-09-30 06:25:37 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:
> >
> >    agents: Add a skill for finding your way around QEMU (2026-10-02
> 11:11:37 +0200)
> >
> > v1->v2: move validate_vex() before all operand decoding (patches 6-8)
> >
> > ----------------------------------------------------------------
> > * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
> > * target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
> > * target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
> > * target/i386/tcg: implement APX
> > * target/i386: Migrate error code only with an exception
> > * agents: Add a skill for finding your way around QEMU
> > * tdx: fix buffer overflow in tdx_parse_panic_message
> > * accel/kvm: fixes
> >
> > ----------------------------------------------------------------
> >
> > Artemii Mashanov (1):
> >        target/i386: fix EFLAGS reads in TCG plugin callbacks
> ...> Maxim Levitsky (3):
> >        system: fix buffer overflow in tdx_parse_panic_message
> >        accel/kvm: protect kvm_resample_fd_list with a mutex
> >        accel/kvm: coalesced mmio: check lenght of the MMIO write entry
> >
> > Paolo Bonzini (25):
> >        target/i386/tcg: compute C of CC_OP_ADOX without going through
> helper
> >        target/i386/tcg: extract validate_cr0_exceptions()
> >        target/i386/tcg: move validate_vex() before all operand decoding
> >        target/i386/tcg: clarify return value of decode_insn
> >        target/i386/tcg: ignore VEX.L for unary scalar instructions
> >        target/i386/tcg: JO/JNO can use flags directly if it is in CC_SRC
> >        target/i386/tcg: generalize zero- and sign-extension
> >        target/i386/tcg: use standard operand order for BSF and BSR
> >        target/i386/tcg: use zextT1 for CMPXCHG
> >        target/i386/tcg: unify MOVBE and BSWAP generators
> >        target/i386/tcg: add APX support to XSAVE/XRSTOR
> >        target/i386/tcg: add definition for REX2 prefix
> >        target/i386/tcg: mark XSAVE* as not allowing REX2
> >        target/i386/tcg: treat 0x0F as a prefix
> >        target/i386/tcg: decode REX2 prefix
> >        target/i386/tcg: implement JMPABS instruction
> >        target/i386/tcg: extend VEX.vvvv parsing for APX
> >        target/i386/tcg: decode EVEX prefix
> >        target/i386/tcg: add decode functionality for APX
> >        target/i386/tcg: implement CCMP/CTEST
> >        target/i386/tcg: decode APX instructions
> >        target/i386/tcg: optimize CCMP
> >        target/i386: extract computation of no-autoenable features
> >        target/i386/tcg: mark APX as supported
> >        agents: Add a skill for finding your way around QEMU
> ...
>  From this list, what should or should not be picked up for the stable
> series?  Only one or two patches were Cc'ed to qemu-stable@ (which I
> removed from this list), but it feels like most of this pull request
> should be picked up.
>
>   target/i386: fix EFLAGS reads in TCG plugin callbacks ?
>

Yeah, this one is independent.

  system: fix buffer overflow in tdx_parse_panic_message - I picked this
>     up for 11.1.x
>
>   accel/kvm: protect kvm_resample_fd_list with a mutex -- I picked it too
>
>   accel/kvm: coalesced mmio: check lenght of the MMIO write entry -- ?
>
> Most changes by Paolo? If yes, which ones?
>

No, just the three by Maxim. I don't really have time to chase dependencies
between TCG patches; the issues there are small enough that it doesn't
really matter to have them in stable, and the risk is higher than the
benefit.

Paolo

Thanks,
>
> /mjt
>
>

--000000000000a40d6f065d996c56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 10 ott 2026, 08:34 Michae=
l Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 09.10=
.2026 15:28, Paolo Bonzini wrote:<br>
&gt; The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38=
a5f74:<br>
&gt; j<br>
&gt;=C2=A0 =C2=A0 Merge tag &#39;pull-target-arm-20260929&#39; of <a href=
=3D"https://gitlab.com/pm215/qemu" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://gitlab.com/pm215/qemu</a> into staging (2026-09-30 06:25:37=
 +0100)<br>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git<=
/a> tags/for-upstream<br>
&gt; <br>
&gt; for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531=
e:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 agents: Add a skill for finding your way around QEMU (202=
6-10-02 11:11:37 +0200)<br>
&gt; <br>
&gt; v1-&gt;v2: move validate_vex() before all operand decoding (patches 6-=
8)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks<br>
&gt; * target/i386/tcg: raise #GP(0) on null SS load with RPL !=3D CPL<br>
&gt; * target/i386/tcg: Don&#39;t clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP<=
br>
&gt; * target/i386/tcg: implement APX<br>
&gt; * target/i386: Migrate error code only with an exception<br>
&gt; * agents: Add a skill for finding your way around QEMU<br>
&gt; * tdx: fix buffer overflow in tdx_parse_panic_message<br>
&gt; * accel/kvm: fixes<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; <br>
&gt; Artemii Mashanov (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386: fix EFLAGS reads in TCG plugin=
 callbacks<br>
...&gt; Maxim Levitsky (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 system: fix buffer overflow in tdx_parse_pa=
nic_message<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 accel/kvm: protect kvm_resample_fd_list wit=
h a mutex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 accel/kvm: coalesced mmio: check lenght of =
the MMIO write entry<br>
&gt; <br>
&gt; Paolo Bonzini (25):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: compute C of CC_OP_ADOX wi=
thout going through helper<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: extract validate_cr0_excep=
tions()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: move validate_vex() before=
 all operand decoding<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: clarify return value of de=
code_insn<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: ignore VEX.L for unary sca=
lar instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: JO/JNO can use flags direc=
tly if it is in CC_SRC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: generalize zero- and sign-=
extension<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: use standard operand order=
 for BSF and BSR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: use zextT1 for CMPXCHG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: unify MOVBE and BSWAP gene=
rators<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: add APX support to XSAVE/X=
RSTOR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: add definition for REX2 pr=
efix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: mark XSAVE* as not allowin=
g REX2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: treat 0x0F as a prefix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: decode REX2 prefix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: implement JMPABS instructi=
on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: extend VEX.vvvv parsing fo=
r APX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: decode EVEX prefix<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: add decode functionality f=
or APX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: implement CCMP/CTEST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: decode APX instructions<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: optimize CCMP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386: extract computation of no-auto=
enable features<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/i386/tcg: mark APX as supported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 agents: Add a skill for finding your way ar=
ound QEMU<br>
...<br>
=C2=A0From this list, what should or should not be picked up for the stable=
<br>
series?=C2=A0 Only one or two patches were Cc&#39;ed to qemu-stable@ (which=
 I<br>
removed from this list), but it feels like most of this pull request<br>
should be picked up.<br>
<br>
=C2=A0 target/i386: fix EFLAGS reads in TCG plugin callbacks ?<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, this on=
e is independent.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
=C2=A0 system: fix buffer overflow in tdx_parse_panic_message - I picked th=
is<br>
=C2=A0 =C2=A0 up for 11.1.x<br>
<br>
=C2=A0 accel/kvm: protect kvm_resample_fd_list with a mutex -- I picked it =
too<br>
<br>
=C2=A0 accel/kvm: coalesced mmio: check lenght of the MMIO write entry -- ?=
<br>
<br>
Most changes by Paolo? If yes, which ones?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">No, just the three by Maxim. I do=
n&#39;t really have time to chase dependencies between TCG patches; the iss=
ues there are small enough that it doesn&#39;t really matter to have them i=
n stable, and the risk is higher than the benefit.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
Thanks,<br>
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--000000000000a40d6f065d996c56--


