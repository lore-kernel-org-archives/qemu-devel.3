Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF97DC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsOo-0000KI-Ch; Thu, 10 Jul 2025 10:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsLl-0006de-Jx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:34:15 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsLj-0003JM-NM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:34:13 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e812fc35985so888661276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158050; x=1752762850; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZx8hcW1Rlc2u9IrCb6ZWenCsul9KMBTbsW/9rgfZNc=;
 b=eLF1pA0M45vOfaDAw4UMtTjf0UYC4KSXPLpRnnveeztRlMYNJPei/zrwfMfHAgTNnP
 IWIUIyOakCqzWtPlZH37pePSxOuFBcAUulx8MYnOxjnkghn85pIDg9y51Id5OCZ2XOe6
 uGMauRu6QJllLPFrKmnE8Atdb1okM4FNGCMj9/BsrNJN67cQ/8U6GJWpyCf334q3m6/B
 arjzhe+FTC17H93wY//Oyw94Wj6Dk8p/0Pa7+pZyXYm60SOpMrDvOii0VDqNt2eTREzY
 6i7yYQfQv1lOezLvZ7JA9qMpFwt3kQmf5D1PgsUJvoIjrExxfFqsv4TxzMeB74oDE3BY
 JOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158050; x=1752762850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZx8hcW1Rlc2u9IrCb6ZWenCsul9KMBTbsW/9rgfZNc=;
 b=t+N+sdO5k4RZ/SDOJPovP0R1EBON++pHYqkUHmkeBhyEnmkHV1w3pfUXvgpf1/s+DS
 nm+5KqYXAUeyaZnrQda1yWRQVUPUc5VqEY2Dl7sa7J9DXtkX1K0V3DQTtuxzsMYeDjVE
 JLqHT+nv+TOO2WRpNIupJ5bAXgAVvW+6WtkQRZubCfgzErxFB+Ya89rKDSQKvuADw+Vj
 wjpEY94qQKqDr+98Th8EAgB0yLnQqzdqECEnYPiedlu8QmW5/eeWnZuMrfoeNVOllvZ9
 oE29Wz4/Z0BSiWEdaEAqsqjXbqeurVymg4iFcpiy7iG16Wnc85473xwAzP1lkKiO+jAt
 f8TQ==
X-Gm-Message-State: AOJu0Yy77ZARDR0xtInMktr39ycTrMw+3hZFFWL5FbqOwhbDNMjXOkJJ
 11hBrflH8rYezlbsxHkEWwf78Ab5kamwU7p9+4lxo0jhGgEQziPTiOJZi1cgX429m3QNq03pCGX
 vX6XXvpRflK2TsNwNV5jCAG1DbN/MBvhj2kwoBKKmT1WojE1eFLuD
X-Gm-Gg: ASbGncu8WAUIQfzQ8bANYkTKNbRDJ5cEtIZxavglkLcMHEOiCEMCIympTkUbWIK0hZZ
 y8ScuPsBwWjTiX+w6zzZaJZYVeSs+DfhMOSfon5dUgknSUDsB3WFSoNJWqxx+urM8dexc6SMto4
 YhdKeLM7IpET5zkNEYaSpMgd+oXMMuY3enSl8pvVVMXM3d
X-Google-Smtp-Source: AGHT+IE6fR37tTGir4q4mgTMEjAWumNGdYUMdc+mCiPJCjOB4+alO+5mHaRQFL4NEZPQOPgLd2W1qZ1FNJU5HoPTMQw=
X-Received: by 2002:a05:690c:3708:b0:6ef:5097:5daa with SMTP id
 00721157ae682-717b1a27f20mr91359077b3.34.1752158050219; Thu, 10 Jul 2025
 07:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250704132439.25743-1-philmd@linaro.org>
 <20250704132439.25743-3-philmd@linaro.org>
In-Reply-To: <20250704132439.25743-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 15:33:58 +0100
X-Gm-Features: Ac12FXzAHqgfW0a7o1dqNHSRITrQAnx7exQnYt6L3x5WKRSMOobv_JdEUKd469A
Message-ID: <CAFEAcA8e4jcoBup890sjNFmOkSJqCdC4JpDJT1H_OZS6n6=xhg@mail.gmail.com>
Subject: Re: [PULL v2 09/36] accel/tcg: Unregister the RCU before exiting RR
 thread
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Fri, 4 Jul 2025 at 14:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Although unreachable, still unregister the RCU before exiting
> the thread, as documented in "qemu/rcu.h":
>
>  /*
>   * Important !
>   *
>   * Each thread containing read-side critical sections must be registered
>   * with rcu_register_thread() before calling rcu_read_lock().
>   * rcu_unregister_thread() should be called before the thread exits.
>   */
>
> Unregister the RCU to be on par with what is done for other
> accelerators.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Message-Id: <20250702185332.43650-66-philmd@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-rr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 6eec5c9eee9..a578698d071 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,6 +302,8 @@ static void *rr_cpu_thread_fn(void *arg)
>          rr_deal_with_unplugged_cpus();
>      }
>
> +    rcu_unregister_thread();
> +
>      g_assert_not_reached();
>  }

This has reintroduced CID 1547782 (unreachable code).

We can't get to this point, so why are we trying to call a
function here ? This is not a place where the thread can exit.

thanks
-- PMM

