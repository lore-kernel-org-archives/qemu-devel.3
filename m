Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F121CCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRMJ-00015v-7v; Tue, 02 Sep 2025 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRMC-000108-8n
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRMA-0001cW-3Z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6188b793d21so6412906a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756820847; x=1757425647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXDiikMBr5sTgVqsLvsvUiNl7i+RmxmaZDNA7vuKzj4=;
 b=CfXU1jUg/NnDHYH3XHoA/iSMO9inGUhRJzY6jq1+KTsL84q0JQsqG3i8WiYjhxcSzu
 SUym4l3LEBoJC7Xoq4yE5T0suuX8xVau7TD+cD3eHZl1WwV3rDHU2IQd5sgQv8CK8sGv
 Tr9gf3z04ivrZjghhLgxuQKMOvX4Gt9PXGi6QFOvdaZg+36bl6cWKUnyLNyva21GhSkW
 GTHg2fxsqSeBdAz8QvJnUM+CKforIDiWMcAOwCGuhJappzEt0C80bIiywTVs0QvrB/G9
 EuY8Ji0/95LaUJgvlDjB/sE6Fk7Nah0fuznTyXB28rvKAuwBfJIeEU5NhRmS5If4VyE3
 gsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756820847; x=1757425647;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXDiikMBr5sTgVqsLvsvUiNl7i+RmxmaZDNA7vuKzj4=;
 b=EuUFRrRXn6c+dR6XXdPdOyuQBl+A3VJt549JxnXj5D9ctJt+/ZFj0MEEL8WwGGQnJN
 OY0X7gDMa0TD6bIpTCsatZ1GpzRKqSbQXjBNAyeQXNShZZJsY67ndDPvuVTmVEsSdL8z
 iDxUQeOoxd5jMIlCJI+o7iIvDbqn0f57zhiNf+f/OZVSzM6t1HY1/lbAd7tNemaL961n
 YJ6y7e5i+9CJ2GLg9uBXlE3kqD3WN+eVUjMmytklW2ubgYW0122Qf/xDs+2x0QuFMZX/
 K3sXO+d06hALUky9aUUewQgF5IjlNGTcpX+2C+gKhaPtIoJp7MaUdsDKriFh/Uzq4Wqd
 tLJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLIqW9WEdbEHGZlruo7hIYWl3+JHMAPyJxHCisRI7eRgawat+164HgX4C82NtJkc+yFU0uhB0o4NUu@nongnu.org
X-Gm-Message-State: AOJu0Yx62Uwy6NTZdz8V9BhSx4A3aPZK7LjKpf0w+L2ogbnQkpvmWZoJ
 nd5qw0RSazBNGU9TnlGeMxw58RVK3GcHr2Vyovv+x/iEGkzz6h3+eIKa5uvDmZXVBD8=
X-Gm-Gg: ASbGncvQTTt1gk6U4BsqhURINU37cldrDTgr9+llpdBRFwpS6rCnXDoQB9vHDFcYksx
 HERHTu9Qd0p/jGS3NXtvvUdmYHWLlVROG9nlD8R8X/OztgaW0bU87+okwHFuu242uLV5J0vPBk4
 D2Y/Y3u/RUpyZqp5v0FLibIslIQyL/X+NptEhbLhZyjRFWTDZwF0C+bz6JYlH2SUVbPdS+Qo9xf
 oO2HqdKDxKQWqbrPJ8EMTLyC27epHuKJDzPaRGsf674X79F8QCJIy2Zc/GFcR5i0mzzIf3fyDfI
 jrUvXtG/StPsKbjVfpHHcJlSSDmy6pgeTGNgc12DjuzNZS4ZmO4DHdfd2YXvbj1r2CsEHdA3Iym
 3aNfSREsed1kyOCjBi8X0Y2l1SHUpThyGC5hw9W6W1SNAOynMGp7cRRZYU/yNrhEnRb6ZNAZqVm
 6jbBZgbA==
X-Google-Smtp-Source: AGHT+IGmrLAs3yDBpLS7g2ehzcKlyslPkeIln4YuE06y0kmMK3YQlqqf0iqJDHIXIBQ49Rfse6gdug==
X-Received: by 2002:a05:6402:4316:b0:61d:2d46:20af with SMTP id
 4fb4d7f45d1cf-61d2d462318mr8782666a12.38.1756820846839; 
 Tue, 02 Sep 2025 06:47:26 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c77d0sm9701605a12.11.2025.09.02.06.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:47:26 -0700 (PDT)
Message-ID: <30f7a3a2-d432-46b5-821f-58e100dfba2b@linaro.org>
Date: Tue, 2 Sep 2025 15:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/9] Misc QGA fixes for 2025-08-29
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250901112413.114314-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901112413.114314-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 9/1/25 21:24, Kostiantyn Kostiuk wrote:
> The following changes since commit e771ba98de25c9f43959f79fc7099cf7fbba44cc:
> 
>    Open 10.2 development tree (2025-08-26 14:10:25 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-08-29-v2
> 
> for you to fetch changes up to 28c5d27dd4dc4100a96ff4c9e5871dd23c6b02ec:
> 
>    qga: Fix truncated output handling in guest-exec status reporting (2025-09-01 14:02:18 +0300)
> 
> ----------------------------------------------------------------
> qga-pull-2025-08-29-v2
> 
> 
> v2 -> v1: Fix author of commit
> v1:https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04615.html


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

