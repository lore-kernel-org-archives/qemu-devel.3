Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAA7E65D2C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tENnm-0000wx-RS; Fri, 22 Nov 2024 02:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENnl-0000wf-P4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:10:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tENnk-0004eU-9k
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:10:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382423f4082so1137319f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732259398; x=1732864198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDvsbj6RDcO7Ou2gwPiUpDPc4QAl6kkHtfVsxsNHy1w=;
 b=RqjQcllWQjlZLaiPIFwd+bjGX29rGQ7PqqXl5VtBk7Cmoz62poyg3rm1GyzhKl3+3p
 /ctL6d1QN+bE1tquXWvSzVqdklDFlh8eMLpChS2rh5cm/AsYUg1KeUmfgCB16n7fSXQ/
 l98ovU1KSGt5Rg+MD+axnoiwdo9V72kOKDWHLKaBJ+/OfHqGQR57gu1zkPTtZAHTx3Bz
 et3bE/8LuKiW4KwsZHXd+uyPKHdWGURyAO2WCAJu7MAsK5d4ND+AcWYNK3SVtJ6G1fdq
 T/ze5M4umnPKtPp9cIeQicNJEvUTUn4GCGduHWgTQDFF/wSO5/bugsZWWPPNVw/nwJuN
 tIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732259398; x=1732864198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDvsbj6RDcO7Ou2gwPiUpDPc4QAl6kkHtfVsxsNHy1w=;
 b=P6nBMS1PbTEuX/61Xenb4R3TS6sPHICEK38kQuYW2vk76JwUEUAkdvKuE8tmck+S68
 Gp9p3MqBPMdOsn0mqoMuOXa8YDuEB79WKKcSc+VjyXk2afm5VdJZgntiSpXroM7Y1Miv
 20jw3yLq/47f7IvYSod0aZFkiQaEHtGWPalR1QzOUU0u+jd/8LVEYy+D6oOunkU6BuxR
 S5VDN/pQvDUSjHVEhSwaCwo8IznUdZ7VXseUZIHNeEM3w8eHlyVWNE6PWZL6k3KHdLpK
 LEaY+QiB1SAFagXS/T/hwLrhtY05YavKFFYN5t01B+Xo2DOR1MyR9glb54lbcF8s1E6c
 cjTw==
X-Gm-Message-State: AOJu0Yxp0uvA/iwHswKSElIbC7h2yCFU0YXxyYYQpZXTl+i3LgNgvAD9
 gSaJ5LppkM5ZE54RMjJqMeapBslcS6LSLBf9DDAsKXJIkOkYEdLP+CX8MxzReUw=
X-Gm-Gg: ASbGncu/ERsTh7aMxp5P7GM2PAqogYPg65dt1uAfHV+/cw9kwJ38HrW7JVmtJdOKGyS
 idAc4rVSmofvQHY+RBmbSoOA3PcoCh4WQo2XV4hJl33LoRctDS8NHqGOyMK1elGR23TQYRyIPla
 S3KEvKCxv6NxzXhoaVzwdrBZz3WFZIjkjBF4hhN+ZivqXtcSfKfYubhMST0gd47arEedlXtoIzH
 Le0Qi0SLhOEaQYtqhQt4CGp9kIkzFMgSKx7yMMV3dYhP6zhjzGxtVQYs1XQM5M=
X-Google-Smtp-Source: AGHT+IGQ9Ave/1FAlIsMZiUnk4SSbck+6p0CBIDHQ/dt1HOyXC2AlTG7CMxPgN8DwpzcnTdbsUw/jA==
X-Received: by 2002:a5d:6d03:0:b0:382:495b:7ed7 with SMTP id
 ffacd0b85a97d-38260bcb1e3mr1701370f8f.39.1732259398167; 
 Thu, 21 Nov 2024 23:09:58 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb30bfdsm1594705f8f.56.2024.11.21.23.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 23:09:56 -0800 (PST)
Message-ID: <7a37b2dc-22d3-4891-9d2d-95d4734c54e8@linaro.org>
Date: Fri, 22 Nov 2024 08:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] net: checksum: Convert data to void *
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang
 <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
 <20241122-queue-v3-1-f2ff03b8dbfd@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122-queue-v3-1-f2ff03b8dbfd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 22/11/24 06:03, Akihiko Odaki wrote:
> Convert the data parameter of net_checksum_calculate() to void * to
> save unnecessary casts for callers.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/net/checksum.h | 2 +-
>   net/checksum.c         | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


