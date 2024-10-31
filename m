Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A371ED74959
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 13:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6VHn-0004U8-A0; Thu, 31 Oct 2024 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6VHk-0004Ti-Rp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:32:25 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6VHj-0007QX-3P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:32:24 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so8811451fa.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730381541; x=1730986341; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJGafJg+d1IxoFjpERz9al47u602kMESqI2izULfSgY=;
 b=Vv/C+rua7N13NatL7tnge+r+qu/JgH2U/OALkvKbHaonlJ/xS8khZr2WZZ7LUBMCZ/
 yEvaokqPa7Zk8VXJ0TXCuE39BIy7BTCuNCtk7jacKGSy5HIQkhr/1ge0p7wkEhmzUtWg
 OYgPBrf7VsklUCccY7DMibYi8zKfpNbtsMJXB6hue77EYgYIS1E7p4RKa1k96y9nyAMJ
 EOxl0uHNgWFPO/QbqRQ3DQ43sSYiSw7r98TFq1aQpF7JE8KqiQSJCp5Xq4x2/w5TvUJ6
 rbV3+NuPXFyNPAk59QRP4hCiHLD6DeLJeeC9mfJ13H8Gq9MAWycX7pOSE3aSU/FffaVD
 okJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730381541; x=1730986341;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJGafJg+d1IxoFjpERz9al47u602kMESqI2izULfSgY=;
 b=DAM0eWzRta9b+jtvlH+8IWVITdqC+WkCBGgtVj2xkGx2j2ve07uV7NXSfp0LsS8ss4
 ESw2Wx8pU4VhWf1zTQwarZfdjQFg2NGFH/qv6+qDCdrR9TaJVwTWvdK0iFgxkERyMf5H
 Hb/e7u/Bfj/axfiNlwkog04/p4IhwFsMD50nAooucIiiSbd7/uO/uIdNH378/SerKrEs
 +3cHmIGcH/I5w8fNNmenM9fwz2ibQJYz/k6V+x3b+NXj2Z52UvV3su3mdYSxPKAO5OJ1
 uK74m3v3674N29wXFeabmYIh5xPRnvf0URFRIW4dHsLrFm7V9453N17ECEzH9LDr0B+0
 IO8w==
X-Gm-Message-State: AOJu0Yx8qd3uwMygN59wWwvmpA5tmauGiiLzGuGqmNEL9gUCHWhQGs2j
 4NEJrdKtNwPaIT4jqBOdoVeyt4nYze2krjZfzFMh89y127izz0s4si968YKsWMLlPC0VuYrLSJX
 CxnXlDGsE+QDx0U5YqT1WO0Q7HQe3/DAcItwXU4AbTfqHUonV
X-Google-Smtp-Source: AGHT+IGuQ57xjDviIvacKolPis8qAc3tFuOsjTIq3Gi0saAtEdf4pjT91WZaAkMld9s6QeZzGSiLOL+/ns50DO8eu8Y=
X-Received: by 2002:a05:651c:2123:b0:2fa:d31a:1b77 with SMTP id
 38308e7fff4ca-2fcbdf62829mr96070431fa.9.1730381540588; Thu, 31 Oct 2024
 06:32:20 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 13:32:09 +0000
Message-ID: <CAFEAcA8pqjY-VKXPOe9W7J6upVhMeX8jJ=9Gmb8e64EtqHMQ_g@mail.gmail.com>
Subject: QEMU Summit Minutes 2024
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

QEMU Summit Minutes 2024
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
invite-only meeting for the most active maintainers and submaintainers
in the project, and we discuss various project-wide issues, usually
process stuff. We then post the minutes of the meeting to the list as
a jumping off point for wider discussion and for those who weren't
able to attend.

Attendees
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Dan Berrang=C3=A9
C=C3=A9dric Le Goater
Kevin Wolf
Michael S. Tsirkin
Stefan Hajnoczi
Philippe Mathieu-Daud=C3=A9
Markus Armbruster
Thomas Huth
Peter Maydell
Paolo Bonzini
Alex Graf
Alex Benn=C3=A9e
Richard Henderson

Infrastructure and Funding
--------------------------

Up until now we have been running our CI and infrastructure based on
donations of services/credits from various hosting providers (first
Rackspace, then Azure, and now DigitalOcean).  But because each of
these infrastructure sponsors has their own differing idea of what
infra to offer OSS projects for free, we end up with awkward
migrations of our systems each time we switch to a different infra
sponsor.

Paolo proposed, going forward, to instead seek monetary sponsorships,
potentially multi-year, that give us a recurring funding stream long
term.  We can then use this to fund CI and similar requirements.

The KVM Forum conference itself made a small profit; we plan to keep
this separate to help with the financing of the conference in future
years.

Link GitLab handles in MAINTAINERS or have a .handlemap a la .mailmap
---------------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 pointed out that it's awkward to find a
maintainer's gitlab handle if you want to cc them on a bug report in
GitLab.  We agreed that it would be good to record this in
MAINTAINERS or something similar.  Philippe will post a proposal to
the list at some point.

Enforce SPDX license tag in new contributions
---------------------------------------------

We currently have SPDX tags in some files, but don't mandate them.
The suggestion here was to make them mandatory in new files, so we
can automatically catch accidental license problems like "user refers
to a non-existent license or a license that's probably not what they
meant like LGPLv2" or "user forgets to say 'or later' for GPL code"
or "user forgets to put in license comment at all" or "user uses a
license that is GPL-compatible but which we don't use at all at the
moment, with no strong reason why they couldn't use some license we
do already use".  These are all very easy to clear up if we catch
them before the code gets upstream and potentially painful to deal
with after the fact.

There were no objections, so Dan Berrang=C3=A9 has posted a checkpatch
update that enforces the SPDX rule.

Code-of-Conduct Committee
-------------------------

Though we decided last year that there should be a separate set of
persons taking care of Code-of-Conduct violation reports, there
hasn't been much progress on this topic during the past year.  Thomas
Huth has now volunteered to have a try to assemble such a team by
doing a request on the qemu-devel mailing list.

Rust
----

We had some discussion about the project maintenance aspects of
adding Rust to QEMU.  Alex has already sent out a "Rust BoF and
maintainer minutes and planning the roadmap to Rust" thread last
month which covers this discussion and the BoF; I won't summarise
here so as to not bifurcate the discussion.


thanks
-- PMM

