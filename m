Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB88CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEn47-0000De-8q; Fri, 31 Oct 2025 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEn43-0000Ad-C6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:13:03 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEn3v-00062A-R6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:13:02 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so473229866b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761909172; x=1762513972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iV+gtM1ohcEXrlaGlvGbFqdRPvrV/oAbDujN3dYxtAk=;
 b=sYwb4hO7gS5jL8VbZ/dxjlC1Nu6BFlNe7805ydbcsyWxkiIB3/FbTLXiDriMqB2i+y
 iDs4B7wXcGlBmdKyicKQhxFB2iQrrDCwGHo/wxSPXLHx6EeBfX5Ortl/7RrJj8Zii42f
 tU40OMJpr7wsS1xK2dIPLgfHc5sbVgyGz4cpyZm3MYAvLwqmWU7tZCJh3/L6lhXJf0+m
 ApzbeFpyhDYtihW68CeCQcZUtjYCLEV6ZznnF0T8XUmBPGoG6Pag0y5EjSFQfIbUdUev
 TXiVQr7Puv1dc31k9EF1L3/pbcHQigbRbOfN5KBgHs+tJCUDKFxPqkLO8rtCDLlj9Fu5
 mSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909172; x=1762513972;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iV+gtM1ohcEXrlaGlvGbFqdRPvrV/oAbDujN3dYxtAk=;
 b=mXTB0KLIgjQ8tEsY8e/0hJhF4fgtYzKvdyAD95PWZdd4auBx5dao4jpwq7l8rrDZKR
 t1TUT2VyujLnOcUUWGGBbpyQz6GO3gs2LNWp4dsWzzXvZY8y/cya/evfQG+QDHyZjKZj
 yWj8udm9pdaKOgxBVggjAtP9T3wCyJM7VmtYUCIqLz2gNHLaLcmwjebR9ZiYmrlH02RV
 NWzpR7M1v4wsumQeHM4g566CSfDsqQcr+gOmgpCVPF5O4+0kvjQ49qt+K3T3Lf6Bq+B5
 ByNT3ht1NcEIzlkiyT7Ko/+mpmFfIh3nUtdjFcO0wyumEHqsVKd3QRMBOqUKIzj3kvro
 gFSQ==
X-Gm-Message-State: AOJu0YxwXWZMN9jT1UZyn17vUEb7gxg1pRi1UV5VxqSMUby8SSH1HsQs
 px4/KGsOJiAsnJ6hsegGNHW12mnPGB4mIXETu1Cpu8vUXIO44CYW1x5yy9YV8Zh7vyT2cMV8p8B
 Io9jvfaA=
X-Gm-Gg: ASbGncvA9WCN0MN55TLqDJgn4qS8lwAZDdsD2C2iHQQl7XPB//53zeOQ8QN43gCc0Ms
 R5Pe1bHJ2edjT4Mmn35Xxg/Nfl14fktkSHXkQ1a/ntx18fKMZLQLIsDUvi3+O28rFzNIGeqH09X
 U8732DDHSjSk05mKp6vuC2eKBHcKAkyY9rPjOF3SwRpk6T0rW4od2BaRje6P0VWVDwyxfNkO//z
 vI/Uuwsz2WODByX+EQt1UaTJ+ZstuvVT4VoHScO6+3Bs1VMQagH4tR5pEFiYnNZ1PZcmvW3KocO
 JHY2CX3cVK33vje8W+P1DtX6mtZTv8prBU7szE6Mqh9UU0taSkNnyxk6vn3rFmO3jqmKvCdRWV5
 O+nvyIzcRj1X4uQmO/T+jZDVXcA4L16HB61tphkpXgqUXTKElQkrhubQ+hKYgV9BkFLpJ3R5OcI
 RKaaIQZTCHt9hqCmfPBOBfYzHp31nx34otQjebhHv0HdpfkAUz2yQ=
X-Google-Smtp-Source: AGHT+IGnLoqvzSAjCkOWwpHdSBGyOAtTwkScI+j4zkhhFJKCHYpai164FSMl4uxy7VNihnNOAIrhZg==
X-Received: by 2002:a17:907:2d1f:b0:b3c:1bfc:c552 with SMTP id
 a640c23a62f3a-b70705f35c0mr316423166b.42.1761909172040; 
 Fri, 31 Oct 2025 04:12:52 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077ce927csm146487366b.63.2025.10.31.04.12.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:12:51 -0700 (PDT)
Message-ID: <756f3e9e-8db8-4e52-8b4a-28748701bb59@linaro.org>
Date: Fri, 31 Oct 2025 12:12:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: permit sendto() with NULL buf and 0 len
To: qemu-devel@nongnu.org
References: <20251028142001.3011630-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028142001.3011630-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

On 10/28/25 15:20, Peter Maydell wrote:
> If you pass sendto() a NULL buffer, this is usually an error
> (causing an EFAULT return); however if you pass a 0 length then
> we should not try to validate the buffer provided. Instead we
> skip the copying of the user data and possible processing
> through fd_trans_target_to_host_data, and call the host syscall
> with NULL, 0.
> 
> (unlock_user() permits a NULL buffer pointer for "do nothing"
> so we don't need to special case the unlock code.)
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/3102
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

Queued, thanks.

r~

