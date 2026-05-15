Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4ECCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtaR-0000Hw-MQ; Fri, 15 May 2026 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtaA-0000EW-Fp
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:32:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNta8-0003JN-Pl
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:32:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so7927415e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855523; x=1779460323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtyRfEg0ttR0bdwcOABvR/6hIat/MC3GjjR3PsW6nH0=;
 b=yYwAwxMV5VAzcKPEOPk7UVH2TCLWeokpKTYdK9zXjlFugCzRIkoEog/f9PqwGqBh8m
 9uYqLiKGgk9CiSGLAwUD+wI1yHKmiMu9NkBLYHR02o6xrb0DwBsj91kwKaY+p8hTLw0S
 f0Ha8bp0/Gi/LgXuRQ2i2TNLDXGj+sopHMuxhVh6LR1WWMxm2T9S8AC+s8a/ahn9Xkim
 H2OcKHQZOY0Q2IxWG2DbOxB/jJ9GoQ7bz6q4/DYBywf7uQ1EK/e3WcDSYjKYq4uPpWPm
 g3n2FbXeORM35u1ao4HUQ78oYzdyDzsdQgTQzily7Sc/+JbF/HKqUzu48j3Is1G2PTi3
 pB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855523; x=1779460323;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZtyRfEg0ttR0bdwcOABvR/6hIat/MC3GjjR3PsW6nH0=;
 b=KRiF2uFaNnNNRvgXkkR/YVVXGVrCcef4FXMRKLVNoME5RCghJH2vX7LiDkEQhzQS1T
 AIU9c9b+aVnQqwIwjehBDiA6+tJDlhVAaGsz1qO1DjY1SP609SxV28HA1vHv/t+dppNA
 UJTk/KadZMUuns+wMMZ0U9uAhIlYnAqFyL8/yz6WtF7VK6JqSy8CnVWSIdLMT9bHklAb
 SlNpqLWLOzk23YAEF/ZSjancujhuHAfGJCmWNTcuOzfHSv6Z+gtMxF+sSzIqy9NTcHcj
 9yk4q9ZzRTwPI7rKO5Z39fupxWs34b71F1ytuYd1zC9WT1/kxTZ6KJeXAYS9kTUAB4TW
 j2DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M9cOxaEsMolU1tXA6PpR53LKhRUetuCegEJ8NT1CD/WiOAbnuuoY8kdwcaYY7AYNJmDKNttKAHYli@nongnu.org
X-Gm-Message-State: AOJu0YwUkc1R987DasNpv0cYaGRNhr9CFlQbZLy8C8mmR7OykCb2ZHBm
 hdpKIxxDES8ldIz2moadJ3xq7gKDGVTyL4w+lfrXLQBkcPguewCOJEnLRnVWLTW1Pwc=
X-Gm-Gg: Acq92OFbcb7xjR8VUIlfLwQeu2qlZc1vDKx2JubV6AV1xuKPQ2e9nvWjm2MhDrn7BRq
 M0P8fMY5Kceu7ADQDyxX5722qdjtluaghtl+p7SnMBWbyMw1jE1B2wum5hbB+LhhHfmh7KjMELv
 1HY57onIvc38tj4rNoKq7kutpHRypAavBSHIEtqfzxRm0amVzQuyTpEaXUycILMElYiEdFQJQeU
 2WcRt/2w/SidHmhbrXpFlEYbJx8AitP2hwfbXkklQNgbMOmJW12z6DANJ8yEAocRimGi295dY/Y
 g4ytAe1YMv0l/HMUJA1d0vtQEQEUD3A52TDcioZSnU3q2ylhblN96QNWEVS6gIU/1PzWcgli1Ep
 HLZfH/wllMv1ebUTeHKJhP1ebwJVLNXcDLmZnDtEyDtRXinMdezCPVN/hoXLHTFPZNzpsgLmYY3
 iDPz2nMkTZZZLqKzm1CeurkW64YX+8eSmewGTgm0XsVvzG1gSlE3xH8fxaKy8u0u8I8w==
X-Received: by 2002:a05:600c:1914:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-48fe4dac5efmr57126435e9.4.1778855522527; 
 Fri, 15 May 2026 07:32:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe5821fsm15087125e9.14.2026.05.15.07.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:32:01 -0700 (PDT)
Message-ID: <9da789f9-c06a-4551-99f4-891f8c28e87d@linaro.org>
Date: Fri, 15 May 2026 16:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] target/arm/ptw: Flip sense of get_phys_addr*
 function return values
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/5/26 16:25, Peter Maydell wrote:
> This patchset changes all the get_phys_addr* functions in the arm
> page-table-walk code so that instead of "return true on translation
> failure, false on success" they are "return true on success, false on
> failure". This convention seems more intuitive and it matches the
> sense we use for the translate_for_debug and tlb_fill_align methods.
> 
> I've marked it RFC for two reasons:
> (1) I'm on the fence about whether the upheaval is worth it; I
> think on balance yes, especially now I've done the work, but
> you could argue the other way
> (2) I'm open to suggestions of whether the patchset could
> be better structured for review
> 
> On point 2: I opted to convert one function at a time, on the theory
> that you can then review each patch by checking (a) are all the
> function's callsites updated to invert the sense of the return value
> (b) do all the "return" statements in the function change.  It does
> mean that the patchset has a lot of places where we add a "!" logical
> NOT and then remove it again at a later point in the patchset.

FWIW this is exactly how I'd have structured it, to feel safe and be
able to test each step (ensuring bisectability).

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


