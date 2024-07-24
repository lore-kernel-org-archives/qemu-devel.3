Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E88C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 11:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZxD-0004m8-3K; Wed, 24 Jul 2024 07:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWZxC-0004iP-2x
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:14:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sWZxA-0003Sm-D4
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 07:14:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso117193266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721819679; x=1722424479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZ5ihu3+cB90tujJoYkCxGFjrInaMowwGXfAgvWCAN8=;
 b=BdJ3VJWjNkkSxnaXMHSO5Bj7JgTBectO8AUkA7DmVxGXIdXb+RP0eT/6h2dNP8lUPO
 zMBCc/6MRJ9wWn/QtoHtozF80GazObDbHbJCFfltrFH6BiRIuzQeYOCcGPyPPqzIPxZ3
 lf75I7OxqWa80JnVCj3YkU5lEyY/uQ7K0xf857UdGRCAWSfTfZg32maMybmykziAcpTx
 pWdijtVu8ZeUELvTnZIQY/2DpEtd+QpEH7UMp2JVeJZhRQKvqzjJEoDdQy9YLMV5/j0M
 19GnNUBEnNOjwDXVUBiWPxoiIWfh3oBwrCCbuk564IfKzmvGPn2vjXO9XwJ0uKll/8u+
 fRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721819679; x=1722424479;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ5ihu3+cB90tujJoYkCxGFjrInaMowwGXfAgvWCAN8=;
 b=oa/kP0ja8L5KSBqvuxz80PXum6pkMUmpzLqnIT24WaoKGmn9Xs2MMBYqntYDp3Dxhw
 FT116BYCyldBqHxunJCJKS2QcC4kzKvHipqpS3jCXgara9iVjtHreb5MpX1u+N/7P9wL
 7w70L/sz/4/NcH58I9TJZ3RxSeA+ticMdrLcmjeY4pKwycisOLe1idTt2uBFzWBnF1br
 OzPr8cI74vxzh+Ui1TCy8+d0DMv+hQmi+ZeBdh2zmN6kghAjNa8FTidsXOY8/7i+k65+
 iQgJmtEux/XRqKMdDmxtWB1da2RKC1mrDOBQjaQ5mXOvABzP1fSmDVFeT1RITIYZ0a6X
 sHPw==
X-Gm-Message-State: AOJu0YwponiJU63G514XuIUIjutjzx/LGhUmD8w8FwQa5yJeQ0ozopdR
 jJ0drdn3CVIHBSoCY2AuzK6/+Z/mre5KYSdoYPZhLCIj8B1/luU8BnFrLaQBbxA=
X-Google-Smtp-Source: AGHT+IHX2P8kI6pEEqyzILHTnIcGbSRR2/K4xC1O0BZ9lFG2L3YtTINWHc9KQO35jvMp5xajhNZ/9w==
X-Received: by 2002:a17:907:940e:b0:a7a:a30b:7b95 with SMTP id
 a640c23a62f3a-a7aa30b815bmr303422366b.2.1721819678280; 
 Wed, 24 Jul 2024 04:14:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa8820c45sm98497966b.199.2024.07.24.04.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 04:14:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8ECC75F738;
 Wed, 24 Jul 2024 12:14:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
In-Reply-To: <20240724095505.33544-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jul 2024 10:55:02
 +0100")
References: <20240724095505.33544-1-berrange@redhat.com>
Date: Wed, 24 Jul 2024 12:14:36 +0100
Message-ID: <87o76nvy77.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Many times we see a build job start failing, we wonder if the installed
> packages have changed since the last passing build. We can rarely
> diagnose this, however, since we only have the new container image, not
> the old one.
>
> The lcitool generated containers create a /packages.txt file whose
> content is intended to be output in the build phase, so record the
> packages associated with the build.
>
> This adds packages.txt to the manually written containers, and modifies
> the build jobs to display this content. This will improve our future
> debuggability of CI problems.

Queued to maintainer/for-9.1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

