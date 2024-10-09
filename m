Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF1DCEDD90
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWDz-00006b-Fa; Wed, 09 Oct 2024 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syWDx-00006M-55
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:55:29 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syWDv-0007kv-KO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:55:28 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fad15b3eeeso72761161fa.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728478524; x=1729083324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMTG5YTg+luBv08NJpmgj7GPT8nN943jig8ePCMC/60=;
 b=qsDWARF0asvHZ49wWubLk8c93cjm/8ogdD+vADw81l3Ws4O+0CtmDD1JtbWSj1WXgI
 5FdX5l6nHK9A8y5dV7uuin1gQfsaY+Zygm0Xw/sUH1UHOE1kzQzSFhgZpVLSGA0MC1bV
 x7xbIbkWmqDjbknX2IQmj+kw2rgbQsJAnXayoDHZyl78CW30kkWJpP4ZyCki6RPYbzhg
 akzkJchpPhActuHjTjInHNVOzGU2ylIsvLhzB/HY2YhViB/e8q0wz3p3uPWLSMfbyanE
 Y1Qa7gvCJWj20E1UXPI5KbW0V5s76JnSLphbPEFJo+mHCzJjVW6q3hXeERa7ZU1x7g25
 yWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728478524; x=1729083324;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YMTG5YTg+luBv08NJpmgj7GPT8nN943jig8ePCMC/60=;
 b=Fb4SYcgz/iGtpxDgNzdwSF3+w7l5P3nn9JqrVDYe2dhejFoI5eGiBavOFvamRM40fH
 xgFjIKqNCkXY5BNWaDCFTdvu6RtJGPjJ8bd7mUjRFAshP2WDPBaAJhoPVrEyJJH4kYUy
 hZSb0usDtk8+0MN3O+LA9rDsgis2Fz3EM2SZ7VcT047M099tf7rLtkIa3KzjQ+wfJfQP
 EAEGH28FV8PbJctjtZzAY/4VZpUlTJlY9fzvztK9lVaHwLK1A5S0N0HhfHSeM+ERi4wA
 o7R4MxOWzgjZyw3KNZDJUnkIn8NNl1ogWECngBdZJLn24juO48idrqyH9Ic++4Fs4naJ
 4GDg==
X-Gm-Message-State: AOJu0YyxMqofNan62YeIXC6Qo/q31ZNtGq81QLPIH0VuBZZiD1ybT3mB
 P2aSB0Ld8acuaH4fo5z3bKTAwFTBxcTYNP0RHaK8qV6n7tznbgpMkFd/gyCzGc4=
X-Google-Smtp-Source: AGHT+IECfMnkvf4c9j/TWr3woqnCGTpC3VQ64IEx4l09bcXoCROxCp8iLyKsbNAA/I30QY7uVmTP6A==
X-Received: by 2002:a05:651c:222a:b0:2f9:d359:50e2 with SMTP id
 38308e7fff4ca-2fb1880c946mr15388071fa.39.1728478524431; 
 Wed, 09 Oct 2024 05:55:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05c0f6fsm5471729a12.57.2024.10.09.05.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:55:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC2C45F87E;
 Wed,  9 Oct 2024 13:55:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 1/2] dockerfiles: add a Dockerfile using a nightly Rust
 toolchain
In-Reply-To: <20241009090151.1643088-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 9 Oct 2024 11:01:49 +0200")
References: <20241009090151.1643088-1-pbonzini@redhat.com>
 <20241009090151.1643088-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 09 Oct 2024 13:55:21 +0100
Message-ID: <87v7y1tozq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This will be useful in order to test QEMU's Rust code with nightly
> clippy.  It can also be used to check that the code builds, until the
> minimum supported Rust version is lowered enough to allow enabling Rust
> in other Dockerfiles too.
>
> Use a separate container, instead of the Fedora one, to avoid that
> CI breaks for everyone if for some reason the rustup build turns out
> to be shaky.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

