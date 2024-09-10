Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE5CEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2Ai-00007f-AI; Tue, 10 Sep 2024 10:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so2Ag-0008OE-ST
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:48:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so2Af-00036l-37
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:48:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so448759166b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979723; x=1726584523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lh1TemglXmYisvhj+aA4tddFgR9NLJzEh4Z8c7gfoM=;
 b=LqAbIO2AcO4F8+kahdvdDk/XiufqTToplrffHqyccnfLOIOQ3VibuBHMzBKE+0SBH3
 17ZJ7cDDu30RCipJBGzFBKI/sH2Pz5Cwj3M5anunJmuNFpY6F7yIA9CF/a/1L0ReBXkT
 LMCXrXkA1/LNTDWHS6ooHJYAttxdguWzN28bkKlP29cGpNKsUh30BC/etiyFA9nkr0/J
 V4iH9HVIovdW8XWNhPL0pNG7MeCo8Xzcq19P/dPGm+fCghr6di6F8GSH98zVuqJvoO5I
 imkKYjmv5ZcDvnVK56I7uO6JrUpyz7cKexsw+ObTN5KWqDjYatuXF+drqufBZBYXatkl
 03iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979723; x=1726584523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lh1TemglXmYisvhj+aA4tddFgR9NLJzEh4Z8c7gfoM=;
 b=n0QJsT8H7psPbzn/4KItz7AI+8rMR6jCV4dFH+OuFMj4E3wuhkt1sWmPrwCpL/pwZZ
 9fmB5aHGlRMRGYzurIG2Wk7Dw6S54UUhKovNTr14sQAGjHQrwJbsv9v76hGlcBHBNaEX
 2LKhf1+mmz39isJhRbIWPO13X2UJmzqO9wyGNrvF3yVo5Ci9vBi67RjQAyz9xO0oJ3iH
 A8hwv0IEXOwGTfbas8J6gfmUrGzMtlE6GzZAunzDvDQRcaBXYqWf+LQpAtdLfbLz+z0T
 ri3cdJqBO2HNjhT5A9hekCDnUZNlK5B8ZMGfiSJ6UTy9gAHwAuI4OvrkbtRNre2+/bML
 JMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEme8+wWHQiiR8gmjXOM5HmCZh/3RIVwJv735KsmcmnjW4TMc4c24BzEQ9OB4cdxNKnqvWaqfkUqI2@nongnu.org
X-Gm-Message-State: AOJu0YyVwu+QBxs3Z8MzAEdINdUk5QeZjTaHmOGlTo5b6miP96K59qFg
 J2MTqux8Jy/tgicyrAhxWfL2BLc/MlOzW21rWQsnnsqP0eL+Q62GAX/Cv0sfI/c=
X-Google-Smtp-Source: AGHT+IHLUh6EM0SxS3BeDFWEg//RIlW33hemk+LFFZFdyWecGMU/jaVn84aSLDRcKp1dXMGyhorFOw==
X-Received: by 2002:a17:907:2d8b:b0:a8d:5f69:c854 with SMTP id
 a640c23a62f3a-a8ffab290aemr93098966b.24.1725979722770; 
 Tue, 10 Sep 2024 07:48:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c60f0bsm491984266b.125.2024.09.10.07.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:48:42 -0700 (PDT)
Message-ID: <970cfa94-c8e8-4fa5-96a7-45b964e4bef3@linaro.org>
Date: Tue, 10 Sep 2024 16:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] adb-mouse: convert to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hsp.cat7@gmail.com
References: <20240907173700.348818-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240907173700.348818-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Hi Mark,

On 7/9/24 19:37, Mark Cave-Ayland wrote:
> Update the ADB mouse implementation to use QemuInputHandler instead of the
> legacy qemu_add_mouse_event_handler() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 10 deletions(-)
> 
> v2:
> - Rebase onto master
> 
> - Replace (DeviceState *)s with dev in adb_mouse_realize() as suggested by
>    Phil

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +static const QemuInputHandler adb_mouse_handler = {
> +    .name  = "QEMU ADB Mouse",
> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
> +    .event = adb_mouse_handle_event,
> +};

Do you mind if you amend your comment from v1 for clarity?
I could squash the following and take in my next PR:

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index c0e0282fee..15e6e91804 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -97,6 +97,11 @@ static const QemuInputHandler adb_mouse_handler = {
      .name  = "QEMU ADB Mouse",
      .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
      .event = adb_mouse_handle_event,
+    /*
+     * We do not need the .sync handler because unlike e.g. PS/2 where 
async
+     * mouse events are sent over the serial port, an ADB mouse is 
constantly
+     * polled by the host via the adb_mouse_poll() callback.
+     */
  };

Regards,

Phil.

