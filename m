Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD60CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slCGH-0001f6-9r; Mon, 02 Sep 2024 14:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slCGF-0001W3-62
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 14:58:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slCGD-0000al-Jz
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 14:58:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso4153936a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725303524; x=1725908324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy8AbH05dPNdEMcmHsRkfyXz++nIDhf2xqP8PIzCBLY=;
 b=Jr5ImMw9kPunEXRUrGF0AzCLNsjCghTmWrG17fd2Kv2CBtnHVVapLWCvUVpcxT0WDA
 Cihf7soPXaAicUFAlEO4IiGUvX1saIX3GYNcTwsvl81407GxOnaBOxH/kCottS1d8Hmi
 e6/hbNTqsgeuf5BDEnUzpkdrwOayKcOaphKuZUw9uWVRE+NMAsyuw2TulRy9Czozo4BA
 b5O/QxVmQjLPS3/FYd4iqryqq43Ih7z+1DON8cxE/5q/XT1Zxm0OrkioO1x2HCNxrZnJ
 dZ9/V4zFS9xAuS3cSTefawurAxwT1bGbz2pdi7sV7J/Fw+Km4ZhhJa9MMQYNIxLAlOYE
 +hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725303524; x=1725908324;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fy8AbH05dPNdEMcmHsRkfyXz++nIDhf2xqP8PIzCBLY=;
 b=sgv/I5rPDKZ1SfGeGqaT/t2/50kKLOvC+xeBd+K4MC1YBZP6otX9N9zYCK/JWbaVDs
 hAkUNhaPd65GPKY3++o0pRsdVgC/a9BwIzgtmFdX00nXQyQG4U8oYBBdCuP8X6WKmCF6
 5C9cWDtQlZ5gHLHLH+gx1ZtGDvZrRm4hnL4zP6lp056yBT+kIW8iNcL9qPtMyRz3noQo
 MCVIZxCSXPSnsn7O2oQZrOSSSRHUqvqo8BRM5rVxtQTmAUoXI15rMnDdy1EdYEo7k/9Q
 7XK+uuAVBNeU0jX9p91oVurevF9rR67ZXeIK5wRLQlOfwbC37wA5Lt/7UiuD0sb3sQzl
 sDMg==
X-Gm-Message-State: AOJu0YympV3ryqdJnauG/B4IQiIa/oES4K2aoCgpJjQ1idyH+jAusDuw
 pAHEu8W/+JOjLedZZS8Gs4/8eCw6IDRqqx2dw3vCh4Z4bYsKISfirjzCQbUolJc=
X-Google-Smtp-Source: AGHT+IGFo/yaUHtsBpYH1wbm2cG+0DGxHY3A2xVeRAHW+1OU4RkFVCvxqMiKlGxChydmJGaVvy7i1w==
X-Received: by 2002:a05:6402:440c:b0:5be:fdc0:e704 with SMTP id
 4fb4d7f45d1cf-5c24235c696mr7054986a12.10.1725303523324; 
 Mon, 02 Sep 2024 11:58:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226c6a2fdsm5507963a12.13.2024.09.02.11.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 11:58:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 199075F835;
 Mon,  2 Sep 2024 19:58:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] contrib/plugins/Makefile: Add a 'distclean' target
In-Reply-To: <20240902154749.73876-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 2 Sep 2024 17:47:49 +0200")
References: <20240902154749.73876-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 19:58:42 +0100
Message-ID: <87o755evbx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> Running "make distclean" in the build tree currently fails since this
> tries to run the "distclean" target in the contrib/plugins/ folder, too,
> but the Makefile there is missing this target. Thus add 'distclean' there
> to fix this issue.
>
> And to avoid regressions with "make distclean", add this command to one
> of the build jobs, too.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

