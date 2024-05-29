Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCtQ-00056B-QQ; Wed, 29 May 2024 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCtO-00055o-Q2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:34:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCtN-0006YU-AW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:34:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35bf77ba951so1013280f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964471; x=1717569271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPVvnpYKtnWXUSFcIEe84KEok/xpdsyLxwsmqQV/P98=;
 b=ucvxImak146AsAX4Wz7R580vVRSuMgRm6cW6lTMl9N0TYOxVegEh5TZJfFu49fuWLD
 5C4akLebq52Ae6/vVoDOK/JLzQo2b/tcZ/Ddmfr0+PKxzYk6R7VGUFwS9QqyLkj6Polt
 GDgToeedYlG6PVpoa3sjUAQZg9Jg05tAMHM4u/zoo3AcbeE/R2rFJLu9cuC9U2wrsuaH
 acfAyRmIUrwemUiCG75/xrSgQMuOvgg4Rm5SQpC1A8jGDT8y6+wLOL2DmJbKEJEgVog4
 5De/tX35xl+Y8Lgjq3UK9rAsyFwMDw6jRcC5mcgcDbwOx/iZG/UAOvxt5LW9wThu21YB
 OUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964471; x=1717569271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPVvnpYKtnWXUSFcIEe84KEok/xpdsyLxwsmqQV/P98=;
 b=OwpO1GPWNqRJ3FlVDrBb0dIfgfbrxch4iIlCZU/rQSO2s77bO5iJj7VfPCoYBqiSPO
 iwnUHITnvJYqbaAJmcbNnDNqBPLOYlkJ+yb1oYSUWYbQIPW6pRBzlMc4UH4974ELaDuW
 s41rui2DRqk7R1mkYSxZt967m3XMZ6hSq3U1EX25JFjKhu3NfCRUIDkvuk8KZxk9rfgJ
 wFa+fyxF58myW0i5XNstM5tKofjMF3n272CXIOk5hVXaXo26/E66IoUNRGVX4KcgZgFS
 OauUTaznkw6ZyHMIbwXDfTHUMrZEiifZxzis5bf3aY7lZyCMhRzkgQjDTccHMIkeqalT
 RFVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1TF6kPhLY8K4xSgKZmk+V+78Jc02dOR0fSr5SapW82WbeE2E7xqBfJKXs3r7rbrs8rYQFC3cxkgwc9ZIQYtMy+4OA4ns=
X-Gm-Message-State: AOJu0Ywc84cH1kbD3VeBXXkUUd0zFohOi0pkiLGNww36F87/ezVUgwTv
 eqxe5HTYwx0n68XKcH5Xm9Um9AecPXH3Ra4TL55byU1/mHbbCyu0gJWBbN66m7s=
X-Google-Smtp-Source: AGHT+IG++ropkhzPOpWxAzHqivlX5xEVT8zpBtl9nOCha7huHHFD3nhbO5vDiCXUsWvkeMRDjMAqwg==
X-Received: by 2002:a5d:64e7:0:b0:358:17e7:7fa5 with SMTP id
 ffacd0b85a97d-35817e78059mr7513649f8f.62.1716964471632; 
 Tue, 28 May 2024 23:34:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c930esm13685684f8f.84.2024.05.28.23.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:34:31 -0700 (PDT)
Message-ID: <8261f1a4-bee4-4bf8-9df1-2073d9b725a6@linaro.org>
Date: Wed, 29 May 2024 08:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] tcg/loongarch64: Simplify tcg_out_dup_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 27/5/24 23:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


