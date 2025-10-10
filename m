Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB7CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IHc-0005T2-Bm; Fri, 10 Oct 2025 14:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IHb-0005Si-7B
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IHU-0003rP-M9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so23102795ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122552; x=1760727352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eg8lpVSDtfUij9f/3fkTAF682lrgpHWWbfcbqWVwyN4=;
 b=jYQ6ucb2tK6kDbl8z9PDXsSthbTyrsMZqC3AsdlRU5hl9ZwPvjP1X/VkD232VhhVFE
 +vAW7geSuBT+iUP0c8L8ir3LScYVXewrkwCNr0+3j41Ya47H04MSr/6v9+3syS5u1qhH
 5YkVz1trfKyJUXSkDfzk9Z9qBTbTyy8JbL00i/oagn8Q0YYOknfM+XLWz2vPf6ESPQ1v
 TfsjtrCDvLw+yfpt9itiA7ufGunHCJG9fHtwUtWPnE5zRT/2mfni1OFA0SEGqWdX6+aP
 8bL4uTt2gJKUc5vrS3KPJIVnBKU+eDYxS1uaCIv+N6ZWmUX6xphASoeFRFV4isIysqSw
 94Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122552; x=1760727352;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eg8lpVSDtfUij9f/3fkTAF682lrgpHWWbfcbqWVwyN4=;
 b=gwrpe+sBCO2L5HC4ukKyoMZtRlzJt+aLCI/fTEdoQDMD8g2BIVcMty92VBqZ7XSLlH
 qAYyCYWNDVpv0DQvBKY7VdWDm0GiWEnPlAw2fayYzOfMg/UYFRYMbEdkm2Ji1EfxlP0z
 0BFAmQrb7KfW0hwJViKHInX9jHCIQ20qHx66CblbyXhwPNjjNEmNCRUetTyUVuZlYkab
 CI712LbwUFLrTbK9AVbdzK5pVZ+WXa1bDkLheCY94prUOxaOOoSxJRAblYkjetTdMUYG
 t1Nc4WKZFdVffosiJc+ksOTKx6C+/iAlDe8snx6lswsSpFLXNsIyjwCxvMbh6d9Jgoul
 LpkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDzkPYv7XfWPwzkray0XoqMYFt4mxKaLci1WC2gsVhE/ZHdTVeMMlj/owygVJTP3F4kHMhxjpYCM/x@nongnu.org
X-Gm-Message-State: AOJu0YwQSJttewR4W+Km7CY5MBZUfYvNKw8bSKzFsUqK/jUrxDIiiP7j
 NmQm0L9LPH8CvnY6Y9PaUsFh4OkKKN19Az5PvkRI6AEdxlH+yA2zjZA/dUnOLb4iL38=
X-Gm-Gg: ASbGncvRpM8U3F3LnBqn1nYpA79zXi+oSO+edTXZe/UtgZ5M3GYhHRKW6PKEVm7v2cC
 G5dtIxmP0qsfZLo4lMcpEM5NQXPsjaeGG8xy/u4Oc4NPi/jh0kXQBZRhPVta7MTuf+Mrk5/JTA4
 vM5Rf6/UY7mDgLqfxrQWQsd/bKG7leX0rUDRDSoe+cMT2NsVvXy1lwfafY3kz8k80N2ubO8OuxH
 WrgPuNHExA3Vrz8Pdsg02KA3TgUh6gi2DN36w4FEnpIeL/TjQMMrytilUKyeYg/BJahnyNjU2Sy
 9nfbbKjXUYq1FJhVcxgkKNn11jw8QBrnCdgJy5PYDRlfl3WW69gFlvi8rh3IEZ48nr71WCyso/A
 1Kw2vDG6n6DHcw5qmmPyRPvx4YHvNn3A21f/dmoQT97fisFCXD6BUcViqOeo=
X-Google-Smtp-Source: AGHT+IGR+T3E+fbtlVYCzYxRiSgxPFdGuz+ZiJKsRJBHfxiZYLns4VBnI7o2MHISIfAaiyRmdYIZKg==
X-Received: by 2002:a17:903:240e:b0:25c:b1d6:c41a with SMTP id
 d9443c01a7336-290273568efmr160504125ad.11.1760122552172; 
 Fri, 10 Oct 2025 11:55:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034deb0e7sm63925595ad.11.2025.10.10.11.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:55:51 -0700 (PDT)
Message-ID: <aa701ae1-6410-4323-9564-8e209c66d5cf@linaro.org>
Date: Fri, 10 Oct 2025 11:55:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010070702.51484-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/openrisc); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

