Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170C7C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nwR-00089w-J4; Wed, 16 Sep 2026 07:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6nwN-00089d-V0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:36:39 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6nwL-0001he-Ug
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:36:39 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so4492055e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789558596; x=1790163396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7cFkzk3x9Qf9YzwUicvkt0Nq0Mj988rdDe1ZGQ8ZasI=;
 b=I1G7nWr2DmCZ5zAOnJ3k/ghd3bhaxQLer5xXD7BHawQloUA19oeq0Vjou1Sts0y0+k
 E9uqqTNknxpBH90WNCedcH7Yn9zfXO6bmZ7C7L5lc7GIzqve9cpwdROZKGVS4290zSdG
 G9CIwF+nQNxXZmYFQ8eKMgXZu9zN3aCv7odglKZTPD3sPrhJ+4IXRneNQKz3yAnnrzXd
 kEQj++5Gu8KFJyLfUmN7fXuvXGEy7nWvsf61tART1VY7phRz7kS+YI3CAT6CQ+ymqQKI
 ds0ta4DG6ZeK5eT3hTQH+kDE8Eerc6kS9wCH0pkNR8olS6d478Hdf9ha7cnNwqf3BVFh
 oVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789558596; x=1790163396;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7cFkzk3x9Qf9YzwUicvkt0Nq0Mj988rdDe1ZGQ8ZasI=;
 b=uwg4XJoyZIcQVth8y5H9qqE690DrNQjtG7kG7axbKMgFiB283JP6pjQgGM8dGkLCXw
 yJ56+2lednWLnkBJ0hfv8etjiTLfbsIPgNsmKEdkSHf40K6lpprK71iPtvCX7FrERXvH
 lAzmOD2bEgfMhTzY6zmb1cU2VcZm/Smjlpa922qMCfjhg0mDIa5gAwWJfsMEhqwz7poU
 bs9aVxTyr4ywl78VChsEo4MeLyRYfkS8ybYiXrEvrDbsi1MO8IYXu1pgZcljHXawmB69
 MrfGKwHv6fxl8h4u/StEv+tQ4Juad85MqH09hnKb1CI3s2AHTAmWnbfG1KzgW7Qkh2lP
 xnOw==
X-Forwarded-Encrypted: i=1;
 AKwUvByxrb0jrncfBAPet7dosbXh59cRiYXN/cS0g5ucuUf7bzlQ9UA+GMoXsoFEbe16hsag5VqsDfgA98cZ@nongnu.org
X-Gm-Message-State: AFuF++mqlcUWglZfsQ48maZvSfqLQhak3vLomoT/D7zKuLOvlW3CYzEA
 VqP74OCHAEPat/GjNt/iO0zaVMLfBtAyKebyVpqI0NoqLGu0NdOyB+NzNRfbFFHO8PM=
X-Gm-Gg: AYBFou2aoAVuyE4yCRwWV/qd/0Eyc/vewHDBFIeyqoAYLg9vcWZON3EMkGhEpsHFeK2
 deWq20YQISETMiTPPFl3QlWX2Y97zVEhPn6bapFB5hZ2timeTi20K5oPRhszL5M6T+Jc6MJ4yx2
 6R3bGPdfdJb25jg/nzBNZ5MQxC4EuHrIUXXj0fzUvgib2weXwyVd+mYTI9+NLaspFqjo+SMmLX9
 Mn2ypTZokO/yIAHjq+Gw161syXYlnQaYqxR8oMlieQ0HQD8wZD2vLdjh6uzVgEPg0K2Oj6TzFHx
 CyKNlux8bCEe1QQtm5CHO/enx7jvJobP5nw25WmBlYs/XwXOWsvfHCw8rAFNgDqg8hw8XYaNGP4
 ULgrGYl9BGpbhO3tV8rrxciDVomAULEjR7vZdJ7bjSeGZH0qpAlII44Y1jJuRw6nR3x5i3x3mze
 Y1U/QkB+N9Gx1CKoiJOvr576rgeh45OtG0zbFHTTQdUun+06FcAIycw4yCe0fE78+N6/7vUPY=
X-Received: by 2002:a05:600c:83c4:b0:49e:6838:c813 with SMTP id
 5b1f17b1804b1-49eb734574cmr26921835e9.33.1789558596256; 
 Wed, 16 Sep 2026 04:36:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83fb4d24sm28495425e9.1.2026.09.16.04.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 04:36:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 318535F8A6;
 Wed, 16 Sep 2026 12:36:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  David Hildenbrand
 <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2] tests/tcg/s390x: Provide the libc bits needed by the
 system tests
In-Reply-To: <20260915110959.492195-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 15 Sep 2026 13:09:08 +0200")
References: <20260915110959.492195-1-iii@linux.ibm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 12:36:34 +0100
Message-ID: <87cxuda0n1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> The meson conversion dropped the SLOF libc include path that commit
> 3fa010d5317 ("tests/tcg/s390x: Use the SLOF libc headers for the
> multiarch tests") had added, breaking the build on systems without a
> cross-libc, such as Fedora.
>
> Rather than reintroducing a dependency on the SLOF submodule, which no
> other tcg test has, declare the three functions that the reused pc-bios
> code actually needs: memcpy(), memset(), and printf().
>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Closes: https://patchew.org/QEMU/20260910100120.2076092-1-berrange@redhat=
.com/
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Fixes: cd81cf86834 ("tests/tcg/s390x: system tests")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

