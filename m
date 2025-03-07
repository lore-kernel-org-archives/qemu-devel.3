Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF4FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeZe-0001qx-9H; Fri, 07 Mar 2025 15:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeZc-0001py-8y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:45:36 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeZa-0003OX-O2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:45:36 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2feb867849fso3720600a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741380333; x=1741985133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLO/+StPw/X4oUCCovoIqeWmzSABFEJNeyQLzxi5l8M=;
 b=XqhN4vcFIqJdr8jlDA0crrkog+tY6v+5LWeAEwGNzvcLTjkeMj13+oXU3gku7ha2YT
 2HgmJcpOTH2ge0ZczYpZGnnmGRLMS6cMtE7lTsW7oSxsmbvhY1gvjczgx20RQvpmkB9s
 ML6uFk5Ig8Rl9R36q6jDjoKmk8ySS053Oow2RDDHW75xedI+98JV0nrtTJV4x0bYODDy
 yxPLr+BsfaTjwYJwkVhO6EjdhDcB8Y9fd0nEccDj3uBvgTKObPZPgUi/rpfEwjL4PM5q
 6hFpopTdsIY9BgkeVC6GVugWoVIRqBIyRPso4vLvAnX/NNbDkwWaridxsVRcv2bxAqt8
 dtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380333; x=1741985133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLO/+StPw/X4oUCCovoIqeWmzSABFEJNeyQLzxi5l8M=;
 b=pW5IPLCMXGT92yw3NLXijv4lDG2w9o6LVbVcMf86eAJLfYLo3O/A7RI2gp8T4FGwh1
 uZLGy/KTcel9OxjRda6DAFz0oVxGdHFjkBSxH6WqkEP9PTDWvmYxm+bJqdg4AOsOaSWc
 pmAWFArC52bNh+S3bdD8cd+b7l/AFwjxMjhShTqHHR7iy4lzfnJikwPItbOvIOA9cXCo
 iZsLd13jo6ubL7Z39xubtdXeVdW23fJQ6tnnxe8qiQ61BhGBfjlt1lqluDfLYHBwVer2
 xKE0gLFW5al2XRkFl/JB85brFH7gIR8EZ/l0Tm6mMeEKWJRp37Zn4J9lQPr5kSPHsCI3
 uaAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB5SqpORV7cBpjWYP4sUfP7Views0TJWRIFaC+9nwb5P/+GZ9tMrujOGVx1vWLh3ITv+ne5rxhRfd0@nongnu.org
X-Gm-Message-State: AOJu0YxeZpG2eGxhgwKgO2Fu15w01UzBhPHAgjQ8JdNBJsMfBvC5N2FP
 1DF83HvlqZxdDPAatUXQyMivXtoAD7UKSEk+nXh3HWR8nwTeH2y5os3bHgt1tBNvUrdqdzp7ulS
 y
X-Gm-Gg: ASbGnculB5fIIYJNVsWzA97TzGuPmT3em9Moqo5SunXvXGfWqm07lurlZB62raWKnhG
 LswNf+TuPef4QJ1y4jKdFJVggObJ1hejUxdcXqK+vS6kz5m+MosO8k2JFm+5d7f+lqs23e5NXYn
 dtRxG3kVfDehQkkfwYotPQuPphdA03Ke5PLnDf47g0cNMkS1wMYozn+e42R0zjc5XmsziAz0YdV
 ZAlnw7cErDkXvjMr5P3vBhbkzKgzwCw5P2CvQuWAwDSAlWl3zoNR/S0jxR7nshqrOvF8luiKqE6
 7j15Rk+8DvV1Sz/zV6IuarxxkbcEEzBgtu9H/4EFH0xloviQkx6DwhTGHhCm5BAu9vjbJ3PvFma
 BrsHcljvO
X-Google-Smtp-Source: AGHT+IGwCMdbLAW1CF8VaUmQROJB67bsnK5YtWJaBtG8tJy4UtvlYxRKLmQ0610im2RjPW/Tjy6l0g==
X-Received: by 2002:a17:90b:2e90:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2ff7ce8e50amr8996345a91.12.1741380332757; 
 Fri, 07 Mar 2025 12:45:32 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f8eesm34513565ad.112.2025.03.07.12.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:45:32 -0800 (PST)
Message-ID: <77ee5a00-05f7-4163-ab0c-d0cd3202c8d4@linaro.org>
Date: Fri, 7 Mar 2025 12:45:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Convert the compile time check on the CONFIG_IOMMUFD definition
> by a runtime one by calling iommufd_builtin().
> 
> Since the file doesn't use any target-specific knowledge anymore,
> move it to system_ss[] to build it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/ccw.c       | 27 +++++++++++++--------------
>   hw/vfio/meson.build |  2 +-
>   2 files changed, 14 insertions(+), 15 deletions(-)

Again, separate the changes for iommufd_builtin and meson.
This is an s390x specific device; it really can't be shared beyond.


r~

