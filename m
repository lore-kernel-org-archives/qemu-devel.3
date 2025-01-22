Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1995DC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUjB-0000Yu-O8; Wed, 22 Jan 2025 02:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUj4-0000YB-Fi
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:00:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUj1-0005Ji-L7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:00:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso45324565e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737529229; x=1738134029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NI0j9R+3KAtfEBOTgbxJkdlt8dgNVhmXhVvTh7/Ulek=;
 b=kGML5ETX+kKbPYNO8FuYHPKo8TYiwyr+kCDXwcx3BdvjAUCAY5JzhfKA4zIqRlRY9l
 Chaxxk3Ibazb4PxEU0W38sFmXCGEDcJd4c8b1QHUy/I4phKjljivmgpJfM0ZhS5QXLO4
 BZyti/n3k3JhupValpp/VDZXbgrZh0Fq8yqn67zy1p/d0lcdnj/OZLVFHDvptLUJL2QI
 eOp3GwXNe49IsOObYqBsSqbjE8J596qKS3AauJZIJaEiLUDP6PG5IX1aAmpicL7WvSFz
 +xtAl0bKUXAf9z+w48epChU5pDP94+thttWIbUM88Oh9ruNFWd79vxZS7P5ZFAVOHewr
 iZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737529229; x=1738134029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NI0j9R+3KAtfEBOTgbxJkdlt8dgNVhmXhVvTh7/Ulek=;
 b=WxZw6xsNrkLp02t1K0Z33IuSVA9v483oMke0qlRxPjLDcamNmRmGPjvascPj5JMpMT
 PFDmZWlZS3FRKc0/jYZMONWUi9we9ex4cKqKqF1W1+A7f6X34JBylFP3x8mVaHrn3tbq
 fMKIjV3naVg6tePdQHcAHuPqWT1FjKv+HKFjtFsJWRyFBI78Xp3gGaygFXdMU6GEFI7u
 FdtjPSeYnkXexnSRCba3Wfh+24REzrbE3mCvQ6haMojoRi9gKjcQy7yZiM36atQUFEVx
 OTg4h3VVvm57WK67OCV09VZ8gbs/5aan/jsa0blKi6skYaJ0bTLROCdqle0W9ypWtw81
 5UiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFtkIXGlz47oH/6W4TzjgNXSqKeslfjqN5f6z4WfP5tsbEPg7zUF17xE2+a87GQLEkXeP0ioH/kObj@nongnu.org
X-Gm-Message-State: AOJu0YykukvMjAnspYv/8N4lH+/JaApmDP7cbzizXjZOyEvAPGpF/jsT
 qOd1lrpqUO6AW9EESs2rfVcElCnDzBPJrt3ROwAYUgGAAmgMVkkbS7yqrXM3w4w=
X-Gm-Gg: ASbGncugXakZs0iSjAu82p8dpsIXyUqwj7DJ/C2Cg2PNiiH2T3TkEAOljl1TNvyGsnY
 +UGiFHrHXoPsZHpulYOwb/Pb5zIlHVbdP7QFHFJ5Ke44oUWt9le06xdtfYvTK1GOVm4SBFqn23W
 T8d88UpdJtmx+14CsWgYBzKqktvKzuEYo22hUynUEmV2yDDB4whd7oeeI5LMaqbUCIx+1gbnpZS
 RDhw+UBJJGqSa/b6iESdfT5bdnrL6Y3WVwNHeH+yYE/wslU1tW/YRQKAajxTViV5onCp7+Gplgf
 IOgVEiy5kCyvYu2XUmvlThUaArtENCC1hXJqxA==
X-Google-Smtp-Source: AGHT+IGD/BrOu/E4XJrIo2QuIcBf5oYjol1pWWwNOtDIfmMyBLfnp98Hzmuh7b9WPutTlTs1o/mHgw==
X-Received: by 2002:a05:600c:5012:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-438913ca718mr209774425e9.10.1737529228511; 
 Tue, 21 Jan 2025 23:00:28 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d99ffsm12344505e9.29.2025.01.21.23.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:00:28 -0800 (PST)
Message-ID: <baf090cc-decd-4d6c-b857-f970b5acd766@linaro.org>
Date: Wed, 22 Jan 2025 08:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc: i2c-echo: add tracing
To: Titus Rwantare <titusr@google.com>, minyard@acm.org, its@irrelevant.dk
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
References: <20250121105935.3069035-1-titusr@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121105935.3069035-1-titusr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/1/25 11:59, Titus Rwantare wrote:
> This has been useful when debugging and unsure if the guest is
> generating i2c traffic.
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>   hw/misc/i2c-echo.c   | 8 ++++++++
>   hw/misc/trace-events | 5 +++++
>   2 files changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#i2c-echo.c
> +i2c_echo_event(const char *id, const char *event) "%s: %s"
> +i2c_echo_recv(const char *id, uint8_t data) "%s: recv 0x%" PRIx8
> +i2c_echo_send(const char *id, uint8_t data) "%s: send 0x%" PRIx8

and queued using 0x02% format, thanks!

Phil.

