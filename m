Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3360E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuSi-0005Ct-B5; Wed, 18 Dec 2024 08:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNuSg-0005CE-4i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:38 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNuSd-0000EF-1o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:37 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f00b10bc1dso56603077b3.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529892; x=1735134692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iUDoOsV26Qe4oFZU3uHRuMJZh3S91v5QoMM2nH7Rk4=;
 b=jM2q66AG/MrR6HTWPUMO59tjTl77sWhtnpMhPtPLTX1/qJlJMNlR+Ktgo1qu6X3Q45
 JO4HFqNZdxQ24yFVvosNOaWxfoIBmeHqv2MS2Ca+mdZLbjJeEioVqZ18DHtfY5YD5stX
 nFjtXj2we8kgZPjh9Z+fUIFMZzT0iM35qOMaoTTPMTs8lhsKwjPyPoMZ/kZkFjZLla4j
 7oItkkjZqE/C1e5NyeBiN+xZlHLZ3XnxAuKrQt4UXf6JBuTvKs+5ptge84t2XwwHy+Se
 8h2/WbC/SHxhEqIS7XVc7x9yb1TfLn+4OSFA2dElMXdG2KIdQ4tUegLgjmfEK1bUgoaY
 Lh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529892; x=1735134692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iUDoOsV26Qe4oFZU3uHRuMJZh3S91v5QoMM2nH7Rk4=;
 b=JdB3FjsBlAZjzOgOt15eCeAF3ZXV8n3wLvTZDE9gwToEP2JpwoluGfkfboQoa+fDnq
 YHtrGQ115ijHJEBZY6f7t8Snk/SdkupAOOY+o7CsORjapiL3VeQf0ZSBgxLfgvhreH06
 xQdEo7n3pXAqBZBKlkYUsGD1Sy+f0Ca36SW03tY2coP/ID4iJOtXe93TtJtIq8j+X7dt
 6BwNTFEng8T+R7w5BMMNamQWM3NYvLrTEiftrLRQriS0uQFnk1rF3s/SqDUOFhIFrXeH
 ThXV0sgBatyJbKHClevjLG281iyekdsbCMT6mcogTbBhCYd7+VOfqZJ680wH+BTP+JqO
 Z9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7KN+uCFv/TJpkG98MeYD6YFHON1ejaqFBTJ+6bGHKfd5Tbbzm5WvL9+QuLjFZX/K8fO85DktTbkPz@nongnu.org
X-Gm-Message-State: AOJu0Yy3jVr/V4hk7yTCMIVEfGeGjmZE42hFdXqFJJ13Wm4WHq5NePe+
 Z3LTPhvIiUYM/9y7MBVxflhh2XdpbFtjFhIGPk7s0UGQ6yejz3HMn7O4rqfpksBOqlplTipuTxZ
 yqDq8D4V98/hFBQ6CoiUdwM9DJxkq6wkHoenv2A==
X-Gm-Gg: ASbGnctHA9oqssa1pYvOQ2qrs6U7qiuqDFgfCVC3pqs/2l1UuT0stCBWkxvpdlSfea7
 PDxzDTYqqJ5kDD4kdQDTtAm2O6umnWgwlnhGjer8=
X-Google-Smtp-Source: AGHT+IHXPem1A6ST3qeAiEL5KTr8qkukNq9VCj+GeLtRyG9HNbPypmNQkQCJ+fR3gFQH5kMC3y6EJP2eSJ+HrJgyZxA=
X-Received: by 2002:a05:690c:23c1:b0:6ef:5820:3901 with SMTP id
 00721157ae682-6f3d269397cmr22765557b3.37.1734529892137; Wed, 18 Dec 2024
 05:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
 <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
In-Reply-To: <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Dec 2024 13:51:20 +0000
Message-ID: <CAFEAcA8YNcft8KU8mytHv+H71L7L8d=QBgQmSAmq9J7Ny23=tA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 17 Dec 2024 at 21:08, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 12/17/24 02:38, Peter Maydell wrote:
> > On Tue, 17 Dec 2024 at 07:40, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> >>> I think this is still a change worth to do, because people can get a
> >>> 100% speedup with this simple change, and it's a better default than
> >>> the previous value.
> >>> In more, in case of this migration scenario, QEMU will immediately
> >>> abort upon accessing memory through a pointer.
> >>>
> >>> I'm not sure about what would be the best way to make this change as
> >>> smooth as possible for QEMU users.
> >>
> >> Surely we can only honour and apply the new default to -cpu max?
> >
>
> With all my respect, I think the current default is wrong, and it would
> be sad to keep it when people don't precise cpu max, or for other cpus
> enabling pointer authentication.
>
> In all our conversations, there seems to be a focus on choosing the
> "fastest" emulation solution that satisfies the guest (behaviour wise).
> And, for a reason I ignore, pointer authentication escaped this rule.

