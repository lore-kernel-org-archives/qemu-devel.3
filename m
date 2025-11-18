Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2554BCEDDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNoc-0000I7-VG; Tue, 18 Nov 2025 10:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLNoG-00007m-9Q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:40:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLNoC-0000do-Uq
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:39:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so33908115e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763480395; x=1764085195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIaPJOkiCscbOi9FWHBQY6vBO+RKlgUmve6DAtE3Y6w=;
 b=EGoFlzWr8NjvxhN/wyX+qc9zoSDbXM9tlvMoZU1aXzbf+hECer0WAhn3Vx2M0VaOoL
 30dFFb0KGNK+5J7WD7hwuNyEPjJEd/h2mcpsEd+t4t9sKCPXa/jEWWlj8QswGThG5ddS
 LWlMH7m8AcAkziMWU5L9EayWfM/QdumzQCvySz0pCWnwgDV20LLJMHWj6ei34mW5uBK8
 tLInlJNh34gvEvycvxyj2+EgUdJVrSMGRU2tLrD/zwI7Mu5ph/q/XcZ7E6or8VNUEMby
 nbx+Am97dnja1elN/B20SwXPCStPBPYj/41V3KbIbsIWe9jYMYX+S/Tst70nu7CIUYCe
 q27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763480395; x=1764085195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZIaPJOkiCscbOi9FWHBQY6vBO+RKlgUmve6DAtE3Y6w=;
 b=jQnkF1Fqvt8Wu+eVfVYFYhhzsW3NRd+ZYb+N0hC/5nL5Qjw/+UwkEvt0w1HEmVaaHp
 t+qlB9SjRjanZ8/YxaiDPCqBmWGbfqcoU+XvfpxkNeWvCY+xtUEj6G4CjD8jZSjVOEPY
 4XXhIfNKG9eqXTqe3DdbehNPNgg/qhMVR++H96/V4uOjzUW+p0nfG7TvnltmNOrm+rVz
 NFuKuE8Y65E8xPxIZxT+jP4sohadwxrJydeC95Qjn7xyW8lyCEIt/mbk0BnUnCB2cj4f
 enzei4VQzqz0+1Qb/6DwhJx/CVYEnEAZkR+kc0lxo6V6I+O66wfJUzpdhJPih5waPEEr
 oScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4VbC6sWZPB4TUF930vrkfbELeFZDblZPXQlqQBAODWgX1ZRRC2YJwRDAMFEye3us3pujzXIZakSG@nongnu.org
X-Gm-Message-State: AOJu0YzwONpmLNLR7vhB8+gnPs/aSHoodTL171F8h9Qt37kDZRmAa+YM
 9Pkf/VtBFhTkxePyLDT+EOPeJ6rdQy0w4kWjPnu/HMBrSk0RoE/4N627KwxPel5s2Ag=
X-Gm-Gg: ASbGncvph1gn547UTuXj6NZU6DaW5vZ7YkBLcc+mNWMTR1mTqyUlkQ07dj9adT6wagK
 zxQc4CiKrI5pquX5MUapL9hXajCD5kjyG6sDBZDiIwF8Qqg6Q4ivDFP5ljP9PMgUW+TK8yNlKLs
 4goxupELUKgNiCD5zKUOAg4TL26XGwt6fOkj5kU7QfJ5Y45j8HGvD7kr+ONTIfhb/ltM/7KAdG5
 hyDB1ICKc8cUlYaAQo9ucJwfqnxkUAV0kvv8g7enl0OjMbGGwQIvcsb6qMMrDRdIWOUfX+Dz+UR
 nXas2qUDvFvPhkFKjAjdGAX2bsQCJrwgehMe6sxC9qtslCzZ4sH4kqWbFNi4fAWcRfNo4rIUrER
 qnDU/jsxKEALf4RQipqc8XIzddo9+l/soXmpZnuVc5CC1//haY5MCO0aS/NccEa7l/ifx0wzyxp
 qggnt71L/3rMFNbqeL1DY71AEU/Urvp56NF+wLiUK/JbuaU/F+kNNrog==
X-Google-Smtp-Source: AGHT+IFu+LpAqVRFmjhUCJyUApBR6+QFsIbzdydlh1IJ054bBkYEsKp8vD6lgtm1gcqTXQ/130BqfA==
X-Received: by 2002:a05:600c:b85:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4778feb151emr157209215e9.34.1763480395123; 
 Tue, 18 Nov 2025 07:39:55 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477975022ecsm209920935e9.4.2025.11.18.07.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 07:39:54 -0800 (PST)
Message-ID: <322d40f9-7c21-414b-a038-9a36b679f684@linaro.org>
Date: Tue, 18 Nov 2025 16:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/loongarch: Fix some TLB flush issues
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251009025932.2990219-1-maobibo@loongson.cn>
 <f1b8c890-0857-d1ba-ef43-26981c54c241@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f1b8c890-0857-d1ba-ef43-26981c54c241@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/10/25 12:01, gaosong wrote:
> 在 2025/10/9 上午10:59, Bibo Mao 写道:
>> There are two problems with TLB flush, one is that loongArch TLB entry
>> should be invalidated with different ASID, the other is global TLB entry
>> should be skippped when calculating replaced TLB entry.
>>
>> With these two patches, it improves VM boot time also. VM boot time from
>> generic qcow file reduces to 300 seconds from previous 600 seconds.
>>
>> Bibo Mao (2):
>>    target/loongarch: Add missing TLB flush with different asid
>>    target/loongarch: Skip global TLB when calculating replaced TLB
>>
>>   target/loongarch/tcg/tlb_helper.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>>
>> base-commit: 37ad0e48e9fd58b170abbf31c18a994346f62ed7
> Reviewed-by: Song Gao <gaosong@loongson.cn>

Merged as 2e9ff01a912 & f72848e31fb.

