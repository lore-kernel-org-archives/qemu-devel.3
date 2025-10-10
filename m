Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B19CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7JGD-0006EQ-6q; Fri, 10 Oct 2025 15:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v7JGB-0006Dz-04
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:58:39 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v7JG8-0003yX-1M
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:58:38 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27c369f898fso32073935ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760126311; x=1760731111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ezQXHmK3CVnORIMCouSwK6LFYXNCn8yTI+4Kja1cVVw=;
 b=K3Yd5ReBe/cnaUlsczRxAY0ILbtzseNV3prx64kXa1jWKiiwFmhZw1ZmylLnLM8A4j
 aWFiQxWfwu01FgJ0njfNlyHePFeFIvAwc+Y4WNKOM2pz/vvKII/Po+M4/jfMR41A6+ge
 r6ZTjxWKcFfRWmJPzaYcM/VVfrcO9/NMb3eZz6rJpTwXKfRX9rhYnhQgAsRV9MKVxzgi
 jznlvBsAKYfiop2yPq1Jae5kKf235+MVkf+osFvN1psd+9j6uPOrEuLw7/PMm5uN3T/E
 1U5V3HXPuHe6Poc4x8CuOJQkzILbBoedBQCA18Ud7mxF+0gdjid1S/tTN2rp7ly4ha+I
 NtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760126311; x=1760731111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezQXHmK3CVnORIMCouSwK6LFYXNCn8yTI+4Kja1cVVw=;
 b=ox1E6QHrwztYMNaVD6PAgAj8CuANom6ttNf4EbJ6CNjhmJWM/8ed1vFL0fEujzXFPr
 6+IGd+HLVrpONOul66HQRCc7/tIVht1H9cPCKCva7yZbRPjoUhTmlFQGM6NASUa1AUG5
 K71Upm1hwkj2Lz+1lg5UqFNfQLW8tS1tYdUKO8nCqt0qc7Iy4vkGEqJaKMPFyKgeCxAk
 Zg1BuoAFW1UFVFRUpaDtZhIiDYQKP6NQ77HCeCEs23Kh1gzpGdiVKguMvZDeu/kzMthy
 dTNYrzVkmPEjoXpM16YMZiU27eghC4vVrTwQMxvILbDamaQeHOGpO13C2dZrsTzeAuYu
 Xm3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXUPTawG9AIjnU9itum/3EUdNXg5b8rAWEpGCTdlAqkHa3g1MTifW0m7EmqPmHt6kdyKCIWa/5WdZQ@nongnu.org
X-Gm-Message-State: AOJu0YxSGaWdkvbS23j+KFGoQGmje99b0eK2IyXT9rkZJPZauC8UUUeh
 0kf7MRLwp5UyHt7c7Xeen3aHap3EesXYq0Kz04qnUcCG3UWD5ZOi3ZOvVMPgNrXJ7GM=
X-Gm-Gg: ASbGncvw3DifnnW49NHtLHVkdMKmYZuZxLrziZLUvfs2mJI29vYtuze06TWH/BKw00q
 7YySQ00Popft+TYqxasxWHi+GzmUq697nj8NcJg3lMQZ8cVa87bN14zyt9cDDgDqEy5rRNJLjKJ
 Z4w5xkUcalYbM70kANRK7k4s0VkJ8pBbMpmKPuLvwepW8KS5nanwiGWqGs4H/w80MIBf0GI9Mpu
 0eQwh55GIt3e9Libbw/EuSpZ13lShYEJoq3RRzgDJEA9YBdv5R+HGY+oxoysiyoVd2ChUJxNUOV
 kmqTHhvttdun3c8ypHNNI4k0jotADqzhp8OfoNfgzTHYJF2Dbzop1EkJIMXSCE0oSc/5FRwmsaw
 LcnAly2bTXDRimh+vfcknZleqS6Wy7y6C1q6knptYqqFvWTEthYhVqN2LLaGRnTU4N5a7
X-Google-Smtp-Source: AGHT+IHlKfZKFBqb1wDzo2j9//e6xI1ISE7ErzsRLniWbmBGhcP57FMpB8tWx0INnGb6cPJmbOORcA==
X-Received: by 2002:a17:903:1585:b0:267:af07:6526 with SMTP id
 d9443c01a7336-29027303346mr167426485ad.55.1760126310986; 
 Fri, 10 Oct 2025 12:58:30 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.58.159])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de54c7sm65682015ad.10.2025.10.10.12.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 12:58:30 -0700 (PDT)
Message-ID: <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
Date: Fri, 10 Oct 2025 16:58:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] target-arm queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
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

Hi,

On 10/10/25 16:03, Richard Henderson wrote:
> On 10/10/25 06:04, Peter Maydell wrote:
>> Hi; this is another target-arm pullreq. It's a big one but it's
>> only two series: FEAT_MEC and FEAT_GCS.
>>
>> thanks
>> -- PMM
>>
>> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
>>
>>    Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251010
>>
>> for you to fetch changes up to 00936783abf77ebb47a78312a2e6500c6a13d938:
>>
>>    target/arm: Enable FEAT_MEC in -cpu max (2025-10-10 13:22:05 +0100)
>>
>> ----------------------------------------------------------------
>> target-arm queue:
>>   * Implement FEAT_GCS
>>   * Implement FEAT_MEC
> 
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

Could somebody give me access to https://wiki.qemu.org/ChangeLog/10.2, please?


Cheers,
Gustavo

