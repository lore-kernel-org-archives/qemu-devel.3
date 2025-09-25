Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74473CAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1s5t-0002TB-8P; Thu, 25 Sep 2025 15:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1s5c-0002JB-Lk
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:57:18 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1s5K-0002Z5-4n
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:57:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b550a522a49so1251963a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758830212; x=1759435012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvCdYBUp687iF+k0SdDokY84TtFQFsGUR7xtOopBpII=;
 b=AlqApramsOoND0a+2OCClibGWjEgvlvsEzfcrRfCgq+opwDksGuXyBYdUfGOUTzFY+
 YcS9P4QgMvXrAgSX1QASrNBy4fXNHZt/gWpJS8VLzGwgNYyog4DVkenV6wIhzqagPIBC
 chH11+dAA1wwFs+6ruNKamQjVWFgeQVy0gUbc+FgNliHqf3f19s1ZAZj5Dn28S4H/7/b
 wa/i3GCO69y/ZqHuE1YYpT4+8igxaLT/umhMS9/f5R3gfVjz3O6YnCieEo1WESzi44No
 hrf6uW8nfnETt8G92mdFsZkRbDqIPE0ns63Tbfd79YS4tOFfec6Ds6ZuBIBWtPpkx29a
 w5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758830212; x=1759435012;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JvCdYBUp687iF+k0SdDokY84TtFQFsGUR7xtOopBpII=;
 b=UK1GVw/wGyCx0VxA8W9Kf8HUL0xzzqigr2TKzOnUXsEyZ3rPDVf3U6OK76QYtbe5WQ
 3hSZEtUJdC+JRx/c66wSz8jJCa23TkZvXrk94uTSpdcFAyEcNKKLvsisCB5jf2OWyV5Q
 xOzjUlnzoGCxckZTySBa2JmdkzIzjkD8nSsfnqjTJV/3nGAf6WCiuWPopIzVydrYSppe
 DOpy7B/UjSgFASvaue2ECMPMU6bzmnrPVRZrQpJUcBK8ZWgZlhE+a/taWHqj5D61V4di
 V4mM02tbf+YQ7zX3Lk4fh4Xad3Zg8z/x9W5Hwyn/YZlEKiR0clwimgbkt1P6jCyadToe
 EXgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4lQgVRycFjClT4nTykZOlGgJ3kiJr5WtPbMwapYk7DKhdRtnnJhUo3adYkE8CdO0bYCglcKoZYTxt@nongnu.org
X-Gm-Message-State: AOJu0Yyd70SCnWpCwPdCK34Y5EXnvDl6VfQGPxzlb/fh9+4rKAp6DBcW
 6b/1aFHKallueaHZHafhmFDRB/5JgjzWYrKoHF0nfBNXehXmWDXUT+SJhw5T6OVZ8GWDkgIHHNh
 6QseF
X-Gm-Gg: ASbGncvjRtRvsnQHXSXAs3atOQx/Ra7Y0OEUulqcvvx1YqeQ3J8IdbGNx2cDnIzeLI+
 oHXvkmX4t7AC6HebRLdrZCXKZXeBKGCSqQmcpffcj+TrdaFTTT2pFH1WiN3c9ZS3u4JMpe00oxY
 tR0YOkxiFRN4MhSzD1sDQUtZAreyZLEqnbxLkaefsNeUTvEQfOZz8Q6Wei10HyUzCu0jjAZgR+a
 yNPPTlPdfB+KB2pZhc8EIFMx37go1BsW9AJd29DRc0ct9M22KUwWL2Ndj23xgZ8TlOy4gYTDHc3
 bkGSTrrKrAxUWq66QRSsTmBLls66qQ3ZpmQjrgyi2RKSPg9FuYOce2xLzIcgjQfuPDADBfyl18d
 hlmEC6P9Q4/BGLoJQEN23uGpaBDtf7S9vEm4gReJHDB4cMm8=
X-Google-Smtp-Source: AGHT+IE2MKfbonFPCTCUWR1Q8OqMoLED4BKBWe6nMrRdr6Z425ceY8nSNPCOw1TUWkhrPY9qLD5Wrw==
X-Received: by 2002:a17:903:b8f:b0:271:7eba:a49 with SMTP id
 d9443c01a7336-27ed49dd8bcmr51109545ad.19.1758830212637; 
 Thu, 25 Sep 2025 12:56:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed68821c8sm31861975ad.74.2025.09.25.12.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:56:52 -0700 (PDT)
Message-ID: <aa940e3b-0bdc-450d-9810-d3f97c6d6fb7@linaro.org>
Date: Thu, 25 Sep 2025 12:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/23] util: fix interleaving of error prefixes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-18-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> The vreport() function will optionally emit an prefix for error
> messages which is output to stderr incrementally. In the event
> that two vreport() calls execute concurrently, there is a risk
> that the prefix output will interleave. To address this it is
> required to take a lock on 'stderr' when outputting errors.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/error-report.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/util/error-report.c b/util/error-report.c
> index 222c40d0d1..b6aa20dbae 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -226,6 +226,8 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>   
>       if (monitor_cur_is_hmp()) {
>           cur = monitor_cur();
> +    } else {
> +        flockfile(stderr);

qemu_f{un}lockfile.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

