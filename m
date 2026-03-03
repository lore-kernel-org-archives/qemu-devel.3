Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C3EC142D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNWy-0008Ho-Ud; Tue, 03 Mar 2026 06:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNWw-0008HB-Dg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:03:10 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNWu-0008GU-B0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:03:09 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65a2fea1a1eso10072682a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535786; x=1773140586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38hw5S4KVNed2/5RnA/Nwvb4wDrTOuvlN1q1DoxTwBk=;
 b=WdNYt7fuMemv/wIuWv5bdpfCXHaSY6k+X11PK2V8sOyWbKNEXbqnLhBegiv5zSIqJF
 XanQZ3wvOVDq0Amg49HnPnG7t5Aphk5I8QW8Sh3dvFU13S0CkdvWbwUYfG7BrFKDyd2I
 2RpP+Kssn4rBd90buxZReugun8NEh/z6DoFEpEbKRD2ne+s7mZN9QuG0JlTLH4boTxQD
 i3hB+0gXj+3Pc1POU2E4aF6RhPMePl2VJXLpvZ78B3veCsglqC/6d5NJzke2ifnGmouV
 KfJhGz/gHZFxJr7MVmXwj3onAVktz9IQ7iA1OssSpUAzleq7xtxtJMblNM2AQj4x5he6
 bNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535786; x=1773140586;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38hw5S4KVNed2/5RnA/Nwvb4wDrTOuvlN1q1DoxTwBk=;
 b=kQLl9O+E2fqyQWtCN8TNeXHewUP5wnRwTKrI3fcWjN5rKzfTc5bgV9BfLDdhrs6Acz
 9XL/y3rVIq6LAsTqQh/zr+xHEscHVMegotZMAFY0zpJO7oULrA229MBdTpZKEImetgq+
 pHUHF1//zPkmEsUwkS9Ck9rs/b1f2lC7A+k+hMNzFf/wUuICAilBCsavaow2ujR5Yz5L
 qlzxh/qd4Vf3C1tPSM5FYSpk/1IUTWwD+Bx8Hj+DInTTs4LPRFNKQhcZUHIHTINV9Ec8
 keEd3LHEeYHuuiy4Wty5+zXz8xC1OS5deEM969MsLDSV40IC9sXAvqFAWkqqrieRm9KJ
 uQOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIYJHheHFvdFbkRGkvigu9QqSCW9bE3NJ2MoyfVlJftHLNQW8AXMxIR4bx3ooPa7nlFSROfGG4Le1+@nongnu.org
X-Gm-Message-State: AOJu0YyuxkrxNwXWGGE/62aF7MQgMqHIc/+IgCvsT+qcrOIG86RBMRVY
 kkdaLPtiEjMhleXI94VhGK9F5fmEZ7CI/j9LocL6j//J7M2QVP0uAiCYam4Afp86Fk0=
X-Gm-Gg: ATEYQzwC9gT4Fxws6/qC2U/fN3xO5lZssqBvk6nWOaWNmlpVc/4vGRNSNup0i74Mdxq
 23kKL3fSCi5Dr4+buDsBVk01iBqXpOsuVK465uaqht/zEvDMeCrrBNqEocpHvlZy+d0//FZ/Dbp
 PVQ+he95tn1t8QiHWmrQdZB6DfH6YE38hOB1MOGnP8IgQT4dByFGG11rDAk+nx+J63YJ47icnqI
 OZFVu+vqDnsz7e1VqOulOTDorBCF72c+EqJOtkcHnC4XRs6npVcHNp+dQ1u8c5/2PEdjOxhu7Ip
 Ja9ak6ZGu4vafOiRMG4IkpgQ93PremGyG18Lu+gEH/FCNz/DYlPRhkT+d0bDytIE8TTFm3S9Kdg
 8/9S+bpfTL5OBC1Kjn+SJekzIPqK/SnV3sS9YWZ6Vj+fqCfg4fdFv10GbwQBQ1ZTAguBfWOdkQU
 ZPrCqJG5InvWMKVTKGYnwj5IM=
X-Received: by 2002:a17:906:209c:b0:b93:6bd1:a4ba with SMTP id
 a640c23a62f3a-b93d424a076mr76708266b.3.1772535785543; 
 Tue, 03 Mar 2026 03:03:05 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae612f7sm594245366b.36.2026.03.03.03.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 03:03:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE3735F7C1;
 Tue, 03 Mar 2026 11:03:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrew Keesler <ankeesler@google.com>
Cc: armbru@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 0/1] Support per-head resolutions with virtio-gpu
In-Reply-To: <20260210123038.2332364-1-ankeesler@google.com> (Andrew Keesler's
 message of "Tue, 10 Feb 2026 12:30:37 +0000")
References: <20260210123038.2332364-1-ankeesler@google.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 11:03:03 +0000
Message-ID: <87a4wpch08.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Andrew Keesler <ankeesler@google.com> writes:

> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

