Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5EACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUog2-0001FK-OR; Wed, 03 Jun 2026 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUog1-0001DI-GO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:42:45 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUog0-0003Xm-4e
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 12:42:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so1876162a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780504962; x=1781109762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKFy5PQQI8iacjLP3uNk7mEIrIcpCeZXN7GiftOvGQE=;
 b=CixrslbCaweKnX2YyHAgcBlXK1eg5ZEgU6ymrkPuOauX5xRLT095ow9V3mr8B0vH48
 epQFEwgdSHTjE8fM2tjzIPYeNlBULgek0JkH5SneBKU26fNAz2ZW5/bazGmQM9CvdV1f
 neEUHGrm4TKNaAlXqlW/e1O/NBJOiAOdRfkfKaYQqf9oWFVtGvjOF4Kt/pfTNWYZUcye
 6MRxUCh3s5cGGMMISYaRPa0ZEoMZ/re66ysZMk5lnO1ljTV2q5O6XW0TRsuP+Mk6otIa
 mA2LxXzd+5vPuHLDDrIWHsCEW6snt4igCpoZ+QF3mwle8D1KgPNGpVsD8T1deXoBUHTG
 h9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780504962; x=1781109762;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKFy5PQQI8iacjLP3uNk7mEIrIcpCeZXN7GiftOvGQE=;
 b=P0Mz5hJpPhHWPw9p+nO5rx1QCE+nr75Nctaeg1VjVRHh6MGn2++F+hLmU1Vhv/V7Dl
 TMBXFEzCJrxA590S9Qu4yghnutLi6QGyspZRKy/dnEwrY4L6rsVwAcn6RXhhtzKycAMS
 +iOp3RwJIGDHzpk3K7As9U9wgxzFSTeBn/1FWr5iH1zM2rIoaUW9FUMD5CUCmJ908TDA
 f+LyhxzXJD7o4yrCGOMpGaV6Tnn6ux7KgLWB+iUiiEYyGKJ9mUuPynjNk8+Us/BsjZDm
 d4CaBIb75XM2nC3RCYkzd+OShqYUqwNUcCCFbssU+H4l9yDX5IZ2GLEiBr79wCKIYAs+
 fWfw==
X-Gm-Message-State: AOJu0Yxv6EquFS9Z2070R+dn9pjk717pVqvYPC6vwGwiqBR7hr2n+BgX
 4uwaNQyAeaeSdEjXtCTdp+MwBH9dR15z+PyKZkomM2oYOfpV1JCrDsIUd7S9AnOtGkFEu65OnFs
 RCst3Ij0=
X-Gm-Gg: Acq92OEW1pVO3jMdRrhl/eP19ZVpHxaEo9dkE704z7ct5G44ANG5/nJro1VXSGaNrtB
 hewRCUWH9e9SpJd3yoOop69hcRaxk1aak4k5X1HmucWAbHQgzjOlwGvVrEEkfJWiqWF5P5mkr0a
 M8X5G9EU99gBVplYEZGz37GSBVtN/LD6jr8yTvRDefSiIdGWsezquFX1TdhwzBzLRHGVOF2Rfsr
 qiAHidKlCanoovMfRPO1ljpFnJ/PaFJlhZ795sVYizepImZbHonf6EgejOch0Z6G0EjpoDnAtgh
 y6txAfePNArKe3wQYj78byv7Z6XAYTF5ZTO9UJwVhO3D+LboyktCEuO5STSut/atswMvIYK/AH9
 kdNVV8ZY+GMckgok9yW/YcCf1iaq55S6V6W6gnSCEAPHP8BmQPxaCLE5dIMhx+hHxtv44PVVdwf
 u5o5dLACF2GUrT7sAAk2uEXOqveLaxEi8yZ7HE1PpHK/sCloVK0kiqiezObA==
X-Received: by 2002:a17:90b:1c0a:b0:369:7f25:cec0 with SMTP id
 98e67ed59e1d1-36e2dc53790mr3857216a91.0.1780504962300; 
 Wed, 03 Jun 2026 09:42:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36e6e1f0880sm1213338a91.1.2026.06.03.09.42.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:42:41 -0700 (PDT)
Message-ID: <51c085b4-ef83-4d84-b028-9b8e3021ce9e@linaro.org>
Date: Wed, 3 Jun 2026 09:42:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
To: qemu-devel@nongnu.org
References: <20260603162545.1835769-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603162545.1835769-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/3/26 09:25, Matt Turner wrote:
> +    static const int rounding_mode[] = {

FloatRoundMode.

The rest looks plausible; I haven't dug into xtensa specifics.

r~

