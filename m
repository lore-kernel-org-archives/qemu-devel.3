Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC08C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwmd-0008Lu-Fc; Tue, 11 Mar 2025 06:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trwmb-0008Lh-BH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:24:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trwmZ-0007mq-0y
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:24:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso2577225e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741688656; x=1742293456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH3rBTmaGOPTJqXm+FHYoIpz4bXlplwmQPanrZAQruE=;
 b=T6L2rPxx2rKF1/YhSszb9VyyYhDgq7iYG6NwUuM53RNyUe3CtXrxB8QotdqVknkw50
 41sagDWK8ebtICfdKqZ8xxnU7fVx4rXTxHxqYPkpjtJLlLmyV+DyQ+95Bc5UdCqK4/GB
 nKI0I8tnEvZWestqLLn5/G2F7ev7x89od7FYQ3RABZrJVyyQSwWdvI4xscNWe8A6DXgB
 aWr+K/xIYXyxSe2n1WybslOeoOhll48cH8oZRdcx7zS5Rmfl7nxHM7PcslSRsOkaOYsi
 +nkA/3Hw52JFp+hox19y7wu8u1zVRLJtQtJhlEUpSU3xMO78KW9qPSCdk/1gu0TtttOb
 FhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741688656; x=1742293456;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BH3rBTmaGOPTJqXm+FHYoIpz4bXlplwmQPanrZAQruE=;
 b=SmSXvhFrCgqFH01tuteLxcQnxCq3WSxJQBKW00VZyAPoq68PP3N1feeTHyX3NXhOuG
 7SADj8ao1QF2vm++5vBhifK4C2w854vEIh8SD0OAZCXY2XT54g24mUWpdYippjtP5AY8
 60TF/UCgYG/WUnSJ2t9m/X+61ScUXSRfZM62JqygNTTJbRaMjPlsAK7yWHnQpXw2kQrA
 jSUuqZH7cwsPXeaxjvDC8l4u9aiToet+AsBYfn1XmK4M1z4V3G9aIjN2EfXBTCEZPD0U
 8YMhPJYZ0zz5VkPl8iSamsDEP0xRRkhRa2ySiYeRThRl78g7xlKS5O9wohTABcEJQZcP
 va6g==
X-Gm-Message-State: AOJu0YxCgAqB2/LBn29ohobSiVNSp4hRo5QrlX0VflvHKUV4gXbTJ4GE
 IEnpW+9PLnIjnfOVbdu/cB3tU496AX2oq6sdiYkhh6zh50W2RXqHWIoh2Y/H3yE=
X-Gm-Gg: ASbGnct+WY6Jx4muPU0+4tzGYTqH/rDUM0IwGHYQ/X7VbsQcJNlaUoI34RQOygG1YMK
 gDfV5GkY19/9eYkI6Jgf1wzzFoctTNb3mlA7k4vFhDAFvAJfgWkBo9n2DCqs/ZATKhRQiRGDSnO
 lspGFkTNWRXUsAbXk8d5OqRt9G87EKa7Xy0igMbB/jV554easEQ98tOoFl+CXgRmS33UpWR7ifg
 GPM9vjmiks61bu30Phh2s7glRkDfISqtM5yeNj9v2TudUSBeUlJYdsUoVjROStaFyiOVtl30uaY
 /rsk47Khb2R5JSt+bE1bFDaCzC8qXBuCNK5THevN6JDQlq0=
X-Google-Smtp-Source: AGHT+IH6RuJRePuJOZnei+RtTrY9G726cP4lhQ1so00dI4+IC4/3MH3zr9Lqnj6hZ9DoYuvYyYdXrQ==
X-Received: by 2002:a5d:5849:0:b0:391:47a7:299c with SMTP id
 ffacd0b85a97d-39147a72b4bmr7880458f8f.40.1741688656490; 
 Tue, 11 Mar 2025 03:24:16 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf6c74f38sm68952495e9.20.2025.03.11.03.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:24:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1D645F762;
 Tue, 11 Mar 2025 10:24:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 01/11] system: Extract target-specific globals to
 their own compilation unit
In-Reply-To: <20250305005225.95051-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 5 Mar 2025 01:52:15
 +0100")
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-2-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 11 Mar 2025 10:24:14 +0000
Message-ID: <87cyen6f1t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We shouldn't use target specific globals for machine properties.
> These ones could be desugarized, as explained in [*]. While
> certainly doable, not trivial nor my priority for now. Just move
> them to a different file to clarify they are *globals*, like the
> generic globals residing in system/globals.c.
>
> [*] https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe-b057-9046c70044=
dc@redhat.com/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

