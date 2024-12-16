Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6412EE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEhI-0003WV-Sx; Mon, 16 Dec 2024 12:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEh8-0003RY-2f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:15:48 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEh4-0000AG-U4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:15:45 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so880054466b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734369337; x=1734974137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otcxnJWO0xbu2A/X69ClULLe+Xr3sR5jMP83hhyEw7Y=;
 b=Bthpdy/rPxXdO1AFUfniBJBbXjuh/WJr/3h1GV5WRsv3LR0bmmPAlXgtM7j+d6Nyd1
 qcOHwRW/NMdmz0xLLxFnKuzXvBSRuDtK58O3Bi44zbLWFfwU5gEuOJ2xnmjV5bHSkL2Z
 eEXocC51x1GWhfqTosjN9uc9SadQXM0EzYre78fUWQdMSudsHoIPTlC2twN5dTuvqxaM
 MoFYEAqutdUh40Rxdxx8LY038LIx7gyFGH4CmGgPKApU8+LwdEUwsTVaDaCQOgOVYdJ+
 Y/hm3pV+SUf2wEuPwsIAK4awvbcSxUiJPHka0aTwKsf6jxJvkT7zbTnWVgbF/UTXIMt9
 U71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734369337; x=1734974137;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=otcxnJWO0xbu2A/X69ClULLe+Xr3sR5jMP83hhyEw7Y=;
 b=AYhedot48akFxo/SBfqc0Knp6IVLyRYAahwh/yciVaFbgwy4G3n1s7xqnr2KSLWPwN
 suWCsy0QlkOAloK8TRjtcnvqyidSdpT716CcdI06DDDcX/w/KWjuTql8IP3lhC8Elfwp
 +LeQ/MPUStgEo50BHfKx7Ul8hQyoAV2shtZOg94/vdMg/YDBYKgCTxHwuZYtQ+taskCE
 mT/87TzWvQbhMM8WPWWv80mM8koqvztFUK6u3PNDpOWViBj0/VhYIuL3IsOxzw7VnO8g
 prEODwjDwfLTp+VSZmB/6wAv05ZirK2lQ3eRryieKw8QTvGHF2K3c72KrEOZYaKg+3Rc
 WXYA==
X-Gm-Message-State: AOJu0YziZchLgHaTtn/rtcFmdRMMs/E9Q3iahASjckc+JVq162T2BdZo
 KlRZEYaunxFiiDb4LOERlAxLbTg6VlWX6PSEe1DyQNomUXOxZTmxdG/KF0A7nQxpSY/UGc/fMiV
 YytA=
X-Gm-Gg: ASbGncuZetPQFVlEgwJIvjtVN7wX6HOM+Z/HUPdvVb7+7SD4agnGE7F5X1OTzmdjz8f
 2j0vTvMMBialOYPaLKz8KX7hjh72GWxbEFqe5QrZTN0sPET3r8Ol3SVTaRvaaphgOSHi9gpqbBH
 8efiIhlwHLnt7DVdVqJQ/mJN950Bfkg3eO1TUg+msHWytQjlADfby0gRXKGKRPy6QOS3Gq6Jy77
 VF84ElKfD8jAV7ehvKeM3RE5aP1CswAC3GU4beNmFFBztLzrpHOm4U=
X-Google-Smtp-Source: AGHT+IHyciDDu4MzWks8BDcAOzqr9dAYS4ttIMQlMyUw7+M1jDzYtOimt2VjkDNUZ/s1ZyBUwzvXfg==
X-Received: by 2002:a17:907:7710:b0:aa6:9461:a186 with SMTP id
 a640c23a62f3a-aab77e7b483mr1144046866b.46.1734369337129; 
 Mon, 16 Dec 2024 09:15:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9635988dsm353936566b.125.2024.12.16.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:15:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E02C5F952;
 Mon, 16 Dec 2024 17:15:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 3/3] tests/migration: Drop arch_[source|target]
In-Reply-To: <20241216161413.1644171-4-peterx@redhat.com> (Peter Xu's message
 of "Mon, 16 Dec 2024 11:14:13 -0500")
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-4-peterx@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 17:15:35 +0000
Message-ID: <87ttb31rd4.fsf@draig.linaro.org>
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

Peter Xu <peterx@redhat.com> writes:

> Coverity complained about them. These two variables are never used now
> after commit 832c732c5d ("migration-test: Create arch_opts"), and/or comm=
it
> 34cc54fb35 ("tests/qtest/migration-test: Use custom asm bios for ppc64").
>
> Resolves: Coverity CID 1568379
> Resolves: Coverity CID 1568380
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

