Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8120C55AB9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 12:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtPLH-0000PI-5w; Fri, 20 Feb 2026 07:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtPLG-0000Ow-DU
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:10:42 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtPLE-0006V5-Nn
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:10:42 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65c20dc9577so3621505a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771589439; x=1772194239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6fzJ+l4Ly9yeRBWhlbynBxkf7jzhP5u2dREaJRBSuk=;
 b=YHXXl4Ahr6zpethaRAT2+Y+kLGq4npbzPN8ae54gNrqCSITSg7qXo3ob1qLacYmGQH
 B2TcPaOxqDwwkv2M/R91yTMEhQvVbeSNgUhqXc6mNhXYYFdOtEA9f6xkTceXqGrflQwN
 p2kyh9n73xCnEhBWntQOeHZ6roTQYmgS5jwRZKsDnBlcbfD85jjzC1xGRW5zu7z4hlHl
 PDylsoBEYDFokHC7V/2QRq4tkcZc1usbclxTMXkHsbfl90+rg67YZ4gDl+41r6hLYbgS
 mYznNllhR6IeRXerMDY7ysUi1lKBiEzXvRX3uN9WXP1Xj674lde2mT7qDuT3j4Q8U8gg
 XJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771589439; x=1772194239;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V6fzJ+l4Ly9yeRBWhlbynBxkf7jzhP5u2dREaJRBSuk=;
 b=NII458n90u+udAksRvl/P7a8U6WT3J2pBLkVxqBQ7oY7nJvYM1p52PPNfntBs5rvrz
 uzfakLjUrghDw2PZozfrjoi9vvYbpe8J3uL/QlOBLg/oV5xj+jC+REKVqO16goywGieF
 h075JVSma0RyIGd7h51OzkkoiYHeHak5Q2t9ZCNmf3LzKyys4SiBS3iNtlDSS1YDSy5P
 kOkHfUfLGDu63I5xFvEfsfZmteI2iMmwEVyJrcIB8PRZq8kecBgOzHbLVi1BpIoqJtIh
 NmgIi7iAa1hbQXCEMLJSckNu6esMy9bw80FKIhl+Kt0BDIoQFN7UeCBo1AEpGGZWnidz
 Va9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxC6MADtkVs9aMNT7J/ecwtijtOUxq9J0mwr9s3TyLcgcOBIOfFNeWKQfho5ETIozRFnqWFawYyK0+@nongnu.org
X-Gm-Message-State: AOJu0YwEn3Ny5M4HPXyaMpM6xVY9LuuT7fn55FMOG0TEWR4Z+xAKMkhO
 oCwdUXedtpZQ0wUiqIZkohEuWmOwETxw3TpdhF1gCaET4a9/am6cEj2u2PjvhguAs40=
X-Gm-Gg: AZuq6aKuOxCq6odLf8X07+qhAd7w3o3XpMdSuM1PAA3d8gmqmW+glmvZPBPDCnOBLyr
 h/ZwaWA8SpUO8Y6voBjpCDRRkKdIVUdPkdtUgvpVDMFPK2JUHp6rsfArX8SUCiPlyod3NccblBE
 nqYhSkSj3A7Ej1Yi0UPfsyNNul97gy7I4ipcSkgc/i1SDZmvxxy3KmhElnQcOhMVV/iAun3mtye
 QSQJPamfBWIWLz3VMgr8lnf0PKdytmhlwDjSiItEiXayl3fZUlJvP59ghT/MyMUTODpqeA717u3
 lonAynwQIFNw1/GWUDE5O93EI5VYTEKgBfi6cZZXdDmzcQo4V5IWL1BtGy7Wvgg0+c9O6Vu4QL7
 JILGQ/f+3WqrOFiwW/FSGD/2W9w4CSKZz6iOE0seMoDlu07j7Q3zlncgZcOWWMi7FQUfcqY2vwX
 HXgCgtNJMIG1dwzPLnlvFAaxvIuTSR604Y0A==
X-Received: by 2002:a17:906:c116:b0:b8f:9d12:2386 with SMTP id
 a640c23a62f3a-b907321eaefmr101233466b.51.1771589438938; 
 Fri, 20 Feb 2026 04:10:38 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7665345sm670206466b.53.2026.02.20.04.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 04:10:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8CABB5F838;
 Fri, 20 Feb 2026 12:10:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: Update error message for bad gic-version
 option
In-Reply-To: <20260219110228.3804482-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 19 Feb 2026 11:02:28 +0000")
References: <20260219110228.3804482-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 20 Feb 2026 12:10:37 +0000
Message-ID: <87seav62f6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> As we added different valid gic-version option settings,
> we forgot to update the hint in the error message produced
> when the user specifies an invalid value:
>
> $ qemu-system-aarch64 -M virt,help | grep gic-version
>   gic-version=3D<string>   - Set GIC version. Valid values are 2, 3, 4, h=
ost and max
> $ qemu-system-aarch64 -M virt,gic-version=3Dbang
> qemu-system-aarch64: Invalid gic-version value
> Valid values are 3, 2, host, max.
>
> Update the error string to match the one we use in the help text
> for the option.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

