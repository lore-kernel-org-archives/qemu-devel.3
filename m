Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9117CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 16:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQSni-0004vW-Te; Fri, 22 May 2026 12:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQSne-0004ud-9g
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:32:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQSna-0001Ci-6Y
 for qemu-devel@nongnu.org; Fri, 22 May 2026 12:32:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso9468515e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779467552; x=1780072352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hsNsyJVNcWSO04d87bUHfOP4iWA2739eXSxbnApeGbE=;
 b=Iv14sUUxUdrJk2rfKTMG/b0jGw9IxBlr77Ey/c0dNy4X0QAqDVs+AVLDZY9sKhabO1
 zGqQQK4HRiPZ+B0er+hZrh/o2Ud/Er/RA273CjvQSdO8ROTKHttwmzDE+6ocSDk8on8R
 GBJKVHSvDjlzgybh6duEsMv/X0A6nTs9eS1e0hZGAXlF9WJFI2nO442BkQi3OiuO1foA
 mUuVodwx7V5j9o0+9Fyzg3YuWwFDzQfBUIIA7qqFUsw3RG5l5C1WlgHRkSyITP4YVIxs
 jkU7FKjIbZi//Xec2BxhGCuuF0tUyBwxIXHMyFLhUmSsFiW0/rK8ZqB0iGO/uFJUVq8o
 AEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779467552; x=1780072352;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hsNsyJVNcWSO04d87bUHfOP4iWA2739eXSxbnApeGbE=;
 b=mdGgHI19oYFs4l0tI9ewm7bJdZx0LQc+NpJupzjpCdslKjEk30HoCkel59QH3pvolz
 TmZNjISme0uX5bLUFm97fdpwBpfMcIbFzlttPWywQLb+jsVMAhPbcKj/VZe8fMFN1myj
 mwkbijcYaIJrLR7KCJ56V4Q3jKgvy0YJ+YIRrnNR/Q3IohuhpQ5etcZ94LyqN7Cbc77d
 tuw0ZS9AydD+58XMVx1fJw8RjT+1FPnolXXBFWF8Cmfc7wlN7d+dVrQYPHIqJB7k9P2R
 fkWBd3e0oXAq0+5+wKQUcmA3qQ4acOWdj5iAZtTGgztPNlrFsXjK72erF6W2shO02+vl
 ys8w==
X-Gm-Message-State: AOJu0Yxd2mVXFuAldbbxFg/XX0A2fBEbYylUxHrTnjnXI+tJkiLhy1ZI
 RJjqYA9E/vtHDqrcn0ueYX41S7N0+23qLJq4IuFnzhITud6EkbtP04qZbjhnbCKhJ/0=
X-Gm-Gg: Acq92OEZQbWo9QTvTrNkIImFI7CBzLmOKMrvU6BTQueyriN5zRsR2WOO3+PhhKCcNOQ
 WnlgmuE7LpGWMYVp18Z/3kyMenrUEPjlXuZS3wudnLmwLN4BjkeLjHbmizN3pD9F2fOJ1vhRFh1
 Eai7219KOVDpxnquk+HeE9HWJQqUNzGHVG880eSCAjtBLGfGtUl5B9EU7BQNienjJAq7VryY75C
 p3OaZKTAJ+ZM/ctwrdwarLJw0HK/wtHNxLjJe23lK/ahS5cjpeqEjPF1/fbhM79HZL0p/gLAtGf
 ViSlVBmXX7IRmkyqdhn5KTNG8qvB856wIJS0Z/+Z0GCfcY25ZwpRqxuqQBXS8/dC9ciiulA0Z3w
 f4PxU4o1b3d4f/lQ9IpCq8oC1XeotVa3Y1xWUrDbLl/cT7jXZcLYN9E8SjIVLosb2QMOiUzZe45
 fS6kIE1IdiJAx3EYwDUqUDkdk=
X-Received: by 2002:a05:600c:3592:b0:490:44eb:c1d9 with SMTP id
 5b1f17b1804b1-49044ebc292mr68451315e9.28.1779467552049; 
 Fri, 22 May 2026 09:32:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f6ffsm5149273f8f.1.2026.05.22.09.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:32:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 773895F8BA;
 Fri, 22 May 2026 17:32:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: GitLab issue tracker at inbox 0 (for unlabelled issues ;-)
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 22 May 2026 17:32:30 +0100
Message-ID: <87zf1rl80x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Hi,

I've finally finished working our way through the backlog of un-tagged
issues in the tracker. This has been done with an AI agent following the
"qemu-issue-triage" skill from my recent agent skills series:

  Message-ID: <20260515163055.1792262-1-alex.bennee@linaro.org>
  Date: Fri, 15 May 2026 17:30:43 +0100
  Subject: [RFC PATCH v3 00/11] AGENTS.md and associated skills

I've been sampling the results as I've gone along and am pretty happy
with how the agents have performed. If you do find the agent has gone
off on one can you tag me or the agent in a comment on the bug in
question and we can try and improve the triage skills.

We currently have 1271 open issues in the tracker. Of those:

  124 are tagged Needs Info
  50 have patches linked
  151 are Feature Requests
  71 have TestCases attached
  16 are identified as Regressions
  ...
  and many more

A lot of the older issues ended up with Needs Info because they are
reported against older versions of QEMU outside the support range.
Daniel did suggest maybe we should think about having
"triage::outdated-version" and "triage::distro-package" states. However
maybe it is enough to stick with Needs Info and just auto expire bugs
that have stayed in that state for long enough (6-12 months?).

Of course triaging is only the first step, I encourage maintainers to go
check their labels and see if any bugs have been missed. I have found
adding tabs to the Work Items view with interesting sets of labels has
helped in sorting through the noise.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

