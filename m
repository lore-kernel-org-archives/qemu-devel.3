Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A3C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x87Nq-0004tV-Fa; Sat, 19 Sep 2026 22:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x87Nl-0004tI-76
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:34:21 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x87Nj-0004Wx-7i
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:34:20 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d9004a1ac0so12335005ad.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789871657; x=1790476457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MvhndkipY6bEKF1z9OoAb9Hd8PPnHJzSWElaNi2qrns=;
 b=F6pNB03oRsoMXS9Q2MV4cS5U9LDgJZ+B1QPZqzBlL2wb7ELdx3WrVXMr7MQezHFS+T
 lL9M1yNRZ0wocFEJFLNLAWGS1MMn3wn3znZvRxSHRZ6wmEd4vFyjJc2BsCrvtH1ybId/
 gidwnG/fHuUOOtWU6ITOlvNt8fCsHEed3g5Q04ZLyUdqYcPQLZEIgMVPPM5iei9XKD0z
 33VNpy7hdQ7jrgwfwjVKizQ21Cks4wPNpwlCj1pRl31nfsfKv11IJm8Sy3fmBB1WNQFf
 6smLnFJVuqisBxhlkyCQxG/GXVgYfpL9Q2wKsp/70mC8vGf+/jA4UjcMBaYjI4WeSfnk
 t6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789871657; x=1790476457;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MvhndkipY6bEKF1z9OoAb9Hd8PPnHJzSWElaNi2qrns=;
 b=1JbjE6z5cFy3GGbRI88eFi/yYqVAOdLrvuM0w9GFxElSLKrRuDmWuy7DgQMIzX8SHu
 spYLKZk6TWIv4teeXeD+D0kcToH67pznj/O3oEbpymcey3PSyk8q3D968id7/VZNlemc
 002PeK68iE9i5W82FxSQxyon4WNAlrduPbTeBF0Y7BgyTqCo0UKxmM5leaVpKXvo1Xpn
 iODCzGE+9MFRBTlVotKjihujsdJz/EuZq+szrC9uTtT3lxhFcMQadkDOSVAHFl/SrBNb
 iiGhZAu/dLjuHtV1vA2lnqnE8AjlrAbAK7Fo5AJAu8M4T7IKj1tubfyIiEkka01du1Ki
 +gRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTzU/wVq3FJu36+tvWRvHHZx+J6u0kqXPS3GHa9XxP4SvQN4sLZw8l2pDk0dSfyF7MsEPQAW4xSpNp@nongnu.org
X-Gm-Message-State: AFuF++luTZ0HhKuMKkCNZnxTANiJRdwQ2UH/WMCZy3zcB5VeOYmcP+ji
 d8tS7tldJ8KfVk//bsrsElpeDcoc89eF0gNNOJQZkBAcE9LGaDV2d2XhRZT6xYc65Bk=
X-Gm-Gg: AYBFou2hnynMqGec93VywexhJsey+tKfQzObdxC7J0stEx+gCjDiDMhuChareKO/gSh
 Q2b6J2Kqq+PJ3Lsvy/0cDaDBDBfGOFn9ZyFqPcDDKK2exzMXBaL2ruEh1/2q2IIblQ91E0Yf0KD
 NSLqoHvA6ySEvrCcTjYv463geL/5UDBXdfqgU1tBaOgV1ftClOzAlFS+Ihk5z0r2D+pxODPbx5J
 t3s6QWtRHGD1tJtYjH3EkOxBQ6BwX2eXvAD6tUs0iJLOCAbhrYCG1MuNs3JhRcft93eoeDc8l79
 N0TiBLvuRCFOWWGDvf9ZCMPuiEg0dfcLbc+vCfO//ui8xADPg1wMTqefbTz5vhBXz/lnOrcrq8g
 c3TRGTupkpxsDHPr/iNSJDCvWpX8oLr5uWAAaNBGLRYQJyUJ4s3b66xEFJFaynw5TVmB4B1kC4L
 S79DUhzSs8C3XCoYCJTrmkGY3DYpBN5rsswSfGxSO+kJd/+M/p+5UbN1q79BP3qD7l2ipvqAwjG
 7kxKv9wRvobuCwv+LmUYwUkHuyrsUKMZ3oiXs0fkLvLoChe89x+aS7BJ1P+Dw==
X-Received: by 2002:a17:902:ce0a:b0:2dd:c100:80b3 with SMTP id
 d9443c01a7336-2ddc10081f3mr48491375ad.46.1789871657477; 
 Sat, 19 Sep 2026 19:34:17 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:8758:b6a7:94be:427a?
 ([2603:800c:7900:ed00:8758:b6a7:94be:427a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f17d77sm9770528eec.3.2026.09.19.19.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 19:34:17 -0700 (PDT)
Message-ID: <ad1190ba-4169-4f33-a6ea-0c3d92bd31c6@linaro.org>
Date: Sat, 19 Sep 2026 16:34:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] virtio-sound migration
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/18/26 22:54, Manos Pitsidianakis wrote:
> The following changes since commit
> b36ad6a0510aee81ecf6087b59f412b9bccaa369:
> 
>    hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/epilys/qemu.git tags/virtio-snd-migrate-pr-v2
> 
> for you to fetch changes up to b36ad6a0510aee81ecf6087b59f412b9bccaa369:
> 
>    hw/audio/virtio-sound: add missing vmstate fields (2026-09-18 10:20:20 +0300)
> 
> ----------------------------------------------------------------
> virtio-snd-migrate-pr-v2

Applied, thanks.

r~

