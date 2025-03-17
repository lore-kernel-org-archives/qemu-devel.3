Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD99C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuACT-00059g-JT; Mon, 17 Mar 2025 09:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuACR-000591-U2
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:08:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuACQ-0003mw-3p
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:08:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so2826771f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742216887; x=1742821687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTEOtA9jZeioeWGG3gtGy8I0zYfEGqP6P2FsXnFWvPM=;
 b=URLRGsG6ZwIuVI3TnW09xMLFHEtsUM7pq5qv6USPKldZXMwrniMMLjmfJ5PFE2P6+H
 I1KhLR1KoT8CZRSPiHW9tdLueKNBkXOEtd8BTOdWCQe/pVlv2Tfu36FyyEc59W/9CDId
 auGCTz4bonTrtf2EX30EAeYkdtFhFQcY2HESLYwxjCLk1qrL3gY4jm+n5aksJW/sSHiy
 Nf3mu1I0JtOWPQW46C6DngEenVAi4evp/W7hKMPjh1oqgOFBE21yCV4spEGT6+ttjUEN
 3vwmyw4iyyLY8K45s2PNq9qX60V1Gv/DpFbYPJCEqAb2l3jj1KC2mEtoyGlaGICgFoy0
 X3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742216887; x=1742821687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTEOtA9jZeioeWGG3gtGy8I0zYfEGqP6P2FsXnFWvPM=;
 b=KypQB4StE97ci/R8oQQJb2QHLXuW9XL7mQu+M40KRM52tbAoj+EzbMJLdieJ9ufzER
 5OhpHXji4urqO30ikBVBy6dnqyceFQKQdQaxVwrxi7bbPz1bm38rpFsWK7rjXTS69zxM
 CvTi0SS7Qfm0ZOhQQEZiybzb8EJXKKCB++3lqbkqNacH09Zhw9LfFQ+y1nBxSzbHe/4y
 NyYCYfu2IBZmRg1B/jpNJ9tKnzodbPeQVNmGMIjZjq48nQuXPMf8liK8Tgw0I5mKb4h3
 yhWXMFGIaCQ9QdirJUoyBsx6WDwh5QWwOja7/VYFmyfo1YY38+zXhecVKB/nVW4+wblR
 FbrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/T5O1545/sf/W6uz12s10+jI0owpsX9JmyqEWmAjAW+Odz5QhTsgwDCZJRjzryOAItPQ7+W1GAgox@nongnu.org
X-Gm-Message-State: AOJu0YzsaN7fwk3nPZ4zvs7UmKnEJXo1nDkQRfn1lXQhY7/1XncOgv46
 KF9lcuUZLi7apimuFbsdgK4kuIAcrFsxXIhtMAAycrVuqW4E61BQSzYJWsaGqh4=
X-Gm-Gg: ASbGncsHGQQpCu3bal4gUEJJbKAbk2+d5yWvYrpl8PAQHBmH+Qb1m/GKJAYfXOXUzBH
 AATn8V+JetvLgvp9eyC/C39MRnoZ9ibT4gmmqAdccofjeygLpheZJL6456Hg0YhG5Ozj4kFVwrm
 mIgINpC5+v+rZBvnrYcLNdPmf+u5s3ZqDvR+wYUkiHSkYWRMpwK+9nyn1M0RQbNDy+S5gbZ/37Y
 qZhWTEC5MMjEk/yhPMH8TcXdXtDMQBLZ5TFExCQWI/8RTybj259gduNRkWPDmP4663grogYfOOs
 KvdSRIBOz49juMraA9xbF60bUr6TXMdN5QWQHFTPU8CJRSBMu98LCPro150H/G9Gd0++fcclMji
 JZeXpZrxpH7UosWQD70L/tkY=
X-Google-Smtp-Source: AGHT+IE/fSIXz7uFxPevErVop0v+/GAARefYKKXBfoah7xx4mqPAk6EHHmuhxvQjYkVLWysvIwbquw==
X-Received: by 2002:a05:6000:1aca:b0:391:3b11:d604 with SMTP id
 ffacd0b85a97d-39720584d0fmr14617525f8f.54.1742216886670; 
 Mon, 17 Mar 2025 06:08:06 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df33d7sm15391827f8f.17.2025.03.17.06.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:08:06 -0700 (PDT)
Message-ID: <9c7280b8-7857-4391-9823-8ad588d73d0a@linaro.org>
Date: Mon, 17 Mar 2025 14:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_arm_orangepi: rename test class to
 'OrangePiMachine'
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, stefanha@gmail.com
References: <20250316210232.46298-1-nieklinnenbank@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250316210232.46298-1-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 16/3/25 22:02, Niek Linnenbank wrote:
> The test class in this file contains all functional test cases
> for testing the Orange Pi PC board. It should be given a name
> matching the Qemu machine it covers.
> 
> This commit sets the test class name to 'OrangePiMachine'.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   tests/functional/test_arm_orangepi.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


