Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93AEECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngEj-0000vo-LJ; Mon, 09 Sep 2024 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sngEh-0000vD-Jv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:23:27 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sngEf-0001uY-VI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:23:27 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75428b9f8so31352881fa.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725895403; x=1726500203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EIe4pPMHVgje/Lw6Piu7SzRHQ8YUVHHDv2iQqiwNHc=;
 b=q7wN6UvkyBxWFwxH8IPq+WZaVoQ8nbgqJD5kW1gIjahQl2OGp3wGzzp0b7GwO1vrpH
 8J2JxZysq22acl9f/uTGa29QX2hJy1yT1AljP7e0OjjFm6OXsp838CwdZ6CWhsSuZZ1o
 LWCcB7oo1dcs/AnfKSA/RF+IHRFirLlKBk7Y7kL110r1XOBvSjS8gLQ5p04Mr3U0a08U
 RRU1gKvZytobR2b+Lqn1ulJw1DCZVYDZTkqSNZZh4bo6+QEEbg7AtTeS4Y7RwRcscL6D
 pwYmvDyYcZCuAbp6VHxukZqEVavzqtvpaksLzC1fisgvxWXkRDfFPXnQfmISBGYfFVoQ
 d+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725895403; x=1726500203;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4EIe4pPMHVgje/Lw6Piu7SzRHQ8YUVHHDv2iQqiwNHc=;
 b=mz0RBqqpopKMmDucykbripoQbvAPXr+MkfDUHXy9JjHtxQdvCo+Vga2cd/c64gFw+h
 n0ZdvH909G7JBhXZPX2Q14trxpNTF/w6w4W9UMsvj6FxOXnEov9ylJ5+RlQ9aU9VQKvP
 8gs3zapJgnIdrdavKDNfe+0VL8XomRZv+iyPlNLq6xu6gntEh1wL3xfy3u5oBp7A/mga
 +lM6cjPIoGnFLgA1j8APGfhaFGrG7tg6kWk445JQOXHlw50U8wQ8d/flLn3FnAD5jEsN
 vUFrp+SpULizWCpxWOjm3V6WSUqIww7xGgRcmg0dVIuUIo1GUA//ClbVIYuZcSJZ+m3f
 7Etg==
X-Gm-Message-State: AOJu0YyfT2sbFSD5gbxrBkmZ5lSwaWVeVdsHBP5HXNIrGxHLjm0qO/UQ
 yPdmNcz2viiTg1CjIsSNn1Gc9ykfmztpEJi3nwUBDLZh1nPvbdXXzp4M5WPR4y4=
X-Google-Smtp-Source: AGHT+IGpMehKXqX7VOk9yqZmP5T/VWuXUklvyIDZTX20CoUrAwVaMOYDmoZiguNA4OROCCg1rvvzMQ==
X-Received: by 2002:a2e:b8c2:0:b0:2f7:562d:cb5b with SMTP id
 38308e7fff4ca-2f75a96da1cmr64854961fa.7.1725895402237; 
 Mon, 09 Sep 2024 08:23:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583c20bsm353509866b.22.2024.09.09.08.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 08:23:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC9EF5F75D;
 Mon,  9 Sep 2024 16:23:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest: Don't parallelize migration-test
In-Reply-To: <20240909133921.1141067-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Sep 2024 14:39:21 +0100")
References: <20240909133921.1141067-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 09 Sep 2024 16:23:20 +0100
Message-ID: <87cylcyhp3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The migration-test is a long-running test whose subtests all launch
> at least two QEMU processes.  This means that if for example the host
> has 4 CPUs then 'make check' defaults to a parallelism of 5, and if
> we launch 5 migration-tests in parallel then we will be running 10
> QEMU instances on a 4 CPU system.  If the system is not very fast
> then the test can spuriously time out because the different tests are
> all stealing CPU from each other.  This seems to particularly be a
> problem on our S390 CI job and the cross-i686-tci CI job.
>
> Force meson to run migration-test non-parallel, so there is never any
> other test running at the same time as it.  This will slow down
> overall test execution time somewhat, but hopefully make our CI less
> flaky.
>
> The downside is that because each migration-test instance runs for
> between 2 and 5 minutes and we run it for five architectures this
> significantly increases the runtime.  For an all-architectures build
> on my local machine 'make check -j8' goes from
>
>  real    8m19.127s
>  user    31m47.534s
>  sys     19m42.650s
>
> to
>
>  real    20m31.218s
>  user    32m48.712s
>  sys     19m52.133s
>
> more than doubling the wallclock runtime.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Also, looking at these figures we spend a *lot* of our overall
> 'make check' time on migration-test. Do we really need to do
> that much for every architecture?

I guess one question is are we getting value from all the extra
migration tests? There certainly seem to be some sub-tests that are
slower than the others and I assume testing a small delta on the tests
before it.

On s390x it seems the native test runs pretty much to the same time as
the other TCG guests. Do we exercise any extra migration code by running
tests for every architecture as opposed to one KVM/native hyp and one
TCG one?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

