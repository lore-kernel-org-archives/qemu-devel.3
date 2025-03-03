Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C385C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2uX-00008u-PZ; Mon, 03 Mar 2025 05:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2uV-00008S-Qy
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:20:31 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2uU-0004xC-0S
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:20:31 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390f5556579so1305035f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740997227; x=1741602027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uG6ex9YqjO5t4mSQicEJeQlwIii0yFZeEAYqlzHcfv8=;
 b=ohm8tkrsFZqjuc5O82pLLxXLvLDKXuIVjQUGpiq1jxUtjLBPP6Juhbxx2m1r8bu5YX
 zhOezDXiZElZFYeiMv5u4b29vBZNo8AD6eQonm1cam6vWuq6UacsVDwuvZtjHKKxC6nV
 XNXUioeWOgul5z89YnQqA0c7v0Xr+g3LZxnlBKr+m+wL9gXz0SACZnN+PX9wepjLN33C
 RULpZRHUcn9Z159647XgUI/g+h/VYi393grlOU5GmNWBfXm+KzVRxpLMQQJ92OiPoLCj
 jwZm8pYerLhYJRCgsIdKiRn0bCk59mXgNcAO1PfVZtD4WRLqQObIAnwtgsjKJ1+zfasb
 eUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997227; x=1741602027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uG6ex9YqjO5t4mSQicEJeQlwIii0yFZeEAYqlzHcfv8=;
 b=kdPLtUNnP+c7yYJpcX14BtDPRGXAheRAX7p55dcRyvsGtdSQsIbOWajTZRUuBGGdPg
 yEOiMGV+LDnxZcxiIKtkt6nYhkX9t3Vkx1ZG+nUN0et3g4DulMsU2fQfnM6ciWrLDplu
 HbHItrH18TSZiP3nnSk8t7ZOtpPMq/zJalJNIYDFihd6WMUOEysIY82vnQivOWWzipdo
 GQR6AitImj68zCwn8pIcaHe/WuY706B+aaRr9u04aUDe/9Ht8I+jNewXUm44Ea+AT1ff
 d9IYFuZzBL0ZxWc7E3CR9A7YlpUxaeCEpi/e1ihYaODMZzK/CQrGAC+UWxikIIlbELGv
 rL9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX05C1Cv9Gm66D+oHf9JXT3jwz2fJhVPE3k6418IXwWUHlsnVRxkCdh77Ba/PetLQwsuqqfVAX1cqBp@nongnu.org
X-Gm-Message-State: AOJu0Ywx8sn2csaINsgv1SWqQF40Tcw/Z+YL9NsksFVmUoAzDONafzGS
 /9rRiD6Ai7Nx8+Bct+iJl7xJIegz9Ze9f51x5xZF/2e4bHsRKET3gx60jCwe4kk=
X-Gm-Gg: ASbGnct3IXJFtiYLoVssxBQYic5JI1ouS0ixVLmWJCWVy+3x+/rPZuAVsuRVguBrErx
 n9iJlc15gLfWDWS7D2xUeh/cvRhkBzO/SH7exTKuxZ0GXtOJfZr6d1mV+8bqpRoQNtHTSSQSPXi
 mEwMfbp0SW7R1X17kLpgJjO48gW5mrxuZ3znpczJxhNuH1gvOVoAuGj5+dICk8zDMeyDbYbs4qB
 AcVPhe4fslWz0sOyAQt/fV2cj7ZBvWdEfgpb71YTNhNm2OWAFrpNRLVCEFzYCyPp9005Ic3BfQd
 XtZUF7XpHprULZiBND+1nXLi/y5WG5Kj4dL2YVQ1v8ZH0dbiGpbWqHtyFjG9buqNg0Z5s8RXB48
 0xXcn8oIwqy6I
X-Google-Smtp-Source: AGHT+IHJP6EFmQ8vaVWmYju/uOx7oTgHl0weDj/jUkwGd+qYhPE0M7x8OI5Wigui0jfI7EFCeft2rA==
X-Received: by 2002:a05:6000:418a:b0:38f:32a7:b6f3 with SMTP id
 ffacd0b85a97d-390eca41867mr7724652f8f.40.1740997227150; 
 Mon, 03 Mar 2025 02:20:27 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d0asm13805645f8f.27.2025.03.03.02.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:20:26 -0800 (PST)
Message-ID: <6e7d0ec7-656e-40d6-af31-85d3c4a92a62@linaro.org>
Date: Mon, 3 Mar 2025 11:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 037/162] tcg: Merge INDEX_op_muluh_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-38-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h  |  3 +--
>   tcg/optimize.c         | 19 +++++++++++--------
>   tcg/tcg-op.c           | 10 +++++-----
>   tcg/tcg.c              | 13 ++++---------
>   docs/devel/tcg-ops.rst |  2 +-
>   5 files changed, 22 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


