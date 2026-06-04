Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846A4CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4wK-00038u-TU; Thu, 04 Jun 2026 06:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wV4wG-000354-N7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:04:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wV4wC-0008OL-Fa
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:04:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso279830f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780567467; x=1781172267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pcyfwWAQ195fcsoV5aCRWDTgnIrAgj+fIth5172GJ8=;
 b=SzMON1EueFhiqoRtXPNRfD4km2pnfPkGPp17Q36SkxFDVcltt7KF8tq3VXU/QzKn8a
 c32bhNCjr0lGvPeOFGnqWLai+6J4BMhjeIH0QYRQvDTC80Ieq8QWFrm9dUeYCx6k6LSv
 rtWOuegVaLwBLbWy/3weklY5fi0a0kMewT0ZE3WxlzEP55Ux9ERwAERp/WVLnJ73oYeT
 K3EyQ097k95eELA7wZTvt4Lkv6fXtOAm9PBe+CabBkWE4iuT6Yu0wnWKKMeaKt105xQq
 QNGLAlDHgJ64mZdmDX+TxcMBxaZM4YCzCv5ZhD7zgelAEzumPOa2yaRspxs70QQ2Chbo
 npGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567467; x=1781172267;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pcyfwWAQ195fcsoV5aCRWDTgnIrAgj+fIth5172GJ8=;
 b=KimlxhIA3DBycH1b+OcOBTu3WtaWT2PxXLyGwLoS9QI9SZQ/AyDYdU2ms94a5K5pkf
 od0M0PLkCvbEVG/EdutNAHXonLb1F9jZ8M9jbcqC1ex7f0HunABo/rS1V2ZtHD7IOko0
 ApzZDRhH87MWBKuV69MfvGvqdubfat77R9OtkDjmPPpE5PmIG9+z9W57HEF9hxCkzHcm
 jQq7CQukNLBeHXzMp4HP3X89lDmnog4G8gKvphiLGPcuZs+hpThs4ufD/9sbe0eZXNiu
 m8ZVCj7GW9t34OmyFGoVso16CnWG/w373sHrB9edil2XzRi/hOc47/jeYkuTMuLpwmDJ
 d7tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8S8F7CKINFv4gvx1al6FM1a8f6pKYVduqTO+Su2qWBsz7O+L0SPcasSkcS2oMlHBfHEHh4mi4uz6fs@nongnu.org
X-Gm-Message-State: AOJu0Yxy1l8n7o9oN4NcAX+JpuEG3BQcGPGhiEmHpSAvvRNAkQL9OCRk
 FWIdAie8GRSNJLPW6pAti1qCFigQIlmUPnVZpEAO5tyqKn/3GRAw4RPn35s2nGIrtgU=
X-Gm-Gg: Acq92OHA53W40mUW68CRwP7kBF0x0VQiEkEc1XhCrhLDaRUPccai15rRtyIQVZrRboA
 53uiujiXq36mtCF2gLkB+Y+zsG92l1NhQLotkLtUOpGxejy74aP+iXAYx2L8nmS4zZDq4iIX45s
 W7K9rMJMxE1492hq2HLDRBD7zVdG8UbVKk3eftlW84Po+qqd/5OHnnuZdpqtLttS87SKdnjn67M
 IJReMPl9B/jqFEMDfxdsevhWgYrXn/mu8SKp8qzfarsZvNF/C3Gon33A02Ppe8q+g/rlbj7C9VR
 /t4Mt1PMvARKGF20Vt/2+Qe5m40v2m3RbxSbO+pwH6zUWun/2JgWuYRTK+0seLFdi1tLJgCBsiK
 DdNqOAvHrHynf9MU4FO8/XxqFbVKkGctEcqRlZxMjqn9O9pEpkdqIa8mZw8sspzp55sZia2gE5E
 RU37X46tKOIWavIL0So/pLGfTLz/yIpWry3w==
X-Received: by 2002:a5d:49c1:0:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-4602733b2a7mr3655158f8f.13.1780567467479; 
 Thu, 04 Jun 2026 03:04:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm18014261f8f.24.2026.06.04.03.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:04:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A00ED5F864;
 Thu, 04 Jun 2026 11:04:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <aiBwWH8iirdw9kw7@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 3 Jun 2026 19:20:08 +0100")
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <8733z3trth.fsf@draig.linaro.org> <aiBwWH8iirdw9kw7@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 04 Jun 2026 11:04:25 +0100
Message-ID: <87qzmmsjti.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

> On Wed, Jun 03, 2026 at 07:14:02PM +0100, Alex Benn=C3=A9e wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>> > Hi Daniel,
>> >
>> > Thanks for the review. It will take a while to incorporate everything
>> > and I'll wait for more feedback, in the meantime just a couple things
>> > I can confirm or add...
>>=20
>> I mean you could just let the LLM handle it ;-)
>>=20
>> AI-used-for: collecting comments and updating patch
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> I only include this by way of an experiment. I think the new text does
>> cover the discussion although I think it has taken a fair amount of
>> verbatim text from the source messages that were commentary rather than
>> suggestions.
>
> Most importantly it has applied no critical thought to the review
> comments, seemingly treated them all as mostly equally important
> and incorporated them. The resulting text is more volumous than
> Paolo's, has poor structure and in places is verging on what I'd
> class as slop.

Well there is no "thought", although its pretty good at text extraction
from the mailing thread. I guess that's the "attention" part of the
model.

It wasn't helped by the fact there was a full lift and shift of the AI
section to a new document. In my other experiments with documentation
I've let the model do the changes and then I can review each hunk and
reword as I go.

For code changes I've found it pretty good - enough so that it might
replace my hand-rolled mechanism for saving review comments:
https://github.com/stsquad/my-emacs-stuff/blob/master/my-org.el#L176

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

