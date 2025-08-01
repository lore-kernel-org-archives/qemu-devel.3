Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15E7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrPo-0003R6-Nz; Fri, 01 Aug 2025 11:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr6g-00012u-GN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:51:42 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr6f-0007Hm-2C
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:51:38 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71b6ad2d6fcso11317267b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754059896; x=1754664696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+uWVbMs6KsB9KhadGpEUUwoeD2/hQ1p2s193qYPj2aE=;
 b=UFD/A/tXZ2JNmwOaLxIiQZk4Yea3VGrNBXSsda+oWOvXxmgqLCWNuuCd4DvxWaAWlo
 bwfBp2lQmqhlWC4EC7RpZVAGNgtlR45RGnEiXml8OF9CXma47G78lsN4lYmq/JsenxPJ
 cUt1fOQt5uvPt3oZZqZ+2eFc6UkB8xjPNHNUwpQkOSMzXBonfwNXqWyOQBTAO4/3AEtd
 d1/AX3LeTX1F3pkry/tl6svImUrT10e3hyIsYKT+S/VTs62kZgj4Pt1ewX3J9pqIt0sY
 WGFBsv7qdjxTVqB96pZsYAgfHfbWiWOelgZl0bXWLFLRw972Te7rsMbcg0UM24UJgjK0
 mRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754059896; x=1754664696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+uWVbMs6KsB9KhadGpEUUwoeD2/hQ1p2s193qYPj2aE=;
 b=EABJKD6g7IlA3hu8C+0oIqhBxaUIPTmnbubjXeGfivuUyv9tTIeO9cRAn8/y5Ep3UV
 gqY1NsNEmu8rhIWgZ0BZdSd4FTD7TWd9TJIFavhJ2qohQvXcD/nypENPogymiIByPfws
 p4SCk1eKt1yaxAw5ZjTq2jU8HJG2IG2ZaJkEPU6HkkpCVVAPjWUJ9yVkFGR71X1I+612
 10qR2MhqmTErdg0QHhCHNCLYx3Kwx7Pmvnr9y7yvVt9sbf/mnlY0VZ/E9VRzmUwhBms+
 3IVcgg6Vv9ZihJ11FYr1P+ZQHLZ7M/HJlbkxUa5ItCHTvijVegxI198FkNkG+Q9CKpcd
 UkZQ==
X-Gm-Message-State: AOJu0YzLnesmDAMOls7yKBYfCuf8UtPc4+7107msqvVwAprPxNRfUcSd
 NZCqrGI5giAqkWdRc0nbbyyTPOySHOwBshQNcAYVWHh9zaBu8q5CvgTnXHVjh4LBpZ+q4Laen5g
 YJi6MSaLj6/Ontz1ZzRdqTIvXFF6Zr1R1rreZUWK7Fg==
X-Gm-Gg: ASbGncudhZTAn70ivFcTMoHN+s3Edyg4qiWciO2Bbji4/+NO3iwRgOjEurLBnsI87NY
 21LyKfufvJ+yamkHzjyJKunjKTGvTbQM1OJubIvGDhbC5/BOmAbIbSf/RoWhs5qbkfyeosZVze1
 brdSpMd3nwVzBWX8c26S1CcO7T35RmYzP69mevQn7BRXgxFD0FfzFDfSB/F8oVA3wSf0ELn0Zar
 XR3j39/
X-Google-Smtp-Source: AGHT+IESxDCC4ymsS93QvJTmXcAkaRsGwK6ss5b0Eh64jk5ANuLJK4Ei3v/KWC9MS+pdwLI1sbTkIMwrVB8G1BS7cKY=
X-Received: by 2002:a05:690c:6903:b0:71b:6bec:7f23 with SMTP id
 00721157ae682-71b6d802729mr38643727b3.32.1754059895408; Fri, 01 Aug 2025
 07:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-3-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:51:24 +0100
X-Gm-Features: Ac12FXw1n_Ko0tyk4ZOTZGSInGwpSaMCy0zQsxzEwapVS1S6NtgH0KoP71Bqpao
Message-ID: <CAFEAcA8Ei=JNuK7+gBnSt=Qrspi4JNKjzxB2_r9egn3HMKNqQA@mail.gmail.com>
Subject: Re: [PATCH 02/89] linux-user: Move get_elf_hwcap to {i386,
 x86_64}/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Jul 2025 at 01:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
> Duplicate the one line function between i386 and x86_64,
> as most other additions to elfload.c won't be common.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

AIUI the FEAT_1_EDX field only uses the bottom 32 bits
so the type change should be fine.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

