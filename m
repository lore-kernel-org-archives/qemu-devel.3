Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA411C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tex7i-0007fe-4Q; Mon, 03 Feb 2025 09:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tex7h-0007eO-28
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:08:25 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tex7f-0006qY-Ho
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:08:24 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so713095266b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738591701; x=1739196501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU52AN2OUlZ1qKBo1DH2Ik2TSp35tGJqbGoyklt/ofU=;
 b=lrNfw1qn/zmUzRSKdLjGe7KIJbZ2nMPP9KuELVqWIldyuKHiKAhZEWakr1sBS38HlM
 soxGyi8QwCSeco8lt+qRnN/+lkmtFYdYEhy+it7Kwo7LFbGhtBYUXvBL60Zs0eGoa1ZO
 jVX9UznPOcZmBoA+qzrWUfnFnnM/cnem5cNCm64BFlF0G4T6JfPBhiWzXMw+9yr9ia1f
 p6UdmCRvmwx1AAE5S2StI8y1pYxsqvHhFoBL/RFRA0B9etkzyijAE77eLOtRkuDWrtky
 qqO6tOSbMNjJgtD9mgSGBNvG1PXMyz6XWDWxKhp5wTZ8I/B7EZTO56H91yX0xdYakPaJ
 /JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738591701; x=1739196501;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WU52AN2OUlZ1qKBo1DH2Ik2TSp35tGJqbGoyklt/ofU=;
 b=mKXnRfHaoOQKFU9gARMUHeBvEkcGqEnUPi4TSboZatUys1Iefg2dkVZ0l89HVGgbGw
 CcOHi/El4sk2Sb9aTnMExK1G+qrkMAkNvClULupkgQWpv9zM0L2U8H3Aj1hQ4OUoIzJa
 elrZQSvh9vP6W7xNpgSmMv7967LvBWgf5Q9w9d8HIpVgJRIeBl5sSzkXSqP6pm36xezQ
 ZkVQvyuMnn0j+blWRx6HV4ItF1l6IPArNkDvs5f+sLVsKR3ysoQeloqCmFzVh/3YkdCg
 Nhnh8jgWB9dKUClEkeneDtBp82s15X4UhZjM5XOfTRUN5RsQOW9u/serDa4TldFq8iVG
 k8Wg==
X-Gm-Message-State: AOJu0YzkF8q1g4MVsaUBEYQZKmzv6FrTFURnDNsm9QkVytJqYJ/DSz5n
 SdEIwjWTorxFLp0/kU67EwlFpZB35vr8gEEw4f8BVwg7gi0IoayKpXOVBIwqjAU=
X-Gm-Gg: ASbGncuSfamsdFVqKRGu6VXbAvwUedHwAH4Kve2cOySuiX/T3CA9QcRcFb/zW2Hrnw0
 F6DbRD1sA4GEZsSxo1vXexdxZFstF6AsHoR/vT/ZBKV3tfifVg9oQVyZnQ7PRI9gKKLa9FnT4Rf
 bWroLfqKB5s+OsFAdcHjTR+QCg8ZZvYz6hE34nDvk75WuIRp+cnQD8PMTUjsWYa10U20SJy3YL5
 XmrC0LsZh4Pb0EUklRj+eoAu+Ee3PmevENQvFkMINLcdNPFoMdq4Fvyaq60CVDq+9olVcLQR0Tr
 PReoc4fI5VmbqnQcfg==
X-Google-Smtp-Source: AGHT+IGh7IreZa8eW2wqj32gawdJUchpdge5r622aiXwj57S1ABb9+gN/n+0ZOTJ2GEMyp3KWOsQiA==
X-Received: by 2002:a17:907:97c5:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab6cfcb6979mr2690745666b.11.1738591699716; 
 Mon, 03 Feb 2025 06:08:19 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a56dadsm764843866b.176.2025.02.03.06.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:08:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 442B15F8BF;
 Mon,  3 Feb 2025 14:08:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: Reduce migration-test time for non-KVM
 archs
In-Reply-To: <20250130184012.5711-1-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 30 Jan 2025 15:40:10 -0300")
References: <20250130184012.5711-1-farosas@suse.de>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 14:08:18 +0000
Message-ID: <877c67ce99.fsf@draig.linaro.org>
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

Fabiano Rosas <farosas@suse.de> writes:

> Hi, continuing the work from the previous[1] series to reduce the time
> migration-test takes during make check, here's a couple of patches to
> create a smaller set of tests.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

