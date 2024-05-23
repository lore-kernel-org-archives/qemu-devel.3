Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCA3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5Bf-0003LO-3V; Thu, 23 May 2024 05:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sA5Bc-0003Kq-Mu
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:56:36 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sA5Bb-0003A3-1l
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:56:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59b81d087aso1064960566b.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716458193; x=1717062993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ypK0+3dGWYb2r7uaXhR+UxFkof7Z1yElfTNTxXeTzgo=;
 b=d0rlwG9KkpUuBqjB4jt0M4zA1M5BSzmkWBOeMBk6Ni92hGi5WT8dRRdI2Xbf6ZVsUE
 9nwJMZhx3MSSN+JG2A3OIiRf7NRHRnwF6z7+sojktT67e2cLPRG7Iq28C/oHkT1Pl9Gy
 9lA9ATORQQ/0vEqQazIxYH85G+B+VGEoU78VCA4sRxsc2D/RGPVeERb4IMIiqee2B4Vj
 2qKrDhC7Lw33cGyl62mYKlyDhCl5GzogjSUppeEBBKOYq+eikJc6HbK/z2tUSXWv9cA+
 qdPIRCRvbaBL6TYbk1c+CtV4brdVQckZQS/FYlOuCOlJdxb85ne1K0/JI2pFpZFAO+yi
 /pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716458193; x=1717062993;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypK0+3dGWYb2r7uaXhR+UxFkof7Z1yElfTNTxXeTzgo=;
 b=DPVMqEsKP79rcOpNinRQab8Hoz5J76XAbM1+jkBh1/HjL3gZeJM34KFgocQhpVhvEJ
 uaLo6DTJsPm4rQhxvU9Nygiun5I/vxzqWvdKuoXAqCybLYZbAIuqoXSGwN8GaVkszFOi
 i/9/SYCC+rIShgTBDunoVtkq1ljDcK1zbAT/fZZaNk9DC6HYOvpdOj5nw1cadRsf4wct
 DwUdpKQhMdoXn1RjltXGHLz+HhglEHc6QMaT/r1EioDyuaAHez6SinfXrUEmjFg0v7MC
 RQfKTmpUnTzUkIWlCDRlgy//4kZKtQt77Ud44NY4IKNe1kTM4ZQkep2P28IKd1tQJoB5
 ejFw==
X-Gm-Message-State: AOJu0YyubuhLAOHkKrYQMQEo4tm55qVBgivVoGWoHsKpkBMpsSJtRu0d
 KRN1qdYqMTiKt2yiuoOW6d87rIfzp63zzmOf8z5oKt1iZXIoms8Es1z3s85mE+E=
X-Google-Smtp-Source: AGHT+IHx79oGyYuHf40hG6jcJ6kkXV82rDi8+aG3KcEbi+p/kU9g5HRuSEtsn7cZOsyk11M5tK+TrA==
X-Received: by 2002:a17:906:94e:b0:a59:a282:5dbd with SMTP id
 a640c23a62f3a-a6228208574mr362366866b.66.1716458192615; 
 Thu, 23 May 2024 02:56:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a623480d162sm137715666b.61.2024.05.23.02.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 02:56:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 489FA5F7D9;
 Thu, 23 May 2024 10:56:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org,  den@virtuozzo.com,  michael.roth@amd.com,
 kkostiuk@redhat.com,  marcandre.lureau@gmail.com
Subject: Re: Test scripts
In-Reply-To: <b2c65317-4b52-42d9-9b7f-471b2a2140fd@virtuozzo.com> (Alexander
 Ivanov's message of "Wed, 22 May 2024 17:23:07 +0200")
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
 <b2c65317-4b52-42d9-9b7f-471b2a2140fd@virtuozzo.com>
Date: Thu, 23 May 2024 10:56:31 +0100
Message-ID: <87ikz4hmwg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Alexander Ivanov <alexander.ivanov@virtuozzo.com> writes:

> There are two python scripts in the attachment:
> vsock_guest_exec_simple.py - simple example of a client;
> vsock_guest_exec_test.py - tests with different payload size.
>
> The last file should be copied to a guest VM. Edit SRV_PATH variable
> in the host copy of the script - there should be path to the directory
> containing a copy of the script in VM. Execute the host script with
> net arguments:
> ./vsock_guest_exec_test.py srv <VM_NAME>

Maybe these would best live in contrib/vsock with a README?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

