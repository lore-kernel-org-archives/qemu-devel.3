Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0893E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgbK-00013B-OY; Sun, 01 Feb 2026 18:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgbE-00011r-Vn
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgbC-0007Sz-1q
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so31941465e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769987480; x=1770592280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZUjIlZWgok0VQbjyCrw3WdQqgVDHdWYyGyT+7ruDhA=;
 b=Qt2TOOgUWfcuGadX1aGQeg8SA0SZrWikXol6YZLFneskpCUx5k39uy53jo54ajr3lp
 jDs/gJDzfFoNbMdVBhy678yDzvCadtA8QxZLB9efIoaa1ydUdZBjbT8cCnEDoARMMsDQ
 w91d591BbaDgCaqR1DRcvwsw7772V0ETUkXGHmP16NDV6cWkR/eICzQK50/SnHtV5u4j
 D51KXjhSQJLhTam0pP0bTlMCul2rvO+S64NmwJplO398SuFgpmT2JdK8WmStEOyNgLrp
 1cJch1+JXeutBCbwzrmWhQLyWQTposV9Xv/zbKF7WPHRKjrf9ylCJ6xW28BdKhWIqINd
 VR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769987480; x=1770592280;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZUjIlZWgok0VQbjyCrw3WdQqgVDHdWYyGyT+7ruDhA=;
 b=mhEHcQvpGkWYESm29TtKV5AWYSWzI+6kYCWA8jnxXhXYpf/4TyieJUjTTymlZyVkcH
 8xIHMQJSjQ7MDl7TcgXETW2JtK49u4Ehm3roh2Adb+Mi0dLc2iiNpLH21MourDZGf2V1
 q8qOR4xUFscbSxSWYtt7If+X4HbZmJDtAn4lnCYcZVTDToPuGq4lg2R2AKEkFjAS3OMj
 DN/DUBBXI2JjgiEdjhZYGwa7+RTOQ3YoZdP61I5ZGnr56oVwy9L2+S8y7oRBItPupgfe
 MMcg+B/0hFEFfg9AXXSCoUPHoPn+XNJ0iBMl/WJhghMsmLFPTT4+vLtTDu9NnYJRevN/
 voDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd3E+crVGg2c6QjQ+FOz/tar/4go4U4Wv/fKkYPyMS3TDC6HWLE0wx6jz5j3WvbtMm+4GoK7p61ci1@nongnu.org
X-Gm-Message-State: AOJu0YxvWnoHpZOh4Kr1umUO3/NBT/7yuVDxYmBev2cqN8BKklBQS4s9
 LNkicDPB+abA5tqGLRSxo8NBvruFzgvkDgpIxoSzlfd05X4NPsyDzsWxzAzAMEPCTqM=
X-Gm-Gg: AZuq6aKN7ZUdRBdeA69LoHDu89poMxk+KvwnPw8CZjUZEHdav0PZxYK6dGsmncRL37k
 P5/zcRGZi48Y7p8xgI+s8z0N9jiJjh1VXH3zRWJZj/IeNMz9bFp76FB9uk15hZnU2VRxyLwf6zc
 slPtTdUAq60hQ6eO0CbV28LEGxMCLvxWlsvDF0IkJEw/ACUInf3IM7jK6W85QxIFSQM36Uok9Ux
 tWkj52X9AvY3kF7tS95+CDQF0sZj5Y7nZL/o+3r/tF+R1N1gFOrq+GOuJIjMOGQQlJo5LUPgjF4
 uHTffdYd/fB+yZRQiTs9uk7QFu7+OZuref39SjWBdYhPwI8KwZByqVnRUSq9AQo9oJLqkUxEz3G
 5/rHoPSuY9KFi+Ms1ANkRcAI1KsURZ5KjxC+3ytLyWj7O1kyly7l13DJjzZnnBK5vCPpLyC3IJR
 75nizjShWJ5i7R0V55N/xvPRtWWa9hWD9qshvpxCMUuF0PHpvQfFlcSA==
X-Received: by 2002:a05:6000:1a8d:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-435f3a6f7fbmr13646642f8f.3.1769987480337; 
 Sun, 01 Feb 2026 15:11:20 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm38476245f8f.20.2026.02.01.15.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:11:19 -0800 (PST)
Message-ID: <a70b17ac-53ba-4c4e-877a-84c9cbfa0f13@linaro.org>
Date: Mon, 2 Feb 2026 00:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target-info: add target_base_ppc, target_ppc and
 target_ppc64
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-2-pierrick.bouvier@linaro.org>
 <a3448604-f82f-415f-81a6-b7327f689513@linaro.org>
In-Reply-To: <a3448604-f82f-415f-81a6-b7327f689513@linaro.org>
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

On 1/2/26 23:28, Philippe Mathieu-Daudé wrote:
> On 31/1/26 03:00, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/qemu/target-info.h | 21 +++++++++++++++++++++
>>   target-info.c              | 21 +++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


