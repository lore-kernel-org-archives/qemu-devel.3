Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD6CFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGz7P-0008FW-Uu; Sun, 26 Apr 2026 09:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGz7J-0008Et-4M
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:01:45 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGz7H-0007W4-L0
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:01:44 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65005a8840dso7819630d50.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777208502; cv=none;
 d=google.com; s=arc-20240605;
 b=azb1lmKzo6UG1CiixXJHzSWaeMvxBWu3eLXXbgocKE7xo8mCbTpN8QqLi7hZ2F5BW3
 iH4daeLJPHLstVoZCfaAhK8sMbLmdgcAkvpN8pQO6oVKFavTlYu0G0v6vuLR9BoB8oy8
 ZNzXX7udfnvtGtvBTe343C1lZPbY3X1HPF3/jFQQFEaep1vfpwPqZ37ghHyUWrwRoeOJ
 spo835Wf0njQNevCOQvj8GOhp7GV/6UZ8fZ8+wZ6t4pDSoaE4AXeqSA9p1uHZHv57TXJ
 cst4BdeJusUtK8A56AY8TglI8GhiuN/7Qjyvp86nwsv7Xjm7DsBMioCr6MzcshTnXahv
 3d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zB4T+EbXJqkH4ADcFs+27cc6y6dRBgoS/fPm5xgAExk=;
 fh=bVAjZsnX9UB/+Cqpm8NkuB9varEVtoOfOkjiYudRcMA=;
 b=AR2lXa3gxgqOee5COHucsDHPSWPgRdnwFhd4rNpGS96Mpyen5zOcOF30uR0kZ9rufl
 UQnI3t3QM++5NCwosNsuna47p4fY2Dlj2pwOMOrs8VM3pG4OD4BhnN2t2gyjb16J/6GD
 rB9so+0vVYWJR6bHr8kphgbx5QGPXlvcBa7QCo1yH5AtBwhuJxY8lCFM+iJMTltvgG5G
 FgTG4NBMYRvEFuFlewhS7ihhURvF89LxhZveKjGI/WeF9ckrQhquIfQ374G5i77Ju8dq
 mdl+hKlT5ER/Kb9wBfLoBrzWtcHE0uWYL4kOnWgpJLe8SF8em1UIRyp69+bJz9AL3RbR
 KdeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777208502; x=1777813302; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zB4T+EbXJqkH4ADcFs+27cc6y6dRBgoS/fPm5xgAExk=;
 b=G05WdCplyaBwAYTHcVzaHXlnk+G/7EMd6+CgMkC1p85Ph5PgqslvVbf5ZZHK8H4+Wu
 nOzIXeCwkZOG556WT6868/HZ3Wklwj9shN/WVvhNd5Q/VvTdK573/xqEgpf4T6E59DUr
 xRNe3OhfMsElxjdutflQT7oywPsj08TBywrWLYa3n70j+7OfQGob8addg0WPMBR74DF3
 8WmtEOxUH5onhCJCny9TkFtJMATuP87mWF4drK+tTrnAsOWOuZgzzGeKoQZrOQoDPRQV
 Mu2+ypuwQETIsR02/dOAq/8vwwEnfV+LkL1pGQ4LkicgwLegvfMXIXhrXDAKJOpfFDzx
 HzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777208502; x=1777813302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zB4T+EbXJqkH4ADcFs+27cc6y6dRBgoS/fPm5xgAExk=;
 b=F/S5Bhkcj21eVD56LMCN1DCKEG8pE9E1yluKJW42fU6/zOfeos7KXwlFQ5MG+qhwb2
 cUKDg9sD9Xw+U2bHB4GWZ6Jh17jelT4/bKChdrvizfhHG7BdjcZYW4KKdgL3t7Vdv6lD
 +CuAgBibawZAqsOSat1CAxxTFs7gFoh2/hCZsePXywikL1VlEWQk4goHEsmsh8ETlTS1
 yQqYOLWKUeos9KrrABs0iIgE+FlXyfSMBhVWL07gZLnvai6EsMeularY5zjJjNrfOL++
 3RZ2RqNqKaTMC145wsKTV2PNkdTCzeiUMeE+lUdLotbTA6zkbSQMTvSkw5PPJFjEZlbD
 HlJw==
X-Gm-Message-State: AOJu0YyQII4eyXkTT16PNha2SCCZ2xK1EbuCtTgP5nkkW1sX4LRV40Il
 LypjJxNgxcpxIq4M9DH1C+xcn2xF5An/YkvT44bFPvDvwA/lq+FQYVLxfmD0U4ZqPerNSwIFdXn
 VyheC1fzvr58mjPzz/5rQw0gWTtjjYWQP+ijSE2H0Ng==
X-Gm-Gg: AeBDieusieu9Lq1wt+dwyC3jO4GrJnx4eX1VFrlu+2AqsCRDZfqKrHCJL+CZmQNeTtg
 95k58S8g1PYG5SBhrnYvRUsZCUMYR3t9rYzZY+edajvtJ2Cfz4YRCDxA0gB4WR8/20X1Facs1PF
 nH9JnWd5MnUQlXe9YbAc9ILN/EqOPWvYuQ5tVDoUG3fM3n2ITDsD+upMpJMZmPcl/5DrO8O1B4e
 osdiWHRtmZSs/78tAU8ZVbydfpqSTw3uKOMBoOfTwzRbG7NMDACeKT/C0lAIMBnghX14GIfEiyR
 FH2mIQYZSIgsDIPzALy9nTdbTGLT4GuRqsnSzAlhWZuhSlTWo8P0ELl3FAo/cgS7jX0shNUItXC
 TbQ==
X-Received: by 2002:a53:b3cc:0:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-65310a1360bmr26792633d50.35.1777208502173; Sun, 26 Apr 2026
 06:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260425144852.46590-1-deller@kernel.org>
In-Reply-To: <20260425144852.46590-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Apr 2026 14:01:30 +0100
X-Gm-Features: AQROBzD-tEHBFqwnZjrAAvsAcxT_clzvc2WRagMGJ6HpHy5a-iJ7NpxgN8tJRMk
Message-ID: <CAFEAcA_hODcBVXw0TsHMXFipgh5+mwSrGEuHhCUOdtt186QP6g@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 25 Apr 2026 at 15:49, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Qemu user mode does not properly flushes error messages related to bad
> arguments when exiting (at least when the output is piped to a file
> instead of running on a terminal).
> Ensure that we always flush by using exit() instead of _exit().
>
> Reported by: Tobias Bergkvist
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c49d1e91d2..84e110dfe9 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -767,7 +767,7 @@ int main(int argc, char **argv, char **envp)
>          execfd = open(exec_path, O_RDONLY);
>          if (execfd < 0) {
>              printf("Error while loading %s: %s\n", exec_path, strerror(errno));
> -            _exit(EXIT_FAILURE);
> +            exit(EXIT_FAILURE);
>          }
>      }

How about the other _exit() further down in the function
for the case where loader_exec() fails ? That seems like
it would have the same problem.

-- PMM

