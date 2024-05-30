Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClF1-0003sB-IA; Thu, 30 May 2024 15:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClF0-0003rp-6q
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:15:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClEk-0000W6-W0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:15:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dbdd76417so975777f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717096491; x=1717701291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1t+36s1D3oZDXrs7sQEeafyfOBXNMW2UvINLXc35rx0=;
 b=p4pPIvD6h6r40boDrcELwT+mYhxV5aStCfAFZRi0FdzzFdm+a9H9KAMVjB0nt1RavM
 HZcxJbaX8HgcAqgcqNwbBmDng8GaLn3IiWO2vNJJxXYI4EzyywptASzbROx/0OroRwS0
 9SY1fg4g6HcZMj7M349X4QburExZx2z8L5q/BdK12uGy4onU5vB3/XArWODhvBGKmz/R
 PXZyr79kv1v2F1DNsp8T9tnLT5p+UoInGeyop6kq8Z4nCBOEWcewrQmIriybNmXxL8Cu
 6UvWbe6CnwCGoXagyM2iiWA1kimehCDvI3wnZZNh2MJveb3MqIN0r9FV27NgNER5PxJg
 x6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717096491; x=1717701291;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1t+36s1D3oZDXrs7sQEeafyfOBXNMW2UvINLXc35rx0=;
 b=gLsix6DuiCxTkZlhAMoJoYYiQuI5siR7NmvRrtLFIPEcNpe5GKYxt8+c3bQLqclZTb
 lwF/db1YaHsGL9i18iU1kx4Fc9pB/ebtmBAOq6w4bzaDo9luYSUhvE/dKnoU56VBGeyN
 Y9HJTWyzi2h7Q8W/WvdJEj+SLrgSRsLof5e3gs6yMd2zRD0Pe/yeq3YzhGJg6C+jPy6p
 Z6awTrke9sgK9sNEjZaDHUAV06majLmwtiimHT0eUWozx7+gvVyZYMCqFOn7w/gCLakY
 aBEmrd9gkfJQnG1qNASwt7sBAyxRqi65q8ufP6IOFi0mf7zL80m6g5gHbbVYMGP2WfOq
 wDAQ==
X-Gm-Message-State: AOJu0YxeVfMz6UVolwlqZ0RBNaRRUUub8jGUubKz13aGBIYG0UVI/HpA
 zwTcCuvU5wc4mJbPvrFa2hkCb/3e3Nn96bTbRkmzfXNBSeHVvmCx3Ysg6VZIpOY=
X-Google-Smtp-Source: AGHT+IHgf+55CP1iznN7+TKAgTkLJOXCy+Hv4FgPHjQzcLp1RV+PuzLcYkhSdopcsc6Qrluq9FGuwQ==
X-Received: by 2002:a5d:4a82:0:b0:355:3cf:49ad with SMTP id
 ffacd0b85a97d-35dc00c6a3emr2510375f8f.65.1717096490870; 
 Thu, 30 May 2024 12:14:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e73f9b84sm6355566b.64.2024.05.30.12.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:14:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 180455F8CB;
 Thu, 30 May 2024 20:14:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hubbard <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@linaro.org>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
In-Reply-To: <20240520232634.317988-1-dmamfmgm@gmail.com> (David Hubbard's
 message of "Mon, 20 May 2024 18:26:34 -0500")
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
Date: Thu, 30 May 2024 20:14:50 +0100
Message-ID: <87ikyvcdsl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

David Hubbard <dmamfmgm@gmail.com> writes:

> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor with
> "Current Buffer Pointer" set to "Buffer End" + 1.
>
> The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than td=
.be
> to signal the buffer has zero length. Currently qemu only accepts zero-le=
ngth
> Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardw=
are
> accepts both cases.

Which version of the OHCI spec is this? I can't find it in the one copy
Google throws up:

  http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-9231=
43f3456c/ohci_11.pdf

> The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
> and earlier matched the spec. (I haven't taken the time to bisect exactly
> where the logic was changed.)
>
> With a tiny OS[1] that boots and executes a test, the issue can be seen:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends td.cbp =3D td.be + 1
> * qemu 4.2
> * qemu HEAD (4e66a0854)
> * Actual OHCI controller (hardware)
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

