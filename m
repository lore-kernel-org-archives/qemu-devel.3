Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C760CC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmB7-000786-JN; Wed, 24 Jan 2024 17:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmB2-00077q-FY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:57:01 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmB0-0004cc-PA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 17:57:00 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d72f71f222so26242795ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137014; x=1706741814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wHNuV+t8LJkSncdkMKFjefdhrQc2Tb0TkxZnFKzHI8o=;
 b=zRIQOU/efkHSeDhotDp0rEnbvyyoifzymVoNb+m10NBnHFzhqxmbHW4DF+ua4UjsKd
 pbAt87eyQrLPyLH+6lJlfo3gCUwGZjBrBP61gl792gmlomN0JrxShgU0Q2L6hHwKdnyx
 J1FBFeZOgyUdntseLysJqXeih9CN174+F2QBlkgWn3BPfzAAOAShUH5V66CN3MbSJcHE
 c7hScCragA6b8cJ+2WBQ9vYKle8qPC6RZ9IOXFp7WvjLREaUGYQV0QyBqAm9C0HRgvKK
 J+DMhmC86TLcUh4kk0wbi4wap6LFhEYhLnp6OBrUrV8/0vWRta/3gpipgZzIx6VdyEWq
 9ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137014; x=1706741814;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wHNuV+t8LJkSncdkMKFjefdhrQc2Tb0TkxZnFKzHI8o=;
 b=V3v54TRW764ZnIXC1bE9kfU6A4SqvBZfPFxywimv6xaKPZq4bcasqLhp/Bx0y3ip5Q
 ahsRLx4Ff5DbGXc1nsDEgTOn4WXZeT6W9gxNJEUsZweY+U2b6uTk8SMsMy7rQ7Pwefy1
 EAdMSCPFWgFHTOceCzLCh57M1g2I8whojvYvAAEMZrzDAfrjpGHiuC5b9fR0dLqc242Q
 cNbepCwY3uHyc2pm7b8grAbkplXshWPBNNxr0pV+Yiz8L7FGKOYxr/gsVB7PufYy98i1
 a9J7QJaZeXICcqLKacsHeUEu9XwxZlihbtgmCGuAfMD+ghfZK6OrsdkSwo9q01Rw/jcL
 APBQ==
X-Gm-Message-State: AOJu0YzriWjfNwB68QAS1rx/MvElLhiqmRU/r6jDUpoCgq8Nnqyvv09k
 7hKIeMXgzGZor0wHEZJaDIPAEBDwOu/H1vBHZnAtjEyTMdBqOUVkAhCEhKqQdVo=
X-Google-Smtp-Source: AGHT+IEwN3/5X5tdBA3k073rM/Qy1IILnlK9pgRRVolKo5zQdR84MrsL2bjzuqXfT8GXnNFdUCL+eQ==
X-Received: by 2002:a17:902:ea95:b0:1d4:752f:9d21 with SMTP id
 x21-20020a170902ea9500b001d4752f9d21mr85593plb.128.1706137014359; 
 Wed, 24 Jan 2024 14:56:54 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 bi3-20020a170902bf0300b001d6fe15b563sm10909619plb.157.2024.01.24.14.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 14:56:53 -0800 (PST)
Message-ID: <1ec09713-1317-43b7-b86f-026acee95d8d@linaro.org>
Date: Thu, 25 Jan 2024 08:56:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] accel/tcg: Un-inline icount_exit_request() for clarity
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124101639.30056-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 20:16, Philippe Mathieu-Daudé wrote:
> Convert packed logic to dumb icount_exit_request() helper.
> No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

