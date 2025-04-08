Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFFC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Fev-0002qa-C7; Tue, 08 Apr 2025 16:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2Fes-0002nX-SO; Tue, 08 Apr 2025 16:34:58 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2Fek-0007MH-PA; Tue, 08 Apr 2025 16:34:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso1006855166b.0; 
 Tue, 08 Apr 2025 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744144486; x=1744749286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r0lG6OOLkNl8UFlSJdqVTWl2Z8Sc3pFCEDfh9aJP4U=;
 b=KXKtcFiTR0cmP+BLvQ+MbFGda4LuSfH6ut6JK74sQRQltaJkZM60YwjFmZ97LFtWzY
 YcIbAXxhJ6VTNICrsfjvDRC7kN4jhy708jNkDJ9JPdEnwmQyWNtJQ7oQrKDHx39qMYbH
 RgNV33Qn3Plpo9TYC0WHepW6S/27dngh/ofR5CRhSHCyXg/e0ekaOqavKs5QcOi8Qb5r
 LWaUaI8zz1ZFFS2RIL0kPx90Cl95ZBr6FdzX5nxmYLx4lV3TY2N5KVHfUFUGZpqLrxuq
 YXTmbIvCdm4+NC7wlHH/Aw9WhID748X6y25mXrJC4ZuSZy/wa8HBkBTy5IO1P5x/+duG
 1V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744144486; x=1744749286;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0r0lG6OOLkNl8UFlSJdqVTWl2Z8Sc3pFCEDfh9aJP4U=;
 b=Q6qoDWteXUfAfqFh7HqhoBQajhG6PXB6KMqkNl906VRSd+93RGjGp5GsZdv4/ZTfwg
 Rohkh0ZHiByILSRsJQsOaTqfqfWFmRPFlUugJMM2MrU+2rIUe6zCEl0sL8TASsXgh+/1
 RkPrQXgKDJlnJ/POPQ3cKStXmqcj0w0JeCMKI+EqW7RFQY2AYVqXnb739vzoOn+oSFDl
 Y60DVWrboU3Zx48l5Yg1PfF2Is5Z4bBB9m75mQoIgMxrfGW41C6jbMNc+IRMv9nzs1IR
 UzeEiTMTWxPG5D+1uUhCZRRebLCxrtk2PtLMz4AeZGnjI2Ihhcjo+iSent6pNBrHZJDR
 HOMQ==
X-Gm-Message-State: AOJu0YwFnwvh4OzRtvNShaV6OV3K4HeaZSByOItvdlADcVgTFlXzBiOU
 kY4SEQbgpV0RY5dgT/ja3kXPa2T5xTEuSrVqA92/+ZF3qKRzWoiIyOoTQw==
X-Gm-Gg: ASbGncuuAJAh455xUBosd9Hbopd3fr2PCLVxqgreJoqatEgj2nBt2dhWhe4rc67JSkA
 0IgvcRBBYZH/dhiHIDnvRhH80YRIEj4ITZttYl4/ahS7+POlGsApXwtSdbxDNPz32vV7xrcbBPn
 rZJN9BszTr6kEZT/WVjRF2hDHIwbt/KWvFo967fswdloJuX/FSOmQtmA4ZfmopMsAWcWtakM8NX
 mgA5anBArlkcm4LZR2ipiNdIV7odYJ2jGD1reJ8ge3KfAnJumMn8hqrQPWTvDoPOS0uzcaR30AJ
 WlyAKJwUDD3M3BBTFI4rPqUaKlaNuAa6cQDXscOjJfmBC+5Y3Q0h5hn6n52zl7TrwWYihbEvhtC
 uaTvPKhUgEofGC3DmVJQc6Au/u6u1RrkdVIDWnqIeYhwk129O4oLx
X-Google-Smtp-Source: AGHT+IGFZIZR5ZwboCAXE/LKYj9mFHJlrrG06UPPM/bb8ASR1eS/dceKUt7eQN+5pc603lDXXXcBXg==
X-Received: by 2002:a17:907:3f26:b0:ac7:c66a:4702 with SMTP id
 a640c23a62f3a-aca9b77305fmr49493966b.57.1744144485997; 
 Tue, 08 Apr 2025 13:34:45 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aca936cec1dsm82259666b.54.2025.04.08.13.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 13:34:45 -0700 (PDT)
Date: Tue, 08 Apr 2025 20:34:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
Message-ID: <0B9AB608-D9FE-4819-87DB-8B00F222F1C7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 5=2E April 2025 10:06:00 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>Meson 1=2E7=2E0 and 1=2E8=2E0 include improved support for Rust, namely:
>* support for "objects" in Rust executables
>* support for doctest targets

Using Meson 1=2E7=2E2 (shipped with my distro) I didn't succeed with eithe=
r of these=2E If just applying the first patch with --enable-modules I get =
linker errors again=2E With all patches applied, "doctest" isn't recognized=
=2E Is this perhaps 1=2E8-only material?

Best regards,
Bernhard

>
>Use it to remove BQL-related hacks, fix --enable-modules --enable-rust
>and also simplify the Meson logic for building the qemu-api crate
>(which may help splitting the crate, too)=2E
>
>Meson also supports clippy and rustdoc but there are some bugs in the
>prerelease=2E  I'll try to get them fixed before 1=2E8=2E0=2E
>
>Paolo
>
>Paolo Bonzini (3):
>  rust: use "objects" for Rust executables as well
>  rust: add qemu-api doctests to "meson test"
>  rust: cell: remove support for running doctests with "cargo test --doc"
>
> docs/devel/rust=2Erst        |  2 --
> =2Egitlab-ci=2Ed/buildtest=2Eyml |  5 -----
> rust/qemu-api/meson=2Ebuild  | 35 +++++++++++++++--------------------
> rust/qemu-api/src/cell=2Ers  | 22 +++++++++-------------
> 4 files changed, 24 insertions(+), 40 deletions(-)
>

