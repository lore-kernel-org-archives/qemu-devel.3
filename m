Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAF9D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCf1-0004uM-04; Tue, 20 Jan 2026 09:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viCez-0004rR-P7
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:24:45 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viCey-00040F-AF
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:24:45 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7927b1620ddso77086527b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 06:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768919083; cv=none;
 d=google.com; s=arc-20240605;
 b=feE05S82muVMG6x0h/cYTdJiSFQb7tCxvgM33mjWWW6JwBIfJ41tSlIqOuzXpe/p3R
 TixXKVy7Vn3CVV7tkkONj25RGcjwGI2wGpG3PFYsQ+MvL5EHUaiTA/wjDLAh2Hhw1d1V
 8szqty1NBszT0rIZxQDrkjbU+9xGRJ6AblGnNhHXIkkK60cm5ZyuQY8RvTLRYZK+qY7Y
 86KTBCw/5jZ+DJPEoOmTyh7Mfly3lIAMYEL3zgSeUHabJT2kCseqN2hG8x5R2CXUBgCQ
 /H8HcFwo+pM/h7IEug37V10MtUBABMlJAW3uAGVkfs6hAeXC1DydPcSx62Eyzhbj0EN3
 qzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jC5r4tunGuWaf7NoeOgcrPyqJzxy1AIdc+TYbWNUrCg=;
 fh=hoSnzboXrzcQ1unl97/Iib2OB2FXuwUu0q/0kzVS8Pg=;
 b=a0AtHw3RjDZ781wzRoBoj3EDtXjjjTW9rume1zVway980ZtcEu3Ee2ggK2WkLU38CM
 u6tSV+/zShMyJEobKbDTLGZ+7mKz39rojOjX1mh80qKvy0Jlql3YhpTZxSnxlqIIR7fM
 16V92gSmciABENLrCkG1lLXHA1gfz0FpsxmCfgzzjXJZ5qf0Zle30oFt3A+mJyZpix0u
 HMgR4DPff23wAJtkuupQoqTo9gSwb2C2rE2FmzR1MmTkN151dMwXwfTRxIvcyT9giWdJ
 SDehR3zHw4yCEN2yKx7cZJv7RfEF6tCnxhxXFHEz++UkRcgru9naM+2yDFUl7IZT3V19
 63oQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768919083; x=1769523883; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jC5r4tunGuWaf7NoeOgcrPyqJzxy1AIdc+TYbWNUrCg=;
 b=XyyZqzmMLtE7uKSL5+0vVORp0vnIqOHuVvnPLNY9UXiu7bEJm1xEpae4FbwZ+rU6eD
 fvMOByxDuKYPpB4BhFx24LvPFco4ZGufpuzMHpOARKzqkLmRxAfoHE2toYNcfWNXoeR1
 qNtLpO+CevHqw8Pv1jgs6Vr65GZAszZbK7/rBesfbGpYukzipRytIn2aSWNglMVYXXzJ
 cpPGwyOs3JKZ/3VABSUD9WVk/6toLWh8386MGrBWrpIpUUR6q3wCb6ZOVMVhQfwW8Z+G
 YwUyKmuAGRBpgQ0jSyz8QzUp3nUv7kA4+gNwZIh0ngJrCHzNmTSs6ZA3kqycKlWjdgi8
 ZZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919083; x=1769523883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jC5r4tunGuWaf7NoeOgcrPyqJzxy1AIdc+TYbWNUrCg=;
 b=OZG4bYRj99b7FZeqGg1Fu/q9Ib0dtC5QsIL1jo+tFQbe+torIuxfphzSDBBVd9WNMF
 PuNjKODnt8tHECNzipLuhgEEofeKhpakTf0Va8jvMvY7E6sOBU/37mUr0HPIhfb7ZWmv
 lH4dLu8P851BCKlcqXSa8AjgHJsj1SOHJGZhoY/nZd7OVWrajBSNVchwdbTrL4FRwv8B
 uiMnUAbXj8Ii2yuIkLK3a077ruIp3c1MldulRPntP3VrxRiyj4Y1LCt5LZSacPfc79Kl
 CiESCBhnytXhjNFjyylxNoeyiMdevnx4qXUiQrosehYuGuly6Bu4x5Wt29/cX9q91iPb
 +6BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnt3OdXy1m9PkydIJAvBaZ1rLBYq+5eDEuR3Rt5JQSqruGfBs9e1BkBnREG5B6TVuzaAgasp55BZbF@nongnu.org
