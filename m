Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB99C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtTt-0002F5-R5; Mon, 24 Mar 2025 21:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twtTs-0002Ep-Kx
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:53:28 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twtTo-0000OX-DD
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:53:28 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6ed0cc5eca4so2950736d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742867603; x=1743472403; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eF8AsYLB8ryNKzx8FOQtDCgtdWwU+MxMBC3RmTM3L8E=;
 b=QomudQGPe1qgJL6WIyiyqJy5/YEOvCRVmELNfLCzFDXPuYzJPtuCetMNW3FInASvWQ
 RnVIJt3t2sQa9mzO4DOxbzDY3PeB96AMRUEiBZNp+E643HcCXxRxJumJdbxcsZpZ683Y
 Q0fqyD3en3YwMuvYhW4IcA1YurSc4ugliuvZ4bD4pzikiWwN2ok1QQK489Y6h/KZadWI
 I7jaWD6PcR1bzTRo7eb5KVp+AddMkf5vBuImJsX5nh2qQuRNVFWTnv/MBCHQu6ovQn1S
 /tlNX/r+KVx2ODVWWOQI93CeIMmlPD1OYgKoQdjdBdD6lYsMi6iG6sCDUIU2aRPkMvdd
 ugNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742867603; x=1743472403;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eF8AsYLB8ryNKzx8FOQtDCgtdWwU+MxMBC3RmTM3L8E=;
 b=fiEym/FznqETpLa748YEuN6SklLV7Xf5oylH+eU6WC0XcJxKu73bnfPj5aK9hyaWdE
 Arq5r1QZSCXLDVd+jebH6OGaktgnrUDb7ojO+hUkIFsH//sUFdIlC1g4j8ke+Pgg0vDI
 ZvAkIMxqX9PxGh9pVVoVVYx/AZ2dCbOTz6mYmy9/mJGRVBLWvOEK/8Cagh6id5WlSGVr
 LNviRPRR+nQZHyTjrGXzuGrGAmNqzj6B/MmV+6CMN0Zx7Py9zZDnmrlkB/nTtTQdEak5
 Djsba5MeAzBhtOutA0DGdl9z8+rc+YMk6X+41pPqmSZpKe1jAfXUwsZaC/RhA1FxYFLg
 +k+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ94qJxpIirxjEWIFBBqXHaKztYIaU3RzgjM8bXkpwgXExVIxgY+1TTZ/gQFNkBMVGDVRK7BBdCSsx@nongnu.org
X-Gm-Message-State: AOJu0Yx0/Vwbb1tQYc4nXiGXQnsbvxZNmMWYKhIVz+nZOala0gngSC7b
 w1OlJgnbX+0dIlRuVcApcykelh9BZg0IkhJrvGt2cobu9DfZXL7m
X-Gm-Gg: ASbGncu2kp9JvBlNLFGJLfhxH6SWjnbP/1HHSuM1lyvzd9hXUXWqS5v8Y90KZCs2ZY2
 8aUc39I2Zpc+kHDPoxfThqUHBTp7fxbsabcZh0jRzP1aKwuWuyBFqyl+Z2b2713WmZnl68ik7tE
 DRxnJB8MRzqAuVfHqysxj7GPORpNbfF/5QS3y7me6kj94ZsM5KTjC+lVksQrm8nyIzP1AaDDUQw
 MzUXHv3FHYV3OMBMUUJrU0Fo5Le9Vi8xMHH0qc/HxfGt9JrZdboVFUC20a272Jq5td0j0neJrAX
 oVgZ3cgnYyjQi+/Tx8S7FHk+eg41sb1EeCzKjYmug5oR0qljrL6hd/c6cer2iw==
X-Google-Smtp-Source: AGHT+IH14IvXRRxGuI/qo7I/hxPO2D1DS4mdLxisqPp0HNqF5siB+K8zitMVZkkLaUtWPFP2CTBzVg==
X-Received: by 2002:a05:6214:21c6:b0:6e2:3761:71b0 with SMTP id
 6a1803df08f44-6eb3f090126mr312480006d6.5.1742867603228; 
 Mon, 24 Mar 2025 18:53:23 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:70c5:433:52e6:1b6e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef1f666sm50829056d6.41.2025.03.24.18.53.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:53:22 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>,
	<qemu-devel@nongnu.org>
Cc: <ale@rev.ng>,
	<brian.cain@oss.qualcomm.com>,
	<philmd@linaro.org>
References: <20250312194547.7364-1-anjo@rev.ng>
 <20250312194547.7364-3-anjo@rev.ng>
In-Reply-To: <20250312194547.7364-3-anjo@rev.ng>
Subject: RE: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
Date: Mon, 24 Mar 2025 20:53:20 -0500
Message-ID: <001501db9d28$affce200$0ff6a600$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHqw2qhMYTgftKQtEzGJUewzZGqVAFkGngws1mpMIA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250324-4, 3/24/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Anton Johansson <anjo@rev.ng>
> Sent: Wednesday, March 12, 2025 2:46 PM
> To: qemu-devel@nongnu.org
> Cc: ale@rev.ng; ltaylorsimpson@gmail.com; brian.cain@oss.qualcomm.com;
> philmd@linaro.org
> Subject: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
> 
> The indent command is not available on a default mac osx setup with xcode
> cli tools installed.  While it does make idef-parser generated code nicer
to
> debug, it's not crucial and can be dropped.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/meson.build | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index abcf00ca1f..246dc7b241 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -323,30 +323,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in
> target_dirs
>          command: [idef_parser, '@INPUT@', '@OUTPUT0@', '@OUTPUT1@',
> '@OUTPUT2@']
>      )
> 
> -    indent = find_program('indent', required: false)
> -    if indent.found()
> -        idef_generated_tcg_c = custom_target(
> -            'indent',
> -            input: idef_generated_tcg[0],
> -            output: 'idef-generated-emitter.indented.c',
> -            command: [indent, '-linux', '@INPUT@', '-o', '@OUTPUT@']
> -        )
> -    else
> -        idef_generated_tcg_c = custom_target(
> -            'copy',
> -            input: idef_generated_tcg[0],
> -            output: 'idef-generated-emitter.indented.c',
> -            command: ['cp', '@INPUT@', '@OUTPUT@']
> -        )
> -    endif
> -

I prefer to have the indented version present.

Is the above check/fallback not sufficient on MacOS?  It works on a Linux
system where indent is not present.

Thanks,
Taylor



