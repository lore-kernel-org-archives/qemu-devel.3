Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC7CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Ct-0005Sp-Co; Tue, 23 Jun 2026 13:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Cf-0005Rj-Oh
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:46:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Cd-0001Mv-Qg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:46:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84537777d45so221532b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782236786; x=1782841586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X/bLx1VdehoOyIgqEyG/VdZ+NofPrbAclWoYp6o1wV4=;
 b=QYZ2CFpyOQsAVkfs3oqU7/JMIYZ6QGCxyde4TJEFOM8vflaFhWErmQE6h4rZgDa5ac
 OY5orSoBAJPvZGOPkssw1s2BObEkw/5rDH87/WEzW14Pvr/SmH3TlWOpv7/U7gZAuUYW
 fiC33UhswYVCvdzqvPqU5ZX1WecjZ6JvLOv2I0aqZs5GrwCgrwhkIUjUVQRuJ2AMlqZd
 3h5sabwcO2eZphCbGWm9WoflshXcC938tXgQW/d59NbzaXGdRTFhXlAgVFdA1sJjUVun
 YvXZ+KHiDT6hoTQPKdXz2Wri9eZKDQ8uIZM+sAlQhpTj+S3KCHzk3NSZ21g9aW3DLxUB
 GVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782236786; x=1782841586;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/bLx1VdehoOyIgqEyG/VdZ+NofPrbAclWoYp6o1wV4=;
 b=Sql+KNIjtZtSaFxPoqj1og+4HWyj1RVuENaBxG0Ae0TLvJrjT4OgkktTF5Qy6dy8iR
 D97lP/AFNUOii1aTVwAYmlHlFiTncEneqHVu/iE6j3+CMhmOzvaTVVQEZ+4Ahx2GUiwf
 OS/rXnqXm5newJDb3Bd1GU9Jbxg8RXWAVGobzDwbgzvWPIYyjaVv3QIJSu1K8QRuBY2A
 4aDPZ7/32XMmk2QJnMbjCc1qAHJ1BMnnlNu2FLMMf1aQ0fXhalp8TdO7p6GbjdObeube
 lCoTWU/nT7TfuXBiJ5IRhrnioRMQo7MU3T/LtNGH44bYD/cfiKGYfRvhLxbqjrLgI4k2
 OxQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0SZu1gJMuasIJggd7nJ0TMqrsLuIbYQwm6//Ex5ViH8TPDROaQqQKSu1TcSk1Yx9gW9w7sUzo8zt+@nongnu.org
X-Gm-Message-State: AOJu0Yx09ZATUS+yp5dYWLVEjXrjo6OcHif5vUF3SuCYn0lMXLiW9V1Q
 uLb9Nz56cFyYQEYR5rDsVsDuDe/EbnMD60FZfYZk7bg2HZPT0L7gZhx0XYDaw9OfEoY=
X-Gm-Gg: AfdE7cmLSFVXxZRc0oBgInOpFf4hYGo4a81PEVv/RFKNtNgl8NhsGtCr6EjFMTtgN4G
 D6i3JkLPkZ0mQE7kLqnpfEkFEP3cCYHjdiDdb+FzodjaWOAr9CghsvgDcAalsn01VNyMcTLLwA9
 zdaVP0beUcZbE+J7Ksbt5IYUCanfP6F7roqfR2PKP1uW97ZHPdcNvHaHpa1KNfXs6bf2Jyp9GxZ
 R3NydfALZxzw4ajKyXdG8W7cGd44Yct6JKH8PBn+TsSreUF15PVv4uj6xLpZmrJnyhXljsR+x/D
 g76Mqr8gulIUK7jIbs1vz0SbKqHdXy/IX0HVSnQs3phIFcYrDV0X2fOdPSSxJhkr8To2Tb0keN+
 Fnj8Nz6sF1kSFN0L5zSQ7AOw5lNKTPc7c0hmZ4DvS9IJ63mEbzD1jbS+uoE+bv0kmhnFQu497Yt
 l1WSXNFvP56Rdjo92ERfnBlTV0e7s2+aPScF+sf74bOvp8tLs1qsC7iOGPtA==
X-Received: by 2002:a05:6a00:2451:b0:842:7e71:ba2 with SMTP id
 d2e1a72fcca58-845a2c82d03mr16293b3a.27.1782236785583; 
 Tue, 23 Jun 2026 10:46:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d89bf2sm11124717b3a.16.2026.06.23.10.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:46:25 -0700 (PDT)
Message-ID: <d4391442-1a59-47da-b68a-188fd4505bd3@linaro.org>
Date: Tue, 23 Jun 2026 10:46:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Use meson b_sanitize option for sanitizers
From: Richard Henderson <richard.henderson@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>, pbonzini@redhat.com
Cc: alex.bennee@linaro.org, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 qemu-devel@nongnu.org
References: <20260623154659.3137518-1-nabihestefan@google.com>
 <a2891cc9-4591-4898-b0c6-b15170b815ee@linaro.org>
Content-Language: en-US
In-Reply-To: <a2891cc9-4591-4898-b0c6-b15170b815ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/23/26 09:53, Richard Henderson wrote:
> On 6/23/26 08:46, Nabih Estefan wrote:
>> +# gen-vdso doesn't play well with sanitizers. It originally didn't get them due
>> +# to the way we passed sanitizer flags. Now that they're being passed through
>> +# meson wen need to override it.
> 
> Details?  It's not an especially complicated program...

FWIW, I attempted to reproduce any problem by editing build.ninja; everything built just 
fine with -fsanitize=undefined,address.

So I'm not sure why you'd need to force disable here.

r~

