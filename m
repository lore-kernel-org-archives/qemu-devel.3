Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF0ECF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtRv-0001Dj-Uk; Fri, 04 Oct 2024 21:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtRs-0001BR-Sq
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:19:08 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtRp-0005SA-K1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:19:08 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e9f955cb97so99011a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091143; x=1728695943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NbQyMLVXjPpCRmBDTpHSCr4x8GjcSjSYuPBHxA+o8DU=;
 b=uwGWDaKOX2FYjPYD09VJDT4JqnGvFCffQQCvbBQfOTMrayMN/KbwwxK7DT+rU8MVvn
 9Wbw07oCh/UNAFrLesy+8oDh9D04tqdFbAMwI2+47wxXBpfq3NXBZE5qAu8hsyc6+ddG
 diJPwQaxMZtqdMXJt2h0nM+DJNO4lZgIg8+hynwe6VOuA/OEIGwhqD03zESgOiCvRHI/
 whGrEWWf7DxMzKoBS1+DsiPOtrW4CX/3wBdVq+FJFNKNww3Wr0CVEqse0RwW7VS3TEwv
 fPOM1VzIAhAynz+3/rBgwlcvMoLG5gtU5/7T4QTe+xDpRMvr4laqdK4uQBADXNp/hYEl
 CGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091143; x=1728695943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NbQyMLVXjPpCRmBDTpHSCr4x8GjcSjSYuPBHxA+o8DU=;
 b=XED+1Pgji2/PofY2N7eHvvndaMsALsCMIm7fCmbcX7TxayE9GIQhFt/CkWw+RBvavX
 Fzhj7zej8TI9FGJvZKN6Hxch1xSHT/sbv96z0hB6TKl7ZaKFGUHFA2Z4Pf3LVotX6OO+
 aIAOHraGIrVuCCXhXAak4ncT1WYtmYoksWnmVCFOemoj+CQyV/a25e5WjQ+VZULwNZGc
 rehXJPXFHQzAALOLG9bufwOSEqzVqt6RxDoEth9QzrvZUjDCTqN2qu8R2r7O55B8E+Dc
 TXSY0mob5eRbiFCX71SqWQPlqeh0T/ICPLFIwoxQf9aAvYA5aG6LRpbglIf589Rcw/P6
 xFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg5iWsM1pZNHX29z6fsVrrE0RwgXKtDcZgAZpJnf02N1VXAOezA2IsdiCTHe/7AqVUl0mfp94I7sHI@nongnu.org
X-Gm-Message-State: AOJu0Ywa+ZziF/HpqMJtfvNnCNDC1OGwWeXHZl0TaKguLEhvdJ26Uxg3
 RGX87hpOPSWjfPzihot43vaJbXGqneKCLfXbh4AUZKuFNbMJH1aHYEFoIIy9lgc=
X-Google-Smtp-Source: AGHT+IHWiL5+dPqx9qQtSNnH6SairR2BkInggIZuAxhswwy0nMBm9WAyY381Dno2ADzKQnxOiG20yw==
X-Received: by 2002:a17:903:230e:b0:20b:54d1:3377 with SMTP id
 d9443c01a7336-20bfd9b2113mr66917355ad.0.1728091143067; 
 Fri, 04 Oct 2024 18:19:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396d750sm4420005ad.232.2024.10.04.18.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:19:02 -0700 (PDT)
Message-ID: <3086af3c-b10a-4651-bb68-a6db5b6fc62f@linaro.org>
Date: Fri, 4 Oct 2024 18:19:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/25] linux-user/i386: Use explicit little-endian
 LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The x86 architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/i386/signal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

