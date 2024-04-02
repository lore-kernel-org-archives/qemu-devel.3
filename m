Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E84C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgox-0004Ts-8N; Tue, 02 Apr 2024 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgov-0004TY-Ev
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:17:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgot-00015a-Dw
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:17:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so6319062a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712074626; x=1712679426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mfxe2zxw0/gIC6GN0RyG6svwYpqTo4X9MoTxCaMZm18=;
 b=x9TXgodeL++p0U9LrMpD1Yq99JUzE9Tc8ykeSTfl7xWTVSMzaLlgZBzz55SVkjc/pm
 CUWkzy4mnvAVCH0HhbzViqi78hQmZNKYloN1zSUer0941F3lQcLSngWRbY4i9tVw7zZq
 o6GSVyCQCkOem+HZQsYnu4VZzmZcSlKl8wkx9RTyz30sTZxXFf5dEOqLu0wOP7OcOatJ
 8ZYkPew84CkQDrLzKHDzoSY0NixMhfswdXlHTWVDw4M6FnHVI82bnckVTZr/X9Cqgj6M
 amkFpbRIcdTs06uboZx4JB/+jM5OtEpBARX7gqtSqZk3+h1jNlB1D4ESVjjH/7EIvWbW
 afxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074626; x=1712679426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfxe2zxw0/gIC6GN0RyG6svwYpqTo4X9MoTxCaMZm18=;
 b=WHTPpjMrPxojpTdGpQbjHHHSH+qhafpN+Aw+N/bp6AXvmmpnujEUaKmVY52QV5LSWI
 lBBnwHzC2hN7JNLwe/UN1iFx+7L/Jtmb0Y1u7E9jIJeRmEI5J7RuZCsdCKUfQsVf2KH5
 89IgSUEkqVAMWPIoWRAEaobt94wnXlUkVcT/vV2w11q3Tn3rtQzlvTO0eGsbV0eEGmK5
 lFtj/OahYTHCMIkLOgQzoSW08kxxwRhTE6wDujhKccNoWRmHmBy/ZpmXSGkxcFEaF2R2
 ZF6eSLGsQz+Vjt7jm1JgqRdW4gVguuhfBfU9xbvEExRjEm1GgSzl+RjNYi6XkA/X7jR0
 sFwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmmEPYDRJ/EcXo5l7c7PP58dvH8ISsvZ7zv8DfnmRmdsWMpy8asJfeskleR7WteEZf1hl9FhqwDFj6OrImccByf+Oy6SQ=
X-Gm-Message-State: AOJu0YxSS6h7tB8ZklnrRmdCE5T46xODZ5zhVlCQKolbE61Oy8B6mGeG
 bmZMV9/829zv0slyV664mX+iNLgdyTjcrnd/6fwT16tKFHhTXa8WjX1fO7BERAGLJLJUxUxgLlz
 qFfckjqIJGVx3PznZEcQtPd34RiXfezMmQSZMzg==
X-Google-Smtp-Source: AGHT+IEZobx9yhITPbGD1QpMm5YX3GGsD7LiFMfjRyEP/my3SznxJtphqDBLdc52Qh3FaHAwiGlZBQeWqR8Ud6lQxBI=
X-Received: by 2002:a05:6402:13cc:b0:56c:5a72:176a with SMTP id
 a12-20020a05640213cc00b0056c5a72176amr12038394edx.3.1712074625918; Tue, 02
 Apr 2024 09:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-21-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-21-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:16:55 +0100
Message-ID: <CAFEAcA-KL9tj8NggU-gDPv45Hki=nLTA+W9E6p6DXH3YVx2V4A@mail.gmail.com>
Subject: Re: [PATCH v11 20/23] hw/intc/arm_gicv3: Report the NMI interrupt in
 gicv3_cpuif_update()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> In CPU Interface, if the IRQ has the non-maskable property, report NMI to
> the corresponding PE.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

