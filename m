Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3944CD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8G6Y-0001MR-UM; Thu, 02 Apr 2026 07:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w8G6X-0001Ly-Jz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:20:53 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w8G6V-00053d-VI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:20:53 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501547d7edso774877d50.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 04:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775128851; cv=none;
 d=google.com; s=arc-20240605;
 b=W2ZJ+g9AWOf4nUr+10/1g+OAivii7dSwVAtQFxBWPdxOniP8oAf7NcXRJPIFiAp/BH
 xmjrrGGbYqM6SRjtitHBK9ZksFY7HIV2OKvlQIwz+JSJPMtAyk2eTBevuJZ7EPyfnFIZ
 RWay7cgWgM+2yt6KLWFF5FpB2rPR/QU3vbFxh5bfd/yMYHakR3Rz8zmdWkqmL2TefOX7
 DwukPVqUsNx7+i4GSfoShs1itRcCxdOmIMWYF2TxSPaHTutBg+Q5aT9p7G3VxPB2p19n
 cAo5opxZdY9md5kHkjc4jUKXrWweB6YrBMysX6iUuJIZ+Ito4lUz3PX0iG4nc/ZpHRCA
 JGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ldJAJvt+MiTmgMyaB+cQ50gnnqqVL7sQvxIT3yfD9c=;
 fh=6/U+EqlDll2XSWEYWIVaPw/RDQtZDsMtP2t3uCfoIHQ=;
 b=Rwqt2VTw482l6DrzYWzrDCtzkekaUFCXCVCOschmqCeMRh/DXsKUJ+t5f0uyqHXPz/
 gbWFOL//gpqd5ZXqe6f7by6TRKrXG5eHjiyZoZHK5oMWAt1VivQ//ijjak63p8nxKF1T
 zYosREo9TUksA+KYpQTgBwqc8DKRDLSIQrm1ABq1s4rudfOZdTT0meVjlyx3KRScVP8f
 AZ6eFIQL5qLC9wrQKrPZsnF4lOpZIpm73Nhx/3ih+i8axMkn1XnacJFujmcvktrm6MhP
 fqHUgTlsyIQlGJNWMqQdKM/Gc9MXOsWGfNRRhsByJEWoSjJbYc1DdPlEvwEucaCIgc17
 XcVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775128851; x=1775733651; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ldJAJvt+MiTmgMyaB+cQ50gnnqqVL7sQvxIT3yfD9c=;
 b=X1WMy5cdQO5Q0XW5XzdNGrX/w6GaBgW7VFqYp0lyd9WejLPitKTH3EE3fBkrBajwmy
 jBRnEzqWxX8C3zC2s6JbgoPXva0//ngqhPXLScp8iC6qdVmwqF3q/wVBxo88Iogbs/L2
 u+lDeqpA1VaA42xTunqM43VTiMUZ0xivq1IsN/ScKIK1oacdYJrZ+kcdJiJZj9oXpeDS
 0VPIkupy2w64VwHSHn9Q/6eAUNur/ECjcleLrhad5M5plu5Umjw9YMcWqC3e7+jPr1l0
 gOrjHJWkUtxZoKPXdGfZH16fofSm/SjvBJMH7LIZdegWpnbvfHTMtRWrEvy7eH21rikh
 rIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775128851; x=1775733651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ldJAJvt+MiTmgMyaB+cQ50gnnqqVL7sQvxIT3yfD9c=;
 b=ZQzwxzIr+9/0JW2uqTYVbxqnmzshn/EPEMFlnkiIOMRObMx/J8/GetXmF4uIwH0UFG
 oVCGjg79D7iJkTAz8ZJBtYIpy6m6+8Iy0qSKf6jiL850mZEv3tOEo8tfx/ljX0VCYJYA
 d1Rmlf+YXyz7O5lIMYxUqZtBo9REC2WA9kwTgkZuxVJASi4oW/HNhl6NzVAc3N3IrvaC
 gu7GSpaJTvEnVAAYsPIRPPXe3vskb+VDU7+9lX04YqwuusWDx0eFcZw/WEzbmrBDe3Ay
 jTE9oSmj4OHIA5Qsfb8jKx2jZVCRv3KPhIjEy/vdfiiFA5DmizuUt6eNXyaczrv02xXO
 pFqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmATvxyarffokYywgZwrW4ow44LBuuJWgiOsGWd8J2DluSom5SuekSQAkZtTNDVWfrZ4md/3ctYHZ@nongnu.org
X-Gm-Message-State: AOJu0Yz2qvKfExBPyOffElvbzaKfPszP93bunj1RpT1Ybs9zVHghfQFs
 nOtODX1Rsz1MH9+dTViKvRYtdXINZqpXtiO1xmvssiSJvcNB/GxKlfEXHlm/fQyWNCxLLqQqAM9
 1EngSRkv/eGqM9ac01lJmgi7THMNtGXKun4VHcfT+6w==
X-Gm-Gg: AeBDiethRzi3MfKjrukSfzt2FvktyYBTJ0xlUx7b4KBbr2+nL6QD25yCvgRdFUOb+H2
 bORnHjk9qvgx6zQS55cynZsRLuBZYoDHRAOAlBwM8z3RmVt8iXafASTsocduCtLPHbcgvQmBVaQ
 5bmsxHI/Zb9SQJ+C3vi/6xl6wU7CR3nfGDSW0W8aBYYak8bnCIj9OTw5nnxQtSh9B6MQ9duBHGn
 TlvK6deYmul3xQulVOmj/to1S+/pE3OC+OoaZT/XqxFWr8st2big+BxJkQ8zhLAlpyUX+mr4guv
 ErLLZi+LVbyGdbzEaozhJBDsnf9vn7AQIYRxFtYdB0qTLxc1fI4Kv6PBo3MCou3HfG8=
X-Received: by 2002:a05:690e:1517:b0:64c:b242:496e with SMTP id
 956f58d0204a3-6502fdc126bmr7680546d50.17.1775128850685; Thu, 02 Apr 2026
 04:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260402095132.29245-1-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Apr 2026 12:20:39 +0100
X-Gm-Features: AQROBzCmKQG4sbsPnsh75Ye9ngQi1Ij5cu9QFWiOoHjMC14NYgOM62kpoKO9CPs
Message-ID: <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>
> This is a follow-up to my 3-years old patch series here, now with the
> universal binary initiative in mind:
>
>  https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>
> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
> (by renaming or symlinking the binary to "qemu-system-i386" or something
> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
> support, which however is not required anymore now that we removed support
> for 32-bit hosts). It is now possible to migrate a guest that has been
> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
> binary that has been renamed with a "-i386" suffix.

I think my reaction here is similar to what it has been when
the similar idea has been raised for qemu-system-arm : we should
have a coordinated plan that is considering all architectures,
not just dropping a single binary for one architecture where
it happens to be more straightforward.

-- PMM

