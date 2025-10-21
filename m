Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE7CCD1AB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBI91-00074D-MP; Tue, 21 Oct 2025 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBI8y-00073k-KB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:35:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBI8s-0004sG-RU
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:35:38 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so54572166b.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761075330; x=1761680130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igTlV4nIHpwO38Q+bIc/j39Edl6xWMG/E2oJ/ZLJcjI=;
 b=lUuo1L9q8z/NzAsu9JosUgKkOkC0EA8fitVw17+w4xXARDLJkIDVqCyYBP/R3dfTvO
 iOZBJpL67o0IiOe3c9L7YI8NvbD1PxTLh1Qwql9DJeMwe5dTNHtiC9VjE/myPMeX/qdk
 hH6BTD9dQ2m2lhN7q2FWvjkEEAI89aK8XxS4iIHHEc83ynSmOsvikSYTR7cmQZlyseuY
 8a9Qz69u6m5n9c0UCsAW4LviDWOWkceYpwjMB+T5i2qYtp7599LnQ7oELEMOB4Av71CA
 0VVzbu626exAQAD/U9q0nJVmGYSf5Qarbw0731SGz2b0plf89eSwAmisaQW475UiCLay
 mhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761075330; x=1761680130;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igTlV4nIHpwO38Q+bIc/j39Edl6xWMG/E2oJ/ZLJcjI=;
 b=Y53lSWY3hA0/DsiTCANV2omKqtCwhEZKXhQMHGtM2Ifq96JwKVBHKXuchRWTGqqsgq
 peBOWK2KBOwpxVXYkHJyCwIABwnT8GDGbrXybQJWvdtYOAvgbj43rL8hKZe3z/8xfho4
 WaQMivzfpeyRPZ7JVKrb85XxxMJuNoImiX3VplxBMYQYX2ESrno5lqMsRQfW2c44PDpe
 hV/RVCMv5FREl+HBnVP14SgOqVtLNoqTvdL6MuVY/X9zAoGykFQTb+sn9KfAuikZsWHm
 g5DjNzRtMxJ4Nnoy5XEmWiBPV3/uAaRhIqKuhjVXb/zOjuaBLaTXsIIfVx0qNl9JwX16
 EGkA==
X-Gm-Message-State: AOJu0Yze6UHmhmFJEcRUJ3RTLbgRCp8PI3NfkIMB1H3Y7HNLOFc0e7hP
 O0YqANoVSjZPdM1NhQg9WrZQvdVp6TkmOwyJ4ZVCevm3GPZrlXKi3tLyibXI+z9RPG0=
X-Gm-Gg: ASbGnctDVGi3HkuwuIItJRyrf0O5auVtYRYd6YUu7h+2UaKWJNJiBGX5+uGGSPLLbqd
 pCAX3scgO3nywiJ1b/PG+JlSkuPhY6kzBz/mnFgK9nW2peW9JrYIi7gPc0ISruzM5/+i7fL9/Rs
 P1a9FMvy+Hr08gc1ByAD7h+XUQ2Bc/YPfALX5SHYFCkU42s266arQpgjBbQZ7AF2kB6mB5ntl78
 LTBuvvyCnFj1nH13DlPrEKTn4qyebiCSQfGzU2t/3F1HLB+xUwCr8lMILFsJRa+7Hj3uAEXnDJR
 yRAEuJUTTQuTlPXU+uH2arxVOSYWoEi9Z3KvrPkO3K3C1ZLgUmY+VIdjrAzIjFrmN09EPeAyrV1
 r5krnZw1t3KlwIh3wry9GNT2cb0Eo1mKFHruwXR6/VRzcJeJDp2VxdRhxN6InaijL3BdespOJWM
 Pv
X-Google-Smtp-Source: AGHT+IHK5btsdY4EJxHqllLllKlFEcvNo4pba8Vg99slzarXqmOZQ1+HrFhz4T4hxTuEuUz8J2yeag==
X-Received: by 2002:a17:907:84d:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b6d2c005771mr132232066b.12.1761075330533; 
 Tue, 21 Oct 2025 12:35:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebb49a83sm1154587866b.72.2025.10.21.12.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 12:35:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 101295F7D7;
 Tue, 21 Oct 2025 20:35:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Edgar E. Iglesias <edgar.iglesias@gmail.com>, Stafford Horne
 <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath
 <rathc@linux.ibm.com>
Subject: Re: [PATCH v8 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cover.1760884672.git.neither@nut.email> (Julian Ganz's message
 of "Sun, 19 Oct 2025 17:14:49 +0200")
References: <cover.1760884672.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 21 Oct 2025 20:35:29 +0100
Message-ID: <87347c6oam.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> certain types of dicontinuities such as interrupts. For example, we may
> need to handle the execution of a new translation block differently if
> it is not the result of normal program flow but of an interrupt.
<snip>
>
> Sidenote: I'm likely doing something wrong for one architecture or
> the other. These patches are untested for most of them.

Well they pass check-tcg which is good. Last call for reviews from:

 hppa=20
 i386
 m68k
 microblaze
 openrisc
 ppc

Unless anyone has a screaming reason not to I don't see why we can't
merge if the tests are passing ok.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

