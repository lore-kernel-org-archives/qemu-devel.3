Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76B6C27C6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIuKt-0005in-TJ; Sun, 16 Jun 2024 14:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIuKr-0005iC-RJ
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:10:37 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIuKp-0007yg-Da
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:10:36 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eee5740aceso10811239f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718561433; x=1719166233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35WLDbWkEsOUGwEyB4WRtVdtTNUnyIwE8/tGdLPwdDQ=;
 b=UYrUgb3JpmaY670XUHLDufXL26wkHhqnmUebhOFwvHQ3/80CteHUli+ggkElAR+rKV
 WDHqzzizROjN0SK7Ura6j/bYFGu3lzbdFo2Vu6u1oSfqM0nLw3rxUKU7FY2RcifysLtK
 sp4gW8WZyufEGTI+B5xzEXWs9L3MPhGMX9UqMmEXdVwcD60TacsrKaT05qxUdQH+/CWS
 Km0NklgzH/UWm4S8+KwchytO1AbT5a94YWU792LwQs7EBTphNvLqGh+bxBXC3tjR5PmT
 LSnoWedkRL0CTkVR2q8BHali125QuTtpptyM+15iUubT3iclqKZP6b45IGyg4Btbb+yt
 zanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718561433; x=1719166233;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=35WLDbWkEsOUGwEyB4WRtVdtTNUnyIwE8/tGdLPwdDQ=;
 b=twN7pAVwpJSjjcqYLg7Eg7sLzD85B4+Ig2OynG9v9MR0xj+/zac+C931LA44RTMERv
 NkRorznoUdjeE2RAUxix4jqqTUSFNcxrtvPo1DqxuiiI8T972sCl62N+wur4/MnPw7nn
 X27ayOsQ9uYh39cqi74YT9cVbIFBDKNBZzWnE15OTOHVrOKrRbjbWtUmQ0WuN3W9UL09
 v5oqmFllT5DPA4xVg3Q/GnR93VjFvver3dUVaYYj2XtAz3Dc6SVoGxso28wmUTi+Rfh6
 Z2Ld9u32Xw9JphyRPEJCTdhggKPoQb1E3GNi1loo/i6tKa3jTb2dbtmSAUgwZTUqRAIt
 3rPA==
X-Gm-Message-State: AOJu0Yw5QejY6o7LeIG8vzgMZLfPAC5JQ/Mt8LRWe8HO8a9xIk82C3my
 RURNdSvtRPfcy3oITfhUzvCMDblXsWTFwEXrdw8YaAxGB9gy4P7F63fENcGVxvk=
X-Google-Smtp-Source: AGHT+IG00w8GiiKm2pJz3gJVLgeVrYMlrkptfAq7zbV80hGUwwmOH5FU1dbTzl8+vYo9qvIjoVizEA==
X-Received: by 2002:a05:6602:168d:b0:7de:c720:ab1f with SMTP id
 ca18e2360f4ac-7ebeb66e75amr791729339f.20.1718561433567; 
 Sun, 16 Jun 2024 11:10:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc9257e0sm6176208b3a.29.2024.06.16.11.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 11:10:33 -0700 (PDT)
Message-ID: <ab2e2fe4-7ef3-49ef-a70d-df3595661837@linaro.org>
Date: Sun, 16 Jun 2024 11:10:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make TARGET_PAGE_MASK typed as target_ulong
To: Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, jansene@google.com, JP Cottin <jpcottin@google.com>
References: <20240614192938.1690188-1-rkir@google.com>
 <e486aaee-9c2d-4bfa-adaa-d36b6ca64435@linaro.org>
 <CAOGAQeoSnVpy6Xhxb+pmHwwfjYsEqC8d-QhSt=Y_c7wsZMSN4w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAOGAQeoSnVpy6Xhxb+pmHwwfjYsEqC8d-QhSt=Y_c7wsZMSN4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2d.google.com
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

On 6/16/24 10:40, Roman Kiryanov wrote:
> Hi Richard,
> 
> thank you for looking into this.
> 
>> No, this will cause failures, because we need this value to sign-extend to when the
>> context includes {u}int64_t, and target_ulong is uint32_t.
> 
> I did not expect this, good catch. I see QEMU uses size_t as the
> return type in qemu_target_page_size which returns TARGET_PAGE_SIZE.
> Maybe use size_t for TARGET_PAGE_MASK everywhere (including
> qemu_target_page_mask) as well?

No, because size_t != uint64_t.
We still support 32-bit hosts.


r~

