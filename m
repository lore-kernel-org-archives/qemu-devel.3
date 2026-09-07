Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D345C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wbk-0003Xr-VA; Mon, 07 Sep 2026 06:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Wbi-0003XF-EM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:29:47 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Wbf-0002lz-RB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:29:46 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-86b03b75fecso50739447b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776982; cv=none;
 d=google.com; s=arc-20260327;
 b=QYG59lnkvGiKV/7StI1dvlCl5vTKLcSz7tsXjmgIKX0CRGgHErz4V5SLl77AHY6RKo
 RBHtZ2j55lzaEONwgqkPk5LIzNdfusbAFWTy6iveznoDX1rSHJOYgWKhOptum7qK/HBt
 zkwunKkKE1JU9wBS8Defo/fBrF0Mr2VzUw/fDhi8tc1tb9i92qvTix4gYonbbhFHWNVT
 dIjozog4HeY88ZZjxxWzD2v1VdL7pDDQ1egIp7SAqTUmyqO93ITr2vgvDVUXkxigfWmU
 GzwDSIM0TwbGnRRtyq6xKsBzhHYeqiUaLt3wpzzgLqWDiLZRJGzpfMOJ3JFFQ18DBp9g
 NQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kpovk2wDR4cuq4dslsWniRlZuj3byLtaKoc1QMTNeK0=;
 fh=g77EAzovYqokRhGQmsohhz1E5xEmX8Aq0laGhUPZvvw=;
 b=KlL16e6xrwf6JHQB1wCGGgMxKemFUUuJzaZ6wv2nDtZ4zKqiiST1fyFft3gjNuQ8W8
 zRO6NVd7hm7rOKpBdPFYR0UCFPZjb499WhHA0FMTgRJYvesDGbHBMtxA9xDrEAkgerlw
 tq+hs0e7/yy1NP2s++/xjcvUJmKIqySV7kcx3FfeNqxArX/anLgtsuQ7CsaYUjlf+3HY
 UiX/MINE+U6hTQU6nX8Iph5zh/OreTVWOJZaZFYJSFq9Rv+LY9p+SXleROWv05hYaB22
 FiWJc7TM/b8mVNazW9GFgW/iorYW7sIo/DDTFKVGuoUss2auGAj/N6KeENw/Hx2OYjpW
 d/kQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788776982; x=1789381782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kpovk2wDR4cuq4dslsWniRlZuj3byLtaKoc1QMTNeK0=;
 b=zTm2jEU6FSPkcQEiirDPLXYyxmgmLtol6N7turF3bCfJIqFTrFwokzjGw4bIZrjxH0
 K4O0d/NxqJaY/VgE9B0EFOkoCqiYHCjOGFLg0w1qaZxIy5qjH4r04vTt9DzkWqDbKLqS
 pqpo+XDgbeAgg23g1ZX8mIvnjl8LkCTLYU/nnvGUTcWrxqpKBlk5l7SGUbKY4E7WJw+6
 pACYXV2qHONxdd928w/r5Q0N3fa1v89d6sAioa/IQ3FEytzh9pLcAuIfAsT+TBR3x3dS
 cZS2Gm2WcxSjSSArEPRNvPzqKQqdOQVik/TN6E+rTfmnW5YYsKydklsxcQohr9Fp+iG5
 f3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788776982; x=1789381782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kpovk2wDR4cuq4dslsWniRlZuj3byLtaKoc1QMTNeK0=;
 b=TZ/quNGQi5FoSaBYJKSFg353XMvQSra2QRu/bq03BZRWh95rptnPazEvh3+8ajqDSJ
 SGELq3nzUnS2bZl3JJvOo/T7pS+GWpNCFaPbTZyQt7TI4LOPolCyRJDXOcvxdnvo46Ch
 IphhMTbbnC9JCVezpc4Eiz+RHMYpb0stmpiQNISXYcwp9nSwALDTuWYvE1IT6g8o79G9
 l7HQVrbqAIBDYmYAPVh03S4uHITnM1Q2PMOc23uGX+uXxpnsaO+zk84pnAAHzl7+8pEy
 gQtTE+p73H856almBVLsDRDCvBoMB2AYzGdkuJFkxNIa+DZJV8nOp1fjVJNTPV2MmrtE
 JkNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJ++F58994zHeTzP2PNdhUA3SgngfTHK/qONA0BOco1nxmVvyb0DWpr2KNFTO3wr48vU+HLsFVuglf@nongnu.org
