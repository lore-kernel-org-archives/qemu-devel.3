Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602BCCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2wr-0004g0-Fd; Mon, 01 Sep 2025 07:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2wS-0004dc-Qs
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:43:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2wL-0000rx-UN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:43:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b8b7ac427so5736185e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726987; x=1757331787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVThE2XUo6tz00UlNsDBLX50+YpEuFe1vy5czFvQ3wM=;
 b=MfHDxwMEcimZvf1qNhBMIzyrpoPIKiG6FgNltsfn9b4TFhFkRCfiU5+uTwADUmna/E
 YRdR1KMGrKLun2fKqYUWBgyb66zUgzw3LZe8NytM4AvegAirwiXfCGBhiJAwX7hkRdHY
 8tvFymu5TWkWg7MQdYd4CN83llnh110PemFcr81bI8+4D3/i1ZDDohahwpqanRyYu4vw
 lLQ6uOc5O9HiyfppdWfyVvONlVwTPTneTrzGOcbtY65gBemrEGHjXn/lmgaSOgjRNdKt
 INn4NYT8U2fhe5SFP/jqi/t3CsTjb3JXRejfp0fgAH2IGnzmfsck7WBNm5r8Usz6qNiC
 hUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726987; x=1757331787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVThE2XUo6tz00UlNsDBLX50+YpEuFe1vy5czFvQ3wM=;
 b=VOltvQOGjG1whZ6X4ibawNHTInkSHw9Fqly6sH/fWcTXGo8IcvwFPPLj1OUibzJKkE
 UR1t42+rZDpurA9UdsYpWVcZhyd2OKPIG+OHZ87MtMyIQYSjyqSOsdUw8J5RC71gOEmD
 eQN8/4w0J7b0MMh2EGig7Q/evuJy3yqYz2hVZoRBA38qDEM1dodmf6E64hTiQG53H7t/
 bpvAqN1+TRnc8aVkKoG5uvwyCJ4emKAVZTU1BN8P4bILTZjiiOi4ZTAYuCRR99MR02vr
 qFxOyHeBaxxs40refAFK+WKisTD28uq4uAXG+Ta9SvO9HzDfi8MGcseGmv9zixGoj0vc
 ZIvg==
X-Gm-Message-State: AOJu0YzQWaan75O0N2gLaE5aAMR9okbBDzHHPtBXOw/KzMMEeBD/ADiu
 yDYOB21kI76UpKC2Feffduitk91MvRfdQBG3IlesCJjjsuQauRp8N74gUmcg9RAIJMtJDj2L2UL
 jHafm
X-Gm-Gg: ASbGncubeMgVhdKy+/HRhPvg8Bps6fpy4Eke2RSayoQYm+TgpGTovTG/le0pbm40Am5
 oAud2Axw5TCfxURTrx5eJEOsPA8mQgFtbMEyYh8D6MnsFMkRSsv/7qdTDC5xKn3GMi6T0G12Hj2
 QGsn9l3X/00+1AUANL5qXlZKtUgrlzCa1S87ew5QHddovxUY7vjKxUxL7LlHdC8V8D5Fi+VWLJ/
 d7+eGItUGAz0kOMYICTqhe2UGKbc+2XrP7X0rdE/QHZ/zSz6xrhtvRlzW7bUqWkwJ9m7caI6UxH
 uPCK94QqORje7AcaYfQrhBHQErOqb5RMfX0o3H5kDj4KgtI1qlOyrmQVIKWGXSm0i8izw8JsRsO
 rLjLiH5MJZKZpyH8sGa3amhfJ34cAkT38XQNhcdKhnoJq0yA0wbFr2SC29V8aQuQDpt0OqMs=
X-Google-Smtp-Source: AGHT+IENMSEk96L/dr228kTneNm2ciEtV71vLYDWyiJBPsE71ZaXiWJ5luM9QUHCV6RebrMKv4JbjA==
X-Received: by 2002:a05:600c:1c15:b0:456:1514:5b04 with SMTP id
 5b1f17b1804b1-45b9353e825mr95285e9.21.1756726987450; 
 Mon, 01 Sep 2025 04:43:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e50e30asm154949815e9.24.2025.09.01.04.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:43:06 -0700 (PDT)
Message-ID: <182ab8f4-c1c3-4228-b715-c8b0344c5a93@linaro.org>
Date: Mon, 1 Sep 2025 13:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/rtc: Silent overflow in qemu_timedate_diff()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250811100823.94105-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811100823.94105-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

ping?

On 11/8/25 12:08, Philippe Mathieu-Daudé wrote:
> Per ctime(3) man-page:
> 
>    A negative value for tm_isdst causes the mktime() function to
>    attempt to divine whether summer time is in effect for the
>    specified time.  The tm_isdst and tm_gmtoff members are forced
>    to zero by timegm().
> 
>    The mktime() function returns the specified calendar time; if
>    the calendar time cannot be represented, it returns -1;
> 
> Coverity reports (CID 1547724 Overflowed return value) the
> qemu_timedate_diff() method doesn't handle this error path.
> 
> Since this method was added in commit f650305967f ("Unify RTCs
> that use host time, fix M48t59 alarm") in 2008, and there is no
> open issue related to it, keep ignoring this unlikely case, but
> add an assertion to make Coverity happy.
> 
> Fixes: CID 1547724
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/rtc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/system/rtc.c b/system/rtc.c
> index 56951288c40..070b99fe6ad 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -98,6 +98,7 @@ time_t qemu_timedate_diff(struct tm *tm)
>           struct tm tmp = *tm;
>           tmp.tm_isdst = -1; /* use timezone to figure it out */
>           seconds = mktime(&tmp);
> +        assert(seconds >= 0);
>           break;
>       }
>       default:


