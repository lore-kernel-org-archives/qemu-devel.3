Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520DCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgvt-0005BT-G6; Thu, 28 May 2026 16:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgvh-00059N-HF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:02:09 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSgvf-0004KW-Rg
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:02:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso73264405e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998525; x=1780603325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5i0BTQPAbMethOHnPVIYTb0cJcy38m7SP4182HgPHe8=;
 b=zQl9rM56gxVqLkntZJVrYfzZ6XrnZJ65vSrKzChWgopO15iPQYSnOr3pMjrj6k1Dc+
 OMfILnhK2j7XPV6kP0FGwr0CWFG6EtExe7X6kk5uTzguCxvaHcx6PVNohJ0Wt3nas7as
 0z7q5l7xF/3MvGG9/b5MIZUQPUwh6+2zzbAwQ3JMmMl5IbGLJsoc8ItZkLpp2NCbIoom
 HjEYc+78wNGkI4WI0f0GKyK6srnMhJUyiCiz7GpZNZCSaMe5jIRoOco2abdc38hAsvkf
 hwS1qdfzrW0jaQjKxkF5UP5gSk+bs25qtichqoP9XspY2XQapCVih+qOMC1AsgmFaLEZ
 1K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998525; x=1780603325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5i0BTQPAbMethOHnPVIYTb0cJcy38m7SP4182HgPHe8=;
 b=seTfb0BzrzKFoy5sXcxsnq1RSvvAATaswEb/P9FZNCAbp4EkfvR6U4r1lyLE45B+Gm
 r/k3fZtHcPs4aEJJ0Y+LEYG8P7igM4kFhqx4w7oYqJTg9ThcQovhCcOFKG98leU5Iyda
 WChp19pgxk8PkbWoGy0uobYseUeY1SrpKuO7PVuBFhOKeLd8xqOJSFJchhgY6QzKLBH8
 U2lvTefwkLAXfXu9V8E2FJoa/Uc1X1VWujckxrgptuyjJPueCdn9JWDGFSy6uq/f0/wo
 ICT52cFYihpSSGGvZISqocUt3xbkjTfZp2aRFVN36hfBLOfVnin/1KnYEL8MVeVsamrJ
 jXUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ84+WINpD/wALwA/vI9L05laS6lptB/R4coo0910pYP9kt1pKUrXXrj+guCg/OnrohXkjD6faWq1llA@nongnu.org
X-Gm-Message-State: AOJu0YwHMIj8cJkXhjLqZGUaw1kwJMCYWeG47MPyzm9Ibp48WpdYrNGm
 4GQP7T8b2Cr6RP+UlCiCWIXurL2EVU7YQeNcg9nUOpxtAAv1sHqM3mjBx+FLLRl97EI=
X-Gm-Gg: Acq92OE823Y9RmSkzr94FS6v0iGuWh2AqZkGvtt81vS0GSe2nGn7fkPCw40Ol/KrZKX
 6K5+9vwQEdc5HCbVAidP7TzNV4UUIU78H3ScsH2o+a45cWF26GaOuyeRlXqbhkNB7AX10wcRIF/
 U5sTb9eUA2D6jbcKsnvRNiWy6iwNyeIdmdXMZroHYTWKppEuawMLOwKxQU13y2rODW4982CbD1+
 xPdSKwUn5/yMdNUII6bW0VI+0DMWzmxxAQTOLp/wyhQ1GKQrPUQzpihZGMcUVUhoJtThlUgILqU
 AgO4UDI48QZgb1DlQuY/qGIGVaZlTdD0vzhIozQXLF1qRW+x5/4Lq9U/Kq388jeSjz7cskMx+94
 W3tG9bymFsQgghwlbdWhaI2wKSUoS73/H3wImff2wf2IvVF1e/RxKk7TTvekDUYwTUkqpLTZMrg
 yM7zGwGcjt5goGfONBjpRCryqMZw3BbBRdk7xuAt+kw7jtZY/+Pkfijf2Z77Ob8S+ktURRMWNDX
 JRS
X-Received: by 2002:a05:600c:3509:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-4909bfb4f10mr1497555e9.15.1779998525494; 
 Thu, 28 May 2026 13:02:05 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490929652c9sm57898155e9.14.2026.05.28.13.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:02:04 -0700 (PDT)
Message-ID: <2ae981db-d7c6-48a5-8e95-beb48a8da24f@linaro.org>
Date: Thu, 28 May 2026 22:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] i386, microblaze: convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528161450.3564396-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 28/5/26 18:14, Peter Maydell wrote:

> Peter Maydell (3):
>    target/microblaze: Convert to translate_for_debug
>    target/i386: Convert to translate_for_debug
>    hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug

Series queued, thanks!


