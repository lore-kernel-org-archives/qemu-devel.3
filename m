Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685CFC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BTA-0008C3-CE; Fri, 11 Apr 2025 06:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BT8-0008Bi-40
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:18:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BT6-0004v9-Bs
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:18:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1103310f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744366718; x=1744971518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9af7Fy//bd4OriPb3E78Pa3Mw/oCIh9MMgIew+MDzE=;
 b=o5le+Oe926feRvBzuPJDvuwovaGd31XmzJXJm+dGR4Q0Z2hEhD0e/+F4cJ4o5RuIc8
 I6NnO++OABCmFmn/Lxu8uC9wCLyEZZUTvU0lHAiZ0y61euoUMIcvNzegSj8+lZ+IpqFa
 SCmiS2aGv3qomoJzavWHsnQV12JNWHiITuDCZmLP0ktb+ovATavPf0Jfvfo6fN1zesBD
 dC/wyulNKb+fGyeKRSfDC5kH7Lay2YGGk/T9EgiVVt2QD/gZXu5QmtlnKJ8H6qF8bWKN
 7Jy853m3j7mym8Emi/0b5qzjh29mO0RxlYjfImjO7BdyfIkTzZ3PsDvrimxDB1dpnnCy
 uxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366718; x=1744971518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X9af7Fy//bd4OriPb3E78Pa3Mw/oCIh9MMgIew+MDzE=;
 b=mWEYDAuSmFs4aJ/DI2KCSqQU2DW6Qg7mSRNw9GOOsgXUgXdGEd9hrDTyTr2Omb4Z/l
 6bhjQNIVQ9JXcbe0Xtpr2Bp4T/qaZfEquNi1cHjLd4u5g4jgBMLYBdfO7FuBDvIwx5aD
 sHzwkF7sVJ5QeWbyoJ6HwzS3Ck9kqoEM6G25VZ5FYRQZxi7qq+IPdaB3oR6dMEhBzx0Q
 IiFLy0d6d4aYi5We0FCQmbhBJRlk7Mj1WbQDRneCPN+RB57v5T5UklVwtxadKybkE1Qp
 cssuL/3xftG8LXLhwqLQ1S0EP1p+wOk485yoUt52MiPmvuH2XFd0bmKbGXOHsDHofb64
 mWxQ==
X-Gm-Message-State: AOJu0YxhQXDKmZKNsmU9C2MsI3glSTYGYwFz8YC+rggdq2Lyp1LupNNu
 9JZioHhUyO8NuZsIGgDMDkLh4xTcrFhLyJlJAwLh9tvl1SJIbA1RMu1HKUkVTZU=
X-Gm-Gg: ASbGncuca8S89CDqhavqB05yofdg7jcKQi6Weyed3WjqQpaa5TivIbS7cHHP6Uzed8X
 uiuRfofjBXq0GX/P8H5hBqkcaTUggbwqAF8VLQPVtYNeSCxUC5M7c5qIctxbLB63XpZMY7IpYo6
 GdCcWC60AmdjaY44sn/L7N6yT7mtMoVxv6cf6MGO5D3MJDr9cL91J1Q6elEgLUOg/kzPlFPSbaT
 AANnwCg4rd4nSX7UCDg1q2i6rA3Z2+m0dALnMsp9lRbMgIrogUJYdOQMgE1k4WGV8QsEgc1rJtz
 4nz1Cm94a6aK40j8+vu4LqY6ga5HHA0X0cvG5NsDF1EW71GZAUKBw7XVRu7DgZoyCuDueVSn0kH
 N6vV1+QXg
X-Google-Smtp-Source: AGHT+IFNIepPS4dvXZHHpSjsPIPkORb2Aue4PdXVgIH6ElQuL2IsiTqkf/phEvHK/zBQcDEmVBNxbA==
X-Received: by 2002:a05:6000:4287:b0:39c:dfa:e86c with SMTP id
 ffacd0b85a97d-39d8f46abb1mr5354802f8f.13.1744366718527; 
 Fri, 11 Apr 2025 03:18:38 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96403dsm1548543f8f.4.2025.04.11.03.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:18:38 -0700 (PDT)
Message-ID: <d7d5b7e8-0156-4aba-ab9c-5564ddd6dbc9@linaro.org>
Date: Fri, 11 Apr 2025 12:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] usb/msd: Ensure packet structure layout is
 correct
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> These structures are hardware interfaces, ensure the layout is
> correct.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


