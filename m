Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AEFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvXB-0001hC-8n; Fri, 02 Aug 2024 12:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sZvX7-0001gV-8a
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:53:37 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sZvX4-0003dV-Jj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:53:36 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81fd1e1d38bso83930439f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1722617612; x=1723222412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wL8tPhs+l+xv7f4srv1BXyWRbawG9VlYcjfKSuhIJQw=;
 b=TMtAfwm4c60uFUkkG6Axon13/u2hdLUyn9TzI1vP5zTuL/t5/CNomZgrUsrYbL4qW9
 JxOYmRRg8CwmNwcM6B7TPFvWEQ4D2QTfRtRoSMq5xMOpUqIypgCK8lMK1b5NNsWA8LEZ
 t5H70Gy7zo28R9d1UqS+Q3IR8K+zDncHAg6neTN6FBdufHKL1y+Ehfqv8VxhFeQH3xpt
 7W/C77z7SMnlz6oTEiNvLy5lwrGXurgx/a+r+zBv0d9M3zl8hUTq61U5Czmz6hBqpRqw
 Q7EprwuCfx/Ogv1BrT51O47S5ANdRbKx83OP9pd1kjWPmPh9p7epCq/pJ33qwe/VGSxI
 9G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722617612; x=1723222412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wL8tPhs+l+xv7f4srv1BXyWRbawG9VlYcjfKSuhIJQw=;
 b=G6SD61/VlMqYrYGfmuHg2IKnM6BHxAQ46Yv6rpxDnBpfqPk0znIphAOfI+H9a8DKcf
 YSpS1CKjdJ9ahAHay2C5MZInmuMfLcImija8y9p1zm7h5Cq5mIY+EMD3t5ARDUT7F8W5
 w3yXYi0oveeraKguHiIrOkU2A4UUmM8LBjPEvQQDi5nyh1y44vrvYfS3GsLVrPgW+7yO
 V+rw6RNIIIlxZms7wOkWDG0+1+Y6uJ7vMOb/4xhux5TCzcKNAAfZ6JWHLdSK7rjeNndy
 NW/r6AmqqReAkmQFNNV1ZqCbIg7m9dnODox1f3adYPfXeOz3R/VJKQb1MfOermozUYd5
 Wl3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Ml9g08LUBf+prYDtpWKE8pF3hbuYmZc7HOgmWvR4RD7hT1J1dticc6SAM53PsdpLLiF7bq+rre6CJVzMUNTB++20JEA=
X-Gm-Message-State: AOJu0YyPl172WAgja//3IUC3Vkl7NYmWASmahbwBplV+8NQ1o3fJS1tk
 YSocjunpisAwP7J8A0wcM1EFLGf61HZtQyTq8ilpuGEAqmDVpqClWRA7IOWUnA==
X-Google-Smtp-Source: AGHT+IHjBSxMpK41252gmSgOsI2pFS0ypvHYNqn1ecx9JLe75x8FCLfIevt5bXLWD4vTpkYUHYWcrg==
X-Received: by 2002:a5d:9048:0:b0:81f:9a91:6c18 with SMTP id
 ca18e2360f4ac-81fd43edfe6mr478427839f.13.1722617612516; 
 Fri, 02 Aug 2024 09:53:32 -0700 (PDT)
Received: from [152.2.133.133] (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6a27a68sm522807173.110.2024.08.02.09.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:53:31 -0700 (PDT)
Message-ID: <f56ec41b-29a0-492b-aea5-814b8c149630@cs.unc.edu>
Date: Fri, 2 Aug 2024 12:53:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Rework x86 page table walks
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <a90225a0-b945-4bc9-8ddb-e3f595ef0f6c@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <a90225a0-b945-4bc9-8ddb-e3f595ef0f6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=porter@cs.unc.edu; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/24 23:39, Richard Henderson wrote:
> Hi Don.
>
> In addition to the other issues, this really needs to be broken up 
> into many more patches.
>
> Every patch should do *one* thing:
>
>   - Code motion
>   - Introduce an API
>   - Introduce target-specific support for an API
>   - Use an API to implement a monitor command
>   - etc
>
> Patch 3, 'Add an "info pg" command ...' attempts to do all of these at 
> once, and so is at least 2000 lines too long, which makes the whole 
> thing extraordinarily hard to review.
>
>
> r~

Hi Richard (and others),

I just wanted to acknowledge that this and the other feedback makes 
sense and I can apply them and send a new version, with the exception of 
what to do about KVM guest register state for Intel VT.

Thanks,

Don


