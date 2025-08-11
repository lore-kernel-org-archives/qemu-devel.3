Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F45CC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 14:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulTpy-0000mA-TS; Mon, 11 Aug 2025 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulTpw-0000ld-OE
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:49:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulTpu-0002K4-JD
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:49:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459ddb41539so14487305e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754923754; x=1755528554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlnwM1s2LkmZdHuBiI3g4Df8D/rN/BVg3y9iRwVJsP8=;
 b=Yn4Ha9OcACAY5ToX2Fx6bGiFZQSSM4myz6E8EwGm8gwb4tiryx98k75qMUbs7VntSB
 qJYAQlj51GlEFcOj6Vfmm6RfwjEzDNGUV1Uvtxl5FiaokIflz2eiNzp6cNk26ofdvZzg
 4I5Cp6p7uJqClWju1NJGkdxc4wKJOaMcr7gVbFTOCoPE6zVtuXy+kWNcqFIucCB5E9yh
 NVqPkSgg1qvYybeUAd8YOpWukkqClBs+y/2/ZZNhQmsVSqq/4dCFiIaTFOt8vgbQjsp/
 nyojSw08eevMPLCqOEv8Z61XIHiRyrRn2+J4Iigv2XpWJmNYxC4dqFQzwgZZIb52tT9l
 nIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754923754; x=1755528554;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlnwM1s2LkmZdHuBiI3g4Df8D/rN/BVg3y9iRwVJsP8=;
 b=Xb/LHY2y1e67IkHwI55+IKtt4coT8fPf5UPlvZjJbtfP8KK3d81Y6VSWcd3GDvRCrO
 3NZXpJ4dwUwBDvSZz6YSuAoLA9UUGS3lluy9fDfw5NdjckfvOzbZtIWNr5YH/IVSvt7K
 OA+nmyu63qJTcysCc5DkBCsx0u5iOHcwuZwb15P/zFy20IdpOnuVqKv0JsMFcJzIMskZ
 UkgWrAp83L4TNu32sKLgt+631gshJGDIwLCnLYN7kAZnovTCNziw+lOyFXMGTIW7Xuob
 7vEAEA8cd/eLaUDfEFALJZ7WtB3g1khamp4a8g0ii5lw9gFR1edhcDQ5w3vsq3Mu0DSU
 ESNA==
X-Gm-Message-State: AOJu0YxmFZ8V57rH47jiLS9iXFnNmItdIryskbVQTt2QWv2o/x0+B8rL
 gBj4VDOyYR6PE2uPUfSN/4a/9wHOKrplHb3mHgNpJgwXxrPPbg7z6cjP55oirS9P+vA=
X-Gm-Gg: ASbGncuY6gqgkbEEW0RSyK1KLTrKiLejoUR2OF0sZi7d87SNIv6ZovVifopQgx1SqOl
 KRvATRr6cCTTj1ddLQUb4W61ZhSc+FidM5AQBTozVxK9+tm0tv82bBfzALLFuqEO1o4XSFxcq/c
 VPPqvwbvSDg2iM3W6e2FObSDS5xpqb/nQbNPv2FK0fv53KVKigXE3nEsEbYrCmLbmgGVmwBwwf8
 FJP7MGlmZ5Fn5aB1Da8QURnOZeP95GOPy1YlCl1SReUT5yKyheANBFvyn5QcQN1pV5RcOgHMch+
 QTHfptqbP2I2P+BTbU9wc4KR3CyMxHzjmA2QzF+fsn13mF79duX7Q4GXSqsI3kN1ZxmKg8AH7JP
 VWDTjyWYuwdTiffRY2/FeJeo=
X-Google-Smtp-Source: AGHT+IEgCrDPw6rvywmS8o19SYjMMTNe8gUAjuMIiimXLsyGYkaWcvlHchBvOzq5ft/eCER/2KDOEg==
X-Received: by 2002:a05:600c:c1d7:20b0:459:e440:61c7 with SMTP id
 5b1f17b1804b1-459f4f3b4b1mr83385375e9.31.1754923754466; 
 Mon, 11 Aug 2025 07:49:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0cd2c90sm306189205e9.17.2025.08.11.07.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 07:49:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9AF75F834;
 Mon, 11 Aug 2025 15:49:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  imammedo@redhat.com,
 richard.henderson@linaro.org,  peterx@redhat.com
Subject: Re: [PATCH 3/8] accel: use atomic accesses for exit_request
In-Reply-To: <20250808185905.62776-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 8 Aug 2025 20:59:00 +0200")
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-4-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 11 Aug 2025 15:49:12 +0100
Message-ID: <87zfc5c3rr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> CPU threads write exit_request as a "note to self" that they need to
> go out to a slow path.  This write happens out of the BQL and can be
> a data race with another threads' cpu_exit(); use atomic accesses
> consistently.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
>  accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
>  hw/ppc/spapr_hcall.c              | 6 +++---
>  target/i386/kvm/kvm.c             | 2 +-
>  target/i386/nvmm/nvmm-accel-ops.c | 2 +-
>  target/i386/nvmm/nvmm-all.c       | 2 +-
>  target/i386/whpx/whpx-all.c       | 6 +++---
>  7 files changed, 12 insertions(+), 12 deletions(-)

Could you please update include/hw/core/cpu.h with a doc patch to
describe exit_request and note it should be read/written with qatomic
primitives please.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

