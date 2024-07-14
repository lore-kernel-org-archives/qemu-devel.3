Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05EEC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 21:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT6sj-0003lK-FU; Sun, 14 Jul 2024 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sT6sh-0003kg-A6
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 17:35:43 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sT6sf-0007Fm-P1
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 17:35:43 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-25e04a7d9f1so1850860fac.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720992937; x=1721597737; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+H0tHlbbNXPKuATyUmYD/AygpGKh+YHsFjxGNd8Q+U=;
 b=f/WZRMocQcQTn+7RKKPOnPOJYWIzeztRmUumQREubP8LeHBxZxGEycVkrHVGb1wgqP
 dz94Cl8FtzebU6C2L1KwA6Ijr2X5OZnPna0oMTQrRUkYk9L9TIYimjsNw9SZJjJLB+IY
 FHM/bVhT6+NQc8AcW9ETWx9p29h4yhUL87cXPnh/Ro+IBEqAnlLdTpIpwKAXe1q/2DkM
 s3wglMrZZN1VkXw/J6SMpMK8o2ZHCQMpYPPRS0SV4GwlFdAKCZS78+0guH9HPSEbnN+o
 g0uByFL2hUm4Vcyz5vMqZOhcTzbfwObzKbo+n2EriO2yFvAaPajfZT8xiMAAYmzlmlfO
 Sqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720992937; x=1721597737;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+H0tHlbbNXPKuATyUmYD/AygpGKh+YHsFjxGNd8Q+U=;
 b=dJV+knga9SfDXOA1EoOc8kKbTbtiRLF8ahw5Gzu4tvIUu9X7iEVjUshUuz1j0zaEvp
 Y+IBXxniOZP0RD11FCkmDzPzhHWHcxXi0r0yapaFiZZTS6VJm4hZLYwnydfkLEbcJ2MM
 /61l495EIYGLSrFOkMtJkcpY+FecL5wFI9GDnAQnEeSmV0kutLDXspAC2gCeU3H43l7K
 FWc5njszRzZfFAPezFcusnQ3lHYfUDDsjxJ4Dy4Qfqhs9FvtC4v093jpWIl6mo2D8JXS
 rouOg8mPpXWys9SNarsJaaXifv4H+Qv9JWXmw24gqyEMX5oeprH4Xb9FV6Z4Rxh82mtt
 7NsA==
X-Gm-Message-State: AOJu0Yw2FS4BLucpViPJK/C/FXKLDWYs5SQPz/FcPcfeBxR98VK6gljZ
 KjzrntRnozflgcjbMcy3mXEZURwWtzGmgMfAcUlioWnQE8PQLa+OLf/EK4BUVeyKETKEDvi/F1i
 irMo=
X-Google-Smtp-Source: AGHT+IHFDLG3hqpCjvAuLTwq60Oh9lWp6pNt+5lX3YaZFak8PUDefphwZOHXuKR6Fvjg/r7hE3SeuQ==
X-Received: by 2002:a05:6870:8a21:b0:25b:5032:25c4 with SMTP id
 586e51a60fabf-25eaec92ce9mr15395513fac.54.1720992937244; 
 Sun, 14 Jul 2024 14:35:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ebb69c4sm2991408b3a.71.2024.07.14.14.35.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 14:35:36 -0700 (PDT)
Message-ID: <e026226b-29ee-425a-987c-2f10bb6d09fd@linaro.org>
Date: Mon, 15 Jul 2024 07:35:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Reminder: soft freeze on 23 July
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

https://wiki.qemu.org/Planning/9.1

Just a friendly reminder that soft freeze is coming up soon.


r~

