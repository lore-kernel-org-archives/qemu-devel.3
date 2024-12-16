Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22235E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEhe-0003gO-Iu; Mon, 16 Dec 2024 12:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEhd-0003c0-1L
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:16:17 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEhb-0000DP-M3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:16:16 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aabbb507998so255725466b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734369374; x=1734974174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scu0IeblFWxlvgGfVSrSZe4ylCDzsPgQyeQRCuepEIs=;
 b=AtsezyxcLLuSHdiI6osRVwLKDxCVhCdRh/RnJkAGc2yZInMrAWkCulx35jRjTLni6Y
 z1KUuKnirKlVakSRe6llE9FtGQZNNc+3ZzUBApL0naqhhTEm/zTxPYj1mPQog5Xm5qbW
 9Xt+b64ZcaPheHv4wy8e2B+JK1bMzTegtCMZ6Uye2OJGAFqiTnEkffhI6uacDMXxhrJi
 Pridje7SCa8Umq0MWrHJJZ6DZEw7XZ47qldOTxWdOdA4LN+BY14Osw/l8egOFXaA+adW
 pAAZJMqNO8M7EU4zmogIlqoxanaoUKbwBl2REhu2016BxPxcFsn7sDo49LFKbuNGz3/R
 RktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734369374; x=1734974174;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Scu0IeblFWxlvgGfVSrSZe4ylCDzsPgQyeQRCuepEIs=;
 b=cWQwnxjhrI4Sm/ki3vWb5jxOirEN4Bl52ct8xAmcC6/FRA0+9VWlkYoBNInEirsm1c
 jcG9EMkry7Hh4zqse4WyJcnnQJnXWCiyE1BZwPKxjwTa3J6AuI78MAMC+ZRrRCO46SbS
 fqsddcafyxWK87uRNKAWW54wo7ud/LgIgzbwkpHZIPEbimHttd4wEwDxy7Yhjhz/DqVO
 Nzlf/xt3N6qJJL3h4wIp6LV65rO7+8wHzfKg8+dSN+Oy/+jIEGf1Z9WPN65tUpHFxRmd
 vDNpslyIqwlkS5pCepyIinjYP5Kum2H6N6lCzB9cZMUJ66rsbMgx0mSTjuwm4cYDMh3F
 bP6w==
X-Gm-Message-State: AOJu0Yw/ik6f0xxy/SVW/doJk9McoRlnrRRJfnDoVzxCSvsFJ8xL1QQb
 NdU99dlAXHRAcxwXTteFjUz7DogZAwtQOnr7uC4sZ3NEB76ODlCYLeDOfmPavMk=
X-Gm-Gg: ASbGncvQt//g9E4zaN91KUtQm8yQpGBQczfkWusZL2JS29HRHAZjile3yCqzHW7kLtv
 qQ5ZBKY7hP7LijiBDYL9RSu7DZ0JUGx2r8KPLmHYtBtlY2mWGu/xdZNrqIaXBu6WpEIgap/0IQi
 j62uN7v5UMq0ZPssP1IMSJFmhLtllwHkN6NSAOw6hRo9fxONJlydN0pan2QYV7BPvaoVwBNtRSZ
 b9VYxGTt4OOYe9uYEddTzU5+7ZOTO6YxGGAe29PspYsuu6vOnng7H4=
X-Google-Smtp-Source: AGHT+IFw/3c4FqBjVaV9o1cpTDsLl8VdW61oHLXREEv2ICovellpBZ2z8b51A6V6ZevJX1lw5Y5TAQ==
X-Received: by 2002:a17:907:7f29:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-aab77eaf35cmr1365225366b.55.1734369373755; 
 Mon, 16 Dec 2024 09:16:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96087424sm347642466b.83.2024.12.16.09.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:16:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 977375F952;
 Mon, 16 Dec 2024 17:16:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
In-Reply-To: <20241216161413.1644171-2-peterx@redhat.com> (Peter Xu's message
 of "Mon, 16 Dec 2024 11:14:11 -0500")
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 17:16:12 +0000
Message-ID: <87o71b1rc3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Peter Xu <peterx@redhat.com> writes:

> QEMU uses g_mkdir_with_parents() a lot, especially in the case where the
> failure case is ignored so an abort is expected when happened.
>
> Provide a helper qemu_mkdir_with_parents() to do that, and use it in the
> two cases in qga/.  To be used in more places later.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

