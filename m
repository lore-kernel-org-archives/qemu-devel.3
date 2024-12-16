Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7488E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFIO-00060B-5H; Mon, 16 Dec 2024 12:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFIM-0005yz-3I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:54:14 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFIJ-00060E-UH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:54:13 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so3782235b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734371650; x=1734976450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZPVmaTLi/NXOPHD2eYOsDNHzLYJc7pfU0IKCdHzZec=;
 b=TXg+9k/5VzgcANhRNcwtj13Ry6G2HYaW+6DfLhrEwZMgx3BBIO8cyi3Nc2oLmTkkxc
 8UifGaZqcpCdThmMQJGFupPCbdZeJwznPnxmUuJ6v0WSZEiy3zJFs63YlMSoxgSgSUUj
 n1fKCOMx3dWLHcP20w9IOzJmPBS184Kk11A9fMoqb3nayF/qOMUapoSuukDPfCqosVzu
 YppuXj8cfBdcZWOGJg2TISG4G2gSau+ZN+H6s1Pw5yswUjwTOQlP2KF5r2TlmI1W2gyA
 1reJHPq0XXZHLDSvHFtPxqGg0OFGYYi+BO1oEz5lWmT2hBVhaiM03LhOuuGS/h5uQuTS
 3LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371650; x=1734976450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AZPVmaTLi/NXOPHD2eYOsDNHzLYJc7pfU0IKCdHzZec=;
 b=rksq2m4bUt0EJ0apQTot+IPAidXLIrfRQEK8y+LajMmkSUOvKd9HraJyy3cWiMPrgK
 67fT8ZEFQX/yudQLnonUfjIYzK9H92jXx4pr8pK2W2dwJ09IoerQnYbQDMgm/r+EqQiN
 pSWtWyrUtB7fYkfTZ79ZG9nxE2Zd0O3yBG089pCiSeokBXB+Jrs3BO+lb25T1ZZKUnBz
 LSrBJ9DEkDimk1Ns9pIY5+hDhZu6h1BwYTodbI7XCNF90XTFbZGZOCNeseSg0Ik2Gwpj
 EP94wnI1acrnNh575khXpMNoEfiBRHYqdXQkqBY2XmK2O4rT6uvIhpugjbGS80xX+9x0
 YgmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj9P+3dO+MqVuSSH93pTFSQ/2E7fcyCuUXYMz9HMh6QfKmBDsQX7lsqkQY8zR84AtV6wG95Ho9Hoai@nongnu.org
X-Gm-Message-State: AOJu0Yy2ZQ7uV5LLa57vKXpwEHENxucX0jYNF5cpCBy9QVB0fXSvYyvG
 cG5rUxMSLcp+1+QOFAA8Yt113jmHIM6ZAHKvHorN07G+kCKmtH0p6s08QO3U7Ao=
X-Gm-Gg: ASbGncuAoyrkFTkw3OYrA866Q8vBqgxdzzq3ic24sIrt0XpoKihHkLsRAbjBtDLQO6h
 WrqXWm8bgUy/KXrDp8kJ6kZca2hQrsJ2CScOVMSX7iFpLQA5C8QR0ZIYnsQdydTo5x9JVt2FzlZ
 TFtDnoM+WcLw+6yNg2aLf1EL/nv5N+s0oIvYVqC6BNG8dElhMc37olSRQP1deijbYMxcQi3vcwx
 u1dF4khXxu0OscciYzp4OFmAcQfuBy464wHGjd0g3U3GgQnG5sh0TQbSxc4z78GIfpqugy7nTkW
 PSKReF8ateSpgz8O7u7VA7teletA
X-Google-Smtp-Source: AGHT+IFvnXtX1HSGUGNsvXnm5m3zPJQhx/+gY6Ig/8e65vdYMUWzWxZrx2+t6E+V4O05DgXB/OQuGw==
X-Received: by 2002:a05:6a21:3985:b0:1e1:a68b:104a with SMTP id
 adf61e73a8af0-1e1dfea30fdmr18822523637.42.1734371650416; 
 Mon, 16 Dec 2024 09:54:10 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcf31bsm5200982b3a.186.2024.12.16.09.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 09:54:09 -0800 (PST)
Message-ID: <a557089d-48d4-44c6-ae57-84ec3b197450@linaro.org>
Date: Mon, 16 Dec 2024 09:54:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins: optimize cpu_index code generation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241128213843.1023080-1-pierrick.bouvier@linaro.org>
 <56210680-d6db-4618-92d3-60af0c999241@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <56210680-d6db-4618-92d3-60af0c999241@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Hi Richard,

On 11/29/24 05:29, Richard Henderson wrote:
> On 11/28/24 15:38, Pierrick Bouvier wrote:
>> When running with a single vcpu, we can return a constant instead of a
>> load when accessing cpu_index.
>> A side effect is that all tcg operations using it are optimized, most
>> notably scoreboard access.
>> When running a simple loop in user-mode, the speedup is around 20%.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>>
>> ---
>>
>> v2:
>> - no need to do a flush, as user-mode already does it when spawning a
>>     second cpu (to honor CF_PARALLEL flags).
>> - change condition detection to use CF_PARALLEL instead
>> ---
>>    accel/tcg/plugin-gen.c | 9 +++++++++
>>    1 file changed, 9 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

any chance you could pull that as part of one of your series?

Thanks,
Pierrick

