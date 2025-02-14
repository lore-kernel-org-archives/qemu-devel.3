Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0457EC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivcP-0006Mp-5U; Fri, 14 Feb 2025 08:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tivcK-0006MF-Ej; Fri, 14 Feb 2025 08:20:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tivcF-0004LC-56; Fri, 14 Feb 2025 08:20:24 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5ded46f323fso2206312a12.1; 
 Fri, 14 Feb 2025 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739539221; x=1740144021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Huq6mFYilJXUqTSfF65YM2pjXvaw2cochtZdva4jgU=;
 b=nkOXnOmMFDUNUc1BikZgypzNZ7mBG/qQdfoHl1Y2zGs2ZQbVSHN+oed2rZqnl4KPQ0
 gCSr5CAyh14bGmJ2iFuF52eLo2Q4e+WEoSH6KvZZy4HC/a7vuuQ8RLIBeKSeMnQJFEsQ
 0FBG8rb4pysLaktKp+zxG2ewKpJDSlvZyVOoiWu/4SQH0kcg0M91AN+Y3dEi+tIgATLH
 q+64BsHiHzrwEimRcDTsRM6Jvae6F+7oZL/N+1HIYOyTNSp3yTXSAZ3GbYY+fnZe6zj0
 P2HpGHnsirwxoU6Vk1yYAuvf9111YijbIn6eTjjQhhtehGU9NQHnyhb7mRKs4jyxekeE
 zI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739539221; x=1740144021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Huq6mFYilJXUqTSfF65YM2pjXvaw2cochtZdva4jgU=;
 b=IKeVpdxwb0queYAxuMXndT7l66DyIJWYUcMBprdDAR2rzHLlm+SwyJLlMkVrOz2RUi
 VIJ+vaYZ+zizgChy3Qhz4IMDkbYaFuCNtXzyZApYIaKDqlUbT+9Rt3gHENR+K8r+X0Gj
 jg81MeApO/dhW7bLadoRwxKfc4VpsZzCZc/jm9meyi5UQPt2iV0mMFZv9C8c88o4QVsZ
 4yHObdjZwu0K8cFRJiDBxK8UZaqci3zObwy3je6frR9h0iJGmSvLcLGJV+SdjmaV4t7v
 5+LKCraJoNjTXJRFQekg9+Lif0U7Kd+fw0+7YsgjdarE0ZTXLDssZmumaaX8oJnkN8J8
 JUNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQK/bR/iyMXWGcfp+I7qEOVwSXn7APevL8lLSf/DHGW56Ed+qbUNNMgOxH1uwmQU3DJEqXj7AwtrDe@nongnu.org,
 AJvYcCVub1zOjOyEvramnnXHaxOQRcCsmDwImsSrtduVS2+JNv7Wcqm5N8uixr3yFO1Jjq/uhbNV/5H2FwBmyD4=@nongnu.org
X-Gm-Message-State: AOJu0Yxv1h9Nzmx3f6mFJcYTfMEJaE+9StxP1ZDxGP23a/SKtM23n1ai
 8eANwK+Ij/2fib8qVJvjn72jJQmemfxumhi5wpzD1bzmmP4nR078tK8dAeFcgnLA4HC+MLKiDvl
 y4qIFiF0WetyahsdSjw6dHjnd1zU=
X-Gm-Gg: ASbGncuF+IUFmYKfB90IDgTzq95fX52ta5dJ6mUNvK3gT9yxslonmxjmdIJ/27z1RIS
 sjAXwf96IaTAuaI69keiIVzj9mlmWlMkTXF9iPf96CcgXhpZRzWp7q96bOQCie2Pr+f7bnEs=
X-Google-Smtp-Source: AGHT+IFLOuiO29e0OG/Xu6uP+UcS6lzs+CjG0+2YeFJlR5kCkgqvDK6gB/Jlix8/qyl0mgzes+1dpcTv3jXJSnR546g=
X-Received: by 2002:a05:6402:1d49:b0:5dc:8845:69fc with SMTP id
 4fb4d7f45d1cf-5deade109f4mr9706426a12.28.1739539218566; Fri, 14 Feb 2025
 05:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20250213235320.3100397-1-michael.roth@amd.com>
 <3ecefb78-6eb2-4606-a551-35633523445d@tls.msk.ru>
In-Reply-To: <3ecefb78-6eb2-4606-a551-35633523445d@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 14 Feb 2025 08:20:05 -0500
X-Gm-Features: AWEUYZlAkb08e1ti2o1aVs7KO9YbLuBoxFVqRT62rfUa7WkU9OyYGxb0ow7NHek
Message-ID: <CAJSP0QXYtpvHMCJBh5-PUzRppMQrrPAraKcM3ziW=q81Xuf_zQ@mail.gmail.com>
Subject: Re: [PATCH] make-release: don't rely on $CWD when excluding
 subproject directories
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Fri, Feb 14, 2025 at 12:17=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> 14.02.2025 02:53, Michael Roth =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > The current logic scans qemu.git/subprojects/ from *.wrap files to
> > determine whether or not to include the associated directories in the
> > release tarballs. However, the script assumes that it is being run from
> > the top-level of the source directory, which may not always be the case=
.
> > In particular, when generating releases via, e.g.:
> >
> >    make qemu-9.2.1.tar.xz
> >
> > the $CWD will either be an arbitrary external build directory, or
> > qemu.git/build, and the exclusions will not be processed as expected.
> > Fix this by using the $src parameter passed to the script as the root
> > directory for the various subproject/ paths referenced by this logic.
> >
> > Also, the error case at the beginning of the subproject_dir() will not
> > result in the error message being printed, and will instead produce an
> > error message about "error" not being a valid command. Fix this by usin=
g
> > basic shell commands.
> >
> > Fixes: be27b5149c86 ("make-release: only leave tarball of wrap-file sub=
projects")
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Michael Tokarev <mjt@tls.msk.ru>
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Tested-by: Michael Tokarev <mjt@tls.msk.ru>
>
> It would be best if this change is applied to master as a quick fix
> (it does not affect anything in master at all, including CI), so we
> can resolve an issue on download.qemu.org (wrong 9.2.1 tarballs).

Thanks for including this patch in your pull request. It's running
through CI right now.

Stefan

