Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E135C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6bd-0002lU-F1; Wed, 30 Apr 2025 08:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6bU-0002gw-FH
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:31:56 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6bS-0000P1-EO
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:31:55 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4774ce422easo87466571cf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746016313; x=1746621113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYBrg3pEuxpPgVBHjS77kUjMrIuqMHY+Cf6oUjfem9s=;
 b=lz5RYW3wytHLoId+/Em4UQg4dlNrpC8vpjQxv0/hiALBl635LP+1GESYpVqPkHOdVk
 5oproy11wPE725PJvt4JjmZbL/Ub4xFq32FpTcu3FNZCgm+AP9fx4U6lMrT2OEJZcwSJ
 cReDWn4sNJsPg4Ks+Hgm3ZogZrIKr+mdivLxDMe3R2Y/9MW9NpuwJSvLGfNhAxpPadNw
 554I+iH5ITpBo5OLWZg8PHEib8UoRkZAb+dnXd+53YhnQHWgn2/PRMPuKOLVj1beOUpL
 KDswMZkjxz7L1jFlGzmo7D3p1wmgHzbJBtUSZyppkM+mx6yeO2cHv8XFJDzCzvcXGQ6U
 rfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746016313; x=1746621113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rYBrg3pEuxpPgVBHjS77kUjMrIuqMHY+Cf6oUjfem9s=;
 b=iHw0tRkZuxGO+EdxMuHh+5hBVNQY5Q9FN2pFzNW14HNSizn1losHpQg/j6L93HNqlY
 P8lM1JnRZMu9Zxo0I6WWA1M+UI0lkMh3zZK2GuTrp5Re3nTkkpldo925dqi9xLsGmh7F
 ka87PruR9EINsOSrluYEkiEUM66JUN39ZZAlTXCM33SQUPHqFEhpVllyADStgUTchG+j
 DOAJWNK82s9CxC/dz1BX8oC9eq0gYLisLcr0e5hJcm131eBd0w/fD9J2biPCFyDE2x7X
 oPNESZxDG/UhlPVRWIh7oZx79C2zXLmTqhIg+IHT2QKoMTM3lpjrCzR2JybJ9uVHMymD
 A1ow==
X-Gm-Message-State: AOJu0YxFrpkSwWlnG/wLVfKKhgH7QN4DX0sKthhZruYnFLSn6jdrZO0K
 6Q1l97HtjS7YS0dmxHGnR7nRjG8/KdPox+3cWD/+F4GzZ7SSHwF6wV40R2Gf8ng=
X-Gm-Gg: ASbGncvqJQ6OzYCbXqv0MKHQjcENg4l6mt+Ly/JQZdad6qq3GzK/XOG5UKDl1DTbFd+
 2jLx3WRr/Nj0ErMzVsRsYVHQmGWNsHxAg95gYvQCpy9EckrVDDRb36R8NTq2CMGCz1C0FfKx5bF
 FVs4iYOol/GT0e5m6NYpZZ7o8yfQTJUHCyipBchb5HKtdJFFQ+LKltWZ1ZOWu9mIRpoUZUStzRL
 qq/d+wRFH4Imq3jb35vbT1Wm19cDAbhMCNAqGo9M+H67a6Sd6sdr8zuC286nU6I6fgzPV/7tXy5
 /DOMYoBVdI3tHOIV1/WGPMaMlqjqqllichHU09OY1wBQ9SdcrYOpFw/Sr2f+J4557RtFUZqCUTS
 Ss44xunI8D88UlQ==
X-Google-Smtp-Source: AGHT+IHXs+MPlWfOmLU5JtKPaw77UJ+tjNI1qvAq/HPmfsvE4ZHdUDmHVprq2WxveaFfOZdkolWLWg==
X-Received: by 2002:a05:622a:4ac4:b0:476:b783:c946 with SMTP id
 d75a77b69052e-489e63d7f51mr40003051cf.33.1746016312713; 
 Wed, 30 Apr 2025 05:31:52 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea169304dsm91643971cf.54.2025.04.30.05.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 05:31:52 -0700 (PDT)
Message-ID: <83b80b4d-0ce1-4002-872e-1577527e88fa@linaro.org>
Date: Wed, 30 Apr 2025 14:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lvivier@redhat.com,
 farosas@suse.de, sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com
References: <20250429155621.2028198-1-nabihestefan@google.com>
 <87cyct3owr.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cyct3owr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x82b.google.com
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

Subject is missing. What about "tests/qtest/igb: Avoid misaligned access"?

On 30/4/25 12:49, Alex Bennée wrote:
> Nabih Estefan <nabihestefan@google.com> writes:
> 
>> v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
>> suggestion.

This comment is not useful in git history.

>>
>> ```
>> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
>> ```
>> Instead of straight casting the uint8_t array, we use memcpy to assure
>> alignment is correct against uint32_t and uint16_t.
> 
> Queued to testing/next, thanks.
> 


