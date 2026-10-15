Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DBACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHNoL-00073s-M4; Thu, 15 Oct 2026 11:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHNoC-00073R-NH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:55:58 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHNoB-0006Wh-0C
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 11:55:56 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso288779a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 08:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792079752; cv=none;
 d=google.com; s=arc-20260327;
 b=KRzLIH3CVO6G71mV+4oq0LXux3yvZOn/yQYKRrCEZ9NeL/Pry8n1UUu5hTvdsGHeZ4
 +6VhTz6L/HgPm19lC0MLnKdMPI1MnBJzOG9lcZJHFnSRGOXIrdF6BmAHJwUCCDuMQj+A
 StRkQzWmLYm7h97A7ggGza3GQZHU7KMdQZjAlKyqT5US6H72qv6aW9IOh25MaEXleFlG
 SyjhWqfh+2UA/K2COy7TLR9iGUSrlSB9M/cfKWGHJ0EIzNGAT5ICjKH2CkX22abra4Bi
 FH8t3giK/ctuM64P7VBf/eoY8lO8/aWMjkhWJ0NI4pQdN0ia/19okt2u8FFejHxF2rvd
 2PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
 :mime-version:dkim-signature;
 bh=biKPhK+Eap31Whv/6hLBpGm6wwDalOoe/GLIqUhb19A=;
 fh=WcfKM6WiyoShp5TmLt4kF7EnAdj3ZzF+QrdHUKEVRic=;
 b=DgOSuFbBAcSQFOfIbCFjJyeiUp65+s/zHk8F/fDwdw9OYXklJETin76BmVWayhikoj
 oJPgfYxJGd0+6zTeqCqlSZsg/g6dLKogdrxBknrr3rR5PpC+rwKDE0SgOQGIYbmQ/Y7H
 QSkv8ufmBVHue0txJsB9mbwrxr93Za5SFt8ABH5OSF4V08806bl3kB5aDuEyRBmSIFnl
 O/dfMPnW+fvxEzSL++vPT8ZQiWIvkTc7nNwKlOS0tKtUv35MXyJ5CH60yPDQ4hTvhYK6
 i8nz0DmokzwZVLz9XneTlvleqeMe5FJZ8zqAxZ/RN4i3wkLE5v1HPl7OD+45U/98rMSX
 JF2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792079752; x=1792684552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=biKPhK+Eap31Whv/6hLBpGm6wwDalOoe/GLIqUhb19A=;
 b=RuEixH+YIIZRynvEPBA1mRHgkQFNihXhkdQHXVYXOvwFvInXB1m2GZBnwJ8dcUp031
 SupAeMxmrDybRlH6R89ONReQq7rVAy55LyfytV2XEvdzNg9IPoXPq7KESSYkI2mwRG8G
 dp/jPMARxPIfn6x9QsL8pJ3de6iB52og9YzdOyQHhZyuX/AgbowAISKkN15mlrHLuYQW
 zn2wP7lmutrxFnPRxbQ/jG33L9aSHdK2DBlqISsmquN2AtEDU9uP5bGeU9dZ2aMa8ejm
 Qqx6axOZqthEviswDFPgJ/5lZYWf6kWpAZz3dePLNXU/cxKp2N8DEF2hf/6PlJpz1QPO
 gPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792079752; x=1792684552;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=biKPhK+Eap31Whv/6hLBpGm6wwDalOoe/GLIqUhb19A=;
 b=KabQbTYu7CIsQH+PdI6vrDBfTFwzvS7TRoMEyvuWF3q0LEAwgOqpaPGQAfOnXEHO1V
 iAYBESUkaNkbVvFJkSr6/VqunCok3NBTZB+cKmsNrKtISy1JGPFbYqSiScqFP1eF/8Ar
 /m/1Ygd9b0qoIEXTldR2jIi07Ix8MSqy2Ekb1MmgGEpmAM8ZqeNlcFa8MX0x0/db4f+7
 9+tsq3REEfk5mo8SB33SZ5Q3sIfcq3vyuS4jvckzcEzewdz/1jiC75xVYBCQAja7i12e
 mZVAVnjbaDI02IoV5CfpHJVd0x78u2t6hGm2yuHT/dKJognSp2yqf+o7h4SbNosNIP5j
 bx8Q==
X-Gm-Message-State: AFq9FYLfpPh8srHY7iUTmt1scKWO0KvDR7TXhhywDm+TxM4s48vC0uC3
 QhyaMpiMNKUo04NWWxuvX9kUHTG2IW9dreg50j+Q3iOh42psh9t78Y0Wd/tQsNZW+tIrHk0iRtj
 BrfIsWXJKx5HejuDLmGxQyrKV825Jzjhm5iYrr30=
X-Gm-Gg: AYBFou1l4E36Yob6r/Mno2FHfkvRYL6tkp6zmAwB/pS+BM8iY6BnhD50iPCGKcbrRvI
 eUmXP8Wevs6N4Zsouno5T65ITIRxGGJG/rZn8iKzWfCof0LZOGT1GoF5+fxJMeKLdHCgAS74dzT
 cdaw1J63aYlXh6XpAIyfT0IbTEHYT4noB0n73o5S+BHEBPumotXh9+sfI9SbMzFBwEKGfsh9s/I
 xsjrbXVOELsRhy9x8t5sX/SsqFD4FNdffXP8YXvfa5St7nxsPeDZhTWmAFVCYOsVXevzTeP7VJ7
 p55rF+ifmhH8xt2R5t/iCcWzEhY3oipB44fLksxml8zjvs+Awr3v4gg=
X-Received: by 2002:a05:6402:528b:b0:6b1:e8e1:a3b4 with SMTP id
 4fb4d7f45d1cf-6b3875e10bfmr542297a12.4.1792079752148; Thu, 15 Oct 2026
 08:55:52 -0700 (PDT)
MIME-Version: 1.0
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2026 23:55:39 +0800
X-Gm-Features: AclHuK9lA7uTCUUywkb1p164lnEOHolsWcmmD3Uo0RGaFs-MokWKa_ou3UZoUXc
Message-ID: <CAE2XoE9M-1WwFzEB2MmuBt5LQJQpmv0mWBxwBhND9SoFPqDeHg@mail.gmail.com>
Subject: Some though about the -machine type=<$type>
To: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As now -machine type=3D<target_name>-<machine_name> works.
maybe better way is -machine type=3D<machine_name>,target=3D<target_name>
as we can select target at the time when machine selected, and at there
The target option for -machine is also parsed, we can take the advantage of=
 it.
And other than MachineClass::targets, we can add an extra
MachineClass::default_target, so that when target is not specified, we
can choose the default target for <machine_name> for the specific
machine.
And for "virt" machines, it's an exception, as it has multiple entrypoint,
For these I think it is better to prefix "virt" with a <base-arch> for
its machine name, then choose the target=3D<target_name>(mainly for
x86/risc v/arm/ppc/mips(which have two target(32bit and 64bit)).

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

