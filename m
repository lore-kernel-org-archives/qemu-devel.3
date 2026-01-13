Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E456D29DC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 05:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfXIR-0006bk-4r; Tue, 13 Jan 2026 00:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfXIO-0006aC-MY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfXIM-0002zA-Pg
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 00:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768283421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qs7zhcW/UVOSbsLU/f5/0UkeBgNfQxpoFiaHDgUVOH8=;
 b=SyaUPUeorFD67KE+MwOR3xq2NFjdxUv5W8WmLkKdq4bBJyJDgq5TZZ8OOsqw2hQRNg9GzA
 F16uJwgLnOrQJvRD6EcuR4wcM9A91/SReG3jBeIEIImCesMvwEJiZoeUPeMY7Oxf7hZdmk
 kCU1gPfGwbfgk0LHr4ruBUIQ9ymNQxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-rrCJOapXNTObSB_zV6OYeA-1; Tue, 13 Jan 2026 00:50:20 -0500
X-MC-Unique: rrCJOapXNTObSB_zV6OYeA-1
X-Mimecast-MFC-AGG-ID: rrCJOapXNTObSB_zV6OYeA_1768283419
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso4476945f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 21:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768283419; x=1768888219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qs7zhcW/UVOSbsLU/f5/0UkeBgNfQxpoFiaHDgUVOH8=;
 b=CFMUCxggP1j1B2opGLvq0tniahs5vLZxv1yoN+p79L+xy4qHOv2/5HvwZsOilSV+2P
 6CS/JyAyUv1txkQrfKDBNV2PA3qZ69wc5YmE45/MGwRRSNaiMH8mikosd5qW0sGngWl7
 4sOWcS75VRkVPvrflzy5y2INtdQOeh3viLhxipXj04vHpuJDCjbg3oRfcyJ0rEj6m0ng
 F9NfIsHqgXpgR2FuURl4E475l/71mb4n/dWzbqWjAr2zh9kJs3v0fk0OZO23hc2T9KSZ
 mxCMXc2vTly6Umq55oWZOk489WHqVjk82pTw6JEpBLN0IGUhOwVp4TdauDaJkWltUmD3
 DoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768283419; x=1768888219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qs7zhcW/UVOSbsLU/f5/0UkeBgNfQxpoFiaHDgUVOH8=;
 b=QNTKXpQBKA+pyGPWi35ovmThBy/Zbm6KMz9rFOJnr24alutPHLwPuQQNeNBRsAV6TR
 5gBsOQxCpmCwg/ykmNorzdxtmyu7uY4jaEzV42ywtWQJP2psh+eVmKjUQyHsuArLmugG
 hOtd6q1lhPtuMIlRJfOmFUO3LbxzRPUJgil3GrZUbBIWzeyAfU6oTaC2aSlVSn33/RkL
 HSCCwRS+qM2ThiqHhUGqG/N+88MQl5r8xug7gAB3SB8IojCSsxPHYfaicZE2y5QRmgHe
 fdpx+4bi+VF/X7QsiE39MEDqcx4XQVN35dIXTvlRPYqFapcZee+0L4TZg/2EPg32x5ml
 fH5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIf6AQ0FDBV3mDxFUPULaA5SgSTDa4VYCr9IdLUU/cdHappZY0msbnZZ/9elqeARZYRkKYdgPmY4Bz@nongnu.org
X-Gm-Message-State: AOJu0YzWrvckDijndnVdcDcssHIJ37pvt341t80SB5GuPszNHhsgfoL3
 tOSS1kII6M9tzkicZI9hOCRNu6RkXkXajAnyy2/JYkQchDneBpY94Pusxb8dNm/P3rXTHna3zAa
 TZreLjBtwZFaMnty6VQcMemuAZpxQjvip+tAIsM1luCVMM24/cNY09DnCd/wdN1SL7rb5rqfTwO
 4fQ/Qh7n3Vx05DoMYZo2doWrNGafQjBJs=
