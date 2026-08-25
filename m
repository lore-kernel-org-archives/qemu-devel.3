Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D57DC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynAB-00038l-9P; Tue, 25 Aug 2026 05:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wynA9-00037j-WC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:09:46 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wynA7-0004iR-1g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:09:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a3819e8be8so1259944a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787648981; x=1788253781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fL8XwWEUt2XqCFR9h3EPj7YOpktrz+Uvr5FCS9wX/Vo=;
 b=pO2TtLmIV4k/jqC/tlEtWis0cwn6XDCcd5NKVIfC6OSMHg2E6KZDfR17UKk+JXC3e1
 ZPwEv1s8JGnsq29lB91GfDx0p2BJ9WQs2eA19grTmdn6g+xVeiTsxyQFIwAWRbT8RROh
 87hWWHFzZ/rU0wMCHE6iWL+IuTLjEZpY+GxA9w9XHMVbGS2FdnVtHXzXXkf7S+i5v8L9
 CUh5PvORx5GQfkbv7xAgadivTAeD0Vqu4aKANP0Msa4YC3Ts4ahclflsy5ldaw2YvxLx
 S1sH4c9306JCsyIHf7DRXwN+e3ERtoXdQDO9oNSPOytJedcVe8p7gZif/qrTfR6VeXtB
 SNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787648981; x=1788253781;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fL8XwWEUt2XqCFR9h3EPj7YOpktrz+Uvr5FCS9wX/Vo=;
 b=qszUFoxBJgdqWuT9vUsO4EpAkc0i3XoyTYjeF+JbBvJ1xHK+8VsplDrOiKyQho0+J6
 GlUCZin6CDiXBYQaaOF77w89EAqJ3z4bXkPLKwGUCcXIL98jGzxU7+iWHyFsfeXYCDFj
 IfxsnAZVqbmMJoQbQQtUvr46istwOphIEZpYR3as37et0MSTcM2eLfaR9qOBhoD6YG8L
 M51TValmWUHxhqiu1kuEgHEtZFcMIzh6C1MZJZZYr2li9JKK9rx2t7T4lu6ygqZ8QTCu
 oaPcPSRIzfRtc/QCV7+Brft1L8HdP2y8lPm8mHLv4gmwkM3qOgpiXKK1Q9lYleQUnOXt
 OSbQ==
X-Gm-Message-State: AFuF++luqkhDHGfMlEmBhZ7B66/T4JFVPbOkNzhuFDoSdgCl4PiqDssA
 U09E/a54DaIlSHoyODgGXOrZMQv7wWAb1GC0pexIYs+l4W07I53hxIw67z6WNfJmWbM=
X-Gm-Gg: AR+sD10wdXSM1r8hQvubgJcs45MrmW5HXASAfbDqcQioTwBbia9AqQLFlaEQtmt4Ivi
 kN5a1dRc5ePss4OeUHWbQuJ6YgrQdGi6xVhhNaVv6qYO22QwTm2FiEFR4Vdc6/4gWpmsRqP7i8A
 hG6vZaOUhzoP0hqWR9lWp13lS2i00NwtpxwJ5V6lg2n8DmM6ZVb8BVucoqnG0Vop7v3UE5HZJ75
 Ik6bxbLqpwRms8kiDQDUjjjimjD56/1oR15dgLXdM0HaQBqGquVnk+rMTeR4fSbBUELrio3cEdl
 NOCKEMRyFkeyCZNOyuXEgbe3rUYG8Qjlw56LZ476uJ7KLhdRMGuABitaYUSA1rDTbhD3bAJVs2V
 gUq8do4r9+tJM45KeLpposwpAgjaHUQhiufjVc+tGh64Qo1kgw9zl0LVJk1p0VMi1AQbf1KN7f6
 N/b0isidX8kRZBWSLh80XWL3UA9rBej+0HM4PBw0kegcU7rhRZVTdrl8MQBPCt
X-Received: by 2002:a05:6402:4288:b0:6a3:eb3c:4142 with SMTP id
 4fb4d7f45d1cf-6a5c3f0fed4mr5653555a12.8.1787648981090; 
 Tue, 25 Aug 2026 02:09:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2da49bsm14554142a12.29.2026.08.25.02.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 02:09:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB2275F7DF;
 Tue, 25 Aug 2026 10:09:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  zhenwei pi <zhenwei.pi@linux.dev>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  John Snow <jsnow@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  devel@lists.libvirt.org,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v2 3/8] gitlab: add arm-softmmu tests to the macOS build
In-Reply-To: <1a491e92-d7e7-446a-9b08-53b12a930be3@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 24 Aug 2026
 23:28:28 +0200")
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
 <20260824-fixes-for-11-2-v2-3-352c6b890402@linaro.org>
 <1a491e92-d7e7-446a-9b08-53b12a930be3@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 25 Aug 2026 10:09:38 +0100
Message-ID: <87jyper2gd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 24/8/26 17:24, Alex Benn=C3=83=C2=A9e wrote:
>> Now we have fixed the compiler issues lets have at it.
>
> The rational isn't clear about the benefit of adding this target.
> 32-bit is already covered by i686, ARM by aarch64.

The MacOS coverage is pretty woeful for all guests given the paucity of
compilers available. I haven't done any in-depth measurement of how
much extra coverage this gets but it will be some.

>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20260723200904.224413-4-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.d/macos.yml | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>> index bdb3eae18f0..40b9b637b3b 100644
>> --- a/.gitlab-ci.d/macos.yml
>> +++ b/.gitlab-ci.d/macos.yml
>> @@ -22,7 +22,7 @@
>>       - export PKG_CONFIG_PATH=3D"$PKG_CONFIG_PATH"
>>       - brew update
>>       - brew install $PKGS
>> -    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
>> +    - brew install arm-none-eabi-gcc aarch64-elf-gcc i686-elf-gcc x86_6=
4-elf-gcc
>>       - if test -n "$PYPI_PKGS" ; then PYLIB=3D$($PYTHON -c 'import sysc=
onfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAG=
ED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
>>     script:
>>       - mkdir build
>> @@ -40,8 +40,9 @@ aarch64-macos-15-build:
>>       PATH_EXTRA: /opt/homebrew/gettext/bin
>>       PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/nc=
urses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>>       CONFIGURE_ARGS:
>> -        --target-list=3Daarch64-softmmu,i386-softmmu,x86_64-softmmu
>> +        --target-list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,x86_64=
-softmmu
>>           --cross-prefix-aarch64=3Daarch64-elf-
>> +        --cross-prefix-arm=3Darm-none-eabi-
>>           --cross-prefix-i386=3Di686-elf-
>>           --cross-prefix-x86_64=3Dx86_64-elf-
>>           --disable-plugins
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

