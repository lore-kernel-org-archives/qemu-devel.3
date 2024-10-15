Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E36CFC273
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0cc0-0002wR-MX; Tue, 15 Oct 2024 04:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0cbz-0002jk-Fa
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:08:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0cbx-0002NV-0O
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:08:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4311bb9d4beso33667355e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728979735; x=1729584535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUtD7kU+ZtH/ohs2DQUCU9xQr55ytexnezZMYgRtEBI=;
 b=kf9yR6glV0QyHP4tBmDMNy2o+vOyrU3a4MrXKuUyM26ixc77ZamxVbxYle0VPO4QQn
 oQm31j43WAwh3JOP3apm70ZLtrHqnB2x+B8bs0KlzwrTEPn232pSqEwDDLXoAH5BjzMx
 J6+sK9GymMhtBMSkHYRHQ9xkaQLR/AQZj9EANizznoPE5euznIZ3lxK6vmxjHbkFoaWu
 kThxc19eVMztaibzd9J+/vAXRLUwixO9tVRXGmzKL2QizXViQXnGEGIBUnf9dMN9C0Yg
 a+g9HBDbTPpX2SQ5fVgwvc0ksUNn0C/LTLw18PdRmk58SqsbW5I+THBmVvNtdsvLt/2c
 1ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728979735; x=1729584535;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oUtD7kU+ZtH/ohs2DQUCU9xQr55ytexnezZMYgRtEBI=;
 b=nbHACzVEu8otXNwzxeUx61GC7CxMoSco943AVEpxwYP1IZhKgSv/+KgMOzr7vhEImc
 4TbuomMr2OdBdbdVi9d4qFxLydN73jnnZjnIdiXFEBz2TF7qJMql4SY3SnSmgvpqlSR/
 HSJp8WjoDJtNlcMGi3a6QPx292O90gF0kOUNYVacn+KwmG+gRs+OBBU8GPv9Dly1e5Vj
 REht9xvGAbNngPIYnVdlIZACEi/vJ/xZSX4+4DNb1i+wNRNRtEclkYaip4iXutY0bTdN
 S+ZBKz8696HvKwjClebb3TJuSqRiM9+yR9gqH776eYRm1SdS9uu+uzmyJ3QxeePdYKrg
 n2lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbk0J+nU17R+VLmuuiYpVYJLSdes7jfgIuTDboafbibtszctr/GHO8hsm2EZ5hu3Ij4J77kIgN2rof@nongnu.org
X-Gm-Message-State: AOJu0YzHYqn19/F9WNMVTO+kMAu19CPkOct81KtqcoByDFggFo65wC0W
 68yQHQ2cKljlsbMHaEloT+HWOjZEkk6PZ09TdmTbGb8Vp1Z6OMx0qvW8VEWI9f4=
X-Google-Smtp-Source: AGHT+IGSEpD8hGVmUhNErQXIbYOe6OexxGi5P5ucTKbmtDALY0nmRF75s8cOc/ApMjIVHy55XFlcOQ==
X-Received: by 2002:a05:600c:a10:b0:42c:af06:71b with SMTP id
 5b1f17b1804b1-4312560998bmr101178985e9.28.1728979734882; 
 Tue, 15 Oct 2024 01:08:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c767csm10047285e9.48.2024.10.15.01.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 01:08:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 903AC5F753;
 Tue, 15 Oct 2024 09:08:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] ui/console-vc: Silence warning about sprintf() on OpenBSD
In-Reply-To: <67e2cb19-8de6-4ebf-ab4f-ae13b3de134d@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 14 Oct 2024 22:50:44 +0300")
References: <20241014151023.85698-1-thuth@redhat.com>
 <Zw01n0A6xCG9mCm-@redhat.com>
 <67e2cb19-8de6-4ebf-ab4f-ae13b3de134d@tls.msk.ru>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 15 Oct 2024 09:08:53 +0100
Message-ID: <87ttddaiui.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 14.10.2024 18:15, Daniel P. Berrang=C3=A9 wrote:
>
>> These two lines are the only place in the code that uses the
>>     char response[40];
>> so even better than switching to snprintf, how about just taking
>> buffer size out of the picture:
>>    g_autofree *response =3D
>>        g_strdup_printf("\033[%d;%dR",
>>                        (s->y_base + s->y) % s->total_height + 1,
>>                        s->x + 1);
>>    vc_respond_str(vc, response);
>
> What's the reason to perform memory allocation in trivial places
> like this?  If we're worrying about possible buffer size issue,
> maybe asprintf() is a better alternative for such small things?
> Fragmenting heap memory for no reason seems too much overkill.
> But I'm old-scool, so.. :)

I doubt the allocate/free pair will cause much fragmentation but it
doesn't look like we are in any hot path here. Anyway snprintf is
certainly better than sprintf so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

