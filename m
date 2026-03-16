Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D00F506DA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2981-0007wc-9f; Mon, 16 Mar 2026 10:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w297z-0007wL-Aw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:41:07 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w297v-0007Ls-95
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:41:06 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9795ca4e6dso348707966b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773672061; x=1774276861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndWjCftNxBZJUr55k01r4llF+9GiE6BRB/ssV67Av+0=;
 b=nHpPoHSbPrIXqMusQfgg88TJzcregLyoQ5G0Y7rIn8Y1I+9C87c9ab2JFqPNPli/QJ
 CMJHSk+Dyn0BnGP4apXZkGtbrW2Rs9Em93pIvI2uHD1knTzGu40tyvjMSRhpT68oaJCv
 zULSHOLm/5z4jf152Gw9mBNc5SSvMi37X8p3IUJVGdpC7HlTm1O+fcLIecWNyfJDoqLL
 kb3psYMZe4QFYsMbhO1XtPEzaQgRTeQT0K14hVUBIBzhGy9desGn9K93ZtfsQc7GQGpG
 eHKQD70ZIaWtr1wWUsKmb2Pcx0gIxWOi7Ibf45+CNNwVqr20qF4PACoTKY8qL0Mn0Eq/
 SPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773672061; x=1774276861;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndWjCftNxBZJUr55k01r4llF+9GiE6BRB/ssV67Av+0=;
 b=RwxX/3WJ+Yfy29KtdB9depYtKgakEZoFvRV9DblT53QiO/UNc8IDLIhyY5RGMvJOoM
 e9oWlfSTb3IXfIbadIVYaLaqtNWkyQlJJ0ZfyUpKFBUpgBd7w1w8/P2QyzIhrJKL8OFf
 ZnbNMEgKBOkZ7CzZgsJHsU0QCFspD32ea4c5ysP1/UcmdLFeSnsA95ojvtg2/ckENywP
 d8sgzg1ogFi9s9D1/6B5hZqchR1o9ZHIENU2Z+av8uLFBy3ly9e3igLU9b7ijSbghBt0
 cAPNTd641G+xbbcHJT3uE1qb5sx6newyOABOVApettx3e6w7lKmsSmiPavFaH3f5NOIp
 z+PA==
X-Gm-Message-State: AOJu0Yxbn2phe+3RANMRLsodhyhL+QRj5PwUEar0DIcrZNu/AYM6OntD
 crMGiQXTxh5Ul5WMeyhHv1xMWQNszlIviZhw4L2PMT9pa/xeb9+x8iW2o+YNvJJE1qI=
X-Gm-Gg: ATEYQzxgnf3DbtzpQU+Rp6TqusX78hl8Zf/FjyXSKvytjdr2xN3SE9OtLUn1W+4PQSz
 nfZSYWYhalfHm75laLKlCZGyni28QUHED3iA+InAjHPuwGfRIWbPh8G9GDUl2xJG+FU0uAOw8w5
 LXv1hj0ZzsVjDGoybux0eZ3+ZEcHDPEULoCkmIpU8tvu5MriJX4QJgRzWbox1xrFTpr03t8DxkL
 GSAxkJaNi4B8MQI6cV5DkSlgiAwmRenltwA7xchdK7hNWew57qDjU3S3Dvg4ZEqKsDgcWFoBwUm
 LpDIvwDBPohk2YolyxYx1YMNKc8MCjrLYv1j9OUgKFXeNEPg1ZGDQgNGF/ok9nAnEd2VyxAw6PO
 OwXSjaCZ8gCW6+QT4pdi1PQ4AY9E8xL+rBzZoBTjfGxtNH4fVJSn2N3mNVhbFDAAxodwfZFOYdI
 dEOapSJi6PH6NZ7FTyPI96ZRz9UKm57gBXiA==
X-Received: by 2002:a17:907:6e86:b0:b97:cebd:8273 with SMTP id
 a640c23a62f3a-b97cebd8c4bmr110587366b.24.1773672061016; 
 Mon, 16 Mar 2026 07:41:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97ae89ebc4sm276169066b.34.2026.03.16.07.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:41:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8643B5FA31;
 Mon, 16 Mar 2026 14:40:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/3] tests/lcitool: Remove python3-sqlite3 from the list
 of needed packages
In-Reply-To: <20260316135407.209072-2-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 16 Mar 2026 14:54:05 +0100")
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-2-thuth@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 16 Mar 2026 14:40:59 +0000
Message-ID: <87cy13on0k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> According to commit 7485508341f4 ("tests/docker: Add sqlite3 module to
> openSUSE Leap container") that introduced this line, the sqlite3 package
> was only required for Avocado. We don't use Avocado in QEMU anymore since
> a while, so we can drop this package now from our list again.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

