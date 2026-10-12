Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C0CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGFDC-0007Gg-VW; Mon, 12 Oct 2026 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGFD3-0007FP-Jl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:32:53 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGFD1-0000CX-0b
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:32:53 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ac525c1f05so13349407b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 05:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791808369; cv=none;
 d=google.com; s=arc-20260327;
 b=Ts9MkfpdfV/z6P6Ka5QgoPPvfhA+UkWJQwphHJ33JobifrL3UHy4FeufmLsS9S4wB6
 RNbOaCSi6tR0iM2iH08OZIb5Xr+ePoG97GWiMxj6ZxvhV97vEf/GJVsbsRex+h1avMNF
 43xOjF2w5Y8hprZOlqAV3WRwj2NEiho+/tQ8ELszQPldngB0l1p5mwU5Zq+NL+gdI1LV
 Yk5lr3HmfWxO+/IQNxWA9tpyhgUT3IxMlM3RqdH+1w0DBsja3RDxL+ah/+yb6fW5e/q7
 Hr8QGpEGDfVzaGy9D0IuydXqmkLV9wcHMiJTkXUh/RrGqxsaASLGTzCp+LNnIm2VX1Ys
 9dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=46d0qPPxK7zwjPUS5yP8stjzanBYFETDa9PZ8JIKsoc=;
 fh=NEyRVjg04fVR3TycHvG0jl9zlGvJgXNyHVqB9OOnoxM=;
 b=mFb5M2/zsm2XEL9eBKWhcD6qc1D2dub9oJQk9/yb8XOsTo0/iin/WrA12Gz/pxXdRU
 /rmK1Aln0cN8DUu1xvuG2sRRKjKCksJRym3a0kL+Cg230t/eo9NaN2m6sRsNPcfTqsOI
 Ub3wXZTRC5KyOrQpwnnFgWRtxydaHENGAYJXcgz6ECeOvtwHq2wIHfy0KbvQ20IpRA//
 NDqA0LAFsZLVOr9xDhv2F54/MiKxXLKgKYIRYujasOHT8nwhAHAyhFzpv32wNf/dr2p5
 1Ple7+f6TMyTUckfVQyDTKAqXGpr0onaV+9FRJ9p4gkRXp96NeJe4G+OAiPrZT0tGPl7
 ztag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791808369; x=1792413169; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=46d0qPPxK7zwjPUS5yP8stjzanBYFETDa9PZ8JIKsoc=;
 b=IKh3fTAaJcS1F6AT3xGpQMcvCsvYLfbKLbE2IGirOdmQjDgaOwoD+zBGTk09ap3EfN
 JZWhfc6sCFEGq9S3AFvahM4RpkmBV0fhOFbwfT0mIR9EtkUZBX/BAZNfV7KUoapnk8cZ
 mo384sILcipAgc5ygbcWznPkR9jyor8wFP/5X/jMmlco/wMAMIx26jswUJYGNCJ7nNxw
 OkZL5zLTB/R1utUT3aqEkxKeigweATUHmaHCAz1M/s5bJ8VWuBG4Vt/rLFj6eF6RmhC2
 nSt1ugJlUCRCVSHeGDQZhUeTCCIgvzigFXEHsWJC1BugUCgC6jGPUvraFriYgmEBEK+1
 9chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808369; x=1792413169;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=46d0qPPxK7zwjPUS5yP8stjzanBYFETDa9PZ8JIKsoc=;
 b=FCJgV9fDhTE+IsZZB1o4CLuUmPjWy0XOsX+uasLswezZQ67Ar6KWZZqApH8SeAUdOW
 ChIHCq84qARhnHcuu0/JcXYzFy5iLdzlSWQcxx6EuieZlETE2r83NJaUBTCobJPt6wOR
 lZ2cB/ZwQiHQqr8BEWzMpotHBocPPFQK/nlF2aoIbLL4zSo7QAKlvfe6CxG7vKMCpSw9
 8fl4KrwSIaOC2G09QBcjqP3nqeRgWyCoeewR+/OXcBHAM4LpUKErfkIUywhQac41/gj+
 A0UlXo4Wory7JXn0LDP9M5qjLvTpdMRx++lTEDLUw27e903C4/b6WldCq2BoI/sQBJb4
 duww==
X-Gm-Message-State: AFq9FYIg9OP52OCi8Y63gfUlDf3gto0ho+xIdliHmZJ/brlmJM2vbeOu
 gKFG/k/yRqLNovH/sTxpKYQfmMh9TqyiiIpa/7oPmqdw3mhEKvP8Y+mN++l17WsgzEiK+3dQCdx
 ahMhorvFJVQ/ePh6oh24WI+4Pi/Urb4zpFUVfJ/2Utw==
