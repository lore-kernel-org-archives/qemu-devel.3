Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDC0C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmt5p-00035c-BD; Tue, 25 Feb 2025 06:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmt5n-00035P-NB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:27:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmt5m-0002Kn-4A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:27:15 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f3486062eso4636891f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740482832; x=1741087632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WLu1YcZRuNqGZOc3E6zggiosmKQ+o0V2aa7sKmAikE=;
 b=yILYxGipqJLgoz188REhDv1hVvEcFJS7Dr02csL+b5BhHXjyvAH69GxAzZPu8ZV+01
 7nNzY9JoMqYvyEFnpKFVRGtxOYhfceNp/p3I6NLwOjUo7dARDVHgFGNDYE4znaNhhpnJ
 VDt48n4S7jiN4/jhyU8uPU1niaL/rVuSJ1D83kylTgubz0ZZDq/3QCjDxFC1FQ+sWKOM
 HhXahtoHdTzKZ872k0LaLWgTpUzzKZvT3R5c8j4qTLcdczXIOTcZqvBrmsD2l6dPg1ko
 9yULUmyxejIbi5iN/aZnjMr+elx6WqT3V4mJ4ql5JQn6wo0v0a239jRdrmtJjYBbUgji
 Jymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740482832; x=1741087632;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WLu1YcZRuNqGZOc3E6zggiosmKQ+o0V2aa7sKmAikE=;
 b=aQ0EFn5lSI5nl79exI3yTReaxr8C4FpAsXL7wKTkDawDrpeXFLYjm0Nmm7fAb2OiRF
 8EuAAz5gcCy9OEIRSNTsudb7SE2iNw5s3eHn57kgGn+zYPgSQ+CZWeUdzBcS3VeFaUOV
 UUdTyvsX1268mnqehxJnCL25FAo8cj7Q2cwOysusjNOcokm85UPduzRDh7LupLZma3Ty
 d74ZNGcKNttzzVS98lwxjVExHCvB6xothsEGihuPqze48Sh5/jRTL6kxX6NqBlRGQ+g0
 1yQ6c9t3lpRnyt1yL4aJBuv/rV+eSFWerjWryk5PnJcdhSDtCVGkbvXhEgSCfqzG5faW
 yVVg==
X-Gm-Message-State: AOJu0Yzr28EcHDBdsYaN3vF43lMFvsn9WPy0mPKb/JHTJSkzGJ1SAmd+
 qo7za3RRBCgaExkhv8+ByuWoX01oLx5pVn0qZMQjIsTyJWK+viNJ6e7n49NO3qM=
X-Gm-Gg: ASbGncvIf4hQ/Rg+iPZ0MRfMuiLYkr3eVCUNQ7XmEWEH7iCva7uf7hs/msMZlfP9Y8p
 rXGSMG6IptM9dEc8r1pyoV9i+s5yUcINov8UBXU2vEXFGSZl0OImRNnzNjUJxSHlNryOwm4GP/r
 PYR+nTyzH1oxhwIyV8ZyXux1NrE6N8Rdx0eVEWd6mtfV8Lr3diiYhKsLCd9HN+Lg4igNqlRKLmU
 j1SQlVFdTq+RxwXF+o9ijDPGkPO8iG5rmmc5LmSRNZdtROkGqkzeHiZSSRqAsSXHcXl+3CDGdIr
 c8WJofva7XuMRNaF+DWOWW5qG9d0
X-Google-Smtp-Source: AGHT+IGCJJxU6jDvhjDwSY3JSWS/K6uaelygSgFhPc9mVKRSR8300+wxJSn7+7okHMuJnLi5/cyMCg==
X-Received: by 2002:a05:6000:1865:b0:38f:32ac:7e53 with SMTP id
 ffacd0b85a97d-38f6f0b189dmr15403132f8f.39.1740482831567; 
 Tue, 25 Feb 2025 03:27:11 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e72fcsm1915182f8f.80.2025.02.25.03.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:27:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 201425F7DC;
 Tue, 25 Feb 2025 11:27:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Kyle Evans
 <kevans@freebsd.org>
Subject: Re: [PATCH v2 01/10] bsd-user: drop not longer used target_reset_cpu()
In-Reply-To: <20250207162048.1890669-2-imammedo@redhat.com> (Igor Mammedov's
 message of "Fri, 7 Feb 2025 17:20:39 +0100")
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-2-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 11:27:10 +0000
Message-ID: <87a5aa6z8x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> target_reset_cpu() static inlines have no user,
> remove them.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: Kyle Evans <kevans@freebsd.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

