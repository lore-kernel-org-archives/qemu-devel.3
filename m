Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2465C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaPy-0007Gw-Qb; Sun, 04 Jan 2026 21:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaPv-0007Gb-Ox
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:34:00 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaPu-0005y2-BA
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:33:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34c902f6845so19177743a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767580436; x=1768185236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFyeVYw0GlWuZ+/t1i7ID5YQeDuispZWUL7OXun55yU=;
 b=lQMp55XVrRO+nKqRoLCHIkm8NFYL32ca8yC/s4kze7o5JFWHMtGcahXExq1tnluBej
 PzQ9QWH6tqQTWY5QIob3mMIXmXQeSXRKX0Fm/tyrP+Hn9wUauvUWdnJ5YZp/fNrD8e4F
 0rMekT3NunBtG2g91h82fKQgsc81fG9j7Rs6w3++FNTlSItdD7gGV9oh4yfPJiH9CwRL
 TZurM+gvybKkJsv21oCySGD4pB+xlwe/eV0Dtmz6L7kCmNDK3WryR3FpoPREHlWq3Bii
 k5XumMThYN5xzW4LzLMuA5gXI1FsA/3JVoosoFlcXT2kH8/3AKp7jWEwRnV7frP1ESNg
 zGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580436; x=1768185236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFyeVYw0GlWuZ+/t1i7ID5YQeDuispZWUL7OXun55yU=;
 b=NpYzz1Uyqc/5sOZiYW+1eMPkz7XGC42pqvdRK8y4wCBp37fwFe+gOUe/T9sQsoCc2F
 VoLTVgeBDlBh3Mp32IIEDbr/qh2k8J3qAZvZygVUAJXGToP8VXLN9bzn3XIUDSwMACJv
 9jSt/RcZNToAKBARs2t89fRo+8jaz5DXhMU0omr/DBlicWdPDM5hf8waGbmniYQu1p4v
 TuvSSU9965oQeqPRqvq0Z/JIuV2zt8g9kE24Kj9M7JW/klUF6DN0ukaebcWy1ZA6bhOM
 pxS+PrjFrCYna9LpcYMEHaBHoEdZs+SFBx14i1Bsov1sXAVXNTS1qzQhcFdB97eUTDwy
 jWlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4FBvkuyOj/8KgR/sWuVtk1tHeY+j5EBPsBR40s05PXBZOuINoy5Ylk3PChAsnrNvMy27Gw0AAeMbk@nongnu.org
X-Gm-Message-State: AOJu0YyJ4bp11EsGZXhdbVFI0naYnq192OeBldKnrLD8KkaD+w7uKxsj
 i1Q8m/gvJZfXY8isZLjkEjOFDGJrLe7c+aI9252w9nUU8NwaFbAaESis634MLtmmFZo=
X-Gm-Gg: AY/fxX6gkLll8tD4L2eVt+FaHIjSXYbFQ2j8+ekqrQMbDA6IvJ5b5I+Wdjdc1l4yQ+H
 2NcWwYo45T6OvoFi8Bu9hyZkb5CDi/Fs70P5DCtC6QzevT7Cvl28k9P3XT9PqePP3HtqNDUFiUo
 tXvD7m9Q9rv25DoNMtl5pntUGnnCzqSKsodU6344F2g8RYhdNDq6mH1vlIg+zwi9QrygpChCVgu
 M4jNxUse3yJ7xgt654wYjNFN1qpJCavGKwWXBBAPex8iJX/0LvD59Xpqdaze63FDBPrdtEqDqnw
 qu/gjIkpA+D8cXrQQyHASpVpsaFAmI/uAASRp43+enGJ+u1YpOyEXg2rS1oBoszFyVE809aD5m5
 E7nKhPwd2JOnEZq/Bm/qHpS9zcuVffE94bCRV5FPS/6MYVUgytbMsDrI5dAU6mH59EKKa98BkP/
 MS1A6ZEfMrK8OxrvEJ1yZiK0lx3aNCMw==
X-Google-Smtp-Source: AGHT+IH7H5FiGNbkUBIj9/EAx42kH4Qu+sGh+pygrVkWBwIbE55PT0fBxNWJBf+v82M3C2ofwMwcnA==
X-Received: by 2002:a17:90b:1810:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-34e921ec5c8mr43559735a91.37.1767580436011; 
 Sun, 04 Jan 2026 18:33:56 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f4776dff1sm4492752a91.15.2026.01.04.18.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:33:55 -0800 (PST)
Message-ID: <c38e2205-47a4-46b4-90ff-526759afe8b0@linaro.org>
Date: Mon, 5 Jan 2026 13:33:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] target/hppa: Remove unnecessary @cpu variable by
 using cpu_env()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229225517.45078-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 12/30/25 09:55, Philippe Mathieu-Daudé wrote:
> Partly revert changes introduced by commit b2c2d00f48c ("target/hppa:
> add 64 bit support to gdbstub"), restoring the cpu_env() call and
> removing the unused @cpu argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/gdbstub.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

