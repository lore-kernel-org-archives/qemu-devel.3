Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E878AC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUjQ-0007J1-0P; Tue, 05 Mar 2024 08:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhUjL-0007IT-1s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:21:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhUjI-0007v2-HQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:21:13 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d28468666so3767627f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709644870; x=1710249670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxN5fSZ0mYuXpILGo+jbfEWTaiqX4vsJYUndZBpbOno=;
 b=ni2CC60uFuD5Zvk6RJTNyKcrWXwU3lAYdnt3qC5dhA45R51qG8sre1NYv4OYRZs6bS
 W9JBRzWLHmNsaw23mvWrhxT0ZF4Lx6O1V7+hQQI5gmuzl9ofKxjtIHJS3Yq2MG3ci/W8
 f+fqbb2OdJ7p+pFbojdiharGyXAPLvKmIAwtYqmlYhKGYhC3cAIz+Ho6ngYZAbQ4UG93
 y3T84ZNMxutYfmmMa6ebJH2Q7dZO9LgECzm6JeBi9eA6P8+uN2fwz6lPMGLxMdxMZD6M
 7mmOj3Sx57ATvUwFwIncIZO7Er4NgQK34nqGQM1/vmnx/eNh1QEWikhmIfuoylL8WcNV
 ibSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709644870; x=1710249670;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxN5fSZ0mYuXpILGo+jbfEWTaiqX4vsJYUndZBpbOno=;
 b=qtziLErU4EXyq9vUsq2p3ykRpVY31H7xy2XYtfOsxXUr4PQs0Ui4QRPfZSmNDNS4Zd
 xQIMwhfN7Vxv1qAGfZnh+Qa9RpwCh6LcUU9YYXjgwynwE4FO6bA9D2k44tnzUoWBG7vb
 tN+cFbJBkkLXQTf9N4pnbC84yJtdN0PDC9mlXkV0iJ0Eeyyqpj9p/ir5GJTuJRr0Vjd1
 C4dDV1THVr8+Z6glBQ0/LKTppHJTk9Xek5osVSMApiS0CVfXk+YhPqmvhYHAPk4FgeKF
 +8vUXVjFVF1vTpucUcy+GtQB7FZQeARfrYerhK3aq389isqatW+B42UwUR2l6hF7fN3e
 +ajg==
X-Gm-Message-State: AOJu0YxGAuD8oy5zlqc6slAMWIDA3v9b9gujej4kJiJTlwD1Xw+MNrgf
 ttMetYBm6giIniIbq9FeOEcakFxpq3TrpLe3zD/BNGUfkuxrlbxeW6YvGyCe9U0=
X-Google-Smtp-Source: AGHT+IEmEHpdzm6GHwi+fnU6z0042A+QmWDgNKEvUVwU4FVSJVt/BxWTp3zvIQ6LzHYGz5iNgXHBZQ==
X-Received: by 2002:adf:9782:0:b0:33d:61d9:2d5d with SMTP id
 s2-20020adf9782000000b0033d61d92d5dmr7724439wrb.34.1709644870368; 
 Tue, 05 Mar 2024 05:21:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j16-20020a5d6190000000b0033e0019b814sm14904270wru.34.2024.03.05.05.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:21:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93ED15F888;
 Tue,  5 Mar 2024 13:21:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  minhquangbui99@gmail.com
Subject: Re: [PATCH] hw/intc/apic: fix memory leak
In-Reply-To: <20240304224133.267640-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 4 Mar 2024 23:41:33 +0100")
References: <20240304224133.267640-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 05 Mar 2024 13:21:09 +0000
Message-ID: <878r2wx1a2.fsf@draig.linaro.org>
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> deliver_bitmask is allocated on the heap in apic_deliver(), but there
> are many paths in the function that return before the corresponding
> g_free() is reached.  Fix this by switching to g_autofree and, while at
> it, also switch to g_new.  Do the same in apic_deliver_irq() as well
> for consistency.
>
> Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

