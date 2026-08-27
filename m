Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F3C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXTK-0004PX-UO; Thu, 27 Aug 2026 06:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzXTJ-0004Oy-M7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:36:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzXTH-0006Ov-Vd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:36:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d6f55a7089so24571235ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787826994; cv=none;
 d=google.com; s=arc-20260327;
 b=BP09L4HhuiFcFzFspnH2+rx+AELXprjkxYa3aBS7bUeUTsN8BX+9StneVGE5giiR7j
 j5I27dzFetQWRyZlQXazZ/ideuMDny4khRiW/4dmPpKyr4a/B5BgJOGgc67tcWWoNw7Y
 Std8xaC83N4PG2fbybimqfFfxy4SAi6+1219z9DBoWqieqlJAesxyrAPvR+Mr0XWTaKW
 HWF+argET2tOspD1+vN9dSx9Y8pBpPpPTIj9WeP66op8zTC9zjNqFE61GkU5b7mz9uxA
 RY0No8NIjghn6sMmyJsjS/8/xf76XJb8BPlcLXrHJ3KejOj74WqL/QPT6Rlf7xkAs9FG
 Z/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BFMZtC3SAnzWL9BXwMyuubCJvroKeKnn2Hgc1FOHnxU=;
 fh=BvaKJMiH2T+cklnzFVwMvu7nTyBSZzzflKJvBCzExpE=;
 b=IOzXuNQhmuS5kx5AW7ecl+6Cb2gvJ+Ti0F8YXYN64//Z1zfLyHO7a4foykjjIddCvR
 i8sQbsmffWTLPWgjuNpjH/Q8GKrau//+01wAzWL8i3N198Hr8sVM6VgSpBuEWSWQBCuE
 kKp14lxlYYO9LHpW3CykIrwq3h24bWRcXOlLZ6OxOYJdQlSvXqJOU2mUhs+/ZEcA6Lig
 ExF6B8PTNLTXZu9aD7I5FeC25z8G15j0KtzLiNJwvizACwOSLSWrWo7qhP+x/NMatDgL
 xgbcAfCoTgfkfwrVtRwSAPQpfrHXiLDJ3pMyAV9P5g5xM7heCmHF1ua87GVRX5+L0hxP
 9BEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787826994; x=1788431794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BFMZtC3SAnzWL9BXwMyuubCJvroKeKnn2Hgc1FOHnxU=;
 b=aVCZGBOhIeLRQzufAaiMKAgeKTZfwjWO8dNqUbO9hhULVevWoIgeZ6as7A8YvC+S9k
 im7UHhYJa9faybwDBs008ATZ9nGeoCM6HWF1mDpEiJwXd7vAW8Wp0ixW1pa5guqeAzgb
 3lV84jenmjcNzkn4Ks3cGwLUIpYxkrm8Dkhu8Pk4xGnP5E6CukOjF7F7L2t4WnLeQBtb
 ltjLW7J/OtPH6UilbXBnTr3s74v+gPdWJpvpi9FHRfaWfc0/GADptT1EshuXoRLB/zMP
 4UXY+9OpesGLimQx54mhcPEMrcyKIz0x598ywizSLc2VJ8CDlluROTcygIPc4mwMSWjZ
 HVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787826994; x=1788431794;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BFMZtC3SAnzWL9BXwMyuubCJvroKeKnn2Hgc1FOHnxU=;
 b=PuWIozql3yDjbHmxbqJrpNNUXxAWzcSGKYfQmezQCesiQnnfpkwS1l97e8vrSk9T66
 9xVPx10YZkAppfslRsnuZPhppKpXZU3mVq1/cpJ0AipgXycQqkicpDiCImNNeQeVeZBf
 ur4B4YDnYOxlcn6JDCgHlAnilBjH7gj2vdwmocYRHq97Ax/FEFDGJIS7tFG7bttDyhG5
 VxEcI/nXSMxoF9sMiAUPPElvPjxYG8cpyr38EyNC5Cw79YWcOV0HppBi1XMDSPaJdBCa
 mpaqwCM9aTamsvgHcN0G6asZuaG6pFgAd1yhmYjsnT1vbmJZ2HGx1HiD01vjlbrhvvf3
 WX8A==
