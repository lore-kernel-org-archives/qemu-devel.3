Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1471C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUScS-0000Zi-SY; Mon, 29 Jan 2024 09:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUScL-0000ZO-OO
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:28:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUScI-0004Zk-Au
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:28:08 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso2594129a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706538484; x=1707143284; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2056RyK7DW9Z8hzDKfi2jmdLFKNsbd3R/XFyHvCStuY=;
 b=pHGxRRyNWEwDSyibDxgYIezjXiDmO0kAEWRv60CrvriU/+B2oMBiR5rqHx+S0RkAL6
 5E9UliqbIDj/QbwIf0m3Co5SajPU+Ih/MG8JCd5t50Iz2Gv3dCA+mrxJ2YuoE+E0lHcg
 fmCcLtMwe4DC2ZEezUH31hniIbZfWmGmuR+wEXYujYQCf6Cf6K+NuRRP1SF7WPlMXihD
 dEX93CrrjoAEZQuaLf6107qDV4eSQD8/mu2oDIMPk258RzNVWEQtXzlcuXdlw9U1vT1p
 S5Yjrbxse2BuAKzS6nwwgycTvkSQwmgGU+fQ2zf5e71C4/YMofmsVrPeJ403xLeIzmJ9
 gr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706538484; x=1707143284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2056RyK7DW9Z8hzDKfi2jmdLFKNsbd3R/XFyHvCStuY=;
 b=UVyEsLlXDjE4IrvK/sYMa+j5sGtiGei15gZcxGEZG/Yby+ngvivCVuyfR9sWbNK4oP
 zIF7ReYKrpYYbFVfsQxl3+MxyY2XbH9GWNtJNEr7Wie54h5N1Fo7OW6zVbJCehwuJPNz
 7FQENvAbSAd6MR2Czm8tH5D7mSEH/31ktq0aIS8t42eSVtU382IpgnSNol+ZYOw7XTiU
 UHyoFYBdlXQ4eWRqRZvyzgxiKUdI0ckEOrfRum6craC2WZM7GkVtss9oSdcfGr6z3QAj
 vQCGudLME8wHefSdSWxx0hTDkuC39rKcsRibKNCNL3qvgRKWhEy2cmHWgOGglEcxzA+/
 9Cnw==
X-Gm-Message-State: AOJu0YyA5YF1010fPbBbbMsxjbyQkVthTzLVt80NFdzeO7dvI4+iPiBL
 KjsEsHhum7yn9uYPQgwsxwF876Fvb7nPbhszrViv5JQRGS8Z9QbZS97BmU3HH3DIPGQgSchHaN6
 VHRWHwCpVFv/LNapEHQFMyFjbNWP3t/20Q9mgpA==
X-Google-Smtp-Source: AGHT+IELAj/+3iRYlGs+HNHv24ZGkRNC+vP7tVmYvSUBZB/jqZFBKT0QBhmnWff031scpFf7vCUUD1Y26zBDLYddWJ0=
X-Received: by 2002:aa7:d95a:0:b0:558:252c:2776 with SMTP id
 l26-20020aa7d95a000000b00558252c2776mr3842620eds.16.1706538484408; Mon, 29
 Jan 2024 06:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
 <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
In-Reply-To: <87frygdzjl.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 14:27:53 +0000
Message-ID: <CAFEAcA_uzJKuvY=iTnbG-xAjLn0zHRevzvjoyhjqqiBThveO3Q@mail.gmail.com>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Jan 2024 at 13:45, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Xu <peterx@redhat.com> writes:
> > Fundamentally, IMHO it's because QEMU as a project is used both in
> > enterprise and personal emulations.  I think it might be too strict to
> > always request backward migration capability if we know some device / arch
> > is only used for personal, or educational, purposes.
>
> Do we need migration support tiers? =)

We already have them. The tier list is:

 * if the machine type is a versioned one, then we maintain
   forwards compatibility for the versioned machine
   (i.e. can migrate machine-X.Y of QEMU A.B to the
    machine-X.Y of a QEMU C.D which is newer than A.B).
 * if the machine type is not versioned, then we do not make
   any guarantee of migration compatibility across QEMU versions.
   Instead the aim is that if the user tries it it either works
   or gives an error message that the migration failed
   (e.g. because the version field in a VMState struct was bumped).
   Migration breaks are generally called out in commit messages.
   Often for machines in this tier the user is really interested
   in state-save snapshots for debugging purposes, rather than
   in a true cross-host-machine migration.
 * some machine types do not support migration/savevm/loadvm
   at all, because of devices missing VMState structs. This
   is not desirable, and for new machine models we try to
   ensure that they have vmstate structs as part of the minimum
   quality bar, but it is true of some legacy machine types.

AIUI we, in the sense of the upstream project, do not support
backwards migration compatibility (i.e. migrating a machine-X.Y
from QEMU C.D to QEMU A.B where A.B is an older version than C.D);
though some downstreams (read: RedHat) may do so.

thanks
-- PMM

