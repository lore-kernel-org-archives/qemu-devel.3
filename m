Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B9BEA8550
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztJu-0001r8-Mc; Tue, 10 Mar 2026 05:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vztJt-0001qr-Tb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:24:05 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vztJr-0004nT-LC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:24:05 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so12296023d50.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773134642; cv=none;
 d=google.com; s=arc-20240605;
 b=iS5C0afG/unD+t/K31h/l71OU4ZCv+lYhKSOG/3Toz6XzZQ0QjPN+6uGa2Y8NLIZCl
 Q4SkNr7MtpxwizjQbzE8wN3UxemMVV/jneUjvCbqosuhJQGiozbg8y+vyfRD2crqzraZ
 WKf5LWKC3RQvgflfbOaaKJ2jBw6ckNRaQ/xhlhhyoJVUBFWyXunOZ0D6mIil9RGwSflg
 Nprjc+RpTWmtteWHDdHr6JB/c6SVloM52Yq84YBd8oh/P2bzVrOjMmcNq7LLMYvySpE5
 Shtgn9Rbjdu+yg71jj1uhxKccCcDEbhsZMPqRSPLdqgfZQg50fBlSXLq7fG/T2FrBh5f
 1wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ePYl0PVMV0NyGzAzR4pZ0F8jALjktyZFJN+6lYjs76o=;
 fh=yv3w+kjv7yTHIWnh7d9fCRPNKJo9KDQR8bD2En3PsEw=;
 b=QS48C6eZ8zYeN5Ms/cq6wVWSvhyjePF2DubGZNK2wN97cZum21FROqoiKIH+BVR3sK
 onh47I8KpMeyit89vUGRYmQCk4IIDNeY7zJTh+d+K6d88btDFNVwfLB3zPc4kD6fNj1t
 f4CqtFNSS/cQmToRLOIdY3Jh7ZoGtk8tCEnZW2MdwTr238Q15jMA8egNr6ysvXJQR72G
 bHK8uk9I1Z6XR6FpAEvPdYomjRpmxGQVWbtBK4moINRI6l3Ksl4VgdTn/AOtjoPDh/Q8
 rNIf1o5jJGaPFu14kh3ntKBEkSOgFV2w9Cbd9P8Zb2U9f5dRUItf1N6Fv1kM+dON9j0I
 M0FQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773134642; x=1773739442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePYl0PVMV0NyGzAzR4pZ0F8jALjktyZFJN+6lYjs76o=;
 b=KQZhXvAj0iZ/EaAsLdD1GNh36AczwPqdC8N9R374COdJ8We92gHCpiPx3wQm++WFtj
 Os1q6pmLfAwRxgfL7q+akZxXNdcKZ5EC0A6oMGIGwLcje/oegCM9VGGlOG5eOguX/W7q
 fiBYHOS6CiTihHPuau7Mzcd9Eus5xH9l3fctmTAgDZPyHCk+pkqbr8tJ36YqvnQr5cSf
 IyBvvxxRY1K0C0GJX/+3DD54nLbyRbTaJZ2ZQ6Jg7rjlOY1+S/Jl8DYOPsTlj5W9rCGg
 WXeb9Kh1vLcJFU7s0MKx7K+UWVquo5XYL4yVTlL0EC38vo9CmtroUksPqRMc2vkFTUaz
 tZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773134642; x=1773739442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ePYl0PVMV0NyGzAzR4pZ0F8jALjktyZFJN+6lYjs76o=;
 b=T47n+5mnw8falxoYzmXHPhdvCSpeZBl9twP+CarepMAflbKjHPb+sLq8CkzZ/citeo
 BF37x+fIkhnI9h76uCo//a4SQcI67TlF75t3E8YtBhnXXXICmc5CkwEcoTk9Y+LmJ8Qd
 qlQOMEpJD0pdy8Byf7p5cbMoiva0qFsckYaFmo6H/+9d10nK1j2fxwK2jHzokM2AKQQ5
 bvdy96yp4yqESRioeDEst4x4fvN9l6Yb0CMEKdwY/I9EaHZUr1mjbHJNVGe8VTIS0GfD
 xuzTr0Mv2YIZwF6Kcha/HuIUIQBl++aSpYocJWXDwOh+LzFaZpUxM26U42Yst7ZMODf5
 efQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcdT7ShXoDTZGjZ/7Ha8K6AeuiKNAZ9WvUOUyrf4YW0vfGwAZNKszl6l/ZVy/52xMJnqJynT2N1tmh@nongnu.org
