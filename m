Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B5EC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 21:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tigal-0007TB-9E; Thu, 13 Feb 2025 16:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tigai-0007SS-OC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:17:48 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tigag-0005Du-Sw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 16:17:48 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so2325341a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 13:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739481465; x=1740086265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KKcX0+NeQcXbUUpZy7P33zfc/8z9DUqpU/IdzsHdBo=;
 b=Rsd3+cFLyQF7u/3nZ7tSW6IUylmEl5L9vBJhqymtG7wURiqgKzcgiovv4vViO0Wr+O
 jOI+2zUpLacYPVt3J+RCNuVt9joZ6mOC7XFsGzjSt73s3u5umz0nC0DULZktZxsvHURe
 tjL3UZHb6+GwmD8EoEPeg6P2ZU7u5dD2M6jvyub/F0wOleEJzISzkA6SV5d2F9CShnAJ
 EdeOgFpxlAyhiyiX6vh2lfuyed+QqP/xL4m0CV2Hy3wV72Hgt+jsF6YlPY4dV39QqTHq
 HKz8ai2F24/175MdK8q9ytPT5oNuI18kVq7hSwo9CGZarPjYesG9a7bG/lkjG7KO6GcN
 X55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481465; x=1740086265;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KKcX0+NeQcXbUUpZy7P33zfc/8z9DUqpU/IdzsHdBo=;
 b=ssJw9UODgo2cdoFW2RG7kiI9gei++fhP7CneNXZ3jD0UOKzxwCYvbCzyVOdp36gPsw
 o0/ZNfzOzSw6mtBwGTYAIZznZM+F98Wfp1zl/aayO2aaTOEf1ShyG9u1wHNhljEtZ1KO
 tpOCdFTlm6g/dnT/DIvndeMm0woUIHWIz37IxhWhCJONyPRVDmVMYTxWKVFGd8FyOATd
 czo+QaGf3Vf6MfuOZy5VHyngwWbGMznT3StIQg3n8cMMnugtdvVZmSQBa5TI+F1pAhJt
 FPMg3qgRJn5f61pMSIqJJFyJgjiFn3J4tQ/QcAMA0DEKHWbrHardHWF3sxY+vjeksFEO
 n0SA==
X-Gm-Message-State: AOJu0YxPGZrx5nj+7KkGP3OJx1fzhaQu+Nn2vmIXSkHYcfVdaaBB+3uh
 zTP4OVXbT4G2E2uEWuUe4qAEQ3a+4tcn3in6YQzQWRzVK8VpQcyykc2pVMy2S50=
X-Gm-Gg: ASbGnctFZK41+FThTgiI/M2d7218No+9DjnhgLk7lbRnCASO4UaZjpwynJDWVN2NBPF
 qiizy5+sgIbCbxx8R5Gm/K0BugSU0Knlb2GMDyiBnpRSUmeuLRd5NZa00hQQuCIomI3vv862oJy
 GwCOPAVqykh791McKkHXCYylvWb0wBJkIhFeS0LvZYyQZznPq1doe1yxCrCBn6xnQuhBNCT+rbz
 Z6fNAtm53HXL5DguxM4eslUU/5vQ8Pmm6XMR/Wkt+m6Kki5XOZmq+PVi0EZtnaMHJwXAUJ9B/Cg
 x48t0N1UtNWhinMEkw==
X-Google-Smtp-Source: AGHT+IEZ0+1rCF3IonaItnM6YYmFyV1mf5trbua2iSo+6FVj1oVvTdpotLBFHID0ZFivpR7G9tkq/A==
X-Received: by 2002:a17:906:dc94:b0:ab7:cf4d:9b2d with SMTP id
 a640c23a62f3a-ab7f33d5730mr652016866b.30.1739481464550; 
 Thu, 13 Feb 2025 13:17:44 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532581cesm199366366b.45.2025.02.13.13.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:17:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3BA375F7DE;
 Thu, 13 Feb 2025 21:17:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org,  maz@kernel.org,  Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>,  qemu-arm@nongnu.org,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Peter Maydell
 <peter.maydell@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Jamin
 Lin <jamin_lin@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Eric Auger
 <eric.auger@redhat.com>,  Yi Liu <yi.l.liu@intel.com>,  Hao Wu
 <wuhaotsh@google.com>,  Tyrone Ting <kfting@nuvoton.com>,
 sebott@redhat.com,  Steven Lee <steven_lee@aspeedtech.com>,  Zhenzhong
 Duan <zhenzhong.duan@intel.com>,  Troy Lee <leetroy@gmail.com>,  Alistair
 Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
In-Reply-To: <20250213135032.2987289-3-kchamart@redhat.com> (Kashyap
 Chamarthy's message of "Thu, 13 Feb 2025 14:50:30 +0100")
References: <20250213135032.2987289-1-kchamart@redhat.com>
 <20250213135032.2987289-3-kchamart@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 13 Feb 2025 21:17:43 +0000
Message-ID: <87pljlpmrs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Kashyap Chamarthy <kchamart@redhat.com> writes:

> PAuth (Pointer Authentication), a security feature in software, is
> relevant for both KVM and QEMU.  Relect this fact into the docs:
>
>   - For KVM, `pauth` is a binary, "on" vs "off" option.  The host CPU
>     will choose the cryptographic algorithm.
>
>   - For TCG, however, along with `pauth`, a couple of properties can be
>     controlled -- they're are related to cryptographic algorithm choice.
>
> Thanks to Peter Maydell and Marc Zyngier for explaining more about PAuth
> on IRC (#qemu, OFTC).
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

