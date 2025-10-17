Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B26CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 10:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9hcn-0000dG-Kk; Fri, 17 Oct 2025 06:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9hcl-0000d8-Su
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 06:23:52 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9hch-0003Fq-Po
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 06:23:51 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6353e91a04aso1821455d50.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760696625; x=1761301425; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ScWagkmQu+GRc2/9CFYu0pgmD/tB5TnUP9mxXkrdzos=;
 b=reVNQC+YQsvV1Kxr4+vKH7MAJ6H7TS87/M7h5KU7KFPQejnz5JHBLBGTSjYJD3T+fU
 jdNADGmrph1edUvaCG8mqJ6ewISjwVkpg/Ot+QDvJjf8m59pezN5Zfoj/Mq+pvn3i007
 5OwH/ZTpoA+qip3Vll1bN/eHqzMe9xdRlwsRJnehoaRRBVsiAuSPBAmaWhKOYEfbYnAO
 nH08Hy3hyS3aviXO6TotDGhqBi6zCcufurEpKLRmkXqNdZLwT1F7PhpFK1IUUheWp/83
 3sfMHgufHLFjOK+pWlB17R+DvU8vxkAcpKuIJOp5mUJqQLnXBIaiPdLlRhk/R66FjyJI
 colg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760696625; x=1761301425;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ScWagkmQu+GRc2/9CFYu0pgmD/tB5TnUP9mxXkrdzos=;
 b=dfBp18sgYFASCnsLd6bYBbtuyh0kfzdHsre3rcrA7vr0XLYIvYgHzf64q+q6YWhH7O
 7Gq04LXhBPkceaXS0pjTdFdalYlDawU8hVaXNSQpPDD70ppI9V4YR+6sj/StfxSPwrnA
 of4RfTYwUKFGmgBIvZnzl4h01lOB+yRPB92jN6mXcR8D3IMShcgQA5GVYm/n5W8y10NZ
 VRCwMXe+TVZ+sMz/+I7mohRUjkJ+aJiA1xIHS2RhYPJvolBgUC8fcG1LuRg5vFWOm7wa
 WBzlDDHm4ZwE8mZASlHMQLr44ehlBmOvGomUtRKU/MlWszsnRjfO6P7A2MhN5Ie/wUT5
 fBQA==
X-Gm-Message-State: AOJu0YwjULmHGS/UcQobh3zjO8Q0SoewOqTuNrBu1+UafVs0pppA9Y17
 gXpeElAZu91KXMIyiQGturnIH8HCTrAaUj2+dXj4B6SwstaC49I+kdCU8t860byZUrWGj1IwNzw
 qvsQJrItiJBr6XLJ8q0EG6WPoJ0FMgSawB18wTS1oPxNXdHdzyi92
X-Gm-Gg: ASbGncuyG1wbWvfj4EJ6aRvlfRGWCgrcruOM7J/+bBnqQw5ayl26OG+nUvdf9HyUZNs
 MpGZySNchMZx3MCTjH10rhs5gQ8D/MAmI5eIRC5dT0qAYhxnbYcQYgK5HgG++P+qsaNsSHvQUE+
 wkzFtL0hUHbMlJsHcgK1QBSHqfXtFZRqQ381MzYQd7q2APGEsUKNq0pZUIRn0wlCGpIDhxfLIim
 8JSdL+aAsHffQ4Dn8846WyqSH0vRe4oPxU2KIb4pc8YMHf8zZ1+A6kaFhp8LcOa4KHQ8ADg
X-Google-Smtp-Source: AGHT+IE8gVC2m9y0QsE8vtJ9m5qO3776XgBwNun7WGeUs8NT6P4TiE+y6NNC/1CAjpyEV/C2MwCFdFkMdZ8a5klqLGs=
X-Received: by 2002:a05:690c:f89:b0:783:7143:d82a with SMTP id
 00721157ae682-7837143e0f2mr39398257b3.21.1760696624846; Fri, 17 Oct 2025
 03:23:44 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 11:23:33 +0100
