Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8672CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Nsx-0002SZ-VH; Mon, 13 Oct 2025 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8Nsx-0002SK-2F
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:07:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8Nsv-0000Zz-D8
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:07:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso3835728f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760382424; x=1760987224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGReayrHSYaTVPTGfVSCKVjz6qk2ujF1YrM+QI3d3/w=;
 b=dufYUyTKPRbYYDmwMnsYfNLISHMXNIhYzF6dJznZA/GEUzhJIsYDKYE/ZG3g9P9Ik+
 yicKsgtU0lH78eg/KRMionuHG7tFmq0120Yn6rnh2/nFnZMz9V6AMtK43M3l/fmVShol
 oN9D4yRxpvTPe/o37W+kNxtfpL+70/fVt1QdSUr8Ub0tXw/uzXQElPNOhvioefhcvkrH
 Fhoe0+6XSd5LwnrrgB+aYy2IvRhnEnORqoGmt6ZP3j6nGNo9Su6JwPd1nQObVsx82jtl
 vtNOeCgbfV1Xw1jN/FtyszYZQKEdGifRiueT4VvHTtQbMULBCr5MiUT2m8Fjzj13SjEk
 KT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760382424; x=1760987224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGReayrHSYaTVPTGfVSCKVjz6qk2ujF1YrM+QI3d3/w=;
 b=nGRY02ELB4LnbYxteuyhE97xJx2xGrzq7EMrszPRNcs5M7IrvswRCalRoxb4HNVdJE
 h04/1IbT1ttHMThx0uEF0FQ1X2HhpIKhjAo0/EDK+nypX16rGvaq29zIVUhtLFCPzim4
 d4ADC1i1q/8rrqWRureryt3HSb4dQAap5kL4Ixc+D4/OmO59vEgG86VmWpl7Ht19b9w9
 mj/uPfmnC/8zfjxQ4yIXj12LwY8PvCZIE/RDSPIF/24ukme2UzP96C1W/UeHPIoDEGPs
 eFDCjfKWrKBLsRZtJaQWB4euB6jeb9qVvogaQY0A0T1By/FqP87T48l/4Su6z3QXp2VJ
 Y/ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+NhpfJV1msfUCdL0mcUvSRNTtTD7A6Oz/R2sUG9onG0x/8jOJO1j6+UwsSJ4Qs4pi3/DCG/M8pG1@nongnu.org
X-Gm-Message-State: AOJu0YxweVEeENyKklg6uH/Jy3TlpOqBmelpC2K26e7ax3BKHv4Sj24p
 g+eb+67rRZ35zYXxmOyXPfCYcALx4eujT9gV7V8nWdNKWy7BOUDWnuhjzX3Ga3+oLd4=
X-Gm-Gg: ASbGncv8ngAbPxlrfN0EhPRU3xdN+c5LZISF81h73EzbrZ2oK3mBpoSpQnjZL8dHuHf
 BDf29FyQVCshW6htB2jPkOvdEvzig3CkS7ckiPvCcPbi9h7gMGlMAVw0eDxCpimW0YIxJC0FOju
 gRfFHEgJHG7ShbH5yvd8/Ly64lGr6b3GldiRR4HS4RlMj5PIvzZMZeljervwM8IzPD/22j6S47I
 jnovlLO7FAD+YQTpnkimmJa8HbQjQJx+8B0ajFUlcSaL0fN+ipgRgHeaGMgipETMSbnTcKb7Kmd
 bf42PPi6dPFNMEr5Br4ql+JtXLIsfxVAxpl01S+7NFfN2vHYm1bSk3W4hLlPVkwjWve5Ja1vjZ2
 hpUHRnk5PVqXOkAvJX+XE1rD4Cu5PVGaFerT2X8Zgxi5F7JoHFmtg+PF5GMEGIy3I0e0+01b5ux
 4xzCsW6B4d+UTUslQ2AYH1Xe8=
X-Google-Smtp-Source: AGHT+IFpXXEOVVap5qH/ysFmlg1lyuzEjPWV4RKaOILdjoUDOGWAloTjMygMhIvJl2vkBKaiB2HeEQ==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id
 ffacd0b85a97d-425829a5a12mr18700388f8f.3.1760382423631; 
 Mon, 13 Oct 2025 12:07:03 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482ba41sm200512545e9.4.2025.10.13.12.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:07:03 -0700 (PDT)
Message-ID: <89f61779-e078-4778-a8ef-d5a507c46f28@linaro.org>
Date: Mon, 13 Oct 2025 21:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] async: access bottom half flags with qatomic_read
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20251013162620.995747-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251013162620.995747-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 13/10/25 18:26, Paolo Bonzini wrote:
> Running test-aio-multithread under TSAN reveals data races on bh->flags.
> Because bottom halves may be scheduled or canceled asynchronously,
> without taking a lock, adjust aio_compute_bh_timeout() and aio_ctx_check()
> to use a relaxed read to access the flags.
> 
> Use an acquire load to ensure that anything that was written prior to
> qemu_bh_schedule() is visible.
> 
> Resolves: #2749
> Resolves: #851

Preferably using the full URL:
https://gitlab.com/qemu-project/qemu/-/issues/851
https://gitlab.com/qemu-project/qemu/-/issues/2749

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   util/async.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


