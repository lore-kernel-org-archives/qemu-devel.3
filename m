Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2507ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElyQ-0000hs-Or; Fri, 31 Oct 2025 06:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElxx-0000Lp-3L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:02:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElxr-0001mE-Qr
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:02:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475c9881821so20299445e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761904951; x=1762509751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QyptfX3oENL6vKBxreh5YRSIKOgJWGuBKxVtSnSCzv0=;
 b=O6/TfHkH4HSFWHaPXZp0a/A9D7STsEjBPwKhwCjkyE3KaKZGdBGd3ViTAlSeQ5xNH8
 EWqdmhpHlmP1IHh+YnNr37FfJnF0ZXcdSiF6QojSZ5x3/QcXIPx6HCIyWp02OmvegLDA
 BIkI/TAzNviLD/oTluLPpYpSF/A1B5FsRP95+9lB1YsKpazsub+zNQYsyrqxvGdZA1qp
 kz5v4Zq4a/tnShM1Q6/pCLWiRVPQb1u+aoYzgh+S/KegsSt/No4MvDg8PyaRPqXwOyB1
 ja+oN11tgNXwOQJvkTNOV4cqe3r+Dp1OPtUaL32fmr2Ln+qCVoHG3OWYhGkwNli8DlMV
 C59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761904951; x=1762509751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QyptfX3oENL6vKBxreh5YRSIKOgJWGuBKxVtSnSCzv0=;
 b=F7BaP5/cjoNQCtXG8IbxbNGvo8scaXolSkWZC+sETtvlqUxmPpL8BlCvWKVWy9l/Qe
 tJ3v7RvvLK5LnSQ7kjxVSBEd0Yg+u9ELR+GWVomk9UwyjtRK1v7aLsxHYE70PqneeLoB
 KdFyrF4B8NSSosMcOklGFdGLCDWfo0htFJ0DddAYaJ61+m0DrxzgcNQftuZxYkHnEP27
 YqLPMApCp7VEGjPhx3y77/VzgOzDzNquWChGCRiDhaKTGdAhPWfw+pNbp3qo7ZQGaS7Z
 8cK+ygZIvrqkd+aptypMY9Q2cFCakpulsVb2ztOSmrzhIMZzUqn51GQr3iOBW/9g88rB
 dRsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5nC3CVmcAWSkzSqQqLPQ6TBSVI3hjBLGwx7fkBie01/j7d/ilM91Fo0TaAXbH44vr1E8jmIfHWLp7@nongnu.org
X-Gm-Message-State: AOJu0Yw0R8hZ8nNqmjIR+iHQ7H0Bz7U8bygc4di+49amelUx20RZ/Fcc
 JRwLacmfMMGseAWOAKN0BJagdcXkWeg10J6EUqX8KdPsRhV14X+gBMJokxGxUfXLyzY=
X-Gm-Gg: ASbGncvspLk185f1vXgIrFldFI7IJpZuqmt9/VYyGQEHH7+rVUmi0VEZn6xoB3+jykF
 pK7dltyFY/XRHCHWbui6uivnPkEM78wXsKMwg22C34zITb2iTRZttbjI61ClzO75lW4Fb2RCQcU
 JvbTAWlp8gfFl93TDyCXtrlWokvMyt8fpBc3EVjPnVV4Cx5KGcXW6X+O6A+dfqIUPxMvuaybZ9H
 NOAj4Ye+usqp6u6op6HCOX23yACdLZWSSA/wzK7XDzIeOGwynyyPbRPzDxa4D8XFyrj8IXUGhM3
 FG0bbBV9k+meU4M+2H9Q2f6Is9FfMpj3NOajS3z2YygWegPZT6nzvNbeeo5dlw9FGnt9KDVlxhG
 bTUsZA2dGQUuX6dt7BElVY+dmy7TFXzS6PsMN2lTawqPcuSILD8RHd2hoEOBKvuRAFUOvUdyp+f
 8u3t1adPV7KMv5VAytM9lvhC1yJu+/pphMFf96q1CmgXwsR8YiZeutzNc=
X-Google-Smtp-Source: AGHT+IFE5i4VVoi6wx1M30APLnUuv38zX6fR+3PKy4xqfxy/XyvAJdchafNF48pM/hvusTBO2QLV0A==
X-Received: by 2002:a5d:5d85:0:b0:429:bb77:5deb with SMTP id
 ffacd0b85a97d-429bb775fa9mr3720802f8f.31.1761904951287; 
 Fri, 31 Oct 2025 03:02:31 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm2654913f8f.47.2025.10.31.03.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:02:30 -0700 (PDT)
Message-ID: <3bd0c9b1-e35d-4663-a611-d25d8c307999@linaro.org>
Date: Fri, 31 Oct 2025 11:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] qapi: Clean up whitespace between definitions
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031094751.2817932-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 31/10/25 10:47, Markus Armbruster wrote:
> Consistently separate definitions with a single blank line.
> Consistently separate member descriptions with a blank line.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/acpi-hest.json | 1 -
>   qapi/char.json      | 1 -
>   qapi/crypto.json    | 1 +
>   qapi/cxl.json       | 1 -
>   qapi/migration.json | 3 +++
>   qapi/misc-i386.json | 2 --
>   qapi/net.json       | 3 ---
>   qapi/qom.json       | 3 ---
>   qapi/run-state.json | 1 -
>   qapi/ui.json        | 2 +-
>   qapi/virtio.json    | 2 --
>   11 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


