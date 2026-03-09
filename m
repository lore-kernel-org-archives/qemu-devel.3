Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6917FCA193
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziFc-0006gs-Td; Mon, 09 Mar 2026 17:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vziFb-0006gk-R9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:34:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vziFa-000056-EO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:34:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so3129675e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773092093; x=1773696893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MKhVpE1JNrwWN6BJ97G1qQIL1z4AsnmLtBsh4RuNbtc=;
 b=bzbSS/ocT9X8ATomHQykVFeMwtdY+gyDfeRtJHDF5erwUNgWS56Q96WQ+h/V0ca8cY
 +o7tHoFjeWxCTEc+VZQo0YEGh7krYtuQe7Cn8rzcD7/M1SIhwhFKaHg0S13vKrLvEc28
 Qox60J3OcLUtnm7lLbG5YrSmQt0ZfZmMYATTM0Y3+MHEcSFsxM01ci1zRPh+7Cjm2RDI
 aeoTJQ79fK//bMkKqKjHbX6aWnvCr4dQ8Wrh5TMQpBciqdWMiwcIqtIW8eeV+8GekY/C
 NHRVi+JdsUxKkSLIiz+ULy//zJQJRPU2C12hx75N5tAP5YsBNW3gA3Z7vRAoTVh6kRHE
 y5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092093; x=1773696893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKhVpE1JNrwWN6BJ97G1qQIL1z4AsnmLtBsh4RuNbtc=;
 b=O9Pc0wqF7mJmaacEhy4Md/uZG4SS6pBErL84QOLD3gBIoZtrhAUdiAfKyXHQScvURM
 /5LG6b0oPeCnHLqQKcrdwtMlQ2Uo2ATg0NyL+PR+IxtH3ARF5CsYa7m4Dv3e0tfLk1OR
 jNcbyT2SLNCWSOBOBjK+Be7pCI2TK1FLkM/C43odeLMgyHU48v3/gOwfKCaX9cDw56mY
 /fY+ERIhpo3cb+Sm+uM6KJ7J+5OZ76ds7sCM+M+jxQDZXmWmqzqCU2NOfBCeAsjW1sm9
 EMxN/h/dK0K1bR5/rmOzo3c5LUtQ2cqcHRBzALUXMPnKYJ41Gnh0G7UCTaXOqkSYVJ+Z
 oknQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq85ARL0rRa/HrvZ7eX17h0ovrQ/B5FO9as4ydN1JPLPtHBXzTrglk9ZxC2Mi/EQsKox/DVZMroL1c@nongnu.org
X-Gm-Message-State: AOJu0YyXfbTUSJOgynp0c/G1FVvt8Q4sVjoFR8lrgwnBZz69AgwFihYk
 HmwSVW3qlgmmjWuqZZhAAKIGtIYTXxf2dtP8orZLXaPDm9zbeKV43Vvnfkgio7eKY0I=
X-Gm-Gg: ATEYQzyULdJtlYUEOZIU909Qu0ol9xRGm/S4uUwO35ayIHU37jMx9HZdT+3mvgZKPMa
 13mdvc7bQpCkLYFvNDea959Xo4NZumdq4ngBBXjfSsK1LnpDJGPmHNt/oXiZ9DP83B9BxOkpofG
 CFIr+ppZp0Ory8aylbZHiaIyzx+FcaeLhkqktEYIKidXVmV85ftGlhwGI4NXowvERyMVWRaecPB
 2Yu0hjIWGtDQ4QSqJ6hs/X6/RtdIqFybouafV2UyR9uG7ofYNfO0rYyts8X1inombfPZwRPu2in
 uI1gC60X1W+13xqdgE8qoMkmdllDocRyWht1R6I3FvmCGyox8F/wULdEE4YOH6LBZbLKfuodJD7
 bRFmPF5SRq5ozVq7diCefiFS42vE2NwjZDqFvn88FqP6gTDJoU7vxWWIhBDOEj68923AoZcv25q
 ClBKrM40LQnWdcowMDAGM3gzvBmXzw/6v6/F+remxNJ8Q6kVQnEp/NCuPBP/d5yhMVvg==
X-Received: by 2002:a05:600c:34c9:b0:485:4388:3496 with SMTP id
 5b1f17b1804b1-48543883622mr3291575e9.11.1773092092768; 
 Mon, 09 Mar 2026 14:34:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm31261383f8f.25.2026.03.09.14.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 14:34:52 -0700 (PDT)
Message-ID: <6ebe57c7-b8bc-4749-85b8-571dd3138b45@linaro.org>
Date: Mon, 9 Mar 2026 22:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] tcg/optimize: possibly expand deposit into zero
 with shifts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
 <20260303010833.1115741-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303010833.1115741-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/3/26 02:08, Richard Henderson wrote:
> Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

