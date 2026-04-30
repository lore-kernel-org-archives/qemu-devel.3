Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5991CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGa-00046j-HE; Thu, 30 Apr 2026 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIRWb-0004tQ-3a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:33:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIRWY-0003NU-9l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:33:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso10506205e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777556028; x=1778160828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dEpvF3607F+qemfhpeYGfsinknF3G0PYbhra3ynjbnU=;
 b=sVoMLJ170faQeixgmjKgvFUrOzt59dlOEK3wKzW4bJBeFyuMOQh4uUS+og47/EEaL6
 R9LY+9gSAdEFX4WDpwJNQbIAOOtnSuvR4w/65TwwqzHi6nH470ShH2lSH5AajbMqXPxx
 KAz21NVNX/630rjG8xJMb9gZU4mkMfcrO3aOaqsvmVudH8KQBdj31o5wNbvfiin/05Tc
 e3XYr4yYhES09D1eJzTZAxT9/TPMjL/m40y3VMde/u2C5djOp+JL22AttBz4fb27b4G0
 NMV946sHsOaEbi3ezLefceIYIGU9KNo7KqGblo1XSdVtENBS25kP/OsLgMKmDaqoaa/j
 /RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777556028; x=1778160828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEpvF3607F+qemfhpeYGfsinknF3G0PYbhra3ynjbnU=;
 b=XlCKWJwfuAC8IpGvD6FdW8scPAUVivnkUoGluNN8MVmpw9SKyIzz+6ChsDpJLC8pMS
 9ajm47TZAH9gncCYaSbimC3cyyE8h8alfTNjjtkSayzrVMjtqDFOW7LUpGu/ihKN5ToH
 JCRxTk7vcVb/HcTnbH9VqvZDTaMkrd7klmi/JRFrNwwSZWu2zIjxP9uxkjZO8gIZWHUp
 wycEoJASShB8O7slxjy24jx0J9ZUJsG0ZSbY/Sl4oIM5iv2vdLR414wLvnjflHHURA9m
 PJt8bKYNU3HmZ2Rq5uEqXLk7bE0u9w7SADMcnFN/7FjPLnPGHbXNXNwUdGZg/UrGjVG9
 Y4kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FNaUd3TQjnDI508lUEelfsEEgxDuNENVTFRoUY0Q5/itw0ar9Q0LuMBxYFDZdkvG7dGleAthfJqDp@nongnu.org
X-Gm-Message-State: AOJu0YzaV6Xit5TaTejkUzWTWDp9VE65y7/96sgwIEVyBLf4nm9q95Wg
 LBlmAsyN8qVUgbhgwApPck2+L2ZVtOuMXOhj2wN4U1loXhSgmoTvzc1zFuzJzk0BvIg=
X-Gm-Gg: AeBDieuk7ZBstwL9vyj+Yk1Tc09jMOROzP5e5wY1kgCOpPDQuYXc/MM1O8Z4RTT1ndv
 hxYvcZ2bTc9PnRbdUDbICGuPhMFxi8Cz5vG+6U5yKpACkDzmToX80/JYef7CDU+23CnoxoqTDAg
 5CQdX7CqIHk9/Yv4951j4bn3EAE6p72LWWghwuKxXpL681KYpHsiZcRiSLwA4Ka3fcElJmyf8IB
 hYLqU6RoLHC7wvH1j4cDoWcoFuel8XKoX/aSERNclg/3poKggTbnVDmPb1KTUsJ0d84nkPeMZeD
 OISldf2uQE29kjyglB9ZdHANLSc0UTJUTB9uiECgOlV99toLoZdOZLxlasPDt3pxGArtNNEjMA/
 avDbQ+2LmHU7/dhXBBPQYn4Ls7A1ey7VNKFPi+PJ6EAuQABRi6VmFsKbnpzPDv5NDgtMz14ucAs
 4J8NyAhjy771jmbtjZx2KuUmcOti75OmbC02ZUP366y8EPB8cqfPx/3z3qDZX73wR/bFG65yq+k
 yQc
X-Received: by 2002:a05:600c:3e8d:b0:48a:53ea:140b with SMTP id
 5b1f17b1804b1-48a844a4728mr50392305e9.28.1777556027849; 
 Thu, 30 Apr 2026 06:33:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c310048sm40810635e9.22.2026.04.30.06.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 06:33:47 -0700 (PDT)
Message-ID: <71c7f6ef-e22d-4fd8-b57f-1408c1aabaf6@linaro.org>
Date: Thu, 30 Apr 2026 15:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/25] hw/i386/vapic: Cope with non-page-aligned return
 from cpu_get_phys_page_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/4/26 11:37, Peter Maydell wrote:
> Currently the i386 implementation of get_phys_page_debug() always
> returns an address aligned to a page boundary, and the vapic.c code
> assumes this: it adds back in the page offset after the call.  Change
> this to OR in the page offset, so that it works whether
> cpu_get_phys_page_debug() returns the page address or the exact
> physical address. This will mean the code continues to work when
> we change the semantics to standardize on "return exact
> physical address".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/vapic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

