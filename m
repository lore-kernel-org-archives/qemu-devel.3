Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A238ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIVb-0004E7-B3; Tue, 21 Oct 2025 15:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIVY-0004Dr-PF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIVT-0008Oc-0x
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-427015003eeso1279171f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076731; x=1761681531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9TuSrGF+WlV0+1U5B0MuSgjP9sXtD7t0YteZNrrSMoM=;
 b=flXyJ4ozj83CJUBC7NHjD6pKFR1gT/7c36N30AcadtgWE2pAVKAd48fwXgoKoesVkG
 KdS9Krtv8zSoSM5rY42S1HHh7LRWsKbpB/rz20X+VnpXFqyVjGwLN2u4FFm5w9ldmhWM
 SM/d3FHBkJkHCK+Qt+qFMKS6Q5YfslKu1ssUf2Png8EiGc6s6HN1ndRkm/Tk00ZQwhQT
 9JRY46v3Z5c0RYuFDayukGf2O1ZsHCJM5XTEdBPzjS+47KdCmvZnT2oPeDsfSYAnGpx0
 oC6S57ne4t882PTc2dFGU0U5HQAdFqKH1XSn38mE0V10tENJaGVQPODdcw6VGIaADXB+
 z/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076731; x=1761681531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9TuSrGF+WlV0+1U5B0MuSgjP9sXtD7t0YteZNrrSMoM=;
 b=pBaQ93UfJFQ8Ej+8S2EqjTWosNsvEhl/digvIegU52wZ+WwW3vufSrslKy0SThhyJh
 yF+KZuQcDEyvDL8wKfRdfztyFF5bU2ObuIoPznDjYUrgdNacc3U5kfihGd4Mm8xoCUbQ
 Qb4pLNP++1CoFlLursSamWfvU6I1OJdrv4Ow27Q8ejzIHwKTM1Kf0roS3CwXlff8KHFW
 ASIQ1jKn+7xRv5xOsGhJsFUlNdp7QI5/fj7gtcYA9M7QWgWn7lwNhQX/HbqJEe+nYJVN
 IKxukQTGefp5iYCkJW0e75+2HRUeYNwnzbr/ysdmhJGtwYVo/Br79TfLIceZygL5lXZG
 I+DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOidh5Eoopw1NZyPMujqyJwhucyjv9tkNaBMOgQVVXZYfFmucW32C2d3lHofOLJFGuAn2GQYapPIG5@nongnu.org
X-Gm-Message-State: AOJu0YxVHExOq7UoMg3sKy8fTUwIBQOTZFa33KoFmaV2ngRyGSldfV2n
 qQGAppqe0Mrvk3GzrSjUgZLh5JRR1fsVuWJUL1A7lQjkt0TH7HR4FryTPsjSfipSFd1Fp3PAFh4
 07yJr1l8=
X-Gm-Gg: ASbGncs+fD7o6z6+zixVaUO2DTSPIXsYdO+KT+pHEl4DYZIMcQGJHai4yfT5x+3wdL5
 b6sagwtNFU/yvBawaW/OXGQwryMjpvNCqs/wiaZQxVc+ItZ/yjDv90EeFRye17DrMeFCDkc8Fc/
 WGzdErmYSztZt8Ko5yR35Xuz+PT1Lu6vR2Uoz8iUWf9hbNEShpk7lRRzE9EfcZwjQJ09UQTLRrl
 y3CUUv7/UBx1jLlQ7Fip3YjPQunAZLqULGAa0P09TEscdEzB9Qpw5Rnk2C389i1O42V0AgLJ5Y1
 qUCEByV2KSrdl478Dbewp0gh8YgoqUeyScAjLFR/I1ErsI/ll4aIdVzMF2Kl4VpfQEJodbdtb4b
 E0cDbW6+jpbKpIghHVSQmrToyPwu4w1lXteeq8ggRK7/k0EN+I3cpqS3uHdZ917M7lNhXK311XD
 HlYBStGbl2Ej1uSkaFJ4/neXWAPGVX6k4Fn1O0+JLiLnA=
X-Google-Smtp-Source: AGHT+IElRBlx5s70oD98BH17UYxw8XE6nzCz3fT5/NnNuCVoOvPbevkq4PHFt/p79Ay/MOM9bx/dWQ==
X-Received: by 2002:a5d:5888:0:b0:427:151:3dae with SMTP id
 ffacd0b85a97d-42704d8dfa2mr11988700f8f.20.1761076731642; 
 Tue, 21 Oct 2025 12:58:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm21509934f8f.14.2025.10.21.12.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:58:51 -0700 (PDT)
Message-ID: <2e6ca71f-4ca9-4ea3-86d3-cfb46b19132e@linaro.org>
Date: Tue, 21 Oct 2025 21:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/25] target/microblaze: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <cover.1760884672.git.neither@nut.email>
 <fd9c79eca3e6c590fb630f948474e1186a9fabf7.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd9c79eca3e6c590fb630f948474e1186a9fabf7.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for MicroBlaze targets. This architecture
> has one special "exception" for interrupts and no host calls.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/microblaze/helper.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


