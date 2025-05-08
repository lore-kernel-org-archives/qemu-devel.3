Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65849C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzG0-0002l6-6O; Thu, 08 May 2025 07:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzFx-0002kw-ME
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:17:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzFu-0003Yh-Uw
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:17:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so8269725ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746703053; x=1747307853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K1Fi6A7xl5bPquTurvis4WauUWx0TEHEdBotDD3k+mM=;
 b=gr+yimiEwQOgRSN7F+mu1xhRSdqFNy8oqxbFQ4cBd8N63EkX/JqOEM9zV5OCj+TGwk
 4SA101jAUMuGeFOjm4cbAEFrRwMyKBkQCmU6qXVX/thAAKdcXnbtGEpqWcpCzxfl8L7w
 sXh8tw4TmRtBARuowwjxQQwsG20yu6SGI+EV88JZn4niH/P1hw1Iax7Wg0BF0+1hZbG7
 TEosCsZYfqCoBk16qMtcb7GTuL1kFudhsWLI/+bUBWivC/eMS6KhVmBgmK6SL/HSaMEu
 oMBAdiZ+JCauuq38WRqzGqMfjMS+DeLJLpzCBytnE0RyBZxoZoyMXjVxC0B2HmZFH0n3
 kuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703053; x=1747307853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1Fi6A7xl5bPquTurvis4WauUWx0TEHEdBotDD3k+mM=;
 b=sXqdC86wSgkWT1mpgNxAaNKLWdTtlZWUD1z9P0YwmpIs89RQL3NQEuBGx3QiM57j4v
 0mnL4Cm7V5Zze6VbMAA6UnFt2eQGK1NVTQWY1AsLtFJoz0JOOb3Xiv0DfUBmqFFaqewh
 XPhUzWVBM8kjeVjf2mXM1CorjwIGYGfGEer6TGVTVNJAm10Lfnr180yVJnFSvSQwCFP1
 JW43DUKlaj+hXVkH8FIu+mDV34t+ZiBRFbbx+1jg5mZWneU8cm6AtR29Zh39CammIY5R
 BaNLwFkeixvaITC664wdac7OY51MzSyUHkfaUOaChmuwuUERKkxvokKjbIPC0lxLHA/k
 1FtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2G7UKmnCzJwPMeQEE1ToI00Nc3e+jfmpcRC0PudxtbFVQczYZuGRak1xis+zm2WmJolhVHNW3TDi@nongnu.org
X-Gm-Message-State: AOJu0YzGDfIkJVngqtCRQeuT82kmSKNVfDea375gcOsknekEE+GtIQtd
 5YRZjbsgMbg5GdK4DW1yDervmwtrPb1USOSMXCXdWJAHcqV1np3iq2F/vCrbM5M=
X-Gm-Gg: ASbGnctR3jPCWX+1MZ3U9THYBCGPc0mJ/xicg9OGE2XyQcOJkDoIsvRgfbCgFy45CWc
 /P9S17fYAYQffcCXRcSmCgFbcpK7g8pUW4BTLc37yWs+695krKRiFiBmcCetWMkf7ZAtPkCUAbg
 +OnolFlUINpy9MexVRzjh0Wv8Lnc2oeFlTC0ugMZ45KzdvPFGtsyGWo5qJBxcFISrdauIYzoKfr
 JK/rOKRoLlNZd14h3pL0nAa2C0jzbHmoWmWYqfLoCfrqnh3sKrL9yjDlHRv2PGdfLhsOP3AJlDW
 87dsKYtbvm5EPeeiRUrurXdNtiuF8NP1+e1EQ7uEW4zwcLRrlUt0SEyYoQ9K8E2q4eUMIykaoNw
 5ytTN7qym
X-Google-Smtp-Source: AGHT+IG/jMSljJcBebw6+Jb29hg+gh9OK5nqhSpaZmshhAc+p8ccVXRVmk8s0pA92qmUI67xVCYs4A==
X-Received: by 2002:a17:903:4052:b0:22e:7f20:52c6 with SMTP id
 d9443c01a7336-22e7f2054demr39563465ad.23.1746703052800; 
 Thu, 08 May 2025 04:17:32 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ed6f351bdsm12754035ad.221.2025.05.08.04.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:17:32 -0700 (PDT)
Message-ID: <22ba8dd4-37d4-4d83-8942-527dd5cb01fe@linaro.org>
Date: Thu, 8 May 2025 13:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/q35-test: Remove the obsolete
 test_without_smram_base test
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250508095122.144807-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508095122.144807-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/5/25 11:51, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> With the release of QEMU 10.1, the pc-q35-4.1 machine will be older
> than 6 years and thus will get disabled automatically by the
> MACHINE_VER_DELETION() macro. Remove the related test to avoid
> that the q35-test is failing when the machine is not available anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/q35-test.c | 37 +------------------------------------
>   1 file changed, 1 insertion(+), 36 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


