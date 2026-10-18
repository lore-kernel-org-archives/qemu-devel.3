Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BBCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIODM-0004VK-3G; Sun, 18 Oct 2026 06:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOCL-0004NH-Nq
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:33:15 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOCK-0000pk-79
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:33:01 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c9995ca60so2030624d50.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792319579; cv=none;
 d=google.com; s=arc-20260327;
 b=amSojOnC3a6S/2KUBCrSgC/pVfmaDiaM6tBx/1QKK2lAi/px9OqgjtxfSTDaE4neIR
 D+VRyQ2qjc0sCf4oGMZvL2ze6/LRD1WM0KjcI3KDbHtKEOCwIN5zqiws9+sJgfH2bcc0
 KL9ebZ5CLNa6s/jqgdL2NUswCwf02A7AQlUJqOFWCIbEADDxWhQOuINi3wyjRE92ZUZU
 rRV2zAIFDspIlXWlmsnEzKSiLb24rJx7LT025cTFF3v6/cX9ZU9qFQMf8v4BtDgP7w+v
 P0VaWljDpu1NUUKZCnC6ZFhwockD32cm2fhiQtsSzr1tLHlG3o5DOz2/nJpbqBmd3dJq
 Jq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4aR9aHeEv98qhJni0KQ0kmpovdS8XBDkabORswPEmxQ=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=hMlrq1DCZN3A2kReO/2TcAG6TwdmvloAZZPkxUs7IjWXGtpSXKK/tqgoQsQNXsbu4n
 tNKhBctMvmsaGjPSO7g4n/h4n/u9uOYeA63m2iwYRYfhLOHMg5ZiuhWxkp2i3oOqhjM/
 SI8kfHrmz/GJwBb2b/prWVYLApRdxqfbPuXDw+uLc1YAAMRIvp9u8uRvRb7YtWNQiDWn
 0+ponstATi43/JGTJsNKWuGmyPvYQZJeVYsfl3W1ACOXaT6pmdaKcZKixtO0+2z+9Qs9
 i06OTS0ZMRto3aJtkM1hJbj86CBXAX7egOXtY8lXaHuZh2//0eBZXXFXa+oUewtokUZV
 ESqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792319579; x=1792924379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4aR9aHeEv98qhJni0KQ0kmpovdS8XBDkabORswPEmxQ=;
 b=cVH42vxSP22bMteRRuHJOC7lET4FayhBmL9P48ZXlXJxLeO9mw7f+SdR1vPxPCn2Ld
 V29thbKF7PO/qveHmtSpPInHDaHxzv9OYklUeXCp1SqNMgdz+5vEePY91OJRrMxiSlP7
 38dSAgF1lUQmE5xm5+EhNYdxNyJHz2xpPXNZMssVXutwuDdbPMYitiH5wP8dlbU2e29K
 hn3ZnnMjZLM/irKRkmGAEFvndWeHw8T5gR9wLT3zzpRm116Vkjpp+uA4xvln4EpZzOm3
 XD1a1fA6ma3+7dx7b5XVobUxHiS3HQNLZdj5Q/V9MmiQxI/G7r1xzBiCu8tgNP7hLbaJ
 zuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792319579; x=1792924379;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4aR9aHeEv98qhJni0KQ0kmpovdS8XBDkabORswPEmxQ=;
 b=JqEQjfZa4mw/FFF5n7FD6rNpYfD3eVVxCBKz3o7h2On1+ujxwGfIsgplGZSvjkO8BJ
 7XRg1ZBhVdlwlHLozNTtJOUmdlxq8ZxDrva24T6owTAwirAtIlHG7XZ+eubjsBz14y4A
 94s9YdgnIcizQNayJEZeT7bqj41+Z1Vth+9Vcxfs7jNX3WbRhIZrn1m6cNhLpOOqECVc
 zVAWV27NDiQ7Yl7JOZhCUE9LVcpVifuyZLAKIYrU3N6SDGC6TkG8Q6vmm3gFdQdrkq2M
 l260yfmCZ2Qm8H+zSadzcwu7iCFbKSIUcXqaJGm8EMVdrjLP8KNelho29Xljvxae34Jd
 cG0g==
X-Gm-Message-State: AFq9FYLfuty0yURTU7XHQlUB9tyfFskiwSK/IJZK8gxNA2o+KWHxjZQx
 aR/GeZGLD4YFPJ+2wwDz39SsDjqGysjSxopIsdJf8CLzggeI5G4bU4+ab3ImPHHRHhilh7le9IQ
 9ZgXjDQqWg0cb9r3EusteIjeal+xF1kmtcOoavpspyA==
X-Gm-Gg: AYBFou3OEbQaICUSENXJ+d8+I21Mg9mAaCdahdBjC24NUO2OnPmYkhtDLw6CeQqa26K
 mBZNnOTDpjF0DD3/2itHT651bsLu544uhDHpMA3BX9RoGwF/tSPkNIs67Sn9HLFPXBR43J8sTae
 mRIvWR1cqlrRK9doZC+7yNGyAkQuLGPJuYaJ1TpP92+ahSulnVNPbwUz9KJJaIConzF0W28Ofno
 7OQarEsJot6sYLFHL7kMud3Wc6PDGZToMKgJUn9NpGYWAMfYGvuLJQAifX72N6+KKxmL3pf0I9/
 VKbRtGKhAsBEKAcRITGqivlZKwPE7fq/P75ioK30pxjFRgWINH3SQXGYHbqydU9g1B/sWGKC0mu
 /BZwKuuuaAHZV+XHhDc8fV3GknI/JBBAA+SlVRlGhfiQDEuq1NA==
X-Received: by 2002:a05:690c:e3cc:b0:8ae:98ce:5497 with SMTP id
 00721157ae682-8b0e2a9ae76mr26007097b3.0.1792319578927; Sun, 18 Oct 2026
 03:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-4-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-4-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:32:47 +0100
X-Gm-Features: AclHuK__v9N8USXjL6-UaRhKfCYshkZRXswPfg446W8rOZBE63M8TcAUQfokMuk
Message-ID: <CAFEAcA-kYNZwk1nX0Nqb8o+8nfQcusEaVTwgnrG2+TS39ipXGw@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] hw/misc/zynq_slcr: Add CPU clock outputs and ratios
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add CPU clock outputs and derive the related domains from the base CPU
> clock ratio. This makes the CPU clock domains visible and keeps their
> ratios consistent with the hardware clock tree.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

