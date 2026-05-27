Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29989CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 09:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSAKr-00056b-Gd; Wed, 27 May 2026 05:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSAKn-00056P-NO
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:13:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSAKm-0007In-1Q
 for qemu-devel@nongnu.org; Wed, 27 May 2026 05:13:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so8128477f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779873230; x=1780478030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k89uV43GsFYF7LuEhcEFZMHEV5G0rCccRoV7T0MulpU=;
 b=XT5iW04rEQ2mFc+96NQeghen7HPpWL92y/U9chpxj4PrYuGwaqPQ2vXhLiWc4nrM9x
 RlwAZO/qk11o4Hcv9IBY28Q3DIU04s5ttQBi2647YMqUaOz/hS3XwzdLAFnhlPwNQ/ED
 e+tTEBZaGJkKh+DAS7vEqMCvBh9n9fgjrFnAAqxc/DUhLtg3koUBWce/cn7ThI8wi60I
 hiF5RZJkvrc8rLbYDItLyuWRFNPD0zxVke+ZbZYSWDMS+zx9BgtjBEQl1gA4UoV61xd8
 hk/7kE3J2V76D/PfX0xUpDXg9JY/fVILckeI3fM4gL8wD5Dh3eNy83bspZ0cUglfvyBD
 REYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779873230; x=1780478030;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k89uV43GsFYF7LuEhcEFZMHEV5G0rCccRoV7T0MulpU=;
 b=EpXLIP9o67FWn+l61xYpa6AJECM1qy6S1G4NnhiVpEp0auqeWyVO/ougnkMiQbzhYg
 PHg5v/XsxEp/UcWJdMk+BeNeap+hffMCJLWOvLo5bXboRiisHr3kYgcYhIyYw6027fCX
 b3CsvSqs0HbL7dCtwdo4dD047IKUZJjygqd3/FStCdGPTND7ajXo9Rt7LfEB2XTiKfXQ
 MUvpQ4WubFYo+5PQlL3oXD0TY+BUwJoiA/ZR1P4hGMW34CoWZJM6GqjU8DH+8m42H9FA
 GoBN05H92q7zxx8WES+lj2WOvL4ISxXbXDgAyKsMefzhsteKAL4yrtovBGRrN2jJQGgS
 j2iA==
X-Gm-Message-State: AOJu0YxE/bKDIeB+jtUk7nMBjzeMNBKBOr/SgB2qLcxEYOumz5M1dapA
 /E/mNqr9kbXmAZzlbzdPAmmRzTQVs4JSqn3cjo4iGd+jKEq1c1ShdDGLzqPu7tl2UpY=
X-Gm-Gg: Acq92OFsVTjXx2dItF9x1dO0zbiVUcATHwu1ckyRquM+aqLuxu83AYvkMF930B4WsSs
 ynaz7LtRkDhJ3cfBqyDXETLhuG1j9mdjVtRUIP2MRWvLUwozFLmR3HKEA55CBdzBYsuWm5l+f79
 BnEBWfRHbrRn9DuaJ0/X4xOANy+inpV3RnW6Xe63+/jhJxrRdkkY60NW87qKbKcbE0d1roVPMP6
 jcElIFYDsuaZnwv+GZucJte7yapnXJAABLyPCZNj3DDbm9J2oMr2a72ZJPc4FfyBxZBcL8ypAQt
 K7v3s8wEcQKNJaethzg5lQkJqGIwLHGySnGBkC6lVS+hZEHWp44eic1eQRmkTo/g0b8YiD8w7HB
 REGcVChamIotieGUgtj2Xa7ZgXevCREB4l+O68EGQwQHrNTo95EggWLb8R/VoybPsuxR9oNB8UN
 Ko3iq/llgQC61KZwWISLIUNE8=
X-Received: by 2002:a05:6000:2888:b0:45d:4c30:81a6 with SMTP id
 ffacd0b85a97d-45eb30de822mr34820497f8f.5.1779873229458; 
 Wed, 27 May 2026 02:13:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm5226363f8f.12.2026.05.27.02.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:13:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA1A15F7F0;
 Wed, 27 May 2026 10:13:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>,  virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Demi Marie Obenour
 <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, Albert Esteve
 <aesteve@redhat.com>, Mark Burton <MBURTON@QTI.QUALCOMM.COM>, Matti Moell
 <matti@qti.qualcomm.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Dorinda Bassey
 <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>, Vishwanath Seshagiri
 <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, Zhengyu Zhao
 <zhaozhengyu@bytedance.com>, Jorge E. Moreira <jemoreira@google.com>
Subject: Where should the vhost-user specification live?
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 10:13:47 +0100
Message-ID: <874ijtz038.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Apologies for the wide cross-posting but I wanted to find as many
interested parties as possible.

The vhost-user specification currently lives in the main qemu
repository (docs/interop/vhost-user.rst) mainly due to historical
reasons. QEMU was one of the first VMMs to implement vhost-user and the
spec needed to live somewhere.

However there are now vhost-user implementations for QEMU, rust-vmm,
cloud hypervisor and I think CrosVM. We get queries about changing or
updating the spec on qemu-devel from time to time and I feel that given
it is an interoperability specification we should think about hosting
it and its discussions elsewhere.

I think broadly there are 4 options:

  *  Move into the OASIS VirtIO group as an appendix/addendum to the main
     VirtIO spec.

     This probably brings the widest visibility to changes to those that
     might be affected. However it does come with a certain amount of
     bureaucracy with the OASIS process where only members can vote on
     changes. While intimately tied to VirtIO it's concerns are more
     focused on practical implementation details of the IPC between VMMs
     and device backends.

  * Move to a separate project under the qemu-project space.

    QEMU hosts a number of sub-projects and mirrors so it would be easy
    enough to split the spec into its own repo. Changes to the
    specification could then be divorced from QEMU's release cycle and
    at the maintainers option issues and merging strategies could be
    configured for just the specification.

  * Create a new project just for vhost-user

    The interested parties could decide where to host (github, gitlab,
    forgejo, whatever..) and decide to move away from mailing lists
    altogether or create a mailing list but manage changes via the forge
    interface.

  * Status quo

    Just keep the spec where it is and muddle through as before. Maybe
    we could improve the contribution documentation for how and when
    changes are discussed.

Any thoughts?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

