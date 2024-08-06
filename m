Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50124C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEgb-0000pB-G4; Tue, 06 Aug 2024 03:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbEgZ-0000h6-O5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:32:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbEgX-0004By-47
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:32:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc692abba4so4205035ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722929563; x=1723534363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hEySo4ELoiD1N2a0rOiicpq47pHf4iQHTPdQaJF9qwA=;
 b=VKDmOj/GuvrJqy+vCnJh442LWoitvaK6HJtMmX4ow7vGTqjYqoT3g2Nv/gdj1YCGy6
 KXj9YkiVIP02of4g5nw8uJVRRAcyTZyp4W1uijOszkyHMpwo5CBerSGn+LPEw9tP/QyJ
 ejetINznV31iFfwUN9pxcy7x7MjPWt4Xb9xDmwsi35pu6+MLkGRFBrXRfOa5A4Ej81kc
 CrjTiQQJag8Cs+XR4cCTMFyhfGwYJ70HeyG48hhTHGUj/hoUMwHp0cnSXiHwoY5BS1v5
 LAuDUAqewzDGr1QKm1vJPTio07MrTZXaY1DLcHkeHN0SmBnPYQbTlRwr/ZoME0WouVPL
 +qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929563; x=1723534363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEySo4ELoiD1N2a0rOiicpq47pHf4iQHTPdQaJF9qwA=;
 b=ZQ6fX/hgdfvSy/HJpZvEJhx+3FSEMVbjadww4rH51PzFOwZfow4HBFNbx1jqlpehC4
 K9e2fI4KZEtn8v5ag+d1lY0YC1UoX4pto2+86E59yb4dDqc9uDrvhZfhVu8MQq7h1ttX
 yNHU4EkNOHzeqvv6hdM+O8hKz5hiLR3LGeJ6kyKMYL320nWpMrV3PmbkWPZL5bwn8nc8
 Hg48MD8mk2oXFi0chnLjAYSIgYwbPdg6OeckPbSXXUtYkkzjwNVbW20dumqx26VGQ1rT
 f9ZtfxRAABgG/iZE3QaTrVdua4reTOUCVZsSBtH4ix6O2FamS7XfWKli+iNh725whDis
 /98Q==
X-Gm-Message-State: AOJu0Yy0FR8yds+AiBwH3pV/kZRoGsiO+mTad8eXTokLABvxTzdr30vn
 B1XiB2ErKuOJwsjSMF+rla6FZxus2cX7UZkk5G+D0dUBnytOZ8/sarg62tBygpc=
X-Google-Smtp-Source: AGHT+IFQo4xsvh8ckTk78bNzIwNfCQJwUQ6q9+4n9xhdXn8mYTL3+0jWD2IQuYUp3WwCmSV9/2jQCg==
X-Received: by 2002:a17:902:d2cc:b0:1fb:54d9:ebbb with SMTP id
 d9443c01a7336-1ff57295018mr134268595ad.22.1722929563302; 
 Tue, 06 Aug 2024 00:32:43 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f53985sm80989285ad.76.2024.08.06.00.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:32:42 -0700 (PDT)
Message-ID: <2ff6be31-e726-4522-8601-19a9be187bf3@linaro.org>
Date: Tue, 6 Aug 2024 17:32:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240805210851.314076-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/6/24 07:08, Kevin Wolf wrote:
> The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:
> 
>    Merge tag 'migration-20240802-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 833362e55d9acc6b7ccc1d80d8cd84688e7f5761:
> 
>    iotests/024: exclude 'backing file format' field from the output (2024-08-05 23:00:42 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - scsi-block: Fix error handling with r/werror=stop
> - Depend on newer clang for TSA, make WITH_GRAPH_RDLOCK_GUARD() fully
>    checked, fix block-copy to add missing lock
> - vvfat: Fix write bugs for large files and add iotests
> - Clean up blockdev-snapshot-internal-sync doc
> - Fix iotests 024 for qed

Auto-merging qapi/block-core.json
CONFLICT (content): Merge conflict in qapi/block-core.json
Automatic merge failed; fix conflicts and then commit the result.

Please re-spin, thanks.


r~

