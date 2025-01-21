Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB6C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCTB-000301-LN; Tue, 21 Jan 2025 06:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCT3-0002xt-ND
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:30:49 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCSZ-0001uS-BI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:30:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so4543317f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459016; x=1738063816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0rtGCuKXTuEWbszCwRV5C+wCQNbs2Gdh30z0rJAoE9w=;
 b=b2pNKrIG1ccOf6h0VdrMZ7Ka/gDQeHFYE5hzkYsIAZO6PUjUVDjqKkRHoa/ysMvXkV
 h7hXTGoModBs/VeJSlQAr/bZu6eul7sGDOgBEhPFwr3/VmkJ+Dsy25g4WKYno1uo3nm7
 llQGe1AEE+kwb36HWnb0uhlpgGqAZ1uju6BV03f85gXbW7uYhqw0aqqAqSts/6r5XXmc
 tPQJSIytwzCv66BjkL61Pe0gSLgoMwjvhI4WqU987IP1dN/wJ+7opZl0tz3PgFVVjmdq
 MGbTIF+bOvcz8tpWX9aTk0NtGXA3DdXuvyMMiH56z+x1XQjebRdm7FyZ5rD2AD8M7PIs
 8NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459016; x=1738063816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0rtGCuKXTuEWbszCwRV5C+wCQNbs2Gdh30z0rJAoE9w=;
 b=XeZaH/ltqAqj6NlQ3GhJ1fxpDS3wMwBo+LZXITywD7I0zE44Xw/a1JVjQj162UA9gQ
 Feb3WTEUqEEcnSi5cnCVzC1epjYv234KWrJHmmSXUn0dIl9hQDq8g86yJwf5FXNXuAH7
 IIXI+avap1EYdF4wrfOoSDlZtpODkYeFXdw3MAXWJhQscwg7EXzibCyWol799ep3eTyU
 Mgpy5xnRRwY6hqzAiVp4tJ0u96/S0XvL3s5b2oYuA/ZMH/SNbCi8ObLaB25pFUugruHc
 0ygQ5yByfJC8q9V8fRZGaK71VV7w1Dd482ser8TqEjrlIUPIqqdl51aH1tGea3689OKl
 E1oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs1xX9cb0jFL1sXmOQ51x0AjnZA0QAhH8/CMKTJMdebnRHwISq3bgjPZ1Rc3adjPcl8DCtcLtr6SrQ@nongnu.org
X-Gm-Message-State: AOJu0YyM0zaHqhMezoXOH78kJeA4UFAps8az3Gn4SyOLvozwar87sR7c
 RLz+FEaz9Dx7+NfaucmQMzyZRgmsGSyEQEzbkJ9N8hA6C/qOBVk5wbIyfNP0VHw=
X-Gm-Gg: ASbGncvve8mLGd0F7OVDWH3er2st9tX6QC2LuuBkgsV7SMt98zYvgWuMpLPrg1YLLu0
 CraZLNkxCj31qy+GEvafKu6zHfQVJdq19rbod1okOMI6HDqS/5JD0LBpYBLvuzzB9CmPmNPAIim
 YCxb+HgDv8yf5CwLUwAxQL22RshY8iEurN3Ako8TqHqpQndv4OmnqjOtK4d2fasRBKeGak/lSf1
 UMKtg6RPEGXd9h8wsNcmCWQkd4fIHcABhBGuUbX14jPNl3hOPbt7e7MSLMvUUTzWD/omy4wiQnU
 WkLtHx6rmadANu8wZv1KxL5iRYs+ZWz4f9FR5Q==
X-Google-Smtp-Source: AGHT+IG5h6G8BxEhcgs3Ogs2YOLAYAWSruyj+tqdnLekIeamIuy/+2sxfSHIgcIIz31iV/WSUDSPHw==
X-Received: by 2002:a05:6000:1a87:b0:38b:da31:3e3b with SMTP id
 ffacd0b85a97d-38bf5678466mr15537947f8f.3.1737459016265; 
 Tue, 21 Jan 2025 03:30:16 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32151e6sm12872826f8f.20.2025.01.21.03.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 03:30:15 -0800 (PST)
Message-ID: <50fe71c0-4b15-427e-933f-68a95b0adf12@linaro.org>
Date: Tue, 21 Jan 2025 12:30:15 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


