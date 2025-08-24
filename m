Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59579CA0EED
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 23:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqKGc-0006cz-KA; Sun, 24 Aug 2025 19:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKGb-0006cq-L6
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:36:53 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKGa-0001dT-2a
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:36:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-32326e20aadso4434520a91.2
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756078610; x=1756683410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WoRPRyRBpGv6AtqitUniTbJfrPMuOIBnbke6BK9EN9k=;
 b=LxUybc1h3fnZTJceRWib4r2Waon4jcvBo8t73rIO3zFI7RgciqfiVb5dfrvmaHRNYA
 QauNZqUr2EVDF/d53Pi3S1+NX4sEj3qaUCewlIHFzisxz/sKti9ZnIwmL6KMG+KqOIJY
 9C4/ri2FC5chJQaC0/OGotI9/Qi4nX4mHb75fB3R4th0HSrg95WxSWjEd599jwH25MKt
 D0Cw4r2ZbpgKScHbSNX4qd0qkGB/cv8n1K+a6KHVetapljUJK3ieYRPprN3lC1MMRTo+
 n6zRNNR5tTIzhOeRVFG907NuqUBzZZw4BPCFeFpzhTrs35fjAF0MBJex8nKLo7ztJ2Vk
 Tnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756078610; x=1756683410;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WoRPRyRBpGv6AtqitUniTbJfrPMuOIBnbke6BK9EN9k=;
 b=bj0vWAgiQK9XsHOJfBNgsmYXlrfl5XF17KCvsb10Mylt8PorTxRM6RmUs1pyegXx+8
 IioIQA7fAEQFYn4LZig5wdYQjGdOjia1lgqEJn0/4a+aHXgz5CqY1f+WOOr8Rmg7FP3U
 6HZczoaIEt9cAGerFeHEKrg521rZ6fyP+RUUfDgU+iAQp+Ji5iK1t29CD8DSVytkn2eO
 dMsjRZthKio2PCKOQbniVip3w66CNvIEvc6SFND0ABGTk0YxCAdUyIRNcZw1bvYxhH+/
 m7wnU4E1tdLBzq5+P9coR6cykOF3EaLztjr/L0F+qXGR50k0VS1UXGIGDZKj48CB0dgr
 iukw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzf5quDsaP9srT2nDFb2Z2tqgMfHx1sZOWEagI0hg0zTNfA3e81nsiH4MqWpojDlqVKfccXIrABVCc@nongnu.org
X-Gm-Message-State: AOJu0YzGvFwku4qua9Hm61W+U0NWFIZbh9NcbxDg9r3E/+FzlTu8Jfk6
 qCo8MUAXjDS/ozI5j22YKRYWIZ9LAWBgS+DWh2krW6WpfL2++sSOOG2Ly3E0O3x53ETaFIKaQLe
 QQiaQMMc=
X-Gm-Gg: ASbGnctDJEEqU5zpMKna8EcjkyI0FJ0wKhktZllWzydITWd9tYESDRqEB0B/5wmq7W8
 IiN0r1I/OK/6a7Ykba3W8/sqEmyLwmv9NB/vlBvH7uUfNFPks63F4ayw/EemE9/NaQIoa8oJhiq
 +bI8O8xZfUfycOexQPpZvKYr/pnlMiheyfXpLPZ896b4MeUi981L2J07SJTLw+zLKR36yZ4Ifxc
 ryJmesWIs8M5M9Bq/fX80hvMCtSNgF85q24UfHXmegvpfI2fT3sUTSaepBM49dHa8OW7kK5DlAe
 m04rm4TmP5E6dF8SqmaTfzR08ApXHeE/1qelZF5xwU/PJC5ETx0RW+JBTpGd+fL93+umrfNSxLU
 zyVDGTLOQOSFT1PVl7a20ZCKM3ppyi8M3+KIONMXyCttIP4yg0aCpVXdoOgrJWaRq8zB3OyVEGG
 FcLoofNg2zMVvts2YPOxuL3cVC15absiV8tnTI60jMNpxz0KZyj8GdFYoelyupAeES
X-Google-Smtp-Source: AGHT+IG882YIkyAz+N4dLrnGaMWfAeCJnq8ZdIqT65PuT6AG9synq3f4O7W+7m18G+aOFfgdzbd55A==
X-Received: by 2002:a17:90b:4fd0:b0:325:c92:4a89 with SMTP id
 98e67ed59e1d1-32515e3cad8mr11037278a91.5.1756078610268; 
 Sun, 24 Aug 2025 16:36:50 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8afc11sm5010187a12.17.2025.08.24.16.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 16:36:49 -0700 (PDT)
Message-ID: <84378f52-2fc1-4079-ae80-d034defb1411@linaro.org>
Date: Mon, 25 Aug 2025 09:36:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] target/microblaze: Break out raise_divzero()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-4-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250824222734.4151956-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/25/25 08:27, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Break out raise_divzero(). No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   target/microblaze/op_helper.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)

You could usefully squash this with the previous.  It obviates the b -> divisor rename, 
and it perhaps clarifies why you don't like using "ra" in two different contexts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

