Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B1EC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFUD-0004eG-Mq; Sun, 09 Mar 2025 08:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFUB-0004dg-Ag
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:10:27 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trFU8-0007jb-UO
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 08:10:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so463256f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741522222; x=1742127022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G4ZDkgTp0Qbvx+Fnrw0EZGMDkC0eNizdgfhsnXh0cLA=;
 b=WappyTddOi072YamBYCCpTK4m74aw0QMIwdkOKnlXWpIWSDvWt2m6i3q97p/xUNhSf
 vdnWEFhg4FB/7EaGmjH/N+oWqVV1W7BOAvCjtFH1Q5G0H6vKZRgyMWDT2CMOaoewcVbt
 6IYA3Bv3O3nLVfpUgHbYvGsdvOga6G8pce18UZBZENYwOa6i1LYhp4JD0B/Ty/6S+PAh
 lwophBH9g+FkaFjPQn+SpWjtXNL70dXk3Avr1YxgBqTibWq+sPmgjQfUIU+fCkwIPBRq
 XyD8V4TboVVSKx0/v9WbOIvYn4jeZkQTkU1nllbO+4z1ExisSWw03cjnq5wq4YO3LV93
 nDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741522222; x=1742127022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4ZDkgTp0Qbvx+Fnrw0EZGMDkC0eNizdgfhsnXh0cLA=;
 b=ZIAwimfX6rIxkvjU5T7xuP9XBJJnASO0axrAoycx1D9H5WgX6eZsTx8Byu8XqpBtdK
 zWcZYZ8h2q/KhUJmGeMaAhPG+9b4tluC1v4yasciYkB5NDE9hDKR5zTUbJBsDfF2jV7Y
 r+cIC3Voqh/WhIz1GSbx+7zvZGtRKlUf7Uv85Wj53G5EVry75tZ+Q+MQxkjVDyfso82W
 KN5m4zDq1V7jPRw2+dQLxL/F7PBDBt9vpPknimDsgwHCkCxpgU7N3FCElVzcdrMBY6a9
 e08/md367Yo/aPbVp6+radZiueDwHz56cN9L7Tvcza5Y7qHCLIb3HMnlN3sTViIuLCva
 YMdw==
X-Gm-Message-State: AOJu0YwqoiaK5yJPYfsG9Ky7UIZG8UZVW3kY0pepRE8pgNYkyb1dXIgS
 7RE+Mytm2EOS86L+Jia7hWqgZk/no7SPTsYN7g2w3MYKmh8dMWCOqnLHkXId/bBVA3QMxY7gjQ8
 7d0s=
X-Gm-Gg: ASbGnculhlmNnO4aXHyLxREZLxCefKHujgjQCVEHp2U2Zr0RAcyPezvoij9CoFvSkL5
 PW0xT41tH9ASaiIULe7kJ3ReDFsfOSvp1PUpRW48yFyBgPWwDsIz4BAqklDNsf+SMIUnFq2sqYm
 kHrzafS8+pvCjo0EVoSbs+qF/mSn52WT/3AKgHltRKR/1e79PCkrVhvCo43rfb+s5F0KrIsoLmT
 8J/vWyqlix6qdocHLBKMB95HGmkidI4kxOzi8QN4Xcov866E2RLbOBN1jLrsNdOXozZkSV2uC/n
 qsvzNg37LbudGphRB3WG9NFKYFpgd1yrcs1WLv4ldL1YG5dBiubdpTZXZX8CdmdCRSst/OSvrG4
 RfM986qpeUGj/6otCuR2FAOQ=
X-Google-Smtp-Source: AGHT+IHxAowrIgdTP8xxmJRJwP7S68EcVPfNAnYSDHqCdLriuxvLqYGYUZL8qdvE2IJFzoEl/s0SSA==
X-Received: by 2002:a5d:6484:0:b0:391:2c0c:1270 with SMTP id
 ffacd0b85a97d-39132d77726mr5744963f8f.1.1741522222519; 
 Sun, 09 Mar 2025 05:10:22 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcb8sm11898828f8f.33.2025.03.09.05.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 05:10:21 -0700 (PDT)
Message-ID: <b2b475e6-e5c7-4ae7-a5ba-c605ccc6bf84@linaro.org>
Date: Sun, 9 Mar 2025 13:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Consolidate core exec/vCPU handling section
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250308134938.77267-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250308134938.77267-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 8/3/25 14:49, Philippe Mathieu-Daudé wrote:
> Some common cpu/exec files are listed under the 'TCG CPUs'
> section. Move them to the generic 'Overall Guest CPU Cores'
> one where they belong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Patch queued, thanks.

