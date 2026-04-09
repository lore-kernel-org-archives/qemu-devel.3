Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D62EA3C5E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wApLb-0004c7-Qb; Thu, 09 Apr 2026 09:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wApLZ-0004bb-Ss
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:23:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wApLY-00077q-4m
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:23:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso565626f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775740978; x=1776345778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0KvwrJymUbJzIua33NKYuOwjtkD7R74EjdXbvE3sgE=;
 b=JLeHrgkB4sCOc504m67xc11y/rAkmTB0d7qfdvKeZFbKkywiKyJSgJ31yH8miEibp0
 ErrvGt4RlFNzFBgjWns4hFEUdqpzBNFHXINQwWGsnFdKOnK+HScTDsPdIhdnbugJDGoc
 yaEba+8rlbSZTdnxbyPbodw3R7QGaq4CqDem2rExR7hWFtb3WPCg81T2XHHF7F58DDd4
 FKAIgoJCPvQOg7XTOA+2v51IZ1kkPkSLqee8Uk5jbzObSSMOd6A211SOom3cVclkYi9/
 aieVvbPDO4FMbVqJi9zMnm1D9/L5sTPzeYcvJstDgIkk/HDMjnKqA+3qAb58N1Byjmjq
 zGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775740978; x=1776345778;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0KvwrJymUbJzIua33NKYuOwjtkD7R74EjdXbvE3sgE=;
 b=Ehmvmf+jn8F49ej9+/b5+GXRzVibKNtuEGg6F4TYGou0WxPoOaKaDl32AhPcIEUR4I
 Y8mINBITcS/gH5wmwosWBm33jRpwxGykaI2hMG9hRttjj6C9uUVSSFBsYvkvJQ6bZm6C
 VqIBfKHroNP8h9InsxkDqTxKZluYRJhwQHCnDW5l2lcFCg1MbKwPiikM5RYY4mP+XTNZ
 j9oYJxfihUMseyZGZCsM0QsT+KEKVQj8q/P8gqLXJy0YS31T0rXxODYNiR5YjFo75dJj
 joLSbDG4B3k5DPg7s1G4vtFp+xqpluXyOVN51H8o89VKXo/48+LlaPkX2f+zo3JdWmcS
 fAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnZXKfMbHagsJ19vEJ6ZRaWT4iuDyf0EwrRTFVt52cjkWkP5ESp46Bvw0oHksY7Y1Fs88bwdLKXvBw@nongnu.org
X-Gm-Message-State: AOJu0YxKWNvWkZIV7T0jy6VLgu+dQiyGsMmcxYnmabtT9hP6ahVxygRo
 d4wi5XEqdAnbgaJwGA+huQpPuIgMs8qjo0Q2nmzVYRR5Q+1x0Xmaya1UBgfxoGRyvdZjzEXPYNd
 NYwhRHPOw4Q==
X-Gm-Gg: AeBDieuwpClwZJ3HYPfwEdUiKS5P2evYMgbXfaaY0PBXDftZwpzM1sEpvBRu5ANlDyq
 0HSxKyUBA6dAGMslMYeVviFMf8kFQFyw9dYkgssBlUVNH+rcHLOesyyp1gf3J5H+VlZoaooYafT
 pze/LpqO11ZHX2dzuDC5rHnWubO4AOs9/fbyTvPWG157Vr6ISp72eUf/TW64rRTMFM81cDWpYlK
 BqonOSblXCYFYl5CfweOXJcsRWFPKkBaa9hAq6GqldC7JZK7FjafxPMDlLPTakrZM2kWjQxBlMK
 0EBeR6Lz03ma13OHgKbdM4dzIoeLxv7KPEdaCNHZpgVo5//Y0kQU+vWxMva0JZKQ5x9gUQ9Hs9o
 aSf+k/g4EElkgmsrQsfqnkW7mQAmxtyq31ORIK/dgGLJiHEFYXZEZOs1aiTbYrufIzpAMf53dbX
 3pX+pvtypzECNxAbs0yQvk1vo=
X-Received: by 2002:a5d:588c:0:b0:43d:1cec:4766 with SMTP id
 ffacd0b85a97d-43d292e3a26mr37404760f8f.23.1775740977136; 
 Thu, 09 Apr 2026 06:22:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5294sm64127495f8f.35.2026.04.09.06.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:22:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3B9C5FA6F;
 Thu, 09 Apr 2026 14:22:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Anthony Roberts <anthony.roberts@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan
 Weil <sw@weilnetz.de>
Subject: Re: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
In-Reply-To: <627204A0-8806-4420-97A2-CBDC36C41981@unpredictable.fr> (Mohamed
 Mediouni's message of "Thu, 9 Apr 2026 14:21:59 +0200")
References: <20260409110256.684-1-anthony.roberts@linaro.org>
 <87qzoo9vzu.fsf@draig.linaro.org>
 <627204A0-8806-4420-97A2-CBDC36C41981@unpredictable.fr>
User-Agent: mu4e 1.14.1-pre1; emacs 30.1
Date: Thu, 09 Apr 2026 14:22:55 +0100
Message-ID: <87mrzcjmj4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

Mohamed Mediouni <mohamed@unpredictable.fr> writes:

(Add Stefan to CC)

>> On 9. Apr 2026, at 14:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>=20
>> Anthony Roberts <anthony.roberts@linaro.org> writes:
>>=20
>>> The original commit had a section of code which worked on the assumption
>>> that if OpenGL was enabled at build, it was present on the end user mac=
hine,
>>> and calls could be made to it. This is not always the case (such as Win=
dows
>>> on Arm devices).
>>>=20
>>> This line should have also included a runtime check.
>>>=20
>>> This commit moves the relevant line to inside a runtime check for OpenG=
L.
>>>=20
>>> Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
>>> Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
>>=20
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>=20
>
> Hello,
>
> As a related note, modern QEMU is built assuming EGL which Windows does
> not ship as a system library - and doesn=E2=80=99t support a WGL-only con=
figuration...
>
> For those distributing QEMU binaries on Windows, they should bring an
> EGL implementation along such as the one in mingw-w64-angleproject=20
> or Mesa for Windows if they wish to support OpenGL functionality
> instead of having crashes.

Stefan handles the semi-official windows binaries.=20

Generally our windows coverage is poor as most developers can only use
the mingw cross compilers (if they even check) and we have one Windows
x86_64 runner via Cirrus which doesn't have bare metal access to the
hypervisor.

It would be nice to have better testing coverage in CI but that would
require someone to fund some bare metal runners and volunteer to keep
them updated.

>
> Wonder what=E2=80=99s the best place to document that requirement=E2=80=A6

docs/system/devices/virtio/virtio-gpu.rst

has a fairly in-depth breakdown of the various moving parts you need.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

