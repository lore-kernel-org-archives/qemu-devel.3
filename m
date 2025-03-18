Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA2C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufKU-0004Lm-OH; Tue, 18 Mar 2025 18:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufKQ-0004LG-GD
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:22:30 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufKI-0004lG-N4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:22:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff65d88103so7740630a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742336538; x=1742941338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x68VORxlBgR+vaVz63DYy5hXfdc/JnPHU4P/9E+3mn4=;
 b=CFMH4L2Nbt488io+KAvMt2doMM1pQAmoXN2WOSGE+bUA2ENQ3+qCBdwe5xzhza3fTh
 4LOXHbfvRUTYQGo+TugD/GjPdvo4ommL28Ia6h/Vdp28zOGef5tVGnIHRpdMSRjIM3F0
 trAVLFdztVOy1LWdx5eDSPoDooBYFEMmWg4ldzLWQqcn4jGSonvLnQc6ZtG2G9bv1H17
 EQliyneWOxvFsPG4Z9dWnMNo1Fh3BrYLC1oNF1/nBw/1zAcP9nAMfSWqvNHhvTXScWlG
 OBI6O1+nT9nq7U+A0Ci+GT7N2yAYguklSwqOtscZppjpQf1kgS3XXeWAiX+42hRymhNM
 qSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742336538; x=1742941338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x68VORxlBgR+vaVz63DYy5hXfdc/JnPHU4P/9E+3mn4=;
 b=RkIV7p7IfS/mwD+bJztMSJfo3/TqldI9w3XK1oKkK23qUXwRJp9TsaGInLxD5tmrdh
 4xuBdquJHpgfIeOQtjmGRlq65tcKc8IsLzWRdtQNtf9RRhKKK1ZP3l0/kDS57aV/BEFG
 boAyDatqw0JmS6rERUEy/zPiuquOEE0veiH3o1FAIvYaZs203Etg1GcviqQtu5RbEZKF
 TtGFEbPnfRV2Y25cGNxmT1Fzm9QedCdupTbBYVqOmF0R6gDEdszAWd6UHc5Iyl8xw4qD
 YDtfmjrTVpo5Hm/zP/2BGv+WvRj9MaEpgFzhc7aqJ4+gWgXHCiG87ZuA+J2tBnMfjTXc
 9EMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7F64d7vhLxLmodHBwmYHvB4yqwRNCUzVf9zmKhZJKR8PC0GmYUe9wM9lK/qjEAz4hrHqK+f/DEyNo@nongnu.org
X-Gm-Message-State: AOJu0Yw2C/CS5jOfTrYVBPHZXD4qpza8+uzOMiytkPBg3+sBai/wiAD/
 H5YEFXkSBOJLmy5Ks/dF3Ys8mLDFXsURUu5PYBZuG2QNo35bFVbSyRc2z2vKCaZ2CG/6JRVttVP
 Q
X-Gm-Gg: ASbGnct9+TpYpwGrgZOAi2eN08TGtlIaiWOShbtEMOfbfD0SWwVRW6z7m9oSEChB372
 TTAgpNaQeWZuIlQHsj91fZuOXYr36QxmCuqgltK9MBx7bMG53CnqxWlAI03r1Tv4OWv0LZWmNEE
 3ZIzJdnJuu3/lJEwGh3pXLnVKqaAaS8AzJs6g8nfri6Czso/nWaL1g8dQPhuwUMVpQNhpcxO5mz
 9YOjBrcw33eRp212EUZBRLSaAH9KirAPZcYOPzSmgQgHMXeHwR+oCNcYNCoYy6DviE8pAAtg+eZ
 del0b5zUKCvVOQkVUMMULqBQlRCH1Sh5a2yDucSjw1Kbs4tXr/atpLXP0ub+Oq11gQI9e5atl/m
 jPRkyIhED
X-Google-Smtp-Source: AGHT+IGHOPLTv3C8biqU57+QSpWJ1D+6cb2Vab07bfb4qaxvU3/KRShK+UJOqz2p7OL3amQORqXatA==
X-Received: by 2002:a17:90b:3b88:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-301bde749cdmr500107a91.8.1742336538060; 
 Tue, 18 Mar 2025 15:22:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5cfd9dsm19227a91.44.2025.03.18.15.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:22:17 -0700 (PDT)
Message-ID: <c71143a0-2759-4c9f-b7ac-6a1d580dbec0@linaro.org>
Date: Tue, 18 Mar 2025 15:22:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] exec/poison: KVM_HAVE_MCE_INJECTION can now be
 poisoned
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> We prevent common code to use this define by mistake.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/poison.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

