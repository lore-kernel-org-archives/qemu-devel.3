Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245AECD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUndW-0002w7-Cz; Wed, 03 Jun 2026 11:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUndR-0002vX-5M
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUndP-0000zm-J1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:36:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so3849652f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780500957; x=1781105757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tzt2o8hTj3I5swgJ+HvIHwxAkjQbj84xHIyIKz4B8Ho=;
 b=UURgMY0xjF2xE0bh4RNYsb8GXWSeqw/lbnVt2Omf7A61T/lWBgHmi1CpSoHR9XL8JJ
 3///XKPmKj/aSPR3meYueeABoKFDvcEnUeX7nN4/47V+7qdHqEgpQ1jPXSpMLQOSlXtJ
 SBCyGUpzPfMlBw6c68LoEDyknZJ2SEuvM4+dGiOdFSuKGHjs2cVy/WPfX5I8LNVzVeBx
 VW3V9028u4zCBh/KH8tm7+AfpaKFNZmhCXM0XnMVo0t1mYS7Ks0xkYkOFCKRGdNJbkR2
 ueAcIQ/3DBqeOcqnk9+uxtyFo60FqFGRUpI1S9R4GEgxKNsPYavB0WG4YraaAK1smMf9
 i+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780500957; x=1781105757;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tzt2o8hTj3I5swgJ+HvIHwxAkjQbj84xHIyIKz4B8Ho=;
 b=SaPDCkz6ptmvu0z9xhHJweWL5DLzvyagGgNMIu15yF4Abq6nZEtrPkHdf6lyB8KBpa
 YvXdclZAAfroObQq/Z5eti3KFl5OSVxrVWgnqra6aBoYdM/5JH4DCluGfO37W7qVblAK
 5A5Th9+KZQ4Eun0TKzfi2egmCb94K9rDgRMIfhgELn0bAPeMr5Mypo0xsdXRXWkHu9HP
 +KObDgQJf5hU8Prsy4y0u2AB0eBAK+b46ZT0X2GNObhPN9me/0ix9RrGhzZXEdpsr6M2
 85knST3rPees6N9zPVXCzW/0rBK48bDbLwm2wj1GKyLg3t4qLzijVyEmWLAqyT6X2C16
 dZ2Q==
X-Gm-Message-State: AOJu0YwRSF4LzWR1Z43pJA7sc2rdZR50hA2mQz+styCAoGqSRDchrgb+
 Uof0/CZB82AgbxYvykpKS+W9FjuSZ8IeVIgm7WMyA00liMmne4YzY/iGIe/vwD5kcULVNA6d76Q
 oKzAm
X-Gm-Gg: Acq92OGgsx0wxhKME2pVWhhyQ17lB8BqNgvLw+ntvuQ12iiHG+RKbaWYX77qdjNRGsx
 CzXdmB46m52cnCWCgNQaInIP9qMVflnl55yCttInAqlqCJY0SsuVKT2mr0UVoFSdCf2eC6GgUoi
 Dmsq+ZbGSr/U6YdC6zCyJbftKccP7iqoDk6ReWZedcKJHuCI0GkJvTB7nRHSNVcADpU0hZ77MkX
 KJqpsVVi+W7T5Jnen1umprCy18nSN3dltrn6TA3yPWkNJgk6E8QM4tc+mwdRWiJ67M0bgBkee7o
 4fu2Aj9w7gUELUKlsKv1fq4Rkb8mfl2VeVbqZMW0EHy+7vKOPRzJiD6OHV7u/yQxHVkTDbPCYWY
 GRfJl/oCPfcnNni8H5s7MlyQ6zBPkgzQvIa0VKZ4mPfNgNkQcAGq6J1QCGW8upk1i2zQDskmldV
 6PKR/VsPHSnhti4hsQOEiOq/0pcXoi9yOZKg==
X-Received: by 2002:a05:6000:299c:20b0:45e:f228:830d with SMTP id
 ffacd0b85a97d-46021936622mr4198936f8f.23.1780500956761; 
 Wed, 03 Jun 2026 08:35:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm7703608f8f.2.2026.06.03.08.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:35:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DEE45F8A6;
 Wed, 03 Jun 2026 16:35:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with
 direct array index
In-Reply-To: <17132c4d-c523-4459-b1aa-236c9046e2b6@linaro.org> (Richard
 Henderson's message of "Wed, 3 Jun 2026 07:22:58 -0700")
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
 <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
 <fff37ec8-1242-4c45-b2bb-d17c672757db@linaro.org>
 <877boguk7a.fsf@draig.linaro.org>
 <17132c4d-c523-4459-b1aa-236c9046e2b6@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 03 Jun 2026 16:35:55 +0100
Message-ID: <87h5njtz50.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/3/26 01:00, Alex Benn=C3=A9e wrote:
>>> This will not work, because each ARMCPU has separate cpreg info
>>> structures, and these structures only have the lifetime of the ARMCPU
>>> struct.  We create and destroy these at runtime, so at some point you
>>> may end up with pointers to freed memory.
>> Shouldn't it be the same set for each CPU though?
>
> I have thought for some time that the cpregs should be stored on the
> class, not the instance, so that these structures are shared, but it's
> non-trivial.

IIRC there are also some places where the list isn't complete until
realize time (I think for things like the GIC system registers).

>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

