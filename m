Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851DFCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQv4-0006gb-69; Fri, 05 Sep 2025 03:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQuw-0006fV-Cw
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQuo-00016E-UX
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757057479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dwi9XmN4n+EEr3+CrAx1bsV0jC1knD4qOO3eFVR4LqA=;
 b=IvkHf3UvhkJ+FDCaVuA2zldAFVAfT2bmhkSytaCNfcFQMfehjnmcPh1Pdnxconk08qgBPv
 qIBNEmEC1nbB78TDj/jVwLytvZA8igfCTemZ9PrBEamdzooFQKpsgqmXn+i/obq8IchBdA
 ZiN2wlmDi+7nDfCIAxGniyWOrOziq5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-vuo5iKMCOpy9093KyBnPQA-1; Fri, 05 Sep 2025 03:31:17 -0400
X-MC-Unique: vuo5iKMCOpy9093KyBnPQA-1
X-Mimecast-MFC-AGG-ID: vuo5iKMCOpy9093KyBnPQA_1757057476
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45cb6d8f42bso15329245e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757057475; x=1757662275;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwi9XmN4n+EEr3+CrAx1bsV0jC1knD4qOO3eFVR4LqA=;
 b=tbGFaCwumDjaS8FBWjA+EgMPgO1j/qtai2n1duTrLBdADQUOJipk6hlJ5bq8fcj8Py
 haA1JZJPQppqthV28CTSnC9by+1gp/V9N/wp4SgDqDRvi+j0XIHjulHLqUxCNIweKJXe
 RqiQTRW4hhotMf7Xbsyu7wPzLtgnQR8kviiYhbALqb+5r912z1x3I5K3c2+QIeOzQwCL
 PjVsiS8s7ljD7Hv3Rw5f8jeGCxtdw41gFkwmt2sLl8V2Sy1fUZ0ddCG4aR35gOOw+lju
 0TQsSl6i0F9fVhTEUy+iDJ8BfVXXK3J7TzRTLJOQi20jkQ/HpF1G7uKjaC6K22fJhCSN
 NDDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJTeNkw4L/8grHuqb8Xduxos8aITFu7OiTBxm5Jc7Y0XVyhEi98fthfZOfY4mCaYB87nvR6F4EtU/B@nongnu.org
X-Gm-Message-State: AOJu0YybN5JVjRNl0K6ILDLstRLcruBYV+Lg7vHtiUcg9a+0mPIVt9R6
 ipptM8wJPIaq7f6DQEx6GgBFr9rZDBcNXEhVWLu81V+GtH07oM9/6tnI3noNFAAj7a9Epq7RnnF
 D/3UnB3KgJYP3qS+73HboVCuZuYvzPX6hfNhzhuPPe0vwtaabsn4+vJ9RdRSLpc79
X-Gm-Gg: ASbGncuvc5njzMGrFU0fTBKddISnvXPxUOjOPwMG4cyiRujAHZpcTWQy5oyUtWQJnq0
 +HIhDgHl4UC0E1EHFxHoRppFtLpB37QjgwtilfhYq1X7XA51FT59k6l1yxlsjF/WdO7aTe51yNy
 ar5iJK6TgNnDes+DtFkdmTGcljdR6vnCggO5rO/sbcnIPb6Trnv4sFSMDDcXZlPLYOcqJBTTdE0
 7/ZJEp1h9949NOf1TDwKHLnkoYIn7nzWmhNWKoXwmRy3c76e6dXpYzDGozZK94fR8R/8W5mzMwH
 sSsgM4sGPiaj5cYbg9NHPZn7Zw33tE+4HVFzUAiMuwGEo/3a62AOwc2mjwdgVNlIyMbX6vR2LJW
 UPXevRwdwMlQXJp9fFGgdDXYxAIM24ctdB15tOx6aK2A=
X-Received: by 2002:a05:600c:4512:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45b8555070fmr179043015e9.2.1757057475477; 
 Fri, 05 Sep 2025 00:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHhnPkn1mDBP3IyJWBXRAdD4KlkY5UIgt1UxsKGlPdu+yHY4AXtAK9vw+swsjJ5rMUS3PnUg==
X-Received: by 2002:a05:600c:4512:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45b8555070fmr179042655e9.2.1757057475037; 
 Fri, 05 Sep 2025 00:31:15 -0700 (PDT)
Received: from [10.173.24.179] ([131.175.126.3])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45dcfca0aefsm36708675e9.1.2025.09.05.00.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 00:31:14 -0700 (PDT)
Message-ID: <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
Date: Fri, 5 Sep 2025 09:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing includes
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/4/25 17:21, Peter Foley wrote:
> We're getting errors about this:
> linux-user/elfload.c:2770:36: error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'

Queued, thanks.

Paolo

> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   linux-user/elfload.c | 1 +
>   linux-user/mmap.c    | 1 +
>   linux-user/syscall.c | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 26c090c95d3e90ad4a23a927267e4106f68975b0..edbacf041f25d88472c95efb4eb9bdccd81e9902 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -5,6 +5,7 @@
>   #include <sys/prctl.h>
>   #include <sys/resource.h>
>   #include <sys/shm.h>
> +#include <linux/mman.h>
>   
>   #include "qemu.h"
>   #include "user/tswap-target.h"
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 002e1e668e631130526053599e1d18ffb4b4141a..9e92117ca3e8e4f45cb333366ecf3668b8986200 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -18,6 +18,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include <sys/shm.h>
> +#include <linux/mman.h>
>   #include "trace.h"
>   #include "exec/log.h"
>   #include "exec/page-protection.h"
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 91360a072c7f478085ac1c7cc8bb2026f8b32038..4101b0e4e7812740afe7a4246a902a5364d7c331 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -101,6 +101,7 @@
>   #include <linux/soundcard.h>
>   #include <linux/kd.h>
>   #include <linux/mtio.h>
> +#include <linux/mman.h>
>   #include <linux/fs.h>
>   #include <linux/fd.h>
>   #if defined(CONFIG_FIEMAP)
> 
> ---
> base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> change-id: 20250904-includes-19d9afaed67a
> 
> Best regards,


