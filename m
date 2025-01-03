Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D2E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTihL-00068g-En; Fri, 03 Jan 2025 09:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTihD-00067t-Dd
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:30:44 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTihC-0003Ac-52
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:30:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216426b0865so168131165ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914636; x=1736519436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pwKHgC4i2qqIzaSRrSPEjofmj6Fy5ZXQgSThwD9E8Oc=;
 b=qScFbguDFutDx24E+AK3eloEfskid5MaDC5or1I2mPKrs8ctDlkfTCtVcogz616/A2
 Ae64WykzzcI3V7KW2X684TaIKYLqS32tZV5QzJMlFPiULJaXqm2Sogls5oKzmfWrMlbw
 xHTt6AE1yDdrcULrMi+tuZS3mKeHtj6X+72b9xOz0q2T1xA2oaEOu6b2BCq0dMGmNP3F
 nIqJWgsbCnRCrmaYiFgD3CyEe0yoTcrqh6KpZmuTPrKfptIo4Ic9EgWDPFpiNrlz1XMC
 gFdHN0IADWXhbc5YSGgr0aIlYAZuB2SP1PfSNtMvYULc/p9QLDNld4fxfnpbW2ffoQXp
 EWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914636; x=1736519436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pwKHgC4i2qqIzaSRrSPEjofmj6Fy5ZXQgSThwD9E8Oc=;
 b=aIEhawKTs31M0eH+tGXQmtfI2ht/eRuHUfowwwwVrNxgqiEBZJbYYvUwRv427KBmrh
 luh9TPXv4ShR7lqHFke9iBUuEjjyzhEAcYtDEfpJJm9HP5zyrHcmLTj3wWWuaHDOoMea
 cKT5dTIDyHyl8J7evDJnI2U3WJvVA4bAAUYFTaBYueBe/otPyEOe/sxsVh1Sfe92tCN6
 h20L2jEEDaZqEWPyKfzCSaYZgLnlAs9N0+x6DZ4kxmgikLA5NUA21zI3QNe3BYhr/BOx
 JJV7xCRLUTfoaYN9Cb3Pma5xHUvcEpOR4oGuJHmYl8VmoF4GfAdcthiFeDGZ753JgwON
 Tt0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4zi24/8GtfOcyzB93zGi+VZE95UBBlMAK2/C2MqoWZWVK1K2CHvwX0v0KQEB9x+guby+DyIjyZoeK@nongnu.org
X-Gm-Message-State: AOJu0YwRvOOTPMtWlfbKEO1Sul8xAGyAVHmzgoE4pIJsBIP2o24tbWzo
 WQBY310+X8PyfRhw5f3EiIlES/iahKGnkRdpIowWm/Y1CwLS/dQi/lJt++hIw3NQRtNGgixfcTY
 4
X-Gm-Gg: ASbGnctxoUcsg+gnjsr2LNkye5geputN4GbANafJNzEB5MNZYXCNKBxO8g32fgbcDuL
 9j07/rub8zbmTdfCsEvrlnrBML7ChSc4Nzb98P41lME+mG1JIRFIWAg/wkjJ0/T1X82OoOBisI2
 MAmdDzSVBZcI/2eJSbpuUi0hdqj/e4WrZf4ZJZrKyVBgDkZEOlqDxmeg5MfwVbBCDAWkmHwwo1o
 dNDm0Ef8iOuPB9VvVNx7ZTDf0ZE4/rFW7u1jPmk+Lac1D5g4sLoCQbWw9T1UYgjWqtrWfg=
X-Google-Smtp-Source: AGHT+IF2Um/UE0Ytq+/DJmzn6GuMW4uF+G5NziP3lWc4JFOYz7Ski2t3QfWXmdGDC/R7zjG9wVIirg==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d62 with SMTP id
 d9443c01a7336-219e6f1483fmr756193475ad.36.1735914635034; 
 Fri, 03 Jan 2025 06:30:35 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e4057b77sm20199869a12.83.2025.01.03.06.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:30:34 -0800 (PST)
Message-ID: <09884f05-01af-4413-89d1-60ced84524c4@linaro.org>
Date: Fri, 3 Jan 2025 06:30:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] qom: Use object_get_container()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> From: Peter Xu<peterx@redhat.com>
> 
> Use object_get_container() whenever applicable across the tree.
> 
> Signed-off-by: Peter Xu<peterx@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-ID:<20241121192202.4155849-13-peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   backends/cryptodev.c | 4 ++--
>   chardev/char.c       | 2 +-
>   qom/object.c         | 2 +-
>   scsi/pr-manager.c    | 4 ++--
>   ui/console.c         | 2 +-
>   ui/dbus-chardev.c    | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

