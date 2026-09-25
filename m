Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73654C9832E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEBc-00072C-9y; Fri, 25 Sep 2026 18:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAEBa-000721-0Y
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:14:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAEBY-0001Di-Eo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:14:29 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso993024a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790374466; x=1790979266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wyYwLYnGRUj/yzNYaYPtMbhVnZpriID0rxEN4oji/LU=;
 b=LcV07Jdxr+ILgytpgFm6/BLCl8++SMh+5XrhCyDdr20KrW6tI+Fc3/hMun7GhjhwPq
 Xa8SKh3WQlYVr613vZrQwFBDWgW0f5jTtl0sL/2iBlqw6XZaY/uDRmnii8SuVt66h84A
 XJ+KbFh0j7dCuvzfindnngIw/4ifQN66pJaosUgZU5LJleKQfCkAVtXNL8nCXaapsbOs
 KopYRs+wZQigwPIG0PRmIOL0k5NqINk3bTbLzPANX/O7wt7v+fo+f6eKxrUV8+875++L
 k7TR0PH/J1Sa5aDkequQFy6e8i8QEnhQprShnNOBSMzaaxBw/Dtu6ngC3xW60IjZdD2F
 QBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374466; x=1790979266;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyYwLYnGRUj/yzNYaYPtMbhVnZpriID0rxEN4oji/LU=;
 b=UvRs+MnZXI9m1xC78qX8w1pQSJszq/YAfolJMqeH5aJc2erl0kqgsynF9c+/QUYkoE
 DguHS4+gcp/0IsTnP+5WvjhfafPqBl/RYLnNB+mXJEbvAi+1jgpbb51qcoruOqLmJAh0
 UzSf+K33IY8/uITfAexTaLk1En351d25fEbPIBFcjlG3lnbzGU/RaXQPw6XCYflssdAP
 yznRsyFdjUpCVbKjR9gEQWwfFMw/Cgsrab/qUJ4Ob+AJHoZ1SdnLF32ebjDvYmEVvOx6
 XclSVs4xslZJmr84sOX4Kn+gTTRY4FRyGZDdQeWF6I1aDRBLFbATTVDmATHvp8MfZGOG
 iHew==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6UIfX6KdpYdagvOcG/lSvY7A3Jax7HdQl7mBddimNhXHtJcCV8Hv32MuV0QSal9gqXgnomftof8+g@nongnu.org
X-Gm-Message-State: AFuF++ltBC/+YoKNWz5IHXuAcAhPYswaOPu7Bbf1peumO/TfE6d8L5i8
 kUrw1DIE9to28FGI2xRVnDvdy8ZeZD+OROp6BPvHj0s6lHzDzScwikIMRSJmZwipOzw=
X-Gm-Gg: AYBFou0YUmR5GS78UtUbjXC2bNbsWyxyDUX4nfV4p+FKtdEX0u3Awah5GBF8Q8B9qoz
 OqCAu4QOloSK9cZTBWl5s1fbEgJmWbYHvL3bXY8Qluj5JzuJsKZkF13zLS7eYIgBRjYiDrNPLFO
 bspqhQURTB+WQRdmBxwlgRQ+W7pxA4W2CtC0GGc2VdS8sg155g0mwc5Ic5JwNW215e83llgl1wW
 XghlUto1VrBS6ODe3q7I4rYLw0x0Gn3wLimlruPpKDXHTBuff2/eQ5m6NrH6eKwb6+uE/nG9R+J
 it1eojQHihn18fyF3dAA9z1XQsjS5zI4yfsVN/YC8SMGlMSFTkpCckMcrQMIeo4PFaGglTBLhnC
 8hJsJY3jeTMP4ktwNU+1t0HqfywWvBHBH+7avUR6/Sn/OGoBVFDhwDQEyjVUcRt8EuP10cNds0k
 26iwDnQTVXmwdb1Jj10xZLY+rXIkt1RGGvtSEPdyEQy6E2Asvh7nggHzf49omC9rq0kYcu5UbDa
 HliNVN9XXXXlhlbFs+qn0mLk/e6y2IlYv6bV15w
X-Received: by 2002:a05:6a21:3408:b0:3db:421b:2afa with SMTP id
 adf61e73a8af0-3de0e72a49bmr4650762637.10.1790374466220; 
 Fri, 25 Sep 2026 15:14:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc787929977sm1868742a12.18.2026.09.25.15.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:14:25 -0700 (PDT)
Message-ID: <075fb406-a183-42c6-811b-d5c2d09b1663@linaro.org>
Date: Fri, 25 Sep 2026 15:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] Migration patches for 2026-09-25
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260925154010.599247-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 9/25/26 08:39, Fabiano Rosas wrote:
> The following changes since commit 3876503faff51ce3a132dbbd0ab42c10f2269319:
> 
>    Merge tag 'target-misc-20260924' ofhttps://github.com/philmd/qemu into staging (2026-09-24 13:30:19 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20260925-pull-request
> 
> for you to fetch changes up to bf8156b03d263a66c00707d38b3f852bd9560fb0:
> 
>    docs/migration: document that postcopy can be used with multifd (2026-09-25 11:29:14 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - RDMA migration fixes and performance improvements
> - Updates of call sites to new vmstate APIs (bool+errp)
> - Removal of open-coded handling of QAPI structures
> - Documentation updates and other minor fixes

Applied, thanks.

r~

