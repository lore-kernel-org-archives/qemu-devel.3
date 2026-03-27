Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B576610ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w680n-0004vD-Ul; Fri, 27 Mar 2026 10:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w680a-0004qo-Ly
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:17:56 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w680Z-0007Fb-6Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:17:56 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-793fdbb8d3aso25058107b3.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621073; cv=none;
 d=google.com; s=arc-20240605;
 b=Jxe4nuidHsvlG52k1qyD16cNxjctPni9Qp2nI+KxXb6BMgmUgza4n4jgAHR4N+M1sj
 oPjj5y8Zgo9aYasSV0bS1HbmRGKaDbhyEZi8gJ4yFv4ZXh56MtclSxGruU1bENTnB4wj
 TgurMwe3ibOVSUxxou0rjb6TSocKEigbO5Pl8Qvhxc2LkbxvW90dUWF5Im9CKGdvRZqD
 JfbrbqxeLUjQd5Ug2VR9EWAlWHbXNaTHs5mUR9r1WJWTHatEKDxh/bzDGjr26LXlooVY
 v37dHEvVZ9rRyJKmdqqDmRYCFSMlhEC9c8AGKyIO+JcBE8TGtSdgY9LzNSLFHVy61CNV
 wMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
 fh=m1ZWdclChptFr2DexMX0dR28G3xVEZvflUfj43c3GzI=;
 b=KZPwTjx6UioBmhbEnjue/yGseEahPrx/8xC7yZ6od89ubhrCS7kTHXThY57aCHzBye
 dky/KaB3Wgd94AVPFnOz6cfCw1XGcGsioAtmFz0zVq/VGdlKj4Zz6L08MVV5YaZ2FZOa
 Bvez8oRpkCnwphj4b1E8G/KImfykr1EtQIkxxNIDVJFCrUCzAphbMXEbjm3Z6+IPxU4A
 qp6Ffqvuf+38yOZOQcE9h04MAGYB5v8Na61YRYDGeP9TXmsBpmrmH6dl3ywXV1fHfnxZ
 onsQ7S24noonbkQIQ3V2cMLLwyWoLdD9NR58iZjA4Z0AUGKLTpc3HBhJBZGGhfaAzY9o
 vIqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621073; x=1775225873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
 b=KIfIPPZmGWC6Y+1T2g8l75A7FP+hThruqNjJzAlr0dbg3rRT5NyVhTQ0uKVuzJKbXX
 bg7ZHTdRJIx7nv5+IM+V3/HEQuIXyqxD72tNUfIk58cZMCI2tEGfWe/uw/Lh0wn4YtM5
 Gs0u58CF6rImNGsx1jjqS3fmh9Ji0eYgsL8mfwGnkDDzwNYkcZ6OLms68db8oWOb0ZjX
 wTJc0Ck8mc5AaM+qTL1V2TVWSeIG7NSJ/z/rJwFC+u5V76LmeA9vcGY9suk9sbNMAhxr
 xtMvXJoqyy/ID+aBgImXAZ0tCYlw08ZjPeJoFDLMGiX77hJZGRuA2+n6OUqeankPide5
 X8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621073; x=1775225873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
 b=NIRNWtXMXNszssbsQE2ZktHokRB0wVMtmL5277jfnZcBXYETLOMGtcasQHnbDz+IPK
 SKVAELrPzmS6fSBIbTcGYCEpQUAsUzwXjMXAko729tl0tyb3S3Q1lmwLVKJXoqfRwg1F
 4P5kD+aDZuL0FmrK40pwM4CzF827VKQH3XlrAgzpXkW7YH+OiIS8/G7QMLlKLaNuirRN
 DRPW9hzdNJ6li66q7286VQt/4lLpOMBSanYTh2CLDcOpZb59NElodx99NZ83P7J0GJcb
 4bE8PP/wqNHvgG8olKV3RFlT+CK73MyJD4PtPdXaq0Hrw1506E7DulyGhzuA2lTEHFk/
 qjjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK23zw9CIC175p5bPpZkW97i+k5L67vFChAUPq+6BPyV4FjQfDL6DvZl8gD+2N5XPv4jHzYNn6Fq/b@nongnu.org
X-Gm-Message-State: AOJu0YzKdXbNajEtkLcQWtzVFFgA2g7fAX+5rYFcL90vi8Lub9mAeY3F
 n9F4xejrtLbjx/paB5UJS/LU+rALRLONvlol98gkoslAiO03Iz1N7v6dszj8WapGOvjLyKtmIOt
 PtgOQkaN22rlRzmpwYurST/1G3a5UkocnbM++uHeg8A==
X-Gm-Gg: ATEYQzzQFPX59qPwIs8lcEnFoRYDeUN1sMJYcdbgnAjrzeGLeTcvMm208L5MO8dNVqX
 51kPMOGjdM1QJZORJcv6nNVGwJ/WM8IN4d4RXoiJgk2Ml6ILIscX7VuQCvn+nFjtKOnRl4NESf/
 jveSdjg/yJHuL0KvmnoKiGecpOAq0CHTYZL++fALTGhWU79KYu4nstnIC3MEKRWT5HQrojAttKH
 +fotw3HXB+Rkc6A9Ipd5ZQr91IXCZHYQv0zbzeFBBnPFO3vhwIQyvp51CKrxnDn3NJ4/kDfR74j
 DW1C5K/ueFn2Szd9obW2ewiCVPe7ARTK8Uj1RJBqRnp+omJVFsIb7wn5Z7dX2qh+Vp0=
X-Received: by 2002:a05:690e:1c1c:b0:64e:f712:4301 with SMTP id
 956f58d0204a3-64ff71d888amr2694629d50.18.1774621072659; Fri, 27 Mar 2026
 07:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-10-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-10-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:17:40 +0000
X-Gm-Features: AQROBzA1x2iZV0aRuSLuZIZdL_8QMnXQgU2W8vy-AEPo-qqdgbcI30apQvxGOXQ
Message-ID: <CAFEAcA8b_18LNshyvOR1cfvHDVVBbA_=5SjOUJ+kxu=Jq2X7fQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] target/xtensa: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  target/xtensa/xtensa-isa.c | 4 ++--

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

