Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9E9C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDT-0002Cm-EK; Tue, 08 Jul 2025 16:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDrH-0007qg-70
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:03 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDr6-0008Aq-DW
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:19:57 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eb6c422828so140578fac.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002367; x=1752607167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F2HpjSQfUcyL+dk5nvnLr+0m8+LQPNaBS3pAOPLTg4I=;
 b=SXxkfaL1tN0UuyMipwKtnc6zPTkiTCCPOnsYYRbhJQZYa9MgwFwZk1EJSRCLGSMz16
 2lYOTuytUJoRg5+BHGWQlbKIO58uGnJQ8XobJJaJbTrVGS++5LcvQHnr0GyFUKtgs2GU
 AYUbDL4ta4LFGogD2IqL8DK1CXZBtDgCBI1aOPzdr+IYMmEJ5NPXlSfHod/SIUl24DY4
 mxcz6CZrrhDjWHxjwYloJFTsg08JyrNJEkB67uDjbZi+haB4eKEnj8xbssCapiOrks5L
 icIQ09DctlgB37dtCidRtwZM8UDRvrH3EnThtPf75mZAojXcUBzrDpFAgUyQ7d3L//yB
 GEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002367; x=1752607167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2HpjSQfUcyL+dk5nvnLr+0m8+LQPNaBS3pAOPLTg4I=;
 b=PU9ssw2ts9aUYsJPu8MLCI3tyRnSCao+T8K31YHJpKNgsXCs1oooiQEBiZmiR1PrNs
 FpxpxPkpdun2PgUrM48aDCTvDKwA56lIC7lFsuI0xGOE6w4MG2wadaAjVW8fjqcstPJz
 pCDo3Mi3WJOVDvdOnD50SaqgP82m9giGlBbH2d2oUClxQKhBPrTli+lUYKFUVGR0O5yA
 4FynaRHelLjVFHhfR3sagRSQF1scxjmVYW6nStLPK0Ew3Wvo4Li2j2xoTIPH9VXcfXFD
 /UI0ytRM9+bPRrO2zQqK3ttLR+0+hyc7foazWu4h6cUaksaca8+GOYPvR7myVtUvtaMw
 /ePQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX74GVT06mtzM0QibPNZ/gRPYbxOv2o28ffLg8uWI6O93Ih8t440VDHAa85CP5q10NJhUeYw8Q2OInF@nongnu.org
X-Gm-Message-State: AOJu0YyDvdjuQ+iuzWXglanxq2pDDRcy7Qpq/ATJCv5ssCJk3r++9pck
 3sIK/POzDmGVEtnk+Ylk5lw0A2AXRI8dnKCuIUUjqL0n+5cf1ubxaffibCv5eVEfD/YXwlMgLvX
 +VebC
X-Gm-Gg: ASbGncsgmgI0p13d/Ncb1a3ivp65+Vfymn7VsyWpMZ5o78QfCsVfdlBLAFQaVlHwvxu
 NhYNj0neOFyrAU5cPHtBKZVAH1hH9EQcFoRR5urhalS726Ek+fS/+/jO31N7hDE3vrDU0sEtQDl
 PJvthowOPdtsteT1Go14MtVzlKMVAErvAgXNCx3Siaj164/Mot1wbtmz9XtPI+NZ/5BMU1ENcgr
 PjREtr9kkmXeJNCmB8NCH2JHMXzJLPwFqw1cWw+1ctOD2kq36vQ+6n346cs2AZ0ITnxoYDHNggM
 LzgsxCM5hmX71iTnSYrmOBMlX2gEqAa0vPZIP9AeJRfkDjmJd4YJ6Fu55CZW0EmYxo8VMCzpD+Q
 =
X-Google-Smtp-Source: AGHT+IHpQZ5mayqXOBtFoWMKmAuI9WiG8w0UvJ6VnSm11hYptZaOI4Kwceq/TASatqqqGmROppu9jg==
X-Received: by 2002:a17:902:f644:b0:237:e3bc:7691 with SMTP id
 d9443c01a7336-23dd1cf882cmr44518155ad.13.1751995993465; 
 Tue, 08 Jul 2025 10:33:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8f1241casm92720165ad.76.2025.07.08.10.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:33:12 -0700 (PDT)
Message-ID: <db881c13-afa7-47a8-b8b1-7a7aad551cd3@linaro.org>
Date: Tue, 8 Jul 2025 10:33:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 4/8] qemu/target-info: Add target_endian_mode()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> target_endian_mode() returns the default endianness (QAPI type)
> of a target.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h | 2 ++
>   include/qemu/target-info-qapi.h | 8 ++++++++
>   target-info-stub.c              | 1 +
>   target-info.c                   | 5 +++++
>   4 files changed, 16 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


