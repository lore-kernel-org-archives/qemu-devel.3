Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB1ECD342D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 13:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slTO1-0006yl-K8; Tue, 03 Sep 2024 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTNt-0006xu-BU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:15:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTNr-0002wa-4s
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:15:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c6187b6eso1540129f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725369339; x=1725974139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2LD41fBqc4MjqU6fbyBgu4Sh5uUK5vzOa4pB56KxVk=;
 b=Uhl3EsjpuetTovgTQ8sjq1disR7wNBQ7jWyd4luhe6hBU4tZb/KrwPY9x/29uUhu5v
 6DjHPoTCmkJM2o60EGyC+wJtkNJ8Iy7MOtZDrl6aXLjgQQjX5dekxpN/OrcC+CsjaNl1
 eGymslvaWMW1Or5OAoobsaUAxSbSBM5W+/2NTW3nFoGWVgdbI07x9ymgpeKpHE18rbo3
 lpJNcCUz+aOTPox/GcPepv3JrqQVdSt+Dk0vw+Q7OJ0FbdBrACiKTl1ri8htHPO315HI
 jKnK6lcjK+3Zg4brPWWuuTkohEjOZObrKOtWYLlJr686kr9+J/nSQ49u4d52zwGbKciX
 emEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725369339; x=1725974139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2LD41fBqc4MjqU6fbyBgu4Sh5uUK5vzOa4pB56KxVk=;
 b=TtU0zPGGvugasNVaJifa8wsbm1zzFZ9PQjxeZq9g5TxVKsFvKpo/a0ROZto4D5fD5Q
 W6kMYa88WQYGKQb7M6CedQIF8oGe8pqWOm0BV3D+r1wwJWXSDSezl8UHQKJKwpJo8mJX
 BkHk9EZYW1NIJrOH+G58UZ+kLImWF7jTGzdqRFFXAE9ciP+wlSuwhpf0Je3qtI6VDMVw
 ogq5vVWXwpcfPJrxHVKHeWqLEuoekQrp69jVLdHmC6uZygIjrUwz1MELIbx/tvpuA3XX
 Ch/wyMDhobx+06t/qb1SLGJibtQVTuZ6YFNJulUJrb4CQFL3q2GgtgB0OVlihJaj1inp
 Dxtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhx7lmElUc8Onb/bnknOldUOFQ9fKh4+K1wS6eyGTe8+2U5u5vUt+qRMoIrjBaHMkeRjrV404noI6+@nongnu.org
X-Gm-Message-State: AOJu0Yz8DERIWvIRZbMH1NCuZ9EdtfGutdttcyluVyWApOKNDoMuUrcm
 74EKPZifr2Ru4arZewY9NdPt501yfOwrK3k1nlKA82+ADrgniQ7n+DGt6oBMl9k=
X-Google-Smtp-Source: AGHT+IGJA9jOm8dKh0eYPl6ERpSkZ+8uzbyXP7VqnnhhWI9sureiIzSzpSdlvzmXPs1VAP4TemaKGw==
X-Received: by 2002:a05:6000:1143:b0:374:d25f:101 with SMTP id
 ffacd0b85a97d-374d25f0282mr2569257f8f.18.1725369338542; 
 Tue, 03 Sep 2024 06:15:38 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df954asm169945835e9.26.2024.09.03.06.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:15:38 -0700 (PDT)
Message-ID: <0388418e-ad94-43fa-a375-73cbff27a2e4@linaro.org>
Date: Tue, 3 Sep 2024 15:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm/i386: refactor kvm_arch_init and split it into
 smaller functions
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20240903113418.38475-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903113418.38475-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 13:34, Ani Sinha wrote:
> kvm_arch_init() enables a lot of vm capabilities. Refactor them into separate
> smaller functions. Energy MSR related operations also moved to its own
> function. There should be no functional impact.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 337 ++++++++++++++++++++++++++----------------
>   1 file changed, 211 insertions(+), 126 deletions(-)

Nice cleanup, however it would be easier to review as a series
of dumb "extract FOO function" patches instead of a single one.
Up to the maintainer.

