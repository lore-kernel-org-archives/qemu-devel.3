Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21314CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyTJ-0002eS-8U; Wed, 17 Sep 2025 16:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyTG-0002e8-PZ
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:09:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyTE-0001ez-K8
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:09:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7761bca481dso227522b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758139779; x=1758744579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tfV7JN+msozm4pVuYVOjGQCmHWF9O7TRkc+Saamin68=;
 b=v/GlrD2iSLGbJwN41DZU6NUIubjk6hebAGHxTb0dcOzS8Ad1FHDfCQKxaC5tq3KOaS
 MVzOeCHoA2AvYUDqy3GeIH4OmMGMT7YBeCU+NWyHAXwkBa3GL8qJAb/6ezePItkg5P1Q
 x4CqRcog8si80tT0ZSL1GK6av7bdrQbBFVDwf+eP3BW00jMR0wFDpc2zLmv0snm/2E52
 CSpKNldw0PAufx2jkHE8F6TCmT8xHKtkg8qLr9/qp0bqzr5lbxOL/8z+BGfQ3WD3sllz
 qF4YQ92Ltf7b0Wcx1+nXT5/Vq7+7JCJG7uRSl8CLatPK8frp/xMEoV7iCO12xggH8vJ+
 ArnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758139779; x=1758744579;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tfV7JN+msozm4pVuYVOjGQCmHWF9O7TRkc+Saamin68=;
 b=LBCLCuBnxtt/vvbPMXGLtWwDzMthm51ZBJLlxNLFEPipmBr8DnCr4grAxYpLMw4acM
 NsITmG6HorGxF9f0f1aZrcUF70CHOvVn3Y3ME6S268IFjWs3ZaOzW5n7LiuIfIYBOlix
 rOAm4mvNCdyXZj6Wn/1sRT4v1jqACpbQgAB3LTx1vHkvD5bo2cMA84CxYdJjWZZcIvi8
 IV2IAM2BplofwV/wRY8XY9I5u83vA+waS4X+yXzHOWyRHU3sqN64C/fKLVNKXTVWfQK8
 4lY/6u79m7FAmiqQFSw9HKyGGxEMVg2jyD7CCTPjElaxB/+Bpky8rlz+C//mySk/er5G
 4vYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgS9t5lR3/mp2IUoH5/IdmnJk2+yPBelYm2LDDykBGaM2zgFh7lYE6uqpb8O93jV2k0Eaa4DNE3U1T@nongnu.org
X-Gm-Message-State: AOJu0YwWAKTY55sHH/uBrLgT4CFlnUIZt3VInmDYMdTd9hAu6QAB6WDu
 GWM7jnrsSIovL+HI96RS6v34UmttrBNOQR5gBMdyKioePCouHJAeunbUlWQ0uoFI1BUFXN3+s9k
 3WEkW
X-Gm-Gg: ASbGncuPC5A0LUgA3MEvSWSwSZNPgPc5JZHLmSaPYTZHHYqy3B7QAq/JMqgmRYCiudN
 IHpig+E7vt1E+do86cI415GmHzlbhpflBZv3dZntRqZjWhNSH2s2zltQ15OHOHPcBQrOUFmR1Uu
 hNZYvEvOMfxc/UCjEGJ9UnlTmexQa0mUumi5B8anlalxv/TgIeX1DEaSK0UafAE5rYZTxAgVMrz
 lzFWVSUMiNdYK3BRUSu8/hYevk1YhOCJPwg+2IRK6EJlk9K2hQ/eTEzciNHEnTjiyTa4aQbhMLr
 6nDrsAee+HdvB7W0lLvZso5TjTCA8hGdWho8310HAerOpUCguhqrBo1YOOLqs/4zmbibVMlhhVt
 CpcN7J6eWrAURHaIIf26y01i4XzeFx4/Z7tYLe0yoYJL034A0Qe7IlJY=
X-Google-Smtp-Source: AGHT+IHhQQFXSSWpQoR+pxGATxlth5Tbeq47lgniZWLbt9MsvJiGd2D7LF6oRuiH758N4dzAh5lrPQ==
X-Received: by 2002:a05:6a00:2e16:b0:772:40ba:61c0 with SMTP id
 d2e1a72fcca58-77bf6dce9ddmr3463952b3a.5.1758139778702; 
 Wed, 17 Sep 2025 13:09:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfbb79b6fsm252437b3a.17.2025.09.17.13.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 13:09:37 -0700 (PDT)
Message-ID: <87455ffc-8b2b-486b-96ed-09be7a66482f@linaro.org>
Date: Wed, 17 Sep 2025 13:09:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/16/25 11:05, Peter Maydell wrote:
> Hi; here's an arm pullreq; various miscellaneous new features
> and bug fixes.
> 
> thanks
> -- PMM
> 
> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:
> 
>    Merge tag 'pull-tcg-20250905' ofhttps://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250916
> 
> for you to fetch changes up to aaf042299acf83919862c7d7dd5fc36acf4e0671:
> 
>    hw/usb/network: Remove hardcoded 0x40 prefix in STRING_ETHADDR response (2025-09-16 17:32:06 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * tests, scripts: Don't import print_function from __future__
>   * Implement FEAT_ATS1A
>   * Remove deprecated pxa CPU family
>   * arm/kvm: report registers we failed to set
>   * Expose SME registers to GDB via gdbstub
>   * linux-user/aarch64: Generate ESR signal records
>   * hw/arm/raspi4b: remove redundant check in raspi_add_memory_node
>   * hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation
>   * system: drop the -old-param option


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

