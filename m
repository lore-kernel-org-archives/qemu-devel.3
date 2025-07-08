Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDAC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG50-0001G6-Bf; Tue, 08 Jul 2025 17:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEuH-0003ZF-K1
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:27:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEuF-0007uf-Uv
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:27:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so599730a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752006429; x=1752611229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fu1WK/w/9D5J6tMkfVhjTZ9B5iy+dfmpVxjwVLiGPDY=;
 b=ZjPdcJh/hoOnLw/t0LCVxjQOSdY4/OFDrkbQYublwTk0NFM9ueP+PWY4K2qy8cEQzT
 ZDGyTWBFE/223KE3f8twVqdcyp/+YpC64t0qIUDsxBvDc3ftrJyDOOGFYTU53DQDOONO
 m/5MPep6mQnPCcxd9Oy2rzshOjDoIz8j7J8+8urfNnYHgXliOY6rZ3LYd3cd7PkqHJPk
 kGsSut4FwT70JOfrYXMntpTNeJ954jHC+a+Es6BQMsu2zVBZ7DRpfXqh2Cy8SUa7jhEN
 Pb3i0r6catAiDfmFNqgrERs5idlQZyj4429bIH+Xa0FGTqzS2PwYg3EAz6hrQGLTw3gA
 7XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006429; x=1752611229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fu1WK/w/9D5J6tMkfVhjTZ9B5iy+dfmpVxjwVLiGPDY=;
 b=S6pXqDXlfrVX/2Q4p1avCitRlPx1ejT4IcuE1WnUJrztN+cXfrALqb2StP/DwrhwbG
 gR1fMNbvNGWMPZHaT6TXXqHxsmM3yBkle6S4velATB3LMJO9BrgBtBZhtWx4VoqKifX/
 vsXnjJzPqZEJ5ushJIZrMBn7HHqDNi+9Grt9zDbRlmxu7+sRHqbJ4p+C9E5Bq+k82FG5
 2MDQknbQKTNwvhVCKvDf4Ftl+PyuGerVHaRU3+JSLQSc2CH4dm1RnZtej4aR1ZQH/qO6
 lQLo1vJrkE0QBMiIjf6jawvqxANuKP4EMZE0iEB9FgKsQmD7+2MJMXbnLRQfYXzO7nPa
 URcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnfJ67ZfeigtFPEU5alSCVj1EFw6E8T/0rMc9ZDG712/PY08bfpSOnDTD2qNlkXJdc13h496nlgcEh@nongnu.org
X-Gm-Message-State: AOJu0Yx1sjshURQO99uD370Hqv/pyINHaSyuN9AdjLUIprxcZEllDNKH
 qlSnBVuQrbPr6CDKTsDa8RwRdE63TpbJDJMzDiy2nAr1L5NR95Eri9VJkR20VOgLEBFgviqZvK0
 gKVFSvIY=
X-Gm-Gg: ASbGncsNJoTEkTeSAebCmwVfqZcWz6V0ZOPYw+mPoDfg8Lm0HFYf/NUhPETlsvfvjgY
 HtgJr+Oh3H/o8dSkrztIPFUk2fbQkJu07d0A3KOR1s7ocnxBzVNnURaRoaUqvG+3KhmkfUj3b7k
 2e1DCkHV1qFTnG2NoMptz/Aeg1igIRJLxtRSyw86TVpxXea8jS/PhpnSvuN8PaDjur+Db5eE08l
 2XrEa1ffMdSre8fvzM6g4roDi2w8rKKYLiOb8q7CYzsYJwBTpzL5mcZFnI7U/poPpH+ZLD3EnVV
 zvINaZ4b83eh7RZHTQlgGHhMX8qZCFQTVXVET22jLp+M2eGKX1MkhWcg+z6TBraPScMBakudJEa
 vp9dDb+u3FaOBPL1HUbHLsksaCQFQoA==
X-Google-Smtp-Source: AGHT+IHHKrJcuCgu3qsCXiOF3gFkmJrCVSvfc7PDQzDeIQ7hUrfI8nsQQ3NaaVo3H34R35nnFkQ6yA==
X-Received: by 2002:a05:6000:26cc:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b5de11fc9amr1137675f8f.19.1751958275599; 
 Tue, 08 Jul 2025 00:04:35 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030cdf5sm11952429f8f.1.2025.07.08.00.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:04:34 -0700 (PDT)
Message-ID: <ca3f5ffe-067e-484f-b5a4-eee0ae029d9e@linaro.org>
Date: Tue, 8 Jul 2025 09:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/audio/sb16: block structure coding style fixes
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
 <20250707193009.12901-3-vr_qemu@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707193009.12901-3-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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
> Change the block structure according to the QEMU Coding Style
> documentation.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   hw/audio/sb16.c | 57 +++++++++++++++++--------------------------------
>   1 file changed, 20 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


