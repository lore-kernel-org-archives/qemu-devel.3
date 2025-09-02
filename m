Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F51CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNE8-0003aq-EP; Tue, 02 Sep 2025 05:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utNE6-0003a5-GT
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:22:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utNE3-0006Mw-ED
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:22:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3db9641b725so8589f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756804969; x=1757409769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPBJaao5eU9miItbgKqnM+Hdb/dWjIBar4Rn5uGCU90=;
 b=U1cVIZBnOy6zHu11PSz/pSEAKGCQ212ek8srojz8psQXun/wSVYqoigrTyvJuBfc7I
 EP7ryvYTiLJgY6oNgtfJU6VaPYVSo8vz4Rxz6G7WfO2nihS2fkiHMXMm1NmFKGXWm+tR
 KAE/pNYNKNGH1x0Bj4EWd/RrsECjkDbDrWyGl/64SBULLXzVdawMBQs0EvSHtxJGqoGW
 ksOVlHkXweKtfnxR5vJIj4qBLEnTtPycVfCbW6d4PxtDdzliBq0o0MN2SCDR1VrrvYhP
 FPFB1OuPYhRCICpIXr1VEhC4EYQFiIeeEKltWcBU+W5RxhUtCTG4YHn89Fo5ElHx/rxI
 PRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756804969; x=1757409769;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WPBJaao5eU9miItbgKqnM+Hdb/dWjIBar4Rn5uGCU90=;
 b=NbKVx+6lpBmBPaq0m5hCIBgM0iklbPFYFeLxNIkSG/KkujgBhVD/okZq1sIDxXByV+
 ZIiyL4BpQtm/WCpuF04YlgaXQnNkMMVMDhh2so2LEMxNk56xVrpcEP0jLmZrk6/z4sIu
 wRNZYCogFEZhmeh3j4SsQV7MD8PmvGt5cB+93Ia5wqLt3+dOhSczzM8cdJopDH/Hhsj1
 69PVPha7q2YAZKqiDB3P3Orf99Nhl0JvNlSsLQAbtaaP8fJe+6GGrXtS/3RDL/il9A8J
 KK0PrJM9CEcPg3c6DUKuI17cK+2F1MH7z//71M4LH6FNT3XwJfVqMKZssPrPSJX7WtMv
 zqrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzvgK7t5RLiG2FF9tFWih/YLx5yn3SdIgZ7OI1RHwZfFDLfrDuTKwQzMBrjkblW17QGn9IIcjwQdZn@nongnu.org
X-Gm-Message-State: AOJu0YwumdoZdzKSxyMa83u36J+z1wHigAavitfilZj4PjBvaz1BhcFE
 T9X/WJl/K5KAQCixDZPDCcC9IysD4GCzuhmdn1/3CWV641bEKXJrTrBqtO8oUgpnvL0=
X-Gm-Gg: ASbGncvTpmwBihO1RBFjXoxNs5TY10L2fiBlVpyX+w2L29Zq6hrWp5WYEZHuM4LRMzo
 /kb/cmCu7dQv6FrZQZnLNXWKaQ2XwlB2+oNiYkOmXeNEqeHnBHuTfmetX5Vf7NbmIWQZWHNfT40
 8M9e+/sli1EjllePNOGAjhoUnhwGgiNlYZbgfp51eJLMx7wur5BxHqE5KmzdMEmyZl9G/TLWgeQ
 yU+Sm3E2fe/TH6rCyFBhXU13lkGLf3g0Z1n6IAUAccLfzYtyd3DoGu+e9tt0cgRJIvgdR9yO6h5
 lHTh33FZ+X8aqV9Npm2BjWfaPLxswIbLZ5JFW+Qe0Ou0GFaUe6j2qLO0g/Tfr7pxMlhvpAdi80M
 lx1rrwITUpSNf1TP1Sc0Xyj9rjQ3e2l2ykzKO4MLRdeOr
X-Google-Smtp-Source: AGHT+IGtVRj02XbDxp/oZkR6xLljpfRs0MXZUU2nscQdKfGFiRwvUDCIswEJLfdafOzKqQWoufz6fw==
X-Received: by 2002:a05:6000:1acd:b0:3cb:46fc:8eaa with SMTP id
 ffacd0b85a97d-3d1de5b087dmr8666817f8f.31.1756804969301; 
 Tue, 02 Sep 2025 02:22:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d978ab6fc7sm3469726f8f.45.2025.09.02.02.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 02:22:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A34135F894;
 Tue, 02 Sep 2025 10:22:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/boot: replace fprintf with error_report
In-Reply-To: <aLYXHdYRlLyjr7Gc@osama> (Osama Abdelkader's message of "Mon, 1
 Sep 2025 23:58:53 +0200")
References: <20250823150321.135527-1-osama.abdelkader@gmail.com>
 <CAFEAcA-GpC3ouaXTQ18VhcY7c-jXK_SF0MLiCMFW471U5Cqr9Q@mail.gmail.com>
 <874itm2joo.fsf@draig.linaro.org> <aLYXHdYRlLyjr7Gc@osama>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 02 Sep 2025 10:22:47 +0100
Message-ID: <87tt1lyzrs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Osama Abdelkader <osama.abdelkader@gmail.com> writes:

> On Mon, Sep 01, 2025 at 05:59:03PM +0100, Alex Benn=C3=A9e wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>> > On Sat, 23 Aug 2025 at 16:03, Osama Abdelkader
>> > <osama.abdelkader@gmail.com> wrote:
>> >>
>> >> Replace direct fprintf(stderr, =E2=80=A6) with QEMU's error_report() =
API,
>> >> which ensures consistent formatting and integrates with QEMU's
>> >> logging infrastructure.
>> >>
>> >> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>> >> ---
>> >>  hw/arm/boot.c | 22 +++++++++++-----------
>> >>  1 file changed, 11 insertions(+), 11 deletions(-)
>> >
>> >
>> >
>> > Applied to target-arm.next, thanks.
>>=20
>> I didn't see this had been posted but I did a more extensive clean-up
>> here:
>>=20
>>   Message-ID: <20250901125304.1047624-1-alex.bennee@linaro.org>
>>   Date: Mon,  1 Sep 2025 13:53:00 +0100
>>   Subject: [PATCH 0/4] arm_load_dtb cleanups
>>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>
>>=20
>> >
>> > -- PMM
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>
> sorry Alex, I didn't know that your patch set covers that.

No need to apologise - qemu-devel is a firehose of patches so its
inevitable two or more people might touch the same thing at the same
time.

> I just submitted a simple patch to replace fprintf in raspi4b
> Would appreciate your review.

I have left some comments.

>
> Thank you.
>
> Regards,
> Osama

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

