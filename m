Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F1C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGw0-0007y8-7G; Fri, 11 Jul 2025 12:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaGuN-0006e7-79
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:47:35 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaGuL-00044r-GS
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:47:34 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73c89db3dfcso539871a34.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752252450; x=1752857250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHP/U8/sr9MNZn1qdI1ndYam485XgQ5cvnH3EDQTGrs=;
 b=pnCQHo6PHwP361AjE7GxTW4rnJ/tVLeg0UAH3FwzsPr+23TOYs/+hy9VcUn+O7U1mF
 87PGfaenMHZ6bv7JvyluaTqxGKM9McwfPzV1mBlcrJkfLOQgqWMIIv3p2NKPM7y+vVLS
 WWHSqsYKCzPNYm/ILR+NDsNibNd75ZtzzNxpCPpfJQdWvPkHtbMzYrHxvOpHOr7DMIzU
 7hL0lkEhdNylz7ajIyh0tRzvSEribubAyz6dkCWV1feZvSWn0n4ePET0qpZtYrdMw72i
 u/vxW+P7yAltmHPZqRapO0qfKZeM/53Z5eLHXpIkhcaSBm6ZI5W7HXcHInPvFKDGmJkL
 sGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752252450; x=1752857250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHP/U8/sr9MNZn1qdI1ndYam485XgQ5cvnH3EDQTGrs=;
 b=byRvSeaepiAW7eEtfsaYwoUPzJ3ajIrkyEde+GmUdZml7WE1aBSPFcLfj6kwjLCwX3
 5sdS4IkUDuJm6vSk/pMlvM8Rvx4SsU78Jy6cktML0S+NpEMafCrSFOdMInmI0vtwEsSx
 YpBC0z2MoxtdMRqbmustBy76EBtikferngl0F9qhmVsQEZupAlWubMlbYTxC7boo1nwa
 GnPmifKl4OstUPzMW8af0q3PRw1mhxTZ+looDPAgKEYzvauYoQ80YycC7dur4EEjyRwU
 OTBUvASq43eAuoMUXzpuCiad42UK9emlOwH+9xPo0uGh30iWl+UinkCSFAkklhevAFx5
 KEIw==
X-Gm-Message-State: AOJu0YyL+xYeXJ75EIv9FC0+GDrqLoQ1LgpPBrvns00L+9/T/UQM6j+P
 jSZ0KDNvsW4SXCdpUIM4253t0nAjTJ4laJ/asM7VvhF6z7/v4e1bqD1Ez0NqKEJ+YhjLMMZtOL/
 vOwJw4KA=
X-Gm-Gg: ASbGncueAMtjSdwaLQ0QDHrN5nxAHqVqNiMFIDhFaLWJGv0OVeGrsmVglBgqU4QoeA8
 U13f0VIcBAPQQKRzRIMwy2BRxa+uJ/htLzP1d3a45AzCNVct3xPo8TX32VFVkcQ+XqJTOVrlPDm
 Pi1LEpgAqGQjuhu/uPABoJUud7JRU1cf6+C63ftC+Pd48fcVqhfweVRYrjsbP2capcDTt9uBkbz
 vaFAnyURbakv9GTN2A/9apMUSrNRenCcS/6DjLXT6PNlR/2pV/VPvPvUWBRhy0724hRAtyucTgf
 FJtu51OU12G27K9T0lhc07YqJtuFbtEsFAtqroKhKiMxDmgRkVMtO4XuXw6g6g2WSDP+Anj2B3i
 YQAo2w+OR4zcbYk2fF3PXtdSo0JCfmS3xFEAmGzfBGEbUihdjTrVjCpJK/RI7UVGFaItwnKdiQ0
 pi
X-Google-Smtp-Source: AGHT+IF2ifa0gI5NRayTlKbUe0FUNMYTREZWq1KpVUNzfnlO+fTaa9e+CIiRkLr/iaUabnS52TMYLw==
X-Received: by 2002:a05:6830:f85:b0:72b:9e3b:82bc with SMTP id
 46e09a7af769-73cf9ea0788mr3177477a34.11.1752252450239; 
 Fri, 11 Jul 2025 09:47:30 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b62e8sm615722a34.60.2025.07.11.09.47.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 09:47:29 -0700 (PDT)
Message-ID: <5b57deca-7174-42e4-9c26-07691c1550f9@linaro.org>
Date: Fri, 11 Jul 2025 10:47:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Use qemu_set_cloexec() to mark pidfd as
 FD_CLOEXEC
To: qemu-devel@nongnu.org
References: <20250711141217.1429412-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250711141217.1429412-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 7/11/25 08:12, Peter Maydell wrote:
> In the linux-user do_fork() function we try to set the FD_CLOEXEC
> flag on a pidfd like this:
> 
>      fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL) | FD_CLOEXEC);
> 
> This has two problems:
>   (1) it doesn't check errors, which Coverity complains about
>   (2) we use F_GETFL when we mean F_GETFD
> 
> Deal with both of these problems by using qemu_set_cloexec() instead.
> That function will assert() if the fcntls fail, which is fine (we are
> inside fork_start()/fork_end() so we know nothing can mess around
> with our file descriptors here, and we just got this one from
> pidfd_open()).
> 
> (As we are touching the if() statement here, we correct the
> indentation.)
> 
> Coverity: CID 1508111
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Queued, thanks.

r~

