Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D2BEB28D3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voFzV-0006Vk-KO; Fri, 06 Feb 2026 02:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voFzO-0006SG-HK
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:10:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voFzM-0006UV-Q1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770361847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jQzYjUvDsxC3K1k1updJlvTpyEistR2Sf23JhNYwp5Y=;
 b=CMSMr3kTsvRMnTbDib/1ZTgU2ZbSlmM/0VL3Agt/hIVdPNF6gqhW1WPJ5UzEIlikBLQuzN
 qry4i+/BgUpjloMm4djvs6gxHfyLdFPGSQ3fpeWT4KxI+WIvzFQYbZKttTp851pCWeC8fB
 1pIY8RPuC+3ZS3TWxOlphoMUwT36iPw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-dyWdk8UpNkeG8xunLBc60A-1; Fri, 06 Feb 2026 02:10:46 -0500
X-MC-Unique: dyWdk8UpNkeG8xunLBc60A-1
X-Mimecast-MFC-AGG-ID: dyWdk8UpNkeG8xunLBc60A_1770361845
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-480717a8ef9so16444945e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770361845; x=1770966645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jQzYjUvDsxC3K1k1updJlvTpyEistR2Sf23JhNYwp5Y=;
 b=fbfKXko5eJ+WfE94ZXVkSekYjm4kLvv/t0j5owfTeS0fhIEGEkPnCO51E14qNAkAAg
 LD3ArLRfcl7fs8IQDA5NJU9Dl0KsuPoLleLcqIdRDTMtPaOZyIx/jqapOzM//xdg1Ktx
 P6fH8BD7pMFY7ZfD5UHoC7UopcynbsKk+6Q9JLftMiuQdolcnZhY4JORmtZ54nUQTJyh
 ShGRzBWKd4HEUEA6yHNSiAMnYjLs6N5LtRO5x3ZMK8krGNAiBlhZvdiVkXzhE93oeM4g
 PkQI6PiUvQdxka17t0f2+LN/XoKaDCwECryDPNBfyFBaEcaDJ8jJrOuro6RRK/uTxALl
 2k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770361845; x=1770966645;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQzYjUvDsxC3K1k1updJlvTpyEistR2Sf23JhNYwp5Y=;
 b=FgdQ52cAu5toe8/G6HKz+cYbAO2VpSM/RzDJq3BZQgFeBZM/NjNsiUq62njimsLKd4
 IKEkBL2qmcN+gH90UF9xaiCqPcGp8saW9IFKmuXYWMIbiFVJY1B0+cakeDghviy0qs2R
 L94QSoJeFoDy1SXePo8QCVDUKJCtaOZvXGHCxI/9QX2vCUKXuiQPTiKdCIQtOCaCPVs7
 A25bpG4zzP7H4poQ+a0Mn/BA24QVfF4MlvQkSxYG4wLbEXZ+TjlCj9zZt2ER1jBzVhaD
 EfpeT+BesBfrWIJqJJUxiMy+VrW5n2AQS7aMFQ5NfM+0KlTLMsEG5zLCV9vbrX3Bcuuw
 Q+Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwIe3yEHiLX8m+iBxOaU/F//DqV+28hIRZLlu5lWwght6+bBjtWuWIf4zFu/hHA5pSETEMTy4gkpTQ@nongnu.org
X-Gm-Message-State: AOJu0YzNcPJsYpqk6k2eye5OaF2ch7YLsSrp1sOQmGzDEM3nfvNUqppD
 b40p3XMmY80rktr5cmva0KvrFq0qBkEFUEV2j5m/YPshmAf4LDMGyvNEK4ffBI1yK5flPKP7bkR
 ydL7v8LRSO0xhpL+eOxR/wI8KxAjBL9ksmHDNFwR9g1Ohw+CFTIzJench
X-Gm-Gg: AZuq6aLjBtM8nPoAyln5BbRrF8j1JTKwRheaWyofzFO4xvR6WyGuPixLh6gkfD7Ougx
 MIl9F2DqRYo7Y0uZOpy/uza1IcV/2upHLDYxPC9Mv1p+9z5IX601MDxce6a5mVANVa4xqIWfZit
 Z4Xi4731aw4IQQBqKXeNJSfLMD0C8EI28p6mCOVf0YMm6ov5696fkh2ZPpwtRd3YXpjIoaxwFk6
 f2l7SW+RSzPaDiw6iHu6CQ+oVfvGEZfov+cokrSEjtJMokdLvee4z1GS0x+7DPpIGW+J0s2j7Zv
 nmQ/gP2rbqd+h9vVuRCMBCAR2LACC/zT906CUp5ne1EFIL/PnPovo3jpV0kSfrfB+6hQooShJv3
 /Pnf5IL0=
X-Received: by 2002:a05:600c:3f0d:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-483203d5f73mr24951355e9.15.1770361844839; 
 Thu, 05 Feb 2026 23:10:44 -0800 (PST)
X-Received: by 2002:a05:600c:3f0d:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-483203d5f73mr24950965e9.15.1770361844404; 
 Thu, 05 Feb 2026 23:10:44 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2bab2sm190377425e9.3.2026.02.05.23.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 23:10:43 -0800 (PST)
Message-ID: <9e1177ec-454f-4b32-a257-7456fe612759@redhat.com>
Date: Fri, 6 Feb 2026 08:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>
References: <20260205213918.10956-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260205213918.10956-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/02/2026 22.39, Philippe Mathieu-Daudé wrote:
> The s390x target is a 64-bit one, so tcg_global_mem_new()
> expands to tcg_global_mem_new_i64(). Use the latter which
> is more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Corrected $Subject
> ---
>   target/s390x/tcg/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 4dabd49840f..203afe265bc 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -217,9 +217,9 @@ void s390x_translate_init(void)
>   
>       for (i = 0; i < 16; i++) {
>           snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
> -        regs[i] = tcg_global_mem_new(tcg_env,
> -                                     offsetof(CPUS390XState, regs[i]),
> -                                     cpu_reg_names[i]);
> +        regs[i] = tcg_global_mem_new_i64(tcg_env,
> +                                         offsetof(CPUS390XState, regs[i]),
> +                                         cpu_reg_names[i]);
>       }
>   }
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


