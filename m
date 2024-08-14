Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F034DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMiX-00022l-4i; Wed, 14 Aug 2024 18:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMiV-0001wM-IP
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:43:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seMiT-0007VD-V4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:43:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-201d9fa899dso3142965ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723675420; x=1724280220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvlP5kjU4m+y1iPTKUYsmqaU0kZYy62iadM9RfDvfhg=;
 b=cJ9ludp95YRxw4fys+JYGsukxa999xT54WMA3ER/OJt0BOugNTbQ6HJp6wEKiAEjw2
 ViFEwUSpLe0X27qfNu39637UDIUKkLQJdSJVkmdAMA/eIgcjXAgOLdjh60CRQDRBnHQn
 MyAa75TToWJRQsGJ8bYR6tqP7F3ZKP/2lFRz1orNWFWcCgXDBa4VmF7qmc2oo9HzHFpX
 tsqDDuV1qip5rQCq58vdnJkZvx0L+mrGeih3Mu8vOETbvnAyuEXFIeWKZ5IyE/IeXrJp
 Sr9YWeIlhYZni5L+CQFtyj0jf+PJp3ARKpOfH1i3FNWmwkE1zReMjmGKOANXBaxRj4Ul
 ullA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723675420; x=1724280220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvlP5kjU4m+y1iPTKUYsmqaU0kZYy62iadM9RfDvfhg=;
 b=dKyxtmAOM9JlVobS5EgEg6UHptKnTw6kWAve97Ew+xw0WElUpc0kAXECU+KcNbt1Ve
 SILJ2yZVjX+XCN+3tk+KkrK5dTaGyN6KI/TJelFTc7MddhPeIGVo1kW3I3Lxe4AvgaUS
 ndfBYUKdA8eqFwkLZ42UAkpWWKvAlpFl6cNGA0oa/LRyFiHMaefMUVyaVdZ7aROepsEr
 4z7FStRZbtmU6Cprh+NWiWicHGAbgzESLu40IGZP8+KjR+fjIUdoda9IqjpCPSdmJXrx
 rV+vWb1V2Qsa+jZx51ool49uEYEI/T7e/jf+KdBedL8iESmknVeXrNDNv/tpR4sZVQSo
 BX5w==
X-Gm-Message-State: AOJu0YydLOen+ByF9uWfuAyhiNJKszTpIQJFy0q7+hY6vlCp3pMTIBEW
 FPmuQiCGlGo4dWXorkzUq1mDLzIVD3dopPZDssAocwh0tlIv6vsRsqub9Bk6cb/yLSH3GerX/WR
 fhqI=
X-Google-Smtp-Source: AGHT+IEkctpY4qxf1n2O9muf9zJIH1Fln9uS5JpJVLgs7XwqDu3bjYUe3TE6kknjb+G/Oq+w+9g78Q==
X-Received: by 2002:a17:902:d2c5:b0:200:8d3f:bb65 with SMTP id
 d9443c01a7336-201d6398005mr54522975ad.9.1723675420387; 
 Wed, 14 Aug 2024 15:43:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038d453sm1266175ad.224.2024.08.14.15.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:43:40 -0700 (PDT)
Message-ID: <d674006e-96ca-48c2-a11f-bb0574beefe5@linaro.org>
Date: Wed, 14 Aug 2024 15:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] build qemu with gcc and tsan
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Sent v2 (forgot to signoff commits).

On 8/14/24 10:11, Pierrick Bouvier wrote:
> While working on a concurrency bug, I gave a try to tsan builds for QEMU. I
> noticed it didn't build out of the box with recent gcc, so I fixed compilation.
> In more, updated documentation to explain how to build a sanitized glib to avoid
> false positives related to glib synchronisation primitives.
> 
> Pierrick Bouvier (4):
>    meson: hide tsan related warnings
>    target/i386: fix build warning (gcc-12 -fsanitize=thread)
>    target/s390x: fix build warning (gcc-12 -fsanitize=thread)
>    docs/devel: update tsan build documentation
> 
>   docs/devel/testing.rst       | 26 ++++++++++++++++++++++----
>   meson.build                  | 10 +++++++++-
>   target/i386/kvm/kvm.c        |  4 ++--
>   target/s390x/tcg/translate.c |  1 -
>   4 files changed, 33 insertions(+), 8 deletions(-)
> 

