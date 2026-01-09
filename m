Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C521D26D7A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGGM-0000X6-Vi; Fri, 09 Jan 2026 12:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGGD-0000Ty-Kx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGGA-0006YJ-RK
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767979609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BC5/C3Fn9fnvF6/higQNpNdnu7olzzpVNEu7o58VIow=;
 b=ZRdngEzl5gzKmuCsE/4KDp2rcvM634ztdXumMppM+wf2HZ0XPaHSNQthIY2E8P299/MsPK
 BUTMJ73sVNdjET4MxYIbyPY2UMDh7GhyUGRva+IDtbT/7FpQXY+QKNc5qtj5ay9ydJ+IQy
 3uMyR/I6Nnl7LZq1xE85I58/tXXxVYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-XVhuU-9UOnKjEyWPA7I8MA-1; Fri, 09 Jan 2026 12:26:47 -0500
X-MC-Unique: XVhuU-9UOnKjEyWPA7I8MA-1
X-Mimecast-MFC-AGG-ID: XVhuU-9UOnKjEyWPA7I8MA_1767979606
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fb1c2c403so3036798f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767979606; x=1768584406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BC5/C3Fn9fnvF6/higQNpNdnu7olzzpVNEu7o58VIow=;
 b=AMWVXL4P145P+wJtnE/t1sTrTAG/HIFabr0poMHH4lEFrIRraC0ae5c/5O+ijLQeyr
 iBky/2NMTFBAguaDGbfeBgvu7DFhXXw3fmzEtWDiAN4yojQqpBAetJ14ZLf61kHnuD1+
 lq+gpe6MAs5XuPadwjHNB2oxNNLuJY9Y1sos96iUCniDRaF/v85IbEIPDxeIB25pXhml
 USSD4l9H2ywBu4m4gaWCJlkQGXsXW/ihtWqnk9HtfqJ3SAWefy4y9OSgMJITlKfDm8br
 hmUXvAX4LUgCS5oLG6Zl5mbB/RNmxTHdHHvnJbjlkJllrhy8L8DwDgzvkKP2QkFSgP42
 TCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767979606; x=1768584406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BC5/C3Fn9fnvF6/higQNpNdnu7olzzpVNEu7o58VIow=;
 b=qoVJZJcO3gJHa1rdgh99LlJAru4nf9gLjZzHgX9p1oNNSqKB+A1eoa+2Oc3wQJqqPt
 3Y1uRO823ATbo5EV7GO+ckcwNKgLIB5IBmTRMhG3Ac3HSk0GesDPF60VyCVHnHW4oiMI
 zNjlSByVEK0JlwTKRjc3TqmSg2kUlGIlDSqJcbXLuQyTB72Umg/jAPQuCr0bGzUaYqq9
 17dPjcqIL5YNQvfQET6tzIM8c317jix380xQyw1ftO/3WhbSE75uSRuaOyaeIcMmWeiW
 6LgwWI/DzT2JU94m+jCKZGibQ9dNMY/knJpfyI1xVB/CNcyzp4WCwuvDVU0GKWEe1+bi
 2LKQ==
X-Gm-Message-State: AOJu0YxZgGpPrn49Fw5CVYkyLlp5QNtGNSSO8jEbGHuMaMHNLiM1tybY
 hgkcIHF7xe/AI7/qfg3EcE7FIyzamqdqowdlbbtIjHItPc3K07+Ic/F7OiECXMPQ/ODP7mNGZVQ
 CRTxTljxFFpCQ24kk2COyiVmL1AIgdevNQQRESFnio0fGWJhuLAsz4Wn76q1L2LIUz7gzh5l2YF
 qQgQUx9PJ/POSppylxh0zR7kKX5MqE4AqBdzvQL5s=
X-Gm-Gg: AY/fxX4/2siU3o+KUV6iSPx0xw7Xtt/Yc+rShUEnFwLgk+6CCYWvR3hXX28tPxGY1nO
 psoNfpzX4P7QJv0G7aA30GWrOvD2OxC68XvkKD53CpT1Js31QxB2nBSAArLtktUBSikiyN8lw9b
 BAAdeaH+B5KExh1tvhK1QmWvgSX8DQYHLc4RfpSM0clGkA2IrH/8yBBgx/5tGQKPzM/qLgVYoXy
 eVNRI3enpxX5gSv6HTx52wBWQIhh+z7XVHRWobLdm3Bk837yqJyVLibUAHEOPhk9EfgwA==
X-Received: by 2002:a05:6000:4024:b0:430:f59d:4dfc with SMTP id
 ffacd0b85a97d-432c378a153mr10921904f8f.9.1767979606004; 
 Fri, 09 Jan 2026 09:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa31tvJsDVw/Ho2P/qsgUz2o9IzqhaqEoCPAiE+87W3tibqX+/AB3WqXHlxr0F1jgkQWuXchHgGHc24m/T1DU=