X-Gm-Features: AS18NWCSyPbqT-IIhBKBIgf0Hjb-yBJK4anuHIOwyD5aGTKapn0G4o7F3CAVtoI
Message-ID: <CAFEAcA-OmqRTqwYZ2WCeqFu=zxG65t6WSfKR=NthfpazrjzpzA@mail.gmail.com>
Subject: QEMU Summit Minutes 2025
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
invite-only meeting for the most active maintainers and submaintainers
in the project, and we discuss various project-wide issues, usually
process stuff. We then post the minutes of the meeting to the list as
a jumping off point for wider discussion and for those who weren't
able to attend.

Attendees
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Markus Armbruster
Alex Benn=C3=A9e
Daniel P. Berrang=C3=A9
Paolo Bonzini
Mark Cave-Ayland
Alex Graf
Stefan Hajnoczi
Richard Henderson
Thomas Huth
C=C3=A9dric Le Goater
Philippe Mathieu-Daud=C3=A9
Peter Maydell
Michael S. Tsirkin
Kevin Wolf
David Woodhouse

Agenda
=3D=3D=3D=3D=3D=3D

Finances
--------

- The KVM Forum conference made a small profit; as with last year, we
  plan to use this to help with the financing of the conference in
  future years.

CI
--

- We have an Azure -> AWS CI hosting migration coming up as we have no
  more Azure credits and we have AWS credits now.
- CI is still unreliable. We need to be more proactive at reporting
  failures. qemu.git maintainers should submit issues when tests are
  flaky so that test owners and private runner owners are aware of
  test problems.

AI policy
---------

- Following the publication of our initial AI policy, there was discussion
  about whether there had been any initial feedback or if there were
  tweaks we wanted to make to it.

- Generally there didn't seem to have been much feedback so far (from
  actual developers as opposed to the peanut gallery). The general
  principle behind the policy is to protect the project from legal risks
  related to copyright and license status of the output. There was
  some discussion of whether there were simple useful cases where we
  would be willing to take AI tool output that was an essentially
  mechanical transformation with "limited creative content".

- There was no consensus in the meeting on whether we should
  consider this sort of change to the policy now, or whether we
  should give the initial policy some time, and collect feedback
  based on that longer term experience before making changes.

- There is a patch on the mailing list proposing a change
  to the policy to allow this kind of "limited creative content"
  contribution:
  https://lore.kernel.org/qemu-devel/20250925075630.352720-1-pbonzini@redha=
t.com/

- We plan to solicit feedback in spring next year on how the policy has
  worked out in practice.

Release tarballs
----------------

- Our release tarballs are quite large, and 85% of them is just the
  source of EDK2 which we include as the corresponding source for the
  EDK2 ROM blobs. This seems a bit silly, since most consumers of the
  tarball are either:
   - downstream distros who will want to build their own ROM blobs
     from the real upstream sources
   - end users who don't want to build the ROM blobs at all

- We could perhaps usefully split the tarballs so that the ROM sources
  and the ROM blobs are in their own tarballs and only people who need
  them download them.

- Relatedly, it would be nice for the ROM blobs to be trivially
  regenerable by anybody, rather than the current ad-hoc "some
  trusted person builds a binary locally and we commit it to git"
  setup. This should be much easier in these days of containers than
  it was when we first started committing compiled blobs to git.

- However, nothing is fundamentally broken with our current setup, so
  unless anybody who really wants to do this work is going to step
  up we probably won't do anything ;-)

Shifting styles and incomplete API conversions
----------------------------------------------

- The project has lots of ways of achieving similar things with qdev, QOM,
  etc. This makes it hard for contributors and reviewers to know how
  something should be written, or which style to recommend in review.
  Being asked to change APIs/style is disheartening.
  This is unlikely to be something we can address easily, but some
  things to aim for that came up in the conversation:
  - we should be clear which APIs are legacy and must not be used in
    new code
  - we should update the old "unfinished transition" wiki page

- In particular, there is no current consensus on QOM casts
  - Using the cast macros looks the neatest stylistically
  - But it has a runtime overhead, which is irksome in cases where
    actually at compile time we can be certain the pointer is of
    a valid type (e.g. cast to parent type)
  - Different reviewers put different weight on these factors,
    causing conflicts about what to prefer.


thanks
-- PMM

