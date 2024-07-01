Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC915C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOESO-0004N3-JA; Mon, 01 Jul 2024 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOESN-0004Md-81
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:40:23 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOESE-0006yw-Lg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:40:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-726d9b3bcf8so1781783a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719830413; x=1720435213;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y91pxqGUc6xp63OWzpq0VcCFBeit31sjYVA/z30/KAw=;
 b=dKgPV30cNHjI60+AnPZ42v8CEMvE8eYP8SMh/GG8bp18tzkKGV/TWZIpP6n8nWIi1P
 Lup28J7Q4yZ04s5eW1lf61Qw7CoTYAo7clOg2ZryWRvnIFx9L1U/tcSrRcWHHETI2sfi
 WSo9m+HsLz9vn47T3YwAcLnilC0FI6P1Jb0gb76kjpcS3427nk2HngJy7YdLM84uHHiT
 Xbmw42L1TdImfOW5GN/D5XJhDy2awW9upEbgLqGXAgFecjTVA1JE57OF3FaCUi1vlPZO
 cipQmYOLB4oJSVuuMV27befXsVQ7PCttCasQ6BK7cu0pQs2YbihFw4AQy5D6VrFaz5my
 kLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719830413; x=1720435213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y91pxqGUc6xp63OWzpq0VcCFBeit31sjYVA/z30/KAw=;
 b=Ti7rTBNhEHBDKph9yLBQ+bfecfsMC1saJ7MYGR4mmLqgmaShfTjDO21KlEGH7gPLDc
 H6Iy7uqHWrvwFVNoVXkrheugaBaP178b4su22dCDnB2x3wfIG3AL/SF8S8quZvCJ58Da
 X5Axo1UcbCvTt65o1xxjP4xXBVcTWRqe+Yc6WYpTj33mR4dvDmWoqIBmujQVNBejhGA3
 0FYCXxVifyiiBBHrTn5iEOsDeP20hKLB6o+F3uObQVnHAA0Hckn+/CV5g7y+J+UVtqZJ
 aZJhvqE1RBI9g3ZAqwWt21pam6Rfp2oISB+wppAdWATI2uKbH6KF0oP/vRWEJ4012NfQ
 wGJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8c5dyeCiQ3m6g0+OWs4Xv+d62y8KG93CQamsOEkV8Hl7w0M2irKVBOM0YleUAuKuWA9ekxP8rfpCuJk45i4jAScrQAtY=
X-Gm-Message-State: AOJu0YweUHooiCt8RTUjsFhEsWBGkahiC87DHo9eCZe9iR07yJOwFbQ9
 Sxdo+dop4fVk24sYN4J92UPMVp46y2L40e/xWqGjPTqjJ6Rwu2MoQSt7xG02rrmtTkzw/O3XE6r
 0P0w=
X-Google-Smtp-Source: AGHT+IG9T0Emu7n6i6m9DzQOj5Uhc/PAjZxKm/dQjtkGAfFjIY6RAfYSrq8gmxN8MVmuXEJCY2GH9Q==
X-Received: by 2002:a05:6a21:339d:b0:1bd:221d:e57 with SMTP id
 adf61e73a8af0-1bef60f9a42mr4293401637.15.1719830412979; 
 Mon, 01 Jul 2024 03:40:12 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce17ccfsm6455172a91.10.2024.07.01.03.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 03:40:12 -0700 (PDT)
Message-ID: <8b3657e2-5d2b-46ac-beba-fd0d5cf2a05a@daynix.com>
Date: Mon, 1 Jul 2024 19:40:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] test/tcg: Clang build fixes for arm/aarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org
References: <20240630190050.160642-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2024/07/01 4:00, Richard Henderson wrote:
> Supercedes: 20240629-tcg-v3-0-fa57918bdf09@daynix.com
> ("[PATCH v3 0/7] tests/tcg/aarch64: Fix inline assemblies for clang")
> 
> On top of Akihiko's patches for aarch64, additional changes are
> required for arm, both as a host and as a guest.

For the whole series:
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

