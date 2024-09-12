Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BFFEED635
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooJl-0003KU-Sq; Thu, 12 Sep 2024 14:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooJj-00039a-7V
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:13:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooJe-0008Kb-R2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:13:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-205659dc63aso14754885ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164793; x=1726769593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oN+UHox9OSM50ZXKK3Fq1bLThxL2Wq7pbmqMBNgBMwg=;
 b=qh8HpVZ2Ojkq7SnSfD11NLhHS1OUhTzuFnd7m8GRLhyTwkTjwrPwp6dNbUpSYyDced
 0jz6W7hvAu5euZEDYq9wg7dlv4Wky1l8w5ulnSbsphPANOv2BJ7h4haRHEDHF2CfO8a+
 bCOoJJRr0o6hKSArdo4uUDJ/FpgRJGZqCBC5duKChWg4B291DYNrYA8IgpUHvePKQSRV
 QqCs2n9N5P7h+F5kB8vI23Ls2El9RKiyzKKuYfHXq4je3t9fcoVDRCgsTKlm/nCqEPpK
 0XP2I59FMNjmUkkTakse1jANMONnnGXhZ4W2Xi+ftS0SEI/rz16SbKMc4/E0HlKTBgT1
 imTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164793; x=1726769593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oN+UHox9OSM50ZXKK3Fq1bLThxL2Wq7pbmqMBNgBMwg=;
 b=pnxTajypLQsvCvGuDaJIQV8aqg1MdI5PnS31GyA/uFdyZzirvvqPxg9EmBcTbcHa0N
 A0+qnmeW9Pz3n+37E1pEryCtbpYP0u2vrv4uEuPibvpNLdDo1w35+5GzYZ2841DzI0s9
 Kox6mjQvLqEPLd16sMyAk+I7yVhcjGKhpZgfVS01xgCSLuJbU3AQIyIxfhXokRzEqoSs
 /aACxAWrHf65A5X05N/M2Bo3WGVceDBB4aCAO6Eab3gnTeE64mA4QUiwereFoGgizzxA
 Lu9jFCx0Kw1NnTAaFaZ+0A17FV06b2IYssP95/wgsRTods4aFssB4JuGTyAtsJdBOs+f
 LsLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfBEIOsLQn0EvCCBhjlJeftNZtq8XJe4LqbjDStjdi7dfxIrVhkVNrWpfSPh9B38XoDDCfNq3CvAeP@nongnu.org
X-Gm-Message-State: AOJu0YwUra1Mj5wjF1vLnQcGLXoY8z7kCvdtywnwP+ECA9q7QVJBO7Kl
 iREb1fTJJhdLqvFKko+M9hs4HMyIoo1OgNlh1iTOcSxqfvlAW9+X/X3SxJVszKE=
X-Google-Smtp-Source: AGHT+IFKFqbRKD1gw5kaZP0cG7tfW4CgiZaO8lFKi14x13nLvy5KJya7wOBTBfIU/U661Uyl0JLubQ==
X-Received: by 2002:a17:902:f70d:b0:207:1842:8c5c with SMTP id
 d9443c01a7336-2076e4614c3mr65401095ad.46.1726164792807; 
 Thu, 12 Sep 2024 11:13:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9a16sm16868095ad.207.2024.09.12.11.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:13:12 -0700 (PDT)
Message-ID: <41bd93cc-6b6d-4fcf-816c-c212936eff09@linaro.org>
Date: Thu, 12 Sep 2024 11:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/48] hw/ppc: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-44-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912073921.453203-44-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 9/12/24 00:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/ppc/ppc.c          | 1 -
>   hw/ppc/spapr_events.c | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

