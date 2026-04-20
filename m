Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C2FF5A8B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEupU-0000Md-Vt; Mon, 20 Apr 2026 16:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEupR-0000Lq-Jn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:02:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEupP-0001bK-Bi
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:02:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso11339865e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776715361; x=1777320161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfaFD6F6Rp/HZWpniKlNjLA/JaI+wIG49hsw68bHy9Q=;
 b=lXZWQwQqYvtUd4HosXzXzCV3vobVd/p1JbBdSDuxi6bq1l7CEYT3AqeYJzUP/kQjgP
 3DMSsDvsmv7arAmEGx+QvGiPXx5e3uXBk5Wd1ZFSVNTLoZ7sTwISry9ziY56D2oQk7Xv
 Mz51PnmWWVPxoBEO/pyTBPSch4lPSF66XO+mcVcrq9xUSrcw3CoPTpBwGiljNET6DnIS
 rPkfYSbiMwI4KrAv5f1ilPiUCFufwAivRMkVB0hPPaai8QT7vekyAoqnL4bb2UjSCJM+
 vTsZyhFl2+ayKUSM557DQs+GSGjrOOKLZnlDeY7v3mMQU32HRIZVnowpaRoQy3GPK9Ta
 bZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715361; x=1777320161;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AfaFD6F6Rp/HZWpniKlNjLA/JaI+wIG49hsw68bHy9Q=;
 b=dTasGdZ3gHOPAwv/CGIyFEbiFJ7VV1POC0tSsJSXmcepOgfQfmET7NjXIvJ3yBOQWM
 rymzXUrbyh/ZE3F4PSL0/vCA+OWxaaLKcvmopVwZrRUXcVl+o/wc8AcJ0TQ3rWXa0jie
 ik0M82SJWzPSJaLXXz1E0Wt6H2LgVjPTj/LDaUiubTu1xO/ZavBLDX8NOx6rriz2vhoa
 7b5gX5h1KVqfsxeGvRopf6EEKQC7OwCSmNdoR9qn/XaNdsDJ3g7IkLemq2IgDi4AzjBH
 frli+8yVaPYo3kEKfY4ef0EPWUYhSJYmqUey1Gncdp4s3RVF8UetCHjVD0WaAfts5Hr3
 WcSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zeMozoeU8/ymNHpMd+6/uMbb866V7rXTvyT2iOFf7Pj9z5upFXoZ3mytvtidf3gZkZXqmlmQjqGeC@nongnu.org
X-Gm-Message-State: AOJu0Yz+axkaPoefduZhFVWe48rUpsCwsOfEYUbItaZqwLV0VD9mjSn1
 NOpeRHVYtGM3NN60MG3R0ykXgJejrHkSSqO8K40eaUx9/P74WccB44coZuiJZ5LDIpc=
X-Gm-Gg: AeBDiesO00h1D7O6fmMsMEdiTxmN21OURbjGJRR1GyiJLkLYKxDvFwI3y1lmhCyDGIz
 OrIqxuLqW+h8/DXAtu796Kj1OHs+fFhl3te6Dyc9k5jwri0dKOveKJOGJ+gMWKYcdUKmtMMPMvv
 7zJF61sXDs8wjDCti58xPe9umpUTcYdDJOy65/nm7N46W+gJsvBceQ4S/rXGpZnJpvuV2cZ6ICK
 tlbX81HTlTQ1PN/mNUgWwtp/3ynz/PhidJNA965c0QWU7gWOy4zDUAwubM91CoPEcnz3U/qnudO
 T87S4PVIbVjlyWCy5yG5g0rlNpXwIYtdeQvBcOg958IwcmWKKpPzXrGow68DRa0/YOElxY/0kZa
 7wJoGB2+hHNEPqnOYbgmCJv2hw7HkSdTv9uusi5wIYw/K8D4VhdaydbM6JJRxGrtHUHxswfKGMM
 5VinudE0a4gJJIhDVjDEQsVZsLwYFFbR/dTaPPkSY7u57ElZwrAI8bwmdSVq5C8l084DQvodQSY
 zc6
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-43fe3dc5386mr24052833f8f.12.1776715361193; 
 Mon, 20 Apr 2026 13:02:41 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm35708842f8f.18.2026.04.20.13.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 13:02:40 -0700 (PDT)
Message-ID: <f8ac63c5-dbf3-4916-9483-cef72e0e4480@linaro.org>
Date: Mon, 20 Apr 2026 22:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hyperv/vmbus: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163844.332663-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420163844.332663-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/4/26 18:38, Osama Abdelkader wrote:
> exec/target_page.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/hyperv/vmbus.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

