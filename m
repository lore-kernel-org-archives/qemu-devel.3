Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB92ACD98D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6bl-0002Av-OX; Fri, 12 Jun 2026 14:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY6bj-0002Ad-R0
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:27:55 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY6bi-0007FU-BV
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 14:27:55 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c858cc9870aso1079989a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781288873; x=1781893673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qj3+qqun5Miycu0p45/x8O2Ir+QOavDLOB6l4yBGeRs=;
 b=bud8dQ2P34lfv96QMtzqrrTXef0rPQGH/2Tk8jGs2esQUsYNzw6mON39qaTIqXSnKu
 q7bE+Yo7gG64PrnUW6qyjIb1wFZ8KBB0vaeWu3i5vPnJ2uR7No/ZySmwTTNZ6LzJZYCg
 9fLVf+zNrkzG7AMDYObWHp+ko6CWuIdRv1V4lbEtMv1slKTEfchj7WR8Acl8g0qELABS
 GrWTGF9KvpeqfPLX/wDKY/sI3E2cfty1QpVrfnmfUQG//kNR/dx0TVrN3Fkv7Zu/bUY5
 bO8VT7DhDrj4eguBYnl7nJWE635inQV42BZHr8e3vpwOfDz658dzMdV0p9l67j9+H3O1
 euZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288873; x=1781893673;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qj3+qqun5Miycu0p45/x8O2Ir+QOavDLOB6l4yBGeRs=;
 b=sCfSBlC2l3VALFI9ORA4eZZEYfvhdx6iTRQCmi6yJLAjCoLWs+J6Kk0i+kTwnxzQlM
 CR6fPJ2ytlmF1zlbVH6/jYEd0gsae6rfCrfeAzR4mglUs63COPwlOlxB1TgafkA/GnGg
 ogK7Z7/F8Q8XjY1U4K7EuKVtpgKdeTLKFxlQeq50fr/uwRM9K6+NpzpgvK974QYU8+mr
 3Bzr7ZM57nQfZBZ52+2gXWNplbID4VwWyCBIxfvwS/QDZyxjk+9bZdIoOx6pvPsUCQxP
 KWUnBKYtPwD/R0X3opi84oXP8RHp9nJVVLSKNGnuUQahPYBODwVfH3UTgzpAZeXjo4Q2
 DUig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KmvK9ojm94DEKruqON5MJ3OWMdR+FcWP9MLzG6xcwmz2GvOv+nMyWMC9xeewHvxDyuAbkZpvZiQ0/@nongnu.org
X-Gm-Message-State: AOJu0Yz9jSwg3iYCWYmgccybJxDj92KUc7zrPlPbt5gAkqGHKGdxyfPL
 Gl1yTGW1N5Pjo5mnMnFDfDRfSHJwkJyNp/PndZDBSdqy+nR6BCrhDkOSUQRUMT/BHgg=
X-Gm-Gg: Acq92OHD1BOqkiLpMj3sSo71c+uMm7rgQEjQWUW7K3V4QM5yDR6pUTM+G68vWh3KUfd
 xWK6Mc86ar3WGiGeqtnH02cebzIP/xKZdUQU7vT2ITD81Xq+iG5Hw8L5PzL/IW5scdxqMRhPYnt
 n5ZvfFUMtpJ2OocTdT4Bf2gFtmoMZeNgqyhvI+3rcciEaCehl+DDRVQBI2yuy1xyjFJaHdSg3UZ
 kRNKbMZ48miF9286caFwYeU22wlE5qJ/O7Z05ZFBH4clojWiK8lbPiajL5alpic/dq59yV9KicL
 o1wY8uAW4FHxLaM98zl3Bp8ZTqQSXU4v6ky93LmF+ID7q03IzdmCHtVB9m664oVdvTL79V8pQuB
 LFF5ZDySjRlK6s8K7R+VRAFfIehrFflERKRg31B5UaV2m7HJCT/JFAZakKtF70DCi808VaRzaf6
 ebyXFbQjq1EFWRPrNWHTNicxCvzkB1as0DfZZq
X-Received: by 2002:a17:902:f552:b0:2c6:6425:b343 with SMTP id
 d9443c01a7336-2c66425b436mr5582155ad.6.1781288872445; 
 Fri, 12 Jun 2026 11:27:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm27999505ad.65.2026.06.12.11.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 11:27:51 -0700 (PDT)
Message-ID: <7e681b2e-48fb-48c3-b143-cb9c15c76747@linaro.org>
Date: Fri, 12 Jun 2026 11:27:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include/qemu/bswap.h: Add support for Int128 byte
 swaps
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, philmd@mailo.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, qemu-devel@nongnu.org
References: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/12/26 11:03, Frédéric Pétrot wrote:
> The recent introduction of endianness support is providing
> a clean framework for the standard integer data types.
> This patch adds support for the non-standard Int128 type QEMU provides.
> Note that the ldn and sdn functions still keep an uint64_t as argument
> and return value to avoid performance overhead.
> 
> Signed-off-by: Frédéric Pétrot<frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   include/qemu/bswap.h | 63 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 59 insertions(+), 4 deletions(-)

Who is going to use this?  I won't add this for no reason...


r~

