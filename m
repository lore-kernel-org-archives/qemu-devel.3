Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D0DC0218F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcA4X-0004ee-4X; Sun, 26 Jan 2025 16:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA4V-0004dS-OF
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:21:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcA4T-0000Or-Ac
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:21:35 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216401de828so65980835ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737926492; x=1738531292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QYxKemM/xZvwRVD9aoAgaA6gwfgdoNiv4c107IIPZT4=;
 b=hRCGw3VT7/TqUf0kSQPw7ITJ3jbYlfjN4TvbK7Zze1cgWuZn6N+g6iMb0wprEjnY9E
 Q8a1hW4MnzZM4Gax2PiUp7hVWCVte2kfUx1HpyLd+JGDH7eZFwKfqFtogn+wrTCcWOgw
 ZMwFWCS3cSfvQN7hubbgmNQvcaVjuHywvh3L/pJ59eLCNbbu09zt1/9xp26bai7ZalAp
 aeRTkcugCmIw1AWW/kXBhzd45RpHtyZX/mL7Vyn1CaJRRC4zl3Wz8LjC6PlIpwoHskYS
 CnKe+VUk/gwzv6kMnzxsBA0FJOXLERWfqCNdRop7LQKEEy4lITXD4nen1H7Hl/cPCwy+
 EEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737926492; x=1738531292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYxKemM/xZvwRVD9aoAgaA6gwfgdoNiv4c107IIPZT4=;
 b=mhXxjZUlSnjkHEt+rQbH5BolT4bbE7me37+sRGi8/SMmlyjsJSS8kYSCdNt1eJfhLo
 1nowsxHpe7BZIkmRCFbB01EAPFdFGYfdH5q9O9Yt24jDtYXBP0w7+Hmwto2Ka9xlH5PW
 DKhjbTiA+dZQzR16PWFxtb3uANrEAH7J/gRwBtNfevvFBbllehJwcholvniNC2fga5Bz
 mcIUavGWcUKave3xW5SCTsSE13Y8OTL+fY+agZl8N3Lv4TXcjFTZuUUp5+hmKwW+BRXO
 ApbkbHZZ6FmUKEfFXJCqGr8wQugnCiFgtWyk7SHP97yI8kmcyxy527uS000iRPFhPxxk
 BWXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWljqg4Ki99zrskyPbZs6lba/P63e4j8whViNpDmWz2kzazjHZyIAsPo91cb0KIo9gjwA3ZR3V1VNUY@nongnu.org
X-Gm-Message-State: AOJu0YwgztQsUsTDzp6Gy1sk7aeGsyH8iOpYjAD6ol+HdcAr2+Y8fVEP
 yBaSqveRUScMIFsKF2jGn1WMzjvQhPjip79dDQXlgNIRc02sWjPjghkO9Sb+tO4=
X-Gm-Gg: ASbGncsxOwmo7LzfQMZZWYIIPlLkUtFuZs9Omjgce+c0YANieNyvMcG005ewyiYyw+R
 /1bkyjcVp8IARMo4rJeX9VQ0lO7usXpqvoLTtFlh8t1r3XLZ+TrqaAY8jt1uUE2r1Sl3kLzy3IY
 Xl27I0NY3odEQOzp8tOU9o5fSR+C8elS4sfKTCXKshszMPeidRI2kthdjpdiHMOGHE5WhrAewcJ
 eXKuQ2d5i0/29MQGPgsnZTftZLT/GeEeO3Z1ZavP35qPqcmdKepgjyMwYfE8zQVgiLaexSSsCoc
 OFpYFegLaEAHvUMbBEMJ+YjpGYhukz5x0maPTcEtKdFJnOw=
X-Google-Smtp-Source: AGHT+IEK/IDwjYTfcGC9vytnhg57Unum7j14HBhQ+TRt9SQk9fY2DLtXa4M3MfHh3b7yHzuy9lAQFA==
X-Received: by 2002:a17:902:c951:b0:216:5268:9aab with SMTP id
 d9443c01a7336-21c355e832amr552530105ad.46.1737926491907; 
 Sun, 26 Jan 2025 13:21:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da4141e2dsm50143635ad.124.2025.01.26.13.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:21:31 -0800 (PST)
Message-ID: <6fcaa7b1-ba43-4a3f-a560-5d05a57cdc7c@linaro.org>
Date: Sun, 26 Jan 2025 13:21:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] cpus: Have cpu_exec_initfn() per user / system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> Slighly simplify cpu-target.c again by extracting cpu_exec_initfn()
> to cpu-{system,user}.c, adding an empty stub for user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Good enough for now...
> ---
>   cpu-target.c         | 9 ---------
>   hw/core/cpu-system.c | 7 +++++++
>   hw/core/cpu-user.c   | 5 +++++
>   3 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

