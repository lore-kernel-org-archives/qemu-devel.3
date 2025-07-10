Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B01C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZwUr-0005Ry-1d; Thu, 10 Jul 2025 14:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZwBg-0006Yu-1b
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:40:04 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZwBd-0001fj-VA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 14:40:03 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73cdce0ee0eso335007a34.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752172800; x=1752777600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P8pr/A2YC3YIqYJz1pODqgDI7xep8x+NaCcdFmWkn3k=;
 b=A4hhGg53DCTGGwiEZk89axo4ovs9aGtZtV1X1DobDldax5W4CzjfEf8CY1ekpLTQom
 maRY70amE6BKXCsoPqoEMPfTMB4SWNoDp/X0ZkQ0Kr34CHLpy90rosq1KFraNz7lwpaw
 ZJ6ryeczmXzfMWGd2//jbCyxnDtHom9c+XU9bnNZriGYNOxoAKzM4SHKhf29ApSu15Qe
 LzSPOZr4/yiTH0N2Z4HpPPu3d0MmFXLNKfCudjqpW8pipCDPwkylMSZrnLZXg085c88T
 riX1wnBa4gQQWp/j+Aer/E29IYFGY1KZ/7QAYU0slTxzqOkXLv10Yp9p2Q7yXz7OOzsD
 mCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752172800; x=1752777600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8pr/A2YC3YIqYJz1pODqgDI7xep8x+NaCcdFmWkn3k=;
 b=JA0mPQcjELVzssdjAy/7UhQg4uzmh22Pa9snmuDIEi89z6Hd8QHJAzDecn06CehEzE
 40oCmAwAqGN91LBeBe6FIASkQoMNdNPYW7thKFJ4iizczHUHL2kLGtoXhDVYPAogADYJ
 6s1YXAogD90Fz0FyvtyFuAwI6vBsNz+5P+vhiQ/XFw1qxP1GQi++slBvP63JluPXj/5T
 zBbIZQwl5ImsnmQQleD3Ms8BaAvq26zV5b/9mUZkzH2+vAQOTwhaXojsI5Uq6Geckrqi
 +PHySEQF6eGYQ2np+wX4q/1uZsdNj8eKUCoyyUQZSHGORwfikH3Og+n1ZMho/WnuNCSG
 5kwQ==
X-Gm-Message-State: AOJu0YzHm7cEaD7058MQ1/PG7pc56umwBtyZvz4KKH4sTW0CBWfqpfad
 LO15LbwgWDskw1V+/+dtSUwda4e/l4NN7EG4hu5YG1YkVwIw9vh52gQilcQ/TaY6fvna48xLCGF
 TkzkH7vA=
X-Gm-Gg: ASbGncuD/XZo5Ri4TnkeJ+kfTl4EFPQ67+VQUckrNoYd3YcEr9LXUgScoc9XMsNZ95u
 JU4jqVv0WSSQ7chdNXoXy/A4yn64Sh4AMP9Tqrith1XR1SwzGDUasgu1tvkoFOhkOx0NoriV7Cs
 +bsC4Pq3s7kV3fkH4kR+1r+NQTnemjBdKKQ1SefP8EaWCgdbjHLxdLpzT6vRXezZDk+c7y226Gw
 GarTUeyQRqnIB+yaAyOLv+XOtXlbiE30zkfI37FXWU0sBEASYTXbKMtVOeila4HmxeCmK5dkhuz
 2PFTOTk8UH6Y6U8plIJ+Nn8Wqm0fMU9DcCWWv55fr3DPy+eQU9JmGRvMWoUlJLSjeEXUmoMGaZr
 wFSg=
X-Google-Smtp-Source: AGHT+IE6GPb295vWa+lRfd8J2iALWud4Uvx370S8t928ycZipyXm+9BRtaZUOhMxGBWu9RZoK3JXAA==
X-Received: by 2002:a05:6830:2d83:b0:735:b205:fd86 with SMTP id
 46e09a7af769-73cf9e915c7mr426731a34.19.1752172799629; 
 Thu, 10 Jul 2025 11:39:59 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064954sm291549a34.11.2025.07.10.11.39.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 11:39:59 -0700 (PDT)
Message-ID: <ee750298-9699-44da-928c-422e495d92b5@linaro.org>
Date: Thu, 10 Jul 2025 12:39:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] linux-user: Hold the fd-trans lock across fork
To: qemu-devel@nongnu.org
References: <20250314124742.4965-1-geofft@ldpreload.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250314124742.4965-1-geofft@ldpreload.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 3/14/25 06:47, Geoffrey Thomas wrote:
> If another thread is holding target_fd_trans_lock during a fork, then the lock
> becomes permanently locked in the child and the emulator deadlocks at the next
> interaction with the fd-trans table. As with other locks, acquire the lock in
> fork_start() and release it in fork_end().
> 
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> Fixes: c093364f4d91 "fd-trans: Fix race condition on reallocation of the translation table."
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2846
> Buglink: https://github.com/astral-sh/uv/issues/6105
> ---
>   linux-user/fd-trans.h | 10 ++++++++++
>   linux-user/main.c     |  2 ++
>   2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued, thanks.


r~

