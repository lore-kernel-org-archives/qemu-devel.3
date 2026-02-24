Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAA4EFB81C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvos-0007jQ-6J; Tue, 24 Feb 2026 12:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvoe-0007gC-0s
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:03:20 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvoc-0005Rd-7W
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:03:19 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9707fc11so1371930d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952596; cv=none;
 d=google.com; s=arc-20240605;
 b=MVmBOT0jbOtfMue5Ars/ZxDR2+2D/BBvXNP3/efYLa3xdQQEu5hu4L9AxRad+qnobm
 VW0oYeg4Y251ByYEVWzPApjtDS4OO8C6Ddz0nqoPD1X36EuHWahPgmvnyL4JuRs7YZKJ
 q23EIzPox91U7UicnMeiHiyVVHWI1wXHQfOD4GpTSqSTCKccMPS4FhDx537Z5mwozLtE
 iLecHKZx7egTA83djnjBCzIFHVXL6rdB3PLvewHdVmAt02ubdrh6KQH7X0/s2MJ5eqA+
 8Eh4R+5cl/NMNhUTomTrvihQnAopWBWkWwRb8LOdRPpArfp62oCHsxo3n+/Q9pND4pBt
 2oQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7GjgLz0SAV0Mo5iX/SOiMEIb9K+tU1ziK2Qcu7Q3Ckk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=GDH4TR88Et7RqDjYkM9fkWhyLqKcOYHsxE4Zm1yhQvxbGHiHE0wLNOhqn8BnygHb6o
 vlhya3PlB5wrMs9THsmSkLOxaoCV4ntEwv5zXh5V3509vf2rS/stcKzjCN2AYKpp9Z3g
 lpwUS6mNNlcAuND1SqoH8IJBAPM6jhW91Pvhf6RzrdONarDkDlb7pgjEmrgJjfFZ/22g
 ZlZpHmvYQXo3HsJuxZhnvaBFAMutJKHn1VJwyLEK7Iv90k+Y5QISxtR98sYLfYM6iUMg
 RnE+RT4tEtARZ4oHt0Tokn97s5yhOdQPkYp2uh/2oxL0H+mTRjncsgWZbwdGfqwCUAoB
 W3ZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771952596; x=1772557396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7GjgLz0SAV0Mo5iX/SOiMEIb9K+tU1ziK2Qcu7Q3Ckk=;
 b=wMBCoh3smVXs6U84p5GcjQdPyMTHynq0383Q2XcwD1yS0uixDABZ+Uo/a2wAYsbyPu
 sj4bFoyaz1TsBbHGZslYwBCcVLQrz28HKAwu89GTgCitX4V3YGYjqC3JV0wxMUKF8cW4
 b+czxZT7nI6pgjGBWQRoNYIZj29xa2xsSGvFXaS0s4VRmmhS9m8LFO937X13qSw7kPwU
 cihuLYF9tusZ91kvaXoG10+6uxBP2BFzlLSPs4aRerWcNUDV7nD3+J5WMY8IHz+HNB5y
 95JEii+xx5bUWG3MIdgZRaaoU4d1aZwmP1CtPgDx8jewOewSdlqxWcvMn+Khy5xX02r9
 c5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952596; x=1772557396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GjgLz0SAV0Mo5iX/SOiMEIb9K+tU1ziK2Qcu7Q3Ckk=;
 b=LGW4D1u1rg08Ugdsqe8hTV0sZ5Xn+8w66Zij1J0pa+x1+bV93QCDnbZaGMgtTJY/gA
 AkDKmPn1ARsDxj5Cux15EwYps+4nN+/Fl5A8hCQWdR5xTcgKqi6Ehh6Z4my8/aawGZS5
 tLnEH8uDEWvYKNT04O2+XPU46MdpdCLE53FdqxVyhB4CP3Cz3gBW9typ6s3YZjEKS5Yy
 2yEIBYufDLDVHxNufk3gn+KaZPqhMdqORObjQvn+mKHIJ4T9MBA/3pc2CB2uoDWrdZGw
 71+s252GEyQ9jVAV5xIJv7Gfn2mgwNZCBELMvGVKm5IhfCYB/GyxeJhSffPoxGGarptx
 toRg==
X-Gm-Message-State: AOJu0Yzc3NQqxxgBINuPB7mEGF1FnBvh15ebPugsXtQgPybw3HKMPr0z
 w60SIlVtFsG+nUMqvTHadqWdIhwkRT8WahMpJRhXpFjwk7vpiRxQWyxSO3HwZA9H1jODkxBVq7i
 QaV7wuZ35AmD4ZZVJ8qC59f44GZrxYbxNxhzNDHk3On4IgZGFqyq1
X-Gm-Gg: ATEYQzx9lu4hD9WmN7a+Bc1sAVhPKeugsRj4foSoyyNcn/ekWN49mWA22+yfdlViHRr
 UHf+o+yscpA8pdy5zvUkEjqJ12aU956EFbv5Xp13EQNoGNvGGSKVfFwBL4dnqedwJszjD3ysu3h
 c4s6Q7jK+Omdp14TJzLaVAx0CxNzFHWwlaHYWhto/i+fGBTKX2zSL0d97AhM0WP3L2NXEOKaYWN
 SzpssNc+SZv+muPw8qtHaPUB40UbjPKyaW9PLCGcSDBtmn7BMoF55uG8OB4LbRESTz6qOjBmW4I
 34Qf/PP4w6at4/rTdlKPwgnHt1ZDbOUiJ6eXoRusfq2+un0jG3vgvfZQVlSpJDD83wM=
X-Received: by 2002:a05:690e:144d:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-64c9ec3d885mr2724073d50.48.1771952596251; Tue, 24 Feb 2026
 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-5-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:03:04 +0000
X-Gm-Features: AaiRm50my_TpEu0wJ2qOWpgeWkf5A7hITHpqp3xpTnSkjVEMlDqaFUOqMj_BzfY
Message-ID: <CAFEAcA9ji1xKA=zi9S1+Ow0SSp=kFCrcZspFV5Lktc-ZwMTkkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] target/arm: Init sve_vq in
 kvm_arm_set_cpu_features_from_host
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Probe for SVE vector sizes with the same scratch vm that
> we use for probing other features.  Remove a separate
> initialization path in arm_cpu_sve_finalize.
> Unexport kvm_arm_sve_get_vls.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

