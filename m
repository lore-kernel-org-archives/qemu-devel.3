Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DE1CD37AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaBI-0000FJ-PL; Tue, 03 Sep 2024 16:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slaBD-0008QZ-9V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:31:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slaB9-0006DY-97
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:31:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bbe809b06so36319835e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725395464; x=1726000264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5SA8Dwy1KEBrCFgvgOCdFtjZ8BnOKmkKGxR1EDwwQc=;
 b=cUVy4e3iz2Ne6SNVXcl2b3OTSYslH5JjH/3TfsqB/woWVCIVTUHBl1akiKMtJexfXA
 B9wRrgzFUZuuZbHTOSH+Mne+ysoFGUMv5NWaUr6JnBDiY1r0L7vzRozCtT1s9lTyXw7I
 XcXie8ci3b/NNvJmwhchLIz3k21dUsReMJsuPVwRwxHSVcxrw1heNcH7WvgyUTF77ciQ
 CYFsmvn3tCFcnUnJshtm7AUjWjaJ4xJnxftewWpQYSH6wILiry8m4zgA7zA4ePq1bAyi
 TPDT4J+p+HdsKUAiNRGaRxfbznjTswUVYtTsJ6cLlRSpX1csGs2/VYaowwn7agKE4MT0
 x4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725395464; x=1726000264;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5SA8Dwy1KEBrCFgvgOCdFtjZ8BnOKmkKGxR1EDwwQc=;
 b=EXn4Xxgz5kmnYCk5YiWbz6p73Wy3QFpprKtZC1HpLn6Tr2SMv0ddlW60jPi4IRdZY8
 YqnlGQ4Ba6O3PQ4vzJL57ApwXx9Y/M+7Z3J+9StP8fjcSyOs1z3IU0kCIziho4SH0Rtr
 CXOBOQyMzcmuKWJhwxMcU6T3PskQMzM+KbEfvs8oLths8wAiRiFKGaNnW1HyJ5msR50e
 ka6SBUsXvs6Koqc7KD1xvo26P24bXNQfIPyFR7OLGKA++n07A6u3I69/MFd3RPwZ6LmF
 nuoL9KkUPahMkuU6ri6U6SDEY6Jv6LVQ0ALXO12k6TxOlbhVHBu630kDcNjkOlNq92LA
 CBlw==
X-Gm-Message-State: AOJu0YzxDdHraEvPTX6KNQOeCn763bHyjW95MpLT3CYCy+fzR+qLmnf4
 WYoZDTy9fVASHP7BPLfW9kbTifo9WKhFanGfix74CHH9TUGLPT0xSuyd/UaWt5CZa+MGyTonBz9
 g
X-Google-Smtp-Source: AGHT+IG5e+/EjW4BA430hUX0C6Jltpo8cRS/QYFhFpGXizWqXuG7Q3OVb0FKe4Rji1kRgxGg1WPVHQ==
X-Received: by 2002:a5d:634b:0:b0:374:c8d3:5f2f with SMTP id
 ffacd0b85a97d-374c8d360f2mr6287094f8f.31.1725395463664; 
 Tue, 03 Sep 2024 13:31:03 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374cbbc8281sm6113299f8f.64.2024.09.03.13.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:31:03 -0700 (PDT)
Message-ID: <cdf40c60-e95a-4909-8c5c-4adc6a20a6bd@linaro.org>
Date: Tue, 3 Sep 2024 22:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] [Block] Is there a way to control the read caching of
 a block device?
To: DUO Labs <dvdugo333@gmail.com>, qemu-block <qemu-block@nongnu.org>
References: <d5f6c856-169d-4dcd-acd3-d42d886df17f@gmail.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d5f6c856-169d-4dcd-acd3-d42d886df17f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc'ing the qemu-block@ list

On 3/9/24 20:13, DUO Labs wrote:
> I know that the `cache` parameter for `-drive` controls the caching 
> behavior when writing from the guest to the host, but is there a way to 
> control the reading behavior host->guest? Currently, on HEAD, if I open 
> a file on both the guest and host, and write some data to the drive on 
> the (macOS) host, the time until it shows up in the (Linux) guest is 
> inconsistent (more specifically, it seems that the data won't show up in 
> the guest unless I close the file and reopen it --- by contrast, if I 
> write to the drive on the guest, it shows up nearly instantaneously on 
> the host).
> 


