Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20C4FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbPa-00027M-L2; Tue, 28 Apr 2026 01:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbPP-0001vv-05
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:55:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbPN-0002ZC-FR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:54:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so8521262f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355695; x=1777960495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2pOa3UxaT3QvQbXdEwPNoYPt2Hehykle1YltTvX/x4=;
 b=t9ScBVE81URT5GxG0yFIOzCCfHBcVicYZkdaCWWZPEAAZwoZgnc6g2TR22qwrbEdSM
 VTludJu8MjkU7uijjUuL4d0a+TwGarihHzxlFfeV2OL/0wUKp17Ok4DpJZRoU2tPJuuA
 aJKcI8u1CrSjRAStBGOn/WgUlGZxdk0nk6Oi2t8WneooWszGBRqsiIObfUKMc992+RLW
 LXtki218spiEhKYltB1UY1BnpjG/zSFMg1Tfa/GusFfBNSIlGrF4bz643WQ8kKwZ3y9a
 oAvfzE7WSl0lruqiUgUlRm0n3eNDfJFxo8h/OPnfOE5Kdw/IMpLkOyqqROv6iUmk7ymg
 z7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355695; x=1777960495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2pOa3UxaT3QvQbXdEwPNoYPt2Hehykle1YltTvX/x4=;
 b=q7ViWbXgc0G+APHmOmQBjeTV0+GE5EKXzeYV4y7IrkV1yQlhWQ4M6nSsepgm7RYend
 jKo+zRTAtDbq1R5w/cJ2n7vywK6nBWZhJLJJbUvzVydlHOzDORk05e8iOoTpNiXGtgXA
 oMk25bVaHSvm5lyXfiwrbJUOG6baA/rpp7sOc7qBzkSKzaKGjiUtYuPUvzGgrqqowL+q
 BK9MH6j7aFuDeq7/TrUJxCoIf2SQA0BKMpMq37zFgqLKnKi2iplETmSNAOSdhpnr8n4z
 pYZGBIlf3I12AaxmcV+gRiGj1hW547zF91AOAZjN9FKqQCmLUzMXxP25TDD28AOscyVt
 jVaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+gnI9PUvevkQSON1/zFs662L4jJhy2reib0MkXo/RyJEbVgZIgKv2XFDUKVS1H4YYEMoWrbgYE6sk@nongnu.org
X-Gm-Message-State: AOJu0YxliGmsOz0vIEOxyZoBfq+/IhwM9EcO7xVz6i9Y0xEut7NyYJOY
 XHaiq6V3NaJ2Irs/j7oTOBfDc7Up4/X0LanaXgzT+Fsu4UhOvfUFOAnp0I2yCkMzVK/JJ2ToeS5
 UgQITzBQ=
X-Gm-Gg: AeBDiesMF0SqXZ0qadcaLHzCATDDREzGVv/Nf2p/2fjuFs4j8SF55uzu1jkqtWq3oqw
 +zpsoqBZt/ChWaVt8EAK9oBe0Gl+Ihhv5it253RomyIo4AJUpexzunEiimrLH7UGO7DCtINvmBi
 rbt6bZMssdLBljxJ0RSjmfGGEpgd8NUQwS+/uYI2bYuBnkS594XAHBD0livHkBgx2ZcRY5Baxg6
 emr3wGYBqVLQFDjsuM1b953BV5VE817xbzrevXRUOSu4dG6uFyFVLHmz73kvuYQrI0zaWitwYj+
 dlITSQLpEfhOS5L8BpULAQyWkyCWTGtpSqbsePQJasFkhpMzJKZhEy9DbREatIyrNUMUnfhu2ah
 wNMDZnD9jpV3P0kUk+vQm3McyBoRPvA+0mUXlLAViKtEuQIwtsfoYSrP6r9Y7TIqtd2ZEyV55Nj
 0f6EGsCwzGEyB8fTVLkE0Ur0ufesZ4h+RhvLfMKBU+ZBrv3zTt5Vk03zoWUSFjbb83Ae5qv2IsN
 A5MjvxsaJlVLKM=
X-Received: by 2002:a5d:5d08:0:b0:43c:fc5c:aa0b with SMTP id
 ffacd0b85a97d-4464a632a5amr2874316f8f.42.1777355694505; 
 Mon, 27 Apr 2026 22:54:54 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44639f2d534sm3438067f8f.0.2026.04.27.22.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:54:53 -0700 (PDT)
Message-ID: <0692a3e8-023f-43c2-95d6-174659b9cad6@linaro.org>
Date: Tue, 28 Apr 2026 07:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/84] fpu: Drop parts_float_to_uint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_float_to_uint at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 42 ++++++++++++++++--------------------------
>   1 file changed, 16 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

