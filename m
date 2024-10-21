Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912A3D15DBD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vZ3-0001xh-NC; Mon, 21 Oct 2024 12:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2vYw-0001v4-94
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:47:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2vYt-0007GQ-IU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:47:21 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9150f9ed4so5794634a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729529237; x=1730134037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+9QdK+pDaQ4xzQsWi/yoOsr3u1sBg93Fhmrj2Bl9Oc=;
 b=nj3js1aPC41M2g7mEY+v3KpRUgtboqYGHwsuMpgrOiqpCTGWHoSKvRIqozIJD/Zrb0
 yHbcY2C24Z9MIXgA46/F4hP6UdjebhqwLK1+6Iw3S8VyFdHSQzyGzDPovBbKn2RoeheK
 MLtDJuGQ3x6RPjP3UAl9H72z5/Y29m9pTiOwCnzZyZf1FKuj0S+Q0Orjq2t10bVi6S8V
 BM8CqxKrqzMHNcKfCP1tEuH/pVgahjVKIk2I3U2KPnt7wdn3yu2e5WPk3wnhMV8QhTE4
 NWGcXOLAvoxJRNNtfm4UTNRmxt5gAoQRvdpwDYd4HMyOS0S5kKFkh5FP0YM+hghVZGBX
 PIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729529237; x=1730134037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+9QdK+pDaQ4xzQsWi/yoOsr3u1sBg93Fhmrj2Bl9Oc=;
 b=pqe0aE/jbf5hHUlhFe5Py7BJMLMcXrURvfIsYSUw90mfZ0ixaAOQN9ecN/C5j+Y1H6
 hOsormB70eHp+KaSBnonVqar4RQw6NnbJaVdX47IvV99pVDB/wDDfmEkN6lac5kMGC0Y
 ichW3FHNPWzRt1YKgVzlyBoLiyhaN6eedKM+Md5QdU/Wa9da+rPQs/OBeGkjzGUpkGgi
 HMINl7mVveTgSu6QMhouaQ4OSTDgKOBxrcMfNNeSdg/H/1u+RjLEje8lvKmv22ilQWRF
 jqaYejSPvo1J1SeDZash/Pl5aAys9anrE+LT2Jgpwz6tUDL+v3DQcllH+wd4w56i8avo
 JcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvlT8BX+p/Aa32YnVmNA5ttfAppBZeVlbSHgrormw102KRVMHGvRvyBZjWd5Hibvq5Aw9AgzbcF8EC@nongnu.org
X-Gm-Message-State: AOJu0YxyzdkivXtVYn/d2kIZJSFM6BpRQKC8SrgjBqJOmRy9Mq9+O+Xa
 C2njh7q7JHuufmkJqcSXIET9MrY935/h0+qaFIeCxu/+XQK1NS4o/6w2BSoNGMh0BfztJze/YhM
 L7OJoBVbsl8k8H5vYCrtjL1XEF5s0I3cUvpMdRQ==
X-Google-Smtp-Source: AGHT+IGVGidZEsmHEyjO2sXuQUgWIafjwUMWOqmpbMwQSIS6Ix9CwXk8NmgiUSnPyhO8/wWAWoRB6zELDeT/HOy6eYk=
X-Received: by 2002:a05:6402:3553:b0:5c9:816e:45d with SMTP id
 4fb4d7f45d1cf-5ca0ac6246bmr11020796a12.17.1729529237516; Mon, 21 Oct 2024
 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
 <ZxZ2KS6hi3Y2HdtC@intel.com>
In-Reply-To: <ZxZ2KS6hi3Y2HdtC@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 17:47:05 +0100
Message-ID: <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_=E2=80=9Cprivate?=
 =?UTF-8?Q?=E2=80=9D_fields_in_QOM=3F?=
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 21 Oct 2024 at 16:25, Zhao Liu <zhao1.liu@intel.com> wrote:
> My initial confusion stemmed from seeing the private comment and
> noticing that there are many direct accesses to parent_obj/parent_class
> in QEMU (which I could list in my reply to Daniel). Now I understand
> that these examples are only valid within the class/object
> implementation or in QOM code.
>
> For instance, an example in KVM is a misuse:
>
> accel/kvm/kvm-all.c:4285:                        cpu->parent_obj.canonica=
l_path,
> accel/kvm/kvm-all.c:4377:            if (!apply_str_list_filter(cpu->pare=
nt_obj.canonical_path, targets)) {
>
>
> At the same time, I=E2=80=99ve been thinking that the current C implement=
ation
> seems to have no way to prevent such misuse.

Mmm. We rely on code review to catch major misuses (and let
some minor misuses slide because we don't care enough to put
in the effort to provide a proper API to access the information
or because we don't want the performance overhead of a QOM cast).

In a previous iteration of QEMU's design the device's state
struct was purely private to the implementation source file,
and code that used the device always did so via a pointer.
But at some point we decided we wanted to allow users to
embed the device struct inside their own device struct, which
needs them to have access to the struct definition (though
strictly they only need to know the size and alignment
requirements of it).

I did a decade ago write a proof-of-concept for marking
fields in the C struct as "private" such that you could get
a compile error for touching them:
https://lists.gnu.org/archive/html/qemu-devel/2014-05/msg01846.html
which (mis?)uses GCC's __attribute__((deprecated("reason")))
to arrange that touching the struct field from outside the
implementation is a compile error. But we never took up the idea.

> So for Rust's class/state,
> should parent_class/parent_obj also be defined as private (for example,
> by removing the pub keyword from PL011State in rust/hw/char/pl011/src/
> device.rs)?
>
> However, through our discussion, I realized that in QOM, "private" does
> not only refer to parent_obj/parent_class, but all fields belong to
> this category. If everything is strictly defined as private in Rust, it
> seems impractical=E2=80=A6

For Rust we get to make a fresh start on these things. If
we do mark all these fields not public, what would break?

I do think that some of these fields really are internal
implementation details -- only the PL011 UART itself
should be directly accessing PL011State::read_fifo, for example.

thanks
-- PMM

