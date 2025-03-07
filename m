Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FC9C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqe0V-0007Lw-I4; Fri, 07 Mar 2025 15:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqe0U-0007JF-BQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:09:18 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqe0S-0001Ei-Px
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:09:18 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2243803b776so15661095ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741378155; x=1741982955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jkvAcqf5QyaoHLzZ/dp86AUlBHOQnShBT+8GVLk7y3I=;
 b=MPSnOWoMSS7+aewZqADv4e3b2X0kjQnAMey2vfVlt+IOPmqv/PhbKiDZO7fl/jpH2+
 gLntnMOv6HZWvCamkgWn7afqeTlQWianzntXctf1nKHctS+AZT0ayLRWXAY8APP0Z8OZ
 Z+PqQebCHAbnuifUeB10tQvl9Hg/L1axjbd2bBhabHY1X6zoS0NtwJL9uoJ2MNbmNcQR
 VT+XFLuc2lydnBR127LIX3tB46btIxUpCoJAHnYjcBtP8gMr/cw5dIZfm0C6nXvdduQL
 RXxfr6OHYXCwM78OvdMVS+2IdFd78WWN0vXDzzDAIZWAEYaxmcMm5AnjsIWOmHg33Ri2
 UkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741378155; x=1741982955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkvAcqf5QyaoHLzZ/dp86AUlBHOQnShBT+8GVLk7y3I=;
 b=V+954Eqx2tPp6Ojcj86uKUbWNGLKCrGhplmhh0/f8lODFmGXUHAwtlz01BCnem0j2V
 ffY3bGAV3Iz2OMBJwU1LmtST9+np9kDF4EEtyLjBAyXTkMG0ziYUCOfa4mDue/h0eqmp
 V5n7c39F2A0hLTcjGmmUTKh1Bcspnn8Zcc2SJpfrHKhrc6LAKIK+eoJGf2vZR6pLtb6L
 E0GaMaGdXEdaLjv79/Q5vYe0ud80U+xTqXSeWhr/wTmlIHzPMxXFmC/ypXgSHqwmfjaX
 5ODeCKb761wwh4R9ex9fI7hyCqvDMr/M1238adOmC3HzAywswi+j31+/rPKvZ4++0Mb3
 HDaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGfGMuYjSNni925ptudn/e33RgyzMuovSPLt532EkOO89NEeUJv/jj0W+TrJSG1ssPv1W6r8mTO9+k@nongnu.org
X-Gm-Message-State: AOJu0YzyglSiIVn1BemzJ/WAzeYjmPW9Ehs7KBXmF47ZNDJWuk9joPQ5
 9PDLuOBruFHqNW80AhPl+m5YAf1xTZqwy+W85qNSMdcUoXXAebskK4Yqq6NragEtNnKQxRdEsXf
 G
X-Gm-Gg: ASbGncvWRBJZYJU2T8UerufxbU/4R+hWK8OlwWwx4+7Oy+pqn4CqZlXaQ9Gj4I0Qoch
 w1D5qP7UqGv3XVcj0WZLW5D8N/nD0Z3I9kbeGbWn0sxU5aiWv257FAh08Zae6V8M7erZAY/yXM0
 yzq6bcSIPEFrqUDQsjkW+71s3kHf+t1qX5NZbBPyXr17QZrQ0hScKVGcZCoFOT3S3AWpnstcMIq
 4ijBIQvKRKZ4XxsoocQaV+w4nUGCY69IV3RKg/msOTcAleMt3rujZcRqstijtilBJR1MpS1mxWD
 eIEFYq3mnQC05+RZCMVOcfuwUmDox3xHSqbldL4bH+/UJsiRSZHQVSWYCs6xD6BPKOxu4fWrMkd
 ueIEuS3RO
X-Google-Smtp-Source: AGHT+IGWdntExg+9giqFdZJ8xxyMPbxJY85FxhPogZcpLgA8Nf8vtJ4Fr7pPy7x9CGV1AjAVFhzZfQ==
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id
 d9443c01a7336-22428ab7313mr72701965ad.34.1741378154994; 
 Fri, 07 Mar 2025 12:09:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ba87508asm558499b3a.19.2025.03.07.12.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:09:14 -0800 (PST)
Message-ID: <6ac48abe-8caf-4897-899e-68af29b2750d@linaro.org>
Date: Fri, 7 Mar 2025 12:09:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] system/kvm: Expose
 kvm_irqchip_[add,remove]_change_notifier()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Currently kvm_irqchip_add_irqfd_notifier() and
> kvm_irqchip_remove_irqfd_notifier() are only declared on
> target specific code. There is not particular reason to,
> as their prototypes don't use anything target related.
> 
> Move their declaration with common prototypes, and
> implement their stub.

The description is not accurate, because the new stubs are
*not* for the functions whose declaration you move.

This feels like two different changes.


r~

