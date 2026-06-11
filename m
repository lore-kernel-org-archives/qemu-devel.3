Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA184CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXhBc-0000m0-9T; Thu, 11 Jun 2026 11:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXhBZ-0000ln-34
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:19:13 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXhBX-0006ds-F5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:19:12 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-137eb0d76beso756959c88.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781191150; cv=none;
 d=google.com; s=arc-20240605;
 b=fQgV5zzlw5QLiGAhI7HT+qqeseW+RK9AVBsYAIYl6XFwrOR84QVpzW5l7lfxvof9W0
 /RKgS5k23gcCtfKe/FV05ImTy1aBOywnv9o7X6kBYK1GRxkuTcN7gs/5s9qD80buFYkU
 sxk7Qk0w2oJmWYZWYUiKHrNLkBxPfdNJNJoFnL3UZeMFICJ/SiV7ma80DRZkZVR8M/kr
 +ll5MBuIFKmyb6fC+RRGy/UfyB/6U3Rane7twhK397hLnSvNrs6qYlJ/mTggGYGrtnWu
 TmJiZ4aYni96+pQfJs26yxGkhDh5RIrgx0ZaoJTNiS3afxKvSLjB1oiraRYTHzFP+wyv
 148Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u923QbB4SCld0rQnFLJOyAFY96nkPI+t+8UsFDVZx7U=;
 fh=UWZJumQUzzkNCzFKeimMAwI+dlWXXb/0g5ZT8EmWBJ4=;
 b=CL6DYsn8dfptShFDBsrEO6xK1Y6enjn2g/x4tnKLYD11rk4bb30k4vdqhwSm+QUNaY
 VG8Apo0AKk1tawNsAXAZdq8hj7YRlnN9Ck9yC96HPudzfyoz959xydA1idTjeHK85rDu
 g4N3mR/WKQlR20QzHEXFCvuxeQky0VRaoPQmeP2gALRMnQDF4t8MTT24BXvpAI2n6QtZ
 k51F1z6QwQ9och7TchPgDDTUhEmgMrmxV3WliwAHTAZEKxVT1T/+en2CR5Kf7c1tPBUs
 ZoOE1CAqs8OoQ1nFxLZEkn2q9t3J/94tBnnt+hOBdT562wAh2LphEobgxYiU33z6Qmm4
 Kn8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781191150; x=1781795950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u923QbB4SCld0rQnFLJOyAFY96nkPI+t+8UsFDVZx7U=;
 b=EtDRDngPrDn4HJ80FyySqj6jsD52yqRR3Vw2piQ/uf2xG9riXnZl6Q2c/O1CkcCO+v
 /aiva+WKv/RvZHr6GtO2XvYYGRRD4C2LLtN57pxd4ZlchzxrXj0nsEP8H+Sh1qqzUwFM
 RfcjgCb9yLz5lUgR4Hc/xqisvyqgZjgimX85aumO3BpaVLUpbZXbfD4rkAvt98j5oYtY
 Pq299+0+1O2OzEYggVHu46+paVb+tNND47fghJlBJME5EvLIdNS8T7l9faXDL1LvcyMO
 vwHoWGaNQUH2hqpYSaJ7SGcQNiQLPF9u2EDVUMBuQALXWVWO1TqBNoGQ0Uw4ZVKjthAx
 xuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781191150; x=1781795950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u923QbB4SCld0rQnFLJOyAFY96nkPI+t+8UsFDVZx7U=;
 b=bvhPOLscKM8SYmGdq09mzH1BlHpDbR6kameM3VO2R5hWn16XbB0z4/BE1Cr1S5A734
 wEFfCwIpNwACw2ShHrjFR3kjxkFUlM75Dc+OSBFOUHSAZPvv0sAEGXu6+s5VYcmeCRA1
 zI7T9YVcqtN7CBfJCvT8FJ5WIelOXeJn9qtAcW6pIyNOMZtKPKJig4OSQdb1OFuRXW5W
 USm7m2iq1PmauwwSDkDS0qEf03NtDc4bu+g/iW3r5+6jC2f3OnuCDaEQZFbheAc2Znna
 9piUpLsvTwB5q0PMsa+XKBm5P9AssacaAR2tGt4wHY7t/jWzFW32JHQlI3VACZUzM09r
 0vHA==
