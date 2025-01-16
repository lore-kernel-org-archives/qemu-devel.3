Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FAEC02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSNK-0006rg-Mt; Thu, 16 Jan 2025 11:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSNG-0006Qo-25
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:05:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSND-0002Dh-RG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:05:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso10628595e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043534; x=1737648334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clmllYa+nRr/hyjMg5CwxULmBgBXRMfF/BdvP+sMGu0=;
 b=JVK8m8p9hsYjV9a7/1m7OI7ffpGSo1r88g6ThP1aK87k+qqs50hAueOwonKqEPaG71
 H5j3Hx2fWfrYWUQcwAyI845tywkbQMyPSJrzHqVcBHGe33bmAZP9wBWfhSBsDEi5adkQ
 hIe2rdfaoflMXWga6Esk5K5fsNnMe/farke+I010q4yRmPzbQcZc3DraqTveW8tz6E6Z
 nzN4WxRTnMNK8Y9AJzh3hElS55qddl/IziNI09GoEyrfnjuehWVuVeFHWA5pWDBPhZm+
 7XUxHMYN4WOVX09H/uo6BgKFA2Nq9Ci/xt5Y2Hpt0z5G6qC0Fi/4mvnhYMZmPNeKtyzK
 k9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043534; x=1737648334;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clmllYa+nRr/hyjMg5CwxULmBgBXRMfF/BdvP+sMGu0=;
 b=nOUzx6XyapW6/qjHOOtOsASV5oALrzZ5uE/kyOiOulQm7k8JyVmmqrNTnp3hsAqypA
 oNgTS4GWumB0/MluPmVif5oTuruqhk016UysECHg7AluZdF3Rjf9zc3Ydfq8qTrRHl0f
 66mkqTF/Rsv2/OOEPowT62g4mNbuR+RT43EO0NVbAaIjf6tk7YNdD5Ljob4z74EXDNAV
 oo5m8F6vhqu1mox7qme1c6t63P6WgAnZ8vaFIhSlefnmtSYtPDMUKS1dteXNxfj49k/c
 k4WFrLsS/bDo5EdBGKfNYlkyaqCti5dTP16IucCxzYO9/QcUNCKQvlNUxvIC/ITy/myJ
 UZew==
X-Gm-Message-State: AOJu0YyN3sdrRR3MKuxp//dVr6mulqobp7UrHSmr9QHgzqJFNDAOeOri
 KB0v6lGFSnaZS2n17GA2NGzJkwtM6dBqzkQPGIr4GJFL018oI2kY0MMQifojpGo=
X-Gm-Gg: ASbGncsn5ljfA/hwrkKGbRSeVUgNC7DFeKivuXoDlnBKOLhRHBWLl1iqUUGXPdCU6IT
 eGSdCVnC/zu2kNCuw+PffhpVDplUHllkchEx5U/fVT5MOGqYkK1FxDIMavq9cDtBe3JFKofrLmX
 iW2JkSjIZO8h3bWiOqPuqiTqoEF9Aj+mxljOGP6Po7pSfgMob4sWM0qgN7p8AeNcoDlxziaM8Qo
 HruAxut5UYilv0PiT2fS27VZ5XwjK7e+IxbufSmoJzWI6Qm6n7gkDs=
X-Google-Smtp-Source: AGHT+IEWu5qZw4Hwv8VnNmWIl2PBGRc48G8yYdbsnFRENUOKVJ7kbIs3K4cB6RaT75Q+z7BrXdV9NQ==
X-Received: by 2002:a05:600c:4455:b0:434:f623:a004 with SMTP id
 5b1f17b1804b1-436e26adfd8mr21728845e9.16.1737043534001; 
 Thu, 16 Jan 2025 08:05:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c6179sm63700505e9.22.2025.01.16.08.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:05:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4EA660853;
 Thu, 16 Jan 2025 16:05:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Yuri
 Benditovich <yuri.benditovich@daynix.com>,  Jason Wang
 <jasowang@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Peter Xu <peterx@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,  Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Laurent
 Vivier <laurent@vivier.eu>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  John Snow <jsnow@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Laurent Vivier
 <lvivier@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 00/37] maintainer updates for jan '25 (semihosting,
 gdb, plugins, docs) pre-PR-FINAL
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 16 Jan 2025 16:02:29 +0000")
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 16 Jan 2025 16:05:31 +0000
Message-ID: <87ldvahhh0.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Only a few changes from v2, sending out to cut a PR tomorrow
>
>   - applied r-b tags
>   - fixed bsd-user gdbserver_start
>   - a few minor tweaks to commit messages
>
<snip>
> Most are already reviewed, the following remain:
>
>   docs/sphinx: include kernel-doc script as a dependency
>   include/exec: fix some copy and paste errors in kdoc
>   tests/qtest: fix some copy and paste errors in kdoc
>   editorconfig: update for perl scripts
>   plugins: fix kdoc annotation

Ignore this part, all 37 patches reviewed

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

