Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BD1C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNB27-0006AT-TR; Thu, 05 Jun 2025 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNB26-0006AH-2J
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:53:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNB23-0003Mt-Fx
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:53:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so1544259a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749131601; x=1749736401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUybuZgNLUQpxqeXyEfWBDVbcdI9XieMqS5p/YfoGqM=;
 b=iRj4xn9sbhxoVQgMvCmJhHE2ERPPaBsAC5+NiTiNwZ0htC01xETYWw7jxxR9I4xh7I
 59LXFuLrRX0pHdgDnzssjzc5x1+71ko90I8FHORMP5iWD0Aoh3oxVTnE2IkuFDGtZlEP
 shmkKgn0AMKTychJyceUke8x1aPQNQyeNxfvRZ6nkU2KPR5qe1WhJ+bvpuJJSTBZEtMf
 N3sAb/P/9P9bpV4V/1zyQIUEllQqX564NxhiVGtHT8ZkCxM0J2b0Fdrk7/C4pOqLttpw
 iwHnZiGmPMeZ3a6F4Uij+w7F7WAG++IDhwWA+1OpcBUyKXM0hYj81eJnj6j8TJ+UPY4z
 ji5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749131601; x=1749736401;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUybuZgNLUQpxqeXyEfWBDVbcdI9XieMqS5p/YfoGqM=;
 b=AfGMIgpUUBBvxhzwtDhI1f3WdQ5TqackA69Ywyu4L21n1ccXyYkd3W88qSJLvXq86l
 lcfJMcvjoguDoI5NUsTNp6+DpC8zwnXTlrsZdGJQA8cyMfcAPds4YrbvFrJ2hSDlwWLk
 095Z1iHbNgkaNVxQnGr0knhylCtSf5rNtwQtevW0x/5XGcvY0aJRKF9ySlf5zDop91Rx
 pm1W7qBf8UQjHSXU83VRocAwCkByS+73Xp1in4B+36jQ+gT1N0brZmPmCtpkXx/Egdj2
 dV53ZphZVlE8bUl6RT34rVtb8fTEzhUwinexn0qdVLauwmf2hpSkth1dIx9YJu7xXyvY
 MQ8w==
X-Gm-Message-State: AOJu0Yz6T2m1Ce5w+14RUZMsmV+wFBRVNIbnAIRpgGy3t7HPuCcRjCtn
 RbH+yDCUBcxCYvtvEwygLKBTxZyz49pU/pKu6H+5RsGKMSGQb3PehZHb+DAlQz74j4g=
X-Gm-Gg: ASbGnctPlpPLcvrXFqxlzDOEzYU2XXGWI8eGS8hIa+SIu3wA7zNMb8QQWRbUfbtFtuj
 CPwZTfMREdsy5Bplb63uwNKwSN9gQLv3Bgzv5RgP8crcYd+csAIuy8TcWUHAUa6RGcajER8JHnB
 R4X9E29kPeuERdvnXsgv6tv55Foh6twEkq+8vxFM0JpQwZFKsUDQS7qz5wIRJyOA3KaXvmefrjK
 m8YGOMJe7//BersSn8egCwevQuyTxtX++HkF8RaV6iTnEpvQ/eyq+vOOkn4Eje/5uJH8fgP69Sx
 eCMKbqWt/lY7TmcJTdMm7+KmQCeP7SXK0/Mrcz9fYZ+mK3hXfwxu
X-Google-Smtp-Source: AGHT+IFtH4IPr5n1H67Yy44U7FRZRXFjW4uz0O7Yh1HuncOROKyMT2iyBlHC32YeRx9C5AW9Zu+tsw==
X-Received: by 2002:a05:6402:50c9:b0:601:a681:4d5c with SMTP id
 4fb4d7f45d1cf-606ea15f66fmr6838493a12.32.1749131601082; 
 Thu, 05 Jun 2025 06:53:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60567144345sm10220812a12.56.2025.06.05.06.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 06:53:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E6BE5F782;
 Thu, 05 Jun 2025 14:53:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <20250605105219.261925-2-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 5 Jun 2025 12:52:17 +0200")
References: <20250605105219.261925-1-armbru@redhat.com>
 <20250605105219.261925-2-armbru@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 14:53:19 +0100
Message-ID: <874iwu70s0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have a lot of content beyond the part about
> sign-off an thus are misleading/distracting to QEMU contributors.
>
> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