X-Received: by 2002:a05:6000:4024:b0:430:f59d:4dfc with SMTP id
 ffacd0b85a97d-432c378a153mr10921885f8f.9.1767979605548; Fri, 09 Jan 2026
 09:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20260109165058.59144-1-philmd@linaro.org>
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 18:26:35 +0100
X-Gm-Features: AZwV_Qg4jRWt1sAw0Set4w0GKRNxK_ihEB2td6Q0ZXO_5ew6KFzXE_v_66NaPIg
Message-ID: <CABgObfaEj8_ssaUhZRpsH1u-wRiPU=V0yj165WRuMBoOy92qBA@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] system/memory: Clean ups around
 address_space_ldst() endian variants
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005bfd460647f7d498"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005bfd460647f7d498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> Missing review: 2, 12, 20
>
> Since v4:
> - No change (RESEND)
>

For subpages, are you leaving for later the switch away from
DEVICE_NATIVE_ENDIAN?

Paolo

Since v3:
> - Assign device_endian enums (Richard)
> - Add/use ldm_p() and stm_p() helpers (Paolo)
>
> Since v2:
> - Changed opt-out to opt-in approach (Pierrick)
> - Split big patches in smaller ones
> - Mark ioport little-endian
>
> Philippe Mathieu-Daud=C3=A9 (22):
>   MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
>   util: Introduce ldm_p() and stm_p() load/store helpers
>   system/physmem: Inline and remove leul_to_cpu()
>   system/physmem: Convert DEBUG_SUBPAGE printf() to trace events
>   system/memory: Split MemoryRegionCache API to 'memory_cached.h'
>   system/memory: Inline address_space_stq_internal()
>   system/memory: Define address_space_ldst[W] endian variants via
>     template
>   system/memory: Define address_space_ldst[L] endian variants via
>     template
>   system/memory: Define address_space_ldst[Q] endian variants via
>     template
>   system/memory: Factor address_space_ldst[M]_internal() helper out
>   system/memory: Pass device_endian argument as MemOp bit
>   system/memory: Use ldm_p() and stm_p() helpers
>   system/memory: Directly call address_space_ldst[M]_internal() helper
>   system: Allow restricting the legacy ld/st_phys() 'native-endian' API
>   system: Allow restricting legacy address_space_ldst() native-endian
>     API
>   system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
>   system: Allow restricting the legacy translator_ld() 'native-endian'
>     API
>   system: Allow restricting the legacy tswap() 'native-endian' API
>   system: Allow restricting the legacy MO_TE* 'native-endian'
>     definitions
>   system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
>   system/ioport: Declare x86-specific I/O port in little-endian order
>   system/ioport: Do not open-code address_space_ld/st_le() methods
>
>  MAINTAINERS                                  |   4 +
>  include/accel/tcg/cpu-ldst.h                 |   2 +
>  include/exec/memop.h                         |   4 +
>  include/exec/translator.h                    |   5 +-
>  include/exec/tswap.h                         |   3 +
>  include/hw/virtio/virtio-access.h            |   1 +
>  include/qemu/bswap.h                         |  11 -
>  include/qemu/ldst_unaligned.h                |  25 ++
>  include/system/memory.h                      | 193 +-------
>  include/system/memory_cached.h               | 212 +++++++++
>  system/memory-internal.h                     |   2 +
>  include/system/memory_ldst.h.inc             |  52 +--
>  include/system/memory_ldst_endian.h.inc      |  33 ++
>  include/system/memory_ldst_phys.h.inc        | 113 +----
>  include/system/memory_ldst_phys_endian.h.inc |  57 +++
>  system/ioport.c                              |  34 +-
>  system/physmem.c                             |  35 +-
>  tests/qtest/endianness-test.c                |  10 +-
>  tests/qtest/libqtest.c                       |  13 +-
>  util/ldst.c                                  |  69 +++
>  system/memory_ldst.c.inc                     | 449 ++-----------------
>  system/memory_ldst_endian.c.inc              |  70 +++
>  scripts/make-config-poison.sh                |   1 +
>  system/trace-events                          |   6 +
>  util/meson.build                             |   1 +
>  25 files changed, 599 insertions(+), 806 deletions(-)
>  create mode 100644 include/system/memory_cached.h
>  create mode 100644 include/system/memory_ldst_endian.h.inc
>  create mode 100644 include/system/memory_ldst_phys_endian.h.inc
>  create mode 100644 util/ldst.c
>  create mode 100644 system/memory_ldst_endian.c.inc
>
> --
> 2.52.0
>
>

