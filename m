Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B09C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRKL-00040m-AI; Sun, 23 Mar 2025 15:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRJw-0003lq-QY
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:49:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRJv-0001VL-CW
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:49:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225477548e1so64020775ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759358; x=1743364158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0VrTG+OEh2A1X0Mji4obFRoKHQRdQUnTcQeHWGV/Qrg=;
 b=gjmcnX1lWLNj7Motj4iVbQhlNCOefu4fhs/3wdYVmVgMIpPj8U16ATh7fQUHo15B/c
 jyE9pYCzwqCNXU9vZBC2kxsZl39mZbfUXx9E5dzMgr0a79Ifs1E8pw7cPveI8y5lcsXC
 65s4KqXnECVM5T1Or2Kv3WiZ+dsTtoWgmbooTo47H5uEXSs3dRlejEF0Bhhn+QVkmpbm
 RTiOOY9/kQ0SNgJw/yAYHLiwZQhRvcXQ8oPHh5O4qy12/KfpHX1CKZAJrxZKjcllUQbF
 AYAuyVnbO2Ckggm7lGIb2wqr6qmbMYmYxuyMBPJiJK5XQy6Wynp7ZRGcRsom6mqsRpvW
 oJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759358; x=1743364158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0VrTG+OEh2A1X0Mji4obFRoKHQRdQUnTcQeHWGV/Qrg=;
 b=EEiJOH00D0vfavV4SsK9LRpcp4wNb3wfOnAWpbwhzNSKvA9CoEuECpDLOKLPvbLQHf
 1eNDi1DKZmFSPmZ+h6Hxk/bomLJIwIKp8QeUBJYjwuP5zBpLJchLGBPuWrsMtJxbEJRO
 3FwKgmsk9OxwHjAE8WhDIhHGhJL/KTB6Mp9xOv3rj8SAcQcmCom4gBv3kPVXToFZY8oo
 9wQiqnl8LkYwDF7SKaFFPrLs/Mmlk+LlMMjZ+rGqX61PuYUbq1WhvGjHHVXPyd/9FbBy
 v33zMlWrIEYZ3MCv9C+cRbYoY8BU/+DhoxK6GzLeJtptrrdzCSy7tZrt5EMMSMoeG6+k
 cy9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpfg6ZPdanHauDX1EaZDSt3Tn0K7Vc2m1zBePtVRbxdVL7RZX1DcuN+ozNK5qbzQh8OoQX9RF9/5cI@nongnu.org
X-Gm-Message-State: AOJu0YzZobPXls6qrSypgRNVq8WNtlHI3FaUF2wfGUogQ7feOpeDt6Sg
 aeTsU7yr1iwGmr9PcIp9IdbsfbTc/+4lQtnDUGNsKArlHTnOQTRL8jcDAzVnAJ0=
X-Gm-Gg: ASbGncuPVqEM+ru/MCzXdTIxoFjwwu4MNP3RUm5RAV5NuMtsSMRqYLezqM86MuZ7r2f
 GqmgAMlk2Zt8trZjSoT++R8OcmDAkt7hVzrc+rAw6wx9jPX1VzkGP9NT76XQuo3gAnI/XLBC2Xf
 jZYgRKt60KodJmwMe7S361Vgoite65xNn5E0t9ShoYaEeOXBc5vrLU/HKt1oUq9qs2hDYvo0P92
 IzM+K5f51SCLvy7Eii5lXOsmzk3Bm6rrSN+TxbIrPOEiKt8RwRA162i8udtVW97V8DseLywD6jw
 PwmoSmQowRhl0VAC4cccuz+pXiyC+2zEc03HDK0keu5fDUCPbvtFgE+TeVEa4THCZGR5mTWdi85
 6cYCF6L/e1jtZhqPMSuM=
X-Google-Smtp-Source: AGHT+IE3dab26w2GkKbxpQ0GrlEU+Vtg4WGY5dK8T0jv2xahW5pgggFyno21qL5No28YGoiYLVYaCA==
X-Received: by 2002:a17:902:d482:b0:224:160d:3f54 with SMTP id
 d9443c01a7336-227a5222ab0mr53827665ad.31.1742759358106; 
 Sun, 23 Mar 2025 12:49:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f44bbsm55022875ad.232.2025.03.23.12.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:49:17 -0700 (PDT)
Message-ID: <eed04dc1-ecee-453f-8f86-83cf72feaaf8@linaro.org>
Date: Sun, 23 Mar 2025 12:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/30] hw/arm/digic_boards: prepare compilation unit to
 be common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-28-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-28-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/digic_boards.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index 2492fafeb85..466b8b84c0e 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -80,7 +80,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
>   static void digic_load_rom(DigicState *s, hwaddr addr,
>                              hwaddr max_size, const char *filename)
>   {
> -    target_long rom_size;
> +    ssize_t rom_size;
>   
>       if (qtest_enabled()) {
>           /* qtest runs no code so don't attempt a ROM load which

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

