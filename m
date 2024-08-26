Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444BBC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicGE-00075l-Bu; Mon, 26 Aug 2024 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicG9-0006qo-Jj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:08:02 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicG8-0008P0-1c
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:08:01 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a86933829dcso496885066b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724688478; x=1725293278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyDfHmFk7Ebr9iQtT14QhOb28pKspIkBukJIbX9kwRI=;
 b=RciNSYBYVLRodfeEQPMir0oPnn8c+Uz7HdhakVSaN3r2LnHo/yNT8yayTR2N4r5/Kp
 w8vIlzRlx13uteVnlkwFaGsqzQckofuvp32XKDMNBSBIUw9mRHGk7dV5oWR+kjTBziyx
 a5iA4PzevdJjhBTPUAwpYDOf6lbTc6PigIo3WCfDy1LFCJF2R3ylWHIUeKi8WTmqKNuS
 kMX1iEZpIMGLj7XVg+5aQKJdxsquWPS2pUxJUxdc+S7lju6BDOd8HOUf7TTfC2ajN+iQ
 irQ6ojCb/tWmClunu3CQ88VDan5nVJ7ftqpz6QJTdgUd4zDWW55pM1KooITHTBXS2QmB
 t8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688478; x=1725293278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyDfHmFk7Ebr9iQtT14QhOb28pKspIkBukJIbX9kwRI=;
 b=jqsTLDPiPuOw4JWYxfZE+qNBPzM5+hvAVJMJOIwAO+HJB4nAfhNjHr2Sv5Gs2/m0yI
 B1AynRuqbsQXnPc6Wtrbqn+uL2CnQbkSB3DC4uxbDiXWfERTqmw566ekp4I2dlhVXqz+
 djilcHCG8VZOkNrmkQ7uYiwp6UrK9wfSGnYD0o0DUoOYEtxvMiewPhmwHVvMmVt116In
 PzCsYaRUpqjmT6Gr2PEcnCw+xI4uKBBTglNge4RB5iur+SrGuECZrFSxPoq3TgPoOMJr
 DnZDg2VMUnp6y3ZaDRXAUZQuEeRs7jRjQebgP14SEwzxVM9temNpEntzqjQg6DK5/qyO
 EhAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1L4v4nsR7/LWf32+6ff5lYd3KfdPz8XSZBF2JTiThgKhWWQBiLifsxzvsWeWRKBDe4htPIoThUN9a@nongnu.org
X-Gm-Message-State: AOJu0Yx4qFqaCP/N2um2R2P9G2WJpn3xp3eulL92nyApCPavcSCAlK2i
 6PZwV9ic0x8GZTlnA4uaIdPdUkv89cFYpP/z/rAyPMzwY73i1yTnXiyENeCSEzuliu5jm+eWRMj
 Q
X-Google-Smtp-Source: AGHT+IE2mEautUWDhj0Ic0VfYtCjAGIbWez7h+spNaKxgM3XtR+uVDoUkariOjZ08ZPL+yttFn2v6Q==
X-Received: by 2002:a17:907:97ca:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a86a518b29amr642571066b.2.1724688478136; 
 Mon, 26 Aug 2024 09:07:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f62fcsm686442566b.211.2024.08.26.09.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:07:57 -0700 (PDT)
Message-ID: <5cbf1a08-6ad9-416f-9fd8-32a7617bdb27@linaro.org>
Date: Mon, 26 Aug 2024 18:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 09/10] hw: Rename DeviceClass::reset field to
 legacy_reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813165250.2717650-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/8/24 18:52, Peter Maydell wrote:
> Rename the DeviceClass::reset field to legacy_reset; this is helpful
> both in flagging up that it's best not used in new code and in
> making it easy to search for where it's being used still.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/qdev-core.h | 4 ++--
>   hw/core/qdev.c         | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


