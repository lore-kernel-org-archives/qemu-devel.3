Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF1BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuUo-0007XH-Mr; Wed, 18 Dec 2024 08:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUj-0007KA-0Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUe-0000OL-4c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283dedso63045815e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734530018; x=1735134818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBU6v00y5aGyI0J1gn4OfRbVK8amqMtqVyDo1Z0C6Qo=;
 b=JSLRvZq1zKnqdjLDLQC3CVn5vg6lAub8c8zJivoJPTSST9SBDwJkAwBont6Otudnv9
 NkJgakGvE5jCbsCV2mh/Qreep7yHvsElYcIA9Pi4XQQFfN7YAm83Ra7RibQeSzip5zi8
 QNpDSZhs9JZ+LBFoKVpi3pgoZLBhm6TEs+NjNRSPQzR6ce5oNUXO9SE+26P1I4akirYQ
 has7PXicgHcbRT7Ewh84/3k4Hao5Fk0oagnsoLZZjKGsnC1yfNL81lbtEi8U/vRtLNYl
 jxftQRFPghuk5YrLcdCdzwB6qeKFWl090heC0RlN2Zs/JpmokaPJy/XBGLzfIyuudPkU
 Cf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734530018; x=1735134818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBU6v00y5aGyI0J1gn4OfRbVK8amqMtqVyDo1Z0C6Qo=;
 b=BnuaQqNlnY8n0WMEJTNWyDaI7mLJ+nsbYNgcogP5sA8UhSsQSEyaOujdgwE0Sv0vAn
 NJxKl+M6n47rr6kEUzGNpgz0P509QYUVnKFkLA406Te+qA4p3tPg9MITwjquO/ZWXgUO
 IljjUrX1wJb7q1wBm+3y8Ry8BiaboeG5EUbEvbWMqyggzb+PogEhXUE2ZwHppUJFiVZ6
 94QpJSxp1gKohtsqMaZ/Gh0oWAHPmns55f25/L9MIiNilSw0mGQIbxBVdNeH/PibIHoi
 us87O7J0bdcPMlZRPWsZ/G7YLJlj4m10NbJIyODGfjiDlf3yKvB9GCipo8vslSFbwJIN
 /BTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtHw9/kHGPjvzTSPQH31yqUkscnh4aBY6xfLJzEGVv1Yh7xEJdxV6+vV6BweFLjKfwPEGbxYuwd6d@nongnu.org
X-Gm-Message-State: AOJu0YySatPyWyysm5b9myaWbS4DymP2AG15X73r/s51wJfwZ5HvNAtk
 yq2jx2cMus96rk+sxxM7g4WfIoq90fx/85ndfaxF2bgGGSQ/vslE5UJQVjx28TsBsw/fJ0PlUsY
 v
X-Gm-Gg: ASbGncv2wIpYwx0tUhm0ha2LKdElFMGT1oFLRzUquKqZf1PUW3k+pTG1wuFHK7hBRLX
 qebYjboSiIn40uVRe4daRN4Kzl1zMJkDhqSxvynzPGfgsdrhUNSsj/PTSXlcjCACELG3ScLH7MW
 33UAX4ZwZuadk1B/KVDuwGNAcHGFMzj72aSBr2ETohhew+M3inzUAYUVBYdfZzBO2qAicwDC/Cl
 pzTl/Qz5Bq90NVQxpjKx/xwrfZBbu9vreTQhj0kKmr4C1VTxxyqqxBFfO8zpYMxBcjZJsSd
X-Google-Smtp-Source: AGHT+IEpBI2rcb/mXLx2ah7roZL/rrGhRRXEqFhjkLFscTlE3FGf7zJUoI7J66wKnw8JI1JlZo9IAQ==
X-Received: by 2002:a05:600c:4706:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-43655341361mr25183425e9.4.1734530018597; 
 Wed, 18 Dec 2024 05:53:38 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b1516bbsm35689185e9.1.2024.12.18.05.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:53:38 -0800 (PST)
Message-ID: <4de00ad1-3753-405d-b6c5-e77239616e91@linaro.org>
Date: Wed, 18 Dec 2024 14:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] hw/xen: Remove empty Property lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> There is no point in registering no properties.
> Remove xen_sysdev_class_init entirely, as it did nothing else.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/xen/xen-legacy-backend.c | 17 -----------------
>   1 file changed, 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


