Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFFFF55139
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzE8W-0005AV-1j; Sun, 08 Mar 2026 09:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE8T-0005AJ-Mv
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:25:33 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzE8S-0006sx-9i
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 09:25:33 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79898953985so58629057b3.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 06:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772976331; cv=none;
 d=google.com; s=arc-20240605;
 b=Vemr7KoN36Y8zoJos0hAZoQL7WQlTlJtRmqTBfraDkVoxIRd1GB/drrcr+mviKhRFx
 5MxVEWWIvYxslKFfvmT4kndkxsxnwoWo7lRSRzh38ehjJVDc7GQjxzdT8yJONjjoelAo
 2RKfTBasgcMIcoErtdnBq2We8Y7TMGyG937QX/fbMmZ7nfP8xNvHDlEDjBSCnVk7V5oe
 eh/TXdixqtWTV/2a6y9+DxV8zN38tLbfcbq0s6xnZdG4KVvXgt5N9AADtfkRNU3RpxTW
 3T3YKuYj2lZkaoyCA+QGkIztwYs4ijwQUKGEEkf8s4BsxRrCrDeo+TSOm4eCbRajGLoS
 20FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W1Ud4z1xPO9EazRI8N7le1PFE/TECRyBWnyqLv19mNY=;
 fh=bOjPkmr4ek6Om+3EEoGyd2p+LFwujOt9ZQcr6jTi7HM=;
 b=K6NeQfSEvB+rfrAIh1zw7Q4Ahc0IRVLUGTyg72XnPx2glvTJkp1SVuMdkbG2PF2DKN
 wj0WTiQpY7faAN0YXtB8E8yCS/j/3xWGxHXM2i9GpQafyPFtbehO5VDjH7hkrMfPM7nQ
 4frhun4VbOPUJ+4X5o1opJzMzAIiek13S74kijR41TNafdsUbxGNcT0wrqfT4+/ODGG3
 CK6REqQZJsONZMFMTKZiYj0QSTa+G+ZymyZAWXwQRjkkQmGUkr8Kw4gXQTxywbqeHogO
 IqAFixAC31WoyPVTzKSjjjXUHI4NxNq8xQxuA+ItnWPTDJHJzImTTMeTWDsm4Yic0rdJ
 v0YA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772976331; x=1773581131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1Ud4z1xPO9EazRI8N7le1PFE/TECRyBWnyqLv19mNY=;
 b=b4fEeEj+ojal71woALgPVo633yy7x3VVpU+KvoDLfq3pXhOLjy5SCRIHUWfdUYA50e
 E1y282tNBgvHXXBrXmTdo2VOiJFfGiNNp4NOAi9sXsabO/SHvRq9OYTTixMgVH1IRDtO
 b4ZOhGH4lCSWWIAwjQ6ehCRbEOR+nAPZgTJuMnGRjxmhk+9+QH7VQ+P+e4X2geF6Nl7/
 JQXxPHtFlIx9PwzybAcukHZ3SV9/VawRdikGwMIjsWFCYdOuh002YbDUz+G66H6Nra9C
 SFkaOMPj5w4g67mA1B7kynn3kB7eqZeI4BGp4VhFHFqsTCqdxb9+mF73Cwm9CjV2tmxz
 XDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772976331; x=1773581131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1Ud4z1xPO9EazRI8N7le1PFE/TECRyBWnyqLv19mNY=;
 b=arya5zYtj0GSq4pU1SqqH4okIWrkpNex9Pdn/BK+7fFCwb/s9+lKr0H2rGhwYRLFNm
 2Z82m6CDLuF0X+XkHdq2efn9NyQ/gZCaL1xurysTOHaVOeyfpzlj6kZaA8TGD+d2kWIa
 M/EVW7FzhGadInBWeNrE+DBmh4oTRLzpNvBwlUzWw5b+X+MfdHNL3z20TrTuYLc1h7az
 US4E2kIFVfdYFnDkqiUCVzcGbVslAC/uZSdEF9TqkXcAFNN6rFnF0NstY7L9/XPJ3jvE
 29mjhMC0XVku1VNjLBr1wztYaFSneJLhQpq+lbTcCmtZ4Fv/J4vW4xQy4cgjmo1ahXuv
 ywyw==
X-Gm-Message-State: AOJu0YyGmd8dXX/C2/7eb8yqezvI4dLgPw2q2lVu5J0EshQU1I05mfYm
 2zrFROBZYQK//oIPGyBidNOfydVUWDmCGiPUW8V4Rzji98UcY//TtvTl/5i+rtSq4fHgTVvTFlS
 DDx6+/TWqLiT2/53yVJXq85GL0xUDR9LI9IyZR/lMzg==
X-Gm-Gg: ATEYQzxdPjwUGNAmZm240b/Wn/W80FoOjxL4atKPReGohpKAQs2i6lOMwn32W2b0+3b
 18JkbZdEdLdkAPYwHTdDoo5F+00MTppqrkQqHiN881c22RfsS8izGJT3kd+VUtMJJ0VNGEkOD2h
 rWN0oGAzBjXd97B/Mili3tB0GhOSUEmNtgCUFwdlJjWMLIJfAu0WSuaH3B9wPm/OE8cGDuoCwsU
 YZv4d+m13M8tt0nzUglSwbk0TkDuF8j1vXldn+Dhn9zS8hML7OSOwoUyXfSTAh676E09Ls4lh6r
 V/e8GgB5A5301vQKDfMzFTClVSNfkoihvWIxMQk/IHLI9XmUWogB572S+zjQg9zJSdQ=
X-Received: by 2002:a05:690c:6305:b0:794:dfcd:5e91 with SMTP id
 00721157ae682-798dd6b08dfmr81531517b3.6.1772976331176; Sun, 08 Mar 2026
 06:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2026 13:25:19 +0000
X-Gm-Features: AaiRm53XEOPKJI1VeSjGkIGMU1-f3eCkxHyv9aSSZ24c0zkelNA3c_auljYePq4
Message-ID: <CAFEAcA8PwXsmYGsPDyctxm7Ud78VYB_3nFazxvTXpu=HsGTnzw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ui: fix small leaks in -display dbus
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 22 Jan 2026 at 11:33, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
>
> Marc-Andr=C3=A9 Lureau (4):
>   tests: fix leaks in dbus-display-test
>   ui/dbus: fix leak regression
>   ui/dbus: fix Unix.Map proxy leak
>   ui/dbus: fix pixman cleanup
>
>  tests/qtest/dbus-display-test.c |  9 +++++++++
>  ui/dbus-listener.c              | 11 +++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)

I don't know the code well enough to review more than the
two really obvious ones, but this series fixes all the leaks I
see in the dbus-display-test test.

-- PMM

