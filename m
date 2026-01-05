Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F031C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaNt-0006k6-5h; Sun, 04 Jan 2026 21:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaNr-0006jp-J7
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:31:51 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaNq-0005ue-0N
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:31:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29efd139227so178879755ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767580308; x=1768185108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXb+qZWLfldbVIydT+z84tuJdM4mV0kQ5IpYeLtGn1I=;
 b=p69BHnaavLDiHSR9B3uq9MkByyJWoTLtjn/pzaCu/0KslhGgYfsVpGchBQzMrqJDzU
 1reRkPZhYEow15YamcKcnAfTSI6PEuZhleRkobVQSXffo3DCAk/VaPfpU/IQLO/VDpiC
 KSszQcBUWBYm5Cbek1Z41y999ZFIq3E7yYSM7cAF4vQVwvodkrvbebxmAfcW4N1lZ6fQ
 ULN1T1bi0V/QqDfXLBEEmt3yMpxVZ8Yp1pUtCNwBo8ji2wcm+pwwXUwYMNzw+8R046cm
 5etVwzXtR1osu2IgtZpjN+apWi5WWmjBhbI+Ovk5F2lHS538zqYTo17yZ5Yk7l4KNGwc
 Oqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580308; x=1768185108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXb+qZWLfldbVIydT+z84tuJdM4mV0kQ5IpYeLtGn1I=;
 b=XOSblQgzRFd4AyktKC5F8U/zl98NqSojH7H40i8qLgHKx8BOHYqrr6mHRzgGij2IUT
 wQnejzFjs/iCcdi8Oz/3CrVEIiTiv4jJ9mNB9LWK7iZjErTd8wbRH40vGQ7PvfQFF/AF
 Pj+jG39PSyxYl3IQIUnqCc2owhNvkHvWYsEchZ1HudfHAZ6TDQi6AK7ejfk6DoAjVeAc
 1Uxvn5vuGvjdQiifhD0mDkU17KoF54Dn9JiDdEfExYAONRv6LD87T4epFW1HeL268Avn
 mduuSBo5XcTOYRGUbiCvFOHQxcbprD6YiLGE7uiksIxmuYTFcGrENuoP1cehTTib7Fzw
 AG/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtLiabgBCaxaIQLRXe/8k+KpRUgIc8aErHEl3Ip6ix04dsRdilmw5A7AEgMWJRqwID4o9nYQKfdwoT@nongnu.org
X-Gm-Message-State: AOJu0YzC0kSXxgHp2aRjrT4nJ7CItBVqqzQNItNrooxhSvescDbqAztD
 44rtvbkryUEXqRVKvnaXbCvT4Ad/q3j7OYmvYmdEMh1tZxSNX4BktCEHEzLdQt5LuusX/nvv2/9
 Xnyr2h1Q=
X-Gm-Gg: AY/fxX4vGuH+3p8yh3XrvRvzD2W+4q203SGURLndiWLHv2/TQdblyuFYtsFJ/O/mAdJ
 aqwmcZzKeg1WGrT3KR5oZSty+R4c9/VnU3lTSvFYeX8UBhvwi1R4VYDiE3T+MwxnkHR/xKNuqRZ
 qdnqLRiDut4zniszqWi5oDnbnwxJdIJOZC5qNc23UdOArW3yE/dSdqwozWUxOWyhQaBnfeN1KBX
 xtRedc1y7bYznySi+ppDZTDI8JWK2HE4kFTzyzwajuacR/XCT2mpnwGCtJs0F1e6N2Wcfn5l/lu
 mKZySeYiCat6f1mtNdeRSw9+BZuQLFdNZD33o2W+F7CkpRqss/HJC5j5K4n9+SxTA4a5I788Wys
 TiA305soVXth8HD0QLzIs1B85afOKCLoPokaAUIzFjAahZ6HfqaK3WbMO4fJjMu/LiX/7Qlcg1Y
 uNoa/uM/oa5ped1wKlrwua2LzPPb/waw==
X-Google-Smtp-Source: AGHT+IE0BUCQDlno46TDmFUpC8Eqi7UAvwrVGWzwSGpORiWW75EeSCOc+obLLorDF49VkPkx9w9rtw==
X-Received: by 2002:a17:903:98d:b0:2a0:bb3b:4199 with SMTP id
 d9443c01a7336-2a2f21fc52bmr568192065ad.2.1767580308008; 
 Sun, 04 Jan 2026 18:31:48 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d32dsm433972875ad.70.2026.01.04.18.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:31:47 -0800 (PST)
Message-ID: <47652828-17b9-42d8-8e01-882fdb3e75d7@linaro.org>
Date: Mon, 5 Jan 2026 13:31:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] linux-user: allow null `pathname` for statx()/fstatat()
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/29/25 23:14, Jean-Christian CÎRSTEA wrote:
> Since Linux 6.11, the path argument may be NULL.
> 
> Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
> specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
> issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
> perform the appropiate syscall and let the host's kernel handle null `pathname`.

Queued, thanks.

r~

