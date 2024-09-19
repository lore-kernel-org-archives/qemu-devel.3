Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDC3CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHJJ-0002qY-Vj; Thu, 19 Sep 2024 09:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srHJ0-0001Zu-08
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:34:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srHIw-0004Rs-0B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:34:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso1049577a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726752880; x=1727357680; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dVOwl7TVYAuQCiKaTOD+iwg1613vIkWsU7lmwzlxW+I=;
 b=AVqwGDfwwbemFyzRkEK36tkabpEoh+gOSjw66N8HqoIDO8Id+MJCBRsjJvwYqpNofM
 mZRQUn386/hwgBqPbrpSHZIRI/6/lyulviokKFB/Qtg34nhO4Djiu66EVFzM6Li0tcCa
 /jxAOsPwE83MBWPGi9ux8cZ6Z1X1jxa+LixWWjvy6wxQ6VRP/3f/Ne9ZXWXQWXejb56i
 ttcSW8eeWz/O6pnBtNDIiXs0ALEU7qb5kdZ/U3u+ambW0+U6KVwsRJgcPRJ4Ts6F1G0D
 9Zj6UqG6YZD66WtcXuhSBz5lX/gZzXqvGY7aSSSLn6mdnjiw6Tx5y4bwDr6ZbScJYj/s
 4X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726752880; x=1727357680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVOwl7TVYAuQCiKaTOD+iwg1613vIkWsU7lmwzlxW+I=;
 b=L3/3C7Mes+0gHJMhpD0h7V5lwNehfCMnyWlDfjEHZVWGfMgNTiV1alHdYcQyLm5MaS
 T9dcoTmMw5FbSUslwTrsKtD12Q84arlejE7OPB96cGadFqKR91wW4pJCYeNIQENAtypU
 fX8p5t9x6BreUq6gmRCIwXajs/2ll1gU3EVFzc/pcVVAC/qYJihUC0tGfiLvxifBxLf2
 aHB1GsMD1opJsJ4sp4x5xq7e2RgFd8KFg/LGY/Zuvd1dwGL3/KjKjpyw57jq3LYL0nDe
 B38ATmaNSUpXQtExhgE4ogITE2TULy6REqL8erUkyGhmWMbPzjTUNeLHMcD1paGuZO5O
 dqIQ==
X-Gm-Message-State: AOJu0YxjMzj585v3tDiZb6lZOX+KYrh8QLYaHOy9NKgd09Aa5eFnBN53
 iXNB5/7cug3topTax8pxlM8dXE5QhXenak+v94YWANf6eLvS3For+6AgBh3t8yqEwHy6ixnGKIJ
 NB3iGIK8USCTYrmjAxUJPtLKGin6p1SWjrar6v6F9BxegdQ7D
X-Google-Smtp-Source: AGHT+IGCPA7EPY+dCI71UJyAZPV20SjoqdnWXYnzvZkAxUA9UrbnIEFjCGREml3MWwQV9TsY+eSwFxC1l6q0zDdizKI=
X-Received: by 2002:a05:6402:4303:b0:5c4:2343:1236 with SMTP id
 4fb4d7f45d1cf-5c4234314d9mr18169049a12.4.1726752880259; Thu, 19 Sep 2024
 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240918183151.6413-1-peterx@redhat.com>
 <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
 <ZuwSGJODsyj_bA4P@x1n>
In-Reply-To: <ZuwSGJODsyj_bA4P@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 14:34:28 +0100
Message-ID: <CAFEAcA_9HKtTciFtrs9T9PG06GgYdoDoCASeBi7wO9CswA=1tw@mail.gmail.com>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 19 Sept 2024 at 12:59, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 19, 2024 at 10:08:25AM +0100, Peter Maydell wrote:
> > Thanks for looking at the issues with the migration tests.
> > This run went through first time without my needing to retry any
> > jobs, so fingers crossed that we have at least improved the reliability.
> > (I have a feeling there's still something funny with the k8s runners,
> > but that's not migration-test specific, it's just that test tends
> > to be the longest running and so most likely to be affected.)
>
> Kudos all go to Fabiano for debugging the hard problem.
>
> And yes, please let either of us know if it fails again, we can either keep
> looking, or still can disable it when necessary (if it takes long to debug).

On the subject of potential races in the migration code,
there's a couple of outstanding Coverity issues that might
be worth looking at. If they're false-positives let me know
and I can reclassify them in Coverity.

CID 1527402: In migrate_fd_cleanup() Coverity thinks there's
a race because we read s->to_dst_file in the "if (s->to_dst_file)"
check without holding the qemu_file_lock. This might be a
false-positive because the race Coverity identifies happens
if two threads both call migrate_fd_cleanup() at the same
time, which is probably not permitted. (But OTOH taking a
mutex gets you for free any necessary memory barriers...)

CID 1527413: In postcopy_pause_incoming() we read
mis->postcopy_qemufile_dst without holding the
postcopy_prio_thread_mutex which we use to protect the write
to that field, so Coverity thinks there's a race if two
threads call this function at once.

(The only other migration Coverity issue is CID 1560071,
which is the "better to use pstrcpy()" not-really-a-bug
we discussed in another thread.)

thanks
-- PMM

