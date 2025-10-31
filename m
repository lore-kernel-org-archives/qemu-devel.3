Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D604CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElz4-0001XZ-6H; Fri, 31 Oct 2025 06:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElyz-0001TP-NT
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:03:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElyw-0001uX-Rv
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:03:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso25639695e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761905019; x=1762509819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjrfepaVlzM2YoxtAFXLNNtWxWSOXoG2khDssmhyEig=;
 b=JBG6fWawF5lJjL8K1PAumR5Gp2HkeyjWpVxAJqblXPM3oOzThjsSHEPEuXo7k3N3rC
 MqxZleZgWGN5vSkcFL4RLV9Amwj1vzIq7RL1P9lW83xWj3oXs0zePSJVeO3WGNAsbPYX
 0V2CfbjMXZ5JocV4FUINnAvL4XPfppD63K33IPjemx18OEsGk7GKYdJO6V06RX2bndAS
 qsOE8RdHvqyPu5IaGsrv6fHxedO0gsxk2MNorC3iDxALF1Jch7rgl5p7sYwKc1IhM7IG
 2y79N8++Fe5GNF1u4niSRlbabg8e3OR5GQt2kWIZ0RkdnU+zHZOUX413x1TKyjGzrw4O
 bqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761905019; x=1762509819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjrfepaVlzM2YoxtAFXLNNtWxWSOXoG2khDssmhyEig=;
 b=adA2kbuwLV3UH0ppOZgUGqdi2PnDK5OuOai+T9ztJVHGc/jInsUF/ZGe2D3x7Bz/wL
 2UmUV+xg8RtRJ5Sou/DD4FKfEH1DYA4YLOLC+B/Y/HHgQCtB73OrQ1UN9UFQkX0ryTZp
 tPUHkqWbGAJzbiHFQPN6SpsRMOgKqd8PpsSDlUYLAgWY5SmncHnPzfFVZonT8Y8KTKZk
 hNuojugNVE6+pK9erPX62eRhQY4+5Qi0mdkdPi6D4zSqwCA7di3JjoAnvY2BwZHwpbLE
 atl23PJ4AjP9PIwDBA107VbKUxNzwzBJRaeMZn4QDIiiOsNPk737BQzDPHU+9Q0rl1uh
 61Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHkic/+Psi6bVLo8MdXXLCYdxZbNLAiHrBtPUZb8RwWejuuslGbPxYZ+UvdhNXYVAltjQwh0VRMdia@nongnu.org
X-Gm-Message-State: AOJu0YwG0oFtml9cgHo896feInXU/XuovEZxlK4TzdTvbs+DLaAzM0fB
 h/GtEa2yFIZscyv8WTGtwvjny4cE5H6Zh9G9vEOopAquqbrOub209XX7PzTVv5PI5Jw=
X-Gm-Gg: ASbGnct4ZCZEazl+VvUJjN+m5hSk75U4+wJrlMJskAJm2bBkRjUBxDPMpU125xxZ1rq
 fOVNnp3fGM0UN972tipdmsN9xoK1vtljmSLt6LyrZ9rE9tigsJg4ait/UKlTkmGVR4L4wP2IAkI
 kSmNGF/+rzb79Vu3GuPQ82v0jXeD2QzdVqqsh9HThh/8pRIk83jzkKOe7AlYH5+hAxcITL9bD0d
 3dqTXxrkUMRuzkS71jhb1OrVaNURjNy40ngQPd8aqREuiD/cko2BzLVwpyA8TLQkdy4/AXGL2ka
 yUsSZXS04ZClj+V32C5Admj0RBKSZvepXmpJKX/WH8vw3s+Osf6gSt2niNMVtoeYN8X5XApO3Jv
 zDJH7i74fbfr+tbMzA+fAKeVlW+6Sr+O1BcuGHF15xEYY58w5ccfYdCnkRfLtYiFN1mtaNWoP+x
 ldUhHDEgT5adXa2jekWsTsn+K9qtMLO0/N9XXNYT3ohevDgS2JZeAzNB8=
X-Google-Smtp-Source: AGHT+IEtw9xCEyZXaZLabayJYR8W3Ityavrn+pHFn/r3d+TDd4XzT3ES1wg41GhT942W5OFZxyFkUg==
X-Received: by 2002:a05:600c:4ece:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-4773087b2dbmr25772055e9.24.1761905019584; 
 Fri, 31 Oct 2025 03:03:39 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ff7fdbsm23791235e9.16.2025.10.31.03.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:03:38 -0700 (PDT)
Message-ID: <0d57858e-d6e1-4eaf-a043-1573b49c37f6@linaro.org>
Date: Fri, 31 Oct 2025 11:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] docs/interop/firmware: Literal block markup
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031094751.2817932-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 31/10/25 10:47, Markus Armbruster wrote:
> A few doc comments show command line snippets.  The snippets are
> indented, which is legible enough.  Actually formatting these with
> Sphinx would fail with "Unexpected indentation", though.  We don't so
> far.  Add suitable markup anyway.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/interop/firmware.json | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


