Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC24FCA5FAB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBlCu-0001Wg-5l; Tue, 29 Sep 2026 23:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBlCs-0001WY-TH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 23:42:10 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBlCr-00048t-8J
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 23:42:10 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so2201365a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790739728; x=1791344528; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvBtvf5o9mhfhCMayeqkoqFo71I0ElEyRiv4njvr6P8=;
 b=WnSK8eHbWBNnjkNHt0KA6R12Tmaaw4idmevu3dI773EtXsOO6RacBRwQlCD+5u3gRC
 eGmZ6tdAbSg1gxaNYcNhVV3/pqYw5BLDTC6IANj5GrtibtJk5t9yF4GWWqHlWoDbFwjK
 ih2Na8Mfid0tOg7hXzJQosmOuBE6x2ZqfDhtW89Ey3FiMwc4/UBKvXQSTIIMgQWJlF4O
 JAjEOJKs3yFdXDJN48/meNp0D/gNnY4mpsfWmvQ7+e1px2cNANGSDBsTieSW9TBuVJOu
 cBJEMR9e8SMpLT1R8otpNLEiVfxBLBD0IR151AUTS5yiyFXw7TAxA1vOR4mYj9nyNetZ
 Zjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790739728; x=1791344528;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CvBtvf5o9mhfhCMayeqkoqFo71I0ElEyRiv4njvr6P8=;
 b=DOwmYEfyLfEvl4/xTIznTTTC7ndbOrRaKeW+xeeesnhCThXMdQc3aexZWRU+q9igBj
 BTVPPycXNQfdkAb4y9M751V0zZ7uhsKNrcYM9pdbGaqfmnKrSzec9Ec4cGB+TlAI3Pcl
 gcmZSUt6FCLT41Fnc45s2YkW50CUdaZnGCOIctK9vgTAAeA7th/7EvVgVR5HskbinMXx
 PfJ4vHS0NZmMjNja6sec+FFEOEi16GRhwKRigkWalsaItM5vDcNSeYKBDv4uQHnqxpIM
 qxfaOX4HFtF8Ywq3EBoapDYQbQR7W9ErYKPR6Qcpnjo0W1iThfaGNfBC3gyk+UAwg1TF
 yxIQ==
X-Gm-Message-State: AFq9FYI3LiVafdxEvGbRiKYsQc92GsVf8TXnH2tjHlNAwAGm9M3oYwMh
 3RluWQEL0mqglHom7apZlv/XGWorTbxxmv9uzGMdJJFzn7DpEFVsW8XlKJpOf446pj0=
X-Gm-Gg: AYBFou1XG5KnRGicIfFRk0G/g5vTfRNYsToyTDNDgtdv1wSoqpOnKTzesCWDvZikZo2
 gMi4wQ8HrHjNocMxZtRKtrnPSHyyN4Dvlq/i7yWRYkov+SpPuY0ac6txh/NX7aABlwd2xgb4Bk0
 iXY9I8x7V2B/dqT57VrsfyuaODu1JV1gjJiEtoA2z7hUeNx2g0rEQuEr+f9zKV+GM60PkmBt0Iv
 rPmTrdLEgpXJSJ5DjYbK+kzdemY9kzpeV2BbcwKygghbFkLrMwy/BqU7MRCk4mWOv0CGa/Mwncu
 iKwPINOrMLEbH04Zdrnd/gtMrPaZkZaeP9nAQW0a07Q2CwaiourvUKHDQiHfY9vW3C7YcubMnXR
 vSIhKWWGTZiHS9kQXdr6lVXxBC1QvxWXuYzRaeJLKpT/ofZT6gXjh3Ha+hNiMah3relE/6Fz3Ue
 fCYKSgEqSRrANrP6EuhlHDDc738KrDLZEAQrQYSFUXySjZsjztJfjBkZv1aVJ3IsPhSGlUlGPmy
 e3rVHeHqvSp2SqGfHhQawkREKMbLCRa5Q2YV7QXzrG844kHS4r2QzE=
X-Received: by 2002:a17:90b:2888:b0:3a2:b465:fb8a with SMTP id
 98e67ed59e1d1-3a4d1ddc911mr137942a91.67.1790739727608; 
 Tue, 29 Sep 2026 20:42:07 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2dd54c089sm3596195ad.50.2026.09.29.20.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 20:42:07 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:42:03 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 00/11] tcg/riscv64: Fix AUIPC pair range validation
Message-ID: <aryAr-8oUs5ZJ-2-@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <983581aa-ffbd-40f9-8a9a-b6fbc066a1cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <983581aa-ffbd-40f9-8a9a-b6fbc066a1cf@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x10.google.com
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

On 2026-09-27 10:30, Richard Henderson wrote:
> Ping.
> 
> On 9/13/26 17:08, Richard Henderson wrote:
> > Hi Max,
> > 
> > In v2, the change from int32_t to uint32_t is pretty much
> > the opposite of what should have been done, since all of
> > these are logically signed values.  I've adjusted all of
> > the encoders to take signed inputs and assert in range.
> > 
> > In the process, I noticed tha the branch range tests were
> > off by one.  Now all performed in exactly one place.
> > 
> > Finally, tcg_out_ldst needed updates for AUIPC as well.
> > 
> > I've tested this lightly so far; full testing on a rather
> > slow riscv machine is still on-going.
> > 
> > 
> > r~
> > 

Hi Richard,

I’ve discovered a verification scenario that could trigger an unexpected
segfault due to the AUIPC issue.

The scenario involves running a debug cross-build (riscv64) of
qemu-system-riscv64 with a plugin that instruments callback (e.g.,
libhotblocks.so) in a host riscv machine. (I used qemu-system-riscv64
with the same images here :p)

Before applying this patchset, the internal qemu-system-riscv64
encountered an unexpected segfault during bootup.

(P.S.: I built the riscv64 system mode image using buildroot
qemu_riscv64_virt_defconfig.)

Thanks,
rnax

