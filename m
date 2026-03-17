Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD9FD877E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VIt-0002WG-HS; Tue, 17 Mar 2026 10:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2VIr-0002Vy-95
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:21:49 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2VIo-0003GU-LJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:21:48 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64e87a81639so1358494d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773757305; cv=none;
 d=google.com; s=arc-20240605;
 b=VrcpqFVZE8znnakAn1S6L3EFCSlbl5f6nKqAM64c55V7tCunHs+OduRVmuNy6hWauH
 RmQ5MJPe95Q67qIwlIdKVW4uBCC+VTI1auPIBe4zoTC2HUhd2C4PavobnNhRPA3sv6bk
 GgxlJx6nSkwNDJlygaF+RWkhejflzGbha+nPeM8IjrnMNuwpbOzatwgqhsEoHha4s1BK
 1WG6kIFP5cFraKa28Li8i47T6g/KRE/emklL9Ah6+Vr3VyWrSa9K7Vi8oN4nB9wX6xXh
 HGQmiSolfwPX8KZ38/I1SimZf3ZsB5wDUfcI/7quzBgDQrjXfAqHD4JZEcGb1IUl87uS
 Ihcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MwTC17NekWXhNq1MG2syUUJW8O9IFvvP2gRuZC9nVDw=;
 fh=3QNFaQgpQQ3n3nYWNWujyNvo/uN/nVjH8Egh/mhBA2E=;
 b=TZNHs4L/9GVTqqBIMU3uxTNI7gHr7WhKpRsdxNakdJZzH+u2MTyq7ofSI2fvFIeeFD
 usLOvZszB5Urw6L1FiEUAB2ZHpp9XxNbxCHPqopsDBF31yRxVR6gHj+I7UFhnfp6s7/Q
 6OCqE53voO/0E+IrG5N/IENd0abaBu7bP6kZMBhCiDZuOOdqvW46VE23CuGq2yJl+aUa
 WNIEb7/uWb3yewapD7g2d2z5IEPY630WNejZpN3ubdDD/QQ/S7WCqx6QKpIvmyZTGkcF
 1p5kZWlA2ZWC2kpP5teOmJAsb0fUxRXHlT0dkIvziF74lm2Psolf+ihgk6bHy/Hbr7eL
 Sgbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773757305; x=1774362105; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwTC17NekWXhNq1MG2syUUJW8O9IFvvP2gRuZC9nVDw=;
 b=ZCeclLM2IiUpywaClBFM9kxm/It4hdnik1lUD/WNT4+9vqGsoQ45ca1zH2vM/XpU/Z
 pcuenQqv4MFa7olOG5dWf8YFSNu8QssC0VbmpQq50QGcDUv535dlp1OaoD26GNtEfLH8
 tloaaCjJoxa3JYVniSAKqCoTqYx9Wm3+/n1Dg90aRox1GJL7D09/TEZVLHNfpEEMQcJZ
 D7Jy2HoY1uHtQhx4n4HvfAauVOUUyfHCz+QDArSkJqH7QbRJKU+NXlI2uMHa1qS2BJAp
 QAfxyh60BrSwKUMHs977efd55UJfoYnqRuX2GA5Zefmqmnv1tkDTVK+RFp67BYtv2loT
 L5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757305; x=1774362105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwTC17NekWXhNq1MG2syUUJW8O9IFvvP2gRuZC9nVDw=;
 b=KWElMVCdnoGLCBfODX0Uxr9E0t5JrJORNJNYHV3njid0KwaoZPb+UKCkccuMZhGs7V
 y5JT52xry8IZ5zeRj93KYA6oMoHszE12d/X5vn25b4q2bBfXuoNnjacSqSlDhrhbrO/N
 Mnk68fdXX5v1mJvj/x/LsMlnDiuKYUX7uPw8LYtlFVDqm1pcjiZNsIQa0epsL31UgunE
 fmmavKxpDZQuQavY1dNWDNLLwToFa7Tw2jbI3QnDFLqrjGCYjIftE1hu5tnFc2Y+5qxm
 UWL6YGx92YQyIZ6haBspfTLW7Hy/PfNBIl7OY6bfbTOBYzNIWVi6a6t3wkCxqY0s90u8
 AtYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYdPZLhHXtd/oyfp2nV5DG0+owsCu+1IElJK8VaJUDdJb/fmyO8PxyR5UA/NB6sWernlhgIn8esgf@nongnu.org
