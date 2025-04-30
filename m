Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1237BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACKn-0005Ut-JC; Wed, 30 Apr 2025 14:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACKl-0005Nz-Kz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:39:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACKj-0007Q7-QG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:39:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so291413b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038340; x=1746643140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ssyZKtuVLZxJbpaPVunx4vfUejWQFU4kZAk3nTNGRx8=;
 b=Zh/b1L066h2nAoy9Gp50/2I1sfgZMkhyp+N7PLp5vIkS3UDQOJ1n7soRL1qJlzZ6P7
 ZTCmbpm55Ay0XiimN8NR6vzsBIYOcnP43S4vU3f9xQrWV3kKF/81FKWtMqxO5fzKYi+W
 YvOXXWck+x0anevJfewNlgzr/e0Q9OLw9F7MqIOSvXqGlm8CgRzt7W+iVs/Rtiyc3C3H
 cYV6kcsv6wLfY0alqA+bclmd6CrmjavCVkByfftNOS0zX/HqgdW8pCcYVrfI+6J18nin
 ab8VbVCJsffEePV7wS9VVQIcxlncXDVM2G7KROYlZMmPJygeuwI8WELeAVyGaCa1QImC
 mhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038340; x=1746643140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssyZKtuVLZxJbpaPVunx4vfUejWQFU4kZAk3nTNGRx8=;
 b=fTvxLPxU18r98GA/JRQCin+xLdwNWzv9lB99XbTADmLB5ywCAOOoA7O97/tjkElVZ3
 5+Jsih+j+YDeq6KWMd7AHxpijSteH4RKOM40fgmKn6XCSrjVBjqGr2Qb1//KMiX0EMdc
 W3oDq9FJY0KIKDVArIjxv9mSBL7jpJphxMvULYbsst6ixyJqOLDIv/IxvEQ5f/+ggV8t
 6Q/kg55FsS8miT4XVeoy2CXVZY2Xj2Y+RHAqSeGZdXHbzcshGZx3XiEwrtaGmp0xDl7h
 1kvU4/J8WIp9c6sDZh8G8/fFW2YaAaFDhOzpEibsZ4vyUzsDJByBtapP/0Yzx2EoLWRO
 OBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0y2IoIqYhjXp6afNq/sbSvUaoLjFE6MCzZStDbiOnLSRf9dnc0P6ON7KsZCiSTjEbO/UYzZEIf+Vv@nongnu.org
X-Gm-Message-State: AOJu0YxQGQFKYvekljHAd3MFEQR2A++krYXZx58QUw3kpmVwC8VmzVSz
 NvKaLCUyQIX7Ac5f93o4YhnifQZf6V1Kcumx/GN5LsQ5b5x3yTSDLBAzyfKTZds=
X-Gm-Gg: ASbGncu8EYdcMdcs9JLTHHXRF5H8slOizTKdB1j077RXBArxONNqQ+dZdPiRcgODf39
 1JDCOfSCcRULGYVV6AT5DSgI9YdCzZAEunqt9aSCSE6LLTkzGVEOy+7kYqLi5fH6RWjNrRFwjFR
 QGYtOBdwmgee7F03uxwHUYT7Ctv3cuVPSK2FJ7Ai5KqFBWUwwVLeay/LgFlGOlECmyDpFDb/QfZ
 qwETjDlmCA7/SUTs0ez567TTlWDGetExA+yfU578oiZKxnzTOHihJayD0N92zGWkr6CsIjcWjZQ
 Zuvv33GXg2GA20l5WkQBrzcLWKQKLd82Ce5BuZspmFiaSIQiURuMyKYonAJi5yaeRhy+vo730jl
 qYGMZzss=
X-Google-Smtp-Source: AGHT+IEISvgiOjRxT8LIY00XzPE7jPD0IXZ43EjcGOEnfrDXNgOwhIFg66+kzDxJM9mdChYST6lrWw==
X-Received: by 2002:a05:6a00:3a09:b0:736:3e50:bfec with SMTP id
 d2e1a72fcca58-7404777ecd5mr31151b3a.8.1746038339915; 
 Wed, 30 Apr 2025 11:38:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740398f9ec9sm2028875b3a.26.2025.04.30.11.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:38:59 -0700 (PDT)
Message-ID: <b3a703ee-d8f7-4b58-bd18-ee71de494e13@linaro.org>
Date: Wed, 30 Apr 2025 11:38:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/arm: move kvm stubs and remove CONFIG_KVM
 from kvm_arm.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Add a forward decl for struct kvm_vcpu_init to avoid pulling all kvm
> headers.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h  | 83 +------------------------------------------
>   target/arm/kvm-stub.c | 77 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+), 82 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

