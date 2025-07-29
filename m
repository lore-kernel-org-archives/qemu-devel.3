Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506A1C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiTN-0006iQ-E6; Tue, 29 Jul 2025 07:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiTE-00065p-B6
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:26:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiT9-0002ra-2E
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:26:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so862212f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753788364; x=1754393164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bamcpu4ZxaiiMEq1WdGInn9RkfGT1cDZci0aMm9WFWU=;
 b=tUVXWT7CGvjCIXTZnV+K/v2aBbdBKcHyAvgfciSmQRpj3eSFe1w2DAWjkIE2r8x7Z+
 pPoAsAZJExx7v4HEzWvLQHRrqczLejA0xZL40YE3kUBwUodGrykUe61ODL5b2Nm2kScH
 n+MTL3ne0LHzfUmSvd8Q9+KuSGsDSSLIhbS40hRHG/oUOn2eM5yGCI8nEqdGKDBJOk5O
 3BolqJOih2jiz6kxgBdcIKyNx/HyC996cVjTuB6A2hwYfhNLNwae18z4B1T8ESoHJQik
 q7IDVUZqytZl/Ut37B12IMaQEaXjeEjS7uykspr6nHnZT8hw+fef/YSgOEw6+vSoZMT4
 3Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753788364; x=1754393164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bamcpu4ZxaiiMEq1WdGInn9RkfGT1cDZci0aMm9WFWU=;
 b=iFrIBEjcQQ6PlAZ6mMWUtsBtmZS295kqvVfk0fnwmv/xtNdmlzINmoDgoR4DWCkTep
 RjyVRty+lwgdHg4lXyiZMUPGHLT+9I0ezPUDQR/PrQdossXQuEaAYmDckKG8sFY9h+dd
 v+8Sw2rayRA8YPyKegznuAT0uVUZqMBnpgAzhbFkXLxSYm8KpFjlh4KweyOD67Lm5VXB
 tyREDtDREHywCZnd9SDgq5hZ9z8us6T6QITMIB8CV6yMtq3/0oqMmX9XlLF/KYmENOYm
 Pk6sKZdjsT4H4D2f1MmkUx1Uis2LfnyRweO6gT3U34+H4hB340IOcZ6Lem6+zj5dPmpU
 z4nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS8MxLH+vL6R3P2OP4MWh8n6E3YA0Ag4belqJW/Lu/VODiWub21hVUnXigQB0knIRSHiO7e6azgSkX@nongnu.org
X-Gm-Message-State: AOJu0Yw0aqRjefxitDbB/Ytvguor9fTWUPNpgBzHKTKH7Q2LskbVyEoV
 8iKV9NbZG5qZL3SgUD58HL5RyWb0j+nHFqdC1Q4sXjJd3z5y+CFRki+FPDrdldkl7pM=
X-Gm-Gg: ASbGncvhgtmt784itB0GfKwiItPZzzvjOvubYtpQPJ0h/c5K9a/dvdQSBXqPe8gCR1z
 Be1TQ18jsx1u0oyfd5xhXmgNAmAWGHYmGgnW84uworcMbV9GCrL5ASRTv8uAid79NftmcCgKBTR
 qxu0muNnE727iHIT6EcgoTXA5NO+42XIg1SPOkeYDAUONscilwEbST7mHUn4mrzobGMUulTAcWC
 zV4BrpKuIRyqu7a3Lrt4Nohxyy/B8P0/EWWT7mYXLMfF6am/BqHqj87RBmrL+FwEf+147+3fAJL
 MLrXq8SzNSDD1LabNlqZ3TVhRorw2uBtS0bP5i+bMdypZD8jk6NKO9i0eNhyeNNj5h3AWzbruFJ
 YnV13ap8v8asTZ+Eh0KTx9546xRBeDKKA5sNf0Sw94x4xJ07lCvrdexcNvyYlMRIoPQ==
X-Google-Smtp-Source: AGHT+IFsGQgT3nWmOCzVxTZbl/bJv6N+J6axhFXup1a5if02Esb7AvBb5wMQiuZlrbRSMG067C0NVA==
X-Received: by 2002:a05:6000:258a:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3b77679866emr11233434f8f.51.1753788363594; 
 Tue, 29 Jul 2025 04:26:03 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78d45d010sm3310098f8f.8.2025.07.29.04.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 04:26:03 -0700 (PDT)
Message-ID: <14fff91b-7434-4d90-adb1-ebbe3f51d605@linaro.org>
Date: Tue, 29 Jul 2025 13:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
References: <20250729111226.3627499-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250729111226.3627499-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 29/7/25 13:12, Markus Armbruster wrote:
> xenfb_mouse_event() has a switch statement whose controlling
> expression move->axis is an enum InputAxis.  The enum values are
> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
> case for both axes.  In addition, it has an unreachable default label.
> This convinces Coverity that move->axis can be greater than 1.  It
> duly reports a buffer overrun when it is used to subscript an array
> with two elements.
> 
> Replace the unreachable code by abort().
> 
> Resolves: Coverity CID 1613906
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/display/xenfb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 22822fecea..5e6c691779 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
>                   scale = surface_height(surface) - 1;
>                   break;
>               default:
> -                scale = 0x8000;
> -                break;
> +                abort();

We prefer GLib g_assert_not_reached() over abort() because it displays
the file, line number & function before aborting.

>               }
>               xenfb->axis[move->axis] = move->value * scale / 0x7fff;
>           }


