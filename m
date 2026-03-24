Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71A2F54ADF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55I0-0002Wv-Be; Tue, 24 Mar 2026 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55Hm-0002Vk-Pj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55Hl-0002mp-6e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774372279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jLEOa/qe84fRiaJ28GBTBVjxDGNzKXW14RsxfehDEQ=;
 b=Vr/OFCo+h7Su+3rqidStNdc3EmR/Ktkpk01eZ7qxevo8QoMzkJSct8GBotsyFkaaOx0672
 l9bqeztbJHxT9hICS6zoig9GQwniEqtNagJ6u/1V2Q4kSvDHDmzSZV0JXvkQ7IoVN1dAX7
 abfJ9Q1o5noUHU9w/6mpbUzimJcrQDM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-_LfA-75UNqqNP8V6mClv1w-1; Tue, 24 Mar 2026 13:11:18 -0400
X-MC-Unique: _LfA-75UNqqNP8V6mClv1w-1
X-Mimecast-MFC-AGG-ID: _LfA-75UNqqNP8V6mClv1w_1774372277
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439ca4b3d0bso5190519f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372277; cv=none;
 d=google.com; s=arc-20240605;
 b=bcbW22gB2QRMUONdbRBn96eLLCG9lgGcbcg5rOVcr+4xRTij8Enlh5+hy4LB0rLDb8
 7+dYaFystfbL6yYmI6cJJE+s61n78cw8iIYy8xwULFCA2v1o1YP396HVl2PSRttXoP5/
 7I6hT1+/WIJYZF5FbPggcyeW1pT6aL0A0uzMFGoDO0GnhU5K9WSanFtQ9KudrCIphR4d
 fHzXSFbGXsO8pCMXglNnNWpTCkn4ccWxLCBhqnRSStI0QGWR8/ENumrTy5E42yBQjG5g
 uTp1Ca6ZAfP50rv9nIZsgzEBVp7R7tRNyM6YHHHD9Wp8aAODA2v9cJ7cNjdliy1kXwxO
 HLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9jLEOa/qe84fRiaJ28GBTBVjxDGNzKXW14RsxfehDEQ=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=IVmRucPDeBz+djjhu2Wttoq8OZh0Ss6SE5S2ltgDk+0NyQJJmeV9Ew7HRkX+C1KrC/
 VoQF/FDao79Y3rwU96k41/Urynbqn0zBbP/taRnuHM88tLRvi7MFIzX2kNK+3ObR8poI
 ksWl2eY6JKC6O8ohKIFLjS9tyvKhZH4d8q9XOESjILN8ZSk0YxqoiCPSDXZIChs/sFa4
 Vq12bvQKCa8pjZOmrqQIiuFUP2/n70EoB8AM/Loy52ydjqp2QxWj87sXB7yj+GpemSWD
 Uo1K8EpKwWBXP89sEONb0teomvV+hJpQcyjNzOVVpdFLMSs7lNJazHTd3eJFUbGzbdfx
 wnSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774372277; x=1774977077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jLEOa/qe84fRiaJ28GBTBVjxDGNzKXW14RsxfehDEQ=;
 b=fTf25mF3/9SwssFs6kaMnEfjP5Vi7Len8UM+ZN5yQ+hhHKclisr/J7IxwmiS+sMJIm
 HsaLBXQY80evh/+Ikh36jH+k+8XVGL6KQbwCH86BEjSPLuQeHhBg/ZjLJbgr0bniWNv2
 Z7GO9eQBkDAEPYMB4kyQ/wvcszpkyrjcuso2dBZsb3oYiSCQZjNKY42HscgyIQptqJbM
 StNloxhIL1wo+ANKYKESYOvOhy7i+xhaUW+8ULnhsQSFQPNFn2w7w5/i3Q1u3Pi6vhP0
 zC8GZ5DqRpOuh0VeL/NQAs3zEDHxesMhGBll3flSjKZRzoQYqFhY/jNVilhRRdOFWg1m
 Uqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774372277; x=1774977077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jLEOa/qe84fRiaJ28GBTBVjxDGNzKXW14RsxfehDEQ=;
 b=lHegDActCtpHcn//KKiah6KJWUZftAtpbbVUw/laPNdV2ov/B3xrOuhzETL+PMLXp6
 NLznse6wjqz6og0TGUdSObQ+yyFu5QuIO8lruyEH5IfSSeNShB4NzWoHMRpo0hGz7s8q
 oM6e3xz0cEja02KOuWlxjNUnD1bBDbAAdnfMWN5YaMzd1qUsG9QnRM1dDyEa6wPJXNfw
 vQJtCmIM0Mvh2YohNCu4CuaCG+6ZF+aYSmUaNPhkj4Gh90PEz7/pRZNjd+tJ+st4/5QR
 FxdxJOSSxHV9HzR6wgtlIVQTRn+Yj5R50k1b7lpM/BQWSZYpUOwamFU1Sg/uTN/BCMDZ
 chtw==
