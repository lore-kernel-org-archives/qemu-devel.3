Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E009CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 20:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upBsn-0000Kt-CN; Thu, 21 Aug 2025 16:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upBsj-0000Iq-N6
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 16:27:34 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upBsg-0006iv-V1
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 16:27:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1458157b3a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755808046; x=1756412846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+s9b8Rj5BbgRxKb7frMiq7GPftdC+wa+Ca7IgD1zeV8=;
 b=GBfMRupoZVBQ4v7GShcL5w1SB3rp0ze39i7StvOVPkWbCvVHJcoaCrvWmHwHp08oyJ
 aVWLYbI2fBPMVSY18YZEeNMb0LcblKn7IHx191dEtPUpvMjPj/kNZHYVaBYaPGjDAUnC
 +5qfHCwhPZPbY46/3BSxvWrKXXyUAj42OoS0vjIT1//BQjQzWy16sG9DsFgjA3Xhgv/c
 FzG0HgC4KgIxm+iRgTAzCM4CS0lAWgFsHGRjH6bBOI0mUSNhzSGYb74WvJuC5oOVngdU
 C2Ey3RElL1e3I8R5Yu08RG5uSFSV2fmlETiEjoCEw3mf42hM35L62BJxUKXihiZqcX+h
 WAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755808046; x=1756412846;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+s9b8Rj5BbgRxKb7frMiq7GPftdC+wa+Ca7IgD1zeV8=;
 b=UhmLOMVZ1tlPh/7cEdPJOo2UfJrDFxgzoV2EuS6ITOTwyMuHeLcQhuC6mLHsrdL0t+
 tMIH3p2W3b6Wwtjc5lL8Q8HEbwPhoC1QMh/ThkPEB22KDrOGTEkCwLl9KX2YbaQpOMGP
 gsZVlBit8yH2uwY9odLm6S/KZTlExpeRoAYEOlC/VwjHi99uUuC/RPLk341YbUqq2Kr4
 zjQYLpcDGpaMo70pMjmk/Wb6aQpa3YR/tltx8/D4wamLRtS04+LmrBe9WG5QrLsLLfgx
 3n4fJdImrANKO+4AZ2jeKvk8/XkOMier8No31JsRjMQWK8WMnyKirm/n1uZoJ7NfELd9
 mJgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR+WYN2kzl9GytDDfZ2CzPzK+GJ1zi85Dme4ubWG3tJFCjL5zSpB6pFqKtIQALLBSNStH/2jN69Jcy@nongnu.org
X-Gm-Message-State: AOJu0YztMtRRBqeLDnZR59W0uxGA8//NYMaxuju0UHWgceChXRjtyNXw
 vjh1FBlNN9CLCX4eBV+UhUIaFUJ6OffdFE3Gvc8RgOaHKhD6iKWtTPfryfkNoLVYugg=
X-Gm-Gg: ASbGnctpHX2Oq7BBXnehiYB+iyhNFT48h8u0cuoonKaK4rvcAaI7AnuvgSbA3QOmb81
 ZBZfUI7i5OtTnY7/3g2EyMmn/tAAl0CYbiiFRbIACAV9Y7B9yYrIrS3mfvOVmZd92pYuDLWyjew
 kFO6zxUPy28PelMfjHo/1iEsTcIZwriPeFyRvyub2Wq7YuuP8yEYeVQYS13pcQWTof9PgKkMCVz
 kKtKwyxC50a0bWfTfqMR9mP2Uo09Tw4xk4fWFXUKlZKqYiEG2Hbv0fiFWAR+dalK9NfifCmlqEq
 KacV7QQp2VYH95X5HJqd0QvDQHoVv4X5ew71Ig5WixyIDL1DkunJ/DSgE5rMAr4f65Ml2JMn+TH
 jpjN/dk9ih7SQZUrB1V01iQ7v28c13pyNBg==
X-Google-Smtp-Source: AGHT+IFUOtml8f11yUg0UUWTd1SeYVYQbzrAm/GFJLxsJAvVJGKSLAPtFvmw2I7sA17mFWKE60Ev8w==
X-Received: by 2002:a17:903:3885:b0:246:571:4b51 with SMTP id
 d9443c01a7336-2463405fde2mr5187295ad.29.1755808046168; 
 Thu, 21 Aug 2025 13:27:26 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed361422sm63626825ad.52.2025.08.21.13.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 13:27:25 -0700 (PDT)
Message-ID: <226ab909-0482-493f-bacf-5d2930d07ad7@linaro.org>
Date: Fri, 22 Aug 2025 06:27:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250820134937.45077-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820134937.45077-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/20/25 23:49, Philippe Mathieu-Daudé wrote:
> qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
> and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
> ("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
> ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
> is C_NotImplemented.

Not true: ld2/st2 are also used for 128-bit load store.

See: aarch64, x86_64, loongarch64, ppc64, s390x.


r~