I think the reason is just that we didn't understand how much
of a performance hit the architected algorithm for pointer auth
is in emulation. So we took our default approach of "implement
what the architecture says". Then later when we realised how
bad the effect was we added in a faster impdef authentication
algorithm, but we put it in as not-the-default because of our
usual bias towards "don't change existing behaviour".

> I understand the concern regarding retro compatibility, but it would be
> better to ask politely (with an error message) to people to restart
> their virtual machines when they try to migrate, instead of being stuck
> with a slow default forever.
> In more, we are talking of a tcg scenario, for which I'm not sure people
> use migration feature (save/restore) heavily, but I may be wrong on this.
>
> Between the risk of breaking migration (with a polite error message),
> and having a default that is 100% faster, I think it would be better to
> favor the second one. If it would be a 5% speedup, I would not argue,
> but slowing down execution with a factor of 2 is really a lot.

The point here about "breaking migration" is that we have a strong
set of rules:
 * if you say "-machine virt-8.2" you get "exactly the behaviour
   that the 'virt' machine type had in QEMU 8.2, and it is
   migration compatible
 * we can make changes that are not migration compatible only if we
   ensure that they are not applied to older versioned machine types
   (or if they're to devices that are only used in machines which
   do not have versioned machine types at all)
 * TCG '-cpu max' is a special case: it is not a fixed thing, and so
   it may acquire new non-migration-compatible changes between versions
   (and so if you care about VM migration compat you don't use it);
   but this is not true of the named CPU types that match real
   hardware implementations

This patch as it stands will not preserve the migration
guarantees that we make. So we need to fix it by either:
 * only making the default change on -cpu max
 * making the default change be bound to versioned types

As I say, I don't have a strong view on which of these we go for
(and I'm actually kind of leaning to the second, given the discussion).

> > That was what I thought we were aiming for, yes. We *could* have
> > a property on the CPU to say "use the old back-compatible default,
> > not the new one", which we then list in the appropriate hw_compat
> > array. (Grep for the "backcompat-cntfrq" property for an example of
> > this.) But I'm not sure if that is worth the effort compared to
> > just changing 'max'.
>
> When we'll define hw_compat_10_0, and hw_compat_11_0, do we have to
> carry this on forever? (Same question for "backcompat-cntfrq").

The machinery for how this works means that you only need to
put the property in the appropriate hw_compat array for the
machine version before where it was introduced. The 'virt-9.2'
machine type applies the properties listed in hw_compat_9_2
(you can think of the properties listed there as having the
meaning "downgrade the default behaviour back to what it was
in 9.2 and earlier".) The virt-9.1 machine type applies the
properties listed in hw_compat_9_1 and hw_compat_9_2. The
virt-9.0 machine type applies the properties listed in hw_compat_9_0,
_9_1 and _9_2.

This is all implemented by the boilerplate DEFINE_VIRT_MACHINE() and
virt_machine_*_options functions at the bottom of hw/arm/virt.c
(plus the common code that invokes). We have to carry all this
machinery around anyway to handle other migration-breaking changes
in other parts of QEMU, so it's pretty free to add another property
like backcompat-cntfrq here.

The very oldest versioned machine types are deprecated after
3 years and dropped after another 3 years, so eventually the
older hw_compat arrays will go away.

> > (It's not that much extra code to add the property, so I could
> > easily be persuaded the other way. Possible arguments include
> > preferring consistency across all CPUs. If we already make the
> > default be not "what the real CPU of this type uses" then that's
> > also an argument that we can set it to whatever is convenient;
> > if we do honour the CPU ID register values for the implementation
> > default then that's an argument that we should continue to do
> > so and not change the default to our impdef one.)
> >
>
> For the TCG use case, is there any visible side effect for the guest to
> use any specific pointer authentication algorithm?
> In other words, is there a scenario where pointer authentication would
> work with impdef, but not with qarma{3,5}?
> If no, I don't see any reason for a cpu to favor an expensive emulation.

The guest can look at the value that the pointer auth instruction
produces if it likes, so it can certainly tell whether there's
a difference. But the only reason to do that is in test code
that's checking that the pauth instructions do what they're
supposed to do. Architecturally because multiple authentication
options are permitted no well behaved guest is going to depend
on which one exactly is being used.

As I say, I do think it would be good to check whether our
current implementation is "default to qarma5 everywhere", or
whether it is "default to what the real CPU says it has in its
ID registers". If we are already defaulting to something that's
not what the real implementation does it's another piece of
evidence on the side of "we can just default to a different
not-matching-the-hardware choice".

thanks
-- PMM

