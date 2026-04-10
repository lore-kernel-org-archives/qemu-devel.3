Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BECF44846
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBB0d-0006vq-Pv; Fri, 10 Apr 2026 08:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBB0Z-0006uz-1p
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:30:47 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBB0X-0005Vf-AE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 08:30:46 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7982c3b7dfcso19640177b3.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 05:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775824244; cv=none;
 d=google.com; s=arc-20240605;
 b=KJ8HH6mu6TExDFJkhiEIppoPflE22Sdc2RC8xrOUcHDDCcXwev3a2L71gMbjDMa0Z7
 gqAmN7eP6FZXeje/wFu7gwpfcXQTVLyJ54xUAcRqEkAIGWNfvdIEQZa4gO7Gowt2rlnf
 QJQrE5/IZda080PlftJ3bqIFlSHEhRb8RQFMwihb2BDIMW7ut9RuGAPQwWfi56JaOOds
 PuJkOXUbVwxc2+l3WjsAwy1YC0A5PxNWPbqyUe7lLycGbQpgt9QeCYogMdGnlaYswuur
 pqbPn6WESuPhUyyNDmUTHgni5mJDZ1Z73xvPefpW491v9QbBk0iosHVcLvkgzrDoEbiV
 SnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q54P+QY5eLcs+bEYW+DP+kazlntJyFpVKynFXeKamNE=;
 fh=4RYpU1T0IT8L5zyrPSfNK+Q45gmXxoqoUAgIyxGlO9Y=;
 b=dFKI+SK2nvDneqvfKLZcYMAy/FixHaAnxrfwhfT8KwitGy3q6YCj24+ztDxV5zN+Gi
 Yzi+UBb2twOhW6iVWc3UAziwIRML6rIm5ogCDchCcXSdBbl3Voljaq71nCqJcA0y/71O
 L/knVCk1oGqWAYFFJWu071nbx4QTRZR4iiuLqucchowNtzJ7wc6Giake4yvn9/dbDSJh
 TlpfLVwSdD7v1hP1BFRO9wqPRnQkpqwls9zHU4Ariy2XXLBMxW8ZRyiwcKn32VaWlIML
 CisDLYoJflRTEUHXtucxtbxBTWu4kCe9IEOaJsZL2bHf930skWBJ3UOXFoz/DEH5Eblb
 EreQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775824244; x=1776429044; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q54P+QY5eLcs+bEYW+DP+kazlntJyFpVKynFXeKamNE=;
 b=eANSLNW9IoJAnnQHSUtHrf0FUEuTr9boiTjaNJnh551m3xSKgJTnDgE/EG/INX0OVC
 g5HcwjdrL+JAycJz+NJuTUpf39ECVMcUSjDhdsf8YB94ad9GhDLVn6uV6PxWGahAdkfW
 re5xROGsJctMjcVxlKYz+nqGY4gzpTip9RqkE10WcXQ35u/S/ah6/sPafTJA02lYilar
 NLMPiaZIGdJkh8TGZ7c+tXpKn00iQkbecT5JvpthtB2FxEdpzRZEPAgE31mSwMlZzhSX
 8D5hUq3dUeFsl3wR0WjSQrrh2pZ/8XiGpqA/RGX/5hsDn/0h4Trlse3x2U6EUNcTfFW3
 sb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775824244; x=1776429044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q54P+QY5eLcs+bEYW+DP+kazlntJyFpVKynFXeKamNE=;
 b=nZagD/tdNAz7Ntxzb6VqQdtMLkt217M5MrI2JoFo+rh/KVf5HsCARoD1/2M8tCh20R
 nfWwmFh9RKEnDcsI9Di34UYpajY9m2pUwf5dwpa+KA2z7dQf+mG7qos4/e9cThA2ef06
 Pk5pLb2Pq/j8fDha3ekyAekf8tQ5ZqNcVVU82GzBezJKO8yTsKt6pedJVYy1Et37u5Z2
 9vLhJJlZDftKY1wirEGStpIigoK1fauN9Wfj1yViKd6ycwygfoliM/M2PbMbXvPJskRm
 mqb7ru7Q6B0oZNaHsMhymcbeKyY2q8ZKbMbSKt+WA/uKAgacH5zKol9RkDvr85tKMSWG
 rECw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzSPRQbANsLm5gJUA6cZQ2Zrk3k8Pp5mHV33AJ1xGfHafQU5EFInOYNRW+TF4aMMYm6EVoZGkbDnce@nongnu.org
