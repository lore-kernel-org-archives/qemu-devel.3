Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AEBCEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWES-0000St-Dv; Wed, 09 Oct 2024 08:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syWEO-0000KB-UD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:55:56 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1syWEN-0007o5-Gb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:55:56 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9957588566so412117866b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728478554; x=1729083354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCcMVJn3TyJblm7+vpT3GQV4o3PEtTTUO4rtwUQKyA4=;
 b=h3BQyT3eDKNIZpfELbzrl0IyYxy2gjciqzSlEsh6HFkaZAYkcyIzZFqo9t7i1c946K
 XKEQb33PQPzJ6w+eDHqCvOF2iI8IeGG0C1apv+6QeDChz2Tvv2OnJj9VmsQ5/jPhtyLC
 xJ3fMZRnbSO2Zg3LbmOaO83d/9YENufg8T6PHdYzAcvQbxOO2HZrCTUblBwB7q3CZXWu
 5mlEtDpJSV6vZruSuywBdQ8Q1kePVxdqbuv8H414l/q+QpnSFQ3uj9ltss7X0CdV7+Gi
 8w6UIFOibdr59dp+37mFg9yxqUnlzY4jjEdmMHFH0nOrVQFaAZh6Oa+lXE3KJPLnrZwV
 rUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728478554; x=1729083354;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCcMVJn3TyJblm7+vpT3GQV4o3PEtTTUO4rtwUQKyA4=;
 b=EZhCP0p55+B82o+Hm7GiKQX4sfbYKxZcxkIZt+KgYT4i/IJIjePFX8flxeDdcL3Srp
 bR0OBE+d1D+s9Ru5f+71t4RzqEesSMVjBM1RmVmAYA+O+Y7JIi74TfmhmFQnjEwNuQG9
 nZAWNbNk82ygvg+b1FWwoEDU1E6pOkO2ByQcVbiDfY7uw+3peD4NhvVcYIW2FC+x1RaZ
 cbBPd71q8ZKefZhZeLMf8aExNw4oZ9VwnlRNsBw9tvoStGACh2tkn/Ad4WKZ9z+8Ij/1
 bePaAxkPhgnzA+1dS7QFnqafhZpPpvyrVF0PfZwkE/fqMz2krUDV4tz+Ex3wzc0KFVg1
 0LIw==
X-Gm-Message-State: AOJu0Yx0/rNxr1Vu8myYnrdbCp0oq54ux1zYepruL8WqrpvZUV09Au7t
 FGAHjeZcmtv9fbJZZIrNp3i0/3oQzDcV0G6/Hv/Aj5yQ7mm845eaaN8iwID2bIQ=
X-Google-Smtp-Source: AGHT+IFlA9U7g5Lna037DR6hpsUmLvgcVVcUIL1i36Ghx39waqrijSbnXvT7bo0iAZmO0YHsySOZvA==
X-Received: by 2002:a17:907:3e0a:b0:a99:4025:82e1 with SMTP id
 a640c23a62f3a-a998d3279f4mr222325766b.41.1728478553820; 
 Wed, 09 Oct 2024 05:55:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99384f8258sm623238866b.16.2024.10.09.05.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:55:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A44C45F87E;
 Wed,  9 Oct 2024 13:55:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 2/2] gitlab-ci: add Rust-enabled CI job
In-Reply-To: <20241009090151.1643088-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 9 Oct 2024 11:01:50 +0200")
References: <20241009090151.1643088-1-pbonzini@redhat.com>
 <20241009090151.1643088-3-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 09 Oct 2024 13:55:52 +0100
Message-ID: <87o73ttoyv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

> Add a job using --enable-rust, to ensure that the toolchain is installed
> correctly by the Dockerfile and that QEMU builds with Rust enabled on
> at least one platform.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

