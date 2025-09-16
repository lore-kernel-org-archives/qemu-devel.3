Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D0CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZjx-0004Uy-L8; Tue, 16 Sep 2025 13:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyZjt-0004UR-Tx
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:45:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyZjr-00078N-Pn
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:45:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45e03730f83so27460905e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758044709; x=1758649509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7UP/4Lw93msGinfUMmin2LERced09YSnvwvDnwE9+I=;
 b=Zr4gK72ERpv6MN1K4mXSbWhI+G2r7Zh0TXgEyYFL1LkHGyMoESI4zMHcpuc2ONDxGe
 Y0y1cScjykXbEFLr5WN4KGZj1mY20j6PKibsPBxmzsw7ozLSikusYArEa0Q35yIsVBHB
 ZeZAqoBG0nnoha9CN0GRHAeuXLtkxZVMHaoRNZIOaPqGQejwrLi2rY1X0bdz5EmBMpP8
 s8EeWz3Q0ge2GhQrALAOs0ZzzHPkZ0qOpfC21ycneWNICPngFC3ZFbJ0PQc5xMX/m1XW
 syuEJaOd/CmnuHnU/AdEDBNHJ56+4jsz5eTJAqA/xBW4g/vRGxEfJbzen0lj+rQniKAe
 RECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758044709; x=1758649509;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o7UP/4Lw93msGinfUMmin2LERced09YSnvwvDnwE9+I=;
 b=UMcOtdwvmOl77WKnFVJyPiQ8tD14CE4AuHY4rwi4lY7b9yojMYe+SczqLmRRMnRVL1
 gDUeDa5WOfESOvaiZpbfhhuAUqaNK7r9jPkbMRcklGute9ThS6MhzxnnBjP9ZKRlD+2v
 RR4oYp1/Qlx1IUhcVXhSYQ5h8gDCfbjsOLWpLlZaT0oSkpDoAgKlpWQRdycxD/CjzkNH
 41mM5SN92iMA10sDRPSnA9oEVvkL1NYB1L9COS8b4csPc3Y0t4oZ/kbsMjbGyjh6jh4w
 HYBF7yEZKKdricBlMVmw+vORps9R0buuPETG0Ih7/Vvuxx2q0lJytKk+nVFbxca0O6jl
 PapQ==
X-Gm-Message-State: AOJu0YxRd78yKVVzQik8AuXUph0XlHCI7sojP/bCs3RKfz+LTLtj+BXG
 CnUOQNq0MbDa70BucsJiO6xnApm8Z6mNxxGTxRQ3z87PJb3h5m6PFHOF4qnW10M6JCw=
X-Gm-Gg: ASbGncvqLCg82t/B+thhj/+mpkzTPAuTKODksUL4J+Ufh17G+yCUN6ThvmPRRpmK2Vv
 jXJWvMKA3DIacw8/Ysl9gTR4Y8CjVJk3KuNYrtpXyWekbHiQyoFFgiBAjw76z7Fny4IquT8KlfY
 YGahdZJjpQbQoCBsq0vQ0PNnevrmXxJtETKv9Un2M9q/kAWdrJgGgQF9i+RUTEX6SZAWjYgzUNV
 TAm4PaIJTEPZnZ5GywzLTqBCFR2BBQ8/ta0XZMEkDpQHEbGKL9kW1rYEMrqdBxbS2SAWJGxPkeg
 AofEu0RQs+TUbpO8LlIKjrMiVhww8SjO7j8ipe697GPywkxTQQpo9oc0XnSrhbk3IXYAd6YAvoL
 tJ1G0AgqBAy0/416KENNWX1I=
X-Google-Smtp-Source: AGHT+IGkeHJC98jGQ4UQUzXB4BMZa9cmEpPBXfZVlHtq59fCYP147tisIB+IZ0HTAmJzYWfWS3AANA==
X-Received: by 2002:a05:600c:4f0b:b0:45d:d718:3b9e with SMTP id
 5b1f17b1804b1-45f2165e852mr175915325e9.10.1758044709285; 
 Tue, 16 Sep 2025 10:45:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46137a252fasm2922675e9.7.2025.09.16.10.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:45:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A754B5F7DC;
 Tue, 16 Sep 2025 18:45:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION
 for htags
In-Reply-To: <20250916163030.1467893-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 16 Sep 2025 17:30:30 +0100")
References: <20250916163030.1467893-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 16 Sep 2025 18:45:07 +0100
Message-ID: <87cy7qnvfg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

> In commit 52a21689cd829 we added a workaround for a bug in older
> versions of htags where they fail with a weird error message if the
> environment is too large.  However, we missed one variable which
> gitlab CI can set to the body of the commit message:
> CI_COMMIT_DESCRIPTION.
>
> Add this to the variables we unset when running htags, so that
> the 'pages' job doesn't fail if the most recent commit happens
> to have a very large commit message.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 52a21689cd8 (".gitlab-ci.d/buildtest.yml: Work around htags bug wh=
en environment is large")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

