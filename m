Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC3C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZ3v-0001yV-Io; Fri, 07 Mar 2025 09:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZ3r-0001yG-7V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:52:27 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqZ3p-00089U-5q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:52:26 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5b56fc863so2706111a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741359143; x=1741963943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ws+wq/2UEr/6t9Jg3xA8GMiXPDqWXp7+OVOIoqXOryE=;
 b=cUg6KgBM1+PJ4MTpKdn2NTnmx9J1CGZL6dbmRwomPFGZi+I3EaLF9LR2QSpgNo2+L3
 zg9xo4WXeDwViO6U3W3t1x4LyYjx0kRUUlmNQmjrYQH60O6qcormt3SeBT4sEgH1trS8
 lSrrpgpa/MyQDJhIZF4cMCl+83f6cil7ioRU4sdNzAVMddsaquqkY8T/4o7Qg6uONVZr
 Vxgrtweoac8mhGnKXniyOeotwe+J/mL2+cYi4tBPY91/EJmQETPL8R0heb4hpCjJjpyX
 L/103aQZwTBEktFnPrg83/FjvhpYAgntmNngnSc4L7mW4dNUc6tSpgGWAp8LJdUZl2ox
 XKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741359143; x=1741963943;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ws+wq/2UEr/6t9Jg3xA8GMiXPDqWXp7+OVOIoqXOryE=;
 b=KKaTbBwr4iu6w0qmYiPUV3PHtzuD6rE99TkM7Q75roxR1gQoVce1UGPhfzfICa3Nmk
 Mr6rNbesA8w8hII0hGO7lqWIkynQJzTD43ItIeIWIf4aaUQbVkRyM06L6UbqNfECJjul
 qEe8lbf6VkNwvCxPE73XDx4fjMd1A9fdJrT2UvO3uvT0NqB5+MMro/mAjkggl+W8ry7j
 c5+Y9AGIqCogijFv34fGLTEGeSVNaHV8M7hDgOK0fdo9t+6q5TjpV78+47/gy+xtNg3w
 bzj1XlRjz5rW9khujx6OErPDU1kE+PMIxIzZuZckjMmHbW9Va++ypjzXS5xQ10ASs5ct
 pZ1Q==
X-Gm-Message-State: AOJu0Yz8he7Br9Bg2D2nudrt7Ho8BC8CSGi7uV3QcvQEjpm3WtxZ3NU5
 s4fC/z8psqB4ppp3m3XDSXF6ZuE3VXgsTYrt2nKGkPmdWUmUuojXZHkJyr/RNEw=
X-Gm-Gg: ASbGnctD6dxhPSTUgDnCqTMs16+EhyCMTH7s1RXqE+cV4vH8dMZMZeH6AmaSSlGwl+M
 FzkOHhfHZI4d/jbdXi8LC6iWA5boORyG1xblrdOKGuBfUdTaRR0fh4g/pk0CNCNeLFwkDydHhuK
 hNu5RTDLCN4qBlVyhji7l5HJY/Y0dqKbURKBLmFGbDWnBgzcvXhN9qrt4jP/+77z9ZgI7LvrjIY
 x7Gg9eESoaCD0YfOXcfD1IlOutMnAVLeFGrKR+dt+h/HUNbEULZY8Q+VD6qVF/Wxhs/IHdgfyjw
 d77KX5vDmgfg1dwnKZiUElDx+fmJFmUxTsn3/iYT/hEHG50=
X-Google-Smtp-Source: AGHT+IGmE/KMv4Lirm/s4UP3hqPRuXpaX0FjdAK+Brv22wDzUef+zp9Becrox3gKBa0/2ENlHOjLNQ==
X-Received: by 2002:a17:906:c4c8:b0:abf:4647:a8cb with SMTP id
 a640c23a62f3a-ac252eab7c6mr291582366b.44.1741359143201; 
 Fri, 07 Mar 2025 06:52:23 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394830a6sm285835266b.47.2025.03.07.06.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:52:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0ED205F90C;
 Fri,  7 Mar 2025 14:52:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3] meson.build: default to -gsplit-dwarf for debug info
In-Reply-To: <CABgObfbcTqr7LNDumDXo7wXf=WigZ2U0Kwv97NRFAHgPoCQ8WQ@mail.gmail.com>
 (Paolo Bonzini's message of "Fri, 7 Mar 2025 15:36:01 +0100")
References: <20250306161631.2477685-1-alex.bennee@linaro.org>
 <CABgObfbcTqr7LNDumDXo7wXf=WigZ2U0Kwv97NRFAHgPoCQ8WQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 07 Mar 2025 14:52:22 +0000
Message-ID: <87ikok3nbt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Thu, Mar 6, 2025 at 5:16=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>> +if get_option('debug')
>> +  qemu_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g=
']
>> +endif
>
> Since -g is already added by meson, it's enough to do
>
> -if get_option('debug')
> -  qemu_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']
> +if get_option('debug') and get_option('split_debug')
> +  qemu_cflags +=3D '-gsplit-dwarf'
>  endif
>
> Applied with this change, then.

Ahh I guess I was missing that meson does that under the hood. Can I
have a r-b with that change or do do you want to wait for v4?


>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

