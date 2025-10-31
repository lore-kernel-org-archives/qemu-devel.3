Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC8ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 20:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEw9S-00049e-AU; Fri, 31 Oct 2025 16:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw9P-000499-MM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:55:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw9I-0006il-11
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:55:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-429be5d31c9so997976f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761944099; x=1762548899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E2494wC8Zkk4OFrvtAjz7MtJs3Y18IdMSDm/KH2Fia8=;
 b=HhCxfIh7dh/ThsgvOBGdJK6HXjFlQzB5jhzE9n6sYE745rS4GAqt/qg0Q37nR4Elh/
 1fR7LOZVqvcGubThEmSLJE0tfY+ZvJVsD7RsAVwmDYlXRW/L/KE3QPfJ2cTXbTTvg03+
 xZ+QO+ToLAn7xJa3MBbXAEcWJ0NpCoigWOKteXkBNmRNcAFdtwM58xDke/4mAsNLGpDG
 1hcF8I5ocQI5HnvP+4vusVwBu7MCeHiyQ9Vdh4R2Gl9jqTfddtYqeV4F2KW4ReTPhBlW
 4BI69Mx4SP43Jvwgsk6HCYffkEjKJnfU/HfJ03numc6RF1BQhuzzxAZcJH3q0BG1jUmD
 XKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761944099; x=1762548899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2494wC8Zkk4OFrvtAjz7MtJs3Y18IdMSDm/KH2Fia8=;
 b=CbiGStKKwWfFiaQRvSkLG44CPRCUfeMCdi/8XOgGs3FN1Bw5h0C2ueetYjNbTj5JwE
 HERukIl402grAgHrmI3tA4cOhHwlehG0OvASs3c9Mx0Ke155LUSPAKOETllRibX4yBj7
 L0+E6WpqWZreBDsEehxT9Td6KBd0y5mT0bLnAl38wHVPah5FC+XR03ue2oRm76sul961
 HA/lODQ/63FIQdRsOZ7RmBMGSN14qr3rWe95tO725BNpsMK+NRwGZc0EGkg8/8Akvqwz
 Ep5IIM4eugq/8XuFDWHISwaBLqE8iBYIwedJCkWsC1iE8hAJ9F+hcHxUf3ASDxxqYYh+
 7Gug==
X-Gm-Message-State: AOJu0YxvmCnAlqyxKF7lXPZ1x03sVQZyhXS7+D/9lOU6QoLdMT4MUcHW
 Rq8n33oPV6xKb0ZIJ0Z8Fcue5kfEaz5gyBpZuy8AsfutGakp5u0LS09VpNvIzJcUKiU=
X-Gm-Gg: ASbGncswDlojOWd9ALNXrAOaJFnqKt6i9DCasLgZfMEqiqc9XCPNix0qtigozVpHyQc
 USBgn1mc/7E/1oASB7rrXmxmAkWSg4HDOtF6eUilOF9A5TGQtF7pi+vZMWgaOIgiXW5OD+XhzV2
 JSwt3GJOXbAYuObKaPP1DmYaXUGCKkVdBQmMlTVGOrTd8UouMEK1C7rdS9felqbXLDrt0c6itlH
 duP/NtyAxNydJHXBkfkbZFcELUrZ0tHKNAzekpSr7qVkrcB2UnoKqK5VScKIOiu0VSIzFRyydVc
 DM33nmJkN1ONGZjVBMLwyx5X4xVi+0pvaJW/eKTqSh+bV0Qqy+tRFJ4iNjxJjdrpTFFqhYaupnX
 FFxeS8W1GLbhLP/esCJWNz27sJhqIWZZAOej4HsZ9/oAGzc3xBhDBal+cOuw5WM0a5rpWVxqn1Q
 3b6mI9bPgu1YtB5PZ9HzDsrrSK+zKo4PirP/JH3IdChvnjjKoVCMkoyew=
X-Google-Smtp-Source: AGHT+IERE4nYpQyQ1FMulxJHon9OZNyNed52fzDTEPbNmpaVb9Za2x2MXFJjp2U4Ptu1ubXMOQGWtQ==
X-Received: by 2002:a05:6000:144a:b0:428:3e62:3204 with SMTP id
 ffacd0b85a97d-429bd6c1aacmr4620233f8f.36.1761944098872; 
 Fri, 31 Oct 2025 13:54:58 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c3a77b1sm13994355e9.17.2025.10.31.13.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:54:58 -0700 (PDT)
Message-ID: <ae1133f7-b2f2-4335-b1d0-9ce186b7a5d0@linaro.org>
Date: Fri, 31 Oct 2025 21:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
 <20251031190246.257153-3-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031190246.257153-3-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
> Test, that fix in previous commit make sense.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


