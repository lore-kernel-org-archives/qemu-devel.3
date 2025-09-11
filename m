Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2B2CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwm51-00028U-UF; Thu, 11 Sep 2025 14:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwm4B-0001bh-2b
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:30:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwm48-0007Lm-EY
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:30:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45decc9e83eso9822185e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757615435; x=1758220235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xd6XaDYT0WdSg/M97tLW+2AqgiOlqQ1VEz6hpdxUHm8=;
 b=nFyUYRZLjGyQ8iQZftcLHBfE2DjhG4rVBqorWEfU2/NBfhdT2QmL4k2q5j/y4KrEcl
 gZV+drgJrLyXwro3gMNHvFNa0yPCtc6iPO2vfutuqN87xSyU6eucUh/FDEUj6aJjXG5r
 lp64+myPfOdaAV0lO+TA64OHVgrQjGq4z3PotQGIe2k8Tt88c2xovmfkE/XlHOHP5SXQ
 Rz+eM3gHesnl3Miggk5mXhe8JtUPIE60BAKcdyVX8DUnmUf24mVAT3IejGJ3IfoWND/V
 S4tTKKepUwIUn4jYJcSV4SNY75jz/BDlckfB7/2A7VeRx/7ZBJbnGx+56C47tpO9RTVo
 Ek9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757615435; x=1758220235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xd6XaDYT0WdSg/M97tLW+2AqgiOlqQ1VEz6hpdxUHm8=;
 b=DMZdAc9A91iz7Mu+x1iffs0aTfvGniOxjoKANjz08X7tLp9pXDwdkodeE39UvvWizi
 LqSUARZ7fJmLDI+unKRwCPu2SpbA2Rou9eY2y4oXJU+Eu/H++eO11pXInVArgp9rw8fx
 WEwzNh0wYHfXDIOgaljtuJA58TvWiynVhvDaZ421868BO3Cei+Vhj7WmMZsN+NJ7hNeg
 T+dWLUkWwpHOsErut70YRBuZrTzGv/B/9LurwYE7aCMGhF95p/kAvk85F6m8Kelx/gVn
 BTY7eu9V6khvzsf1WlrUrfL92F3UCK/VurDi22nJcwfImBT2FPsKPR64Rr5qxfCkBKNP
 pEhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyjrzLt1WJOZfGuslF0ok42EbxI6mVW3mHbGRpFtDfI+I68IGXvqiJ54dWu8CMTrFZ6683WWeZMRUu@nongnu.org
X-Gm-Message-State: AOJu0YyQBzHnhx6B8CJ4C0yBph3y1ibNa0MSYLESzVQqAzZ3SSdQkVsN
 rPiDXtW07omOhjsur3R57thGVvlIgI/f33deEFPN3Co/F/IMGih7EH2JZKt92nNsTes=
X-Gm-Gg: ASbGncuiGqog1nHEStLQW8ksRGe7ohq7EIm4XasJ+y4KiI6U6hcuxVbOeFpzXv1DIWN
 zLRDEkdV9RdZcYxkLcP8u+4SRANL0FWv5idLy+lUpUvmF83tCah4b9dBCa4ymkGbUoadjqYxtjl
 gCjTENkxa/A154AcRVmqJFFLVB/hBFvVFShuDOvP3pC8PVvpWf7i1fRNkzPwaE5J1p+Cr+UHXib
 mgHkoSr3q/3rWZMQNdT0xwAc+FN2RoV7xUUlGqp8kmC36tUG36RF9ki2SiqvRQLRPgam9G/bmdY
 IOujwiYJ9UumqBMOpI9OCZFl1VlBiLR/W0pKRR1fa9W3EAlRXEi0baHAYcJBxh+JbWTuDP6N8Z/
 TlWb5ZGV1qiukZgxoccNxRhx0jKmCTLaJtuqrR166pV5GP/x7t73jmCg22BBlbXgRGl9t
X-Google-Smtp-Source: AGHT+IHif9JZ193Qkx9GbmAVoffwrUcePmf96v6VHN97P45gZNPsNodLr12Rk4aVLhUO3IkHS7724Q==
X-Received: by 2002:a05:6000:2dc7:b0:3cb:285f:8d9c with SMTP id
 ffacd0b85a97d-3e765a48a8dmr252232f8f.48.1757615435204; 
 Thu, 11 Sep 2025 11:30:35 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760776badsm3472160f8f.5.2025.09.11.11.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:30:34 -0700 (PDT)
Message-ID: <3791c8ff-fcf5-4312-b6dc-c7ff172f7f8d@linaro.org>
Date: Thu, 11 Sep 2025 18:30:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The different ways QEMU logs stuff
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>
References: <87bjnhgpg8.fsf@pond.sub.org>
 <2ae622b3-4210-494e-95a3-cc20219779a7@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2ae622b3-4210-494e-95a3-cc20219779a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/11/25 14:49, Paolo Bonzini wrote:
>>    -d tid further splits per thread.
>>
>>    Splitting per thread feels fairly redundant once the prefix includes
>>    the thread name.  Thread names is easier to make sense of than numeric
>>    thread IDs in the split filenames.
> 
> https://lore.kernel.org/all/20220417183019.755276-1-richard.henderson@linaro.org/ says 
> "this can be extremely helpful in debugging user-only threads".

Compare strace -ff.


r~

