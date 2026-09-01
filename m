Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C7EC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MJY-0006Ah-Tq; Tue, 01 Sep 2026 07:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1MJX-00067y-13
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:06:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1MJV-0002Vr-98
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:06:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso53138815e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788260759; x=1788865559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lUgAUhd2rXlgrh/xTe4gpmKro7R7g5bjnf8JPhRAS0w=;
 b=lhONVxImyMkoDuS5OmU4UrbnBIkXezDvVa1gpU9zCS8ZYmBnTOEnnHxBwFFkrCpMpy
 RMInTiZPnsFap8zBh67GasWqrZtveAwdmf++O5nAqgGP0znNmEdD3KBgN5JWGidYWrj1
 tnfMmHu+doheKgmVFfZCB9Bu2T2hhglDJWCo3h9F9XO/eun/BLBa8mhAw06j4DkfDbmX
 u+hUkKOJaUJmTzkVekA8YNxopkMPJuVh0fxq/1udk8gfvviIPrWXOUr9dGuQnxp9Kj+G
 gpvafwPEw6i1SuyMbPXeksXyfSfPrkqtQyNv6NvPpsTvoMApKC7sZpdqTcj0dnuG1HsS
 x9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788260759; x=1788865559;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lUgAUhd2rXlgrh/xTe4gpmKro7R7g5bjnf8JPhRAS0w=;
 b=YyIWdVSoeZm8u5QLBSUMFtlmebXRGtSX5CSJnWAyOoR/WogNBpZ7XzBatDUO6SxNBg
 Q3R/EL9D+j3CN92lmcw9rku1XJd09XYeXjqp0KD7b0PwppJd251wLFMznBYAsoj/QQok
 XdB5+CSzOHahVRI27itOxtVADzkif1yKguywwxv7YdtB0g7bNXv6OxMlh9EnZTZxgXfU
 gglmXq81uVpg0AnLTstzMgG5FzGKZyO4cjZK0ykyf6BtVZzIBJ6yv2a0R2LsNh+Mzp2+
 QsWPv2oidqMEzE1P5kWdGehP7gcUiefP09NCOtQ56xE6u+irx5y8y+ZeaVECpAniAC2W
 hkAw==
X-Gm-Message-State: AFuF++mtFCZBvqVmhQdriZc96vJAIq+ZSWpD1n6qc1ow16bs/dS1uwKX
 rNmOzC3qkUCb6jub21RaI4mLXB4uqIadWVJGLCQaXeZJxTreB6o7GM3j63RH0pUqivw=
X-Gm-Gg: AR+sD11WhvMUpo8ylhugnjx867jJ+VuERofYT+IRHqPRPfGVMo0tf4v9uut2mzXigqX
 ZIe/5Of+OzW6YaVV/L3KNbbq43Gc1PuR7MAh7jndAAQvuAvDwJiQZ/umd4jE3QLQO6o11EaI/XZ
 ut8sLECYTXQY9+qQMUJ7DBstgkKQiZIqS+0RIp1igvJHpE0uWeuMwlCzM+LRaLz+WJLH0C+mVfX
 3asBmqsyuY8HhzkRSKeabba39pI89ceSKAkxHc0fxxUeKJBHa2RY9Bj4hlXpKHA8bJp5SxEe8iF
 wc6U3zK3c0CJZiRb3pjhY3Fn0veZd5OHWXiLOGh4dqsI3u5c6U1iMMqbqXeoN8NRjDNPU4Qc1wf
 DaDwXYX0+vpT3CNzssHW9UTtVR62KwJclNXVNV4CW0BlKISvSvHEvl+jOBm3HH063Qz3fb6mzX6
 aNF28rlFZaOc15Drftrl8eqBvUsTKJRHJPTJjyk/5hYem5QQ==
X-Received: by 2002:a05:600c:3584:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49cdada30e1mr133990995e9.2.1788260759497; 
 Tue, 01 Sep 2026 04:05:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b926874fdsm348301715e9.4.2026.09.01.04.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 04:05:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96BBC5F829;
 Tue, 01 Sep 2026 12:05:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PULL 12/25] gdbstub: Introduce GDBFeature structure
In-Reply-To: <e9d8c2ad-4412-4299-bb1d-34709b6e42d5@redhat.com> (Thomas Huth's
 message of "Thu, 27 Aug 2026 12:45:39 +0200")
References: <20231011103329.670525-1-alex.bennee@linaro.org>
 <20231011103329.670525-13-alex.bennee@linaro.org>
 <e9d8c2ad-4412-4299-bb1d-34709b6e42d5@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 12:05:57 +0100
Message-ID: <877bl5w7sa.fsf@draig.linaro.org>
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

Thomas Huth <thuth@redhat.com> writes:

> On 11/10/2023 12.33, Alex Benn=C3=A9e wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Before this change, the information from a XML file was stored in an
>> array that is not descriptive. Introduce a dedicated structure type to
>> make it easier to understand and to extend with more fields.
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20230912224107.29669-6-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231009164104.369749-13-alex.bennee@linaro.org>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9e7dec4a58..c3cc12dc29 100644
<snip>
>> +        if c =3D=3D b'"'[0]:
>> +            sys.stdout.write('\\"')
>> +        elif c =3D=3D b'\\'[0]:
>> +            sys.stdout.write('\\\\')
>> +        elif c =3D=3D b'\n'[0]:
>> +            sys.stdout.write('\\n"')
>> +            quoted =3D False
>> +        elif c >=3D 32 and c < 127:
>> +            sys.stdout.write(c.to_bytes(1, 'big').decode())
>> +        else:
>> +            sys.stdout.write(f'\{c:03o}')
>
>  Hi!
>
> FWIW, this causes a warning on NetBSD:
>
> [913/4769] Generating gdbstub/gdbstub-xml.c with a custom command
> (wrapped by meson to capture output)
> /home/qemu/qemu-test.QowHuk/src/gdbstub/../scripts/feature_to_c.py:28:
> SyntaxWarning: invalid escape sequence '\{'
>   sys.stdout.write(f'\{c:03o}')
>
> I guess the backslash should simply be dropped? Or duplicated?

Paolo already fixed this in 7bca0ea74a049839e030c7fb33e82c0a7f7cd791
although I had a similar patch I obviously forgot to send....

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