X-Gm-Message-State: AOJu0YzAeFdUBtXWKP+0tVMUblbZiEylQ50EHK8MpLXb1pzavnJYU9uC
 0Ceyejh7FWCF/jcOvX0b/WWIKTsDFjVhNdIXXdGbU+xX1ivXyj2htdGUBDSZ+ujKDrNHNxh03tB
 FtDeH4yG8UtLawTMXjLBtz7fLj4a4VsWvtf0YXEggvw==
X-Gm-Gg: AeBDiet5dtKLIhQe7FVx3sV+r0vYJpHc+aV1edi56WDCeVE+aYEIilmn/4pkOzSUGaJ
 s3ZOLuZjldGprw8wjywbtnLBQ9oDXiJJcyJyzr2ctUpOYDu/MsRbTHXrujX0KWbSMD0a0yrPozQ
 +uLi6q34CPcGNQOfxh9F3SjnL2HRSKCau5Ag6qOzmz0wcOGtzBOUkVzvr0ak9l99Pwko1YEMSKx
 XUiCdU5538PqthDeY2dFgqafMWBuYRltObxMcxsFyoyju/UeTZK171+cw317dkdsE3xAbugSHx+
 9Odl7pr6rJmksAD+40kfMVr7m1MsFxOlENGHD8LlvlecJeWjFYfBfa3DIpZy8JpSnEs=
X-Received: by 2002:a05:690c:1d:b0:798:1636:c330 with SMTP id
 00721157ae682-7af70f92613mr31071027b3.34.1775824243407; Fri, 10 Apr 2026
 05:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
 <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
In-Reply-To: <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 13:30:32 +0100
X-Gm-Features: AQROBzCubG18WzVTiDLxr79n2IPv6VzrMuAtq1k1JzwsujFiRd8nXOboDTBEEZE
Message-ID: <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>, 
 qemu-devel@nongnu.org, Oliver Steffen <osteffen@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 17 Mar 2026 at 08:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Mar 11, 2026 at 03:24:04PM -0700, Pierrick Bouvier wrote:
> > Hi Luigi,
> >
> > On 3/11/26 6:43 AM, Luigi Leonardi wrote:
> > > Add a machine property to pass a debug level to EDK2 firmware via the
> > > device tree. The value is set as an "edk2,debug-level" property on all
> > > pl011 UART nodes.
> > >
> > > This is to create a runtime parameter to set the verbosity of the debug
> > > log on the serial ports in edk2. Currently, the only way to set the
> > > verbosity is a compile-time option.
> > >
> > > DT is used because the fw_cfg interface is not yet initialized in early
> > > boot phases.
> > >
> > > Corresponding edk2 PR: https://github.com/tianocore/edk2/pull/12277
> > >
> > > Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > ---
> > >   docs/system/arm/virt.rst |  6 ++++++
> > >   hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
> > >   include/hw/arm/virt.h    |  2 ++
> > >   3 files changed, 46 insertions(+)
> > >
> >
> > I am not sure if maintainer want to have bootloader specific options in
> > machine code.
>
> Does that mean "yes" or "no" or "maybe" ?
>
> Some background:  Traditionally firmware logging in edk2/ArmVirtPkg is a
> compile time option, so typically distributions ship two builds, one
> with logging turned on and one with logging turned off.
>
> Last year edk2 got support for logging to a memory buffer which can be
> accessed from the booted OS or via qemu monitor.  Ideally we have this
> always enabled, but without also spamming the serial console with the
> firmware log (by default).  While working on that it would be nice to
> also get rid of the two builds by moving from a compile time to a
> runtime switch for the serial debug log.
>
> > Alternatively, it's possible to dump virt dtb, modify it, and pass it.
> > $ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb
> > $ ... modify dt ...
> > $ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb
>
> I'd like to have something more convenient than that to turn on firmware
> debug logging.
>
> On x86 we have a dedicated device for firmware logging (isa-debugcon),
> so logging can be easily enabled on the qemu command line by adding that
> device.
>
> So the idea here is to have a dt property added to serial port to
> setup firmware logging, so we have something roughly comparable to the
> x86 functionality ...

My rough rule of thumb for DT properties is "if it is a binding
officially documented in the binding specs in the kernel with
the relevant semantics, then OK"; but not ad-hoc bootloader
specific stuff (we have turned down requests from u-boot for that
in the past).

Would using the fw_cfg mechanism work here? That's intended for
passing configuration info (and "how verbose should debug be"
seems like configuration info), and we already have a command
line interface for it:
 -fw_cfg name=edk2/debug-level,string=1
(or whatever). You could also then use the same mechanism for x86.

-- PMM

