Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166EBC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1RDk-00054k-Jh; Tue, 01 Sep 2026 12:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1RDi-00054b-1L
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:20:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1RDg-0005mF-1S
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:20:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495590dde14so50364865e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788279618; x=1788884418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ephyY1eI9SteQSV7EWRsttTS0JX6QIhioumwXSG2CUM=;
 b=RTpaFgaVmagQwfbd/1TDSAo+TVAgid1SFUfo9NuRu3kn2jtuirs/Zeh0iAj/pHwEdg
 FKBeO9cCuG1GqnF+p97ZLVx/MKbJqmKflPNfGP3bX5AM6/2EbynhcKCcuquQUM2pve4l
 EQGTJe5MMfgXU4L1DLTYM3atXA4Y0xl7v4liyBOhKn4R5lyzNQDhRdx0/0dEjdPAhz9D
 KqJ4VmRRINLeX5fEAq4fssIvLLdCvZxZeeKZQu6sH83pr5dV25Fh4XkLJfFxhTmZJsCf
 2zVpv6RDkJJaSFA66iuQ23/nSzJp+CtmILXigDyU3QsnJSsnS0nRjLYMMyinTEMFKg28
 EqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279618; x=1788884418;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ephyY1eI9SteQSV7EWRsttTS0JX6QIhioumwXSG2CUM=;
 b=Yo9gIvEUAoRvnrZLqlI2u07t1UddXviUDMP629W7IHWNMiLXbpG7I3BDPju0rk6joB
 Q3lrsPrdOo7XMMEU0kvk/YNLEl4ytthDSjZUZ/Gpc5kAYVLkp9mgc2b0yEuxFFQENPFS
 QD3702m4Wd57/59eo3jcK72mtUqxXM7nRz8XPcazW3mrkv/l6WMAZjxrGht8h5LhcQzn
 aQhZZvx7BVrLZHTYJ0flQmaEbpcrBt4M+AP7c5SPi0DrZbQaoLPWHkWiSLXAFdwyouTV
 pCTPYXiCo/Dt3XM/U+RQqfxnfts00T/hxCXzgvhBN03L1wuyl6OPhPTN4w/5sKdRI56X
 3RNg==
X-Gm-Message-State: AFuF++mUzaJwusCQFvLwGuxiD033NRsGTufP5BMRRzvIGRmIKmmYoghp
 m0qpxYiSHBIHD7Aun1n0jp29kCHY8zYxEm3IADIiE+dsPU5gutOrKDKo9LIajS2LiN0=
X-Gm-Gg: AR+sD111C2xhM9aEp24ERaJypD2GnDV/KnfSbiCrLU4mj0OHPFg1RvhX5fGr5v5YBBR
 pkQMOYtSXA7B9/lFXF4RgH1s/DylnpvR6N9rMFNrmDys3t0NJ2F/C/K2LWc7KnMK3G8ESVuySC7
 JJhLaa7JDH8RfxbQqQ4gBmfFTIiplweH33EJ5lryc8mM7IhcZwAb7TxlOMTH5U8viTYjFJqifJv
 QQHoAOOhvwlWjrAZNTqq53hrpzU/U/yOoO+wIN5Eb2onT21acV2j84eDPhgLPy9X/X8zQ5Q62+L
 wRVdyqHvOjSBudEfFfkqLfbNbq8ewps78VG1880xc84HkO9Y090QV6f+RcUaNRf4+3yTEBrpr/m
 J2Xmxo22XZeKpCrKbCbeBDBQVjwEpns114CBsJfBna9dxExTI6M+LRihkKlOagzLkqcxnJoFGc+
 8y+kiYdu4JQ15sTRsQNHLaA1BKv6ZWWhllvw51GCbCszNxEScCzJdlL0mV5IqO
X-Received: by 2002:a05:600c:3492:b0:49b:909e:922e with SMTP id
 5b1f17b1804b1-49cdc4523d5mr191623345e9.10.1788279617883; 
 Tue, 01 Sep 2026 09:20:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1025asm76481695e9.6.2026.09.01.09.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:20:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40CF25F829;
 Tue, 01 Sep 2026 17:20:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] gitlab: use --emacs --quiet for checkpatch.pl instead
 of --terse
In-Reply-To: <20260901154741.1488763-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 1 Sep 2026 16:47:41 +0100")
References: <20260901154741.1488763-1-berrange@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 17:20:15 +0100
Message-ID: <8733vtueo0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The default checkpatch.pl output includes a lot of "progress"
> information...
>
>    NN/MM Checking commit HASH (SUBJECT)
>    total: 0 errors, 0 warnings, 105 lines checked
>
> for large patch series, this results in alot of noise from
> clean patches (which are the common case), obscuring the
> info about the patch violations.
>
> Since the alerts from gitlab job failures only include the
> last few lines of log output, we want the checkpatch.pl
> output to be highly relevant to the failure.
>
> We previously addressed that by adding use of the --terse
> flag in 7025111a199b97ae806817788bec50f456c47d85, but that
> made the output a bit too terse. It no longer prints the
> offending line of code, so understanding the CI job failure
> now requires manually re-running checkpatch.pl locally.
>
> Using the '--quiet' flag gets rid of the "Check commit HASH.."
> messages which create noise, while adding '--emacs' causes
> the WARNING/ERROR message lines to include the commit hash.
>
> This is a more useful tradeoff for the CI job logs. The
> output is limited to only patches which include code
> violations, while still including the offending lines of
> code in the output.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/check-patch.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
> index be13e6f77d..45be77295d 100755
> --- a/.gitlab-ci.d/check-patch.py
> +++ b/.gitlab-ci.d/check-patch.py
> @@ -46,7 +46,11 @@
>=20=20
>  print("\nChecking all commits since %s...\n" % ancestor, flush=3DTrue)
>=20=20
> -ret =3D subprocess.run(["scripts/checkpatch.pl", "--terse", ancestor + "=
..."])
> +# We don't want "noise" for clean patches, but do want to see
> +# the full commit hash for each violation, along with the
> +# offending patch content
> +ret =3D subprocess.run(["scripts/checkpatch.pl", "--emacs", "--quiet",
> +                      ancestor + "..."])
>=20=20
>  if ret.returncode !=3D 0:
>      print("    =E2=9D=8C FAIL one or more commits failed scripts/checkpa=
tch.pl")

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

