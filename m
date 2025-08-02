Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6738C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLMG-0005Zu-DW; Sat, 02 Aug 2025 19:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLM5-0005Ml-Ao
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:09:35 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLM3-0001L8-0F
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:09:32 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2664735fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176169; x=1754780969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h6SN5pmWsVNZE/VQK7ve4QJ0+lY2blGsnjsURanMPUU=;
 b=aaOURQ5YXFEP6rgRCZomz7UvhqWhQ+Lzk5Hc6Bi2VZgorTIOXS7htRF/9ydc5XUfsB
 MfL22qHJk6kIuO4J955RSJsHKXSSEU3VC2FWRJjr/Hyj/5GcVBK+EllWnZ8mOfZ03tm0
 Qy101EUl3QuTZ1Vfp7XHTtAcGQhgLSS6eBtd3ytONFxalywcU7OuXg0seTN+EaKWnfF/
 ahT6rsLHglC1MPo0BaPOGgS/vOvqazPwTdFAQVGpH+sU6mPGnXZ2x+O4FZAbBysOXSsv
 j/kVkRHtoWSJD+ygwPCQkUZr6f43e7S9RrpDE8ZZLHTsc0BESh+i2dlnhhTMyWLXwlZD
 xjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176169; x=1754780969;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6SN5pmWsVNZE/VQK7ve4QJ0+lY2blGsnjsURanMPUU=;
 b=GAmMBCG1gezziNncK9xkK3/O6QYQ5g3aSwiZe6/bDxfhHp+HsTo52CBny5vyRf3efJ
 MP5cDiwXsjyaNx/WD5DO1idoR38QGArupjVcTMNHIOQxq5AnoXjSsBNVy4yldwMQVbwc
 mlDVHorwOTIgfwceLvLDa278x5Ql6dQI1Au8MumBEOUPnD0dyhEIDyWvJx2li5DtBh3X
 8UDKNzxw63lS+bAEhbmg39BI9//YtkNqAglNJ3O+I3GmS3w67YAQY2pUolv+ubHKqs4K
 0oBdlqYisT1S1mHT2T7ax7e5OpEd1lNqEGewK6lOsDcZUcqWRRnJlEscta2M5P17SpMH
 hi9Q==
X-Gm-Message-State: AOJu0YwaIquSBjOUprOEyJ5H4WFRibdvhxMBRxLj//C8wEsNFNho0rqt
 lpo8HMvNF5SymXJxicGW+WDWxSBGWjhJRFnyAG402gKz+P3/T+1oGGLkW5/tt0BYUnYjsNdDNBB
 Rp9ElmNs=
X-Gm-Gg: ASbGncsDDP7At/Fih5JHZ6JeWX148L+z2ZEd+p+ryIPe7RZwBkRR1bM8SEBWRnnP0jj
 q6+HVCvo6bByme+dpd1KZGhq+HXoWyGH+BO2k9qkRC97kZq5xrCfWgvd2GhZerQyv+JftVXlJ+J
 +Pu5CZv0lSU6U8LFXsM4JpNYtQfTkkkO75vtqRuZxgQDzjuhH6HDW+m1Pyj8S3LAueQjvLj6M1q
 ahLsJNV2L190Rx/hvv63sj4NbOAiDxNXINAq4l3sR2jIqJKI4P/57P5kzcVhIsET5T2Ct9jI+rr
 7uSaU4DlqGW5BGWf5MbGwYWxFXTupmGaVbe2VGr7+LgBNzIQU4TVCJMeivTGWfqF6arEPGkWVOH
 gL+//GDNL2rN68nf3EIwMBYhcscN4O8BjeK9srIM1BJcHAhXRmn0b6BeZRF0W6igR8c5StLor3a
 o=
X-Google-Smtp-Source: AGHT+IHC3vCkd9OR9WVRLNz+2zG/CLZEUynanrjXQYRrgFvHcSW8FiJVE8mBrrnLnTRim0M2YnNfXA==
X-Received: by 2002:a05:6870:9f0e:b0:2b8:78c0:2592 with SMTP id
 586e51a60fabf-30b679939c5mr2487529fac.23.1754176168971; 
 Sat, 02 Aug 2025 16:09:28 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a548adb1sm429882a34.43.2025.08.02.16.09.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 16:09:28 -0700 (PDT)
Message-ID: <2b270008-bdae-4f1b-bd04-e3b5cc3640e0@linaro.org>
Date: Sun, 3 Aug 2025 09:09:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add a feature for mapping a host unix socket to a guest
 tcp socket
To: qemu-devel@nongnu.org
References: <20250802034154.7834-1-murlockkinght@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802034154.7834-1-murlockkinght@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 8/2/25 13:41, Viktor Kurilko wrote:
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    if (buf[0] == '/') {
> +        if (is_udp) {
> +            fail_reason = "Mapping unix to udp is not supported";
> +            goto fail_syntax;
> +        }
> +        if (strlen(buf) > sizeof(host_addr.un.sun_path)) {
> +            fail_reason = "Unix socket path is too long";
> +            goto fail_syntax;
> +        }
> +        if (access(buf, F_OK) == 0) {
> +            struct stat st;
> +            if (stat(buf, &st) < 0) {
> +                error_setg_errno(errp, errno, "Failed to stat '%s'", buf);
> +                goto fail_syntax;
> +            }
> +
> +            if (!S_ISSOCK(st.st_mode)) {
> +                fail_reason = "file exists and it's not unix socket";
> +                goto fail_syntax;
> +            }
> +
> +            if (unlink(buf) < 0) {
> +                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
> +                goto fail_syntax;
> +            }
> +        }
> +
> +        host_addr.un.sun_family = AF_UNIX;
> +        memcpy(host_addr.un.sun_path, buf, sizeof(host_addr.un.sun_path));

The memcpy length is incorrect -- buf may have strlen 2.

No need for both access and stat.  If the file does not exist, stat will fail just as well 
as access.

Why are you unlinking the socket?


r~

