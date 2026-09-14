Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420A6C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BBS-00058Y-8d; Mon, 14 Sep 2026 14:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6BBP-00055P-Bx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:13:36 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6BBM-0004H1-Kv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:13:34 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66de7e0bc85so2993030d50.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789409611; cv=none;
 d=google.com; s=arc-20260327;
 b=aM4Y37oeEXRFx8ORHv0wbx6XFB95REhjhj4vCV4unaSg/3lnK955rSGEm71UYVr7k0
 L+DmYPZ9KxZUvZo6VsDR99n7vQhcZ8icOTZ4jruV6RtMJPqbcVFgM+TKCgm0lJLwyg1I
 rcDgE9sD/RbFFvk84Tz+w7NLqQ+nzm4xFZk5NUZGOS+jjC0Me29IPW4IvqMvk5uKQWET
 GDJxlVU4eHVRcjxu5Whf/ParDdWgG80ROdpB/9xxvBMwdCiw2U2dGzvoOnVDXFPWVzhP
 nFpIrXtxa1KNG6/P1eWL3D4Y6PQJNE8z7ixDNgGE4bFRlO48cHyhSSxDAH3yu0aV2dNp
 dd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6NFLycDbYQLQ/wsVZAiSevufSezxm5IAib9EU8Njv3o=;
 fh=HX/mT844IYtdkvMd3nZDmf1m/n/lIPFwyrGp8Yh+TCQ=;
 b=krkDzNoGlKAl58OSwOKuhMYamtuBFftoShPilTIX06LSRPv0hRFICW6beNdJU9SMb1
 yu6Qjg3dv5gbLfgFVnOzxARMd1HKXjdC26cshVYTJvLwhLe9EBDLcP1dtcW5ifDHzg9X
 uAgldBkIQyZbzZN6spK7iqaxL3P9PzBlwfwFywv9mCoos/giEUdpUKMyRrBmiMtw0q8l
 +jsZOgLjp4deS8sdbxVpq7jYlB1KVV/Xfrt/8BhqkgDJOiEHdfkrMXDtx7vvW/HgyaoH
 uuMGkXsq1hQlaIZagQmza3Q8ecbiqMMZKR6BjpJz6Il2oP5YKh2L2M+CqGJtqNGKpltP
 VGqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789409611; x=1790014411; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6NFLycDbYQLQ/wsVZAiSevufSezxm5IAib9EU8Njv3o=;
 b=MeGk3rJsUq+gNtZ+6GcxfIzAKRAKqNjx7XaiARLjvgcm1JLi3y1LNl2hnLSwd/6hFL
 VcGKKKH22N6VZwUQycgdAJQ87nBECjwrcsbPXBLaEzApLR24AqkfEwbr7VGYunWisJ5l
 OJo5Nrv0NM+BY/0gYOYFnToYJ1q2M1yATvv/x2ohXwPtALvk9Ud6fYoQ7MNuuCi/PHK7
 nWw3as7VmUDCPAF7WjJ2C69gyvD9BmGt99D8nksFA08u6kCnC2zoz9E+znDNqmJPpANW
 PDbywesmQMTr9dS7j9n4yR26pO6UWlJP++Kx/mbFM/qj5SNBP2Ic1PF1XtZTsIPkZQc/
 zUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789409611; x=1790014411;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6NFLycDbYQLQ/wsVZAiSevufSezxm5IAib9EU8Njv3o=;
 b=cLO/aQLWgsAp3/iItJU4oCRk7+LSRjeSMxqAZYIj4O6y6uaP1nNmZleUFJCvHEP7XJ
 1kIFd8f2fIprQYqpP1KBafC22KZK54CW+cJOxgpChaF1/zzdk1ciLogqyLlRAYtIZsno
 E4jV/n0nyuHHP0uZcjyY8o4py7rFJX83obJ0nNpedZ8Xotu4c38UcckHuw6UMZla7ul8
 I9gf0DKk1br4R5rr/5JzqE8nm1abKY6qZTpNcQj0O1x35oLo8qKkZ5iZeX8ivIPt5WQ4
 JaEt7OzHm9j1NAywyKoiGmdlmEbNOEcryRXMc2QV2Y+CbuPMltTrpARLCpBiIKD/8V+F
 subA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIVsUnVGrwbCUD1xYuHx23Sd8zwSK5/+YS7lhesl1CtDjsysAWa6tR+ZSktP/JrnbxNAzB6fDKZai2@nongnu.org
X-Gm-Message-State: AFuF++kX+DqbZ3I8t9noSD4AsYSIHcqj+oyPRSfm2akYun16P8F7iiX6
 /QUyzJxpjTDJtkboIsSubKFm1LtwQgeH6TgFJUxQeYjHI1I7E5AyNy+H3CMam73++gtRLCCzr/y
 LnrEqVH85EO4ph1FJ+y7kU5ngXspBra0w6rD99dUD4g==
X-Gm-Gg: AYBFou2dobJTYwWj4gNmsKeU7vrdGglNecElQ2+HieMHTJ4c/Yz+HRRLsG/bGlanwG5
 My/sNhmlPm4+malxCPu+yRcvy3GD56gSQoGhtUGcFl5V3wWVHOJ+Ph3pQ3psPKOI7hJSStGQlC8
 MJPpDNukdf1V01dCq1kvc+4Yi47rd174PTHmJ20DD4UL1SxZP5ir8+iPLBGjfO7VN0jKPat4O8n
 fcp37Gs/hsKbigeiVEYWKAqLyCYMjn/ESab+V+ZfWbrYonqPlRmECLaATsXIqkZLQQhuGQLzQp4
 JRHusqCOWtVvFbXuC2NzW0334jgxEOtawVsQXOvuRnQFyOQOo6mmfk5jkBj0d0Cf51X7zi7UXEw
 rJ8UPmGc7gFcAweiaC2drbYZgfx3ookBfobTHBZU=
X-Received: by 2002:a53:d84b:0:b0:671:3ae7:5216 with SMTP id
 956f58d0204a3-6714e1a22e9mr886767d50.69.1789409611175; Mon, 14 Sep 2026
 11:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
 <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
In-Reply-To: <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 19:13:19 +0100
X-Gm-Features: AcwNN1Whzuf8R-D-70-U9T4t9BfxU7sHY04AIwm2wDDyx6iKQL9gfWTnTYk8HvQ
Message-ID: <CAFEAcA_f_u6KgojmixnKBn=v1nLybMXYn5MBycrjCtgSP1J7TQ@mail.gmail.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Aniket Sahu <asahu1x@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, Joshua Daley <jdaley@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 14 Sept 2026 at 19:10, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> For vdso, we could simply build them as part of tests/tcg and tcg-tests
> target, without having tests associated. This way they are always built,
> and people can update them by simply copying them if needed.

Then they'd need to be an odd special case for --disable-tests,
I suspect, since we always want the vdso built even if we're
not building test cases.

-- PMM

