Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392CE8304D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 04:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn802-0000y7-GL; Mon, 02 Feb 2026 23:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn801-0000x3-FI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:26:49 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn7zz-0006UH-SB
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:26:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso2006083a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 20:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770092806; x=1770697606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zETuxYE6wQ3bIqFwJgc4Hg8ib5dFK/lb9mbhSwO0Co=;
 b=H8adGn6ia4egV25g0ZbqiTv3wRl8uuPKXUF1luV04qlWZ9zY/f4uTaYj5+uO5AIbRT
 JSfCxDUi0eeVcM/bTKtTGIObQqrq2riJVxmzoZSyt2lvtMr6LoFOZfVnX8HEV1/Uw3c7
 mvjsAqaO0D395SatVKQ6JL6aE8MaGbsr98hXMk+TaILcP1WNYssfre+6liM68uREx2jM
 gxhE4iEgazznjyjBd4946iIG01+uSnNDV1s9Mt3Jp5qgdcF0nsR1pUdOqdYeO2kmnhSH
 PKhb73DJe+Tmi1t9f/+mtNE+Axlqa7E8ikhR1rz/iTieNmw2lAdCeZZx3G1jZ8Sn5Lye
 S1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770092806; x=1770697606;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7zETuxYE6wQ3bIqFwJgc4Hg8ib5dFK/lb9mbhSwO0Co=;
 b=eTFwdKeopl0QM8f7ayFS973gmNDoHodChU8uHQANwyCDMskPySyWTS/yo2/JojU/Pp
 XNXN0dpCYjCXMWtKYzEz2vXGfgI+5Deo+gTL2wH/u3VwfqX0b6cmLHDigryChVyEP+LQ
 wj+ZkpeVSPWWcVao3htakobC0wtLhrkIXtU6olL2z8MLcXvr/6iNwa/C+0gIWH4/W5Bo
 h5OkiShx5BxC3sUJcuYKp20Gl9WXl/fr2r/gNjEs+eYNGWhxFyHR0GzySU1h8enoTvr0
 65G+X57QFhixSkmqpQnDNyddBCXBC/jva8rK7Z23QrYuZ/4RrwLis54ebs5KF3Olr48W
 9QTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs1elXzp1dMMEUH2Bbdxgm3zO4cciwonODnSeKHKnK4yTVYEHJ9NQRMm2gZcauRiRNhZo65aVKY6Uz@nongnu.org
X-Gm-Message-State: AOJu0YyjOTdQHB576mSYES2ZjIGqz7cXdx4XfedHgV5TH0AWXZOTCiDl
 o3O6Lk3hULIvX2CMg7QQBFQAf445kF9bZMJLmKN2k3AbV+v7qNud9pnD9WQXUSA3f8A=
X-Gm-Gg: AZuq6aKv32GXZE5fxUetViR9/tUd6Zu94tq9cqvCiePwZ0+GjIMGRsoKhecXUaP4DP1
 gH1NucqK/om5FBqN6YlpGAClqBWOWIDJmx6SRFuawoRnlIVINuuiYDhCXtFgRwpik479ynFrr0x
 gPPDt/U6ApS5Z5kkFsT8zsWIOarRCOfCmDu/s/qgzUKmrStFQg4VrZ6ya5KYb9tFcSoi0U8tXEs
 70JnCn56ZJUbrAHBuumKyWkCrUGG+wpIvH6AoTeHOPXboBqqbpzTDuKBhsUTHUeRPGbctaSt0Ny
 /DSktcq90JwbHveOFSV6SEKmQ9mr98l08Dt4imZBiNxQ7CkHuPGPHGqKFkqc467YhWRc3XvXl3y
 NbUz/i3YTV5x5dgKzrfvA6fWZ1Xk5Cjk3DuoAkINUJtVcpkB03U5eoOwnngUTRdM1g52wkpZbmc
 Gv9YyR36Rq26MreLju2vnoRhbjm4YVDPaSYI4uds44Jm2dMWp9oTgwxcpRqQmydZWLMBvwOfkEg
 ZYfKBoNnoAeG5EljD3F8G3AHo5JuVtBJ75TyGdPhQ==
X-Received: by 2002:a17:90b:50c7:b0:353:3b33:8263 with SMTP id
 98e67ed59e1d1-3543b3241efmr12750868a91.9.1770092805576; 
 Mon, 02 Feb 2026 20:26:45 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354774e0034sm977779a91.0.2026.02.02.20.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 20:26:45 -0800 (PST)
Message-ID: <874d029e-fe67-4075-a02c-9c79c59a2d97@linaro.org>
Date: Tue, 3 Feb 2026 14:26:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/syscall.c: Prevent acquiring clone_lock while
 fork()
From: Richard Henderson <richard.henderson@linaro.org>
To: Aleksandr Sergeev <sergeev0xef@gmail.com>, qemu-devel@nongnu.org
References: <20260126151612.2176451-1-sergeev0xef@gmail.com>
 <e0ceab50-b976-4c38-bec8-705994295c0d@linaro.org>
Content-Language: en-US
In-Reply-To: <e0ceab50-b976-4c38-bec8-705994295c0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

On 2/3/26 12:42, Richard Henderson wrote:
> On 1/27/26 01:16, Aleksandr Sergeev wrote:
>> By the spec, fork() copies only the thread which executes it.
>> So it may happen, what while one thread is doing a fork,
>> another thread is holding `clone_lock` mutex
>> (e.g. doing a `fork()` or `exit()`).
>> So the child process is born with the mutex being held,
>> and there are nobody to release it.
>>
>> As the thread executing do_syscall() is not considered running,
>> start_exclusive() does not protect us from the case.
>>
>> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3226
>> Signed-off-by: Aleksandr Sergeev<sergeev0xef@gmail.com>
>> ---
>>   linux-user/main.c           |  2 ++
>>   linux-user/syscall.c        | 14 ++++++++++++++
>>   linux-user/user-internals.h |  2 ++
>>   3 files changed, 18 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~

