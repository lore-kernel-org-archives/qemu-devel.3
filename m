Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBDBC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfOd-0002aK-Ur; Fri, 21 Mar 2025 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfON-0002TU-77
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:38:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvfOK-0005FU-Ov
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:38:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso3873689a91.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742575119; x=1743179919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wd8JQPF6330iFbrfqEOHPqzvf3WyiSqrdPORWZKD/hg=;
 b=uumL/84UYpaMtkv6Yh5ixTZFXVMqAOS2tBB02pXvGS1VmgwCwTy+yUczoeScQFBIfe
 nxjtA0VjRHRpRlDCGiKyvmZDzM4IpsylpxYDo1qo2XQAYY+gQUDYL8c1CkjsxjkddTT6
 VVDngHHCIsZ29PUljUnJg9YWTup9As4kIXxDgRn4DNVkIWVMeFSdEfHFi+7PL9UNvXFu
 SOg53r6UgoAvMER4DeS2VEyXtZPlvwhbV1sqKn5klBUbGdumdzswddWAwiolRZsbSgT2
 q4w/Zt9XR4o8nBihZBI+YfA04ZdXjpIRss3LWssVrHqHuAc8tlylHPJHgflaNllDCStd
 IqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742575119; x=1743179919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wd8JQPF6330iFbrfqEOHPqzvf3WyiSqrdPORWZKD/hg=;
 b=La0fazKGVM0CvLxeFn51n7sklS/eQQtxQcrbrrh5mQuHengoxFUAlElPowJLF0/Zru
 7MbzJLxQR8egddB7aCBukypAMp9d3fqs22rIL6lZkOWBQKAJfvivDInq+951AiVjvp5L
 eQatZrZA5VI3N58af0dDI+Bp+4aCtFNSkWjmET8Ou04j4TJaqVMtmpDrHdSkzMFQ3yAZ
 gxUJcGeAtJ0b8k4/y30GU68FxSXt0/iln8st/3uSd5rxTk+Q9M+lRD+zBds/KN5Xd9ud
 uXiRkyoxBKF7iI/16UisZFMbMQp+J1zdrWpV0K7SOP1fN/vOSLSs3plMIP6QeEB24BAM
 bwYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYiSvNvuKySeVzWE7mVAq/1MYqUmYQeFEsOv+sPiU1Xzj5U5nx5fqmBrc89+qRz3qShIxJVut3CTNl@nongnu.org
X-Gm-Message-State: AOJu0YwQt4reugIHduDbXN5kjGB9mlIUMW2D60rhggTtFUweZmEGnbw2
 e29uMdzOZFQEw5muOjwqb2sz/SAW5wUYa+CtR9p9hFfJk3qdWYavPwu5i2u8dms=
X-Gm-Gg: ASbGnctwlLVaBvTlspw9NRMJhV4nYSfFGhSYcgf6X6PcOXGB4WKoOUXGMCYwL2jp7Wd
 qSfRD2SO1rdfv3U5f0xJefrudh7O/cMnxB7cG7wXgwdfStGdEWPHtQ02/WsS8Qo3co8kfb5DtvB
 LLN6H1qIecg7NGXkaojDm/3btVpBFswXpAoRav04XtmJJopm/31ijE6oMXaxU6CsuZrB67dJa/w
 Js1qKpjHcJRXlKBxWebyrep6k8y2QEjfh1Ccus3wzpiMKU5JjCeo3ONea9MDk7WCZxxpVmYEv8z
 3zYqYzOMohNQ0yZKvoVH2A9XWNVbtrE0eXFYbGzdFh1Knpn56dEXHphTa/YMXoroRyI2IKD1wMq
 EHmTrrEqo
X-Google-Smtp-Source: AGHT+IHBrfgKc4BXXVrreTwTXf7JYTWMk7AmN3VgpTI8o/PnAwoC0SnVFSBL0TAxFoQV6CIXyEl68g==
X-Received: by 2002:a17:90b:3886:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-3030fea9334mr5800623a91.20.1742575119381; 
 Fri, 21 Mar 2025 09:38:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf635fc2sm6300112a91.46.2025.03.21.09.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:38:39 -0700 (PDT)
Message-ID: <8eb1b40e-3d24-4b2d-9cd2-d5928d488e08@linaro.org>
Date: Fri, 21 Mar 2025 09:38:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/30] exec/cpu-all: remove exec/cpu-defs include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

