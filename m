Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E96CE7B06
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtU3-00027M-Hf; Fri, 14 Nov 2025 08:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtTk-0001oz-26
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:04:46 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtTh-0005of-LB
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:04:39 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-787da30c53dso18860567b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763125475; x=1763730275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ibAtVrD5u4EYwMwyp8Eua3TDKKkAx9oV2MDQQWvTpRw=;
 b=fZ2mnJOStwKJ88O7dIwwl5q9mf9BuLqeGo4kbWrpSi49Bxe5mnoq7PH105q6SD0ay7
 +zwVw+EZeB2A+/pIskZvjLVbByFD59OQ9iia4ZEptNyTtUYq9JhmJdCIPSjI7Lk8lVvJ
 N+ZGlu00ENTf4d0vjUK/YZYWXrmzOfcmtzkAYPr6C5mOLsU0pAoBqU447XvhScHXW7Xk
 139gm9lBuIAdOatS7pMa+qMpQsEViPoZ7BH/GY+CZJegZiy6cvC2thMTTtvNLvtZLfuv
 TFQ4ssqmkEId2NjxmrkTervU0aYEzyNN75BPJrtGCSGvw5Ab4lQTcCDrz3+kpv/Q7dmG
 7roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125475; x=1763730275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibAtVrD5u4EYwMwyp8Eua3TDKKkAx9oV2MDQQWvTpRw=;
 b=ftOskA8Zt3G0TTN7FKNyX5JVWXjISsd0K/wijH8tAqlTQZTQpy9GaajXWQ4OVA+Bn1
 dHTOrFGEhCB9hkyXTLTOlZ57L/9HgcQL5GbMNv9NPpHF7oKyJZJ+CCKwSp3JeTe+mwn3
 I68p7CT4nPcZvdXuroR89HVYcBTfIG0nrsh5GVjo1uSTRGZXMCGFMPQyU8gfRowkbnHP
 h1Lb/hMRq3ZAotCLjEmGLl5BioYfXkxveh8T+S2Zd/AEOyaOG9BnLU2O6P0tKwgYhPTY
 siVtHDELJ+ZRrPEfLrbw+ZsoOIv7TPxoHmo/4mJdZFMJPCZZGs2m5aCIBApUNXDJ9W52
 U2/w==
X-Gm-Message-State: AOJu0YwYPqEyzreP22vh0WjlJlE+IS8//6Zo5wJkcaqQdvukYlC6oP4r
 Ytd5U41/9JN3V9xI848QSF499YKvDmphvDM1kzMtG9UCbfioy6DtbTC4r4OKZdyXqshdPJ6DxqO
 jlXFSpDOzGH/YBUkNSD/z1A2G1SygINnNTgyzNs8TAPtXHMyZ9HO87Dc=
X-Gm-Gg: ASbGncvjDSRyC5L4Ndu9WqC+v4L+qxs3xcFXn9plV1BdZiBFG8EOPWWXFZ+bjdNKqk0
 em7m4M0OEVbyTzvJTSPZCWIie82l/gCDXdXV5GO+woxzT7Cgh5gQvDfzozcvEAssXTU8QJILMul
 /Z5gtkQqlLg1zYaVZg2xTK6R02vJF+3ds0XK/5YZaXqgNtUTEeBdU2+3i1yGAKJqRq27/hsHWy0
 M77W7h3NAJMmG6fSaVh9YYYufe6cSP3h19s4zVlmcRa8xCiHwiit0kiIkpken6mro9S5pZ/HIFI
 aaTrINg=
X-Google-Smtp-Source: AGHT+IEEJL4fmswJ4mL/qtZMsXrpqpktFe9GzP1Ks6zGp32PTzMQ94LoOF5FMDMgnOiY9FBXBRNr3tRKYhTAgWBKOCw=
X-Received: by 2002:a05:690c:7085:b0:786:a3fa:cffa with SMTP id
 00721157ae682-78929edafacmr28733027b3.48.1763125475102; Fri, 14 Nov 2025
 05:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20251110161552.700333-1-osama.abdelkader@gmail.com>
In-Reply-To: <20251110161552.700333-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:04:23 +0000
X-Gm-Features: AWmQ_bmzNTGYAC1lthx_b3rdZGF7XzO9Vu9PbGz9_5oQJDeFqv9pFH3zkqcQlaY
Message-ID: <CAFEAcA-xt_1hFXELMyu+vGtnP9hZsZEaPLkT4km0YEEpE4HzJg@mail.gmail.com>
Subject: Re: [PATCH] target/arm/cpu64: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 10 Nov 2025 at 16:15, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> cpregs.h is included twice.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>



Applied to target-arm.next, thanks.

-- PMM

