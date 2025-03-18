Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77563C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 10:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUFc-0001yE-Gs; Tue, 18 Mar 2025 06:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuUFJ-0001sB-PV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:32:32 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuUFF-00055p-0l
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 06:32:28 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e573136107bso5086174276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742293943; x=1742898743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9e/0qq1rE0bHzPkXA6OeA4qlhMl3ekhtHEyQQmXZOg=;
 b=iDaXoFfeVEtpdgf/yFHlddUGvGkihEkvOmVEoMvIJWLZqOzH4BzA8Rznlx/7zO2vaH
 Q4JkYyKdkY0hrpp9zXni7TeIx6Z4ehHLuRmTxZauOg7NW9pAhhn0q+SC8fD9ov/qF+LG
 ulSokjTPqiK14T+Ts4G0Sw8EXX0ldtfM9+JMBB0DfEGvpjYBVNCNSHbY8kUBjshvVTUj
 WU6CkK+6FQzg7VyCt5ur2nfj8bMpuqjYa7NVRiPBWDmALm49WSXtu7/LP6YH0EOGm/US
 HpxYPllgoYJLuda5vJ4REyf66FG51fx4o2bEBozL73S914sKZ8agimpXeH1uRMiRinP5
 ciaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742293943; x=1742898743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9e/0qq1rE0bHzPkXA6OeA4qlhMl3ekhtHEyQQmXZOg=;
 b=Ye5OnVqKUbimfsnmO1/QmOAWBryRYzNL5kdDezEIraqs6yeLv1QS4mj0E5KYhtFTiO
 l3FbDZcM6gOVvFvZVZ2p9RcQlLRdE3Xoln1QXnrAadjM/C3HB9s5qZ/kdKTAd9nHKgTS
 Lc+qCo5e61qsZlbyNYva7LFoq0aKwQ+p1Q6QQ+nyzrdN6Qoo+c8MoE/sutvwBV3yNjx6
 CEAYBddzldIsgl+k2plYQpJjR7tSZMvoCscfwO+qwv473Kfs5oI2BLJqF926+W9CFuL8
 0YU8QeLsRHpNFHHwGjdQreyOsl44oZmM2UwRLHi0H+2zjSc9E4Jd/hnbqSFa0LhYUO5g
 KqIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCnwpU1gKese20JEpXzGRkkj/gLsEWLgvBZFJfEisoeNAtmYCSKmKo0se8LjtYAALmuusv7PukW49L@nongnu.org
X-Gm-Message-State: AOJu0Yy+WMw9F/DmeMWgG1EL9wH9Yc/GM4jsuZj3Vdptghuqt+RILayI
 vMH86gjek9MUJN/2yRUzCgLwU3d0H+wwFuE7MCvrEq+kIfqzpIFsUJ/WzbnywVkt9MlVmqbXpI+
 YznnxStgVD5HBaI3njQwiEfaKotc2nyTpvBOwhg==
X-Gm-Gg: ASbGncvqamzB6EgDocPwRNw+WJ6Y8eXg8q26JPHB8yQgvqez7UWzpDDerSo9iSJhu0H
 HXHlvYnftCVZCYMrw1rcmySrLItAsAIDKog05OdFi/k0FR+8kclOwHZXb712JMSc4DgtoLM/Spw
 1Ehkm2ENURDGo1YNaiHAfVmuuV3xI=
X-Google-Smtp-Source: AGHT+IHn3hQ7eud/FMfkidW832vHlgCpdVnkON4iPnX61ok+eaToHVyx3V31d1z0Jq6gCbXGsWBxpgAoHui/4Jlb/cU=
X-Received: by 2002:a05:6902:1b84:b0:e58:8e82:5345 with SMTP id
 3f1490d57ef6-e63f64d8d2cmr18386868276.4.1742293943421; Tue, 18 Mar 2025
 03:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250317173239.941034-1-peter.maydell@linaro.org>
 <Z9hxJZhDO17SjYPS@redhat.com>
In-Reply-To: <Z9hxJZhDO17SjYPS@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 10:32:12 +0000
X-Gm-Features: AQ5f1JoXYHtI8-aJlw5h0IIfsc_nYTs7Xmh2c9JNJeH95gI8vPCv6AVo9k-2iE8
Message-ID: <CAFEAcA9-a9MFTXew6c-UDSzpprTCmPtkNHmssvV19aTE201C9g@mail.gmail.com>
Subject: Re: [PATCH] rust: pl011: Cut down amount of text quoted from PL011 TRM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 17 Mar 2025 at 18:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 17, 2025 at 05:32:39PM +0000, Peter Maydell wrote:
> > Currently the comments in the Rust pl011 register.rs file include
> > large amounts of text from the PL011 TRM.  This is much more
> > commentary than we typically quote from a device reference manual,
> > and much of it is not relevant to QEMU.  Compress and rephrase the
> > comments so that we are not quoting such a large volume of TRM text.
>
> Is there any significant amount of quoted text remaining after
> this patch ?

No.

-- PMM