X-Gm-Message-State: AFuF++llUKvWSA/ALJ4QhibtujGfReGLteuW21QLl1HPOmIBPaU5MNN1
 maicRLoGm/JgVuvXPUQ5+2Pgj+IvsCaJp9pGqAMVNC0ke5BDazbg6bfnHEu+IrPOnPLckNBEg9H
 f8l87+dWka0+GOsmgKMLdL54nK5efpjE=
X-Gm-Gg: AR+sD13PQD/ZKfdtaf3TwZZz6E77fo3EEUFnSLM/GZytDHx4vTA0II8VpELurV0HMJd
 0Lozr9/NRMHM9o4jRrca4wrb6dgBVKj4n6mMIFvnzACtRxBX+mAx8Tfs6/+DVC3HFD13wr1TuaO
 dlAf+8cccT3dTr0+D+Jqw9OibrD2EyuO4USMTNrqzwjWWDEOGnluaiR3LBqO+uprOJFxFH/r72+
 wdATGOWWdvepc6tORorYrjbXKcdNxjgzidL7muOkGcmxSHij9burJpdlWN7P86L1FIk1G0L8o6d
 rSBgo6+Fjmf5BkFRUWCKPnayxEmCI4UOHJGsnPypzj2fvFabvi0fT809Dh2bhnCe4mVltQFNj2R
 v+aY5gAyWytI=
X-Received: by 2002:a17:903:1ae8:b0:2d6:f3f0:3e7a with SMTP id
 d9443c01a7336-2d707957143mr252694305ad.3.1787826994265; Thu, 27 Aug 2026
 03:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
 <ao_5WNBxRiZycEeb@redhat.com>
 <CAJ+F1CL-4kx18mUC4Jk7-cARiVX0Cq3qSFt5Ct-qM2EBA9dyUw@mail.gmail.com>
 <apARs-59eJramFr9@redhat.com>
In-Reply-To: <apARs-59eJramFr9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Aug 2026 14:36:22 +0400
X-Gm-Features: AcwNN1UNGAaWiVcSIx7dhepzy5jpMadSVhWob2q22gDQbhPrrTN9NazwPP7hWX4
Message-ID: <CAJ+F1CL3y68B40P+2RcB5G5-GVjfP3JnTLdcRECRAFsk1KEdhg@mail.gmail.com>
Subject: Re: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Aug 27, 2026 at 2:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Aug 27, 2026 at 01:58:14PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Aug 27, 2026 at 12:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Thu, Aug 27, 2026 at 11:06:47AM +0400, marcandre.lureau@redhat.com=
 wrote:
> > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >
> > > > When the new cursor is the same object as the one already held by
> > > > the console and the refcount is 1, cursor_unref frees it before
> > > > cursor_ref can increment the count.
> > > >
> > > > Ref the incoming cursor before unreffing the old one so the
> > > > refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.
> > >
> > > I don't see where/how this can happen.  The caller of
> > > qemu_console_set_cursor should own its own reference
> > > on 'cursor'. So on entry to this method, 'cursor'
> > > should have a ref of 2 if it is the same as the
> > > current con->cursor.
> > >
> > > if anything the behaviour you describe sounds like a
> > > bug in a caller not holding its own reference.
> >
> > You are right, I thought virtio-gpu kept a weak pointer, but it should
> > have a strong ref, so we should never reach 0. I can't explain the
> > crash I observed then.
>
> Is there a bug report for this or crash scenario info ?

No, I just had this report from ASAN when testing -display dbus with
virtio-gpu. Pretty regular test.

> Something wrong with the 'cursor' object stored in virtio_gpu_scanout ?
> I notice in the VMState:
>
>         VMSTATE_UINT32(cursor.resource_id, struct virtio_gpu_scanout),
>         VMSTATE_UINT32(cursor.hot_x, struct virtio_gpu_scanout),
>         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
>         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
>         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
>
> what is restoring the "refcount" to "1" when vmstate is loaded ?

cursor !=3D current_cursor (allocated with update_cursor on post_load)

