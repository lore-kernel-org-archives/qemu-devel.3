Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB0ACF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCmL-0000zd-Lu; Mon, 30 Sep 2024 05:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svCm9-00006K-9G
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:33:12 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svCm5-0007OJ-7q
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:33:02 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d29b7edc2so586176866b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727688778; x=1728293578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIQ5oy6F0LgxLI7PQPhdHvHZLISU/dLKj0n+QWStUjw=;
 b=pImUMimVu83/iQTdnIa3tR69Le102HCW0SygWLd8eynbr/WlAkHxLGerqiKrr6qmw/
 CpnTX3NEUxBH5cqMRVa6Y0431DMwcvAMF5hNoXbfd3WJE16b+8aXTj+9qk3QuaOHsLHC
 81ivjUHYLy5sZ/DeX3m8sPSDyaL6Togc9tBbHvUzH9Fr4jj6kqjK1WPN56O6kf6LZ4UO
 xBweXl4+ZCJd3yBAMofAq9WfibRh/ekTEWFXaJQPzTZ7GPw0sMpSMCW1Qn9W3tDHj/ct
 XUL5lbrU4guA4T7zS/oWEkyi57vRafsRfoVeW5Ll9jwlmgHp0UenQrzScKCy/EGUeiXL
 1+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727688778; x=1728293578;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SIQ5oy6F0LgxLI7PQPhdHvHZLISU/dLKj0n+QWStUjw=;
 b=ReviM37JDkcvRZUVSsqOB48qBS9UtY51urcsmaAESWyuoaTiSd07ZdkwAwLNX/JzWl
 o55HRAZx9UvxajvG7UxHHWieLax613ZDSUeoKAEwOa7Pd5oL2An1B2zZmxpminRC+eMh
 B7hmdYJJgSFEFOkxT9DqK5v7vkyaL55JmDsBjffM+P0XnWe0HeT7KXNd89oqZjMh0CP9
 4EeBw2ygcAdKj4vS6z5LarPUPFuMhdZ9+S1QTnafhMO3yA7lwzidk+X0wWpyemfu+mMv
 LxPpa3dPpVRY235n3HRsrFNkXwAs6FgdXzBiuFkcbGlyGsVIkMhNVhUayV8TbJCRTZx4
 K6eg==
X-Gm-Message-State: AOJu0Yz0A9ZZUu3ehdPn9J2/4Tiz9L1BS0kccaQDX7USfEyg/RAUU0d5
 qmlctPu77Q0SwhcXU1zdLNNLyA8aeKFCE647iC62XJ60wE898lc4D0/1Wl7pirg=
X-Google-Smtp-Source: AGHT+IHUhlVWNtN/w1WwPKrmVQZHaP7RTUXtvsmLiyFI/PHmI3L3gOtOvGILAIAkiwywdcJZXCTn0w==
X-Received: by 2002:a17:907:6d12:b0:a77:b4e3:4fca with SMTP id
 a640c23a62f3a-a93c48f711amr1288165866b.9.1727688777629; 
 Mon, 30 Sep 2024 02:32:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2997d20sm499296266b.196.2024.09.30.02.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 02:32:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2AD515F7CB;
 Mon, 30 Sep 2024 10:32:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] testing: bump mips64el cross to bookworm and allow to fail
In-Reply-To: <a3644805-e4ba-4cfb-a429-0604d7282f06@redhat.com> (Thomas Huth's
 message of "Wed, 25 Sep 2024 13:17:10 +0200")
References: <20240923081537.3846145-1-alex.bennee@linaro.org>
 <a3644805-e4ba-4cfb-a429-0604d7282f06@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 30 Sep 2024 10:32:56 +0100
Message-ID: <874j5xpjuf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 23/09/2024 10.15, Alex Benn=C3=A9e wrote:
>> The mips64el cross setup is very broken for bullseye which has now
>> entered LTS support so is unlikely to be fixed. While we still can't
>> build the container for bookworm due to a single missing dependency
>> that will hopefully get fixed in due course. For the sake of keeping
>> the CI green we mark it as allow_fail for the time being.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Michael Tokarev <mjt@tls.msk.ru>
>> ---
> ...
>> @@ -143,6 +140,7 @@ RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
>>                         libvdeplug-dev:mips64el \
>>                         libvirglrenderer-dev:mips64el \
>>                         libvte-2.91-dev:mips64el \
>> +                      libxdp-dev:mips64el \
>>                         libzstd-dev:mips64el \
>>                         nettle-dev:mips64el \
>>                         systemtap-sdt-dev:mips64el \
>
> We could also do a temporary manual hack and remove the problematic
> packages from the list that cause the failure. I guess removing
> libdrm-dev:mips64el , libgtk-3-dev:mips64el and the SDL2 packages
> might help to avoid that the mesa stuff gets installed (which causes
> the trouble)...
> Of course this will be overwritten the next time someone runs lcitool
> again, but with a little bit of luck, Debian already got fixed at that
> point in time. What do you think?

I was hoping the blockage would get cleared by now but I guess not. If
the distros no longer have enough eyeballs to care about mips64el and we
have it as Odd Fixes then I think the allow_fail approach allows us to
move forward without manual hacks.

If the CI runs and is green great, if not it doesn't hold anything up.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

