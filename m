Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D84C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmOK-00063D-G4; Wed, 19 Aug 2026 15:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmOE-000625-Rb
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:55:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmOD-0002we-Ap
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:55:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1328556a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169356; x=1787774156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PkJ1ZPAtDfGQ/iNKQ2rds129FttPYxMBjsrotuKDUvU=;
 b=cATXj6lSWMs1EkqliygHE2er749hXHsy/D4qaRjLtoNYE4atR64/pkB2oY6DvsqjPj
 PZDImy+ab66hbd/BaSkXImlkItfMFFxAWXB4kAVlRHjJq5AzYN+GuzXXdy5Dlqjte96F
 A+l3UpYBLdWV97KahPMO0A6Lk9LaXWz4ysNF5yCbfTdtaLsb2UVI9P4NRcoV7GY3pIne
 9ElHMDSq9Gl8P8lQ8aAXhab9l/gD104bcVYhJL2VdMo1UqHqWuGs41SU4k0DwyWwl+oa
 bbIvfEmvGc9PIEo5V3KH6Ooh31Vo2hEhbK2KEdwjGMRditr6Ghm5EAGZg2GhHA/pztZ2
 WHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169356; x=1787774156;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PkJ1ZPAtDfGQ/iNKQ2rds129FttPYxMBjsrotuKDUvU=;
 b=lecWINKk5bMK8c6QZFJ8zktkG3s3X3HpRk24GOA0yEVIPnztOx0SG13p/ge6e6xjut
 RP+V8eSJXzDlpeLzDPKGG+jw/M1lv9RdKXeRFSbNkN1VQ6of6OdOtAon/581kdGf3NVx
 citPdUsFpLcoin69rwjCl7W7hq4O/cOBmjdjxaYs7nbIXRlTLNkgwwhG8Ei1ly5b4ewR
 WV2Q4HmiItBwGOsGW1jyc7+a6kYokZUFwwiIDUgpPBV3qswS3CtPg8UYwJjHXmRraKel
 aoTof7exACobaIl1RCWz0AqGqYAhHaaVxERljQdCv1XiKp0Mztt00L5q0snp1V0StIQn
 NQ+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RotHcGjcEd7M/xsvEN455qHtWYd3xmT2/bm2FvJA8theYTkp+Q3qEW6G14SmEwyUawAs6A72AQ9aKOy@nongnu.org
X-Gm-Message-State: AFuF++lo5U7uehexpZcIx9TJuT4PqvoCFCj6OFodng+WzZMwA405MeyO
 tHG/6f5qyZppKSHTqRSlQaKyMJv6ySeGITioBktPZQFkg/fDOao1tNav9HvWCGDrpr0=
X-Gm-Gg: AR+sD10X/40jSh9czBSxyvAn8hkf38Dz8nvglAkazzuUHSab4vIEdnm3UTDO3X01BaO
 CofZwERlY2M7+Ppv4tJ9ejZw50miJ7P5Zz+gI1kGdq8pZfLzvz0aBbV2a1dFCbcDhastJZluHSU
 Pqb3BRQ27815M8skY6OzOrY+z+PIShud6FLfnrwa5OYmoF6Gt6qV+texZcQEkZCKJNpoaAetSQC
 +JAeqa2j9SKpGvDQybw4FgUYs0KlbitI6V0lJZ+nlRwpsxI3DTVvMn316RO1HY7Oyka8bOAInRW
 KYwQ6zESP177MP80pvS7s/DY8FVdnqRA943AoIXOXMGav6M82i70KpSAZTC09wNUTU9bf+LnvNK
 9Q07QwWXat2EKFyJskf8uMfS46o8NbvIRac99V6totbPVDi0cC3R/5ywypNdrb9OD1fTCTqm60l
 OqFNbG4Laui43zKQS307eXTJ970cWAIjsesD1IJGDpprKwefyhx4Oa1k3WYLL+Od0Ofv4gO54Ln
 DS/I895
X-Received: by 2002:a17:90b:17c5:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-395814cf6c4mr11004878a91.16.1787169355529; 
 Wed, 19 Aug 2026 12:55:55 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb5127csm3598695a91.8.2026.08.19.12.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:55:55 -0700 (PDT)
Message-ID: <fdf8dd42-ca26-4891-95a9-2cb61e098272@linaro.org>
Date: Wed, 19 Aug 2026 12:55:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] accel/tcg: Rename for exception codes named @ret as
 @excp
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Rename meaningless @ret or @r variables as @excp to
> directly denote the value is an exception. No logical
> changes, purely cosmetic/clarity improvement.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/cpu-exec.c            | 24 ++++++++++++------------
>   accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++---
>   accel/tcg/tcg-accel-ops-rr.c    |  8 ++++----
>   accel/tcg/tcg-accel-ops.c       |  7 ++++---
>   4 files changed, 24 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

