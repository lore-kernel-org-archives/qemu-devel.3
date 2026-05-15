Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5131CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 04:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNk8D-0007oH-2w; Fri, 15 May 2026 00:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNk87-0007o3-An
 for qemu-devel@nongnu.org; Fri, 15 May 2026 00:26:31 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNk85-0000Ko-E4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 00:26:31 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso9977723eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778819187; x=1779423987; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K8eEhfROtVoDNsNzcVf3q7NW759U1sQ7wv62Fvwtajs=;
 b=dhHhs7xw0WSdvyR+dYahaCQkW0VmBTb5bMu+3qH9gu452yGgmw6dRf8sicqe6F9jy0
 zMf8mDB3/7q9CLBIaQvMsd2AyWhTyiXGDIYO66vNVSTc3xWpAfYYCXfQlkiOJ9eR7agQ
 62+uE8ZEVePKGqXaN0MqQe6IQTJZ+OdheEmJ7mvoB/ZiSk3fF2SGJWoSiDuH5mVUK8ZI
 XCPKvqfx4jT/p+jfVZri8SMH40iWxFKjJYYnXo3VQnJKVxWM7HeEXrO0HsbOaZGYLDOV
 yVLmEhKnDC7qDkmCswTpi93eiUIGui2+4Pnknfcgg2mRKHnpeEjwKyreMLkIz2w565GG
 Fvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778819187; x=1779423987;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8eEhfROtVoDNsNzcVf3q7NW759U1sQ7wv62Fvwtajs=;
 b=iyS5CDQpYkpJxcgNfLkmZRGFkSG7U/Ij+abSIc+YKLP82yJrH7wz8PKfsj8vfWm6Bi
 3ZpyLr3qiJAb2JOec9K8Butky25fXPI8ZrA9IShcKlZ9jdrLekMxVSsp9I3kwkAZi8Be
 ZUXUk8iNdS3HeBOk861Uzp51i9W8Yln/ukaj5wAfaDqa3dKHTZfgq46ledPO3zDBEpCl
 Rl+NW72z760Y5N+2YIA1pD1rzNOw/G6bJnbKI48P8LswR3dLhq75P9o0qHmRwcrNfeXQ
 Q5n7c7AxG1JKDjDbXpaidMUF6PkYEmz9mlMeMrYbyfCo+dfSIa6RouQNd5J57v22g7vv
 nIRQ==
X-Gm-Message-State: AOJu0YyWJGIHbY/GnGsOvMyWucqpd247AAd9HqlbbY9R18MDnCDu13AF
 hvNIIdu1bTBIeuHveKmyGwIFnBcQsEXMMTjDuRIeQeqJlVtvR1se1A0S
X-Gm-Gg: Acq92OEAxxgY2fIbl/eCJEK8Mqcm31DVFeKx5NyM3N4TD4pg+F5tDZjEBn1VW7ZFeI9
 7rflJDAeVDSeb1WPhEdgLo9wsOspIA7VgGEPlTgPdCupp4p0RcFcG3zxki1ZvjDNfjLBYaLfD3m
 C1g3f7KNG0q+mZIlLPer6c4v1wNdU0w/eJkSNITmTu7mxGFLx8Szd+2V68YwMrO7cOEDhGLpWP9
 tC/9STLmqwMzJoyETdA0Q4mQOx3DRW+OCw8l0LLXu+JLyqGTkiQYAsG55BEhKFp40rzgDVpuyDq
 sOxR/o2eXllgDGB8IBTkzg/gw3VtZrnMtyzgh+fsovVVnySfHs7hFaCxIt2q3QxFKnKVFqkPiNa
 ipdcqxyViJYkAYK0ZM0zYKL7d2UoZEJy4H2IKdwi46krEFOT6l05HNB+HVPiyf16aKvX8Ky+fvr
 UUA7QGNglMotjlGSMHn4DSs0IuQ76o59C4NLuL3YvY1TpukOn4vnq6tVPG4t7/d9u8MM/dwiCWG
 9k=
X-Received: by 2002:a05:7301:6089:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-303986b14b6mr1073226eec.32.1778819186459; 
 Thu, 14 May 2026 21:26:26 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([64.186.250.142])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm6803733eec.3.2026.05.14.21.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 21:26:26 -0700 (PDT)
Date: Fri, 15 May 2026 12:26:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
Message-ID: <agaXcTwX9PiV6Mqr@ZEVORN-PC.localdomain>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
 <agU4-pUgXDvyA2dI@ZEVORN-PC.localdomain>
 <87bjeicxbi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjeicxbi.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 14, 2026 at 07:36:01AM +0100, Alex Bennée wrote:
> Chao Liu <chao.liu.zevorn@gmail.com> writes:
> 
> > Hi Alex,
> > On Mon, May 11, 2026 at 06:04:50PM +0100, Alex Bennée wrote:
> >> This was written initially written by ECA based on its understanding of the
> >> code base. I then expanded it with links to the various documents and
> >> the general coding style.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> 
> >> ---
> >> v4
> >>   - will add AGENTS to list as we go
> >>   - moved QOM, QAPI and trace details into qemu-code-explorer skill
> >>   - add section on Security policy
> >> v3
> >>   - More MUST
> >>   - Remove build and test in favour of agent reference
> >> v2
> >>   - more build details and source overview
> >>   - more on commit style
> >>   - give plan files a place to live
> >>   - add Daniel's agent suggestion
> >> ajb:
> >>   - I made a slight tweak to use pyenv to run single tests
> >> ---
> >>  .gitignore |  1 +
> >>  AGENTS.md  | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 79 insertions(+)
> >>  create mode 100644 AGENTS.md
> >> 
> > Do you think we should add CLAUDE.md, GEMINI.md, or other agent-specific
> > prompt files that simply link to AGENTS.md, to better support different
> > agent CLIs?
> 
> Surely all the mainline agents will read AGENTS.md by now?
> 
That's true, but in terms of skill compatibility specifically, there are
still some subtle differences. I ran detailed tests on opencode, claude,
gemini, and codex, and here are the results:

                       | codex    | claude     | opencode  | gemini
  ---------------------+----------+------------+-----------+----------
  AGENTS.md            | yes (1°) | yes (fb)   | yes (1°)  | no (1)
  .agents/skills/      | yes      | no (2)     | yes       | yes
  SKILL.md             | yes      | yes        | yes       | yes
  native dir           | .codex/  | .claude/   | .opencode/| .gemini/
  x-tool compat        | none     | none       | .cl/.ag(3)| .agents/
  auto-trigger         | yes      | yes        | yes       | yes

  (1°) = primary, (fb) = fallback.

  (1) Gemini CLI natively reads GEMINI.md, not AGENTS.md.  Redirect via
      .gemini/settings.json: { "context": { "fileName": ["AGENTS.md"] } }.

  (2) Claude Code only scans .claude/skills/; .agents/skills/ silently
      ignored.  Workaround: symlink .claude/skills -> ../.agents/skills.

  (3) OpenCode scans both .claude/skills/ and .agents/skills/ as compat
      paths, in addition to its native .opencode/skills/.

The current impl maintains maximum compatibility. If we need to fill
the gaps, a good approach might be to add a script that registers
.agents/skills/ for agents with poorer compatibility.

Also, I'm still trying to test these skills with as many models as
possible. I'll report back once I have results. Thanks Alex for the
contribution.

Thanks,
Chao


