Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E5FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkAk-0002GO-2z; Fri, 04 Jul 2025 13:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkAi-0002Fo-13
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:26:00 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkAf-0004Tg-Tf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:25:58 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e82278e3889so822978276.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751649957; x=1752254757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mrfecAbSmjbX6e6b9Z+wVz+JalRW7xrqzCQz9jMHwrs=;
 b=sN+viqKdwo3Xe7/S69Xwz6JZYE8ElYj9Lagk2gY6Q8DqCFsmy403z7FWmaHyyQfpcQ
 wq/YZNqImk2WWrQpyQqafgRximj7f5As4HBkQ4IhMCyrE9dwzW4cpBXF+HTsf6/K5vgf
 3ZzVPxcj5YCx3UGz4QHt0tyloKgIw+87wzFoRLbUI1/yyyjTBPwBcup4Dn/I/Yktd6cu
 Sy8cHj4etx4rUj8R/CDn2Mx1U+aYLwMKrx9NZLZ9/k02yhfuE/AdF6sTD8c5RsFtNbiF
 /jZvmvPzNi7KUMpDF80PEH/k3Dba1IndQO+9LHw2VwlmVg8Go2Cqc9NJ3YxaOBm3XJTJ
 bkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751649957; x=1752254757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mrfecAbSmjbX6e6b9Z+wVz+JalRW7xrqzCQz9jMHwrs=;
 b=cvFGyGPj5nYXT7EB/rHFQbMyPRwtcr6bisZZFSvYX8jx7Y6nCVRykjXsV0FSSHkJZF
 jgO5Xsj2czQDNINMl/wKk9lBown4iTmJuDRA+E0jP32B+u0Rw+jgHrxilwO9V/o2vbSy
 u+CMEjSrknhcgemskVgE+MD0YmBdGq1S1xkSlwH//UOxwer2x54Bqtdg1VvoaUyV91DK
 HdSdoyx/kbK6cZ2Xf7xvIlJEJhc6jY/LjQUM5xduC3DTCMa8pA1jGu5UjHt2Vzbamj7a
 htb0vAelOJawJvp0fy7rbuFLr8h5jfa88EkBcK6xXkJ57c0UJVkXJsE5dEhBqCM0Fnn1
 HxyA==
X-Gm-Message-State: AOJu0YzqDs3YdBwdXthCjV+zgLlZigo3Z5BD7m10SRUgyVJzRsAg9aNJ
 +aZ7hxeB9uVcD6+whZRftTPhgl8l2ggkNMmk3Vr4o+sVjPc4E1+K8v/KkLbJhKj+13hmsZYi4su
 4QlvuMuEp0KJc4RHWZY0YsWcxvVx28Wx9G3xQ9jkWCAxbiphJj89V
X-Gm-Gg: ASbGncsfDBBNDqOlhxpZepmF3luK+yczzE+ArQsYngq1TDcFvf9FRFi/Vitlp2SzkAw
 nmbNPHJUTUUcYVmX/jZ7ZDAKeVcRth2keiqAy1uAA2xNPcM9yqcOGqxm404DO6M1z2+k0OPzbPt
 0AZhesz+LbiqQXL0SAp6z+aZKGdSVILom54oMJ41a2f2n9
X-Google-Smtp-Source: AGHT+IH1cpJGrsZmTXbS288FxULKBkn2zivhZ6nU3xHBBnbpMpcHqpx3m1sJdmZDxNy0cef9+sZHVvx2bSkCjW/RZlo=
X-Received: by 2002:a05:6902:1887:b0:e84:940:e866 with SMTP id
 3f1490d57ef6-e899e3fb4c7mr3394716276.6.1751649956798; Fri, 04 Jul 2025
 10:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-6-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-6-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:25:45 +0100
X-Gm-Features: Ac12FXw6OSs42-2ayJJ12wt8M7DosRiH_94ImGfTFsMxh8rnig--pZTBLcpAuHM
Message-ID: <CAFEAcA8YfZjwS-DWGDCBK8gR4ShcQ-a+NC=AZk5b7BGNK6JUig@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] MAX78000: Add UART to SOC
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit adds UART to max78000_soc
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

