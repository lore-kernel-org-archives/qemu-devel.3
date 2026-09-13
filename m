Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD009C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 03:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5awe-0006Fc-RK; Sat, 12 Sep 2026 23:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5awa-0006A6-U3
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:31:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5awZ-00076u-G6
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 23:31:52 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1026102a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789270310; x=1789875110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q0avdD5Qt1f6aYeipVuRQ0d8ElVha2q0qWnxQBrqVkE=;
 b=ahw2fgYIUX+xhsKMeOsCrQzUxfqmIxggH1qsvCHcYxAtvE0Jeec/rSsQD997dyKAIY
 NRnCupCBqGmlKJWc5OVUL3Nb3MPk6JQp3l0geGCDo8NfoNHOagCvK9Hg3cBuDBTu4+po
 j37KZLwAERjAQP5uyHfxSCpjHy4H0AryRmfdXiG5cUgtm0RkV35nz12hm5KOZIzulF3t
 OUWPzNGWPL6JBpt/cQA5g2a6yjKM+bHltfQ6BQIGE5B3yraq4gsm9Am5Q2pxS9kn7/yO
 Z/BNKIRZtAgjMGN41ro3NbEIzOrea0SHPboUQfBC06SKn/eeE6uOiP9TajnwETp/kkHB
 7TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789270310; x=1789875110;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q0avdD5Qt1f6aYeipVuRQ0d8ElVha2q0qWnxQBrqVkE=;
 b=gs6zrpPsaCcJRif0rN5BEWNdfFYlbeFZoJMpVd+CzScEsCjR6kE/tMw1EVNb7Wvc/s
 8BgoBE6KEWtbEt8nV9aLAB1AX5fDJytLrqlEibitKe3ZF4SrAe1Bvcc9uyWj4Z9HrBAi
 TGX0jtiN1MoQL3TrImfLiUyy9T5lkmAkl+BltVISOE8g19BVh6Hs9194Mqf8rrVuDD5U
 v8kbVEW3Kmb22Q2oNDKEPy4U6qwnkTaNnyoe5WotcTG2xoc+pRN0GEYYODbYR7lFnAG2
 JS3ChRpSeA0p940H/KFw9S+gaj+9TBaGFnx0Ng2r59c+zR9wtOPnczyLVRWxMMwc+v9b
 4S2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvV09KYQ2RovkRGML4RWK+I9+XGB1b6TBMLzFf8Aeu6Z7nf8yJIY1tbKhHnmGcYG6s9hYL+Nxs7M1X@nongnu.org
X-Gm-Message-State: AFuF++lFbxomQICj/KJazyuP5L6wvGDC9SvdduSLRAZ+4z7fYuW4ZetY
 QsdKSRghtNbiyKx0Sl0/WonpW6fLrifmajS65RlzBK0XL3HwSuqwIPQgjeRO9vmR3Ug=
X-Gm-Gg: AYBFou0RfAdB7lxaokR1UX0szvT4My9saK25YAb2YsTtXG6DsHoQceepaGz1l9ISqZA
 UrVMtETh99KftXrSecRvgTlXBl6MBYWQHH3a85HIzDpk5t6hDPdKdjzakM6j0neewH1jLuS3to2
 UfUKBsdnixxP+eEV4rpyg0nmwQS1SelDZFk9tg90PICnDdKvwszzfVl5w/UVVjmXvHGi/c1Z1wd
 H2QG/rYWXG+5uqQtq3jHxGyqcWNsQ++NDvJv0enE98tgwbSULEosrVHuXuJwH8PDFiM0IpcNwMQ
 cVCcaze1cosCaJeTHb++obP0br9K9l9DiFq+mtgponcP3GSNVyrj4NClm21ErtRJ8/Z42nFwb9X
 g5swmsHUsbeQ+41cmz8Hh+cMZpgf76zCWouEZMPUNb7OddideSmE+4GqiKjJZ0OE39mF7gGhmQD
 uB4h2C9SBk6D+4pxt2V4+wncP0/tq7bKp25RJfET25lhJ+Bl+ZTY5HLat0a8vrgXl+RZXdj6x0D
 LX2U1Y75IXejYpMcJdTu4nmYi7KM7GFHs9OG8O47jzLd6NHiOfW44kMSbmmNlpblUkyQL+q
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-39d9c1db130mr22838193a91.13.1789270309766; 
 Sat, 12 Sep 2026 20:31:49 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4efc398sm19822422eec.19.2026.09.12.20.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 20:31:49 -0700 (PDT)
Message-ID: <c0f30411-cbac-4551-a8dd-bf11f150d26f@linaro.org>
Date: Sat, 12 Sep 2026 17:31:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] accel/tcg: Rename do_interrupt() to
 do_interrupt_locked()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> From: Robert Foley<robert.foley@linaro.org>
> 
> Prepare for pushing BQL locking down to per-target implementations.
> The old do_interrupt() name will later be reused for a wrapper that
> acquires BQL and calls do_interrupt_locked(), enabling targets to
> eventually remove BQL from the cpu_handle_interrupt/exception paths.
> 
> Suggested-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Robert Foley<robert.foley@linaro.org>
> [PMD: Rebased and reworded description]
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

