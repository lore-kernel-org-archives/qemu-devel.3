Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8118EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJT7-0006Zx-5x; Thu, 04 Jul 2024 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJT5-0006ZV-U0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 06:13:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJT4-00062B-5L
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 06:13:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77b550128dso57553466b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720088012; x=1720692812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fPZzP6whuOS4Z1W0BwVKBk4bkGaqBjTPifFKj8lK9w=;
 b=gQi6fHokSBNtVPWzuqQJXKqaxLVAnrwOn2ImAb8faf1vmFfKY6v7laeVy8HDzmCLgB
 ve4zt7M1PDbSk7lfv14zqZ/Vmu8TCHhiBcmZRlEe9nrvvSJXdq9eQQl/RPH22s4jt5zI
 IiuickNBnWDvyXWPZ+CkuJnTd01y5jpFoPvRvJaVBIS1JEkpGYWP3wxkTfgNtWoOA/HH
 bEIdj0oqGOCQzWQ/S4JgJobQfjNwklvyTcqyEiPOYAV2hhOIcV7jvzmEKNpxszqzruv1
 47vx9eFoeYA2zlfdWrcK9/uwvRxRRAuAK7i/+moR6aSe3Sk4nHxDIDX9CwxsCaCN0bDi
 pQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720088012; x=1720692812;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fPZzP6whuOS4Z1W0BwVKBk4bkGaqBjTPifFKj8lK9w=;
 b=jNW581HlHR1QRZaEUOKxSmdKzZDueB1l7sZeDGw5YgsLa+AQCeubG9YrSedE8kdH8h
 KB0SLfvUpgxxsnfJuLiF2Up7u/oOIGv8L4+hqfPUaF+Oy0nJFbQF6pYj4Cmreq2eadgT
 iPfPuMiEipEpaydWeRDunE1I4T5Gb2mYVkHDN4ck3Hib2YxOW3lGKWUZvZgG2xpZOBta
 /d2iDsi4+B+W1dg2JlMLVuCIavFeAZSTYZwteE2R7bB+udCFcuGSKkRp/Hx6NkQwFSoG
 /kw2U0/vhFKYiJSYEkyoEbRDeSzy+5Ourok9WAWfj4iuN3eVtd6A3AAoD5WAo0RIJUgH
 xi7g==
X-Gm-Message-State: AOJu0YxdMn7OOE+qJy7rxSbKXBm/yQhAqUa3DkN58lcplw0RPlroAXp2
 XaWntNp7x3otc18B65DqUccSDWZXfx9T5yCuVhrcRdfNZaUvS6okjDWy58T1zpo=
X-Google-Smtp-Source: AGHT+IHxW1dPktHnMskA6cWvuM9zyj0zPtoeEHrcnvhbqPDxlxm0xefDiBij/n7DRtLKQVn0w1H/Qw==
X-Received: by 2002:a17:907:1c1a:b0:a75:20f7:2c71 with SMTP id
 a640c23a62f3a-a77ba48e4e1mr105445366b.38.1720088011699; 
 Thu, 04 Jul 2024 03:13:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77bdbdbbd7sm29324466b.164.2024.07.04.03.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 03:13:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A1BA5F839;
 Thu,  4 Jul 2024 11:13:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH 0/3] plugins: Few debugging cleanups
In-Reply-To: <20240606124010.2460-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 6 Jun 2024 14:40:07
 +0200")
References: <20240606124010.2460-1-philmd@linaro.org>
Date: Thu, 04 Jul 2024 11:13:30 +0100
Message-ID: <87msmxo46t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> - Assert cpu_index is assigned in INIT/EXIT hooks
> - Free cpu->plugin_state
> - Restrict qemu_plugin_vcpu_init__async() to plugins/
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   plugins: Ensure vCPU index is assigned in init/exit hooks
>   plugins: Free CPUPluginState before destroying vCPU state
>   accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/
>
>  include/qemu/plugin.h |  3 +++
>  hw/core/cpu-common.c  | 14 ++++++--------
>  plugins/core.c        | 10 +++++++++-
>  3 files changed, 18 insertions(+), 9 deletions(-)

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

