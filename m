Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BBD4417D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU0tP-0001nx-Qe; Fri, 12 Dec 2025 06:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU0tO-0001nj-2p
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:00:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU0tM-0007dc-Ij
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:00:57 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so453249f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765537255; x=1766142055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dN5n5FvFokaF4H5Q0w6t3jMZM6Wk4SZTSQi6LBa1Atw=;
 b=VZ4ipjqLdXUFeuwyedDk73fbsape80ziTxkMsIofSKEoRW2ng/Bjo8zMPHAE8gx4j1
 pnslBHQMHWTB7Slzu69mKBY7DveW9ijOSZ4YEo28VSPXxC0vlIWNczdhCAsK07YisWiY
 J9bXxGr8n3gVc660a3bxDjCv3Do4QgFOfMRRwJOy4FfL9+Z/HEW3zBYK0FgAEW1aqqhz
 bw0zXdQ1rmfWd5hr9iSB+BxCsQEeILXV7rxXhZih4SP2LN69Wp9Dauo/+1r4qJGBsBxO
 HpkIC+WBkcrdFY29dYbFEfd0kukuQxiJqiOMro72XGqhtMlTpu3meD6i3I+L/eC9BXLS
 Hqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765537255; x=1766142055;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dN5n5FvFokaF4H5Q0w6t3jMZM6Wk4SZTSQi6LBa1Atw=;
 b=IwjVisZme4JgLwcU7Ess2AI6XmYPf/eDMSkcBeQUB/N0sliPLowmUmgdQ+cThtg8th
 WDinD1PoM6o3PDhh5oDdAC7wsM1FYxzKrY9G9KN8CiuINiOjfxnEBT7xzO25CWObZ9a5
 hWpmW8S/p5fVY5aKl6Ea5qWOGR+c1/wS30RhmrzNjXZri65HHW8QzdV1/mX4KMTUM8KZ
 bYUxHVlNngR+o6jZ+xEIW91YsDZRAD397yLKW0FDLLpSf3tKIwgEfub1zkcLCEw7bxvr
 yuK/CvTXI4mkD8g9tkHAxQi1huYyZ7ltKijXzOjRUKAbBXzSocl/IyeUvjq01mqugKec
 TuFQ==
X-Gm-Message-State: AOJu0YzdxoYJYMN3GQ7ZWBgCnBXFf0DAYqcRP1BcFitH4XeGK/5SKCq5
 tFr1O+0nV1sONgYwnV+Fl+dq2cx+lGT5vM02YfWwJyxlGxE8IfxRKEz4X9VVS61Ryxg=
X-Gm-Gg: AY/fxX5heBI+Nsei7QCgGdMm5qiV45A8fTZiaHLSzqUBXoat+B9ouNw0DoyF1afH0P8
 m86aAOAXF+L9bVaFndN9RDTzUodiGyRpMGb9TiuatrYPGLHQ4wM1bprfWFIG4VqqPC7O5txGT3E
 dr92LIzT1X1siGcOlkBPheVK8fzphF9yuZWiMLmY6e3YXJ+qO1XEAQmDBftKHu21d8hOvIhd9lu
 fTVz9CGJeQk18RagQLoll0aD9cM6pjGwXM3dm0Ten7JFyEVKllLnu/9tAgmg5WAstfnYBw7PWTN
 CarTdGCPBhWJltKzw6Zv4ZQAMDeB4pp+ZebBNOrU5LOpfGtXUAw5LK1UlYlkNiRgnDx1SIdjJXA
 QN51BhQ2yq7aZYYILLbQpAHLfHH8ooYHyn64qZTmqui6xd+E97rt/vYvlJkTm64lMJ/CwAzJmUr
 gsR9o1M7V2Isw=
X-Google-Smtp-Source: AGHT+IEQ5T/lZ87VUaoIOFNe1LYpV32cvKSaPH48iUe5N0qstHQOrTlM+8/mS+8SYpGWAFCZ5/SeYA==
X-Received: by 2002:a05:6000:1868:b0:42b:3ab7:b8a3 with SMTP id
 ffacd0b85a97d-42fb44b9797mr1778174f8f.27.1765537254319; 
 Fri, 12 Dec 2025 03:00:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a70379sm12139566f8f.11.2025.12.12.03.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:00:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3CCE5F82E;
 Fri, 12 Dec 2025 11:00:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 2/9] MAINTAINERS: fix libvirt entry
In-Reply-To: <7f479d0e-1370-4574-9966-e373405ddb1f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 12 Dec 2025 07:45:41
 +0100")
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <20251211180132.3186564-3-alex.bennee@linaro.org>
 <7f479d0e-1370-4574-9966-e373405ddb1f@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 11:00:51 +0000
Message-ID: <87tsxwt15o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 11/12/25 19:01, Alex Benn=C3=A9e wrote:
>> We have a particular tag for lists so lets use it.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 05b644cfc9b..a3fdc4ca911 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4466,7 +4466,7 @@ F: gitdm.config
>>   F: contrib/gitdm/*
>>     Incompatible changes
>> -R: devel@lists.libvirt.org
>> +L: devel@lists.libvirt.org
>
> Maybe keep both? See:

It will still cause them to be added to the CC, like all the other L: entri=
es.

>
> commit b02c9bc35a03c099600693d6909f4566078880b8
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Mon Jul 16 09:32:26 2018 +0200
>
>     MAINTAINERS: New section "Incompatible changes", copy libvir-list
>
>     Libvirt developers would like to be copied on patches to qemu-doc
>     appendix "Deprecated features".  Do them the favor.
>
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Message-Id: <20180716073226.21127-3-armbru@redhat.com>
>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>     Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>     Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20eef3cb61c..666e9368126 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2194,6 +2194,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/build-system.txt
>
> +Incompatible changes
> +R: libvir-list@redhat.com
> +F: qemu-deprecated.texi

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

