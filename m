Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55ED2F338
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfgMG-0007xv-8U; Tue, 13 Jan 2026 10:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfgMC-0007uK-5W
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:30:56 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfgM2-0007o7-Cq
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:30:50 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-790884840baso80580287b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 07:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768318243; x=1768923043; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW6PvoSICJHJNz4coqHX84UgMdzKOsoSZg7aH86/zjU=;
 b=Me4lfOE9mT31M69EyAye5BhqhhzTlguI8tRhffUuNSCVrQBAzQWjj9MyUesHSxtdId
 1SrbuwedSbExZKANp/PYyc9vn+vtIXa3krTjYGLkPY2OaC75KrkwblWnB3RTTzM7KfzE
 Yu2I/c/LnSutnkeCoo3SQWigD9fiL2R4txeMqs8/99sOP5+DDCSBEC5OnxgVYlwIPvjg
 Mie875CiFHH8v40oyFUkqtjLDbIA8uUVTTyQBwseJSDVIXzRC0OW+/8Rm1RQWrkyG5+r
 ReDdJpZyz/pOgCtVJH7rKAUyI9Jah47767NpiKHIQ5vczmQYeh/86stFli069nwjIeFB
 xrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318243; x=1768923043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eW6PvoSICJHJNz4coqHX84UgMdzKOsoSZg7aH86/zjU=;
 b=qAQUszMWgkVHk0ZunXSd9AW1C7vSiW+OG08iDYNCIfld5FhbP21WIm95dAWCojSWdO
 LiJhKoHXTQ1CTs5qQDbxwe1b8p7qPcE/BKDMMeC00JlqU4NDEYyvf5SVuYa5I5oJtWkc
 Px82G+x81ZOf5GPQnNGGgOQGyWK3nHavRkDGCs4A26OECjovaLws+FSHrEQP1BjTCS2a
 IsZ5L+G62QS8NDOe4/EWUuY3kZMG/R+IUvdfsiMyb/1fXsez1ac0RJ60Sou/xqVqcPEO
 0DDRx9BBfQyUgYlPDldVdfgK8yxShsVeuai8nG+L8WQuCs/fFpXU6h6zcbFtFQxZy0AO
 IuxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj8cDbGfFue59MWNcHJ/B2xQz2j2ZcJzugvlXcNgwEYCPiDVVpxGBukbWVGKF+eJWNKVS8M5Qk5JGN@nongnu.org
X-Gm-Message-State: AOJu0Yyr/o9hngIDpdiqOmCqo7fp/0avB6tkZFua629zkY9eQGDxLbKt
 zc1R3dRPsVJfihcNu2j075bx3O0b0zwzdGPSEuCsTzbVtkQ6gkmXGTjLbZRUq6/LYRmvB6lb93s
 h9c0+9J0sDKj+of+Buwg7L835X49dHefB/Ki6u0gikQ==
X-Gm-Gg: AY/fxX52iSD9J22j9+mQXI84sQevdubZ5ZBGcTbZJYrfR7uZ/9wswk+KjXCLYQpCUOA
 VXgLt1z9P70XD+JsENV8S1EzuEMTIui1zDxEaGgJ7/+iU2XUXOA7ow4yFKHHU2qzLzqOzRZeHW9
 uOw4EC5UKHPkEtkHz/uHVCqp3xApIjtGi1pu+b/nKUyvdSrCoSwHuSuVXRDYYEeacchdEZtFa0/
 FpAVU3GPFfxyn8bP8eQ5cQx1Xmxe62W/Z3EzzqGuQ8e7rlStiZrceLKxHRFJdYYmASJwDd8e0Ct
 6f57bFeMnvrCe+pLc/jjHa0GrxFyTyARlg==
X-Google-Smtp-Source: AGHT+IG3dSkgNOoJ/BdcaaS2plBFMB9YKt90Oon9KshYmD8OLYGFbljxMkyW0O3TnZ5ptvcfFe6NmH659ZKSuNRnYAo=
X-Received: by 2002:a05:690e:138e:b0:646:7064:368 with SMTP id
 956f58d0204a3-64716c19af0mr18225539d50.53.1768318242784; Tue, 13 Jan 2026
 07:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20260108210453.2280733-1-pierrick.bouvier@linaro.org>
 <08c42104-d7c5-4df8-b25f-7138ddc94a94@redhat.com>
 <82940e3b-f9a7-4172-8ae7-680bc1a5785b@linaro.org>
In-Reply-To: <82940e3b-f9a7-4172-8ae7-680bc1a5785b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 15:30:30 +0000
X-Gm-Features: AZwV_QjDKnwoYKAyN9SdqyefnGdycyruckyE5ntR0WojJLVlHxhbMv0Do6VBdnI
Message-ID: <CAFEAcA8ZiViYfkvBJ6P5rqGmChTw3VyN5iaEqxhfNb59ba2RdA@mail.gmail.com>
Subject: Re: [PATCH v5] hw/arm/smmu: add memory regions as property for an
 SMMU instance
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 tangtao1634@phytium.com.cn, richard.henderson@linaro.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 12 Jan 2026 at 16:21, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 1/12/26 1:58 AM, Eric Auger wrote:
> >
> >
> > On 1/8/26 10:04 PM, Pierrick Bouvier wrote:
> >> This will be used to access non-secure and secure memory. Secure suppo=
rt
> >> and Granule Protection Check (for RME) for SMMU need to access secure
> >> memory.
> >>
> >> As well, it allows to remove usage of global address_space_memory,
> >> allowing different SMMU instances to have a specific view of memory.
> >>
> >> User creatable SMMU are handled as well for virt machine,
> >> by setting the memory properties when device is plugged in.
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >
> > Thanks
> >
> > Eric
>
> Would you be ok to pull this patch, or would you prefer someone else to
> do it?

Since it's been reviewed, I'll take it into target-arm.next.

thanks
-- PMM

