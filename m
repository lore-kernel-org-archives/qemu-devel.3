Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzH9-0002jU-P6; Wed, 15 Jan 2025 04:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzH7-0002fV-43
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:01:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzH5-0001Ld-JX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:01:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so45310405e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 01:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931676; x=1737536476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E83QNQa5X5ZY90f2qQhpSXDnTl5nXXSGLhtrWqSOjR8=;
 b=ultsPp3gjXaI/4dNAY8rKgyNXV2hZAcLgPoZXUqRKJHK3jR855fNwENcHCIz+Gv39r
 qM76Cuk00a6hY55dKpSinYxsRqXIY7++zhqmCMsm+WI+4CASxXes/lHxqAQHSrzoKERd
 ImXcA0bLAzPmLu2S/1k08dNponNynCVOPlJzO/dCabe2BH/akZ2H5cIKpEx5RSfgRj8l
 sVctx6IPxet3NJtTaY07JM6Dt3VrgvkILeXPJOA2tetrggLH59BmccFEr6qk789qFSQ7
 SYdDqEXznKyr5OB47+BY+N1YNuAotJFyKp4KSePKE4pSf8Y2ryztFlQvOqYk6lBtTULM
 y54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931676; x=1737536476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E83QNQa5X5ZY90f2qQhpSXDnTl5nXXSGLhtrWqSOjR8=;
 b=qnYzO0hVOcDzEcM+5O9UNh6UqgLdYMOgQ5wSFvqs35YW3Ih65R022SsgqrkHnTm/wA
 SGR4kbcdLEOGfkH8EIk18U6vbjNbEyceeaWm3AwANN1UtkV6K4R6Dbb48rNlT9jjbNps
 lNoJ0men6vekaLp1CYzsN1QFwtz0yYP9Q0lfPjrYMUIRAnrcw8uuByQ+gsXAgzK0UB0p
 X3Kcx/ELmzPMpI/5ea+mLjgVICG/PVaxrUtsBqd2W2+mQDWh2lrqBt7fdrgN6LDJuree
 14t+xn4+y4/+xf0wsNZhfq5pkk02X5R6TzWneFcOUZOe3xM621KyUbk2fexUrj/TrLx+
 thEg==
X-Gm-Message-State: AOJu0YwxSp469C1MjRRzEidiXMai5RrH8wcakqkQpsfYu0/Ju+U0vjkf
 wll6ofVlbuS8lm0TVOiMfQDGGVp4gWJ9QlfOtE+h+ax+OXHw1LG8S++UyuaMJCA=
X-Gm-Gg: ASbGncviZzZq4iMWpz8jJB1P+xFxIgpvjRgk1h9VOwMKZtwI1dT7kj2LYV5yaUX5Quj
 985B5S2RIpRBA/K5ePDV8OoMmqTg9gAHJqIXNOKaOmJYVeVvG7tYn6tD+58G/9ZgiBmQkDs44eY
 QKu+x5L2vApS7JMeEfbdWvFrIr81lvyjJkUavdUKc8pZoAeQ/WUqoQXU2ZiGemCyRslUDrXyOSF
 xnwVwed3wo1kmlnJggLvGTIVAz39qwgxLTOtjsh0L3A3ekMoXQ/iTnC0Z37TKFI1C6RV5ua5Stt
 1+GU5/nJlogVTGN+TDr4wPUs
X-Google-Smtp-Source: AGHT+IEivgMyMuhasdMNdd+lwSpgL3ZoM+SbU/8LA2slSQ3WPRfoe7RUOM2iaGOktyIMM/NKMsjRVw==
X-Received: by 2002:a05:6000:402a:b0:38b:d824:df3 with SMTP id
 ffacd0b85a97d-38bd8240fa6mr9153124f8f.24.1736931676569; 
 Wed, 15 Jan 2025 01:01:16 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38f0eesm17319941f8f.61.2025.01.15.01.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:01:16 -0800 (PST)
Message-ID: <344075b1-9a45-4bee-99c5-e6bd3bc5ae8c@linaro.org>
Date: Wed, 15 Jan 2025 10:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/intc/s390_flic: Remove the obsolete
 migration_enabled flag
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/1/25 08:38, Thomas Huth wrote:
> Now that the machine types that set the migration_enabled flag to
> false are gone, we can remove it and the related code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/s390_flic.h |  1 -
>   hw/intc/s390_flic.c          | 14 --------------
>   2 files changed, 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


