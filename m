Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD7DC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX1AQ-00043U-5G; Mon, 05 Feb 2024 10:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rX1AK-000428-AT
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:45:48 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rX1AE-00009h-Nk
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:45:47 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so5461266a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707147940; x=1707752740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPTw1VhQOHyQ4P4aEwCn3POjKndjB3/tXTl7/3BUFUg=;
 b=EyyW5itq+9SckUIfpixMItLvXuXIp5L8u9RPVhjyj5OGFc2oaE2Zv19Pb7AwVcKtFp
 DRutnsllLQzqHhi+k2FtI1pBlRsZCRDMcZZ1rVsMUoBSPgcaRQg2iURMQrnfRf5rQAYj
 wgEeY++qgglL95ZKsyleb9wPW2QPeybB6OiBMpMWXz0viBenGr5p5RxrE9nWQmdaKivd
 Ng/ylvg6qZGY7E1298CGDcvy6VHWo9trHfnVI2CNLxJyZC3J3+xssAx5JUBA9eJy9w9x
 EcwM6kFDRuqK8MxEcp9g4ng4bd5UBjbWpr1WU71fQ7MFpZJ74tkuq3BM8bwtLY1GXNzB
 XnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707147940; x=1707752740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPTw1VhQOHyQ4P4aEwCn3POjKndjB3/tXTl7/3BUFUg=;
 b=rY3KuVWZjD3YBeg8VUySODSUZw28b6Gnsth6rmiY4HrcC5UY9Gxp6fe+DSsOM2a32f
 77QEKt9Meww0iyulelJP5VlvKmVEl5Fe3ftNWSQXCgWFnLL9QuiKVsy1/gWenBOJgU69
 sBDnxuj7I2joiI3/1GHfZNj08exmJuCPH3XJdqrG204BXe+iQxc1K75AbUSAgUZQSp7s
 Ic6dl9HzlCTkKdC3iMj/RFUqYKMcBdza8E8nRmyn3CQAJM/2YDi+icJdYtJky7fJmBNB
 y+Ftk6HBsf2vx/6H4Q8dFrV2pJrJje7sUviyvX00qoGKpiOHisWsJgO1U75AssLnXoFk
 2v7A==
X-Gm-Message-State: AOJu0Yxrpxpd4pgV+YJTkUuw7rQ0NZ4pggQfclGHLsYcDYwBj2+BioS8
 I8w7vowKsu3gCx1/DsF/2vJ62bZsM134gIVCQeyXavM9+UbZl6Ue/qAedl7s4r9t7ZtRq3M1VUJ
 D6QqFqh3FO2wUlmYKaSXzG9sg/iAY2BIbdMK6zDc5BeQ+sDyj
X-Google-Smtp-Source: AGHT+IEUXrHcQ+gAxpiru2rR+q4cW7stLoWlTmQmclInQjrGB+f+uzvornZVntBmeQtUYcMe3WMyN/lN3fx5MxsIgUs=
X-Received: by 2002:a05:6402:12ca:b0:55f:31f7:4279 with SMTP id
 k10-20020a05640212ca00b0055f31f74279mr5288363edx.12.1707147940030; Mon, 05
 Feb 2024 07:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20240205154019.1841037-1-berrange@redhat.com>
In-Reply-To: <20240205154019.1841037-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2024 15:45:28 +0000
Message-ID: <CAFEAcA94RfwQKLec7gWZMwz8fyDn=W+Uwn+owi6MY-rOF7Rk4A@mail.gmail.com>
Subject: Re: [PATCH] iotests: fix leak of tmpdir in dry-run mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 5 Feb 2024 at 15:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Creating an instance of the 'TestEnv' class will create a temporary
> directory. This dir is only deleted, however, in the __exit__ handler
> invoked by a context manager.
>
> In dry-run mode, we don't use the TestEnv via a context manager, so
> were leaking the temporary directory. Since meson invokes 'check'
> 5 times on each configure run, developers /tmp was filling up with
> empty temporary directories.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Could we also arrange for the temp directory to be created
with a name that makes it easy to identify what has created it?
Very generic names like "/tmp/tmpNNNNNNNN" are very hard to
pin down to the code that created them.

thanks
-- PMM

