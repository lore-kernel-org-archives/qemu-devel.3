Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD76E6C610
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 07:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tINLh-0003HE-Db; Tue, 03 Dec 2024 02:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1tINLe-0003Gv-U7
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 02:29:30 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1tINLc-00018o-Sg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 02:29:30 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-724f0f6300aso5797369b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 23:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733210963; x=1733815763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Giach6L5tC8jPKtTQtHb9rZ/lQDlKVtlyEp/nTHH4Q=;
 b=RuGqDAR+stVdpGibX7pRh5kZARMaTM1/723uZ86IKMuhJP6J7+MLxbmW/gCPED/ZAv
 +iKcbR+cVh6OrJGZL92T3xyA6li6zY8o9lf1+TzXiCHzHMMU4RL5jSV5Kar4PXjjuJo8
 Vncg/5GbFFi8/RAqqTVIgRTrdQB6BIUGzs+lLm7XCi6GfxNkvwdBm/8sshs7yWrzoKDA
 VAfl6V2ZTJDAoO5Z/bMGNiL+uBg7CkG0+k0lBmI1GOfQXpMlIv2+kOcSrOFPJNC4fy3M
 GWA/EQXzaD0J+4IweS5h0uaN1eBBqofXTIFFzBWfVgVbzx6srQ2mAqXd73zWEJQfCiHz
 MlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733210963; x=1733815763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Giach6L5tC8jPKtTQtHb9rZ/lQDlKVtlyEp/nTHH4Q=;
 b=Q9cYjX/NHFzlBKdC7OJk3w3Mn5AIJOjI+rqQFHMb4bRagO5X0wRjOhQ7tgt7ZLku+Y
 RhnAoIxhtSgYM7DqWLTG/SHKm5P1w0c9C+4mHhqXt7f9yb5dSlzhSTO0RNKsL60ZFlVY
 t4Hzo47xY/rft6ah2b9CPV+9lFp34ZzHEYBZaNxOkDadP1xNVhOUawGj1GhrpZtxTEC5
 y2Iu/ScQBQ32iS7wteAxU7skXHVgonolBEv2xjjQalrWrq7xCj6JX5zkkn4gfy9yedxD
 ihBnV4xAitqedK/WE5De7pm3OJbg0+B4FbhjN8z0ArILaJA3sNSqcYvb0iXT/XiyqXj4
 CGVQ==
X-Gm-Message-State: AOJu0YzNGTGI1GIUHCCmXOM+TJGfYRj2yFsmOE1+46uHwpitb6EzTT3/
 lznc9Ecz+mNEHnEfxwWoL+c0AsKTPpBiWinUaP6JGAndb7/qy8LKLEa1x3LUxQQ=
X-Gm-Gg: ASbGncvaF6WZwrP1EOH4jxRiL+NtD37SAQRsb7RsE+ioMKyQcf7HWA+/yQfFRNM+7Ab
 yLBhEoC4sFogGvGqapNdX04uN0ciYlAC2hjVWrX+ZS4MtN85+zlTIpPOTOzGnjn3zrHHuZXxHAO
 5p/uKCPzCdjeJcpcUL6CRLKDDDPxt7J8+VcERcOtxa9wNpYhrHyFCDRQNZ9mZ93BAPdVqSc1UW6
 Z1ZykRkLPnjec70GUfawUgJXutSqpGQENkWwgLOfkGtx5XNtz32PcR8miXKvcYCbhRLKEz3Np1F
 Ow==
X-Google-Smtp-Source: AGHT+IG2NEakHcyC0DaerlubcQxF60YwmpRsERz0bQAX8/6/9G+l6ZZBFFFBwYegH/RB+O3ZvwZfxw==
X-Received: by 2002:a17:90b:2890:b0:2ee:c291:7674 with SMTP id
 98e67ed59e1d1-2ef011fb986mr2179850a91.14.1733210962810; 
 Mon, 02 Dec 2024 23:29:22 -0800 (PST)
Received: from [10.84.146.245] ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee9d371f1fsm4542583a91.20.2024.12.02.23.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 23:29:22 -0800 (PST)
Message-ID: <c07e7285-cb8c-4228-81bd-1703eb523d54@bytedance.com>
Date: Tue, 3 Dec 2024 15:29:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <Z061AeZRyw4jwWjd@intel.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
In-Reply-To: <Z061AeZRyw4jwWjd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.796,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Zhao，

Thank you for your message. I appreciate your willingness to help push 
this fix.

On 12/3/24 下午3:36, Zhao Liu wrote:
> Hi Chuang,
>
> Could I pick this fix in my later series (with another overflow fix)?
> I can help you push this fix forward :-).
>
> Regards,
> Zhao
>
> On Wed, Oct 09, 2024 at 11:56:38AM +0800, Chuang Xu wrote:
>> Date: Wed,  9 Oct 2024 11:56:38 +0800
>> From: Chuang Xu <xuchuangxclwt@bytedance.com>
>> Subject: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
>>   processors in the physical package
>> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
>>
>> When QEMU is started with:
>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>
>> On Intel platform:
>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>> logical processors in the physical package".
>>
>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>> CPUID.04H.EAX[31:26], which matches the expected result.
>>
>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>> integer too. Otherwise we may encounter unexpected results in guest.
>>
>> For example, when QEMU is started with CLI above and xtopology is disabled,
>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
>> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
>> as the result, even though threads-per-core should actually be 2.
>>
>> And on AMD platform:
>> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
>> result meets our expectation.
>>
>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
>> only for Intel platform to solve the unexpected result.
>>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