X-Gm-Message-State: AOJu0YzZswcAqwZ/5t9jjvKvXEmHrRBkXVV7y4lkqxC/RIrLrl8sqrmB
 om5NACjCF4z3X0zs0dDfxVxj+pgeCIhmXkEGDDSpJ2hXAyhnjER9I7cjcroJ/HFWzW4pC7t2zpm
 cp7HZa9hh2PwHyDjasdcsuSlEQecvgTU=
X-Gm-Gg: Acq92OEQe/3vWtaX79h3N+4WECXLPxu8j0ri/Iq+y3kVTs3dv5sEQH9PCzMAxkxElQE
 12Dt5fCU+e+VhfUvd/g1ZDTh6Zk8ENI/3Oktu2rf1z136ejaxE1RAXmkrI7wrHSgeTgFxSGLQy4
 TAEWL/nzoiuE6B6lapp+q1ZZeEIZojqQbda8fDQeU70PVaEwquo13A/dvYM1E0NiC5Phr1O4wWD
 eIhp9kTeVGLm06+67CM1fDbLkcMQ1+iV96Ds43DgJXorS2oCowSHugrcdo+NmrWUVhAdSOheYEg
 QMkDDvy5dS2yZJClzIXgHgskXkoFLiZ4LTDNDH2698AEunvjiv8Q
X-Received: by 2002:a05:7022:1b05:b0:132:c944:9ec7 with SMTP id
 a92af1059eb24-13842fcba46mr1408435c88.1.1781191149685; Thu, 11 Jun 2026
 08:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781095539.git.yong.huang@bitdeer.com>
In-Reply-To: <cover.1781095539.git.yong.huang@bitdeer.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Jun 2026 11:18:53 -0400
X-Gm-Features: AVVi8CfS2hfVJ6fhHy3BS4VGpOVBS-q3AlXWiwdzR9IZLJBOra5bh5DBf_50tYU
Message-ID: <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
Subject: Re: [PULL 0/1] dirtylimit improvement
To: infra.ai.cloud@bitdeer.com
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@bitdeer.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=stefanha@gmail.com; helo=mail-dl1-x1234.google.com
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

On Wed, Jun 10, 2026 at 9:15=E2=80=AFPM <infra.ai.cloud@bitdeer.com> wrote:
>
> From: Hyman Huang <yong.huang@bitdeer.com>

Hi Hyman Huang,
Is this pull request intended for qemu.git/master?

I did not see any previous pull requests from you in QEMU's git log.
It looks like your previous dirtylimit work went through the migration
tree. Do you intend to start sending pull requests now and are the
migration maintainers aware?

Please follow the pull request process and sign your pull request with
your GPG key:
https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html

Thanks,
Stefan

>
> The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d15=
06:
>
>   Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/qe=
mu into staging (2026-06-09 14:00:28 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-re=
quest-20260611
>
> for you to fetch changes up to 3b224b1c7df1ddefd6bca34f201264d72846c397:
>
>   accel/kvm: event-driven wakeup for dirty ring reaper thread (2026-06-11=
 08:22:50 +0800)
>
> ----------------------------------------------------------------
> dirtylimit: refactor dirty ring reaper thread with event-driven wakeup
>
> ----------------------------------------------------------------
> Bin Guo (1):
>       accel/kvm: event-driven wakeup for dirty ring reaper thread
>
>  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
>  accel/stubs/kvm-stub.c   |  4 ++++
>  include/system/kvm.h     |  7 +++++++
>  include/system/kvm_int.h |  3 +++
>  system/dirtylimit.c      |  2 ++
>  5 files changed, 52 insertions(+), 6 deletions(-)
>
> --
> 2.43.0
>
>

