Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1AEEC1429
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNOe-0005dv-Ek; Tue, 03 Mar 2026 05:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNOa-0005d5-10
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:54:32 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNOY-0006r9-Ig
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:54:31 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so4752804d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772535269; cv=none;
 d=google.com; s=arc-20240605;
 b=j4NX71m6yuyNS/lCKybUZ7ex7QQ4bYef2ewXtS3tczDLdm/mo2Nr9/VwJ3NNurM0OM
 uTNYNEG8w0UCsZfiwBHnnbbEogDuU9QFcX0UNRtEAmdN2Iuhu94gfmcwV9/sIEKq1hzD
 9xqyc87n3PB9L8sw7ESim+7g1V2rrcBCzNc125ZIi4PgPVS+kfSwziwSIWgh+cmttrKg
 x+AWh2CDJNhbmzReADRUHcZJumqLxC867CQx8693OtVZSGRDlRpt/PRLgQORBA/SQO1z
 PmaX02ehy/5CS2L4y1MzthbxDcy0u3sX2Zl8/38F09Je3WDe951ro/o3w1qmmbU5CCHW
 14SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I7/oEUbiOqQUR4EtlmAbLUTq9ldIKUaBwwgFXUxw3f8=;
 fh=c3FqgpkaVTkY0Zpv6ZxHkFYc0HJjKAjYRnYx+9g6neo=;
 b=OnnlGRyX/tEpEDi2lXdzpXPNnzsfx0LKAg4nG1KdFXOLF/yov3y+1UR/RqBdVHMQi7
 80ZKBcgz3uP/M4q3OwcTgdrVs84uJY7ra2j+++vWjo1l5gU+CK3DXewLmJvv8GswQrcm
 Dvl+9SZoLlob+eR2yBQQ5fQKJ14T13x6y+3Jzyt4EGQL0yusGVzOu5QArE0mpahkbo4c
 pDxCv2YFmw4cP+cNB1GiTRyEgeMhTXSCRoGbsgp8Oo/ZoRIDIkCBkkd1Gz+n4TKmzIIL
 4Esz6hZuqOZt8b/P07EaenrT275ImJr3LWfGaPiEH8yd3HhnOIrO6oDq46tSXlneRVst
 xoDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535269; x=1773140069; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I7/oEUbiOqQUR4EtlmAbLUTq9ldIKUaBwwgFXUxw3f8=;
 b=v34GSJYyexibkjnIxoBTNnz+YzIfPu6PK2XH68gjngLiiLc1THV3ObbPve07x4zA5o
 TeIYntKL4lNVBm86cs17aHrx6MRijloroxOg275SHK9EhwyGIodxsRoScWKuONWGmcP2
 wrMwFjReQ/XE4QHVWvWjvBhNPKBTLydrTtiwy54q3CsXoYHOlAPowajKRerfog67bQ/s
 PPh5bhsio9lGCLnmKmr71qSzrW2yenlPo/Iou7/pi+FxInVHeRaXjoEF7IvX7G4GxNAD
 sUk23wJnEDmCLkLC3QplYuq+G2s9BhbqgLqyKyy6Gfft6fjdgKq16L4jNhN9KAF6xakp
 FHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535269; x=1773140069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7/oEUbiOqQUR4EtlmAbLUTq9ldIKUaBwwgFXUxw3f8=;
 b=ELSkxvDqMkiwZo4SMOgbwYOJi7GCorD3nM4tZxAnOp+yxl0CWFZtNx6EE3Kb+DSiN5
 no/rWOlxWktnOmquHmrEGmJMprCkjijLUYUbWBoRua7Q1D6yp44bCY0ZTq02R2Qrvf96
 i/etddbqsWgfSMBjcx+MKhZdxTcSLPmaJC33m3qvlAvJ7BVBwAqwMRsmyTRtFN05Klar
 ASrfE/D/6VMeJaMlkL0VuQNErzimHj8Qomf8l/Ar5SCRoXiM4F5cQREWE8Qs2WwQttIx
 x+DAnhkqyF71CeT6Nv0AyHyIkXI0nmx9rDsnPttYGGvJEZqnoRrd0jxzw+1ychQ0Au5p
 WCxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfZgfkQS61YMO9H8B+iMskWFnrZAq2sTcFDgdN5NwZ3bXgzwTb+/gMTd9QJKNWEIJQnsuiUYhp9sZf@nongnu.org
X-Gm-Message-State: AOJu0Yy0mYlZuujqtfccrw4noN04rk8kYkyybL9adwLqufhIUR8zACrq
 Duq7T0ZBYpyjPTVEy3ffGFik/in0P7JTlO24eEFMuEW67OJSV81OXNVse/zQ13gA8eIGAaxUkA/
 H2aM/0AUcra7K5qCH+4D/gfZA3cjT7C7dq068gnyasQ==
X-Gm-Gg: ATEYQzzche5MVgNg0Lp24bIxmk1vgXQyW9ia0y7S7iSY9ONLck/dDZlnx7Vzp5QCDyr
 7usZ9pvg746Q0t8DdOI6lX1iqBu9No24al3Arwzow0PCDsecE81I/vYSCgfTeVcZj+PqBIaLbnz
 uZul0Yt9y+nHcKCz77p0NQdE5N2sXUepCGToY2BivGK2GDjjaO31mNbqNkOmKP40tX/z0iqS6/E
 9Vh+Etcw3glXZu2fX71hJkiXweBjdkpiYM39Ec5BY79Krkwo4nP5qHHLNYsa+apCfzLFI1GGDXj
 VtpxcRFTyhYiIRG/DDwDS0UVScR9rxdaxfo7q/bxIzUOSmk1NI8RPoYhnf3Apln9NFQ=
X-Received: by 2002:a53:cb82:0:b0:64a:d64a:b025 with SMTP id
 956f58d0204a3-64cc20832c7mr9474194d50.7.1772535269176; Tue, 03 Mar 2026
 02:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-4-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:54:18 +0000
X-Gm-Features: AaiRm51Uk4LPPhktdHHnbdTNPiggtaynqQtbBi5uTc0ioSOzen9dE5fhBShiFqM
Message-ID: <CAFEAcA9Z9LWKxisumU6C3WAtWiUhV0s+tnpFNAwuaBO7GSpCvQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/arm/kvm: Export kvm_print_register_name()
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 26 Feb 2026 at 10:02, Eric Auger <eric.auger@redhat.com> wrote:
>
> We want to use kvm_print_register_name() in machine.c so
> let's export the helper and implement a stub when kvm
> is not enabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm_arm.h  | 2 ++
>  target/arm/kvm-stub.c | 6 ++++++
>  target/arm/kvm.c      | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cc0b374254e..b6980e4957a 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -266,4 +266,6 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
>
>  void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>
> +gchar *kvm_print_register_name(uint64_t regidx);
> +

If this is going to be wider usage than just inside one
file, then I think we should be a bit pickier about it:

 * brief doc comment in the header file
 * use the standard type "char *", not the glib funny typedef

>  #endif
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index ea67deea520..b13bb055e0e 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -129,3 +129,9 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
>  {
>      g_assert_not_reached();
>  }
> +
> +gchar *kvm_print_register_name(uint64_t regidx)
> +{
> +    g_assert_not_reached();
> +    return NULL;

Don't put code after a g_assert_not_reached().

> +}

thanks
-- PMM