X-Gm-Message-State: AOJu0Yz0YXNT/kvvE/xKw4ssD5lb7UMQErx1Wa/z2qWIrKRsLZUrp2fC
 WbOw5F5NEautFxdS/IPp+hT8Et1nF6z3nmdnbhI5fnmKnMv2bfVqVvg7k20OBN984ngoORiIbcz
 YURHyL/qk25lGAn847VtnZSQ16Mj01eCHloA3TuhH6Pr3vdButFXWn3rk3g6DmGsWaAsI2SEmeT
 BAl6XnWvCA0IjsgFkx7BdHzEqC/GSznrE=
X-Gm-Gg: ATEYQzw23h/Cn1aA5BUAa7fTG7LpQ/69X8sDBj0nwovQeDjMnK/YesETgOm9cwR4ewl
 alcphToloCFmYkJ2FOLRVHjKEUbXJwixhBPTc+nL51yPuNtZo/2pA/g4Kf+Si8b4lDdIPPK75gW
 Himj/I6jy3gEf0Da1NrxKq8W2EkMk0x7BnpMLCvhTfTVoVg75PxcGQkQizZiMKKXeH3BGDuQXsy
 /T1pb/DyB4z3AjKGdKKgEW84UQFDzsiYwhonWrTCDIOdKJGW/IhbYkQRlh6ZQyPrhJI/zuh4qVI
 JM+G
X-Received: by 2002:a05:6000:4205:b0:43b:5762:298f with SMTP id
 ffacd0b85a97d-43b88a25610mr344975f8f.36.1774372276821; 
 Tue, 24 Mar 2026 10:11:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4205:b0:43b:5762:298f with SMTP id
 ffacd0b85a97d-43b88a25610mr344930f8f.36.1774372276335; Tue, 24 Mar 2026
 10:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260324165705.785605-1-pbonzini@redhat.com>
 <acLDpimgjedofUgE@redhat.com>
In-Reply-To: <acLDpimgjedofUgE@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Mar 2026 18:11:04 +0100
X-Gm-Features: AQROBzDwiGcXnGbd4Z6NB3K-mrE8QK5XKd6kArL4nhVqkX-l_hyinO4YXElKs-k
Message-ID: <CABgObfbwXU5gtpKcq85LNeGce+7tkJGeUwSqTRQ06AXgvadE7g@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 24, 2026 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 24, 2026 at 05:57:05PM +0100, Paolo Bonzini wrote:
> > The version is never set on 2.5+ machine types, so qemu_hw_version() an=
d
> > qemu_set_hw_version() are not needed anymore.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  include/hw/core/boards.h  |  6 ------
> >  include/qemu/hw-version.h | 15 ---------------
> >  hw/ide/core.c             |  2 +-
> >  hw/scsi/megasas.c         |  2 +-
> >  hw/scsi/scsi-bus.c        |  2 +-
> >  hw/scsi/scsi-disk.c       |  2 +-
> >  system/vl.c               |  4 ----
> >  target/s390x/cpu_models.c |  2 +-
> >  util/osdep.c              | 12 ------------
> >  9 files changed, 5 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> > index f85f31bd90d..b8dad0a1074 100644
> > --- a/include/hw/core/boards.h
> > +++ b/include/hw/core/boards.h
> > @@ -197,11 +197,6 @@ typedef struct {
> >   *    used to provide @cpu_index to socket number mapping, allowing
> >   *    a machine to group CPU threads belonging to the same socket/pack=
age
> >   *    Returns: socket number given cpu_index belongs to.
> > - * @hw_version:
> > - *    Value of QEMU_VERSION when the machine was added to QEMU.
> > - *    Set only by old machines because they need to keep
> > - *    compatibility on code that exposed QEMU_VERSION to guests in
> > - *    the past (and now use qemu_hw_version()).
> >   * @possible_cpu_arch_ids:
> >   *    Returns an array of @CPUArchId architecture-dependent CPU IDs
> >   *    which includes CPU IDs for present and possible to hotplug CPUs.
> > @@ -297,7 +292,6 @@ struct MachineClass {
> >      const char *default_display;
> >      const char *default_nic;
> >      GPtrArray *compat_props;
> > -    const char *hw_version;
> >      ram_addr_t default_ram_size;
> >      const char *default_cpu_type;
> >      bool default_kernel_irqchip_split;
> > diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
> > index 730a8c904d9..a40a6c204a6 100644
> > --- a/include/qemu/hw-version.h
> > +++ b/include/qemu/hw-version.h
> > @@ -7,21 +7,6 @@
> >  #ifndef QEMU_HW_VERSION_H
> >  #define QEMU_HW_VERSION_H
> >
> > -/*
> > - * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> > - * instead of QEMU_VERSION, so setting hw_version on MachineClass
> > - * is no longer mandatory.
> > - *
> > - * Do NOT change this string, or it will break compatibility on all
> > - * machine classes that don't set hw_version.
> > - */
>
> I feel like we should be keeping a comment statement that
> this must never be changed due to ABI compat.
>
> >  #define QEMU_HW_VERSION "2.5+"

Ok, what about this:

 * Starting on QEMU 2.5, devices with a version string in their
 * identification data return "2.5+" instead of QEMU_VERSION.  Do
 * NOT change this string as it is visible to guests.

> Also, is there any better place this can live now that this
> header file has a single #define and nothing else ?

I could put it in a random qdev header that everyone includes already
- but I agree with Peter that it's better that it stays isolated, so
that it does not grow more uses.

Paolo


Paolo


