Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD92C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoqM-0000bh-Ew; Tue, 28 Jan 2025 11:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcoqJ-0000bJ-LV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:53:39 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcoqI-0000lD-4p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:53:39 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21644aca3a0so137728565ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738083216; x=1738688016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gxL577YoEs51SQP1TynpZUMPj2SBVLXrrjYfUKK+dGw=;
 b=H2Hd93dOdkSWy3P/cDgBuelAhSHolASImAbitvGN7Zndvt4IIYXDTt7AEIX2iZlupv
 3SkM5GoiEfa1voESvir5wph/2sWvaAI7teNIHgwW/1x+9QZOST90xl5UEM83DSluQ1hY
 niV7zuheneytUb4fvd76WnpDDccfaGV+hOm544qjjGAXlf2LkwlV9WQ0hV/Gs9gf3X8H
 DgSp/Kqvy/bs7GD2HmHvx1HRc/+UWNuUKjx+NSvgVmEmrN37fcIrJjnSGdZoJGPI+pEZ
 gW5V1zQ/xW/l5QMMVW3WFbuFIEAB30fVfkejcdj+uA9n6kvr+DGKh8n1Oz1BLLX5NWEp
 jsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738083216; x=1738688016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gxL577YoEs51SQP1TynpZUMPj2SBVLXrrjYfUKK+dGw=;
 b=R56U3ZDPTp9XfGbdOaJUq//IbVGcnYBSQeVpIVJYEWWtHTYxacDi76iBWLTMNPLx7/
 3SxHQuM9HPKsN2ZqjesHEiaboqPj1G8wOwH9ueaDQKASd7IZPsRB0ENZWwgdWA+buMWU
 bF2NbCIZdt38ZxA9hq4wHfFeuM0N1/LwtwbHb3nIxlGfJy+nqajDfD4WGW2oWz8QnNrE
 BJAMlU5pn8HnpkbeM+26UKyunuQOKoIVtXXlF8umOvR8pn5VubxyL2grY1EPLaLSUkbV
 gysahM1cBpkb1aRZBBwHqkrHr+ADZ0nQMAHuG5GhRG/uWMtzcBS2bnmgLSMRxxoIb2Bq
 /pVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVqca5MIP2WMpe7QVX3oLs3dQ14S/XTY/k5g9QdwMuRVg7cs+QWasHR7U1n5yXTTT320TgmJ5xJ+D0@nongnu.org
X-Gm-Message-State: AOJu0Yxze4m2nqxnkdaS6NR+fuACAwVBM2xOPiLoVjs1kbqXHF3oIvkw
 byu9eUlUjzSJx08Vz9RlKQn6AQt+zEDXJk5fWGBh0DjZb+Q4bfZgKcgevsiPSLI=
X-Gm-Gg: ASbGncuD+ZCwa+V2A0vDIA0O/s8Xx/45haWRKWqWs6g15jH6CvRvHTop7m48YztkU+y
 QfwoP1lzS2rghJLGrytCmnOVYmFsQ/DV7JQbYqp+lPdImdYsfBa/NuJj5ftAK8e0Q1L3baSor8A
 sMvX+aH/I23hJnG7UE9W3W2wwYxzBXZ/fUlyOGcvB5KTjuiCeJcbigGAWtAf6CEgN57oa4QlJ5h
 EvHNxqEA3Mlx6oH75JFPc9kZGoPliItuy7FK7/7fhkHDPG27iB2QlrdT19h5k/KxtELA/lxsc6n
 xoVWM/C464JWEV+y6NLqAwme0nRGBVqktJ4oCJ9Fd8zZ3SjhxyxWKnokTw==
X-Google-Smtp-Source: AGHT+IFSDQWN4ETbbr9jMZoAAOR36HcSuiEnfychza+FWRF6fPbYaq0hecaeFMQfOXzav4k+zVPq+w==
X-Received: by 2002:a17:903:1cb:b0:215:b9a7:526d with SMTP id
 d9443c01a7336-21c355bf901mr616474065ad.32.1738083216294; 
 Tue, 28 Jan 2025 08:53:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414116asm84351245ad.129.2025.01.28.08.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 08:53:35 -0800 (PST)
Message-ID: <1f768f8a-499a-4d50-a17a-1d19c8b8b412@linaro.org>
Date: Tue, 28 Jan 2025 08:53:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hppa: Sync contents of hppa_hardware.h header file
 with SeaBIOS-hppa
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250128161450.12975-1-deller@kernel.org>
 <20250128161450.12975-2-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128161450.12975-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 08:14, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The hppa_hardware.h header file holds many constants for addresses and
> offsets which are needed while building the firmware (SeaBIOS-hppa) and
> while setting up the virtual machine in QEMU.
> 
> This patch brings it in sync between both source code repositories.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/hppa_hardware.h | 36 ++++++++++++++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

