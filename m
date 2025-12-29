Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E4D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va29l-0000iR-9w; Sun, 28 Dec 2025 20:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va29a-0000i5-Jr
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1va29Y-0005GI-Qj
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766972071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tMd5bIHd3kL3Mm0vjZ0kSE0+JN0XOeKspccI5ZK1uqo=;
 b=AFiw4kWAWWil4oicC9nuBBQqGSNq0AP1nZ+a6ppHFEr1OsvfZDKCVQB83JBr93lNiOJ6d3
 BZMB+ch+YidqXy8/vn5l73ayH/on33n1GTWafeHI51CugDMh5NG8xdn7w3pCiq74IxeTNS
 QCKDXaGrvIuj6gKV5bUHqT4gxkrqA5g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-QlEYB5-aOyOCyMVmSSBXqA-1; Sun, 28 Dec 2025 20:34:29 -0500
X-MC-Unique: QlEYB5-aOyOCyMVmSSBXqA-1
X-Mimecast-MFC-AGG-ID: QlEYB5-aOyOCyMVmSSBXqA_1766972069
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ee0488e746so193417601cf.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766972068; x=1767576868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tMd5bIHd3kL3Mm0vjZ0kSE0+JN0XOeKspccI5ZK1uqo=;
 b=DHEIFUHch0Ku8B9sdWrO0pIUT8+GXH5VJKpH9NlYcPWbOUloXz4zk6mG/0iV/XNKLa
 RRiNWANv/22fHpMvRt7pVrFndKFRrNBr7Wtm2jsgmnAkN4gLXto45C8h5RAY/oQkaa6a
 Bhcl3GxhQ+WI78U6vCWgZHVh43RhqHD3C2Ad421B3kmyYA6Bpvlr8haRUw1mWFTt3HhR
 kqXN+j+RCTTnDxro4MC3PwH1MNo+951dXgvlnLQ9kPeNDniG8byVng6FAE1T0Pox8QH+
 e7X4Uhu0cCTndm94jdHCpqJUVVpOuxmC+XU0QGCHT+c+IW44H7EGgYxJWrpVLpe0pELm
 Wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766972068; x=1767576868;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMd5bIHd3kL3Mm0vjZ0kSE0+JN0XOeKspccI5ZK1uqo=;
 b=PTXM2eIr2iaRwL71gXCtygj6mSj5SB2fQHopBy5u5pfqcGayE3l0IJgx7/DdhycrYQ
 38ZaG0kKRYMt6lyW6wo7Q1LVPXX15NWN5abQ5bipo5c5w/byyjyB4ClL7glbh0EFwAmh
 zxQwWMzsdBhCILHkHj4y5qCjB6bjoJCHKkav5zDrLIHncxwga2avlvi//Yd3NZPSj1D7
 PPFALEG0mmRh4YeEPPI1aibvk3eA2GV13jPVDH8GLAbFb5Q7tnHywX74AOJkmEvoEQcC
 bNfjNyS7o3sCEXtc+7LLDSfStaJyKLB5lTZC0jtt8CJbW1YDWRObyDP0nve9PrVFgnO8
 odBQ==
X-Gm-Message-State: AOJu0YxE+DCE9liO06YDa1+t1DFZ4KrUzim/UjYdAjr/yHqwk09nNbtm
 uQLwIv6++LMGO93ci9hPCXvVvf8YxAU42f1ZMeleOBH9tWFs2oOKZ73P/kTQqiFSQ1DgTb5z1Vq
 gk7iCN9lqrynfI8hZ7Rz/E6FsMjVGfNfZ9KXiHiYMCyJ9OmiVKpnJF2kFV3fHMJ1mBQtjogobiG
 /svfZ4+Iz1OCNYMk+WDLaH1I3Bop8at8hmQpyFvmA=
X-Gm-Gg: AY/fxX6mf8CuR9p9FIooZDHtB5FUEhwyYgPJKU12gVwG4OP3/RQTMqXtMCw81gpgXWV
 RHcGfiKWUVF9UTpWdMwZ9fL6tRYBU91PAxLWpyenLMrb6nqeck18AbuSwNu3KocUq1yAvO2EVmp
 OAyESkGsuZAp0SVZzG/erz05+HtMe4yfwvcwTHc4ZNllMup7aBnYowlwowUm8Adv5u
X-Received: by 2002:a05:622a:199d:b0:4f1:af84:387a with SMTP id
 d75a77b69052e-4f35f3a0267mr445658541cf.5.1766972068457; 
 Sun, 28 Dec 2025 17:34:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHubiXxmGjpTmIEGmuKLLpDEvHscnCZZzEtFaDeI8FwJsu6HpG0MB7S+SgkSjM4AIFrsixVhCalTBkvgb197R0=
X-Received: by 2002:a05:622a:199d:b0:4f1:af84:387a with SMTP id
 d75a77b69052e-4f35f3a0267mr445658321cf.5.1766972068119; Sun, 28 Dec 2025
 17:34:28 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Dec 2025 19:34:27 -0600
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Dec 2025 19:34:27 -0600
From: Andrea Bolognani <abologna@redhat.com>
References: <20251228232649.1708400-1-abologna@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20251228232649.1708400-1-abologna@redhat.com>
Date: Sun, 28 Dec 2025 19:34:27 -0600
X-Gm-Features: AQt7F2q9MCHpLSiwdbo5RqRTZ5t-NO-t6aubxjQXFgvi_vV_GSQsCQ-_N-d8SPQ
Message-ID: <CABJz62Mj61G7feKyBe5JWh=zp4_6X6HfKe1z5bO2aCqd_3SdmA@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs/interop/firmware: Introduce extended syntax for
 FirmwareMappingMemory
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 29, 2025 at 12:26:47AM +0100, Andrea Bolognani wrote:
> This is part of the ongoing effort to make Secure Boot for aarch64
> libvirt guests possible[1].
>
> I'd be happy to have the QAPI experts debunk my claim that there is
> no semantically-meaningful way to represent this; in the meantime,
> I'll be posting very shortly some libvirt patches that IMO prove that
> supporting what I'm proposing here does not impose a significant
> burden on consumers of the firmware descriptors.

The patch that extends the parser to support the new syntax is [2];
the patch series, for context, is [3].

Note that the libvirt list server is acting wonky right now, so you
might want to use alternative URLs (e.g. [4] and [5]) instead.


[1] https://issues.redhat.com/browse/RHEL-82645
[2] https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/VKZQUHGGLKP3YWX5FCY4UUVME4ZOIS34/
[3] https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/TGLFMPRXCATRPA6MPHH5KYXY5XCTSRDT/
[4] https://www.mail-archive.com/devel@lists.libvirt.org/msg13963.html
[5] https://www.mail-archive.com/devel@lists.libvirt.org/msg13955.html
-- 
Andrea Bolognani / Red Hat / Virtualization