X-Gm-Message-State: AOJu0YzGKj+sc4pZXl8/YXZpNnA4DwUx7c19vi1NMriuXyFBzO6YfuP+
 mf+d0KwnK0b/kxvxSbhdJ6961e2DiC3cK5I9clTEWqW0hNcmlpUZnu18KaJRskDKyC2kkI6VFMi
 w8p6Ns8jyGhUY0HVqH4imf9WrGgpy+UIEXggEfaQKqQ==
X-Gm-Gg: ATEYQzxJ5UyGXNZ4JBOjgYgsCUFO0m0rAWuF6CGBP5copkLpqI0NSNTHoyzYre/1uQS
 aQyNQfGP9XVOTff3+GO0W0PywUBbeV79TDnBQXJGDlEWmwgFdyKLF7XtpipoPiuHbQpbtYXg99Q
 WwnOPojogekYpaz7wB5zF8+9HWQJh/oLBl+xqSuA73UhbRZ159+sxthI/Ow72YQZGcbM/dw6XaF
 YqmoN64rToTPZhsC9PRfMl/XjjYNHUdatX+hhjFuNKCWvihx/oRHFC6nCeQj4jchnnPGsPCkStt
 rBiA+bXOBCwLIZXZJ41d71lp+L+DcMFgkYRVeWr5mVn1FXfPUU3X5NkGKSWXO+h+wms=
X-Received: by 2002:a05:690e:438b:b0:64d:d0b5:3f46 with SMTP id
 956f58d0204a3-64e62f07143mr12743077d50.7.1773757304855; Tue, 17 Mar 2026
 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-5-pbonzini@redhat.com>
 <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
 <abjXUtJNrcmSFUP4@intel.com>
In-Reply-To: <abjXUtJNrcmSFUP4@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2026 14:21:33 +0000
X-Gm-Features: AaiRm51KM2BTX1HDfYfsS6D92MKkFgnpIyRZuKoFCLbjMwBlqJ4hM1MRy83QNbo
Message-ID: <CAFEAcA-OqrbNGgn8krhJGYAPTg=_ojzgts5UP00OX-WmEYhP=Q@mail.gmail.com>
Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
 default
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 17 Mar 2026 at 03:57, Zhao Liu <zhao1.liu@intel.com> wrote:
> I think Fabiano's patch is a clean solution. Or I think there's another
> option: we can bring needed() back but check mc->has_hotpluggable_cpus
> instead, like acpi-ged/cpuhp did ().
>
> Igor, what do you think?
>
> ---
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index bbb1bd60a206..5c7dfb2c69db 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -184,10 +184,18 @@ static const VMStateDescription vmstate_tco_io_state = {
>      }
>  };
>
> +static bool cpuhp_needed(void *opaque)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +
> +    return mc->has_hotpluggable_cpus;
> +}
> +
>  static const VMStateDescription vmstate_cpuhp_state = {
>      .name = "ich9_pm/cpuhp",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = cpuhp_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 43860d122780..9b7f50c7afac 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -195,10 +195,18 @@ static const VMStateDescription vmstate_memhp_state = {
>      }
>  };
>
> +static bool cpuhp_needed(void *opaque)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +
> +    return mc->has_hotpluggable_cpus;
> +}
> +
>  static const VMStateDescription vmstate_cpuhp_state = {
>      .name = "piix4_pm/cpuhp",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .needed = cpuhp_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
>          VMSTATE_END_OF_LIST()

I quite like this option, though I defer to people more expert
on the piix4/hotplug code. This patch does fix the test
failures I was seeing on MIPS.

-- PMM

