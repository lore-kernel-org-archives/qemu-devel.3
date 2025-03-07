Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCB2C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaAQ-0005Em-2n; Fri, 07 Mar 2025 11:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqa9c-0004mo-3f
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:02:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqa9a-0002XS-Fd
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:02:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso12781095e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741363344; x=1741968144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ME81v5aH/TuF2khOtehqCQQR3r3r08weUaCHg73I6Ik=;
 b=PNFBLALD7uIdmuES3ZypUX8O3/8DakhNjpg0Atlk+y8IuNsxycyiQ7wujRl7QSHK8G
 ACiudxzi+xOOj5htvlE2YVdNhmKHE2iamBmMaA2S6SURnINfUvhWpGZLMPSktE3DEnLa
 rzPSp2TKp0PbvlEQLdpCsyp9kTpP4/Zp26xJcJj7H4lzQVEQ8z5S61hn48PVyxmleLf/
 AHaKHihLyWl0YK5ULeKCEiVhy03vSnlXyIuT5nV87Gqw8DmAZlDNhm83jH6qftxzwD4v
 nICUO4+avc0QAnYx4EKyPe7wy4jKGEWe+RfYwfzZENChEooWm3CCOy6o+sBkSC1fcWp0
 7pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363344; x=1741968144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ME81v5aH/TuF2khOtehqCQQR3r3r08weUaCHg73I6Ik=;
 b=VUERvaHj8qy6ib4hLHxGg7rCndV1gX1a2RHkQxVXlJzhrvZzzq9p5xSdtT8nFpLeKn
 IPpbkFygKck4VY2q3czytpTfqrAN09e5ToznFHYGPLiIN1fMDGRLEmNjjFXo5nWUwhC7
 vBSTWttCdHQs+YqGdEs0ApUscdg1EvzWs1kX3G0tz6l6kvahzFV4n8XSSsxLQpXqhgep
 kTiDIu6brYdyfP5pJaup4xQNL6H7Ff/eL6MS+rQhG4F/tTTftcxaqKXOp9Uv0QOXV+Yb
 AtBZ2m7NzDM4dvdgUw4jpu6sluHtruHOWV2qiN6fMRZfhUKkN4XsyDbqtpjUjR9HzWr6
 Jgpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrfNaMZBgHOd+oJbF26x0A6W27c0lKcWRH4u88oGdLwEWc8phyzKPH+BBk/c+9bjp9tpthzjJ3lOtV@nongnu.org
X-Gm-Message-State: AOJu0YzmDSidEI9qgRCOX5ORHYwJ4keaLO28xrGXrDYae54bNG0vqveo
 /zfmleUE4eqaSrqESGTE5BVtkKpH/C3/eT4vb9vK68ZxsSKg0QnTyXUFvaOQ5BU=
X-Gm-Gg: ASbGncvWmV2b4+S0FbwNKC81fSBYQzDmNfzrzqmRZvPEGYXhXvSt7uPC8mQB7RE+PUH
 rWJIXeKTF3c0Cgvir/xfdjDlM5dgFy4tNI9QD5pKPEeokiokxaPUZ08c3uJJxWw8/4Pv2kw7mgb
 TRBV+oCKzu/MKAx2jZXQcEKFUOP0fI0DMVmxUUd4J4rtfJNlDHGLoWrv4/D7tEgJ35UKhMVbV7H
 n8sFCfaeMHnTdNu3vIQPnOsZSGpD+/hf3inQRDx14Hf4m5u2LyDw76ol2cVp3Gd9J7bqPYT6yBO
 9Xw6A8S1YYOCHzNB6dC1rhPPMoKZBZOyAb/LkuWlK51wJ/Z+I3/3KkV9zF7jr5r2NcS1DZyhLnG
 1f8E0IMK7pbiv
X-Google-Smtp-Source: AGHT+IHbugBgaGWl1wNLvR8hFB6pP+1qwHfWXc1U8dRSFC7C6BmOToRL4Ke3DqxxQL/wC1pSKvj9tg==
X-Received: by 2002:a05:600c:198f:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-43c5a6009a6mr25610865e9.9.1741363344242; 
 Fri, 07 Mar 2025 08:02:24 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4293250sm84318815e9.16.2025.03.07.08.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:02:23 -0800 (PST)
Message-ID: <500e69a8-2889-459a-8172-a57b342ae0c1@linaro.org>
Date: Fri, 7 Mar 2025 17:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix status for Arm boards I "maintain"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250307152838.3226398-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307152838.3226398-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/3/25 16:28, Peter Maydell wrote:
> I'm down as the only listed maintainer for quite a lot of Arm SoC and
> board types.  In some cases this is only as the "maintainer of last
> resort" and I'm not in practice doing anything beyond patch review
> and the odd bit of tidyup.
> 
> Move these entries in MAINTAINERS from "Maintained" to "Odd Fixes",
> to better represent reality.  Entries for other boards and SoCs where
> I do more actively care (or where there is a listed co-maintainer)
> remain as they are.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Somebody was talking about OMAP on IRC and I was shocked
> to see that we claimed it to be in "Maintained" state :-)
> ---
>   MAINTAINERS | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


