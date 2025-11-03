Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77452CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFr2E-00086x-NU; Mon, 03 Nov 2025 04:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFr2C-00086D-RQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:39:32 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFr26-0004pC-82
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:39:32 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63e393c49f1so3750121d50.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762162762; x=1762767562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYUQwz67P2sbbLYZqyPo0eTemBLPD2HKKjDtG8SKGug=;
 b=SIqFDXtHFsrDKc9sweYkkRWj8T947LQFHktWkpkNv6KCV0YJLB993alG0J00N5p8gP
 3Exe5l1Z2xBTQ8I2Hw8HF/N9xJCG9AMniybnQ6bzStVdfTYbeSfWdzU+WX4VoiJEGTCr
 UymH3yr+YBhW/9y66yQWm2AqQFBv+qDaZEmNlRLv3ERBweTn8jRCftdx/3ZcUL8yXt3N
 bbowcXjF9pkqumcj7TELyfZjyMDR35qBzszBhD9K91QxPe9XMMg5md+MS0CWY7/MrqZ6
 MmGJ+pesTpbEXMBsUkQ/McMSAjKxhwVE4CEiqTghmKZL4IDtLC2U85+7SKXDBdYlE2HA
 hYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762162762; x=1762767562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYUQwz67P2sbbLYZqyPo0eTemBLPD2HKKjDtG8SKGug=;
 b=gQYESteNlbCgRvr7UOewnHQ0Jz0wJ/ppCZQSp1I7Idw7eglP6DZLfFv7VhADBg0xiN
 zpwpdQKoEyUE8NjSbjNNx83xD/KIckxyjtctvjaA047ODt9xMJZbigtWDNe0CQ1mjJIP
 5rb384735xYzOYDZezjBY76xQ3+0ZBR/1BeikZXlBjO7ncnkd2EoZmFunQSt+eE2AIiK
 nJlhjMPIHAfw5Rbh9TGL+tKmxg/EEgHKa1KXkLMak32KsIa7pcBRWPJcj+7qEvFi8x7s
 N3kuUJIZ7lQyYuXXwTAWv0hoL5qp6f4wra/K9wPMWlcDJXohkPMXJka+wW93eBFifEX3
 CPHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVknp5f+pAO3uB23OEJawCjXzX9yM6QRGIjM/P6AAQdykIsBvo9rn17sLd7cEI1GqNY3RudFEo8fbWM@nongnu.org
X-Gm-Message-State: AOJu0Ywu2jTD6Xgi1GIOld5IWPJQlrYw7RZe05ZyEbzMNjufGMXCYz7U
 k55me/J9L3CcKBhIjSWh4v76g1ZbdJmxluWRhBpspw0wEbw1HFTrcTbndXzGyx5H+ynNlW1Xr05
 uWzTpwneUNCMWv/iLFqw3icFF8HNkE8lUVmCFd+pxZw==
X-Gm-Gg: ASbGncukDAjQh5IVGZsJU5gWldadEoCcR3xAz0HKnvZX4K2IgziF5vFfpSD+/KO2M6s
 3wBmjK2+8BHukp3hi/Gc9oLxAcnT8iH7Hbjbg/ljSUmzMLHe0RxW7clY577eOz0eRTzb11dGc5+
 cNRcTwX+3Cl3+YkQ4Ai/lqQ6jk8ozSHh6sBRTK8klpuK5qtIrScWtngvY7vJIR9dasInJi6YTEH
 vMpdHpFCm90eSe5STQd/ilIAT+7daLBCBvIwxgVrJretkDJk9TZJAWJZIt3WOvpXS7q3WfA
X-Google-Smtp-Source: AGHT+IGCNckNl7Bpw7KKzUeYE2R3t+usOTlPoiRpCL+LXvaFbZ5Y3fxIhgsAGrbS7MDLo/c1+71F1bvzZoOD7lE0hJE=
X-Received: by 2002:a05:690c:3201:b0:786:5985:f611 with SMTP id
 00721157ae682-7865985f92amr79433027b3.20.1762162762408; Mon, 03 Nov 2025
 01:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
 <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
In-Reply-To: <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 09:39:10 +0000
X-Gm-Features: AWmQ_bk9IZf0e_Iy95sJ7pITHU08a5wEVviFlUx_Oh3UmPop_YLmrOt2and0IvM
Message-ID: <CAFEAcA-4bJaJyOYdTeBsb0KdKRj6q-ABGRzT2rQk1psNakkfLw@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 3 Nov 2025 at 02:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> Hi Balaton,
>
> Thanks for taking care of this ...
>
> On 11/1/25 22:22, BALATON Zoltan wrote:
> > Commit 9099b430a4 introduced an early return that caused a leak of a
> > GString. Allocate it later to avoid the leak.
> >
>
> I think we also want to mention:
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

You can if you like, but it's not essential -- I just
forward the info from the coverity reports.

-- PMM

