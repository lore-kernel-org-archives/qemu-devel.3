Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45573CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO8f-0006K2-St; Tue, 02 Sep 2025 06:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utO8e-0006Jt-6I
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:21:20 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utO8c-0007zz-6m
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:21:19 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso288498766b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808460; x=1757413260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x3b5/s9If+DnxIWAiX4ATSffwuvhZBjQMaIJiLs3wU=;
 b=rm2dBnDqGeJzI/uZuzcgaHSafNCMDjDROUDQLUzdOsZ1IX2Rq/G2tDd4QrxfLWW9j0
 RjPggLvr6r3y9kHcQObd/o6CGacgcjFfpw6vWirc1MDvN426p9/tIJtKKGQWyY9Zpuip
 64OmN3DHrblqRkG7oK7d71APF3YnTKtgCqMpXpRJuKLHTeaGejH2LaB7++QsiRPva3mi
 ZolwOTkBS6/1NglgahaXRPOmPIWiqsr1eqGkBe+GumP2vEnvdlI2CZtrN7zZkFXadmKG
 huLxguNWuc4nl0iZWxeAG839SMlCB/eZZLplRsFTKS+4UZtd1AvRa3G/ujx3ENy8ntqg
 Drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808460; x=1757413260;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+x3b5/s9If+DnxIWAiX4ATSffwuvhZBjQMaIJiLs3wU=;
 b=ZCL4zY5o9EcrccvvhPRNWhxDZdkmQJl0tWmfnfJAUUTU3lMYc70UnwIQbEUZf0kEe4
 N4vRUj5QisJn91xV+vHceLe4QGS3dT7wUe+3RoD1FLZSIjveI02Fa6rVQ0YCaLknkpVr
 MOXZb/BxqRJEnyf9gLDpmOf7kzwVsr8R0naltexolu5+5tBZjH8++nXKcDkq4p98v45V
 HG8Z/DMoc/f7P4RX0DfPMsBssO0BkIXWb7a3iP0jPcOsv1zo9jtR0T4JtCF2sp9Abnam
 vlaVfuVnnRdh4/CXJRmGNC0QqCpZfVhUiTTFHECaCYOH6B9hg5Z/g4lyghnJ5fCRQwk8
 5ojA==
X-Gm-Message-State: AOJu0YztiMECNMKA807AqXjqQzJmTKF6ntAuhSHcCW654dd9wrZ9QHh7
 xVSSdCS6fhqVvaiCSlRUZztJDNj/inXneIWO75isjooPY8kqQyAKJG5ol/DS9uIB7YjDHLvwV5z
 jJxsysp4=
X-Gm-Gg: ASbGnct5NA852FPeZcdNAa1Xwu9TEKcjU37Un7VJrX30DtvjBhKyQCI4bPjimY48brS
 lQeTd47AoZzqb5ompKdtr9ejV/bomRYMd30k2HXWi4C9foSd2YCQ09yKPLkKjzWQi7TAIeFxMEl
 e6XUCEhcnw7436T4+X3ml+XhnQDvPlDY9kAcDfDB5NvpX9wwEVcmUhvtw/0YXZ+gWP3ihsY/xF6
 QyOMqSb5lO9tzpRZopAVqOmfvYScrp4yW5494XEgDTOVMM2IiWVJD0+wMnGPbpVEVQ3zqzAVRRk
 v3UGiyjnp+4PTFgzswtRCdQCQXBSYg4wBVI3wm572OJePO8NdB5qN+rrR1F8mih3AUARdhcAzZ1
 H7zII/u8iN+J2716m0ltlnaY=
X-Google-Smtp-Source: AGHT+IEgeS0SkbTK037y8h6ez4nByt4QS1rYLZRxXZy8/aD3Vv6RxM6pLqWGQLEndrjXKyZedPqY7w==
X-Received: by 2002:a17:906:c10b:b0:afe:954b:25b2 with SMTP id
 a640c23a62f3a-b01d8a26dcbmr1098300266b.12.1756808460380; 
 Tue, 02 Sep 2025 03:21:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff173ddc78sm869379166b.33.2025.09.02.03.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:20:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA2F05F894;
 Tue, 02 Sep 2025 11:20:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cover.1747666625.git.neither@nut.email> (Julian Ganz's message
 of "Mon, 19 May 2025 17:19:40 +0200")
References: <cover.1747666625.git.neither@nut.email>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 02 Sep 2025 11:20:58 +0100
Message-ID: <87o6rtyx2t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
>
> Even with the existing interfaces, it is more or less possible to
> discern these situations, e.g. as done by the cflow plugin. However,
> this process poses a considerable overhead to the core analysis one may
> intend to perform.
>
> These changes introduce a generic and easy-to-use interface for plugin
> authors in the form of a callback for discontinuities. Patch 1 defines
> an enumeration of some trap-related discontinuities including somewhat
> narrow definitions of the discontinuity evetns and a callback type.
> Patch 2 defines the callback registration function. Patch 3 adds some
> hooks for triggering the callbacks. Patch 4 adds an example plugin
> showcasing the new API.
>
> Patches 5 through 22 call the hooks for all architectures but hexagon,
> mapping architecture specific events to the three categories defined in
> patch 1. We don't plan to add hooks for hexagon since despite having
> exceptions apparently doesn't have any discontinuities associated with
> them.
>
> Patch 23 supplies a test plugin asserting some behavior of the plugin
> API w.r.t. the PCs reported by the new API. Finally, patches 24 and 25
> add new tests for riscv which serve as test-cases for the test plugin.
>
> Sidenote: I'm likely doing something wrong for one architecture or
> the other. These patches are untested for most of them.
>
> Since v4:
>   - Fixed a typo in the documentation of the
>     qemu_plugin_vcpu_discon_cb_t function type (pointed out by Pierrick
>     Bouvier)
>   - Fixed a reference in the documentation of the
>     qemu_plugin_vcpu_discon_cb_t function type
>   - Added hooks for SuperH and TriCore targets
>   - Fixed typos in commit messages (pointed out by Daniel Henrique
>     Barboza)

Hi Julian,

Just checking what the status of these patches are. It looks like you
have a number of comments to address but the number of reviewed patches
is going up each revision.

Do you think you will be able to spin a new revision and look to get
this merged in the 10.2 cycle?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