X-Gm-Gg: AY/fxX638ZIRNcPtrzVEogEIjVuLSmP3Q7/k9lG26/WGTNvUBhzbSRThKzpFvhLN3Ua
 hUkXNutZCk0JeQ9TAUJUw3082euWy78uyhpTP/pLhOJGtNRhJRR3U74VTYtbQoIBr2TZza5fa1g
 pDZPgWm/OQcYsD5vvALs+w64a/5ynY2m9ron5X0FovUJkvIPKyvlsFmHfvku6DMATlyDGAByZ2/
 Mwt7QqOay0EbvwkVY4HmBRZy0IFAnAdO7ap5T0ei9m8wLt7blPVFHESy65Rq+i7NNI/IA==
X-Received: by 2002:a05:6000:2085:b0:431:104:6dc2 with SMTP id
 ffacd0b85a97d-432c362811cmr19726011f8f.8.1768283418740; 
 Mon, 12 Jan 2026 21:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPWxQNrcWE5zzwIRFg7QrWYT8fRVrUis+5YlZmgqwjJj33i5p+0PiklUStuQq49OSFRkSZ2PiqLPPt12RPsq0=
X-Received: by 2002:a05:6000:2085:b0:431:104:6dc2 with SMTP id
 ffacd0b85a97d-432c362811cmr19725977f8f.8.1768283418358; Mon, 12 Jan 2026
 21:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-5-anisinha@redhat.com>
 <CABgObfbDTAvm6E0imC=HSm2=BAC4rzUDmuHcoUbVjJ-YeXFw-w@mail.gmail.com>
 <CAK3XEhOWn_zecQjvFvzsRu_dmHBAjJ4gaSfKKp6BHviQmz2D2g@mail.gmail.com>
In-Reply-To: <CAK3XEhOWn_zecQjvFvzsRu_dmHBAjJ4gaSfKKp6BHviQmz2D2g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Jan 2026 06:50:07 +0100
X-Gm-Features: AZwV_Qis5VsfOLzY6XbOPFF70nqRNXDlvk1xQ65pKarvD6noNf4B3av6VmmnO0Q
Message-ID: <CABgObfaMhQqSDLCudcn5sJ48p3Z0bOTzeX97=0PZNEgnEHNPbQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] accel/kvm: add changes required to support KVM
 VM file descriptor change
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, kvm <kvm@vger.kernel.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000003901b06483e9159"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000003901b06483e9159
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 13 gen 2026, 06:22 Ani Sinha <anisinha@redhat.com> ha scritto:

> On Mon, Jan 12, 2026 at 10:32=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om>
> wrote:
> >
> > On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha <anisinha@redhat.com>=
:
> >  > +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> >
> > Weird name since there are no "operations". Maybe
> kvm_arch_on_vmfd_change?
>
> I meant the operations the arch wants to do on vmfd change.
>

All callbacks are "operations that the implementor wants to do", aren't
they? But "ops" is usually a suffix in types that group multiple callbacks,
not individual functions.

Paolo


>

--00000000000003901b06483e9159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 13 gen 2026, 06:22 Ani Si=
nha &lt;<a href=3D"mailto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; =
ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On M=
on, Jan 12, 2026 at 10:32=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Jan 12, 2026 at 2:23=E2=80=AFPM Ani Sinha &lt;<a href=3D"mailt=
o:anisinha@redhat.com" target=3D"_blank" rel=3D"noreferrer">anisinha@redhat=
.com</a>&gt;:<br>
&gt;=C2=A0 &gt; +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s=
)<br>
&gt;<br>
&gt; Weird name since there are no &quot;operations&quot;. Maybe kvm_arch_o=
n_vmfd_change?<br>
<br>
I meant the operations the arch wants to do on vmfd change.<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">All callbacks ar=
e &quot;operations that the implementor wants to do&quot;, aren&#39;t they?=
 But &quot;ops&quot; is usually a suffix in types that group multiple callb=
acks, not individual functions.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000003901b06483e9159--


