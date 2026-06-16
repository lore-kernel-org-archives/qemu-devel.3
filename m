Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ED0CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPC1-0003sO-7L; Tue, 16 Jun 2026 04:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPBz-0003pB-92
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:30:43 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPBx-0004n2-PC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:30:43 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6626b5ace23so3911590d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781598640; cv=none;
 d=google.com; s=arc-20240605;
 b=fsfBFjh9xg/NfLhSprGHzSWIhMHnWv5qd5sCctkfBSLRWovwAgntXyQ3vhgs7VkJtn
 t6P++bR6/nLYiLwknIZ6HH89jRZZGq7xvVnqmxSJepURoD1OIPo8GYf4Bf1+tf93xtX/
 PjiYbJrXPOE11E53685j/jJ89MyX1WmGEjrUbYt0w+txGoc8nKfWinG5ueinAWxJDuQc
 l+ELULGbsg0e+SJKRB++X53nrBX4jgoQyFWoVYFCoV2gBomUEYwlypJo+UFlXv5KGNIj
 T+PPddopnBB+Ounl8oSgZqyCwk+m+iCF1zIvuFeYrMN0JnO44LfTh19qmwH0EUSoU6bE
 YY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ipFAUhzjvMHVGdUYRdJgwNu9TuMm8bv+SyOKrpfzJqI=;
 fh=3P9WV+Oqv16eOJ3dAbNAhhRxUBqLtDgHDVg9YpB2Xeo=;
 b=NMOFCBO+i7tUc3ZvJfn3qWNjld1vYhzXH5rsLlOPwkfnTqqxgYlLDNyfYCZQrNdVpP
 8a6VqOsuUfoH/PFbVuYVK/jHgIBI8ip23gjaXLO7DsU2UsD5/uhuua0s5WhxzjUhcGm7
 boGJR4zkj+xkdL17N/1U93Mh+gFtZQ68NmYBxaN/DBzUQ8622ixzzZDTOEX91ayqBr83
 G/J9YAR9KfU4/U91IBhv9XfSgYjSLkovEf78LV1raIc0cfsCX1wZMtNU4lzK8W8yi+XP
 sPsPVRui4BWHUFXfIS6qMaw4JvJ2nSATCRowMwYbTsC/o2afWZD1C7o1fSSmlkurzgOE
 vhcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781598640; x=1782203440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipFAUhzjvMHVGdUYRdJgwNu9TuMm8bv+SyOKrpfzJqI=;
 b=QDFEYXGPVbV3hVlyDKMCXVOSDbtMddWm7uLBieDIVqIMVprgBMqXx+ujHWrXVH6YSM
 W4s+QQD90tKtdcxb+dtmNAnBSTRP7KlhG6llWPKoqw/DfToEgGB9K2S1uCDzU1lQDpQH
 CXUaXIkuJRSFu4+d9WpExXUf4qnYu8EEMlZUg76eGjRlOpIUxGp3gJfx6PobnuiG+TTR
 6FBnoloWzpwLETI0nEL7ceLiSx6uBr13ZRDpz+3zdnubrtrf9NY2YYSDV/eyhHDut1pS
 kP6Xpy5uWGZwqFroBaWTJ1F02uUE6Yi8XG3Ft9bRACrihCpJ3PRy/pLt9DRbFfe+MVmH
 ZmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781598640; x=1782203440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ipFAUhzjvMHVGdUYRdJgwNu9TuMm8bv+SyOKrpfzJqI=;
 b=C0sadIFwNlNRxGQVUKiqu59DpNL3QnDypSiCeC1yTVvY7FPwn+LmfQAxjnNMijvxrM
 NmYQMx9MRNwOtmey3oTlSAeDDcI7fax5JO+KNKfBcq8oDmychqsKYfmnm+fy9+Ne6pOa
 k+2dhlvU6gFceObSTQRZPNHBL9gNr0GuOtUkNd7DEPjDAelznsRuIemzWV7AwgPozePy
 v210X511dthPv33Su5lYTOKnuRZut+YzlLV7dIqt5k2loMz1HOboLvd8/ks26E+O3fLX
 9lQBOH5zAoKLQkXdMPdxtRO9c7zybEZ1vao+ZqFLFO8zfTlfSNx/Ol/675EGbIUje+tz
 fVbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XN13v7CtNtx+hLMcs65qybn0HjHe/NEVbn+zf95JgGdjW3VnMdJbh6piT/LZsyOacQax07Djoij2I@nongnu.org
