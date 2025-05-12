Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F98C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESxc-0001jq-95; Mon, 12 May 2025 09:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESxb-0001jh-1g
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:12:47 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uESxZ-0007oP-0p
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:12:46 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7091d7244e8so40736577b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747055563; x=1747660363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+XQClMX5pWtpNeE5J/PJyn/AA722Eq277GuGl0Rb16o=;
 b=CtnxDWMxaXSv5ioASCixQuA4dBql4EEvTQHvuyQFGZbtjyzl0ZbwjJvNsTGcF8yFpq
 EMxg9xQrSnh33uTPuP3oJVDPz+PvqGdUL2JAx8LtxDn8fjJP6zslRPkX+xoRHSsL532U
 O4GOi8D5xj4YRVmC13cHQDOb/Gveka0kezduFwhqVSxk0xnta9pNtcXdSLGlfcPFbx0j
 4ZYpMsPvPjrh9BxBmD5U1RqaDkUdaQcYGsHgcvB0N7d2whH6zByBvWF8QBc1y0XZh0Bv
 LJVxgo1dwCBXLchJSKR+hHKrxG3CQryVO5ewoRBcYQM+K+nsbRI2z27rJpBraBFM1DyH
 2SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055563; x=1747660363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XQClMX5pWtpNeE5J/PJyn/AA722Eq277GuGl0Rb16o=;
 b=rulZUrjrUSGHtxm8imTYODJNCJ1QAmHm3ebIgr7OQ3J34cB6VCNKKVne594DpZeQAp
 o4L/yA7acHBAvOiVHd+twyhWN8c+k6Gdfn11UHX6tV8Vdh/1fUiGrMukw5ExYkqlwtg7
 SToSisQM4BkrB3+mNACxInGzjMzaLuvlWxe/xsbO3ijE1DTCk0yA+qF158AQha/Y9mlq
 jrd5E//KKU6FRmyZIhjTm79lSHL1mQpjlfUqxfIL9P7TiqX4pvmssI9HxozsSW2oc4ht
 ivsEBDFUO2ux0dXr6AMM5ItXckX/hOmF7ZxNXwEN+LLDkRp5252ouEMUzf4oc2J3N7No
 P1ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw+457EPi3mFmJpLlwsSyFUMAWwa/n3mNT/K39mMfAa7EjP71Kffn8gmqfvfI5z5/3fFBDOYqUJ9DG@nongnu.org
X-Gm-Message-State: AOJu0YwlEonDVgLgsp0atrfA1jZni4CaYYW5l0IwN2XPbO/FzIVCGhXl
 NlY7JVeycjPp7nxM0gGcsAwuCcX9XerqlYBCXQFKAe16ArulclZIRO0T1ZpFPSw4yzsj0dcMhVT
 AhakdJGCDnooU6lO9ApfYTzj+StnedgZEzfl75Q==
X-Gm-Gg: ASbGncvz4IkfEFm1QX+kLysNpq3o480YGwJ/6hQ6O9nG24279CFCg3VxeMXeeEmfKry
 wzCN77mgWWaoYMrDVi78ecyux3WmqFTxCE5kDynyAciep6j7MPTQpKnEGggkxy+XZfasD5OhtQe
 qyiqzJgSTFXngBtcrakmqDOl4HRDvDsXuHhg==
X-Google-Smtp-Source: AGHT+IERER98JYjdGqDU/DruIrioOHGmov9dd2j4dmhavG17HWYxPA+pFilVNlPsn7v56eyKxpjlpjPWfUOlAZ08Z7c=
X-Received: by 2002:a05:690c:4b04:b0:702:52fb:462d with SMTP id
 00721157ae682-70a3fb1250dmr167571137b3.29.1747055562857; Mon, 12 May 2025
 06:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-10-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-10-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 14:12:31 +0100
X-Gm-Features: AX0GCFsji6TNvFHFqLc_pcx3ItCO27VDAVqSAaRU3NbqGyz5J1byXoX-4x8p3r8
Message-ID: <CAFEAcA-DaESGExWB9bgMW-MTeX+_5Pp8dZMmaUNSFLCkgvmhWg@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 2 May 2025 at 04:33, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> To prepare to support another USB PCI Host Controller, make some PCI
> configuration dynamic.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I think this patch is trying to do too many things at once.
It's OK to bundle the small "turn a constant into a state
struct field" changes together, but the ones that are
more extensive code logic changes should be split out.
In particular "add support for pm capability" should be
its own patch as that's a new feature, and it looks like
there's also a change in here that's fixing a TODO comment?

thanks
-- PMM

