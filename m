Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2FFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH4n-0005Jw-MA; Mon, 27 Apr 2026 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHH4m-0005FQ-4x
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:12:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHH4k-0003TG-Gh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:12:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso5396203f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777277535; x=1777882335; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2q5LpL17iNf3C+6crpYy7BsXt017YD6GKFZfJklSkh4=;
 b=W5cvGhbt41NDi+rZ9IeMCfBf8wk8jyQJMqV5Ezeff2n+h2aG2pJ59DbHJDnIeFHKKt
 fgn1PESMSJ8XiJAu8ourgPv6HyKOPPw29a99BtD2WlGP0yuR+NQN29TEOTXwwvuXtTpw
 RULJhrrNhLnoKSK/mvYufCUlyhPaAjnZ8+WMCdifxhEOC99+NOjO056ccN5T8IzJNTSV
 oz0Kjq556Qb3OafTpXsI7GjTCJaprAGNUXKi3ruyWNrb2jAiyDxNF3V51ftJP9eVDiUT
 ULq495xqzu+HJuoUj3uRP04UuFl7a2NJAS2vGh0fX/8Oim2kfNO2dt5OhQ12uWLGXyuN
 aWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277535; x=1777882335;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2q5LpL17iNf3C+6crpYy7BsXt017YD6GKFZfJklSkh4=;
 b=WMexfmbD9NnjOn0Z+PpV8YjygWUrzkIxma7UrddJc0QGrhan1CX2KToMCdTN40fa00
 OkYPL21zsFwPspcvDQP5IkZwNqE04uRq23IcQF9Dx//OtM4BNcwdbLU5dZCTCqIk/c8c
 tMY0Me3mi9VRV+vUExnj1HCNlzSOBEvQbeYHp7wCshhS7TBy8LSHClVKAL4Ba6whBnkt
 UvwBEcEEq9T4ubBJ890GWtKkYYyr0zHzT6b1IumACktJ+v6A/EfG3rfbDZHs6xTKec9v
 3J7pXL4VLyv0UL04gfyoHDkXIv3xvtuOdr/yMaAVlV3A65zz2bYpghUYWxjZ4OOa5wHv
 Aufg==
X-Gm-Message-State: AOJu0YxlML1x5hbclc7opAO1KR/uRbpNoQ1Abk87zRTMA4ViLJo4VLR+
 k6U43rtCyQuGIijb8kZasG8T1f/qTPAJmdFFdQEwwXXWr6MsDPE0aojswEnmcW77
X-Gm-Gg: AeBDiev/Y/BAnzyw8r1n5h8GxY3r0Qu3dBpIduWS5zE9/ySfG9sFFuUf8bf6MWHLYSo
 jClBT4qeKiw8BDA4RKtaHH5zkrHLlRhNByxZY9te9rYAG3fpBSfSWRpTc2l6XKi1dT9Nvv0xzTC
 9uq2nBUsZNxQNbtJjlSEhBzt4VgZO0t8aSTrzgOOdZQKcpsQIF9aMnUJQ45MgqhZ74kvBmmLY8Q
 PTjmUwP7UNaFnPy68PQDi99uFAXISIXK2l8yBRFVfvYSYwlLOXk7uQMiHzIjgddriAAFzm1eSUV
 KXpIbNz//KNDmFc8rQQJHkYDhCd1+MYxnYMseHscH2FcCmMtKiXKi1BKNOG7+Y27B5NxpEHumv/
 P7RsTyIG2LpYRdhkazndp8ehZkwST3FlWArC6lW1lDUXoEweXaj1hp71v8s4JV43lI7TN4PYzzN
 oGfhaEJZPI9/I+2zE8el410PupNe8ymZ9B5JpVjlPc2Q5jSmZ/5KDw2pOvJafG1TiDnw==
X-Received: by 2002:a05:6000:240e:b0:43c:fe59:40da with SMTP id
 ffacd0b85a97d-43fe3e0bb95mr62389309f8f.47.1777277534840; 
 Mon, 27 Apr 2026 01:12:14 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm80088985f8f.4.2026.04.27.01.12.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:12:14 -0700 (PDT)
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Message-Id: <73E79A4E-C0AA-499C-84ED-81FC5C1A8972@gmail.com>
Date: Mon, 27 Apr 2026 11:12:02 +0300
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wr1-x436.google.com
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

Oh-uh.

I=E2=80=99m baffled
At the time of writing this issue, it wouldn=E2=80=99t load on either =
the source code version or the Debian Mac OS X version. However, now =E2=80=
=94 without any changes to the code whatsoever =E2=80=94 it works on the =
source code version, but still does NOT work on the Debian version
I even tried checking out version 10.0.1, on which the bug was =
reproducible, but it no longer reproduces! Has someone done a rebase?=

