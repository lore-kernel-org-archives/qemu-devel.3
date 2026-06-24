Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E2FCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcObn-0003xZ-CF; Wed, 24 Jun 2026 10:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcObk-0003uq-Mo
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:29:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcObi-0000u6-Ti
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:29:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so11317365e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782311377; x=1782916177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYjKHZjnLYJLZo+BdGtkMQncJD1vlAApZLDAgIhFQJU=;
 b=voYLlkiR0d7IVZIt1TGyfjyFyp5UdMdyiNZbJHvYQD9qra+kWC3jvpvV6GHoMVT7TX
 DXlKjn4UfIRxqIbFIRAAmLM050ICW4VGo5fMFVYqdrKYOzjKKvhWsKW+qWJxM6QOOvTv
 FSnVhGx6n3P5lc2XjnS/o1X2/dtFzWDmCWkBH/F1hszbgXX17US0g+bBDKyFYDuQ9D6B
 XfXA0oq31SKkUCQgfvdiURw7koPOmGGMCkjApaQ9gCgI8wm8cdsfPb072N9XQktZ9vEK
 IphLE9khHk2gUCD67R7vXCpS0Gh+ZHaHLLVPEayR25EgJomwRfaj1saIktnb3SKrHtS9
 rAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311377; x=1782916177;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYjKHZjnLYJLZo+BdGtkMQncJD1vlAApZLDAgIhFQJU=;
 b=NVuMzQIleRGsOa8yDkoyyk5PnrTfpsPYU00I58HVaenMnsG2u1UjuygJttejI4cOpl
 3ne/8HvZsBFZiB5XlXeJ5C//K0dlhJ+R12hIqv0RyKHQxkGgjA/mw98O8p4LIJtHRjgI
 tGfFMRh/enH0tWuJjyQFAfbuwXYJv2erhStMOjRXkU93/pDCSzd3cqhqWubrrabdSwjB
 nc97UMZ/fbmDTQoqbF/pq2RmF7a6Lf9P78UJOugmkBOJWYwupCLzWZ9oP4bHUNezdIQI
 NaOejZD2RYD4MO1Qixz6JOnQv3CvgW0KwG4eiqem1VpEBW+5jWRHJxdoWQPJYNA2DES9
 +7MQ==
X-Gm-Message-State: AOJu0YziSTOiuOO3L4F2dJv6yx/4lQD8HxHTDP36ZAdSXzA+rIsvx463
 VdKlJ1sAetFlN82vxUuxO3HTx1aaOpfQPqHEH4zuY4c0Q0S4M3+56Ugh60/qE23/btA=
X-Gm-Gg: AfdE7cn1GmgZWl0idm32IHAw90Ctuig4Rh/RSa1FK33gWIPqQFq3YVR7uQXBiypqFyi
 1lV4gkIP/bcOFTf8MLoSf7MC6xPSQdXXWF8xX/HJiGB414AIqWfj+zNapa+uE1cW+MCZEKZVNxM
 CqpPbil2Dl24q8IsGVxab6+lasSz8srcmtDw4/cKNKfRHpqP8z8OUYez3FE1WjPuHuQopUO0oAf
 RDEpIJrqXSny1VY31HD+i3SpE6M6qBXiZoY8zXhEG7jCxY5I+E7qNdfiV2Le46GvvBv0EAbimN1
 9ZENUXUuUM3jaQ+ZOQRpJdy/VLMisuemoOqOuQsNoIKLnZRHkyKYxTk413MwdHYPG+TTLwrDIVL
 DYwJsFFdqYgfUVpUQzzZtsFHoyaFDctcmRiIdgHEAHGroYnuXtPfdjFclDcF0jzHuIkmPapvO46
 zz9K1u0KNjTsipVFfa7wCYgiQ=
X-Received: by 2002:a05:600c:3e05:b0:492:3fb5:3a17 with SMTP id
 5b1f17b1804b1-4926329a882mr9598505e9.2.1782311376918; 
 Wed, 24 Jun 2026 07:29:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm491971525e9.14.2026.06.24.07.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:29:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D05B5F80B;
 Wed, 24 Jun 2026 15:29:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 03/27] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
In-Reply-To: <20260609214745.772536-4-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:21 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 15:29:35 +0100
Message-ID: <871pdwko4w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We'll reuse this name later in the series, so change existing script.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

