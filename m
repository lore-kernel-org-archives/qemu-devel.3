Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC1ECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1Ze-0001r9-1b; Thu, 05 Feb 2026 10:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1ZX-0001kt-Gr
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:47:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1ZW-00070N-0D
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:47:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so8655405e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 07:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770306428; x=1770911228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FqATkUxZZH8+wS5pyc4liUaTdQjMbILnKne7rw7ECKE=;
 b=G8dTonmdvPuoDlK3sO8T/HIwwn84GoQWauMXDjg7Yu04gdHgUrch2ybZS4bUyP23Vr
 +23enuHlfj8q2eyXUBO71pdAfUBThJ3VFo1zkB8sQbXj2f6jsnhywTPuDl8omjUZuNRH
 cSqSSXLvIWPVov86+cm6w9c0P2eLP2e2aV5O5NRqxhlFxNDGGBqdZpVznUDDBBMZX8hS
 PwsNy4yp/sw3ry3yFlfQ1h7uPkOL0uMVEnHXqKIkO0vxBj07jd7/nC9M41+xuuWryi5v
 yhBY93srfLvXA1I899o/vZukeOepnbz7oG8nH84zU6zDLW4X+n+3rIyQ8Y35UQmxRdGj
 gRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770306428; x=1770911228;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FqATkUxZZH8+wS5pyc4liUaTdQjMbILnKne7rw7ECKE=;
 b=Xf1M3tsPpL+K0pMzwwuP9GTFCbHxLkqGBHiNoWC56e8+jkHUZ8KeGWuGp9JIogPLvj
 utRzqb1q9zoOoMp76QDBeg+HNWZcGbMcIgkQoc01uI9CWNV7sGGwROCw+JgD2K7SOC0a
 E7fVzpWrlouFM70pKmDppSpui9ksuk9VLOoj4Zk78fu+YIOHNp7du36pwOQ0+WUOV2lU
 Ljkqjl3JreB6rjR6yzp3Y0Nxr4l/7ihZU2nc1f+8nQ2stVhKjmHJD3AMAoMy1cLq1kOQ
 MwsdW2YQoe1FsN5x6g/IKjUq76t3lYpIDJb37zeS9SOdisO5rnzHcV3WD52prfyYegDB
 47WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXElNpQD5UfcYxpIWbUsUsCxkOXFcuv2g/SYYio1k5CrNY/pUX/Ou7VY8NiWcaGs8ygb6mypVg5R2YE@nongnu.org
X-Gm-Message-State: AOJu0YzayLgeKwNOK43U5Q8gg0pIyAgIZgPSe/ZXtnyJnYT5CUDPd0Uk
 4PehoOEhI+6C5dLt69v5kJlYZrm3n6ffbLrXA2IKpPYIfR2pyKdSxNieUruOjGySOFo=
X-Gm-Gg: AZuq6aJQrFg2f8/XoAHhAo28gKQ4thQTXRmc36skB1geuTNgLVswHY43ZxwJSC6/S8t
 vx6Ewgf19J9NcdsxCkukJ7RtcIzUh4+BY3bX8uAbmk/ztPwABTrqEjUO5rPCp22tinY8fsGSnAr
 d0v+9UyUBgpIZBzfG6TSRnewepKTr+9uCZF5RFqhCGthxAPVctQtKiYchI0G2VHyKYcQJ+QRUAY
 Dug3HhjbK13sfyh1ubIs5Iz1T3ZJR/DuYIp5454FgnnE9u9VrcRXFSFw3s0PYgki87AeOGfx91/
 4W7zMPHKJyRh+LL/4wTgJiC29z5/HvO/H/I9aK26amc7qVwI5RsLT3YNl1oYbKNwK8HD6OTClkH
 AqcON+/uTpcnGS/nCAMm8PqVtTF19upMndV1Y/cMLHIwDU88t1MER2gyaZx8l5i3qHigJqUHiAj
 uFg4v4ssfc9z+gjCCQrV4JhC50qOXS168gJZ9t1ji/q1ote9SpNiUsrg==
X-Received: by 2002:a05:600c:1d23:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4830e93ebc7mr104854075e9.7.1770306427817; 
 Thu, 05 Feb 2026 07:47:07 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618058473sm14741809f8f.22.2026.02.05.07.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:47:06 -0800 (PST)
Message-ID: <02fbfdd7-0148-4c2c-b20d-72824f69057a@linaro.org>
Date: Thu, 5 Feb 2026 16:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] or1k: Rename the architecture from openrisc
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <ec2b9446-df98-46e3-b7aa-f486eb189dd0@linaro.org>
In-Reply-To: <ec2b9446-df98-46e3-b7aa-f486eb189dd0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/2/26 16:39, Philippe Mathieu-Daudé wrote:
> On 5/2/26 04:02, Richard Henderson wrote:
>> We have an odd mix of 'openrisc' and 'or1k' in use.
>> Standardize TARGET_ARCH and all of the filenames to use 'or1k'.
> 
> I was confused thinking OpenRISC is the architecture, and 1k
> (or 1000) is the first (processor model) implementation; since
> there is also the 1200 one:
> https://github.com/openrisc/or1200/blob/master/doc/openrisc1200_spec.txt
> 
> But then I read digging [*] I read "OR1200 is the original
> implementation of the OpenRISC 1000 architecture."
> 
> [*] https://openrisc.io/implementations.html#OR1200

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