X-Gm-Message-State: AOJu0YyJgash/4zDuqqBw3SN43REnXXIgqv5ewSJ8KjxzW2z/DlWgoJr
 AHz/elkWgRI4VdRU4S5WyO3b5tuHJBUD92ahieKr+rMnfZ+MVaw7r9dKznm2i0oPbd76AANItfD
 xpZSK6oIZPFWOEdAIxS6EPXkA5RE0iudMwQn/Lu16mw==
X-Gm-Gg: AZuq6aINiOoZ7ngOy+Udd7S/YRyPJ5dduumIMpWON5QrireN1rL3xkOfIDabfk4otav
 ywKA09Oe25LJwur8xxZ0JA/kZuf6FG0FO425XohmRiKSDr+zGzQWQ2WWddvqLg84RaYKUbA2db/
 +z2HUPLschrQQzAmLRUHBfwbs0pzqscY594Wt3pBPfmGq9W77pJkR5y8ubXWG11Xrmlj0OA9vWk
 +t1fgw3gh+PI3/nu1mjxrWshnfVzBgmbHGI7fKOMOYW/ZUXExU3AVNDucw67g4JRBj20g==
X-Received: by 2002:a05:690c:7108:b0:793:e57f:2249 with SMTP id
 00721157ae682-793e57f22e4mr63373377b3.7.1768919082864; Tue, 20 Jan 2026
 06:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20260120122108.131708-1-thuth@redhat.com>
 <CAFEAcA8nzm+CEN_Dp+X+AggcTg57wAt8D43x-7oixLeNH4TDdA@mail.gmail.com>
 <791eac72-f4d2-48b5-9973-c64006e8ce13@redhat.com>
In-Reply-To: <791eac72-f4d2-48b5-9973-c64006e8ce13@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jan 2026 14:24:31 +0000
X-Gm-Features: AZwV_Qi-nhyfIqRDBywfAotFoUlG1bfyXsXVaPJvMuSacLTD2jMGWLZeHMty9-o
Message-ID: <CAFEAcA_0xM47w6tLgGSrXZO2v1S+ncq92N_h3U=HQENapzyU9Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Move the "arm-cpu" compat settings out of
 hw/core/machine.c
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Tue, 20 Jan 2026 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/01/2026 13.55, Peter Maydell wrote:
> > On Tue, 20 Jan 2026 at 12:21, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> The hw_compat_* arrays in hw/core/machine.c should be used for generic
> >> compat settings that might affect all (or at least multiple) machines.
> >> Target specific settings should rather go into the target specific
> >> source files instead. For arm/aarch64, the virt machine is the only
> >> one that cares about compat settings, so move the "arm-cpu" related
> >> switches to hw/arm/virt.c now.
> >
> > I think it makes more sense for all the compat stuff to
> > live in one place, rather than being scattered around,
> > unless it is truly machine-specific (which this isn't).
>
> It's only used by the arm virt machine, so it's IMHO machine specific.
> If we will ever get other versionized arm machines, they won't use these
> config knobs, so this never will be shared with another machine.

It happens to be only used by the virt board, but that's just
a coincidence that we only have one versioned arm board right
now. The config knob itself is not at all board specific:
it applies to a device object that is used by many boards and
sets a behaviour that would usefully apply to all of them.
If we ever did have more arm versioned machines in the future
we'd end up with a weird split where compat properties of the CPU
object that happened to pre-date the addition of that second
machine type would be in one place in the source code, and
properties that happened to post-date the second machine
type would be somewhere else.

thanks
-- PMM