X-Gm-Message-State: AFuF++nmfeJkl41HF/jPm0bh/Ae6yp8VdyXd8AYLcf10Dd1WF9peW+Jc
 39riao702yiuQ5HI3EDqjDcgWW96h6309UV9Y7ZOi+mB4NHHeZ7NxSdeSoR60tBBiQiAkldBGRa
 e9M97G0B1Ui/38N7u6w09ocvlmwh13OSvnQ3R3WNneA==
X-Gm-Gg: AYBFou0V7F1rtiZZZ5jIg5gVohYjJLJ8Pt5esI8mx+66ZfXMB/oOoOjvbTb6LPbqaVY
 FF0cGwzrtuEYzIj8xhzbmYKaYXZdYPmNqMGgnNV+6UZDZFTWwMMeKU+tdHxgIqNW+qGyKEaTd2r
 xSiqPuuC8C4kzJQKDVjR76IshMNdSuEQUzD2yuREmwywishN5KLaZ8MNmI8OE5hRjF8fpJU5d+c
 grIuYwuogRQTzdoJMcIWkcCIQfOwxrqUxSSLgsGgQ+QI73kDELvTc6VWl4ECGOBNWI2vzLFPStH
 TnQpeGAOYrP6fuhPg2hnflqDLlm27GIuhZrnWYwrmnSkPoDfCQI0ryclE2kDgaaY+tg6lqYYSLB
 Z7Zt9Ni9lvS/sMQbLMzTO6AptfSbO
X-Received: by 2002:a05:690c:e3ec:b0:873:5bd1:98b5 with SMTP id
 00721157ae682-8735bd19ff0mr53492707b3.39.1788776982490; Mon, 07 Sep 2026
 03:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
 <aoxiBB2Wn8NiL5s6@x1.local>
 <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
 <aprI8xQIDCRTJOV1@x1.local>
 <9d125a95-0fa1-4ea8-a8a6-4869afc629bc@lanxincomputing.com>
In-Reply-To: <9d125a95-0fa1-4ea8-a8a6-4869afc629bc@lanxincomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 11:29:31 +0100
X-Gm-Features: AcwNN1VWk8NRxaWIEuR3tuJ59HYNQN-ogtxwUqbglZw6rDiK6gDjVvy_tPlbesI
Message-ID: <CAFEAcA-hV-eZHfH1FMYNLaFY8M-emt8aN+Nt4MvfhSfkUZv7AQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, mst@redhat.com, 
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 7 Sept 2026 at 11:12, BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> On 9/4/2026 9:34 PM, Peter Xu wrote:
> > On Tue, Sep 01, 2026 at 10:44:13AM +0800, BillXiang wrote:
> >> On 8/24/2026 11:23 PM, Peter Xu wrote:
> >>> On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
> >>>> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. D=
o
> >>>> you think it would be better to make the load/store_atomic* public?
> >>>
> >>> They do not fit by default, as we need to still process unaligned cas=
es?
> >>
> >> You mentioned the use of guest CPU context in [1]. However, what I mea=
nt
> >> by load/store_atomic* is code like the following:
> >>
> >> static inline uint16_t load_atomic2(void *pv)
> >> {
> >>       uint16_t *p =3D __builtin_assume_aligned(pv, 2);
> >>       return qatomic_read(p);
> >> }
> >>
> >> static inline void store_atomic2(void *pv, uint16_t val)
> >> {
> >>       uint16_t *p =3D __builtin_assume_aligned(pv, 2);
> >>       qatomic_set(p, val);
> >> }
> >>
> >> I consider these to be generic atomic load/store primitives.
> >
> > __builtin_assume_aligned() tells the compiler the address is aligned.  =
What
> > if it is not?
>
> When using __builtin_assume_aligned, the compiler will generate
> unaligned load/store instructions if the data is not aligned, rather
> than emitting byte=E2=80=91by=E2=80=91byte code, which may cause errors o=
n processors
> that do not support unaligned accesses. That's what I mean: callers must
> ensure @addr is naturally aligned to the access size.

Indeed. That's why the ldst_atomicity.c.inc code only calls them
when it can guarantee the alignment, with fallback cases for
when it isn't. Those are the lowest level internal functions
in that code, and the higher level ones are things like
load_atom_2() (which might call load_atomic2() if the address
is 2-aligned, or lduw_he_p() if it's not but the caller said
it doesn't care about getting a 2-byte-atomic load for an
unaligned pointer, or a function to do an atomic 8-byte access
and extract the 2 bytes we care about, or if all else fails
falling back to "stop all QEMU threads and do a non-atomic read".

The difficulty in generalizing that code for device use I suspect
is whether the fallback cases remain the right thing to do.

-- PMM