X-Gm-Message-State: AOJu0YxcV5FP+TihTE2CfKpVjqkkeDiSrV0q8dDA55dxPS4SyCGHCDve
 9c24ZR2n4uftsrtd6mKKJ57fvLAgLGvozlE5jwz/bsQkAzz/dM7gVnOuln8qGylBUTknOPrA3oi
 Y8nvgNj3Gn6PSSObKhK9vUQsYtFZ1bDcOgJdbkuX0ag==
X-Gm-Gg: Acq92OEXvfV2VbOxZchELSEavORP8N7fUfGcUHqOt8M/XUEhP3djQvJAtGWpO4KOxQ0
 zUfSdDOorTugeaDablJm6rT4RJB/2ZsMSuL02DB8B69YKRW8mKwk1lPcTsT3O5fGEDaQEe9CN8j
 ITkFNXaReQtRMAEhfaeDFQ+OQAzL3zpXQ7d/sv84fACQTTAOB39vB3JyCW/NqMAu8Ke1xAw3Xq0
 zQVRM7QZdmYUWR5kxanSu3pDsQYUYcojaTpPvnn5U9pjQcDtnokDMkbS6jxfzjmKe5MEnSXZly1
 5lCFMesKXk4nCMobJcLXReG3DpCq1MFk5Xvh/Gb7i5Ij75XDubxmJCvVrGqkJdjWExg=
X-Received: by 2002:a05:690e:2551:b0:65e:b380:b6c5 with SMTP id
 956f58d0204a3-662b4a0443cmr1685685d50.21.1781598640103; Tue, 16 Jun 2026
 01:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <ajEA4CybcZHwYEEF@redhat.com>
In-Reply-To: <ajEA4CybcZHwYEEF@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:30:28 +0100
X-Gm-Features: AVVi8CfY2uKxoxt1rtg1ZZ0nD74Ahl3ygbRtVC18IkZfkJlbqVAyJx97HWcAaiM
Message-ID: <CAFEAcA_r2+S+iy4nu4Kv9Gjwsu_izq5iHUYs6vycq=dX-+Cpsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, 
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 16 Jun 2026 at 08:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jun 15, 2026 at 01:17:23PM -0700, Pierrick Bouvier wrote:
> > We add a new script: scripts/check-maintainers-file.py, that will run a=
t
> > configuration time (and not at build time), to not hurt build time.
> > This script runs in 0.2s on my dev VM, which has an old cpu.
> >
> > We can expect things to be mostly in sync since adding or removing a
> > source or test file will trigger a configure step.
> > For the rest, like docs, tcg tests, or remaining files, GitLab CI will
> > build things from scratch and always run the configure step.
> >
> > With this, it should be impossible by design to have an upstream
> > MAINTAINERS file with non existing file entries.
>
> Accuracy of the MAINTAINERS file is an upstream-only concern, but
> IIUC, this check is going to apply universally to every build of
> QEMU which is undesirable. It is irrelevant to end users and not
> appropriate to check in downsteam vendors forks.
>
> In a "normal" modern project this kind of check would be done in
> a CI job on the merge request, since that's the only place it is
> relevant. In our case, the nearest fit is the checkpatch.pl file.

You could put it in "make check", or (if you want to avoid the
downstream-forks issue) in some sub-bit of "make check"
that we don't check by default but do check in one of our CI jobs.

checkpatch isn't a great place for checks that you want to
stay consistent on because so much of its output is "this
is wrong/merely something to check, ignore".

-- PMM

