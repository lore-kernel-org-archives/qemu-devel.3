Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06344C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujiOu-0005II-Tg; Wed, 06 Aug 2025 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujiOs-0005Ho-IL
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:58:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ujiOq-0003J2-6V
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 13:58:06 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B4143F2BA
 for <qemu-devel@nongnu.org>; Wed,  6 Aug 2025 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754503082;
 bh=mr5nj7V1KIgHLhN+73jWIruHWFobQDyMxcw/R01uNtA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=d56oEvHDrtbehpTMC3V6j4u80rcscymY4zBxZ2UQ7jwIyBreTd51ELT+j4Nh47BDV
 ETh/PpIrUJSPdlyAEMa7IuzYNaY7hjEQlZQ0K1BRkoh0CJi2aBTzmSoxQIQvXIGLtb
 +BJ220UHY5OD+SS6+NHCacDD5NhReT5e/uzX6WsyP8R8OZaNeq5LVa7RtOpv24scII
 aRSNBjDHZrWTdr6jSgpeIXoqzaVcpV5AkObh5I6AZLUWYbhnwUj/evbI6nXFLDz3+u
 23lM34FYODN6jjHYl14ZGxEqlr6k83RNzdP7nx9OLtJqLCwcnxVSWZqxsnQT8VGStd
 k9gzdfzs63aDw==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-612b6aa7ed2so122937a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 10:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754503081; x=1755107881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr5nj7V1KIgHLhN+73jWIruHWFobQDyMxcw/R01uNtA=;
 b=s4C8BLhkfeT5jzVdyHgGi+Lovn3QeFRRxxvEgoVxzYlnOtK2c4eupu3B+Zovnl0djZ
 d8BRmPYZruJv4PzYrIMP06SRH8T55QtUQpV4RK1FqN3EW7P58N6AYt07OkkuXOVZC1mW
 9+y5EOrAa1rYyqzvWwUZ4xzk8uE4RUlewfvINGSXSdQ6Bc0abkDVyoq0asthOwJY2d/s
 n2UZav6tq8a8fUhKlfUMPyuC1WJCUYgi1VJqRqz5OPElhfSTO80auKmcTHuVqQ13ghKh
 QVocjz8aIy0LdYB4dTkG0Q0Qs1g4h/aK0AR9KRVsYJuIOvIAozoxF1w1P2McOosPkcgm
 OWWg==
X-Gm-Message-State: AOJu0YxfnJYKulaKsJDFv7AeCwN+1b6vM4RCoUwdzT+xi+FkuDYdaWFv
 g02TX3cjVnGm41ck8LblZ7Pd9Oab2soviO89RZ33qRUj7UXVY+J7Qa9cZZO22TqReBZ9rvmniv8
 Tp4tnW40i3a54dQI6S+WIYSbA3xtn0OV64PPccxAjnZgu1rdXfR/RFXG85wjP+iZROTvhkPCXjB
 CSQboE/RGk/wBwNZ7P/5BtAFRXsRX5QQXB4M7lLo/6uVpmNQgqc2VQYMQqxg==
X-Gm-Gg: ASbGncsMMEu0yavK/YwGK/BfJmym9K3TvH/Nqg03gDBaBqVxOm7AJhTuLU7vSOR/dJm
 QO8Xf7/9lOOapEEU3s62O1GlGxSRKigre/rZZDpek9+oBIWezEL/T4TFOlf7h8OTCvEzmmrU/1d
 RfkdwGE37JcoDz/uJZltmd
X-Received: by 2002:a05:6402:274c:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-6179615a422mr3412865a12.16.1754503081138; 
 Wed, 06 Aug 2025 10:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZxfw6Qa3Ye1UyJcqtskbVygx1yLoeOfp5rMp6pnD8G0oV3J788DropTF++k9kJ1K+kKhtR2d66UAWN1B4dXU=
X-Received: by 2002:a05:6402:274c:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-6179615a422mr3412842a12.16.1754503080596; Wed, 06 Aug 2025
 10:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
In-Reply-To: <aJNDxxjeqkOLAO2r@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 6 Aug 2025 19:57:34 +0200
X-Gm-Features: Ac12FXwzNQaPv4CP1-TlHtIttj99qJlIgo4YL8oWn0UtBTSlxNCefl3MyqD8zhc
Message-ID: <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> > Hi,
> > I was unsure if this would be better sent to libvirt or qemu - the
> > issue is somewhere between libvirt modelling CPUs and qemu 10.1
> > behaving differently. I did not want to double post and gladly most of
> > the people are on both lists - since the switch in/out of the problem
> > is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not yet
> > having all the answers, I'm sure I could find more with debugging, but
> > I also wanted to report early for your awareness while we are still in
> > the RC phase.
> >
> >
> > # Problem
> >
> > What I found when testing migrations in Ubuntu with qemu 10.1-rc1 was:
> >   error: operation failed: guest CPU doesn't match specification:
> > missing features: pdcm
> >
> > This is behaving the same with libvirt 11.4 or the more recent 11.6.
> > But switching back to qemu 10.0 confirmed that this behavior is new
> > with qemu 10.1-rc.
>
>
> > Without yet having any hard evidence against them I found a few pdcm
> > related commits between 10.0 and 10.1-rc1:
> >   7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> >   00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> >   e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> > feature_dependencies[] check
> >   0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> >
> >
> > # Caveat
> >
> > My test environment is in LXD system containers, that gives me issues
> > in the power management detection
> >   libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS:
> > Read-only file system
> >   libvirtd[406]: Failed to get host power management capabilities
>
> That's harmless.

Yeah, it always was for me - thanks for confirming.

> > And the resulting host-model on a  rather old test server will therefor=
e have:
> >   <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> >     <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> >     <vendor>Intel</vendor>
> >     <feature policy=3D'require' name=3D'vmx'/>
> >     <feature policy=3D'disable' name=3D'pdcm'/>
> >      ...
> >
> > But that was fine in the past, and the behavior started to break
> > save/restore or migrations just now with the new qemu 10.1-rc.
> >
> > # Next steps
> >
> > I'm soon overwhelmed by meetings for the rest of the day, but would be
> > curious if one has a suggestion about what to look at next for
> > debugging or a theory about what might go wrong. If nothing else comes
> > up I'll try to set up a bisect run tomorrow.
>
> Yeah, git bisect is what I'd start with.

Bisect complete, identified this commit

commit 00268e00027459abede448662f8794d78eb4b0a4
Author: Xiaoyao Li <xiaoyao.li@intel.com>
Date:   Tue Mar 4 00:24:50 2025 -0500

    i386/cpu: Warn about why CPUID_EXT_PDCM is not available

    When user requests PDCM explicitly via "+pdcm" without PMU enabled, emi=
t
    a warning to inform the user.

    Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
    Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
    Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@inte=
l.com
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)



Which is odd as it should only add a warning right?
But I checked the logs - the build on "e68ec29809 i386/cpu: Move
adjustment of CPUID_EXT_PDCM before feature_dependencies[] check"
passed the same use case.
I'll build both outside of the bisect run tomorrow to ensure this is
reproducible when I watch it more closely (than submitting a bisect
script).
Maybe this already helps to put your eyes and thoughts in the right directi=
on.

> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

