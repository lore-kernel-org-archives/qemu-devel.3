Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0624C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaCV-00037L-BY; Thu, 30 May 2024 03:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCaCU-00036z-4r
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:27:50 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCaCS-0008W8-Hy
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:27:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so43015066b.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717054067; x=1717658867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GAyVajqKrZWyG0ODNndrLjXLYAkiSJ2KuYYzxE6coXw=;
 b=ZwloSTOBryVc4/CsbCoSsojZ3f9EWC4kIEofXD+2KbUI3sWZaz+5APaziqjjXc2wa8
 GQ8vTARo5TAl5HZlbIXuihZIbe6iaQh4TXQ8WYlYVPtyfoUeaX5fMdjMDrURRAWl3hcH
 oo5QtUdiRJG1JWr4tbTIm0zzIOjAridXUIKUErRT1xAGi5nQTiQTBiStiAYTUDSXNo6z
 S45N/+4HsU+n9YyQsJMYn6Nffkon0aTgpHnbDM1/bpVCJuP1MmLgvhNXEwFQ1ZeG6zgT
 VeNXEDieAEYGoFaumLuexar+ZwIL/CLmvLt3dsItW0iqLwPh+zFttbENtQRzwoi8/yqZ
 wdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717054067; x=1717658867;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAyVajqKrZWyG0ODNndrLjXLYAkiSJ2KuYYzxE6coXw=;
 b=LkurB3OvtNiiDcvcN5Gw2jQQ/y9fKfc900Nju2YSVWuZPmptEnVCg+RVTWOqsswoxg
 m3bnOIm0xYDas2pv1rWcFzjBkFwV6bwPNB694Ixr0V/hC/tB/xMquJSPEEjQ9r8oo4O9
 Px+kItMqNXO1aAe/61HGon1cbNX0svvfZcI5ACwcLiPXaWRxhFgeV0nq1c6SlihIUWLY
 W1c/lXCDh9Z5FOkA6AnEWj1jCBvGPu/W0+4TGdIKYhy1mY/nkIFNZItsJ//lwBboxMBQ
 AHoBm1Sg8phhc/zxZjDK1ZTAqX5aqDDmyn2ww9QJavvOeB5PWmdqMpJMOPOYlTkK3gF5
 hliA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUswwX+r76m+BXvlz3pR9wsPmepr41LV6YX3kfaKCJ2UgW8iswxwn+ks5TbZgU2sku8T811EFiw6z2iBFKokCbPulokVNM=
X-Gm-Message-State: AOJu0YyTKCYq/gKa76eLjT4uopOIg04fx31CtHNgPoYeiHS+0MEfW1eT
 bzOvpFM+QwC4JZJBluHt09m8/1EJvgzfEj2kHfAbanNG2VmRAU9d6AUxKe8u1bI=
X-Google-Smtp-Source: AGHT+IGIGEbUSZ4xahWwPFA1ujWnKcJ83IGn/8dtw3O4v2udJt0FBMZLbq2a0PXC3hFulMGUtCHF+Q==
X-Received: by 2002:a17:906:c1d6:b0:a59:c9ce:3389 with SMTP id
 a640c23a62f3a-a65e9205f3amr76458366b.67.1717054066726; 
 Thu, 30 May 2024 00:27:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a63420e4f36sm254040166b.85.2024.05.30.00.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:27:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB4715F77F;
 Thu, 30 May 2024 08:27:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
In-Reply-To: <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 30 May 2024 08:02:57 +0200")
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
Date: Thu, 30 May 2024 08:27:45 +0100
Message-ID: <874jafep3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Wed, May 29, 2024 at 5:56=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
>> It is pointless to build semihosting when TCG is not available.
>
> Why? I would have naively assumed that a suitable semihosting API
> could be implemented by KVM. The justification (and thus the commit
> message) needs to be different for each architecture if it's a matter
> of instruction set or insufficient KVM userspace API.

For Arm at least the HLT instruction is an external debug feature and as
such not trappable by KVM.

>
> Paolo
>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  semihosting/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/semihosting/Kconfig b/semihosting/Kconfig
>> index eaf3a20ef5..fbe6ac87f9 100644
>> --- a/semihosting/Kconfig
>> +++ b/semihosting/Kconfig
>> @@ -1,6 +1,7 @@
>>
>>  config SEMIHOSTING
>>         bool
>> +       depends on TCG
>>
>>  config ARM_COMPATIBLE_SEMIHOSTING
>>         bool
>> --
>> 2.41.0
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

