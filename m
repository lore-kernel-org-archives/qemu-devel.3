Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B35C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThes-0005fj-1b; Tue, 16 Jul 2024 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sThep-0005TE-0c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sThed-0004yX-1P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:51:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58b966b41fbso6912806a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721134297; x=1721739097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oWcgzWITsOqD4WKF97xGTXXfFC5HM8S11DOTymOReL4=;
 b=pgulFg2jKq/Lxj6Zkgtjqzk9PXwFFeZeDm1Fxxn8uy4hSTTTuqrHUUzidw5R4E/oOY
 DKqVcHMA9kDNB89px9ylqxCHLkwXqPaYgF//RxXV9CLWblL1nDvsMiNtL4Y4HY9EfwNX
 KfTlV1lrPbZd1lwwnZiwFGW9pnlkWRt2sU4fWAX1Oli3gEQx6QRWFGCVKvSsAvVXWthR
 ehqeVe5FdZiQJQjW8Z1SKurvAnVWuti9/1zG0VHYmcBodMiJMxWCzlfNi+d/xgMKVSAA
 QwXs8S6XM4IcO0zvnV5tdEAUOzQF9DJVrBL9k1ZgGv6M1ICP+rAlTuPGGuQVtJ35TubV
 v7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721134297; x=1721739097;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWcgzWITsOqD4WKF97xGTXXfFC5HM8S11DOTymOReL4=;
 b=cruLeHYLhwO8zFhvSzCrzM7d46W47IpTgXeS0d8YsWiDpq6cnhrnfpkR/18+8b8eeJ
 c386YY/poklI7YfDQ5aSYu2EORAH2szMdTiiuRNk6t5Uuc6m2mDjLQjXn0zb8Fpz7Pu5
 hSfUjgredzevZR3ySQbQzJL2GUo3sWLwtS5uYsrnXdhAEcFfcNsMdEgCFL714+IWb6ZN
 Lk6W65RxiizV8y8/HzdcoulFvoA9+VxhPsMhI4ldQ5k1MAI84E2ZEhuzJpMdwqNTKoXz
 wf90cWVwPN9D8wjW7weR46Na0lndCr7AvQdk43lC0OX+bLDL7nj19xCHLHogA6uIYwV5
 LEUw==
X-Gm-Message-State: AOJu0YwlxSn7tlotLeomADLwa24KwF6AheGO6SlJbVtNUVjLnNUqCQs0
 BYy8dM1n7nstvm1U9sqzoxZKQSgg3rlxC/bd3z5Zk7Cy/hI72U0hK7xYZ5vd2oA=
X-Google-Smtp-Source: AGHT+IHDx1i3ZgdrhjvqsCr68U2wHIcEQInq0Hnp88u+q4XvhdaX/54K+T4VFWcMJF9gdq7XjQInSA==
X-Received: by 2002:a05:6402:2687:b0:58d:249c:5ded with SMTP id
 4fb4d7f45d1cf-59eee640486mr1230492a12.4.1721134296895; 
 Tue, 16 Jul 2024 05:51:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a770dbsm4919625a12.4.2024.07.16.05.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 05:51:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E8555F7A0;
 Tue, 16 Jul 2024 13:51:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
In-Reply-To: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org> (Simon
 Hamelin's message of "Mon, 15 Jul 2024 10:15:22 +0200")
References: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org>
Date: Tue, 16 Jul 2024 13:51:35 +0100
Message-ID: <87ttgph548.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Simon Hamelin <simon.hamelin@grenoble-inp.org> writes:

> This new plugin allows to stop emulation using conditions on the
> emulation state. By setting this plugin arguments, it is possible
> to set an instruction count limit and/or trigger address(es) to stop at.
> The code returned at emulation exit can be customized.
>
> This plugin demonstrates how someone could stop QEMU execution.
> It could be used for research purposes to launch some code and
> deterministically stop it and understand where its execution flow went.
>
> Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
> Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
> Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

