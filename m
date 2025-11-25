Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB763D1036A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 23:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO2O8-00089P-5f; Tue, 25 Nov 2025 18:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vO2Nq-0007zm-Ie
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:23:45 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vO2No-0006fU-PH
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 18:23:42 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b852bb31d9so6965234b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 15:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764113018; x=1764717818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yqCdFpNO97PRfmpLw6bdDhvis83vS/TtC7ohPTkVhU=;
 b=j1SVLoJUDKm7+KOrnoVfR4BZSuIt+jvJJB53ugZ91HMLprtESoUn5vwvIH60kAuMc2
 9av92EQWVr5xI7TiMCUuzkhtLVfAhNf6qdHvmpzswidPMNF/WOjT0KD49w5ZOCjfFMUp
 pMS65ELnMVw4bWt/HcAes5hcGIVTnjnbGZqz5xYGMAuWSIYSq+o6f+tpyjaGMacAmVzk
 vjxc5vyt+Oy97Vl8ITdAKe5q0Rhm4KNO6pFRXNjUNMc4JYlws9FsfWoWlSkL2zzB1aHO
 uY9imC+7LTwafenerYky7mMql/wj7NAW8CVQFChnzQksZ73EKbzXD16H9FFpCltdlAgP
 fSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764113018; x=1764717818;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yqCdFpNO97PRfmpLw6bdDhvis83vS/TtC7ohPTkVhU=;
 b=IORIsMQ2r92y9oWc+EgMsggsghdjVWCYEiBzS8h6LxXFPBjiiSZCPiOuMxwBKrJaXj
 DLhA5DlYA31BCZ0tr706Y909PNy0Hcjf151eirwTs8Qvv0atpZTJxVqchw0EPgJc+4oB
 bOLYe0HxiIlk4660TMxNudFg7tcTg9R8kyE4uAjbDHHyfD1duj6ej66RM0RYEn3u/yP+
 46lLw31h+MjOEiU/Hr4pUlgZdp+9xsQqUoX7q4Yov3yg4UIUeFbfKyAMAAVsNqDjJoNi
 zbCtvKLA59XHG0DJkkdt5iXwszWDQvu75qQERrsA9yUKIGgBSjd+/q4p6RxK6F3i4uy4
 mdRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1TByfMsnbOZpFn6Q3DvNZpSEUnsW3Rn3q1kfaL4DmEKXA8hwMUC0p3YdNIWt6YkcZOIUtQ06GGc01@nongnu.org
X-Gm-Message-State: AOJu0Yz3lEFnbP9VokkWPEbyyh6cfrtyaHpK/d+gsUUsIboB/CQKe/Yo
 ZiRkDnI0TmOK/PlumlYwWThZVCSACpzvzjYb35BMNirKvc5t+w+IEVN5FW9TsKBiV20=
X-Gm-Gg: ASbGncu9Z7scgiSvBVRzbWSfeOzQXOJKKw2JI01uxg1ovJdTN77gAp1Ai4mvxMsYn+B
 JyGtGph52BemvcrzeaFFwMRVnOE+gj69b3Rw4Z7aatkVAHitH8ki1APrXS1Lc6AFNb97PAwRcvV
 HbszPjBBmDeedjKPbMVPvVM2Yv/aNA9S4VSxarE2WCw7In+34AkmEsbP8msXBjKAmYD7sWuevRy
 zZXnhTf6LFeeu98LZQxmqwT+95ofKr1PGZhZzX7gjPQBcS3claIpPyQVa7FXp/1uphjNQ6XlWg9
 uJmi7B5vLvNoVMyZB231XihvcoZuNSbVbEqD+5lIL4Io4wVNhC3GeHtZm20xH3vnN12VtspReeE
 JWIoeMyilF7wTvNl4zSnSQzmHYgRgl41Dpgk+ROC62qbaul7P+xCStbYCBPDB8rASlGqumSOPtg
 YE8yBW+20xCKeevCA5ndZVUqa+qMLUMWfD9RyogEQSUznJgM0t3A==
X-Google-Smtp-Source: AGHT+IHJQ/qzWkgHELpeXONKhWlFWAmfnSOLLqKqLLrdHAAESLqaqOiThoiAnJA8RYdUKMWKQuJ4Rw==
X-Received: by 2002:a05:6a00:181d:b0:7ab:21ca:a3be with SMTP id
 d2e1a72fcca58-7c58c2b1ebbmr17819680b3a.12.1764113018393; 
 Tue, 25 Nov 2025 15:23:38 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fba8sm19399968b3a.41.2025.11.25.15.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 15:23:37 -0800 (PST)
Message-ID: <3a785397-1a1f-47b1-95e8-ea54ae5cfd89@linaro.org>
Date: Tue, 25 Nov 2025 15:23:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Misc HW patches for 2025-11-25
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251125214802.1929-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/25/25 13:47, Philippe Mathieu-Daudé wrote:
> The following changes since commit a8d023be622cab21e90bca8d9618068f0e49b74b:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-11-25 10:25:16 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251125
> 
> for you to fetch changes up to 57756aa01fe52c50d655929c43d9a80f8214cf1a:
> 
>    hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN (2025-11-25 22:45:30 +0100)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> Few fixes in hw/; also including qtest and replay fixes.
> ----------------------------------------------------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

