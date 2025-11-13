Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F092CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVQR-0004Vq-SH; Thu, 13 Nov 2025 06:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJVQK-0004T2-IX
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:23:33 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJVQI-0004cO-45
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:23:32 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso1198081a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763033008; x=1763637808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05+zH1ssvO1O4l7BTDYVnannDY+o1C5rvot8EEaz3Yo=;
 b=Dr614GvY4z9Lkvn9mxbuKo3SOvZOTz8Kk8oSYuThB/Z3tfkrhwHICJlZRrnFrhQZZz
 YaUy3D1fxQsakoKawwa61bjTIEzFdWzL1oVouqdQA8xkDJqeCc4UTRolLH5E1FjLvOM+
 Rg8GrXk5qFeWh+uJRJvRsXrfsS1bPDnmIQT17sQnGUYXirdd3lDxHi887U05NPDDGUkJ
 3+p6KlrMIUEqayF6RJha9+mzGdliTo6+wCxSuwDRjD9zDiXHUSv2xZGlPwuaouIqNn1M
 +k6Sm1c0E4cEkgeYzXzzq9Gvy4e6Kg0lB8iBpky8S5p2r2Cmwfo1oGlQydLGNdSYXz3k
 6Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033008; x=1763637808;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05+zH1ssvO1O4l7BTDYVnannDY+o1C5rvot8EEaz3Yo=;
 b=QYIIhgAC2g9+PF9rS1XJoM5VaH+g+z+I3RxHonMyEEgNsccfVSHssrjhvRoGUkSn2e
 fwOkrtU7Ju5ywhZ+n+qaJVL6B/L1Mxk8P9oZSbMMMLilpp/PIHzh8uE7wF1ECCGUdRfo
 SZoH2gz/WsItyxMs9VtFzG9FH24Jzl86OBLt+Vh2HJy9r0YvDfFuOvyg4JJE7b/7zeA8
 LHKMZny0m/JTaCVI8XPyKZxIY35ce5rsY9fk0ADDe+/vbypTjmIVz5/osrHB51UecIOQ
 sqf5b8kcFINDzSoL6CDydB1Ja0IYzuDY9JWyIQIdD44PGcqfYjw8qGADpE470ljmhsyg
 hDLA==
X-Gm-Message-State: AOJu0YzXzkt22fuDUNbY7leZ+6mqkLoV7dHZzRjuOP2rgDFDXBkHqKLR
 GCBEcgVW7/7hBFbBvr3nwMlQvwOT0lQg5UQG5cC0Yh8dTZidL2hGQtNajAnD4I85ykI=
X-Gm-Gg: ASbGncsdez1gPIEbZozU9rnFN3KoR10VSR5CErJqsjai/xW/t3LFTZsvQwHWCxGfGmq
 mp4SkefPv2ZLKEPIA5TA1mXZ3ZaWgaW5kNmBnX4C2ADqp0NeN/D0zT4p2Djk0bf6vGpR9DjOLz7
 vGdT97Kj2CSOhfDofG+cEwBvFrzQHTWYEjxTkR4Hc3xUJDrHeHeGGtjQigZWALcO1il9V+dBoPa
 EUAs1RWkx1VQ2mweGJX1ZA6asDlZ/x3mNSeBkf4FGIxip2BRNp2Vc1sZFMFLykktlwakv2ppSep
 NUANtAMOXvuc3o0u6rhb4ZKQx/STYgNNxpeKy2L737KLSDa26nT9tz40QqFqpB3eXwWx65K3eG2
 zn0uJ3mO/Enr1r2lI0VkqK6VjaCPBAL+PJaYzN1MDvqmavle4xZ/BQG/dacXLox7sz50MYIrjJG
 +Y
X-Google-Smtp-Source: AGHT+IE04ouxLenDvyOPogzW4nms9jL+EK9ReRY5a/mJUvi+wvjHLtUoazaftmhOloSdVpb0Yxa95A==
X-Received: by 2002:a05:6402:d0d:b0:640:9bed:85a5 with SMTP id
 4fb4d7f45d1cf-64334c9c502mr2497740a12.8.1763033007631; 
 Thu, 13 Nov 2025 03:23:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a3f8e6dsm1240934a12.10.2025.11.13.03.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:23:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E5855F7DF;
 Thu, 13 Nov 2025 11:23:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paul Durrant <paul@xen.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,  Li-Wen Hsu <lwhsu@freebsd.org>,  David Woodhouse
 <dwmw2@infradead.org>,  Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH v2 02/18] libvirt-ci: bump libvirt-ci to latest version
In-Reply-To: <aRW0Lflm37zIrpZT@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 13 Nov 2025 10:34:21 +0000")
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
 <20251113102525.1255370-3-alex.bennee@linaro.org>
 <aRW0Lflm37zIrpZT@redhat.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Thu, 13 Nov 2025 11:23:26 +0000
Message-ID: <87cy5mqiq9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Nov 13, 2025 at 10:25:08AM +0000, Alex Benn=C3=A9e wrote:
>> We will need the latest version to add coreutils in the next commit.
>> As libvirt has updated the handling of ENV variables this brings a
>> little bit of churn to the docker images.
>>=20
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> I think 1 r-b is sufficient :-)  One of the later patches has
> the same accident.

Hmm I wander if that was b4 or my old emacs tooling getting confused.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

