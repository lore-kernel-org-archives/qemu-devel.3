Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC94C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmPX-00070G-QZ; Wed, 19 Aug 2026 15:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmPP-0006w7-I3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:57:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmPN-00034Y-UU
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:57:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cbedf318752so905514a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169428; x=1787774228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vWvB6BazJ8BEi0Y61wO1fKBv4RKx5o67uzbVRb/7OXU=;
 b=P4IVkkAeh8txO8/Pnu9j65McdAxAK2fu/iCOp12UWuLIAUzvvtA+DXSdYuPMsmTK51
 9wV0DspXJmyV9v1r1ug3yahmUrj8CmgcMr/iO0XnRywnNVs7zZ+O3IpYN3511JZIhQOj
 lizJl3PnQIVn0BH+Xp8TJjoWHidLCxWN71OX/eBWGqdlQGr0NbUAosPqDzSEzt5Hn7Bb
 bH6P/tLI36suwMNz5luZoAnmjGQ7y6k+93dQTC2g1i827MReiwSA8Gr3kiHV+AaG38DL
 AAygo6N0mkOLDCXi0RpAJgz9jVPaWe5HhDd5PT7T6cHSJRPSdsKVwO7i9PGRp3wjT5c9
 ANXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169428; x=1787774228;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vWvB6BazJ8BEi0Y61wO1fKBv4RKx5o67uzbVRb/7OXU=;
 b=aSFO1kAptsLnChocH7le2zK/4D92GNKhEP6RSMpdR1JarLvkujbDWOuVJ2ydq2rVpe
 CWmkkFp8dx2j9dcDsIU6/QulV0WAxCCk5mNJQ9BK6lLDX06tsIaHzUVaCPnhqfffmZ2H
 TFRdFPayVayTEwz5uZxtigFgsPOI+jJL4gJeXfksmgNWe5uroXualM42r+cK4I1DdWU+
 T2LNPket7mRvvi86fm4FROaJMB8TirK/2NypsS6ueKjYVXGZLKiCYt5ZsY41SN1idAXb
 DqkUOn63RbRtWcWY6LHjDV7VmOXr9uWWx3d3Mg/6TKPxVfyIlUfN5ru4vM3rXTeeZ83E
 SR+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0WOT2b1XJvLtbSwhluGGi4ccoj+5A01S4rvwhfTDL1uxpnO47p0DogPx5qyR1CORTEeHRwC8d0clY@nongnu.org
X-Gm-Message-State: AOJu0Yz9QSzi0NBz7jZcJe0Tl1rjyORbtJ39vYWD3KvGisPTiyWZiJ/L
 032L293VCN3jFUXu1poTZvJh8kNL3NzBuJSnK8Tud7bSDoP0mDSsJcp5H6o6sbddN2A=
X-Gm-Gg: AR+sD11LdGJ1QXuS2m0EApg4qU4fniamMO3jbYUDRdBRllclPT8pObwzgWIpiii6K5D
 bX64A3OZh+eIA6DTTqFV8F2b5jiFKHSADciFF/yuG0+RgpHUbTf1hf7EaXKzDP3D2ogprG06XrT
 +J5sUcGqsrHrgbmiojDBI8siXbh/wOjAmlNVEAi3qYjgiyKSIyQehfjO471Ue7x3Ny6oRH0K27/
 gIsbhB2cySFl0vF0vjUMDPvsYBg0vf6B8zwvDQNTPAPt10KbndVtEH1PesCkYsrsbClG7Lw7fGk
 WeCzMnw+mcFRiz5pDbj+NjsFmFmus9DKSom4uiCqi67H1L1/Uapnvjk7PTPIOJf764zj3WxQLMQ
 NNTbiKu8lnhWeSGfF9Es/tA0vfZxKWMSqXDJvbk4O0AQccWNYnINUJQbHW6ZnrFdtodbVivNdSg
 e9OkC9HdvDKoujtA2/LG8K677zKf8SMMgc89KScplKFJZ0Sgo4zYdudOGPJVVnwRsNdklyAktSd
 UdWA0Hx
X-Received: by 2002:a05:6a21:9182:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd00df4c1emr15089738637.5.1787169427871; 
 Wed, 19 Aug 2026 12:57:07 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc15567537esm990788a12.19.2026.08.19.12.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:57:07 -0700 (PDT)
Message-ID: <2bd3459e-19e0-4bd8-8688-8ad83e7cfa8c@linaro.org>
Date: Wed, 19 Aug 2026 12:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Qtest patches for 2026-08-19
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260819143152.1541266-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819143152.1541266-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 8/19/26 07:31, Fabiano Rosas wrote:
> The following changes since commit fa19879df1658f96ac07365fca8835b7decd6995:
> 
>    Merge tag 'pull-block-jobs-2026-08-17' ofhttps://gitlab.com/vsementsov/qemu into staging (2026-08-17 15:37:53 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/qtest-20260819-pull-request
> 
> for you to fetch changes up to bb98963d6df300fe6fc6d2074198e220571cd0cd:
> 
>    tests/qtest/pxe-test: skip per-row cases whose machine is unavailable (2026-08-19 11:27:58 -0300)
> 
> ----------------------------------------------------------------
> QTest pull request
> 
> - Use GLib wrappers during QTEST_LOG parsing
> - Skip tests when 'pc' machine is not built in

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

