Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F3BC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGJ1-0001ZZ-2U; Tue, 22 Jul 2025 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1ueFbG-0001H7-4n
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1ueFbC-0001Qc-Rw
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753200733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4x3D/i4GIz6o492rp7lytt11dFe77FgBTZxGlV4fUg=;
 b=f0ff661AdjPWbyAhljZWrN+FHNTadP54NOFVSZYidxhS3RjHQfRlrZkPksYbgk8pgYLcrp
 FO4RUOWxGlTLWM3UaedgqMtXcbsqxzLw9TIzlItws9AIcEk9DDfpDRH01GNfpX7nOqAE93
 Klyd5scdzNEexmzvfmmBTUGSzFGlEHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-OaIQdCa4Mj-3-q5RNEr1Ww-1; Tue, 22 Jul 2025 12:11:05 -0400
X-MC-Unique: OaIQdCa4Mj-3-q5RNEr1Ww-1
X-Mimecast-MFC-AGG-ID: OaIQdCa4Mj-3-q5RNEr1Ww_1753200664
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561dfd07bcso33843945e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 09:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200664; x=1753805464;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4x3D/i4GIz6o492rp7lytt11dFe77FgBTZxGlV4fUg=;
 b=jZedCsEADFi2dhl6bQhPY9DavltjzIcnYnw8eW5MN6hiaDMQrqSbNzLv87PZ9Q3zv2
 MoZ1+UTHChWj8FfLKhKd/JkVxBX3EHWnJPdS7Tu7k3AaptaWd/u1ScvxLyGLr6tJXSHs
 rSCqx+Bs1D1SO77KSLciZu38godkYsiTOi801y0cGdWnmyIrDChot/fF8sXqEBpl5U+1
 ATzjH3qVVHwPnSEIkL7ZAhjcY9NMOFG+JPHRi7oAaHr/sRQ/5Hw77gGh0iagy0qGwxsv
 NM4ZDVEXVBo4varV+DbgGPZm4iG7cn1pK2Tzznbwvms3cb2Tk5GnNwD9q4MVVwvbB6zP
 errw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwiMJhgHBsuIhG97pdKeXlk5h6s7aEoqWweb7hVWwTHVy7E3FhmFAgiJhOIOTADXvRCApZgF0P348x@nongnu.org
X-Gm-Message-State: AOJu0YyT2pEdv5YSuldN2owxFSUxbK6cKZXVvkcya3F9KZ1G6KmSAAjc
 g+FjGoPmmNMtRkiy9qOD9EdYUZoCycUjVicYetRM2HPmeL7pzbXkExRZxwphhV4AK2u61Hy7nmq
 k6cHPwRHwYAuy1XxJ/xqlvRe83S3DSlxjUR1R6Fjd6O77q4AceqKZiFZN
X-Gm-Gg: ASbGnct/KeOV0k7aZch+iR8YG1yxz116Ml0GBWSZ92WrI4NC2L1PbrthE9SCN2/diAf
 MTc1k9LQMhT8s/A2DBxdzYZbXNW4LOLBgGkld0MW36bxgZ6IJm++Ly/aut3otHa+FjdeDOomqPZ
 oSs40IMzs7einfaOaanqJwxXYYeSQLh6UnB4QxuGT1ZrvWl2Hw77JVrva0Cq5Kxk7VxuBWNn7OF
 hB8Y8fAIwKIRyFaK7W1qEUCKNtRVfzIHkhOal79Pyr118ymLLeRVP/nCRa4TRqZ6vFxbb9NEjjD
 8iqjepS23xvetzLaKMi4iR34VtGb7UzeazXl3vZyvMiEeJHWMdlZaX7g6i+mpF78APiOl7a3xWE
 LlpntcYkahPtF
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id
 ffacd0b85a97d-3b60e4c5212mr22421829f8f.9.1753200664294; 
 Tue, 22 Jul 2025 09:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCHXaFJIN6wZg9she9zBMcbIAxjluYAG5+RDzJu/soPI3BPkblYjBQVwzQ5OQHCDZNtibTYg==
X-Received: by 2002:a5d:6f0e:0:b0:3a6:d92d:9f7c with SMTP id
 ffacd0b85a97d-3b60e4c5212mr22421797f8f.9.1753200663812; 
 Tue, 22 Jul 2025 09:11:03 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de.
 [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d807sm14005725f8f.73.2025.07.22.09.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 09:11:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:11:02 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH RFC] arm/kvm: report registers we failed to set
In-Reply-To: <20250721161932.548668-1-cohuck@redhat.com>
Message-ID: <b1f7bb67-070f-da38-369b-51ed1962fd2d@redhat.com>
References: <20250721161932.548668-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 21 Jul 2025, Cornelia Huck wrote:
> If we fail migration because of a mismatch of some registers between
> source and destination, the error message is not very informative:
>
> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
> qemu-system-aarch64: Failed to put registers after init: Invalid argument
>
> At least try to give the user a hint which registers had a problem,
> even if they cannot really do anything about it right now.
>
> Sample output:
>
> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>
> We could be even more helpful once we support writable ID registers,
> at which point the user might actually be able to configure something
> that is migratable.

That message will be even more helpful once we have the stuff in place
to actually print a reg name here (and be able to change the values for
the guest) - but I agree this would already be a great improvement over
the current message!

>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> Notes:
> - This currently prints the list of failing registers for every call to
>  write_list_to_kvmstate(), in particular for every cpu -- we might want
>  to reduce that.
> - If the macros aren't too ugly (or we manage to improve them), there
>  might be other places where they could be useful.
>
> ---
> target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 667234485547..ac6502e0c78f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -900,6 +900,24 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
>     return ok;
> }
>
> +/* pretty-print a KVM register */
> +#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
> +    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
> +               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
> +
> +#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
> +    ({                                                   \
> +        char _out[32];                                   \
> +        snprintf(_out, sizeof(_out),                     \
> +                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
> +        _out;                                            \
> +    })

Gcc correctly complains about a dangling pointer here.

Sebastian


