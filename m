Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DADCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1T71-0006Ay-3h; Wed, 24 Sep 2025 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1T6P-000608-Nq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:16:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1T6D-00025F-OA
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:16:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77d94c6562fso78466b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758734168; x=1759338968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zepJzZ7ladgk5LMTrEwxYr/wsDP9Vl4wLTK8+luEFSg=;
 b=Vz9gRC1xTxkh09zbmojw0FWWhPwA+w4T3D9fEP7qDIsLwkxsFdrmowtTdI7+BTYgcN
 scuS/PZG6fLaj1mjXJkfBdVr420+owx7l3G7axE58JzQdbw/+9BU9jxPgx8D4nguRxnF
 pG6Kd8CLw1DqQED+wd9LhBlM0aEJr/1sP2T6AcOfKjWbUQDVWk57cDYb4VosL6HgGnTm
 nQPOFSAo+6UGGAjLLCBEuVYjNonMJxyZsjKWFTj5Lwb9naZ1a4VYAvWFxXS6h5l0ofXb
 z2GnJG7/BL06sqLHrOyn69WUSMm5cLvAWul2Cb6vKwYzZ5oS8CJ59NWJqH4a21yG+XSc
 ukeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758734168; x=1759338968;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zepJzZ7ladgk5LMTrEwxYr/wsDP9Vl4wLTK8+luEFSg=;
 b=kR+PRRw60556TG4PK/Nly2dUNnH4Gv3hrBlFvcGhnpj4z5ky7W6y94wQp6lEqnQjU1
 nicXSpiHZttVCNBxovLFm2k60zW6NlTavxkcZBA7lItMW9SkOIG6gLAMPvQwPtYQ95Uw
 ChUbz61jbBg0PEpi2cB+2vUaNSszHoxoIiGA+G3XpdS1BmNupf+b6FhcNMwU5MIC+IjU
 z7bVD6aV2rrDpgnAuvZYFCxx64RwOcQSNI8uf+mTXnBwezOYrSfa9CmnD2PNG/n3YRtj
 M5Mqs/hhkqtV4kPdaJnDCDW9YLmDlCO+oqSLnjG7/YtqvuJ//96Y06qpsiHxm5PubnTf
 RVjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4yS9DBJ84T/QiluUU5sJ8uFt3BDpR7CHSXysH1Jp6Y/esNF4fZDkltqs4Im+RmKKKGjYEIcbU6JzQ@nongnu.org
X-Gm-Message-State: AOJu0Yz4p4EyJq29h8x0ZVTocExKg01P+RtO9rxlH4wKlKIP3czRF2+4
 b2aTjnwVHraibXp5WM8RmIcYVQUke3ZwBBK+NYKT19LYMIl9s3sviuFJcvqPaqMoCIU=
X-Gm-Gg: ASbGnctwFuEzJGm7S3XsJn0SFGs3B3/yQibnTAY3DYoe7BY9vkSQC8neWJn4/jtb8bP
 7IftpOrmx73Hp+gYXdJiseqLTtzSQk10ANaBx+CJBK/mZU+b9ySmaZDHsplOpG3giPTZPE6n4Uz
 2YTPvxzMKJB8B+kp19qhykq6T/oepUqqQ8PhVdfn2+TRrsi+4M5MTph9DfMYS4psrSGBwvcfSLV
 UWQiemooKedrZ9JLyASd1TfGzqZixkSm0pC9LgdpeVUmaKwsQwl4xqHGyPrvbogByi48BLguO9v
 PBISHXtOUivJiiHFveiw24/BP2MuEOZBJQXIqzoXe9HP9hjoklnCQla7z5tdkeEbAD6hBXRaOYt
 9b1e64joOlrk8cP3A3p5b6k4oXZ8A9jmrbPpx
X-Google-Smtp-Source: AGHT+IE0B54BvZ7ix4ofa+I0yolUHFpSOb4yJ/dqo13pmD/+tQKGm2dWyQnFw21dtRq6Hf1nQ2/AAg==
X-Received: by 2002:a05:6a20:6a04:b0:2e6:dc0:f835 with SMTP id
 adf61e73a8af0-2e7c5089debmr535991637.14.1758734168170; 
 Wed, 24 Sep 2025 10:16:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5541f0374csm9988209a12.49.2025.09.24.10.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:16:07 -0700 (PDT)
Message-ID: <fb59bbf0-56cb-46c4-8c0a-349c27345332@linaro.org>
Date: Wed, 24 Sep 2025 10:16:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Remove dead mmap_unlock() call in
 invalidate_phys_page_range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250924164824.51971-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924164824.51971-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/24/25 09:48, Philippe Mathieu-Daudé wrote:
> Since commit a97d5d2c8be ("accel/tcg: Use interval tree for TBs in
> user-only mode") this code is guarded with #ifdef'ry and only build
> for system emulation where mmap_unlock() is meaningless. Remove the
> call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued.

r~

> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 0048316f99a..913dbea6d24 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1154,7 +1154,6 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
>           page_collection_unlock(pages);
>           /* Force execution of one insn next time.  */
>           cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
> -        mmap_unlock();
>           cpu_loop_exit_noexc(cpu);
>       }
>   }


