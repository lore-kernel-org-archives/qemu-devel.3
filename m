Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D97DC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 17:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJx3-0003CI-Lj; Thu, 20 Mar 2025 13:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvJwx-0003BU-2W
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:44:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tvJwv-0002Mw-0u
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:44:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso5501985e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742492694; x=1743097494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbVg86dL4OjGipJDKC04hYYAJluOLbTse0CjvR7RC80=;
 b=LRzPlp5znNNi5HCNBr8RV0K74p8cGHYhsJ5zLz0aFI53SiBVTRUpoSNZdDxGD5e9JM
 GgWi/7B3nZPZHNdpP3xaCrBLtZNVisD7dAzsW/Xp2oF8B+4WExfWZ5m0+GYs9omrhIxu
 RCkKCV5pcwz4g0feYVWsfAIw3C5PNJ3Mqb5sVVPXNORCaM3BwRJcfMFYzfLHWORPOI4P
 nEOjGCt279h2xNnn28T1PE+WmWHF2KSt+aO5FiceFFhCMGDuKS95PG54IQZ4zYe9xxOy
 vbpxZ/BZ4tNIxlvhUH3V4Xu9Y9dD6pfgDrqVloGJH1ay73xIaldborJPsLTHFjsxreC8
 tn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492694; x=1743097494;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AbVg86dL4OjGipJDKC04hYYAJluOLbTse0CjvR7RC80=;
 b=g0h6QpsewAidmbFn+9PiiEplB/8+Tzy1sOVGx3g+MDab78zcXXn3wAsSgePrhvkEmt
 jGcPlvj2MnJHR6VKagA8Fp19h0LgC9yUgkDZIVw1iqTJYfF2FiVFGLA1PjlX93dGAr3Z
 Ns2WWTGIyMIMc5ei9quEUhrtENdyibYY2loxK9FspofvBV8A5wr7d890fCHQnVjyuaEq
 aU8do74ru2g1PC5jkn5wThcagWA5KWi4mshpIuiFCQZmIY+CmsHrfGuVJrRgB/gw2Qua
 TCQEgaHPWuq2q+5tniP3BD9b6wF5RM1oE5Io33AYI/DpkIZNKs1QRiDx6k7DeQlooJOZ
 CP2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIOkW0KRDHurW2/GhyLbdkLpjK5pWI3+PBrkovQ0L0WHdj9M/9xOk0TJqeJmbkygwfEVfxVAfhTrbM@nongnu.org
X-Gm-Message-State: AOJu0YzZ3gKvzkkQ9qcwac20i8/l38gJHWjK4xGjD+SM4uj8tp02iU89
 O3kOaBvi1bIabpxM8eCkgK33sLZsB1s3E0f+ba/4vPu/bZfZKv3Mz1LY9hyR2zM=
X-Gm-Gg: ASbGnct9Vc/3fHXkJdnaoJJezwB+pvL+c26aU3EfVWhKXtnX0LEy5q4vPM9zMKzR3Um
 oejMc33zI4vK3fZDQOzO0Ur3N2STe9XJz2+X59PFRdbz7xsI5BlskZNs6oUaBrUNhena2aSbUMp
 SybyFqs9Q3EBz5DEGhOd56nD0RAjB63J1Seam/LkZ8Ql/UPm63jqhGm6YvDk/0Y91nhXaJgS436
 6XZuVolOER23H+AdlJG3f0eDFVmCMogZj7pB2cLKvmcU/EpREbO2WuihaBbVROHIyH+1JHcodLk
 7KiSvx0c/XQxhiAyf6YiLVIFy8N21YC5oQvTPT9bUvVrhuI=
X-Google-Smtp-Source: AGHT+IFIeVxpq+o3nBssDsRaHw7HLQfjOX+GB2tyLLXkflamz83ekVIWVckMnoVwMWiEzsVa7AV1Vw==
X-Received: by 2002:a05:600c:468a:b0:43d:ea:51d2 with SMTP id
 5b1f17b1804b1-43d509f4a20mr175355e9.14.1742492694188; 
 Thu, 20 Mar 2025 10:44:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3adc4488sm56238585e9.0.2025.03.20.10.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 10:44:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF17C5F8F9;
 Thu, 20 Mar 2025 17:44:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: =?utf-8?B?5rGq6bmP56iL?= <wangpengcheng.pp@bytedance.com>,
 qemu-devel@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] contrib/plugins: Install plugins to moddir
In-Reply-To: <CAEg0e7gHD+=YipqOrv_TBuMuZ3zxwtmERHVt0g8ZfiuwUK6mUQ@mail.gmail.com>
 ("Christoph =?utf-8?Q?M=C3=BCllner=22's?= message of "Mon, 3 Mar 2025
 11:37:37 +0100")
References: <20250303100927.3443321-1-christoph.muellner@vrull.eu>
 <CAHtqR7WAa09mwhO1QeQb9b7NR==ajLnuDC=L=NzYHNSS-6kjZQ@mail.gmail.com>
 <CAEg0e7gHD+=YipqOrv_TBuMuZ3zxwtmERHVt0g8ZfiuwUK6mUQ@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 20 Mar 2025 17:44:52 +0000
Message-ID: <87r02rlhpn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Christoph M=C3=BCllner <christoph.muellner@vrull.eu> writes:

> On Mon, Mar 3, 2025 at 11:24=E2=80=AFAM =E6=B1=AA=E9=B9=8F=E7=A8=8B <wang=
pengcheng.pp@bytedance.com> wrote:
>>
>> What about plugins under `tests/tcg/plugins/`?
>
> It feels a bit odd to install something from the tests directory.
> If certain plugins in tests/tcg/plugins are of general use (not just
> for testing) then it might be
> reasonable to move them to contrib/plugins.

They are useful in their own right - but the principle use case is to
test the plugin infrastructure.

>
>
>
>> From: "Christoph M=C3=BCllner"<christoph.muellner@vrull.eu>
>> Date: Mon, Mar 3, 2025, 18:09
>> Subject: [External] [PATCH] contrib/plugins: Install plugins to moddir
>> To: <qemu-devel@nongnu.org>, "Alex Benn=C3=A9e"<alex.bennee@linaro.org>,=
 "Alexandre Iooss"<erdnaxe@crans.org>, "Mahmoud Mandour"<ma.mandourr@gmail.=
com>, "Pierrick Bouvier"<pierrick.bouvier@linaro.org>
>> Cc: "Wang Pengcheng"<wangpengcheng.pp@bytedance.com>, "Christoph M=C3=BC=
llner"<christoph.muellner@vrull.eu>
>> Currently the built plugins can only be found in the build directory.
>> This patch lists them as installable objects, which will be copied
>> into qemu_moddir with `make install`.
>>
>> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
>> ---
>>  contrib/plugins/meson.build | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 82c97ca0f5..c25a1871b7 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -14,11 +14,15 @@ if get_option('plugins')
>>                          include_directories: '../../include/qemu',
>>                          link_depends: [win32_qemu_plugin_api_lib],
>>                          link_args: win32_qemu_plugin_api_link_flags,
>> -                        dependencies: glib)
>> +                        dependencies: glib,
>> +                        install: true,
>> +                        install_dir: qemu_moddir)
>>      else
>>        t +=3D shared_module(i, files(i + '.c'),
>>                          include_directories: '../../include/qemu',
>> -                        dependencies: glib)
>> +                        dependencies: glib,
>> +                        install: true,
>> +                        install_dir: qemu_moddir)
>>      endif
>>    endforeach
>>  endif
>> --
>> 2.47.1

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