--0000000000005bfd460647f7d498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferrer=
">philmd@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Missing review: 2, 12, 20<br>
<br>
Since v4:<br>
- No change (RESEND)<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">For subpages, are you leaving for later the switch away=
 from DEVICE_NATIVE_ENDIAN?</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Since v3:<br>
- Assign device_endian enums (Richard)<br>
- Add/use ldm_p() and stm_p() helpers (Paolo)<br>
<br>
Since v2:<br>
- Changed opt-out to opt-in approach (Pierrick)<br>
- Split big patches in smaller ones<br>
- Mark ioport little-endian<br>
<br>
Philippe Mathieu-Daud=C3=A9 (22):<br>
=C2=A0 MAINTAINERS: Cover &#39;system/memory_ldst*.h.inc&#39; files<br>
=C2=A0 util: Introduce ldm_p() and stm_p() load/store helpers<br>
=C2=A0 system/physmem: Inline and remove leul_to_cpu()<br>
=C2=A0 system/physmem: Convert DEBUG_SUBPAGE printf() to trace events<br>
=C2=A0 system/memory: Split MemoryRegionCache API to &#39;memory_cached.h&#=
39;<br>
=C2=A0 system/memory: Inline address_space_stq_internal()<br>
=C2=A0 system/memory: Define address_space_ldst[W] endian variants via<br>
=C2=A0 =C2=A0 template<br>
=C2=A0 system/memory: Define address_space_ldst[L] endian variants via<br>
=C2=A0 =C2=A0 template<br>
=C2=A0 system/memory: Define address_space_ldst[Q] endian variants via<br>
=C2=A0 =C2=A0 template<br>
=C2=A0 system/memory: Factor address_space_ldst[M]_internal() helper out<br=
>
=C2=A0 system/memory: Pass device_endian argument as MemOp bit<br>
=C2=A0 system/memory: Use ldm_p() and stm_p() helpers<br>
=C2=A0 system/memory: Directly call address_space_ldst[M]_internal() helper=
<br>
=C2=A0 system: Allow restricting the legacy ld/st_phys() &#39;native-endian=
&#39; API<br>
=C2=A0 system: Allow restricting legacy address_space_ldst() native-endian<=
br>
=C2=A0 =C2=A0 API<br>
=C2=A0 system: Allow restricting the legacy cpu_ld/st() &#39;native-endian&=
#39; API<br>
=C2=A0 system: Allow restricting the legacy translator_ld() &#39;native-end=
ian&#39;<br>
=C2=A0 =C2=A0 API<br>
=C2=A0 system: Allow restricting the legacy tswap() &#39;native-endian&#39;=
 API<br>
=C2=A0 system: Allow restricting the legacy MO_TE* &#39;native-endian&#39;<=
br>
=C2=A0 =C2=A0 definitions<br>
=C2=A0 system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition=
<br>
=C2=A0 system/ioport: Declare x86-specific I/O port in little-endian order<=
br>
=C2=A0 system/ioport: Do not open-code address_space_ld/st_le() methods<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +<br>
=C2=A0include/accel/tcg/cpu-ldst.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0include/exec/memop.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0include/exec/translator.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0include/exec/tswap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0include/hw/virtio/virtio-access.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0include/qemu/bswap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 -<br>
=C2=A0include/qemu/ldst_unaligned.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 25 ++<br>
=C2=A0include/system/memory.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 193 +-------<br>
=C2=A0include/system/memory_cached.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 212 +++++++++<br>
=C2=A0system/memory-internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0include/system/memory_ldst.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 52 +--<br>
=C2=A0include/system/memory_ldst_endian.h.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3=
3 ++<br>
=C2=A0include/system/memory_ldst_phys.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
3 +----<br>
=C2=A0include/system/memory_ldst_phys_endian.h.inc |=C2=A0 57 +++<br>
=C2=A0system/ioport.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 34 +-<br>
=C2=A0system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 35 +-<br>
=C2=A0tests/qtest/endianness-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0tests/qtest/libqtest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0util/ldst.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 69 +=
++<br>
=C2=A0system/memory_ldst.c.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 449 ++-----------------<br>
=C2=A0system/memory_ldst_endian.c.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 70 +++<br>
=C2=A0scripts/make-config-poison.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0system/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
=C2=A0util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A025 files changed, 599 insertions(+), 806 deletions(-)<br>
=C2=A0create mode 100644 include/system/memory_cached.h<br>
=C2=A0create mode 100644 include/system/memory_ldst_endian.h.inc<br>
=C2=A0create mode 100644 include/system/memory_ldst_phys_endian.h.inc<br>
=C2=A0create mode 100644 util/ldst.c<br>
=C2=A0create mode 100644 system/memory_ldst_endian.c.inc<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--0000000000005bfd460647f7d498--


