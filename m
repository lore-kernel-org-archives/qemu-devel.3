Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1378EC021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrL6-0002fc-GR; Tue, 25 Feb 2025 04:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmrKz-0002ef-QD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:34:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmrKx-0004mH-4V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:34:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so46836515e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740476084; x=1741080884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/aOnmiLBL/MdJMrbpdNPso/NCDWVX7/KXn8mmcJks4=;
 b=y/UfIn9DD+csW0oJnrAGlrF690tcMopmcTsCRnpJUbCZcDHZphRg/ZYZHmfwqb6fnJ
 D4lBvCeH/0PGYLoBm4FtNHsH1kU7+WaBX5vofA7PAVvPBjrunIiGjJRbT/2ahxgD6kDA
 +odoJM4W98vU0N6UhLL2Fc8bvMhWqfaJDxiWOrpVeVYnmQSVL8pimjOsxjQWIvgBUBtK
 OAKLlgyYjbrtG2XJMWb4nT93nJ4kQ47cYFik+jFd3xg3ABtR15i8bp/Csn/n1002mfAR
 VtzXxmkx+IWbLYFskZl3YX2HGdt0Cglfm7sRyhdEfDAI496WECEp43uanpaaprMnZTgR
 nTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740476084; x=1741080884;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/aOnmiLBL/MdJMrbpdNPso/NCDWVX7/KXn8mmcJks4=;
 b=luWWGxxmDKLgpbh//aTBEsFSqTnyAjeY5fYlByZTr+Wx6t3RaIwqYQeSLVraDYoMDx
 XTtr5gdIKu9t41pAvySoEjkaiW0xzkNSEdJNpEL4zvry4OhhMl8yu5/C6x1bsGSqCbcc
 iDLGzP33D+87tJf/XV6ice+qiHkSmvDscCyAYv+UlE18IlFRI+dpmrjSGPcv5la35YGv
 9W5/SD713Zrcq+cZMy/m7C0inmHWONRPIrFsLRbJHX0F/kZsLNSMx4Z2QGUzEwit8Y7g
 2QpJsMnq9yJRktsQrPdj5oqMOZRTFD1XKKM0h3hYIgwZ8IpOglJa9yOmEPIuf29ApRIY
 cujA==
X-Gm-Message-State: AOJu0Yx0birREzlvJhdeSd9J5X/FV22hSuUmAXxDDsSs7Ba+IfdNxq0X
 V2V0iJ/X9Q6Fj4C3HFlQqoovXu3Sldbe5wSs96Iwa8OHquvGfCb2U1Br9mNIkKE=
X-Gm-Gg: ASbGncsRTDc252F5id3dpMp9bK8S9Ryi1FVNLvdwpuYznpU0pLW7Ova6p3D6wVEAVlh
 o+bzT5KYijKGoCMytGTg+t2G6S1TO82rBTTmQYg9SGpjiEOOLziY4J7O9asdFbjOKbSmsZLZ8h7
 C0gu/68uSLzHjUrxmLxjyomjap80yGITXoJSQs6awifkzHvWGUI9W0WqZXD9JYKXaM/vvKvTGv8
 BUOUWwIR8OLSk/WF1RJdf92HLABi5j0t/4qwylqV1EGx96I8w8K44EJyD+H+ojff99L27/6rwi7
 aLVTtb/fjRTS83QCKAQ8u+covnw9
X-Google-Smtp-Source: AGHT+IFxN2JG5TtZyYz6fnPCVm0BLnnBn3DEhqCz4MqMzlayRxjkXcL27JWB8lQWwgo047ttJHKO/Q==
X-Received: by 2002:a05:6000:156b:b0:38f:2a82:4427 with SMTP id
 ffacd0b85a97d-38f6e95fe69mr12839485f8f.20.1740476084467; 
 Tue, 25 Feb 2025 01:34:44 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd866f15sm1648077f8f.4.2025.02.25.01.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 01:34:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7F7E5F7DC;
 Tue, 25 Feb 2025 09:34:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jayakrishnan A <jksoftdeveloper@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Seeking help on implementing sync over ivshmem shared memory
In-Reply-To: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
 (Jayakrishnan A.'s message of "Sun, 23 Feb 2025 20:18:22 +0530")
References: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 09:34:42 +0000
Message-ID: <87ldtu74gd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jayakrishnan A <jksoftdeveloper@gmail.com> writes:

> Hi Team ,
>
> Seeking help on implementing sync over ivshmem shared memory , As part of=
 internal project we could able to achieve
> shared ivshmem with doorbell mechanism ,But in order to achieve shared me=
mory synchronisation we are trying to add
> atomic operation  over this shared memory area variables , Just wanted to=
 analyse whether this atomic variable between
> VMs shared memory will work as expected , If not is there any suggested w=
ay ahead to implement synchronisation over
> ivshmem shared memory for threads running in multiple VMs.

Atomic accesses are properly modelled for all QEMU TCG guests that
support MTTCG using the hosts underlying atomic support. The shared
memory region ivshmem_bar2/server_bar2 are just pages shared between the
two QEMU processes so atomic accesses should behave the same way.

I'm unfamiliar with if both sides see the MMIO region but there is no
intrinsic synchronisation for MMIO regions which are terminated by a
MemoryRegionOps structure although vCPUS on the same QEMU will be
serialised by the BQL.

>
> Thanks and Regards ,=20
> Jayakrishnan A

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

