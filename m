Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E447C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAv98-0007K8-PC; Sun, 27 Sep 2026 16:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAv96-0007K0-EK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:06:48 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAv94-00032b-PI
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:06:48 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso1155173b3a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790539605; x=1791144405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kci4gT8yqF7ZsQJHmqhQIZ++Tsmg9GXry8ZQUrfrDpA=;
 b=YEKxN+1coNBzoMCCI+vDLAsQORDqM6EwHHosJ5Nlhfqy38OylrHelEI1KZv9VOtuQo
 EnA6Lgwgs9drXo291Wq9ST4UUWgUR5uzO7Q3DZ9wLLK5jPfQxv11z6Qgy5S93CRJnxqq
 dBqgbpTZnlyWHsVBULWzrD3dOEt+eilYzxiamG9CEcxiNPnt3OAjsJwl50hcV5Q7gt+m
 MgfdmE6TJRlST44KguhwA9pBUgIB6ZCZqDEwrP5Af0oVfkjWooa1lvvN4hIuhIBvITL+
 d+s2wmg7XAW+geWgZ/+HW2SUhY/eGOIBKsMlCh6Rz2F0HwQM0Bmo0AMfsMQKRvVwBBEt
 RMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790539605; x=1791144405;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kci4gT8yqF7ZsQJHmqhQIZ++Tsmg9GXry8ZQUrfrDpA=;
 b=qZ/3FVSeazIlYhrCVSn6PATSGcUSCHnEtqCbu/VmHLQbgSzo32wqfmGS5auE+A0g3a
 pqb69R0nubf1LwE/uEmZxRjQUobVl/D7ICj1f3dThiZE7wAtZOcfSTdtKV4W8W78UNaH
 Q0DBPNsPUr/g08yQGptBg9T9l890lGLAxZO0km6XUXk+O+PHjf6lYyElZWz3c+qzVemm
 qdpFTvqknevt8cUOtuukoKiGLAVgIJ+DC4XJO7ScMZJvxO9fISaGbYGPO+uLi0GymQnl
 ZBspxxni4c7YBusiXZihJ7QfJdunJ8M4tuf5MhqIEvLYMmXL9TFeAS1iwZv//N1ZGAKo
 PUrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjZB02pUjS6GPDastKuZKEY0qBGL1GvcEBiIguXG5b0GMagszwsUq75ucBt0Ww6XO2jbAUXnNhMmnZ@nongnu.org
X-Gm-Message-State: AFq9FYJCNZ5Dsj8GdwREQUs/Szu93j4Fa+vFbEQgZLTgQhQhzn7q/w7m
 N5+WJDk7Oz4zMO60bbZvNwQI7XyeQabjecNubDG6gajHry5xFw1D1yKGxcoeIrwiW7M=
X-Gm-Gg: AYBFou1zCiXO00vQN+YfYAK6csmWs/hplirDOcsRQe8eoJwduG64a72lYxlZonL3bcQ
 1gdnUXjDfGKIexwiccrQ3HYvH5BkiympsM6hUCUT6eHbslcvQ04Psjd7EO2wjffmHQgAiB1h3ol
 Enss+VZLs82GPIWsI4FuSIHrEf1IAkCI3N2HLhvGnlbZjzCiHs7Voi6WkldV0LTCPdPGzpSSkaC
 Z8hsq1HwBSUTAIhx/1tIkYIA0qRxtbWd6CI7gJdnfstpMpaIZ/YZ2ygu/qPHgrqhousc+Q7zLGR
 xS7YpGLL1WrHJ2oFcqKRHOaA/i8i5iUjScLS0kVDDHlGRuRvKG0lf+rtYQEGOl3yMwpez7y1+m2
 xPC6N9hvA/92e6+llOwQIk9B1nr59qNhy3D8Vrgr7HqkZhhspnWD6sHY0Rjg+4rRv9xV9fhceFq
 rAwCCkbhFQa9T/nVQsTZ2oKBxRdGiG4eWUE6Y6QiBxCrKlAY1O8Vcj9F3saaIC9CqUzy5edZaOP
 msby/YWj3WjjzufjK3xYqPK7BRXx7wnv7iPAPBnvA==
X-Received: by 2002:a05:6a00:6c82:b0:882:157d:95c3 with SMTP id
 d2e1a72fcca58-882157da59bmr2408382b3a.32.1790539604556; 
 Sun, 27 Sep 2026 13:06:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fe82ec348sm3218681b3a.1.2026.09.27.13.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 13:06:42 -0700 (PDT)
Message-ID: <e7d81b7f-e46a-4613-b4c6-f78092c22678@linaro.org>
Date: Sun, 27 Sep 2026 13:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Misc HW patches for 2026-09-27
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/27/26 00:31, Philippe Mathieu-Daudé wrote:
> The following changes since commit efa3b9d5ac8024078225e1ab434411fdfe53b457:
> 
>    Merge tag 'pbouvier/pr/tcg-tests-20260925' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-09-25 11:52:47 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20260927
> 
> for you to fetch changes up to 8b395deb9475ca669f4ad62dd01d3ea66fdeea13:
> 
>    target-info: add multi-target test binary (2026-09-27 09:30:12 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Improve QDev documentation
> - Remove non-32-bit CPUs on ISA/PC machine
> - MacIO and BCM2835 CPRMAN fixes
> - New multi-target test binary

Applied, thanks.

r~

