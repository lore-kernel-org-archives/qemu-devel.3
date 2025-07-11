Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E5C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaB31-0005sP-Hb; Fri, 11 Jul 2025 06:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaB2y-0005lX-ES
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:32:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaB2w-0005ZY-Ik
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:32:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-454e2463e3aso4687735e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229920; x=1752834720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9eU56WcJffaKPPiVQXHCUgZmEq/DkRsB1HlSOhwH/Qg=;
 b=Uti2E4QJ5VNOmVyjQRXYYKD5C6PqpNYz8/bY+ofAtTSUj53fhQRqu0qBbxkP5zRe7a
 2QQ9pr7krvzTwGZMOB5wO1mXXst1feaCbSApXsNoUmPk/cHSRvu0G1Aj55siOmjeKbTS
 nAeEAbsAdh/ULNl4jo5qjCenhPxRhIxYjNewkDASwMPp3tBWrPq0gBk1EpxQmZiHb+Ol
 oN3bcQSsFxMEl9o5F1fr8iVfMDCAHjco+CuxbQ9yRzCpdNtItjcECzgZm0fu8j2YT+SL
 N/NjZKX6PDvg4HG4Fbw7pkZUdVXuqOcoL0PPtjAwBXsSYhSSllQwW7CB03TH8Y1butny
 wuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229920; x=1752834720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9eU56WcJffaKPPiVQXHCUgZmEq/DkRsB1HlSOhwH/Qg=;
 b=cKergL590Wxb+d0YgdjL+usij3/mL5HREaNMfJhdt30CaXHM3ztPBw3ELQeh+7N+mT
 8uL+zG1PG+qBkx/XkfnZ3Uf9kwGiXc7euzhDa/iInmZWoyrP5WirshTe/lN/AH+a228E
 IQkoz7hjTQVUDG2EE8w3s5j6HgFttCs+VN07Co/IMYY5hNFMsJGuG0DA/ZvRMcbpbEYZ
 p3B+6qJp3j3BK5HIZDrJE1y8dzT1BxZGFmtMfVbgP/IDpy6x5a6HgRFvPVfOtq1MTkSe
 io8jd33yVAoCBmD9i+qpm4IbEAXOrt0bgcI75CVWcn10Om4zb4uiUbmiBML0R42zlDF6
 6AZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZYDXmyH1FnvQV03UnrGzgTrfwZ9G29aQ7nxrcqxIRAPS4TkSunfWJ3B/8LpL94d3sEABYI6cko9KU@nongnu.org
X-Gm-Message-State: AOJu0YwABMqrAZmyv95h+mBWlk2aaooaP1qlASPtOcgXWo61NmV3jz7p
 mPtFvAyKOcsLPrzOs53EcvdHb78guVCSr/DOP2ljO/MeSQzepTvsc2mXJBedxOFCkXw=
X-Gm-Gg: ASbGncuILI0M6PjKQ5yBNwuwa6Qe2+ghCduVryA9oITpEw3UbBBzl30UmENSkXy9QWt
 mQzlDcFNQKB9LSV5+hrztDOnEedYetVP9fB8sRYut3OE+1W3bWmDWBWWsF0XH0iaS/sNnN1wUmt
 VXKbjMbTkXRqXhHF/iOsuCPgw+fK1xtCWJZjfQdkNC3VqsOC92ij/8igGK8hLdtRjIxYE+RNQ8H
 TYgECmZVUreKxgfXluuNLN0uCt0zDf9o6pygV5Msm0iXOIGbvY6OshCEJYDZADiVW+chbMVe0Ij
 ibyNQF+khHGVoW4r1Ww6hKepWaNcFwE1CgG1LgyfywnWhL+t5si8YLblX5/6tGBPEcqX46KDxYH
 j/okeEa3U16Jj5dwweWAKvCHgJFwcYvYEWrLNeMdwxrA9KUBko/5vladceQ7sjb0ROTJyiw==
X-Google-Smtp-Source: AGHT+IGgCfZh0gN0VPBuIA4PDtE1IefqNu7UbvYGQgBvNb9fejWcwx11vk6c/dxFsq4a/JxqAk17jw==
X-Received: by 2002:a05:600c:c116:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-4557f0b6245mr17492125e9.16.1752229920378; 
 Fri, 11 Jul 2025 03:32:00 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d511bd6dsm83326475e9.38.2025.07.11.03.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:31:59 -0700 (PDT)
Message-ID: <63393442-bca6-482f-9353-de4b858ac5f7@linaro.org>
Date: Fri, 11 Jul 2025 12:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/19] hw/i386/isapc.c: replace rom_memory with
 system_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-20-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711095812.543857-20-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/7/25 11:57, Mark Cave-Ayland wrote:
> Now that we can guarantee the isapc machine will never have a PCI bus, any
> instances of rom_memory can be replaced by system_memory and rom_memory
> removed completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


