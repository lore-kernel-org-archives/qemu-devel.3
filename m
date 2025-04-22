Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6883FC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HPH-0001V4-PJ; Tue, 22 Apr 2025 13:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HPF-0001Ud-Mu
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:27:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HPD-0006RY-V9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:27:37 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c3407a87aso82066515ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745342854; x=1745947654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLytmdm52KqLjDCDgNVzWcZybPblMr3j/M4+6QW7H8U=;
 b=xI2gb8/Kx9iTctN9UbRuJOZct5LQhmh7fou6KeYtgLGCas03sph4g19ayqIi/Qp+cl
 Tlfka58NjZ3c2Wa2ALOhia26qWRgh/QQsQmp8ySgQAx/PYqeie7QPFJS8hSFUiECE4co
 XtMt1eq3aNOQqByzHxWQmbzhnTtKxwF1H4pvdpFgL3Mp0UYxqljHtdKZc8OtR5V4JvA/
 /+ZByq7Hf//asVa8PGCvffDdf0hE4S0PtpZZwJeALl4Htz3XfinRSSeRUrBXab9v5Wrq
 MN+N7d9CQ4gxVHKMH9FGDW3vTvznlylY5hWCHYYpjk2WSv8dpZPx5UQtZ2HbrrZowHtE
 oWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745342854; x=1745947654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLytmdm52KqLjDCDgNVzWcZybPblMr3j/M4+6QW7H8U=;
 b=uYJBWsx1tFNBTCax+00OH09cmYTR+H7NPN1GlO5pcy1mqqVa/g/zrV4r9ZcTaT4HRS
 Juj0e49kT88f+bSyfiJgR1yGi2OYMTD/c59OLFfNmNqLkaRy0zH1PE1y8gREU/Ll2cqL
 oeKVoPwMiBO53fxHRowL3UNemxJVhimFhCM0neDBjA6FXjVUMTpO4q9Vc44KU4k096Mu
 Y9dbWojJAmkF++qDzItxxTyMsNYTeR36WWsodJudzqI5KlA+eRV4o1Ur+CBrPA/H/zJ+
 KqwUlpPfLqf1pCm7Y9t9IzO/d516MGVFPBa0hrpkgOwmSAGgmykWgjhPAn5pW+3Rbowf
 PmpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVYJU36omer2f4SV3A8u9IAJFWtxgHn6FcNImRIlG7FLHkgP1S4EU1SWx3z37Nu+KwBJdEKuk8i6sJ@nongnu.org
X-Gm-Message-State: AOJu0YydUSYScyzb6R3YvS+3ik2qTdGL2xXlf83VUnBncJLy7qIrNtlc
 XAGvS1gj3GYAZQY+SUy5Ka1sdVEQitziJIu79QBXyK8pZ5i0NssHDzQrUaFT1GasWvPgOSOQ3zC
 u
X-Gm-Gg: ASbGncvhnd2LD06tHoUZa6k+5AbNKHCIfaXFJ1W/LzvZYQpJ5l8LIZsT5hsWSc8jbJz
 TaLj6sOV0crmNnrQXT7FCYgO5QrffvKXZ85rIiWWeHdxFAuOHpqvmeHksOKiwo78blnkc/1ibBf
 Ti7P8Shi8QU0CTKr7Pk9V87PL06+sghbk5WNchK8eRupg/N9PdqrutF5hw/2KVXLbWMy3CXZePk
 AYnuRBiyaYU7KyI2hv4lmf8rHig0B2qKsUTfSDrvjK5j9xOaqKGBvCYVgOyPUOy95KV17oRka8c
 PxnWwT0od7Bm3EERHavXoSWhdx59w1VdTuvzrXWWQSH2Ybt6/B55KTsdd+3KAEsLulY+5f8JDpk
 YOihM+BU=
X-Google-Smtp-Source: AGHT+IFa92chHt/St7tEV6uoZT0hrVH9MrUd7snISEdXdIsHMlfLyRskN51C2OLkTi6mSAuGFVvhzg==
X-Received: by 2002:a17:903:1b67:b0:223:377f:9795 with SMTP id
 d9443c01a7336-22c530bbe9emr241243915ad.0.1745342854163; 
 Tue, 22 Apr 2025 10:27:34 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdb9f5sm88165775ad.218.2025.04.22.10.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:27:33 -0700 (PDT)
Message-ID: <6aea41b6-70da-4f9f-bcac-e57b32012aca@linaro.org>
Date: Tue, 22 Apr 2025 10:27:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 02/19] qemu: Convert target_name() to TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Have target_name() be a target-agnostic method, dispatching
> to a per-target TargetInfo singleton structure.
> By default a stub singleton is used. No logical change
> expected.
> 
> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

