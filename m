Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E54AC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGT-0008Oh-HJ; Tue, 08 Jul 2025 16:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDuU-0002ez-0b
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:23:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDuO-0001HJ-Kv
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:23:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4162698f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002593; x=1752607393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvjAHKKj67nzrJNGML5W2IgJTI4rRxVlMgp/bugiUss=;
 b=jSWxQpQoFXIF5+TFgg49/Kok9ze4ihMObuEJtkE8WSEdXtC4bhpAIGTd4PN+/FS0R7
 b9sOuAJgaIjkKHN9vTBZbes9EyOyxhbz7GPOjmPFXCYjARSYcS9g0cyYUCLug02VYeX3
 d+zJWwXKQ21YVKFfNDQ1tzLGbm4j0x+UGzlWOHTTa9LtP+EgX0oEF2WL5clhS/4c1yxL
 9HuQDZpF9zeiEi+JMwEcHPe++hByWs1sXRHeeaE0W3SSwSydxplKFclRecNlfbcIGoMa
 AAyM5XA9alPtofJDRGfxYpqpPKpI3NhXTc+2COgYy7N33CKCfN9olWOBa0C7HEIE0scQ
 ORfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002593; x=1752607393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvjAHKKj67nzrJNGML5W2IgJTI4rRxVlMgp/bugiUss=;
 b=fYeqVuGsYqZrhCrkQ6MAlh24L/QpdcYCtxsHRoq0nxU4pylIsmSgVjlyKPI3hZaPny
 g+NDh4bt8t2uKXOfSiFF5Ugrx+TIvilZzMre4+z/+jZf0U8+rOE9qbL4pqYpKjMT803Z
 mZhovIoBygh/AtueEUMKU1e/5HRFu92aB2pjdMIwl1B0znyus950IABag13m1TSjcVWU
 DRpicu1URHmP1Zv5HVqeTu5uIYYbECN2LanNowhuMAsma8+wERbgH1XIhSDSzDBmo4OQ
 EK9fDvWD84HhfAiUvzn4rh08cQ0XMmUjPXReY836PzlnfFMvJfc5IBVX8nwQeo+aV688
 +nVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnbaeIkvDj/ckfQiqJFyArqCaRS4mphffI9Wp0Tan1UFfK4uM7+WeBClOm96Cj63D7DCwJatDYXiOQ@nongnu.org
X-Gm-Message-State: AOJu0YyFoeLcewzW2kg7Kppm2axz/qFHT0PhQlCS0Dsh+35WUvojwfC+
 n1ZUyGOaNXje5/96l4Qy1kHvDt+ChvHRftQQDgQ0fzwKloyjJCut5gPPoov98VaBgqLXSDty9m5
 fAP/zQ1I=
X-Gm-Gg: ASbGncvTNx2tPtXAVdtm95K5aYAD1W2nB1IxQTTll+lgQ2gfm3yfebgJKJcYpd49XbX
 95X6AM+S+mTmhSz3WghCd6sZxt2FmRg3Lzn6k123AHdWkGO+7dpo8yaGvMx6hSs9bihQulWXQbC
 VJdX59eiooS5AOLTYsaS1OZx94gYdU7CTjNq/2QmeWvCPaaitJXfsT+oG1ERamijtw/gDC4CqDB
 6OUHCh/g4KAODrHqL+td5W4mc+gDjpSXFjvQ2T7j46z2hrbFz4tbcWhRrdaCf9TEYmfgfTfPfZN
 F5Y31tVsi9ODyeZfNOcw0sqYAaTIpJBiJtUAm8YFNbhho2NU9mtqPHcxE1c01506uNOwBAXhFoj
 b/8iDHk4hAJo8pagB/yMoZ6N5adoaHTDZ4QJSr0jU
X-Google-Smtp-Source: AGHT+IGJFAFt1p/ZayEQasGRAxlaEvvJJScgAlfGNjA70acw6J8m4ptNEH0DoPT2RyI6vpEc3YOezQ==
X-Received: by 2002:a05:600c:1c21:b0:453:7b2b:ed2e with SMTP id
 5b1f17b1804b1-454b4eb7e77mr131013125e9.24.1751958414874; 
 Tue, 08 Jul 2025 00:06:54 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd45b8a2sm12855255e9.18.2025.07.08.00.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:06:54 -0700 (PDT)
Message-ID: <1749cfaf-6d89-4f11-b9a8-8de8919c1aa9@linaro.org>
Date: Tue, 8 Jul 2025 09:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/audio/sb16: introduce DMA helper functions
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
 <20250707193009.12901-1-vr_qemu@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707193009.12901-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/7/25 21:30, Volker Rümelin wrote:
> Introduce the hold_DREQ() and release_DREQ() functions to ease
> the review of the next patch.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   hw/audio/sb16.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


