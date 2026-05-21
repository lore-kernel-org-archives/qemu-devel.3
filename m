Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BFACD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3V2-0000S0-98; Thu, 21 May 2026 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ3Ua-0000HV-Rf
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:31:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wQ3UX-0004XG-Jw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:31:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso6821205e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779370262; x=1779975062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJduBZOxBcym8TBVlPzB6tsXdWEP0pDqdUXg2E7JI/U=;
 b=uK2TulNRncETgHIfGzewhBFoOGhdWTZNPOOb/orqSJDIpjIR61NAFGumpfLxHOv6j+
 bFAfQPjXVlLMHOnPnpIXR22vbAuVpAzzYzZrmeEzwNI/5BxmdhchZhMlSg/GeUP+wkiW
 FOQUQGfL1gy0shaQqh1VzydsnFsZxepqmQgUEr9/gxIskUexMVohz5YmPsXR/2QHEIqi
 KQ+ksumBSmk7MvgMl1GWGbIsuQACcU3fC22kBrmPWyk1XX0Xvz/8niB6mWkuF9u61TtS
 NLSJPgBXIX6ny4kN3Y2xLFVWEbTso6UYnq7xzoHbcJr9jtP09pw7xd1k9d6z0VcyPfzB
 n+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370262; x=1779975062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJduBZOxBcym8TBVlPzB6tsXdWEP0pDqdUXg2E7JI/U=;
 b=WTHAiG92JhnTKrlXDvyce1tELunJGFZxMICcv2/NLIdhByl0qYVrtBkNs8rUO/n15P
 msCnlUV9M5IuMEDQMYnoDNyl3alSY7KY+9pqC3mbg2yDEFCfT9OudYULD1xfuMKgo1zi
 q0AvnY2gOvLNF/vcpAMjZ8+UIydoNqDpracjrwz5RGvtGaJAfdZuX6WAPtOkxSeZZw/D
 6fWjd3n1T21cFSQgzuE3ZAPQUFAdffCYx+ndwUUVwTckmTnUkmBURvI7zkB98a/ILv/L
 rbCBLWe2tRPgTunaVW3oHuLFeWn4+5LjCD/8CSPyeCBj9CmtYX43mgRqn5iYXDF/yy8p
 Mg4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9deg/UWfA9GymgfPtQPR09L3azdF1ckGwCoC3WYi7nodRPkioI7+GSlwEdkJEB3cTPuwGzocxK6dmw@nongnu.org
X-Gm-Message-State: AOJu0YyLglwn6S5AKjFk95c0voKdtjmSfDjPy5DWLD+npakz4edWknFd
 tqrtt2nusH2rskQspd1DKezRwebBxGpxn/Omon5M365M01ejup1Bhu72/nabiJz1iVs=
X-Gm-Gg: Acq92OHdDeFMJAIjo5t5SdWrQ3yYKTKAjciCKkJeyj1QXlKiDgGaN0GBANgiDOJvj3J
 AStvdTBWw100M7sXBMG7zRvKp9mGcuAYfxxCS4JJHRLk1W3B19PFaEAiKyXYH0bD0bq3x/2rOwW
 2KGIKMMGgOYrZdMeVB9UYPi4KxhwY9Gr/HejeFJ0WYW/v/DgILshW0JXlrYaYX6T3mZIiXtbC8C
 x1D0Lvx6Aoxh8o5UYPlMWs4/rdzrCEnfOcsnWCSc/wlHASTg5M5pwRHEcQjN8RANWh6sC2rL32R
 UfOhjHAEd4RLKwO4r4r2Ora3C+2Mm1h4/TQFPkbbo49Aye2KL6yDWcRJmsp/dVaFManyctx3NR/
 OxU5FQO/573oztCed9EH6qu9vqhKFy1auIaVKuquf6PWQ/mOFbKDpY2k/d3+OgxE/6htwJhMZ0v
 Mtk3DdVZZLyt1ioFJrnu9MvwMo38lAIrAYofyWCLSysx5auSK0qw6NbAkg0rCYoJwJrw==
X-Received: by 2002:a05:600c:1588:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-4903605d05cmr27576905e9.14.1779370262337; 
 Thu, 21 May 2026 06:31:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa936333sm2900474f8f.27.2026.05.21.06.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:31:00 -0700 (PDT)
Message-ID: <53535865-a013-43fb-86fb-f1d162a53378@linaro.org>
Date: Thu, 21 May 2026 15:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/i386: switch shim loading to
 load_image_to_fw_cfg_file
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260521112806.504961-1-kraxel@redhat.com>
 <20260521112806.504961-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521112806.504961-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/5/26 13:28, Gerd Hoffmann wrote:
> Use the new helper function instead of open-coding
> the shim image load.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/x86-common.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

