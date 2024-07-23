Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87899C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCb4-0002Tj-PD; Tue, 23 Jul 2024 06:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCax-0002Cp-9X
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:18:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCav-0001Sb-7i
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:18:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso2723502f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721729887; x=1722334687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QwrKvwVQMPA6Y0vkpJawjVGBDdNlV6Wd6WKyfKR/69M=;
 b=blCUqg4ZGOgsNGzFy4D+tb9pf0GIr163i97CmLMXnzRPMiayf68997suFoCPr/aAbt
 jnFVq0xs3jS2ePXl+z2GDvLxHNB0O8kyWFw1iJ2BQY+t0gO6YzIcClxYW7uvWuwKHg0X
 AHrSELahsjsfBTvGWBQCU+1dJTfJmb/gBLgG3LPFe3W55VaiCche8lkYfwknMPm0TW6R
 jg0C1N62iYiS7rcb5/QBK76JXUZZ7onfNM9PJABztUvg9cbQ6FmRVrV59SBoMn6JmhI5
 uCCVF2z6hTpURNWMCKFaKShjSvE84CKGr7HLK6sxozIGaXWPwMqC6ZSZB0NxA7G1engj
 s64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729887; x=1722334687;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwrKvwVQMPA6Y0vkpJawjVGBDdNlV6Wd6WKyfKR/69M=;
 b=HJJ8mdXhVi1I86qg5PsqHrCtmlExEcGt7c/ugtHNexXUp6jJDi7Y5JH/uKy9+LkC+c
 84EAD46n4esIU437M/SLNAsJhaEsJe+o5zhf/g4Je+mF3XVBPJo/B3kXyUqeShHtgygs
 ETg2/L706k3koG11tIGKsmXSAxTXxFjRnaeWWZ2NPJqHfPfLxM4VFII9sSdwyifrst8m
 GbKBLUooZN9wgmkFEsl98AgrzEHp0FPAdi7eIx+HxfQBG+wEn9JJ4BMor84xhOdit4Ez
 HlmMwAufI8RNwP1PR2LUVyfDGe5j19mpRTT70sHfaWWQxB3Bb2xIJllwo+s//8GV9Vdf
 uzbg==
X-Gm-Message-State: AOJu0YwoOyIjGQkonCD1GsDS8hBcWT6tkwYXMovFBSGWOIwQwlJ6ss6+
 5Y2mQrYsWMcNsQiLOoRECa6AOzubfX8DhiAJbhW1PUbykiGWDc5X0yEaCi2zI2U=
X-Google-Smtp-Source: AGHT+IHl36AwiZnbHc0eDcOkPv/fBrdktGdhyYJO1gMoCp+xvqCt0djGh2zNsfer702gjgxC0Clk/A==
X-Received: by 2002:a5d:6592:0:b0:368:334d:aad4 with SMTP id
 ffacd0b85a97d-369bbbb3200mr5981054f8f.4.1721729887630; 
 Tue, 23 Jul 2024 03:18:07 -0700 (PDT)
Received: from meli-email.org (adsl-255.109.242.224.tellas.gr.
 [109.242.224.255]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced05sm11088188f8f.67.2024.07.23.03.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:18:07 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:13:09 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v5 1/8] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <cdba13875d38feb836468a73509d24a88c8332ca.1721648163.git.manos.pitsidianakis@linaro.org>
 <Zp9PxB4ZyLDgWGtM@intel.com>
In-Reply-To: <Zp9PxB4ZyLDgWGtM@intel.com>
Message-ID: <h2na6.fj0mlm6syrpr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Tue, 23 Jul 2024 09:37, Zhao Liu <zhao1.liu@intel.com> wrote:
>Hi Manos,
>
>On Mon, Jul 22, 2024 at 02:43:31PM +0300, Manos Pitsidianakis wrote:
>> Date: Mon, 22 Jul 2024 14:43:31 +0300
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Subject: [RFC PATCH v5 1/8] build-sys: Add rust feature option
>> X-Mailer: git-send-email 2.44.0
>> 
>> Add rust feature in meson.build, configure, to prepare for adding Rust
>> code in the followup commits.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  MAINTAINERS                   |  5 +++++
>>  configure                     | 12 ++++++++++++
>>  meson.build                   | 17 ++++++++++++++++-
>>  Kconfig                       |  1 +
>>  Kconfig.host                  |  3 +++
>>  meson_options.txt             |  5 +++++
>>  rust/Kconfig                  |  0
>>  scripts/meson-buildoptions.sh |  3 +++
>>  8 files changed, 45 insertions(+), 1 deletion(-)
>>  create mode 100644 rust/Kconfig
>> 
>
>[snip]
>
>> diff --git a/meson.build b/meson.build
>> index a1e51277b0..a3f346ab3c 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -70,6 +70,14 @@ if host_os == 'darwin' and \
>>    all_languages += ['objc']
>>    objc = meson.get_compiler('objc')
>>  endif
>> +if get_option('have_rust') and meson.version().version_compare('<1.0.0')
>> +  error('Rust support requires Meson version >=1.0.0')
>> +endif
>> +have_rust = false
>> +if not get_option('disable_rust') and add_languages('rust', required: get_option('have_rust'), native: false)
>> +  rustc = meson.get_compiler('rust')
>> +  have_rust = true
>> +endif
>
>Only a nit, "disable_rust" seems redundant, and "have_rust" is enough.
>
>Others LGTM,
>
>Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>

Hello Zhao, thank you for your review! Indeed it does seem redundant, I 
added it to allow graceful fallback to not using Rust if the compiler is 
not detected by meson.

Manos

