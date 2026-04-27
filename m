Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C758FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHM6-00029Q-GA; Mon, 27 Apr 2026 04:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHHM4-00028o-Ec
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:30:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wHHM2-0003Nr-P9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:30:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso4270588f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777278609; x=1777883409; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTKfx4IYZ8cxJlBel8epTON4PvL3iq+gQkDhzblj8z8=;
 b=WxkoL4Kq/Z6uJAN5FozJk5zDtQkU4XpzYywPTHuojEWfzT9unolQUUc44LHf4te8YM
 I5FhA0QaH2MmAtRKdSUUUHOFi6kv2AkYHyDTgapJKHtXzkrieDuy0x8Xi0hf1TybEHls
 P2FVbE7zD2/Dn09iBD7D0MxPrOs79+sngbEiBjQOn2URzBH5KKzUMQrRMQdMvug+l4rP
 H31c71g+Kbz8PlP/EYZplqAIZ+9GWRgOTLU+TIq/MpBVfGQAEExwRnNUtrdaZye2Dien
 XwC5SVcDXgHxvgtRHe+xXXkrPxEMsBzEqtK0e4P0vNTZtn2RVQUToe3Y5Q5dyi8nuHwG
 dTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777278609; x=1777883409;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yTKfx4IYZ8cxJlBel8epTON4PvL3iq+gQkDhzblj8z8=;
 b=RQRWcbQxLUfL9IqeY5UONWc7scAB3jWVGJfihOJsMuWaNuu9SoBlTWPnzNL+ScrAmX
 9rrMZpqFgj+WBXQmRI6ogZhGz1HjDv1ahxOG6Jb9fbieAJpFg2/L1Gy/1RYfQLLlmcLW
 L3SW/+DTDLToy3fgR96N+88aWBynsXjdNN09d/qTcAoSPq/zV9RH3YAXfBAySxRJgBFh
 Wkqb2xuq3mD6ue2Kcx1QqwwDGpqyeLvVPXP38wdkKZtbhm2Qy6AxLp2ncAjiKWNpivSi
 Hva3c4ZxJo8tXc/hfa2ULeYT35F31+e36I1LqngKJ4Oa6qyBwNoTU0J7KZFq4XMlyqYY
 3NrQ==
X-Gm-Message-State: AOJu0YwNO7X+N4xtIHNP5Hu58O7th8G5izksRAf14wnL2mREgYaFEyEw
 qDsaohRIM3mX2b6MiWbvAQ9do4pIqd26nJL6SGH2GrdiiG5UVRmkHB2B1Yul15I4
X-Gm-Gg: AeBDieuXpnjbNrqhVSEzeJG9EbUXQWJRR9ToyzuefRuKR3SNY81ud217T+cfYRZ+aD9
 64JJqTsGd+GluxO6+NvuxQF2NAVtB3EzSMqrUeilH/sOEIzUAsRkpI7YXnyEXWADQKGcli4Wbkf
 bDRT/jy+SNLVGlvOD/nt88Tu8GC13l+DoHJMy/PZ/J9w/eS4bhgsw8QLukWVWBpRVJ0GEkVYsFU
 +IbXMKXIn6M9+9aUrCCxGf3MnnhP66j0CLhs79MgxDjjz1nacVbpvcTGkh9ljDqbgtvzF6Da6S3
 OlgWgpFtTSCPf2Jpbnr0Jh+T936KGF4894MP67muEWKlKDfPDGvST5/xbGZeioe95uzGKXWRRcy
 hsP4cqRQ4CNTjvj0C0uaX78kNUUOpmvQhYbO91HOIqWglT9mUnaNi9nBeBjEGD55522UH2IXKoD
 PRbhelHgSMY7GKhoZLSXJGv34b4ueeIh41AFDcjHQ9vlfzrYhcIeUr7Mkm7JEh6KngTA==
X-Received: by 2002:a5d:4527:0:b0:441:29c5:f90a with SMTP id
 ffacd0b85a97d-44129c5f92bmr19678354f8f.22.1777278608265; 
 Mon, 27 Apr 2026 01:30:08 -0700 (PDT)
Received: from smtpclient.apple ([5.32.173.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm80238968f8f.0.2026.04.27.01.30.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:30:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
From: Elisey Konstantinov <elisey.konstantinov@gmail.com>
In-Reply-To: <FC5DE7C2-924E-4690-B12E-4E33BB118BE5@gmail.com>
Date: Mon, 27 Apr 2026 11:30:04 +0300
Cc: mark.cave-ayland@ilande.co.uk, berrange@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org, philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED381CBF-D01F-4379-A9C7-7C91E2CF0259@gmail.com>
References: <73E79A4E-C0AA-499C-84ED-81FC5C1A8972@gmail.com>
 <FC5DE7C2-924E-4690-B12E-4E33BB118BE5@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

So, later on I=E2=80=99ll try building it on an older version of Debian =
(12) and see what happens
If it compiles and the bug is reproducible, this suggests two things:
1. The bug was in the system libraries; the issue can be closed
2. Debian Auto-Build has simply been linking against the old libraries =
up to now, but will catch up in the foreseeable future

P.S. Apologies if I=E2=80=99ve made any mistakes with the metadata in my =
emails (To, CC, et cetera), I simply don=E2=80=99t use mailing lists =
very often, and secondly, I write via Apple Mail (I really must set up =
git send-mail; I think this is the second time I=E2=80=99ve said this:)=

