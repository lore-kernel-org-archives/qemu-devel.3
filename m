Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8994DCD4F2C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXxSj-0003Z3-66; Fri, 12 Jun 2026 04:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXxSh-0003Yb-8W
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:41:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXxSf-0002bl-Lh
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:41:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so397306f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781253715; x=1781858515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGCKSNXMNuGp59+ayIPxBmQonEttZvJdJDY0P0tl4mU=;
 b=GH7uHueJSVvwJr76BxNI2HkFK49OvoXVSo6pF7ECPFm60Ibn6lJHSYLPdY5hvF0KlG
 9dzJZ4qRiaBtlZfdQ6DxRyUVyBK8eQvfKTtpSpDtid2D5swV3UiZa9ZeoOZGWOsh5IJw
 w0ymXrjMIKcfdmjzFOy0/vgq1d8vn8nE5IX+tEi1ud8iMcKKFVBYo5+3kxiZUo6EMQS7
 QwXsZetmy+158vLqH7VqT0SD56/Sw2ZwoeTpHP9FctNDibVvoER3Srrv/d3fx1TW9L2C
 CwL8myS392hkq31YfNqz8elDeaxS+cQc2rTE44SiUc3oRfTCyth/7vr93fartReEljqY
 MzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253715; x=1781858515;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GGCKSNXMNuGp59+ayIPxBmQonEttZvJdJDY0P0tl4mU=;
 b=T3CzwXdBVh1pbX2NWmODOBuoARyWQZAT0H49x2d4T0+aidXzPuUXdnb9r3P1I7O0SH
 kWza69ev7C5G227JbDJueAUiYUwI9pRqq/UvYAP0/F/egSU8YfdUDxpq542LlE1KAkud
 u7QXkdRDNCWf6RXfyI8Iu8EeXUVcXKhHlJdHrIG3ey7yoUMdLg5jfI0ynNWqcqiEhCLY
 3Ck3JFBmMLPijrWrLk3C9lIVz2P2c4ZjwJ3QGXexziLV+4qT8vYqAiHb4e8bFQGtOC6m
 qUeC4w+7yiWfBQi0CZcy1oBoW5T/NCzgvZWlemyVGTHA9PzpQjIRVqTg5BM+RcDLqjUP
 899A==
X-Gm-Message-State: AOJu0YwXEcQvH0WlPFYwqd/F1xSGUva7Bmufp/sO/wJK5tbwFWC74HLy
 BlUbM0MxrDGS+lGBsf/wTqx6+WG5VoFX7Djz0a07bW1xYfDKzfLKP6gXbqnEVQpoh4g=
X-Gm-Gg: Acq92OHW3aQd/z9Ux3VIlJZOCPuZtca5yLxKhWsyYqzudeanzyxdtmgFcSFKopW/W6W
 YXdH7npzqOjL7Ypx2et8uZK1Ex5XBbRqkOT3szSo2Iv7UeJyT6w5MXtF4JVbfmyZmTqufcFsIUi
 PsfJNzxfXGce1rzgdm2vSPTXnNZFn5cU8M8qGutSN3+3RG32bjdncK0FRWdy9FHt9p7MP0z8Sm0
 N+1BLv0PNvRy+ALAZAcTSs5aipYKfDqTKKT4SNP9e2Vtq5Fe3nGhuTx7YqsfUC+1EK3cFJKXorq
 pgcEjN2TVYaWyAne57rd/TRFmqW23xlhGtCvmH+VaEd1FiTB+EXRD63JIt4w6WGDR1BJo1FLJkA
 smUSL5cvnBcDX2w3G03dHmYmL/ShwRyzRuGqR4G37b1gXLssaPRIw2lYIllq/6Azpu2Z0/m18lc
 8FcE+LuX3vJ9cvOqboT9Ot8Cw=
X-Received: by 2002:a05:600c:56d8:b0:490:b642:ce31 with SMTP id
 5b1f17b1804b1-490ec4b9030mr14864345e9.2.1781253714686; 
 Fri, 12 Jun 2026 01:41:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db56asm61650635e9.7.2026.06.12.01.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:41:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D993B5F814;
 Fri, 12 Jun 2026 09:41:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <th.huth+qemu@posteo.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH] tests/functional: allow pylint to introspect cv2
In-Reply-To: <96289f60-23a5-441d-aff8-831aaf95eca0@redhat.com> (Thomas Huth's
 message of "Fri, 12 Jun 2026 08:19:04 +0200")
References: <20260611162536.2184620-1-alex.bennee@linaro.org>
 <544ac437-5dfd-4cf0-8332-16cf8bd56260@redhat.com>
 <874ij8ganu.fsf@draig.linaro.org>
 <96289f60-23a5-441d-aff8-831aaf95eca0@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 12 Jun 2026 09:41:52 +0100
Message-ID: <87y0gkdub3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

> On 11/06/2026 21.05, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 11/06/2026 18.25, Alex Benn=C3=A9e wrote:
>>>> To fix:
>>>>     qemu-test.test_pylint
>>>> "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83:
>>>> I1101: Module 'cv2' has no 'imread' member, but source is
>>>> unavailable. Consider adding this module to extension-pkg-allow-list
>>>> if you want to perform analysis based on run-time introspection of
>>>> living objects. (c-extension-no-member)"
>>>
>>> Which pylint version are you using? I don't get this with my pylint
>>> here (version 4.0.4)...
>>    dpkg --status pylint
>>    Package: pylint
>>    Status: install ok installed
>>    Priority: optional
>>    Section: python
>>    Installed-Size: 2073
>>    Maintainer: Debian Python Team <team+python@tracker.debian.org>
>>    Architecture: all
>>    Version: 3.3.4-1
>
> Ok ... thinking about it, I think it would be better to rather add
> "c-extension-no-member" to the "disable" list in our pylintrc instead,
> otherwise this will likely pop up in other spots as well and then we
> have to constantly extend the list each time which sounds cumbersome.
> Could you please try whether adding "c-extension-no-member" to the
> disable=3D... section silences the warning for you?

That also works, I will respin.

>
>  Thanks,
>   Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

