Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3EFCAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 19:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1rnB-0001CQ-Co; Thu, 25 Sep 2025 15:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rn5-0001BA-MK
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:38:08 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1rmX-00008U-Ke
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 15:38:07 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4f9d61e7deso961511a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758829042; x=1759433842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HULEyZtS4ItKgHtWPhB+ESbu716ykjcHwHjBc2//t7I=;
 b=DhzUcdYT9sbXzkTGG8FTZyrUavX5zq7Q2/MIzAtUc1fkB5X57amsYVL5+UtL8joRI3
 rBm7WcTxiI4tbEVwuw6PNjgCzevHi1kbZidlVSuec9gH/yUBayPygjY1WtYZtyj3pyis
 esL7O+imObor4fdf+yxyfgywNCWnSB20KzPgU2y0C4Z/bov/+EsiQdpeP++Lb9oWCQ8V
 YGIplWgOQvaaPLpXGgMbKBXfcLXDwzc93TRrReqiJ5PkDPw6kKrOC/ZpM1/Slq7GfIDw
 OY6uJBqifNyKTDTa0Fye6znjdPep/nf9uNPfwz/+E+VMHR+KX7Vvm41FGKZHUyLxdSYH
 pSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829042; x=1759433842;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HULEyZtS4ItKgHtWPhB+ESbu716ykjcHwHjBc2//t7I=;
 b=PgBIAuSqzbbbnfpS65/wXWhHxyXJQu6vXsgxG0kk5vMVL+Esv2COat7VtsI8nZvYOk
 HVDtnXPbFMLPYWJCjv4++gkLSDOIQL9xXhD2w0XDPOxBuBmttRE47mxkV7whygD5EOr6
 cqps27iJuWSw6fa6lQ4jpxZGc4JQYuf6lPuaN+opsvIECEWXrOgSuNyevXXQwm2HXNgM
 9HHJ1dStem+nXGz2Cen8WkrgC3oMiQMh9UIyqzcGS4GJYki3kK4ZkpESIKZ4blEh9ocj
 yVUZk8mEyW0TOy1jgy/6ToFUIl+FV6ia1/AUzaU6g9BDi0wymqr/I6V8ECzl5qdAWdCl
 F86g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHcc4yzwfwqf/8U/uEpqnJgOC6fwPL99o9imOIaRGzmV6wvlnGceCp27Y2sAZ3zk/AA3fEmV8HJhKE@nongnu.org
X-Gm-Message-State: AOJu0YxCcJbieRGC7N8UYu4qP48ZRHhVXpAaIu/CpvXhUmZfak4eYey/
 CZi26nr8bn0lMEhF8ElYLSFEma38cZLM/9RnpREpEvpaIcb7ytEM/d5LBEewCQXru2A=
X-Gm-Gg: ASbGnctnNKdkMdWiQV+n0x6fhLYfPdbVoAXQHPFem4kUO26NyDExCawu1x12VHqs1+c
 eUF5yAsitsXF65+Tud/D5iKEZ1KFcSYZcwTq4uo/G9wXAg6FjXyhxUvugo8g907vAowbihXyHAP
 btkq2Giy8o+/d0CvQGsU8PDV5v4l2WSyzI7viMRw3lpj47Zp3+EB1z9M3n+2Ypimu6gZR5Ppefv
 hT6LwhlsmffUbv6g6ARq5F16EgljB+V6vVNsUqQ5bHRHKjsDeVawwLqd4uMXoqzJ7uQnKFHd8Ef
 ATOw7b8uuhCEmtPxU1vjdMpp/8+yB42SB58faQuUJ1uFV3PQIPY2tztYN1Jqu0bWC9CvKmGt1Fg
 OODwqU8198sFzF+vhjelkZj7RIatD5Ha2RtFN
X-Google-Smtp-Source: AGHT+IE0Qy8YZBvfehJfCfvkFaFpTNkNrmm0HRgKu5Segg+I4VPD/LA805Q1VnXrquNA5ufsEggyKA==
X-Received: by 2002:a17:903:32c3:b0:27c:3a0f:f066 with SMTP id
 d9443c01a7336-27ed49d0a47mr44209515ad.22.1758829042197; 
 Thu, 25 Sep 2025 12:37:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ad1d45sm32219585ad.141.2025.09.25.12.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 12:37:21 -0700 (PDT)
Message-ID: <497d094d-08ce-4af8-8421-be470eab69ff@linaro.org>
Date: Thu, 25 Sep 2025 12:37:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/23] monitor: refactor error_vprintf()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-13-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925094441.1651372-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 9/25/25 02:44, Daniel P. Berrangé wrote:
> The monitor_vprintf() code will return -1 if either the monitor
> is NULL, or the monitor is QMP. The error_vprintf() code can
> take advantage of this to avoid having to duplicate the same
> checks, and instead simply look at the return value.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   monitor/monitor.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 03dbe5d131..c00f4aac5a 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -268,17 +268,19 @@ void monitor_printc(Monitor *mon, int c)
>       monitor_printf(mon, "'");
>   }
>   
> -/*
> - * Print to current monitor if we have one, else to stderr.
> - */
>   int error_vprintf(const char *fmt, va_list ap)
>   {
>       Monitor *cur_mon = monitor_cur();
> -
> -    if (cur_mon && !monitor_cur_is_qmp()) {
> -        return monitor_vprintf(cur_mon, fmt, ap);
> +    /*
> +     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> +     * IOW this will only print if in HMP, otherwise we
> +     * fallback to stderr for QMP / no-monitor scenarios.
> +     */
> +    int ret = monitor_vprintf(cur_mon, fmt, ap);
> +    if (ret == -1) {
> +        ret = vfprintf(stderr, fmt, ap);
>       }
> -    return vfprintf(stderr, fmt, ap);
> +    return ret;
>   }
>   
>   static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {


