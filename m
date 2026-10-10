Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F0CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 10:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFTxK-0007QI-HQ; Sat, 10 Oct 2026 06:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFTxG-0007Pv-QM
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 06:05:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFTxE-00084h-WD
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 06:05:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so5208715e9.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791626723; x=1792231523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Eun2wuMaDTL+cwDtkSHvnrtaPvvClJdUVCr3KH3S40g=;
 b=BVsMNLOlKuIZeInooMULXdmdfMtrqO7F86ZHRUNuOncoYVNlOeQRm4gOLMuUQUJqGX
 hYK0fWnChmBs/jzlDMfvSU0M5tfi1995uWopJWgIABf2BLfdhPZM1Oa4Od1MD5qnNHbM
 +u5urnYditrAy8XVcyW9sBF7QnG/Da9dDMh6vgDxDWpu6bFUc3m8EVWM7AUQY+oPgxxJ
 EfboSs3xkBlY9shhpp/lRAida5++/0fkByXa0RQeWf3R6KwOF++O68azuw8adpjFVtQV
 xdwqiEA+OpSxT3chg0TFKNzoRt3oQWC6rQlzbZkhqcNmZGZdQM0pk0AVMfstiTCrV6ZS
 3Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791626723; x=1792231523;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eun2wuMaDTL+cwDtkSHvnrtaPvvClJdUVCr3KH3S40g=;
 b=ozAfIdRPF9WeLLf2qAhf/yW6g7Aq7RFjs9lb9CeEfH2B1aJL4A5OjhUilHu2nZrv4A
 BytGPvhFkJ4g0s10ywUxvbH2coTpwCmSSNzLwL5ZTcSFlWcFvUzcxv4vKtuVxjIVtBWZ
 hkoaSIlH7GYVo0QcqJvCoGmzWynWkmJ6lQg8cs7DA9WkyOJjnIv/HxUJ9AwyjjrAABRM
 Y2qCP2ViFzJgaOYYKqRoEk1NkQ6uxxMBnohcx1J2g7potMZP4j6CfiJrt0SdX3eF8KW0
 z5trkA+Qnuifz/ibanjf+//cw4SippEv2z/TaRcwLPGKXfV86VdRh8CJsMT+mH+tLBqR
 JYWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzC9a9IJD7UnbgDiGSe6LcWUXfphS/kayou+6K2XzmDOTFqqRVhzbzjoB9e77EglxrjTiMvZyOc3Dl@nongnu.org
X-Gm-Message-State: AFq9FYIBHkQ93UO4kbCdFUNwB0gMbUPjeVBooU409DidknCu1Il3Kyfc
 uTTuJXQV+23y49Ac12yyMDY0MODgCd3EJw6dWZy4nKfxrR3LOftHHwhtZzxIMSSsUeo=
X-Gm-Gg: AYBFou3PpK9MyHJ301tyPXF/RRl5GdjgcQMCuNNR3wLoaemFHqyUt/Qiph+ogNbDXQu
 h6CY96eSLKTQYc1TQ/U0MAMkfhZd/bFo9yEPHv6t8mN17sAMnP4fOd4TT+XG8+SmK4QoGSOwe3A
 KfXGfGvAA8zHzN0Cg8OB9ZysVL2dhKt6OjS5OpJWFQUWd6Kgt+vuwHw4zV50P4OgSl/8jcuYxLD
 qDWRFR7KtrWerCyH9380sQntiiWZ7nWzNaqfMRx1Q5B3Bn1emq415qxdKBUAu4vht+gvLeiq8b/
 8ARRRdytre7avHgnnBqk6STdDz0Z5W9vynK6cc2HsEFSr9XQElU9e81XoKpNpN3obh74OVKiIbE
 SJLXoWvtagD9u4Lwdq2yGqc8SX4gctcsLwml7z2fZVIXb/qV2u7SgJN1TvMh87uj6v0RMQv9jdd
 FcmaI/wOgHxhjoKcIAGp3GTOx2l0xopp7RIP67Y1u0leoK2jva5qQmWv72+Va8KQXZqNjjZYMtK
 3mMh4jRtTdk8juket7C5z9h5CLTCJlOCQ4o2fNqhJ7Y4S2gSOIFfWw=
X-Received: by 2002:a05:600d:644f:10b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4a196611aa3mr11396275e9.29.1791626722983; 
 Sat, 10 Oct 2026 03:05:22 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:1896:21cc:25f1:819c?
 ([2a00:1e:e082:2901:1896:21cc:25f1:819c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1984155a1sm1038485e9.2.2026.10.10.03.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 03:05:22 -0700 (PDT)
Message-ID: <05eef374-0e94-47e0-bf79-bf19f6311b18@linaro.org>
Date: Sat, 10 Oct 2026 12:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tcg/optimize: Fix s_mask for rotate by constant
To: Dominic P <gcc@gcc.dp11.uk>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/30/26 20:51, Dominic P wrote:
> fold_shift rotates s_mask for rotl/rotr by a constant.  For I32 the
> INT32_MIN OR in fold_masks_zosa_int can turn the result into a bogus
> sign mask, and the next sign extension is dropped (ARM sxtb; ror #1;
> sxtb, i386 movsbl; roll $31; movsbl).  Patch 1 handles rotates like
> 5fe51606146 handled the logical right shift, patch 2 adds tests,
> patch 3 builds the test-i386-opt-shr test that the meson conversion
> dropped.
> 
> Found by differential testing of GCC output under qemu-arm.
> 
> Tested: make check-tcg for arm, aarch64, i386 and x86_64 linux-user
> on 9c88811b81, 312/312 pass.  The two new tests fail without patch 1.
> 
> AI disclosure: these patches were prepared with an AI assistant
> (Claude, Anthropic); each commit carries an Assisted-by: trailer.  I
> know docs/devel/code-provenance.rst declines such contributions and
> that checkpatch.pl rejects the trailer.  I am sending them openly and
> leave acceptance to the maintainers.  If they cannot be taken, please
> treat this as a bug report; the reproducers are in patch 1.
> 
> Dominic P (3):
>    tcg/optimize: Do not derive s_mask from rotated s_mask
>    tests/tcg: Add tests for sign extension after rotate
>    tests/tcg/i386: Build test-i386-opt-shr
Thanks.  I've taken the first two patches into tcg-next, since the third 
has already been merged.  I tweaked the if condition into a switch.


r~

