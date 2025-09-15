Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A087CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy66u-0007Ck-HK; Mon, 15 Sep 2025 06:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy66o-00079C-8d
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:06:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy66d-00060d-Hb
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:06:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso39856105e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757930796; x=1758535596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUwBE/3JeKVh2fnm/o3oHMNb3S7p2IufNZQrGTpBmGw=;
 b=mk36XMoHVGEwbrkAiuaU2p9idU1+NZqz0GgWbRmlYrczig32Gy6RRSayhIUBV2vMfY
 ZgV8ooMSQ6YUKSKy4DBUHhv7BCvTsh0HgQu1CBn0DNuTZl057agGP9WsMx5VPwVbm44k
 vjjoYCIuBhuVqCIMTcEIjDu6XQz/thSbzvYjxRRD9UzstGZxDyJH3xdHw5hRLu7avu95
 oQpsj3KLIJTfxwssEM6JTjOMi8/h7cilgbUfLb5o8fzzMgrr80WpDaMDk2LNyjR4jJN8
 H8XujVWSPpcL3wUfNvZIvc3qa7ni2lbSAa7suzaItESTSUOyqwEEQMpMfIzBS66LEeA0
 lFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757930796; x=1758535596;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUwBE/3JeKVh2fnm/o3oHMNb3S7p2IufNZQrGTpBmGw=;
 b=IoOas0EM8nMg7N4EFfJHmW6Mwm1o9Cq/Wx7F+jWeybYJfFcfYUDDey9N8bI5M6nbW4
 4HUvm/BC5cYtUtmY95XSPisGEh6nhzmwquSZMHMMDq6mvIl6QQ+Jtz/arLOk/aTno0Ez
 cKXtaFdShHkFogPB2DhfV4SFcTPE75FTXrINfUakB3EIySPN5vu0gfMQ1jjm5xouqLoj
 0eRdhSWLpUH4b432TC6o8k1ykOusc1012AC5kJXOT+q60mHMwPEi5NH3U5cfOmQxVOBI
 r454VeE15YKRZlTFPtYNbFoC5DXIO03P0OBDiQHQBb0o+p8nveFn+9ZORIoR0PCcF2Oq
 farA==
X-Gm-Message-State: AOJu0YyaIhk7vXf931Mwcy2I5ByVlUieclRGO1bT2X2IP/NHS+kg+6bp
 MZ4dP2NG878eByTFJF1uFT9WLBR08UaJ4MiLgWxedaLfpwgWlBbQxdMfIBL/tzib/hvUyHdIFdV
 fYcV09ss=
X-Gm-Gg: ASbGncs8kQpmUnk5dKDBYKMKjQY6lBQRCNb/UFNOyoE8jpry4j/4wtv5tXUKGN6tcA7
 68MNiTXn67JdAHURgReZxifo1s2BFqJbkENgeQh8hcSQXMsGPoIRBnwvhHnBltyInldKJbvlsiJ
 7AUdYmUzLvbi2eVeoIXCZWp+BA/hZdhbelAOyZIka1S685ctKJl/Ai90AWV8WsmX/BdvN0+nLL6
 p2OlqB9pdlSgArTQiEyOiEZZ2Evq63SEAeqpFwSJpUE3u8+E1B12udCAUYtdR/xsKHEBw2J/Cy+
 vxqkEFWDjpCL4LY3nWgdukX75dp5ufJRxkGgDMKx/IhtVNgrrvYNgfg4GK/yJUUxWjCnmVcUX9m
 vD8a8vdDTga8TOX14Qs6QCSf2UbqI731Wfg==
X-Google-Smtp-Source: AGHT+IFz1HjyMI7QwR0WJ9c8gve7FfR2WYve3sekLpK0WjtCxKgWCC4tAxujjw/w2uBiIZqBJi4ODA==
X-Received: by 2002:a05:600c:5246:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45f211c8aa9mr126167075e9.10.1757930795933; 
 Mon, 15 Sep 2025 03:06:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156d206sm177402935e9.5.2025.09.15.03.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:06:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C46C55F867;
 Mon, 15 Sep 2025 11:06:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/6] tests/functional: import GDB remote code from avocado
In-Reply-To: <20250912182200.643909-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:55
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-2-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:06:33 +0100
Message-ID: <87plbsrpw6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The gdbmi_parser.py and spark.py modules originated in projects
> that pre-date avocado and are imported unchanged aside from the
> 'import' statement in gdbmi_parser.py
>
> The gdb.py module is original avocado code that is imported with
> all classes except GDBRemote removed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/functional/qemu_test/gdb.py          | 233 ++++++
>  tests/functional/qemu_test/gdbmi_parser.py | 419 ++++++++++
>  tests/functional/qemu_test/spark.py        | 850 +++++++++++++++++++++
>  3 files changed, 1502 insertions(+)
>  create mode 100644 tests/functional/qemu_test/gdb.py
>  create mode 100644 tests/functional/qemu_test/gdbmi_parser.py
>  create mode 100644 tests/functional/qemu_test/spark.py

I wonder if we should put these in a subdir named "imported" or
something similar to make it clear these didn't start here.

>
> diff --git a/tests/functional/qemu_test/gdb.py b/tests/functional/qemu_te=
st/gdb.py
> new file mode 100644
> index 0000000000..913e3b65ab
> --- /dev/null
> +++ b/tests/functional/qemu_test/gdb.py
> @@ -0,0 +1,233 @@
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +#
> +# A cut-down copy of gdb.py from the avocado project:

Or indeed a link to upstream from here and the other python comment
blocks.

Otherwise:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

