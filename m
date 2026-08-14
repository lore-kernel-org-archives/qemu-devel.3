Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB0C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wurg1-0007zQ-7i; Fri, 14 Aug 2026 09:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wurfy-0007yX-NH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:10:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wurfw-0000a2-LM
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:10:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-848743155bcso308962b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786713019; x=1787317819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TalSN/osGGLn9nVmdEI7a33nleoEOaDX7f33oNEm5ts=;
 b=lD8/BDkaaTLqP1F+vFo4ztsIfEoZukqstlqVDFWrUaYD/xDTptVfU2cqL4kEt8oxlg
 yNvXrKNCpw6WJ0+wcQDL6+8H/hUcMUvmsZA0tAnpKZdQxjTy068msw2a3CM3CmOrO214
 x6zp6eT5yGo6COAUEGjBJSNTPUI1hPsxyYaaDq66/5xQdikpXRINjnHc1lVsW/pKCZPR
 8y9c26u26beA6WbSKmwi/dDAsnuWCZu+YwGqnT2+r0yf2JCSoe88MRJdbQmUrX0nYNaj
 GWzWxXpE6fGNde5Pu7vSdkW9wmAcmCsBMwlmA0jf7d0aZ3NEAsNu5bH2xO/aSddL0D4J
 j1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786713019; x=1787317819;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:from:cc:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TalSN/osGGLn9nVmdEI7a33nleoEOaDX7f33oNEm5ts=;
 b=AYSDG+hNc3qrVdCYi8kh+49q3YY/wDnQ0mkcWP5rDPZiJ4oK756uz9t+9qXv1woz0j
 PaOzGocu996sfJ7nteevqBtUQP5c9vOXxBPTdRH7EueEBF2XxorlekN1j3Tt+pwuQYgB
 KFJZGw/hV6eBsbKQ7lLwv6EY1fXaNZMVR6eMf9cYEkc4DorlYO/6VtT4+TvxtLf5rVWH
 TN0DGtfT/op8FyBzbC1LmWEdvTCa/fC6A8vOnp4QNfopfGPWvoy4r1yDXXjzP+76jGtd
 OPFMtV11zbsseZtlJ4vwx3vwxLVhyUl00EVLz+o+NanaJvys8o/KsKb6VZdsRvjFrfoG
 rh2w==
X-Gm-Message-State: AOJu0YyoKsYOix7f7iBd7834PPPl79DRvCcUJTclfaXc2nrGUUhpuOS2
 YQaaO1V6XLAuImdBHYVaecAmsKdMEkyFyiYOj0X9TCLWa9xu0YLgqIcCUSDYnA==
X-Gm-Gg: AR+sD13wwBpIWPxEJBAEe7e+DLgykf95WDXf1QIenYtjp1kw+yBzgboRHUJzLhhVHQp
 Roq695AmFMqfKlqAQv2qF0krW1RB7YrBwo8cuP9FrEbxvFDcNsUATUWlM96nJn/g3OqKgkYJXQK
 sxJT5HrCriYNu7lgGEPvj1uB8Xx33mtQMObmwlK1RP74aw5/Nq7D1wg6u3pINRZoTLqCJc4k9/4
 Yt1a66oNwWqGaKr/ymwt7TCp25lGpldtd4N0YE4/kmto0UQavbJVWpDOEpwRwi8nSqOgLd7WSph
 /pJt6uaS180g9M0iA92Vs11/TD8qOdjKBsEJ6ANW7KIqGZOjafn6zLjdsPO+BvTdFd1fZaqz5XE
 cVnp/1h6OcVILB0+iGDhSzaT+4Me8SMG2H+gxMxQvuiR4Ll+v4gQ5jwP3q2e3qdVGNu9sgdwCK5
 b4DsBtRVHtZDTeYRIcOrSstvneTuOXM5h4cRM+9P1VRSMFopawVw9bkZ7oCwlW
X-Received: by 2002:a05:6a00:3cca:b0:848:2c5e:305e with SMTP id
 d2e1a72fcca58-84fddfbf1a9mr5991953b3a.6.1786713018890; 
 Fri, 14 Aug 2026 06:10:18 -0700 (PDT)
Received: from [192.168.1.35] ([112.133.246.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm448779b3a.27.2026.08.14.06.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:10:18 -0700 (PDT)
Message-ID: <5e6fb4a1-61b2-4d8e-8422-6c3f1e02947e@gmail.com>
Date: Fri, 14 Aug 2026 18:40:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix incorrect tcg generation for RCR & RCL
 instructions
To: qemu-devel@nongnu.org
References: <20260528144457.682901-1-314abh@gmail.com>
Content-Language: en-US
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
From: abh <314abh@gmail.com>
Autocrypt: addr=314abh@gmail.com; keydata=
 xjMEaaCh3xYJKwYBBAHaRw8BAQdAVM1RsDD2FeoNQaZK2QC/kzkYIIfu2q/KFJAYfDCpNIjN
 FmFiaCA8MzE0YWJoQGdtYWlsLmNvbT7ClgQTFgoAPhYhBG9m91dTkOrKD5lID3UzAekWp6jS
 BQJpoKHfAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHUzAekWp6jSz6sB
 AIyMERKwB5XgphDIZtbjD9g2FiJpQZqqPDhTeQOEZ/AaAP9YDNmDmxEYizl29eYioMxhA+37
 xFTSw6WSY07BomlyDM44BGmgod8SCisGAQQBl1UBBQEBB0AzQxaqj7K6RZqXl4xOIleDubFp
 TQsXvEMWiRnJobgjMwMBCAfCfgQYFgoAJhYhBG9m91dTkOrKD5lID3UzAekWp6jSBQJpoKHf
 AhsMBQkFo5qAAAoJEHUzAekWp6jSrWoBAMgbTZK/HqjOv6Vqwl4uy02pZkeymtrbjARfNUJF
 K/7DAQCooyWGaQ6m0RM3RC+fjSCVa8qyuppeq2wSa84UBhmXDg==
Organization: The Public Safety Devil Hunters
In-Reply-To: <20260528144457.682901-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/28/26 8:14 PM, Abhigyan Kumar wrote:
> RCR and RCL instructions of a count of 9 is meaningless for 8-bit
> operands. In gen_RCR and gen_RCL functions, gen_rotc_mod converts a
> rotation of 9 to 0. But, the can_be_zero flag wasn't updated and hence
> we skip the immediate if branch. This causes 0 to underflow into -1 at
> tcg_gen_subi_tl(count, count, 1);
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---
>   target/i386/tcg/emit.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index ce636b6c5..a71af846d 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3452,6 +3452,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
>       low_count = tcg_temp_new();
>   
>       gen_rotc_mod(ot, count);
> +    can_be_zero = (ot == MO_8 || ot == MO_16);
>       have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
>       if (can_be_zero) {
>           zero_label = gen_new_label();
> @@ -3504,6 +3505,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
>       high_count = tcg_temp_new();
>   
>       gen_rotc_mod(ot, count);
> +    can_be_zero = (ot == MO_8 || ot == MO_16);
>       have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
>       if (can_be_zero) {
>           zero_label = gen_new_label();

Greetings. It has been over two and a half months since I submitted this 
patch. It's my humble request to know the status of the 
review/acceptance for my patch. Please inform me about any required amends.

Thank you for your patience and attention.

-- 
Abhigyan Kumar

