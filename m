Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59C8C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbV1-0004dY-F5; Thu, 31 Jul 2025 18:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhbPF-0006JI-Je
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhbPD-000565-9l
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76858e9e48aso845737b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999541; x=1754604341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ly+5RojnC6YVhoJ22XnOgL58UOwnVm+4YBPnbTE4qDY=;
 b=kql72i7a+HnMd3ys8vbR8sVGH40gjFqFnTP64k46gU7aOaQVb7gHiuaRoY5UjKiTc3
 bxnDMh2sGrAgu1KC0yYax+ISnwALesfrbsC+yR2XDp11uvUtO4ZyJxjhRVM/5UxsKoCX
 V5vYY6ytBTfu0z3YxJ+LHaex7UrMrpGSl/KTXNFNx5/HqoPHoBTtOW96ClkhYUvcVcKJ
 TqYJnIanzYY6tfMMrL/3J71yiiQAM3BQw4EzulquIMhn6f+rdDnZbB7jrg5AvnVxS9rn
 EXOs8zRz4pNuXmMCnRCWhLfP0yjbJmkUThEkZozFJSXtDHsUIRbLYO9w5OqZBdOlznsv
 phPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999541; x=1754604341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly+5RojnC6YVhoJ22XnOgL58UOwnVm+4YBPnbTE4qDY=;
 b=aXVrCE8Y5W7bLvagXWw168Dr+8QeSPXWxDoO7dluVMIKrQMawjBHME1qBIUUuLGDEM
 5aA9QTjXNkB+p1DD+a2q0yLAtb09D4ehjpOz152T2ZYIHqcy0mdvk489x+JRR0WB04lg
 zrbHMU389O33ImcthHG7b115JJezfqrWVz4AAQ2G7vBX3DunpsDGjr7SyNlbHIoeOUM5
 gUqtlmEY9/bWxwq8pcorw5WIy36bNdfNWVkR/ty1h5ZQxzt2ilr0jmvgD3Njege4X+CP
 +Xn52K7CRTn6000uM8PBhMfKDJXfQQGMtKDDdEa3SNxrcw89QF5j+PsaUPf+6LQlf2eI
 RYzQ==
X-Gm-Message-State: AOJu0YxBRr+vBXEoipFBwylD4b29Qku8Q9qAg4djWyDMKI03E69YzwlZ
 X0EzM6YZ7zhvmwq7gtKfhiWzvM5bQglw4UrMTZIbCrclmFVNfUtAPCDmAC/6F8HVkhQH2A7K2nx
 mZ+yJWA8=
X-Gm-Gg: ASbGncs25B5avFlTW3n94jQAsEeOYVLsiFckVVrpteD0HVwElIDODqsSsJS6/bIOJkd
 NrhTHBEdIL15o5iseh+rRLwuIoYufI193bxcDo9fBYqywFiu4B3iJ0i/pJ5IqDxuSXlQJyXD9jj
 KWyELMgx9pLpox7Avq3okF8r864kavN4eWrmf+aeUtloITEPGpfrwwGT9FDRLHVOww444OefZfO
 Jo5vzhyXUTrf5T8cfQBFV/4O4nwifcleHRZLYCogklcH6DAGnFiwQwvh80Tv37vOwprrex8mB62
 0PNvZRSk0+8UFiqCNYIW/eIoPn5kEEFWlnFr6pkq5XfaU8w13fK9YMA4yH9+uc91pnAuw+nO+2F
 hceY61z7hpgsnagCMllvF66EGLGcZhiV2+Cguh2TE
X-Google-Smtp-Source: AGHT+IGgwkzTgIlR/tf1BExvKkO9CB4rZWGLz3lc17lwgo219VFF+QsAa4kLgCT/fluBDt3WTd4fzg==
X-Received: by 2002:a17:902:d50a:b0:234:8a4a:adad with SMTP id
 d9443c01a7336-24096b17831mr122976245ad.26.1753999541237; 
 Thu, 31 Jul 2025 15:05:41 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84df4csm2825457a91.37.2025.07.31.15.05.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:05:40 -0700 (PDT)
Message-ID: <847b1e63-ab3f-4be1-a4cc-3df281341f33@linaro.org>
Date: Fri, 1 Aug 2025 08:05:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] migration/vfio: compile only once
To: qemu-devel@nongnu.org
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
 <20250730220435.1139101-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220435.1139101-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/31/25 08:04, Pierrick Bouvier wrote:
> Acked-by: Fabiano Rosas<farosas@suse.de>
> Reviewed-by: Peter Xu<peterx@redhat.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   migration/vfio-stub.c | 16 ++++++++++++++++
>   migration/vfio.c      | 14 --------------
>   migration/meson.build |  6 +++---
>   3 files changed, 19 insertions(+), 17 deletions(-)
>   create mode 100644 migration/vfio-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

