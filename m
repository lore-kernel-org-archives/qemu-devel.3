Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdwc-0007Yo-AI; Wed, 08 Jan 2025 16:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdwa-0007YV-B8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:50:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdwY-0003HZ-NQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:50:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2167141dfa1so4480115ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373024; x=1736977824; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H22EqvJTcu5bvRp56Xfa0ltFQAdjrQAsFUz0iqnc1vw=;
 b=gTAA206WtEUYB+wEshm2uWOClYxxO7RkCZtsd2o6T8+CuPDi47Uo/tFIPb9H5ztt2E
 aRZdQEQhV+f2MihlhDUK/p7lbYYAxhOe5rUSFJuJ8nM8mpwlhRrg/ZaU+/oLzrdAcCYl
 XV0ZoavglqfbWnWFqdrhN+EVyFd0BTayHIWfO6sez2uu99phjwA9SnCEHpxp9V7ymf/e
 OzJaeUGfx0PHgHYQKwoq2w1b6QLNbzalLN5wqUhgWRyqsfYG5Vw9Yqm86271DErsQ+bt
 7Y7jccNKO/ekvKIRbLyvI+HCzDIdkUB56A70WV8jlQG9gRnPafOQ0X6LXmu8ZLfcBwkk
 WENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373024; x=1736977824;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H22EqvJTcu5bvRp56Xfa0ltFQAdjrQAsFUz0iqnc1vw=;
 b=aQHJbBkbbSphFQx+B3M53UcPLOTPttXTIumoqFum3xbbTi54HB5WMePDtJfNfR/Mff
 FuX5nqVOhrJgSyYD9aaemhXa3U8iGVi2F6quxC1qfw/VdNZfXWGvIKzOjvhjrmvpeh4J
 HcVpgxA1lpDXNOQO2Z8PtmWE9RKBWKmxdJwbZaDqBvnlytwfmG/EokGfFrB5c07Nz464
 rHhoCletyJPNH7dMB+WQRxkbxXgn6Xq5/f17G175X6mmBA0YRtHn7lMEWOSH/T0BnwBy
 PuNRL6hwwuWxfSQh2I9wPxE7pBGa8RDsUo9fMV+WgV5ledPI6eClzQlSZ76jSeWmvcSt
 UFDQ==
X-Gm-Message-State: AOJu0YyoDmz1RetC8g57vWuMQeDgsNHDBGlujDJP+SEEXmsoq8GKBai7
 kibkf33Ghux36nhNfODGzJEFXlpY/VyqSesTCPwRwTdbFJGFFQQIwwrd5T1u85g=
X-Gm-Gg: ASbGncsxHrcQLOFd+fcx/1Ak71c+NtzAcRdVdRuM2cboscARF3rmwMI+E9LrJC/VdqY
 SfKvAk9RZGlXyeX+BuJWNTYd32lWCu9U++dzfA0RzsGja0gTzTtzo1IaWNGY0rf1ZSjPA7LIgeS
 wkMBEcxMPv/6gO5ZchJP5rcBhJlRjS1oDUF1R4Klauy7WNOhzGzwh9+5nukPm8Ae59N3MAICszR
 AgwIdX3shD7DzK421e61YsRLZP4XtDsvAqSVI1xzBLSifvY7ZS+Pk1jncqKjWEZFRhyx48J+MgJ
 yBG70zejb/bVV1dbB4Aw+mbz+E3YN7I=
X-Google-Smtp-Source: AGHT+IE6VcYSeJIOuDFWy93JGtw4h49GosXKKy8e50WhSL9GlNTRuvD3+YoEPTBqI0mTEwpcw/pI5Q==
X-Received: by 2002:a17:902:ea0e:b0:215:758c:52ea with SMTP id
 d9443c01a7336-21a8d66c5b8mr12153595ad.9.1736373024506; 
 Wed, 08 Jan 2025 13:50:24 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a7e4e46c1sm31405225ad.84.2025.01.08.13.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:50:24 -0800 (PST)
Message-ID: <d14c7896-807c-466b-86ff-a590dea24979@linaro.org>
Date: Wed, 8 Jan 2025 13:50:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: make docker-test-build@debian-loongarch-cross
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Hi Alex,

It turns out that $SUBJECT does not actually cross-compile to loongarch64.
Within the logged configure,

   Compilation
     host CPU                        : x86_64
     host endianness                 : little
     C compiler                      : cc -m64
     Host C compiler                 : cc -m64
     C++ compiler                    : NO
     Objective-C compiler            : NO
     Rust support                    : NO
     CFLAGS                          : -g -O2
     QEMU_CFLAGS                     : -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fstack-protector-strong

Obviously this is less than helpful as a smoke test.  :-O


r~

