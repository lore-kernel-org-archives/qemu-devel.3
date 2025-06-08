Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A45C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 05:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uO8Y2-0005NS-RT; Sun, 08 Jun 2025 01:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uO8Xs-0005N7-9a
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 01:26:13 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uO8Xp-00078p-2A
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 01:26:12 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b2c40a7ca6eso3067484a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749360365; x=1749965165;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0VyhX7QEujmW9qFjeBb8iBB0P1skzbjozZWhYvWxj90=;
 b=idUKg1WdZN2q4nqrpU95dbaYEioLyASxl1BYcGIh9Iznt4wf8ofq1b2Ic1oZtkzE2T
 ZU5dYIC4Sohyz7KzXWLctKul80WGUYizBOVNBbQmPVGOiz7BZwLNyMThCmqi8QuFwNHn
 TA1lMPMRJmE/S/Gvp4/tIp0gDQprmJ9kAgVFudtrXPZRUNU6kXwb89yXAkN+Tkqc4VAq
 6vOL9ocv9okwzdtaNjwkUPBoJ7Va5g7eU1jjT1OY+aSH1EQHK5t56WJTTV9p/a46yfQY
 NQFl5GzJo/C4ABKJNkB13NyXdnV+2rFI11e8l05LcAsXJNF6PbPWULgcLrg8DywNyAvk
 xAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749360365; x=1749965165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0VyhX7QEujmW9qFjeBb8iBB0P1skzbjozZWhYvWxj90=;
 b=ejHQpZZLW0z8eL5KcK8reAC4KVWT/BU49/Z+qZTR4W8/rJ0hDv0lfSzMDL5BfPh3E4
 HBzX0aokPoE7mLxc6g+Ct0v6zh1H2IoxqiaoiPhe0CVhTRIDCUkljC1rK9RgRowKayyy
 Tb5luYITj6VgMynEhgWnVbUxn7TjdVDMdtVxzeHBWRy7HIXDByFvGY/jxoqJws/Kpk13
 RrzHc7WWgh8NfH53f28xNpHeY7DrPcAMzswY71h9Ee+pnuI4Ar1WS8a1OWcbwF0h44nL
 5j8/N4iAH7NHoTT6j9RCfn2a+dR9gAoRCfX6u9k/2mHIOjsl91Vaz2bzH52+jbq5+n3W
 fQpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4uol7VpTCiY5BTmzaB/0YIosnH+qwKdOnuhP3isSlmuKiGDfq4UJ9tYPx4iYawauwQaAHGyEqyI8R@nongnu.org
X-Gm-Message-State: AOJu0YzEiIqkxetBtl0KULreVKdgZgE2Jzoq7QJyPKHDZjH+MdOkwMzS
 l5uGLepEkpQeCi9FSOKYI7kA9MlbdD7/HJ9zR+V3dG2oSDDda12PR5BjfKrQjscyGnw=
X-Gm-Gg: ASbGncukc3mUxSzc9TBl7V8Gmvw8EwM6Fyy75jLlQznoE3sjlgXzSZ5nr7T8iXAf1Mt
 3ZDnbY1SPkKqEkALbqhukI/vld4anJGhFSsItH2iQlEcX40qke8ulL93iPf+EG6mvREpEo9AXbM
 teHvn8QfhcHL0kLFBViTWkMf53r4zFgMLmaDB7urvuZpRYw4cINvQnlKNBInmkDcpgeAdoYWPis
 vmF5Z5Q2CUrAvtVcDFYRPblQyaWgWxdYI9q9zgLxPW31kiN3s1+2xQBKfNABHYBSjxeymn1aYnZ
 9Lx6V4eC8PZ+Ps6IIhnssHii05KOFnqOCMnWXW+It1qqsBhYxL1CHz8e0Y1WZqSTKZzuqRAnH3o
 SqT2/S5vIzw==
X-Google-Smtp-Source: AGHT+IEI+nPUxasnAC0LSIQWWQs/fUY4MJ20Qbz50rB5otllGes//Xb+7DcseYw/rrGZdjvwMTrlqQ==
X-Received: by 2002:a17:902:f54f:b0:234:8ec1:4ad3 with SMTP id
 d9443c01a7336-23601d71b8bmr139977065ad.40.1749360365622; 
 Sat, 07 Jun 2025 22:26:05 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f1910fsm3607595a91.1.2025.06.07.22.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 22:26:04 -0700 (PDT)
Message-ID: <d1a5fe06-599d-4a04-a550-1c9927495516@daynix.com>
Date: Sun, 8 Jun 2025 14:26:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] python: update requirements for Sphinx
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
References: <20250606205009.584615-1-jsnow@redhat.com>
 <20250606205009.584615-2-jsnow@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250606205009.584615-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/07 5:50, John Snow wrote:
> In advance of actually bumping the build system requirements for Sphinx,
> bump the version used for the static analysis tests. Update the minimum
> requirements accordingly.
> 
> This changes the test environment without actually changing the build
> requirements, and no extra changes are needed for the tests to continue
> passing.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

I didn't notice these files. Perhaps they are better to be documented 
with pythondeps.toml.

Regards,
Akihiko Odaki

