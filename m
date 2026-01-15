Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549ACD44C73
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQRw-0003Uu-Bf; Thu, 15 Jan 2026 11:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgQRu-0003Ri-FH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:43:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgQRs-0001jM-2T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:43:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so986504f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768495430; x=1769100230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/5F67crpwhGUIaSgemYTAQqay02sgYsdy0cnOA/2UU=;
 b=ZBI3QjG6GYCjNwK3lCY3CQXW3YEezROo5vQv+S/3udxPNx09Cf2jqVgTKZt6BVLcQx
 XoadTAbxXr3v/ZMYuVESCrB+JxmvRHksJP+keMgiLlsIAZyT6NdKzpxg7sGdcRI8aa5H
 yxb/krcrdGRbAKPIbn6YD+Qt7//AIcEXlZvpRNLR4Rje5PJ3je9byKLAeA6CIHmL5/pq
 zJJ2Fx2vJ5WfPA+OKr3nXZy6NoxotspJGrpfI42up2jT+98DlR3ZEu7F9tM0I7ubqgeM
 gDKgY6XbtJfcURcdjkcgHm3tD3Z9q/aIw5XnIR4dMvroCK+qpK+/lZUoRSVC1C952ASB
 e2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495430; x=1769100230;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/5F67crpwhGUIaSgemYTAQqay02sgYsdy0cnOA/2UU=;
 b=OAuXwZfzu8UJhrILpKVCMNcWQeMlUfcZyrzu/3y2Dng+s4xfnUtgwjUCVkrWVXbYxk
 ZIYK6kny2VGtWEtg2NnnfMsGtC1zqZmdHEGjng/LqRleS2WqdLhtAazzMMAHaCaJ3nFp
 zULvfeWRPUM03h1MyakOKop0FxzNKmNxcuszlDwmXb/QPQ9XChEYPC4OGt1WQ673EZ4N
 X36w+yYFJF90BTAgef99EHblZaKw28Nbj9EBwlRXg5AqTQlg3aGI6WGfE8VkY1sNEyE4
 kIE7iWzf8SsQYKwHg0b8flLqSWBL71Ng6iAPxGgSFlOgiGGsEEGducByuCxWJ8UWKkah
 LSFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFuC3I/A/5qMxxZ/TeVTUZx/BmzDNPrsnls7aUdIOApujwQCkeAPb7v3pm5QePX337JyiKYKYGxbaP@nongnu.org
X-Gm-Message-State: AOJu0YyPRalLC1ZvYnH0DF9YGPtyQwxExM5c0z8ea6WEB6Wt6tt8dsia
 sqq5zsnXcJODz3HwYlh9w96dKTU7QhbfrBRIbi973nPlvP8CUq127gx6zA3hOjQLvLM=
X-Gm-Gg: AY/fxX7Y5/ydtQ+bEpiNzzRC2hJyPOs9q2iR/aLjyzKYlff9ilp6gPLVd81JCNVGnan
 cZ0adx5/+Cmm1yAocctK6EWQTQz6jSDC61bZnOUVoA+eNYkTghDI3oxxGriMlp9YfCvLK1tjV92
 96buBRSp/zWpmI7HHSGnUj1SMfAz8ayIEE3cXzJAA7DeArs/qQwzBNN/xtA8OaLlQ0ANPkOyvVN
 WkGsbZp/CmLmVrW1ZjRK5AMM+BjT1PTllhSQWPleqThSk56+b/xNe24+UKi2AmdENLFf9hACuXh
 1glsxpRQPXgd3Vi1b1NaUSPQi196ICoNGqLbasx3K2mZhbb7EgmXk48iMEc+aWCMxMaxKYgGDS0
 v4v7R2DM9xZ+oRZbhSNHxOJvsu6Q69BegTjepByxFRQtGEXv35XXCET/igPkli/FPw03aNI6ltS
 ck8ZyFPo2+M+U=
X-Received: by 2002:a05:6000:4283:b0:430:ff81:296c with SMTP id
 ffacd0b85a97d-4342c54ab86mr8256220f8f.34.1768495429997; 
 Thu, 15 Jan 2026 08:43:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6fc7e0sm7012220f8f.41.2026.01.15.08.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 08:43:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8382C5F88E;
 Thu, 15 Jan 2026 16:43:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Reinoud Zandijk <reinoud@NetBSD.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ryo ONODERA <ryoon@netbsd.org>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
In-Reply-To: <87a4yfxgm9.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 15 Jan 2026 12:25:18 +0100")
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org>
 <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
 <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
 <aWjBiwjKpfmnaBSe@gorilla.13thmonkey.org>
 <87a4yfxgm9.fsf@pond.sub.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 16:43:48 +0000
Message-ID: <87sec6hlmj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> Reinoud Zandijk <reinoud@NetBSD.org> writes:
>
>> On Wed, Jan 14, 2026 at 01:17:20PM +0100, Paolo Bonzini wrote:
>>> On 1/14/26 12:28, Reinoud Zandijk wrote:
>
> [...]
>
>>> We're not asking you to keep CI up-to-date (which Thomas is doing now,
>>> despite having no specific need that I know of to support NetBSD), just=
 to
>>> *report* failure to build from source and tell us "hey, that's how we f=
ixed
>>> it".  Otherwise we have the false impression that no one even cares abo=
ut
>>> new QEMU on NetBSD.
>>
>> As pkgsrc normally tracks releases and has a directory with local patche=
s on
>> top of that, build errors only show up when we bump the version. Version=
 10.2
>> is now in pkgsrc though I am running 10.1.3 so there is surely interest =
in
>> keeping it running. I could try to commit some more trivial patches in t=
he
>> repo here to reduce the diffs some more.
>
> Fixing the build long after it broke is less than ideal.  What would it
> take to get NetBSD covered in CI?

We have the ability to run tests via the vm-build:

  make vm-build-netbsd

however to take full advantage that needs a runner with a reasonable
amount of memory and access to KVM so it can run reasonably fast. Does
anyone want to host a dedicated x86_64 custom runner?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