X-Gm-Message-State: AOJu0Yy6ZMsGaqaXZAob/Grdp07QL0vZAa+VxoMmqAS5Xxde1R1lZqof
 zxfeUhMHbvuCElPnSlDk1PnlLvpW6EBXxHomzvEEUrrMMsdXBoVBx1rsMyq1NbnbTmiVstwVH5s
 QeMsF4Sev8p+qscoiZH9m+DC8paEmtcL8OW2RLVFToA==
X-Gm-Gg: ATEYQzx+1y5Kmkf8ndDIu8Ds0eq+tgDKr+t1d8OOiDHlznIEe5ghv2yfnJoenyaGSog
 CXipHrdS95CUOQG+9lMwvdCVeEy5HljrjwO/WQcG+LVSNEeW0eEJJif5yRYxw/+dXqBGgHPrbSW
 G/gx1+2fqR3xOyPts62ijYWY0Pxoc6AcCJQN8GTpV0BsIkmaKouKgDKB6V1nbCc8fHE9YWZWKGH
 bBNcXjm70o3SyooAF0AWv2ZBvi/zrrZCUQpAHtMq0Cp+2WaE1lDFMVn1aGxAMlImrLKZtq5lEmc
 dYn8mqvkWQMYFv23H9rBwPshOrB0rKc7fQgZ62ACtxw78pAk2h/dOWBeyt4cqtCPGF4=
X-Received: by 2002:a05:690e:12c9:b0:649:c36a:a9bb with SMTP id
 956f58d0204a3-64d142c6c32mr13054838d50.61.1773134641897; Tue, 10 Mar 2026
 02:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260309214852.92545-1-lucaaamaral@gmail.com>
 <10F88EF8-950B-42AE-80A6-6B1E13BAD27D@unpredictable.fr>
In-Reply-To: <10F88EF8-950B-42AE-80A6-6B1E13BAD27D@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 09:23:50 +0000
X-Gm-Features: AaiRm52L9ai98MIgcrAa_q3ljjkdnRiXiqNAVZ8NYav1H8IGFST19uk1Yn28Zsw
Message-ID: <CAFEAcA-kie72iOi3KX-s4+rZmdNPYz5JbObY51x7CUzZVVEbHg@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: emulate ISV=0 data abort instructions
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 10 Mar 2026 at 01:29, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 9. Mar 2026, at 22:48, Lucas Amaral <lucaaamaral@gmail.com> wrote:
> >
> > On Apple Silicon, HVF exits with ISV=3D0 (no syndrome information)
> > for STP/LDP/STNP/LDNP, SIMD/FP load/stores, and DC cache
> > maintenance instructions that access MMIO regions.  The existing
> > code asserted ISV!=3D0, crashing the VM.
> >
> > Decode the faulting instruction from guest memory and emulate:
> > - Load/Store Pair (STP/LDP/STNP/LDNP) for GPR and SIMD registers
> > - Single Load/Store with writeback and SIMD/FP variants
> > - DC system instructions (NOP on MMIO regions)
> > - LDPSW (sign-extending load pair)
> >
> > For pair instructions, compute the effective virtual address from
> > the base register to handle page-straddling accesses correctly.
> > HPFAR_EL2 reports the faulting page, not the effective address,
> > so using the IPA directly would produce wrong results when an
> > STP straddles an HVF-mapped / MMIO boundary.
> >
> > Tested with virtio-gpu Venus blob resources on macOS ARM64.
> >
> > Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> > =E2=80=94
> Hello,
>
> The idea is good, but this specific implementation is NAK for me.
>
> This ought to be in common code target/i386/emulate style instead of in s=
pecific HVF code.
>
> Oh, and using something that looks more like a regular decoder perhaps.

Yes, if we're going to do this rather than simply saying "fix your
guest to be more virtualization friendly" (which is the approach
we have so far taken with KVM) then we must:

 * be hypervisor agnostic -- KVM also could use this code,
   and I suspect whpx would like it
 * use a decodetree file to do the initial decode
   (you can probably borrow the patterns from the TCG
   decodetree files; don't try to actually share the files,
   that will be too complicated)

thanks
-- PMM

