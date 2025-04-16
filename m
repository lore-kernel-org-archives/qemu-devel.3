Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA9C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Ml-0001tn-VK; Wed, 16 Apr 2025 15:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u58Mj-0001tA-Cn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:24:09 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u58Mh-0007JY-LF
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:24:09 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af6a315b491so6294736a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831446; x=1745436246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H40+N+fQKmshn6EwwmzleyyX8/APVqIf2KhD3fCTk6s=;
 b=DCA3PRDcdgVEf9cIlnmu3kvvJLUeqxGMkMCeKYxuLK8CQO7TtBZZo88EsYzWp40c/E
 wjMK6Jj4Jp6mO8IXEFg5eP5N6Pkvf/FjzsOEQMA/mrZc5nUTX+VEyMtZ8wbGsZnd1Yba
 aYQm/4Im1z0Ayp7loZsKdWF5Y2mH2RFkWdhkSmE/0y5GkU28E8Ngv7+WYATr7MAH+389
 5/+I3ffIAQmjs8yY6+TNNNhSm8klrb2aieVlJ95uFh6EHgsAx2Cb3v/u3V5MxH/CeFS3
 JUPoAQQ/bR5dJs85S3aU9gXOATWv+HU3kfcyb3Wn8xcAaEykFrzXBb5ATOHYikuC1Zms
 rg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831446; x=1745436246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H40+N+fQKmshn6EwwmzleyyX8/APVqIf2KhD3fCTk6s=;
 b=araCmJ5s9OMKLQzPss2lzySqfA5LcChXTjibbRsqpnzMtE0I3Cy7Gi+vwI7ubOvgd+
 mC8CFhU+R3dokrr1oqSvriGyr2hmxODuf/R9EeSWlBKUbCIvmzlX3MTcMsULirveTwdG
 TDVsNb1AKxh9/RjiFgg/GjOC6ruq4W9W4Cjh/KjSsijIdatJ98vFUf/RpJkc1q11VHK/
 LT2YRJ0W78CUqpdE2JobvNPCD9RLXfLZzeMfA45Vu9qT6axf8hAUbmjQxr+qegU2vmo+
 D+ikjnHaTp1KqDQN5fRWMDAPpus71kux7X7wq/u8D4y799Uktobhry5ticwGbhVRD/L4
 NPJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQphvtEjwCKMnTkuWcnh2w+KQnZgx6UpKNfsJ5F2L/iTGftgrMRmxgz1sNjIWHD/Y80YqAqfDglpk@nongnu.org
X-Gm-Message-State: AOJu0YzOGpiI+Ku+6O/a4Bunpmbu52H9yRLXTC6YDDZQM9OlbKLk7vd5
 e41RoMc2lJpy6JAxzOtykrN/tJZV2rOJst8Ov1McbAO4UxoOj1ALlD6sIcC45dY=
X-Gm-Gg: ASbGncuU2PfcII/gan/n0KjgnN2+K+8psQeUvL+Kw44OyM8TEvN/lBLQh73pkWc2JXW
 HRBg12WTFH1fqEKUFFanpsfR2TBOLjZJ1GD5YaxuotqR/dQH5RT2MaeBAXI99gY7S6Xmkb/0NHO
 VphnxH8TXNSChNXeW6ydeCCJxQoelYgNvhrpJuCS2Vaf3P+0Bd8bnj7f0BW5CZM0gw+M2HktDi6
 qzgjNt9pu+J0pOljME7NkljlygvTeDLJ1oYM8VKOMQfp9fkZcciR/c/1gHLsXdon8tr93tMmk53
 BhGJ//xuPXFzNafaiSmVAjYMOORKG+odo3GHrYr2T8rnwxW65B25gs/ZSp0KOGgubAFsokY6Z4N
 KZ3JgqXc=
X-Google-Smtp-Source: AGHT+IE8L3mjO9jwXdTq9fGhT3jqIUdmcVv/drtOYZ1r2liYOnZanSYtVIzRfzsa+XQCvULVdyhfLQ==
X-Received: by 2002:a17:90b:268b:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-30863f18415mr6159982a91.12.1744831445699; 
 Wed, 16 Apr 2025 12:24:05 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30861212fffsm2010240a91.25.2025.04.16.12.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:24:05 -0700 (PDT)
Message-ID: <c0887bf9-e820-4897-91a6-d9439301301d@linaro.org>
Date: Wed, 16 Apr 2025 12:24:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 159/163] tcg: Remove INDEX_op_qemu_st8_*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-160-richard.henderson@linaro.org>
 <7e614948-f344-4cb1-ae0d-c645fcff562f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7e614948-f344-4cb1-ae0d-c645fcff562f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 4/15/25 23:55, Philippe Mathieu-Daudé wrote:
>> @@ -2457,7 +2457,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, 
>> TCGReg datahi,
>>       switch (memop & MO_SIZE) {
>>       case MO_8:
>> -        /* This is handled with constraints on INDEX_op_qemu_st8_i32. */
>> +        /* This is handled with constraints on INDEX_op_qemu_st_*_i32. */
> 
> "... handled with constraints on INDEX_op_qemu_st_i32."
> 
> Either INDEX_op_qemu_st_i32 or INDEX_op_qemu_st_*.

As of the next patch, just INDEX_op_qemu_st.  :-/

>> +        return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
> 
> )
> 
>> +                ? C_O0_I2(s, L)
>> +                : C_O0_I2(L, L));
> 
> (misplaced parenthesis)

No, it's not.


r~

