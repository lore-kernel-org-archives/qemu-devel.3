Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6852EC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKe1-0000rB-Ct; Mon, 31 Mar 2025 15:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKdz-0000qe-9u
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:18:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKdx-0005Cr-Hw
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:17:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso34313925e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743448674; x=1744053474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEH1oYoEpGYhhuV111kWYXCvqIRE2+UH6ug61uZ+4oo=;
 b=k0RGCPhqqbZMqWNNVU6xKOkDM56yP61+0Iu66mVluku5ATfoULDOrzbf8WZ+YBodC9
 N2iwlssZhS54cfm9iR4MihpDB1tyi7Wu/htmfCYINgUzFTYJT57ZG36nR/b423zOuUz0
 3g/QjcY4UDxir5bduQqTDpP2HSJbttqTKBPckBTn5ixzrLV0PVrCSImoYQMpJDogdWcr
 nD0FCSYgPxAzFURNrwGkmQ4TwODWqMC4MSPeQggeitU3XOU5Adxzu9CvqzvpzbdDk75q
 aiaISwlGSJbcHiwBMesZ7HCOBGs0Y1hr7FcdclMFr2nZj3DNFxNJvV6kzCquez8mo5X2
 YraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448674; x=1744053474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEH1oYoEpGYhhuV111kWYXCvqIRE2+UH6ug61uZ+4oo=;
 b=Qn76SkOCEQ+9iBYWvCkEE93MPDXiPH+l/gOsTh/Va4vHeN4RGvlECn8hHy9n2EG80r
 8oYTwbd+XYlIG2ZNZkhT54/pTe65rc5vZfcG2vBN71hR64jWEbJRfAiKeVNVFfhj80Bh
 ms5/W8eGfba/hdPBnu/ysM+yu8k9gdnA3xucXQURVR4NZJxS4vdDnSKJFWkIaPeazw84
 KlTvS3k4p6Cz6ll/YhHxbLmKhbhd8pSxSu1ZtWfwBIF+osBDFloPxyA1yYux7VgOZSUK
 QeBj0shvf6ccaDQ5biTLfa5YxU1SXowhEeKeYr3D2drDTqnqHyjB7t4cuWWbkg9IoUAC
 i85A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbYhRq3gHsEhL1usaFt/f6Zf1pLdw9hue29ht0nY+V0EobxI0h0wMU+Sa2JiFbNZVLq7pmVXsT5dZ@nongnu.org
X-Gm-Message-State: AOJu0Yy9MaYQfwGw9qk+Htu49xIZnYH/t5+bdD76yb8FJ0TPGiZJxaTm
 n++JLcBIGp362esrLgIai0ymU1LE3+lkMnosiIUriT3DfQmHBFVr8tI+qcqV5XE=
X-Gm-Gg: ASbGnctRemdThJiaQYoxW0HD/Sb+U0clBxQUsF5bNH0eRTACsB2bFI4+5tcT0qgi2r/
 w/7ZwKfnrN67tB5fJFghMdYVrgOtL6uReaqMoGecsRxRs+taZf27YD1bsJH6iepiHOgiJerOl4l
 rW9iNkZKIvUt/yhCysgA8BMLg3Gvx7ObfYK9YXqXyTNceA3c7frp2J0+oX2VzfRJCvBbDuCAkU3
 s+mpGgkz0KTDk3mdK46Tner/wEXLXHYv2aWdcIDh+1j8Hl/NeoAGJPWHpZe3sZFHtxx/LEwk01Y
 HYq4pO0cpQle3ppkMWyLQI94rnM9dxCEaYPqZX7eCPTPLLuBynOY5/z90hwaYZ4d2ARfwpmfIqf
 yeK7mbt/Uz+P6
X-Google-Smtp-Source: AGHT+IEDGwpMo88uHGn2uNFgAqWKX+wbE6fPxnvUARU1UaLg1eU3bKzctuxquZ95sQysoC5rEQ7nwQ==
X-Received: by 2002:a05:600c:3b8e:b0:43c:fae1:5151 with SMTP id
 5b1f17b1804b1-43db8525ae7mr87889475e9.25.1743448674573; 
 Mon, 31 Mar 2025 12:17:54 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589efsm12291652f8f.16.2025.03.31.12.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 12:17:53 -0700 (PDT)
Message-ID: <cb9a1627-2055-482f-9a6b-abbad9111629@linaro.org>
Date: Mon, 31 Mar 2025 21:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121103655.1285596-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/1/25 11:36, Thomas Huth wrote:
> We are not aware of anybody still using this machine, support for it
> has been withdrawn from the Linux kernel (i.e. there also won't be
> any future development anymore), and we are not aware of any binaries
> online that could be used for regression testing to avoid that the
> machine bitrots ... thus let's mark it as deprecated now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   If anybody is still using this machine, please speak up now!
> 
>   docs/about/deprecated.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Thanks, patch queued.

