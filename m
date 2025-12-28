Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484EAE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZywW-0001gZ-GK; Sun, 28 Dec 2025 17:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZywV-0001gO-8e
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:08:51 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZywT-00038P-PR
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:08:51 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-78c66bdf675so73126537b3.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766959728; x=1767564528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uEBO00ROoMJWOpPzvMqUtrfif4OZf7PHSURJrTERtwc=;
 b=R2yfIe3CbyUttFL4ff4LoIk4XKvhAuuWgaDN/zIX7tsNsNX9Rg04nF5nE4EEF7Rl9E
 ErJ/H6sZgLhRvFT1A54rV1dEpDSRZJqBOog9XC2Wl/3KYxsVu9RzFVGmU/j6LGeTc6dz
 pg8V47FQYGVMr+yF2h04RFIk71lV9RRPNFDR3Jl/BuKivNbcDcIwqMnnbMmvFq3W+Qce
 E40Q4YveJL/09X7Iqw6O+0N3MPpnvCJEbd9RoBvKUoSc9Tu/d1BklFvyuOokx2KIQ75E
 npBAglKVjp5zwrCQawWfdFLiVepZWuzmyLETdpqZd15uKpRZVxC0hAOjFCBXNMKSbPVv
 ko+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766959728; x=1767564528;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uEBO00ROoMJWOpPzvMqUtrfif4OZf7PHSURJrTERtwc=;
 b=CRj0j/ZixBbHD7kx3F9m36J/56pkZNviPgwszk4SIwxiUKbFXX4hLwJe+QP+LdurW8
 HigvTGQWMtMmH/0sUuGvJba6+taHacUUij8eYY1WD/DxEK4+4gZcvpvyz1XKP9Y5HtmU
 z8Zw7JKhz0YtggvXTt3xxVB3udxOEQIM+G3lUIpdJtcWGNXBYRqqQM0X8oatZtxU60XV
 64fbtuETpIZ9xa2bJ+oNFAdeHfGoOjELqccKGu3ns39kdvoN4jc0xnD9g47JHK8/9hsp
 GdaKPFvjtsPb7oVS982FfPKxkMJHHYN1o8RzrGr05vkbgJWl2bFgUSmf9xseaN4DR+kW
 fNjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGvLP0ZbyZuKJhyUDWPZe+nk6Z9kkAgNfHjeMsZqsZkrPeBALUQMIen8+G/28SYs8pt8DgBYaKoSx1@nongnu.org
X-Gm-Message-State: AOJu0YxtqLxn5Kz3pLSG7N1b0djaY8MnOkfHkUtTUhvZCWgwfECYWVer
 tTC//16FIq0FdHWzxiZrOB+I/LHJDptUqFUTgYG4kQH6ubKcJzdKI8oTEkOBOhTmDkA=
X-Gm-Gg: AY/fxX55sWTS46fIY6OnhRo6CqC0v2gkk+ZK8o06vXdP2M5DgRqDwqsF9BAwasqtpgS
 ln8G4sYgi8CCVUyFIx45uSo7X7U2g76oj6sZyOyBs5w9/H70VqjPF4RoEPPJwEGJS4MxFmrz9Qn
 U/1ylVSlvzzOLzCQhKFwn1iU4p91xypngDKyxYgrzmvDO0bhI/ULy4zLmaPfIs/HOQcxg+glwX5
 +yzARdYBVWqGUWXbzx3LYoyEVJ+2VZPrJsLUFrf1bvdEwvMRf5C6U4BfcM50CFQvkgoZHN6tKGg
 PCjq2vMN9duc64VVCrW9k2FfADEhFu+q0ZZlKPN+yiJOCP/m4OCWXQltx6jd0yn7SZWyLTTFWu9
 l8e8nk7+C5Uo2CfYZcPwQeQfTGhupD1o4swROC6zubLnRjKsI7vfUASYyDAcIbpMbOenZpQOZ1d
 QsFOCkNZBr8P9PpspkF9/ME+l9IxwjoiyoLd8jcXLYcBTAWeTAFObx
X-Google-Smtp-Source: AGHT+IFei1CpkgN5Bw4u/kRoFskoHon8cg6qWvfPqJOEF4uweMKj/SLle8WWTOS5kBVcQV0fXACn1g==
X-Received: by 2002:a05:690c:700d:b0:788:b84:d4f9 with SMTP id
 00721157ae682-78fb419ac8fmr203563097b3.57.1766959727956; 
 Sun, 28 Dec 2025 14:08:47 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb43701c7sm108946207b3.8.2025.12.28.14.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:08:47 -0800 (PST)
Message-ID: <0e791e7a-5c2c-4758-9786-b3dc01cf2b1c@linaro.org>
Date: Mon, 29 Dec 2025 09:08:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/31] Next patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
References: <20251223142959.1460293-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/24/25 01:29, Peter Xu wrote:
> The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:
> 
>    Open 11.0 development tree (2025-12-23 14:45:38 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> 
> for you to fetch changes up to bcb411a005fdf39b76e99c14f3618c7b70f7774d:
> 
>    MAINTAINERS: remove David from "Memory API" section (2025-12-23 09:27:02 -0500)
> 
> ----------------------------------------------------------------
> memory + migration pull
> 
> - Pawel's misc fixes to mapped-ram when x-ignore-share is enabled
> - Peter's series to cleanup migration error reporting
> - Peter's added debug property for x-ignore-shared
> - Part of Fabiano's series on unify capabilities and parameters
> - Chuang's log_clear optimization on unaligned ramblocks
> - Maintainer file update from Ben (CPR++) and David (MemoryAPI-)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

