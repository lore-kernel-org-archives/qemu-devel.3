Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1E9C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwm4u-0001gl-Pd; Wed, 19 Aug 2026 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwm4u-0001gQ-5G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:36:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwm4s-00072X-Lg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:35:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc891373e0so17678745ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168157; x=1787772957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ju9OtINuyKhVVoSExlRZKWeBEouYo6XGLhMHp2hhEIw=;
 b=Miy+2y48CiCnw48gEFzQkuIHjNn4lpHZ0w82wXM0C+ri0BU8LjX0oqiYnYxFQ0fV/J
 AE2Kk/vAxlvOe3yr+HR0VbgldKYK55/RbAN3P6JomNQyX7sE8kQ4qYHb8amTc3AbzHvj
 p/IdB+c34vVHK0hbdlh+iSNMdx7ESGgqHWNnPhXf4yRyM8KN+rbQ6J19Wyaq8jkgUVx4
 eGtjijKRq6LOM8rl7UT5eQKH286uZCebaUbtwY2cLE5u83KYSK/u/OsQoX3H8HB5netV
 rZO5+JxMy2ywA5aNnWYdjd0IypBjFl9+z2bMAgyBpRXMxh1VhyzxZco5Hx++QRbFPbMt
 qEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168157; x=1787772957;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ju9OtINuyKhVVoSExlRZKWeBEouYo6XGLhMHp2hhEIw=;
 b=XnSEHGoJoh43aa1C0uh88Mk5Py0LaSeO/JRX7SqZQp7R2mYXjYFA56OAOpg7HwD/4I
 RFSEIdkb3Fzqgyi2lxbbx2YHo/laswYEPZD829a/FAgHroDqZjTzFtFw9Vm9AJtjA2qj
 Uy5AwDD9hmEW9YQdmkZ8G5UPzYjO7aTRAV3fX3g54Kwfk3xUCpLtRLhJ/rq4qNaDFtgD
 6IfLHgpq4xar7rgTbV7LTrXmLwJ1l+AFkKfaefw1B7BOpURo09EgCsLfKA8zDvJPdFk8
 V12W86Z4kqwk8YG1f30zPgOkFjqGL+B4M1tOTZXTZY0LC08iF0k8bvyvqqA2GN7sCdxt
 MgnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RruLL9qCacMcj3SepCE5MRtoNNo1JWAnkzoEY43b+60DHe7ESVRmqXVnVJlXCkIRFCN46pdZruu7B7B@nongnu.org
X-Gm-Message-State: AOJu0YywiAVX1HKC9CFQpiNs9FRKytb0oNp4nhyVMX8ffd6hPosrqSVK
 Joy8WM1Ua7fKiofv4S5heMCz1+8U6eZoEVciEMbOrd7qPV9dgmc284gzgm/6fi48iXMUeFQaEer
 2spYTHlA=
X-Gm-Gg: AR+sD10wG1w2O8a4JoshydmfIhfDfy6Rk+2tDFyPGjVpH0vXG0TV5uDCrw1rEpfn8IZ
 8CzdSLvkdNzOGa120SsxLwsiZt4FzonIa8xapcHIuzSZDMBcwpyTTyXzFa+wKoD3L5Qhs8WxgGF
 ODU9bMll/hv2sXbA3qOorAKbJsHpF0zSuftDyCs7VMcJLuF7Jma55cUHYZ+TBA04LS/hPQORnkw
 liHlgqtOmORCoD9Xkd8Bo8WmpR6hqyKBG8Ggt8kjk1cZMcVbYRyhB0RHlOnDMqUUNMcjLXW/bLo
 Bi/gF00bMM1ieLODcJtIFpi/m9w/aSsPU7inSGu1kq5e0McBArnx4ne9anqxYivwwgejmOIADV+
 pDXS4LEwWgZGvZjBOe+aRQO4+p9bsg9Uz7Hml0rQKTcwpfVtjlVMFgOjZ7pf98Fe8aEYh54LNrf
 3k59aKD2Takj4UqQoLd7H7k16RobwtlvQXzOoa4kr+adq6/rrMjmQsBOYWKk4KXIKPk8rU6ywwT
 j2ABIJP
X-Received: by 2002:a05:6a00:14d0:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-851d384706dmr12205176b3a.7.1787168157170; 
 Wed, 19 Aug 2026 12:35:57 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d36185c8sm998036b3a.38.2026.08.19.12.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:35:56 -0700 (PDT)
Message-ID: <b184e75c-3950-449d-9e0f-6c4171dc89a2@linaro.org>
Date: Wed, 19 Aug 2026 12:35:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw: Remove Marvell 88W8618 devices
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819185430.3467629-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/19/26 11:54, Peter Maydell wrote:
> The mv88w8618 ethernet and audio devices were used only by the
> now-removed musicpal machine, so can also be deleted.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig                 |   3 -
>   hw/audio/marvell_88w8618.c     | 315 --------------------------
>   hw/audio/meson.build           |   1 -
>   hw/net/meson.build             |   1 -
>   hw/net/mv88w8618_eth.c         | 403 ---------------------------------
>   include/hw/net/mv88w8618_eth.h |  13 --
>   6 files changed, 736 deletions(-)
>   delete mode 100644 hw/audio/marvell_88w8618.c
>   delete mode 100644 hw/net/mv88w8618_eth.c
>   delete mode 100644 include/hw/net/mv88w8618_eth.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

