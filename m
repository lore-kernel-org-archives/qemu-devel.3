Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B9EC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 16:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP2WV-0006FY-9f; Wed, 03 Jul 2024 12:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sP2WU-0006Dr-E2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:07:58 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sP2WP-0007da-MD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 12:07:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6fe61793e2so321955866b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720022871; x=1720627671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vcRnX/AnDTWVCZ8vXHrMQa21/kSwFEhtPim7jSN169E=;
 b=Kk4YhuhXdqfcV4C9ybXzab7E5r1D9MBaudnAlPR/LYGquOFNgUnXF1cPivDFcwEcB4
 Jr05wJxqYnDCNrREet+Jfr/rcqF2oeQtAYfb4mvZayzRau41b71bbvqIz8ssQcIpYJjL
 oO5IFNki7BA4rlhUjguX9fz2SekvU1wPIFJwDEAXufBX7KTRDw2eFPsF03BW7nN8CSBP
 OWvi4JnMlrESbKKiBYqBW5fmTBp2Vi8ZoxP9Ga8e4iQDjIRB6qKib6qWjn1RsWb1q39A
 WZrvns1orNiTMlizQm9wI40y+nSfsgcDEVHq79WsTPnT7tzZqwE+N3KgMn0r83ZzO+Zi
 cwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720022871; x=1720627671;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcRnX/AnDTWVCZ8vXHrMQa21/kSwFEhtPim7jSN169E=;
 b=VmIlAX2NIK3USEHv90xmgGhJ5/f98V9dow7JCRXYwOldr7w6PLpaUYK3F+h8qKqJ6u
 T4z1xLBl53FPajfVAUPRE4Z+CAM9iaTKAB/UXaU8RuWO8+wvNW2d/TjOeUDnpqysDBvX
 /yx0PgNGetPbAQKkxM+42/CCkQWML47yI/TjVPLiwHA+cCcDW5u3EHqsBofO5olxPcP6
 LdrG6ft9xJvvzLEjIGhyLMjH0H+Xet+C1whdohn4L7tg65eE9FQSfQy7YwG358ANP1uj
 NtvC2DLZeR6wDadjfbd9wFB91gkrVZsn5d2WX7X8LCdAr6ZlZ0htB8aGTF4KLKCxtp2x
 uReA==
X-Gm-Message-State: AOJu0YxXKi3bBcN8Rv3DAusT/PmOffXlv7m+89+NEPJJ6YHXn+g2sFrT
 /xx5hqjcWD68O4lKcnPJzemQSDCzRuiXAEZCh/LSEYHONSLdyUK6WRzMk0UJsIGfqyIPrvYmTCI
 X
X-Google-Smtp-Source: AGHT+IHiG2zLgPg4Kie1we4rQN5LfptgNAhzYStmS5AZr28dPlHcZz/TUDe8xKph/i5pp8YEEAELPw==
X-Received: by 2002:a05:6402:2712:b0:58b:baaf:f4a2 with SMTP id
 4fb4d7f45d1cf-58bbaaff632mr3317081a12.40.1720022870428; 
 Wed, 03 Jul 2024 09:07:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab06531fsm519810266b.100.2024.07.03.09.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 09:07:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 657CC5F8CA;
 Wed,  3 Jul 2024 17:07:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Krasheninnikov <krashmisha@gmail.com>
Cc: qemu-devel@nongnu.org,  Matwey Kornilov <matwey.kornilov@gmail.com>,
 qemu-block@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
In-Reply-To: <20240703145956.16193-1-krashmisha@gmail.com> (Mikhail
 Krasheninnikov's message of "Wed, 3 Jul 2024 14:59:56 +0000")
References: <20240703145956.16193-1-krashmisha@gmail.com>
Date: Wed, 03 Jul 2024 17:07:48 +0100
Message-ID: <87le2ipigb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Mikhail Krasheninnikov <krashmisha@gmail.com> writes:

> From: Mi <krashmisha@gmail.com>
>
> Add a Virtio backend for SD/MMC devices. Confirmed interoperability with
> Linux.
>
> Linux patch link:
> https://lore.kernel.org/linux-mmc/20240701120642.30001-1-krashmisha@gmail=
.com/

Is there a corresponding patch to the VirtIO specification?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

