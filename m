Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4454DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3b7-0002y4-Au; Tue, 11 Mar 2025 13:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3b4-0002wT-EG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:40:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3ar-0007jQ-TG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:40:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so76037505ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741714836; x=1742319636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJoSgtJei61Vv1IRCa8Xzx03ffV9RuFjSgTUQ60+Pf4=;
 b=Ib6Lh06PBjIGS4O49v88g6p5elqH4/K7m150qiuYIkmRdh+a9KSoR8tKOPhhjxZT7g
 l7HOvJbuHkSYb4SuBNtkHN68RxU93deN4I8iliFHPxIoq8vXvuQIJWmt1LWOBZpWc2Mi
 Xk0m5brD3CbJ/Xskln47SrQMRds90Yx1WFOd4dXJ+IcNawQg4osmo68cKr6JBgadSivV
 iuYdVl44Mf3ey5Nv2rXGJjpRiVmq8e3cD/b9qxScjTu9k14vx46a/wlRh2dGRhZ//P7K
 SB28JQL0BKbpiW65Ki0bcpAbq//ka3c+ksU+hDvm7gAYQm3lddFiIh6Zq3UyDRn9zVda
 psCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741714836; x=1742319636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJoSgtJei61Vv1IRCa8Xzx03ffV9RuFjSgTUQ60+Pf4=;
 b=oriAQM7R4mLRK91PCaoIiU+uPlDAJyY1aEatmgrdorb8pE3N2+CwfM1WQy16CrLSJl
 Uaviovbz6KCveiYUSFhO8PHmIeUckDb/hEHU5CGz9eTL1zZyKCvcvail51FL914eYYPr
 JdYuZe+MQFiCKRTffOYYic3X1xpADMKJSe+7MR0bhHTsCiK8NS5WjUSdP5ELJbXGa7IF
 8ERhDK/5F9jKGo4nuyeOLGIZ4v9auqFMATOBTDXSjfjau8JJY+lWDOA792AfCl3ySizJ
 AWLh5YQDqMvY8MtKCXFXDgSjVuKjNOhUm+BtrXpPDYjgF6EHDbPiF2fDpkzT1W0S+8VZ
 bPTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhkh7MkFKjo7CP6LS0auBFC37VMRSwrgVumpmOd4xa111CEOx5MIMldKlE6K7Sto2d/VT8CD7n/zon@nongnu.org
X-Gm-Message-State: AOJu0YxmTiqCYTdc2zNZ/FQ4FnhprqiYROO7yF1iokZ0v3hzM814x9HZ
 oTklb3cT/QQf/IYH23TD8HpTfME1zgYBysXB241BC7q8KRE+H2wPBPRylUDichI=
X-Gm-Gg: ASbGnctsn7uJcU+XZBTyJQIY63S0e2/SAvFseJ1A9li3Dm+GX0auw3O3ofY9DwUcoPz
 1CFwkEj0tA2GSkf3f31y7u/TNTsNt9HcTrQ7Wy9QQ3smF5/lU3A3LoyHiitVFlVgYMJMK4nFW3G
 sLBexz2aQSqcYF6qL4Xa8xzQcE9F8Ytez8F9bC5vzZbXFGMEE88YgPQ36T4kFpd6f9AIdA8Ic6V
 e9BF0AIVfKpWyXIy9eftxu04F+MXWr2p/FEczcO3RdBe7XW0knO+m5ZcetF9AB85Y7EjPLtYse9
 SZmVdfe1f0N4sFwKKC+cbVlkg2YUPSxJy9+/7kFMQEVOJ13/RacMTKqHChJpgkd4O+rgv70y6Fu
 TaU7pK71A
X-Google-Smtp-Source: AGHT+IGlaR9HwjrPVHTQyRxHtXjUtcHCgPfmVSkbp3ZKMt8nZvn1Cdbu6c7wfGboStIgwisDcZkQ2w==
X-Received: by 2002:a05:6a21:164a:b0:1f5:60fb:8d9 with SMTP id
 adf61e73a8af0-1f560fb098fmr18554773637.33.1741714836477; 
 Tue, 11 Mar 2025 10:40:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af52f391035sm3669478a12.77.2025.03.11.10.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:40:36 -0700 (PDT)
Message-ID: <37fd4871-f3c5-43bc-9dd5-1c0f72dcd392@linaro.org>
Date: Tue, 11 Mar 2025 10:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] arm/kvm: add accessors for storing host features
 into idregs
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, alex.bennee@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-3-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> +/* read a sysreg value and store it in the idregs */
> +static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)

This still isn't used, and so must Werror.


r~

