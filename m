Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D060AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZScY-0007ud-63; Thu, 01 Aug 2024 06:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZScM-0007Wc-Jf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:01:06 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZScG-0005eM-TO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:01:05 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so885562666b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722506459; x=1723111259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UTBpZ4WfhGR6wr0rsPWMHJvB/g81CHGnO+KPNCQUrl8=;
 b=utwxKpkGxvo0y/7EtluOXwmsbt8NzLWVxyStFJbRcdR+MrJR9Ohf4CYKSnZR66zFSh
 wi6ZPAf4r93cKF2szqkOo06bqFEoSpfiM0B0I+6ZTb1nlyg057IuMKjJVmg9UVrStlfj
 xfTRNlhO2Kul8J3mT5g/fyrTou3o9veKiaUd3WdqiB/FuRBbuvC6SKcByrQqm/GBtVgp
 RW9Tb8p6SXnwS7guIsGl1A9FJq1VINMZQF61ywabJNQzQC0+FxbIIonMxJNjm8xrVoA1
 okywAI1mGVSvJTWOD8pmxoi1ZRazY4wTLyOP7nz9a94qVrYbM9aKTgnwKZppCSC/7uAo
 EWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722506459; x=1723111259;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTBpZ4WfhGR6wr0rsPWMHJvB/g81CHGnO+KPNCQUrl8=;
 b=bwaTj9yPj6hc+hsSqdbxbv6GoIZw15bStvBnP4JFyft/xEsNr+F1bBnxrutVwVxPUx
 v2S507BUFzpfWf6ZFJGnmKP6zqcUBXfwcqeRVYzGslz6vOy1vneREYYgOOZIlagvXQcz
 3+e7lb620+Sn5ZnV9KdQSwgEDgc6lRd5SwDOIbLhHGQXdYVHp4TjcjfuZW4CB1NOVR7O
 fBAI+Kk6fLRdP0DoBNaTcS7TfrtjsP2NlX8MiZYh7ktmnA6/H5RO/WyMYjGIvtdEi9ql
 p5G9lomEsKj92mWRqIlx83mboK5wlArKESQdk3zV+HBkY2q9f662QMJglllOlQSv7/AL
 WSmg==
X-Gm-Message-State: AOJu0YwNJBRbS+r0UaqjMpFUu+9xuIX3saAEfPcyDmWX4WW6gHkkCvkj
 OEfKWkEFA+9HTX8Opx53FuOEryWwcrLh2lnj6Y8vaH46KiCO62aWG+pcYbGT0ok=
X-Google-Smtp-Source: AGHT+IGTX94rNEMUKs6V8nykGdwyXbzvXcf77vZEjS/1hYkSDTtlbkZ6iAstJTgdWAbJigHPKnT+xw==
X-Received: by 2002:a17:907:1c9f:b0:a7a:9a78:4b59 with SMTP id
 a640c23a62f3a-a7daf2d1823mr149139866b.23.1722506458703; 
 Thu, 01 Aug 2024 03:00:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab2316dsm883514466b.2.2024.08.01.03.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:00:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C2495F80C;
 Thu,  1 Aug 2024 11:00:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John
 Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 04/24] tests/Makefile.include: Increase the level of
 indentation in the help text
In-Reply-To: <20240730170347.4103919-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 30 Jul 2024 18:03:24
 +0100")
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-5-berrange@redhat.com>
Date: Thu, 01 Aug 2024 11:00:57 +0100
Message-ID: <87cymsef52.fsf@draig.linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The next patch is going to add some entries that need more space between
> the command and the help text, so let's increase the indentation here
> first.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

