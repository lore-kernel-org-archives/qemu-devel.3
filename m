Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFE8D5E125
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVSpg-0005nq-Ns; Tue, 16 Dec 2025 06:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSpd-0005m8-UO
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSpb-00061r-5E
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765882982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rstc1k+1ao8220HoCbk5GTZsEnr3g5JRUCBW7970FLc=;
 b=ZiSBLYATsLbNOZYDKg2B965KGfXbPUDZoBGtizmrrGhk/zU7o2t0gGWhZKsPNXyt17kctz
 Gr9lklupWbV2RKkw6F+ggHS6V91VcPFluZtIdgGPCWZKdSl3MKSdWDgK47O30HKtFGiz7L
 gZ8Pexg68QDUoypy7s7ohEGSXZZByUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-fOJR1yXZMJSsxR3K6gJHWA-1; Tue, 16 Dec 2025 06:03:01 -0500
X-MC-Unique: fOJR1yXZMJSsxR3K6gJHWA-1
X-Mimecast-MFC-AGG-ID: fOJR1yXZMJSsxR3K6gJHWA_1765882980
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563e531cso31276995e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765882980; x=1766487780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rstc1k+1ao8220HoCbk5GTZsEnr3g5JRUCBW7970FLc=;
 b=jNyoEKsaXXhmjd+4avAg8Nlj8bJJe4V/rdlLTKE4yz3owfn9KTvpowrb4qRHq+PQ1d
 JunRYfWbz2lyAVzTr43XkzhS7a8Ph5uRmtLGx0E1eQzKMR1vnO6fNFV26XnNCBUdRjxi
 3ZIZi30CixKyZzZgzZw+GsRydgFOc/HgHoc5iLbktd2HYKDKjBD22t11O3ZlHZRmMdyj
 dVGB3kPB/lJlo057Tl3x6XelQJfeJDtrIbfLH/ROct2mK5nENMbP+t2TA9BPEUWoSxi3
 FQgTeMB6N56CfJBtpog6E0hdIw5udRtlXYuAr967a7vikV61b0q6S43GrpBFKT61vZjQ
 7sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765882980; x=1766487780;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rstc1k+1ao8220HoCbk5GTZsEnr3g5JRUCBW7970FLc=;
 b=rLC231CV4HRxXeJ2kqKitD3iVB95bLywzzGBcnsaRvqCWUlzDyW08sr+yBH0fFMRc/
 iz1f7u+utj6eY8xjxZQPnaVvsT/NNWvOPzFslem0Y/RhAJw6K/Na3EIkK7IXbYTaEKDq
 1wBWH+FodHjElpMDyoHABMX9INBhQ//xf3O0b17WpUELmBM2OsshQO1cN/QfX+3bMJUW
 KpGYlFEidM90kTMvnooO1dZ9bQFBBRUzXsWGfiFL9llYGmN77omSrCe3AMDQyluvJt3d
 fBkBMXfJ/vZH526GtInMyKfu9PlnyHl2r51OhMk60Q1RoQB+JmtrlQW/KVf2nP7xOhVd
 /1/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMo7p3WXwmyhxTD93ZJujuWpasmdZG5MRrMKzwQ8nqoayANg2/IjN8scn0s67tlWuXAw1T839XlzwU@nongnu.org
X-Gm-Message-State: AOJu0YxFFmY6Olh/dzizMEHSUsrh4T7C8ZgWOnodM4JUy5WB/q6xN8eJ
 pDiXJWfnGpf+IgdUCRQBLfSKzhIfVU2NRTArP7/WEIHzXjEv0wlZ+omiwx8f4BDXtZD9WE8m3Y7
 dOnI60079bYmrj/P6U6YiFjwCCm/CJf9/QFOQUz9BcRKnA7boJYdeVH5E
X-Gm-Gg: AY/fxX7TxB6lxgpGpVGXsoQQ1xkTnrXhtKysZSL/uX7+1ZwZ6sVL5HCPHtoCeLX4vRN
 0xkSf86MNSh1IeoVMa+Z02un6awvO6qpv2nLQLsm+pHABiAhs6Luz/x3dKOKjoeMl8HbZrJ8n0s
 AuZDay6Cw6f3NETyX5cHiPnA52BKxF8MyCm0SP4UhJtcdwHaPpK/HtJNQNwhVOlhaZSVpXWrJHZ
 +9DYoCBwIwLskM1F4XYQ7Ff7ux3SLn7X18durmhwSncDCya16qnDpR/Zsovl1/MIu+prazdl0gq
 skESbIyxG8S/7QFyqRIqOVQHdKntg1lCeUjBNRl46dT/BjPGEtioTLYe5CEeppJgrWe516AHeHr
 VSNk4nYU=
X-Received: by 2002:a05:600c:6290:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47a8f8ce390mr183312705e9.16.1765882979767; 
 Tue, 16 Dec 2025 03:02:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErs4Te0ItyJ1hKu3cQN9rwOvKQOH1rpkvMBya0zCcmU5RtIXqtGzcP/QuXYcn5EjxSZ8khzQ==
X-Received: by 2002:a05:600c:6290:b0:477:63db:c718 with SMTP id
 5b1f17b1804b1-47a8f8ce390mr183312305e9.16.1765882979399; 
 Tue, 16 Dec 2025 03:02:59 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8e9115sm239454405e9.12.2025.12.16.03.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 03:02:58 -0800 (PST)
Message-ID: <8fe1bc9d-bf2f-4c85-9176-a8905488be9f@redhat.com>
Date: Tue, 16 Dec 2025 12:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] monitor: Fix const qualifier build errors with
 recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251215101937.281722-1-clg@redhat.com>
 <20251215101937.281722-4-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251215101937.281722-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/12/2025 11.19, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strchr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../monitor/hmp.c:589:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    589 |     p = strchr(type, ':');
>        |       ^
> 
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   monitor/hmp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 34e2b8f748b425e1e4446e8e64aa25b1433d1162..a3ee02e52cda530508b170c4c5e8357b304f7df6 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -577,10 +577,11 @@ static const char *get_command_name(const char *cmdline,
>    * Read key of 'type' into 'key' and return the current
>    * 'type' pointer.
>    */
> -static char *key_get_info(const char *type, char **key)
> +static const char *key_get_info(const char *type, char **key)
>   {
>       size_t len;
> -    char *p, *str;
> +    const char *p;
> +    char *str;
>   
>       if (*type == ',') {
>           type++;

Reviewed-by: Thomas Huth <thuth@redhat.com>