X-Gm-Gg: AYBFou3aoxy6fop+JLJF1x2K8oQEzJxtz/BSoSdZDjVwVZo1ffE9k78fivcO34bdDra
 N8U0Qg7Jz8YTi+KuEr6R5CxwAVVvzoFOjNBk6Uz0Wbbqx6tXoBIhcZm4mMp03OI2YCzHD+Ugf5b
 8y3EYVR8Afapyhj/IvoY5qyd6SHs5VBJoAt4yRUWZGbmKieg/u5vngwo2Mq/+HyrQ7k8FpwLhRW
 +8L/FapsXumx0ZboJiWMdvYm9op0wYyraGDHHkhISHB1HT4Tatg0VimddOEmyYnvIb1eeiwkMz3
 CLXPasbwLHZg1PE42GZ0fuIpiS7tCnAzzbUDcgUL7MdanyhTJHaP7be3IlO0iLOJscTkgzE61/n
 CmNQavODO8AkDa8Q6wcBgQjk2HndM8z7gSYQXdcg=
X-Received: by 2002:a05:690c:6e85:b0:8b0:a352:f96d with SMTP id
 00721157ae682-8b0a352fd2bmr11739437b3.11.1791808368621; Mon, 12 Oct 2026
 05:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261004090500.3082641-1-bin.meng@processmission.com>
 <20261004090500.3082641-2-bin.meng@processmission.com>
In-Reply-To: <20261004090500.3082641-2-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 13:32:34 +0100
X-Gm-Features: AclHuK_MFJQiIRUZ3pR1LXKyfoDcxnnCZt20Dv1-e5MwI9M5YrjOpKmiVHOg3fc
Message-ID: <CAFEAcA8AMsN15gpeQTOR39w4uhVAWsfa44drHgXP8NN+pYSkYQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 4 Oct 2026 at 10:05, Bin Meng <bin.meng@processmission.com> wrote:
>
> U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
> so that access causes a data abort before the console is ready.
>
> The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
> specifies read-as-zero, write-ignored accesses to reserved locations.
> Model that page in the private peripheral device.
>
> Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
> https://documentation-service.arm.com/static/5e8f15e27100066a414f7424
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

In the interests of un-stalling this, let's trust the in-practice
observed by u-boot behaviour over the TRMs. I have some code
review comments below on the specifics.

> +#define TYPE_A15MPCORE_RESERVED "a15mpcore-reserved"
> +DECLARE_INSTANCE_CHECKER(A15MPReservedState, A15MPCORE_RESERVED,
> +                         TYPE_A15MPCORE_RESERVED)
> +
> +static uint64_t a15mp_reserved_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void a15mp_reserved_write(void *opaque, hwaddr offset, uint64_t value,
> +                                 unsigned size)
> +{
> +}

We should make these read and write functions do a
qemu_log_mask(LOG_GUEST_ERROR, ...) since guests accessing
the region is a bug.

> +
> +static const MemoryRegionOps a15mp_reserved_ops = {
> +    .read = a15mp_reserved_read,
> +    .write = a15mp_reserved_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void a15mp_reserved_initfn(Object *obj)
> +{
> +    A15MPReservedState *s = A15MPCORE_RESERVED(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &a15mp_reserved_ops, s,
> +                          "a15mp-reserved", 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static void a15mp_reserved_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Reserved private peripheral page";
> +    /* This device is an internal child of a15mpcore_priv */
> +    dc->user_creatable = false;
> +}

Defining a whole new class is overkill; just init the memory region
in the a15mp_priv_initfn() (it doesn't need to be a sysbus MR).

>  static void a15mp_priv_set_irq(void *opaque, int irq, int level)
>  {
>      A15MPPrivState *s = (A15MPPrivState *)opaque;
> @@ -43,6 +81,8 @@ static void a15mp_priv_initfn(Object *obj)
>      memory_region_init(&s->container, obj, "a15mp-priv-container", 0x8000);
>      sysbus_init_mmio(sbd, &s->container);
>
> +    object_initialize_child(obj, "reserved", &s->reserved,
> +                            TYPE_A15MPCORE_RESERVED);
>      object_initialize_child(obj, "gic", &s->gic, gic_class_name());
>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>  }
> @@ -131,6 +171,12 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
>       *  0x5600-0x57ff -- GIC virtual interface control for CPU 3
>       *  0x6000-0x7fff -- GIC virtual CPU interface
>       */

We should extend this comment to mention why we model the reserved area
the way we do, e.g.

  The Cortex-A15 and A7 TRMs suggest that the reserved region at offset 0
  either will (A15) or "can" (A7) trigger a bus error; the TRM for the
  related GIC-400 documents RAZ/WI behaviour. In practice, u-boot for the
  A7-based i.MX6 boards tries to access this space, and does not fall over
  on the real hardware. So we model them as RAZ/WI.

thanks
-- PMM

