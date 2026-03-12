Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E4106ACDF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lkF-0001q0-0b; Thu, 12 Mar 2026 15:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0lkC-0001pa-NP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:30:52 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0lkA-0006wA-0C
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:30:52 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9a6d7f81so1616877d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773343849; cv=none;
 d=google.com; s=arc-20240605;
 b=fiVYlxoXSVfxKrRYWxZrdEL1BJA/enprOy0aoY90yrkdlswL6IsSmD5Aq96IH110Hy
 r2/IoUwTOOw2psvomU3GcIlccLH0eiwMjPfiwxwUZySQmf62VGxABRddBo8neLlRfKm5
 f6PZfGHivBiTAN+vBzWlQs1maOx+jQd5qfXqM6gx/V1YJo3FhAILRG54rad/BImSuDnL
 q1PZI0FsEm1MwCdsSeD8mJoSOk7M29nlxP4s9oX1Mq73ZBKwFhhDrsrILPRaKQ2a7pqb
 nD7OQCdtXVJxv+ruH2RwgO9HTXCdshx+yYTNeSxiS1EnBTP+Rjlfr/B8n5VqvL7Xg1tu
 belg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TmYYtvHx1q1pG+vHoKsVAiKBnYejRoLKvgnkGpoDk28=;
 fh=QARB9vtaff4mA+bi3Z1G+dpoulBJd/+TeNqhNGHddVw=;
 b=MX6xmiOYfE3XyhD63l0QNzdPtY7XDjK8iYbc8BRjj0kBvpBbC8odyHj/9TK3g1gULR
 yX2t0ov9aYT3KSDlXioiKYDepupru9Igj9q1QpVMN960dsZCKwD3ZMeBWBeSmI/PqgyB
 2BUEiEszArF+CIlF7zUb2QLbfHdzEjMSHkNpmdaf95pYFVHeoPVmeOrk7P3hJFi7RkTZ
 ITUwqi7CNnrpPiqYLloZb2pzamcyxa2opJd/YGMDK00LdVrBWIYuZXgjOnD+kJmLKln2
 hHz+qRIkdbl2xqm/jAODqZl0xAfbUM1R2amAZ6cdTRTfiTQMiCFfSf828NlbhCISf150
 yjVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773343849; x=1773948649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmYYtvHx1q1pG+vHoKsVAiKBnYejRoLKvgnkGpoDk28=;
 b=H1oL3PLONgL0pI6hqTNGaxeVEtdOWMyF9ZowWwUCyy5Qz9pyDAntYWb8kuFqebTR3y
 l7/ygNognUG+lpapxWe9ACKr7aIpaVnI0Lf5DHN/p4JDUTmd7YghtC1ASOGDI9zt+8Fy
 BxaiIK3wtmQjqCXaXHCPseNA5Y+ah9ap5kHRJjQYBXI0GPUWb34Uo5NbTu9fOMicfKhw
 5F8SNtPDFqDAGIe1nR5NdU2JPWLPgCKINNSq8iCcOsufeZYeWQneCyWGAkwweEa4pmKZ
 +vNfeqTHP/RgZa8A4gsWlBCakaqyVskhcMy5xJ4Hl2BQiUdcf/FnfgX4j+J9zKS7C9Kf
 sLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343849; x=1773948649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TmYYtvHx1q1pG+vHoKsVAiKBnYejRoLKvgnkGpoDk28=;
 b=lkkhfaepEBXZOgegwIjgWBDKb3JLlAdA6n7t6PGoyQa4xvWrqTPcXhstA5egnkM3/q
 /C73lZfjzIGnfqBhihMkpJtk4aWfeOqYmFKidjaU7LYfz13J2xh8puHuN52L6SW8LRwt
 tGkOJcqPCIC6GcIlqUYzhehVWwuA3qYT5lCfX433uJHqR0VMcOhPfo+jy6T4hYdJHYOB
 9Y4QvpfZJwGs2JWeBErUWh2NNik3EDiRbS1ClQ9SaTP0YfEGW0nMoeTYLDmLv74SUu5N
 6Lpe/dNPfUfiUU5d3PpiybJOOv9b5xrSOsA9XMvCCAUryrr0s7j2cqUF7kfuw432BBnG
 D3iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI163eVI4hnc5LeUa6GayLDHMlWja7ATxPR9vKsmWWaG2SshtmyapWB1gy4P7FcFNnmgdH889Yy45k@nongnu.org
X-Gm-Message-State: AOJu0YwT3MED/fKKnyB4nvf5SSL8rOa5R3MNMMUifVcXde0OLPXqUajh
 eBvwvdFnlp5eYSbENB4eEtzLUTWG8QSoL0WU6FUxhHAF4x+dVJEG+m8jh3SWyNQaKICIJspHo1/
 OdkOpa/+1Tfe0DUmo2+t4Vaui1BVA285mb53jKb9Y8w==
X-Gm-Gg: ATEYQzzuAI8hk3Yd5la+MSoQnGxjmwO4i/XhTQGf2h0/4SYkFPM7487qNJNS+fTqFsN
 /lGEUguxSzgETeDviMN0j3k2CXXfZX9GuaXetjTF6sXvRsJ7aB7n1jKpXiiY9u7+6F5ZvrehzcW
 yo7ZcM10eX7O89c9DhAUETatr9V5xNEbUg3pW2sA7EiXXopxtNbEo7duGoZv058jUE9Mr+qQK+g
 IP9HxhfXW+Nr/Hpxvzrnn5ZCQQZyJ7SDJA6QjBFusflZ0/fgHm5ASgxjdScG2qO82vg6gHv4pby
 EP7c6iB80UzOxVJqPCnnoDSr2PVrRFpJ2+DjFy6tDF4iPZt0xOIEVRC2UmOQmpiU7vojgtoLtyj
 K0g==
X-Received: by 2002:a05:690e:23c4:b0:64a:fe95:2ba7 with SMTP id
 956f58d0204a3-64e62fa66bfmr648295d50.31.1773343848639; Thu, 12 Mar 2026
 12:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
In-Reply-To: <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 19:30:37 +0000
X-Gm-Features: AaiRm51_ml_r9NlgX2xNipfQTV4EdFwhN3jm6qD8WLc1p5F5VS1gltPGD-WvXIc
Message-ID: <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 12 Mar 2026 at 19:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/3/26 17:27, Martin Kr=C3=B6ning wrote:
> > These functions are needed to support semihosting on CPUs that support
> > runtime-configurable endianness. They should not be used in other conte=
xts.
>
> Another note is these function are not target-specific, which is great!
>
> These can also be used outside of semihosting.
>
> Matter of taste I'd have named them using this shorter pattern:
>
> cpu_internal_tswap16() -> tswap16_cpu()

We specifically didn't want to use a name that might tempt
people to use them -- these are only wanted for the very
few niche use cases that are outside the CPU but need to
know information about the CPU's internals, which is basically
legacy-virtio and semihosting.

-- PMM

