Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456C5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqvx-0007rn-7C; Wed, 21 Feb 2024 13:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rcqvs-0007q9-J3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:03:03 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rcqvq-00086f-Nx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:03:00 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-59fd69bab3bso1113390eaf.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708538577; x=1709143377; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f50Ax/Ki9ypHvi/OoLjeYscpFnsuccpEfRX/UYWAmRw=;
 b=OIBsE3l9g4ncKHpR3u7j0ybQBcS/zhU70JfYRMZKH7+jwpJ/eZ9BgcOVE7nNr+svtl
 qE7z1bKw0yshNuUFLc1zVJGraNGZi8aAf7zwRsWyKgtZmhDYiak0pd+z1NZ+gItA/itI
 FOfoV2YloigK/r8Ez9hxmuxiTX7v06sDUzRl//gt7n8H9oghoxGO0CG/yQaMaax0a0FW
 eIU5GDI8xzpF3xmHiyL6BPJ78CYXkt59o89pvvDGjR/iXowtTshBnbQwkZXyG9nwpOsC
 7H/bVyFsn31iGhIP8xX8u5UFwCQfS2zTRdylTzWPfgUdHNeoSN8ZNQnPQrxFG/aEQDpw
 7dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708538577; x=1709143377;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f50Ax/Ki9ypHvi/OoLjeYscpFnsuccpEfRX/UYWAmRw=;
 b=bIzIYs4fPoh7jwKmJD+DYDq9Lb0wBwgbLQC+AYb/Ab1EpzkpEq0pZFuxepAmaYGej8
 yD/gH/69a+G+/uNki30x7a4jNSa/2cp05xXMLnGDgkAXqj7nzNCR3ilkxiEPUcP002hH
 /1V/yB7EpMBN6QDk/qr8FylEgjeDW9o0gZlZhWcy44i3Dn6zoMqySTkbM1LySMct7qks
 ESzIS85udmESQd6FnvmLXRn7Ta5lfRR1UWrOd9lbyK0TpKjgE1pe/rpcsdqBIEXj/GXm
 iHQO+cbe1rquzK3hZxtAbAJtnRIyA3j/SG5ByH5dpdRYYsTe3ze2OQE/HpSDpK342bWn
 PKCg==
X-Gm-Message-State: AOJu0YzUKgUrK6SxNj8Yc1ljEn6c72bigKwwLQ2XOWchnEGBzqu7877q
 LxE2v1i7kMlV/3kklYxrG7PiymOi7XNB5R7jbzgBicHJN2S380S3ngubIJZ0E/iMkpiPNurSujd
 pueIwMLuoVhjCbkIv358yu6GYBCBTVncBg9s=
X-Google-Smtp-Source: AGHT+IFp4Qa6H028v9husRiSLKomrplARZa2a7qZgkaKSSubq94NAwfSYMpY2fFko5JYenWiT5TiFEHuCT/iz6XiDMk=
X-Received: by 2002:a4a:d5cf:0:b0:59f:f90d:49f0 with SMTP id
 a15-20020a4ad5cf000000b0059ff90d49f0mr5547926oot.2.1708538576727; Wed, 21 Feb
 2024 10:02:56 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 Feb 2024 13:02:44 -0500
Message-ID: <CAJSP0QVs3W7MOMSdU0G8J1=AufwLGp8K3SGUGxHUDyjEWu9LpA@mail.gmail.com>
Subject: QEMU was not accepted into GSoC 2024
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Dear QEMU and KVM community,
Unfortunately QEMU was not accepted into Google Summer of Code this
year and we will not be able to run the projects we had proposed.

This will come as a disappointment to both applicants and mentors, but
please read on. For applicants we encourage you to look at the other
great organizations participating in Google Summer of Code this year,
like libvirt, Linux foundation, or AFLplusplus.

I have not had detailed feedback from Google yet, but at first glance
this seems similar to 2012 when QEMU was also not selected. Sometimes
veteran organizations like QEMU cannot participate due to the finite
amount of funding available.

Applicants can still contribute to QEMU outside GSoC although funding
will not be available this summer. Don't hesitate to reach out to the
mentors for the project idea you are interested in!
https://wiki.qemu.org/Google_Summer_of_Code_2024

QEMU will apply to Google Summer of Code again next year and we hope
to work with you in the future.

Stefan

