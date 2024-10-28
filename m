Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AC4D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5R53-0001vs-UQ; Mon, 28 Oct 2024 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5R50-0001vR-Kw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5R4y-000612-F2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730127046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENzyasIEjfwzerBBI+Rg521CcoB5LwAA60Ba9gFCwUA=;
 b=A9/DnU6Qmq/s4zfChtiZQXQeucTZu28G7rAFQNrvVmF181qAOUwFPezNpc6sUEOl6CRdIf
 7sbjvKUBl86qIo1UYTuxdFEqhrIJsZlVqgUikfByfd64BoDCzvf/3Uv5Iffjgh5oc33Akh
 C2BaeVxILYLWLQpONcf/krYkIcJnE4Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-8zNePljTO92ofmyKrTMv9Q-1; Mon, 28 Oct 2024 10:50:43 -0400
X-MC-Unique: 8zNePljTO92ofmyKrTMv9Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3135797f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730127042; x=1730731842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENzyasIEjfwzerBBI+Rg521CcoB5LwAA60Ba9gFCwUA=;
 b=CW2lzUuSlRZTX4p7J4UmUfOpmJox/GMlXpn6TeHY7EqdUiU629uxHJ6xXg2C4h60KL
 fLowcFfwSadqcIOsjAFOxzea6hsi3yHD9JTLleGEDD+CSvgM3kCW9uluwtaGgSYxaxmN
 ZWRyneVQcRgHXx4N3vZx5R0CS1O3kz6ZBcJrFqJ546cbL+9WAlxr//mVZ9jVsaAiAQdU
 ruq+IVvM91Gc5nj3MHFGmi1AYLo1K2cxUcLCRTSH7NWHPZ8oXuHC8XCe7h6EsOmRA6qm
 3Zf3WEcG+wb5Kwoj98JvHJ36YrMTjdyGFxbQRNG0gM4BrvH0iqOR207QnOMBI8JfUWf/
 CdzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVat4bIioz6fsUSwqKAaE9ibvUosmX8Hiw4ASdYz+VjT4FA940i0JEkqT7kwTIjs8WQPsQsWvjqvjuW@nongnu.org
X-Gm-Message-State: AOJu0YymxDidlogKMfq7Oh4il563Rzzchb/WSKTyMFPFfEY73NOACnQ1
 KiEEtjrKA8NwnoRKP0ia7A2fUiaGoh31s4uF9/NMz3z/09ndiQFxZvB6fBXzhMPhJY9hA/AnvX1
 CaWohMorsq8hdJvfxZDLLFStQwH0CPj4cupaciJQ+rUO9mDunFsycOawdvj1JBdu23TfTNY9LQA
 fdr8brUPIamjyI9eXF+WMCB4CKXDY=
X-Received: by 2002:a5d:6dce:0:b0:37c:cce8:4acc with SMTP id
 ffacd0b85a97d-38080e37d84mr80308f8f.13.1730127042603; 
 Mon, 28 Oct 2024 07:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWz7RliIqZXQxW1AAK21aPrfkRvIpU2mCv8K19Zjx+8HZ8hKSHZ36v8iwHUOQwXEcx+ghpTkBIlbor5jER2yc=
X-Received: by 2002:a5d:6dce:0:b0:37c:cce8:4acc with SMTP id
 ffacd0b85a97d-38080e37d84mr80288f8f.13.1730127042291; Mon, 28 Oct 2024
 07:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
 <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
 <Zx9hPncYMxsF3Hkh@linux.bj.intel.com>
 <340b5b33-8b77-43ab-b0dc-c6e9f610b4a2@redhat.com>
 <14c432e8-5049-4051-ba1f-303f76bfbe19@intel.com>
In-Reply-To: <14c432e8-5049-4051-ba1f-303f76bfbe19@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Oct 2024 15:50:30 +0100
Message-ID: <CABgObfYq4itG4ivTqh5nc74dfc11_FG7NA1UQi5Yx7z+1FNG3w@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org,
 mtosatti@redhat.com, xuelian.guo@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 28, 2024 at 3:48=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 10/28/2024 6:45 PM, Paolo Bonzini wrote:
> > On 10/28/24 11:02, Tao Su wrote:
> >> On Mon, Oct 28, 2024 at 09:45:39AM +0100, Paolo Bonzini wrote:
> >>> On 10/28/24 03:45, Tao Su wrote:
> >>>> Since the highest supported vector length for a processor implies th=
at
> >>>> all lesser vector lengths are also supported, add the dependencies o=
f
> >>>> the supported vector lengths. If all vector lengths aren't supported=
,
> >>>> clear AVX10 enable bit as well.
> >>>>
> >>>> Note that the order of AVX10 related dependencies should be kept as:
> >>>>           CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
> >>>>           CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
> >>>>           CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
> >>>
> >>> I think you need to add a set of dependencies so that avx10 cannot be
> >>> set,
> >>> unless all the older AVX features that it's composed of are
> >>> available.  From
> >>> the manual these are
> >>>
> >>> AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA,
> >>> AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
> >>> VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.
> >>
> >> Thanks for such a quick review!!
> >>
> >> AVX10.1 spec said:
> >> Intel AVX-512 will continue to be supported on P-core-only processors =
for
> >> the foreseeable future to support legacy applications. However, new
> >> vector
> >> ISA features will only be added to the Intel AVX10 ISA moving forward.
> >> While Intel AVX10/512 includes all Intel AVX-512 instructions, it
> >> important to note that applications compiled to Intel AVX-512 with vec=
tor
> >> length limited to 256 bits are not guaranteed to be compatible on an
> >> Intel
> >> AVX10/256 processor.
> >>
> >> I.e. AVX10/256 processors will support old AVX-512 instructions
> >> (limited to 256 bits and enumerated by AVX10) but not set AVX-512 rela=
ted
> >> CPUIDs. So, I think we can't add these dependencies=E2=80=A6
> >
> > Of course you're right about AVX10 in general, you still need to add th=
e
> > dependency but only for CPUID_24_0_EBX_AVX10_512.
>
> What if future E-core processor starts to support AVX10/512 but not
> enumerating any individual AVX512 bit? (AVX10.1 spec only states the
> compatibility behavior for P-core-only processors)

KVM and QEMU could always specify the bits. If you want to ask around
if this is possible then go ahead.

In the meanwhile I actually can apply Tao Su's patches, since the
dependencies are merely a safety feature.

Paolo


