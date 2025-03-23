Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B6C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQyU-0004Wx-6W; Sun, 23 Mar 2025 15:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQyK-0004Vk-22
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:27:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQyH-0007aE-1u
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:26:58 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso4522895a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758015; x=1743362815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nf4+rA43Kt9Mv7AOyCCKgBarZrgUwABieRc07zFXEno=;
 b=fdTqazb7fsIdDfu3MvbSsSK/9/u6U6rP+ydsSy1prR4wkgBJKJ11jVvacW0avc0oR6
 bk1yHvpYn0cnrYAN60813RjlfEjKUJUraJlxIqt5Lr/EtdzBVW4nAUWcB9ovp6xFF+qg
 w559DUWe6f51CcyiK6fCSP3hQrZGL9A+ajOw1O8zAbbZCQjNBvtxSvwbhSF96I8MMFAO
 r1zRLI+6SCc9ApWYaqpynJo04Q5Pz6E/stHg4AMhOur9nz9HShLiWkCWMa/0fTkvb4XI
 B4jYYGiJnjAcyLWpDWEgamE80UJFBxpK3oix6f0VIC+AaOW0J/L1i4x1CFzeWSDvb2xi
 ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758015; x=1743362815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nf4+rA43Kt9Mv7AOyCCKgBarZrgUwABieRc07zFXEno=;
 b=p58DDro6XA/fFe57g34pWVoFFfDRG/SZ/qcJYWZPLJPbIGke/gHRI8kWbFi7n3bDug
 +otbeEsyQgBoGPhAtMKxYHBIpTzNvc/Oxgh62ElIYspzvErLmmdbBYmwbbE0NXsZn1Zc
 oa27ltZBj7cYeGa9LyA4VtpzYVzDQA9++HhPgIEO2hN/PrpcfVMgbywBsDmmKlm/pXoj
 b6RUqOj3gd5/nTTwPoYw6okDLBKH+dKMjqLeL4ghmc0mMcC25nf216xoqX5wZ8I8SrXr
 /EICoRakP/C5vjqU3HWIrtGuwWJtxuvmHRCbOOrU20lHvSMgDGAlz0xtTH296XlttENa
 yShw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwGEu1DkjCENH1QjeNzjr4N0mOqWL+pirI1BBCpIVwYISMwZbcZnUPesc+6wqcEVLgyNW1egBAGqsn@nongnu.org
X-Gm-Message-State: AOJu0Yxd9oHFCpbZ0jVYbCmGXA8klk1Er/C126ZvIlYVrDlNsilLJNe3
 nnnNjdyGhOpMJG8zl+iIMfVGxEuf/K4hQLK0aDw7yzlRXicP5LCDr57whdYcdB0=
X-Gm-Gg: ASbGncuwXTGVTYlSSMys8H6kh2BhaCQKk5SSxQbMJoubQGRld+iq/8OvAqWw7z96B8O
 IQdS8HVzvjwtQ0Ie1wd3jR6kdgxMkWCeVmOWVpkC+u4fnoaCfXeEBYgBr1v1wsmBlukRhrI/XGi
 DkRJOBKYqo6YVTWk2ASrovHFsEgfEl4+6VchhaKRGfkKTgR3RYEPpFkZdlZ1w5vXbCuY6kNS6wk
 6dGrxW9d6aQEutUF7ZMd4nvOzXmJB7pjtqeaGvnYMsjxIXmZrlue8SNs96jtBGulf4HnUasPdrS
 IQByvEjxR4LIcTTDOwVvaB+Mqn1zTEb9ZZ7z4GX32AWPxM/+bTxN5hXnV0oISjnvizhUUOHTM0H
 vKC1b0bW7
X-Google-Smtp-Source: AGHT+IHRgCNveshKuDJuoCV+0B+dzaT9aXiMJpElP8KJKw7QemBWMjAKApy0XLHS8tcZ5GFOpDaplA==
X-Received: by 2002:a17:90b:4f84:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-3030fe7e2b7mr15835517a91.9.1742758015264; 
 Sun, 23 Mar 2025 12:26:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d71b5sm6331942a91.18.2025.03.23.12.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:26:54 -0700 (PDT)
Message-ID: <61f1bc3a-abcd-4cf5-9d56-1132c8fc3ba7@linaro.org>
Date: Sun, 23 Mar 2025 12:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/30] exec/cpu-all: remove BSWAP_NEEDED
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> This identifier is poisoned, so it can't be used from common code
> anyway. We replace all occurrences with its definition directly.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h    | 12 ------------
>   linux-user/syscall_defs.h |  2 +-
>   bsd-user/elfload.c        |  6 +++---
>   hw/ppc/mac_newworld.c     |  4 +---
>   hw/ppc/mac_oldworld.c     |  4 +---
>   hw/sparc/sun4m.c          |  6 +-----
>   hw/sparc64/sun4u.c        |  6 +-----
>   linux-user/elfload.c      |  8 ++++----
>   8 files changed, 12 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

