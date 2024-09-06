Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A02E6FE2B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smaxc-0008Jr-4M; Fri, 06 Sep 2024 11:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaxb-0008FJ-0v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:33:19 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smaxZ-00061i-FO
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:33:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f502086419so27961501fa.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725636794; x=1726241594; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qp7kpq6d0ncLVzd3V57W1r3ObwEk60cjmR4mFc4gBas=;
 b=QHdwkBR+KXe6tcL4kfXOmU5HQd1QsEwhynCU2Yu9Ah/YjmpNB/EWnw2+RKFWCK+olZ
 yiyw+4ApdEiNugTmW5xytpgYGMtRnaRMr8t8/ySHczpppmlRuCmNLMqid7UdAmzKjTrJ
 JK7ATGOt1crOFsTATg2HV+Yay0vPxQ/y7H+9SPBWQn/yWWR6exCGh9NRStyuhBj6Pahd
 4c+eTtDYN8zCpaU5k4J+IrR+GOk77wn1rGl2I4EDxap2R0PpyZGrDx9O05eSXRdZvkrR
 DSMPHpAN5XHtFmJTpNK2uAt16GfGdGKW+aHSaV+c8GCzp7z4l4r0vj7rMRzwlZ5YSQNH
 uPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636794; x=1726241594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qp7kpq6d0ncLVzd3V57W1r3ObwEk60cjmR4mFc4gBas=;
 b=TVcE5pq8yyTKuVk4Rnod7NjyjWy0xjwFordMRU2ijIlItKFMvEt/y72/XIFLgV2kOn
 H0kcy3zsjqZM4jCAGzZzvKvXdDatoKYsNCPXpsOtXg9soz0UtbYRkYg9QJ5/mtYvPCUS
 BcLL06HTkXffGW3pQzmtV6zYvCNeegSEulRXbe3BXO43hzsQjrrdafeLNGdjxJi6KlGn
 N81KODR4HpLT0oNP7QRmcHRRQq+v5M521K2UQifgeSynS0QccmZciSvGe6ioz5yA8SMr
 WYPM4t34/w1l8kE/e60PVj345cCdbQYyqTD7UefrdVQEH/2eqbDoRX2WzQMVDVbuZsdO
 plfA==
X-Gm-Message-State: AOJu0Yzc4Rkxs2QfyKl5pX+rqkF7j2WIJ5PuoYKgBQ0XHtl6mGCBypyo
 rV3NHto3vFmhIHOZwz9G8k35aa0cFwUBiBUvJIC/IvRG/2484fMzrYv2bW2QRGBNLUTjNPmU/Us
 Hxj9gDlGJGHoWbaHO69PbQxWDQkpWWhywxFmaaQ==
X-Google-Smtp-Source: AGHT+IGQ1TFwAA4RkmmtU1hN7d8gsVWkcs11KtS3jO+qjz4eLvDAxLl3bphQWVAs7LarVgw2G/jjZepcO30sch1BSWE=
X-Received: by 2002:a2e:bc0c:0:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f751eb8802mr21214791fa.14.1725636794309; Fri, 06 Sep 2024
 08:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240903144550.280-1-alireza.sanaee@huawei.com>
In-Reply-To: <20240903144550.280-1-alireza.sanaee@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:33:02 +0100
Message-ID: <CAFEAcA8ip=+d6JwZJ71P=nUsUa4o2x_7LsWxoqzpnSY7C2G9AQ@mail.gmail.com>
Subject: Re: [PATCH v5] target/arm/tcg: refine cache descriptions with a
 wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, linuxarm@huawei.com, 
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com, 
 Jonathan.Cameron@huawei.com, alex.bennee@linaro.org, philmd@linaro.org, 
 jiangkunkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Tue, 3 Sept 2024 at 15:45, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently,
> numbers get hard-coded and might be prone to errors.
>
> Therefore, this patch adds a wrapper for different types of CPUs
> available in tcg to decribe caches. One function `make_ccsidr` supports
> two cases by carrying a parameter as FORMAT that can be LEGACY and
> CCIDX which determines the specification of the register.
>
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].
>
> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>



Applied to target-arm.next, thanks.

-- PMM

