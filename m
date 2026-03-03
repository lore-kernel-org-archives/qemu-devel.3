Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D266BEDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxYJM-0003pq-So; Tue, 03 Mar 2026 17:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxYJL-0003pc-5K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxYJH-0000ag-3x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772577225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZ3iVpiETC1+FJYK8BWoumARbNmPPmCJX56dPvoZWG0=;
 b=A7GOKNBZw0oDnJD7JbmGZobGMQo2ZpdvbVPdo0MOxOvZV/qyfLsRpn6vu764wuiUdscGRV
 qauV6XyCJ06Mngsb5RKOnu6/8UIya4jQM39xODp5Kx5z+siVN/Qh2+oBU+an79kpz4nG1k
 lC5XY0ZWGE28eIxxFTyh8q/GKD8DU+Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-4G2GsRWEMD-bUaEPBSYNzw-1; Tue, 03 Mar 2026 17:33:43 -0500
X-MC-Unique: 4G2GsRWEMD-bUaEPBSYNzw-1
X-Mimecast-MFC-AGG-ID: 4G2GsRWEMD-bUaEPBSYNzw_1772577223
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-359918118ebso6328917a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:33:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772577223; cv=none;
 d=google.com; s=arc-20240605;
 b=S418C/+mbgww497grigzVB2kwW4lTXN6/ZD1dml9jvhmggKzSmL6HKgJ/51Tg06tzy
 Dskc/LACs4NHUkEmTBEA//yWGlpMYtAw4KSDkjKq4lTYBgSkxrAC886eCKhbJf6W8F97
 WPEm9V4I1ZZw9zuSUUpUgbLHwqXXaMynTnFQPwMtAnX47ktEq5eaUOhNgpCD1K578bHx
 PWRcLAnnrOjOjFc+/MMmI8Fo3Amicb4fbasKR44KeHCi5PdS1sLQteTJQa7a8XysN1xw
 cH8XEvp6FNH7KC1N4ccZux3YUx9hGhTKAPG4LkYEPlpoKTSiucNJu/wvZtf6l3B32YUn
 H0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NZ3iVpiETC1+FJYK8BWoumARbNmPPmCJX56dPvoZWG0=;
 fh=OKaKyZj7DgGtfb2RDDRBahu5KxUDfK74GK37YsiN4nA=;
 b=VfSrc297n2oKs4mf8vWz9lC3bPIdUSF2R8kIhnqK7GcbmxOypDuCr/vZJWUTWjIsqi
 XqnC7k0Z01m/ipy4hM5gpI19E/zVQd8OlCARqjEPVRqj7F5ARbuxmQRTbLcdxqkUgBej
 ptcyxSCOibRezU89Hd3rDjVjz5+np6qaoeBVfH0uuHHqvVkVsvc669WmEIg4zcunMWDg
 +1/dT1vuXQl7ex0J2/JHlYABdk/wxd0nVO2syj3d2e09qBkCn6b3rx3rC/iffXvuf+sP
 o0yseO2FHyI283eQKjTAz5N7A7Mesr9r6IR908QnIOdjBj3DtDocir3kjihl0QQmoef3
 JafA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772577223; x=1773182023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ3iVpiETC1+FJYK8BWoumARbNmPPmCJX56dPvoZWG0=;
 b=EaEJ3S5ARG7w4AIjPavlqMDy6pIh7oAXPs03PGxpsKNcEFKWct8zD83npZZ5uK90Bd
 VfIGw9uhBGLsCj/1ysA/nAMRHRUZcGJWEb5gRCfCn/r+DYhXF1VhmGvk+X2hlN65d1G8
 RgGw9J3Y1HjLorBCAXWirskuEbkj+LqjXnfntAyk8i3C2pAI7M68vNZTZ94HV0c9ChcK
 Zapw7jSiKpWUdDUY4Zm/7tYxlpW/nb3797dLUeECDKRGVD1GAWneXqm78btIlLFxKPJp
 Tyr5h98Mndoo2YYnC2vI5iYAB5M96yqGTRqspegz5Ol/cGp7bEvDKifK8MP1rVPsgEb/
 /NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772577223; x=1773182023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZ3iVpiETC1+FJYK8BWoumARbNmPPmCJX56dPvoZWG0=;
 b=NFrBFmqR0ZBMLMpIH1BaZxJaPwcyR2DF7dIy2Z9rjvmvY+7Y4KRDrP+9xoDEg+h2k4
 h5QhkIBJHDs8DfwXezzZGLkVcsnSyZJDWZUB30+VNfl3rHy4drTb4XuqRnRQTlyBY7HH
 K9YuDIzHaygteNVg4nm2h9E85iwfLZa07fSSpuPf8iot4tDdneZTWdSzLQ1IhdR6v+tS
 mKJdPO9ESLhZBwi7RlusginCVnNa2Q1QVd1qWdtPTiJ64TrXys3w2zmCfPD5JPR8eocg
 8KcMmGYUs+mhopiGBKFFfdirDOvVIcUyMUnYbYBmknBpd5Tj2P4d+t4iWxBvQCjDO5uK
 9Zjw==
X-Gm-Message-State: AOJu0Yz6IhIL6RdHqsdRGa/mxivTpK5ju11HlCGbP+9/IrUiIq/GKr1c
 SNT9il4g8CbmdKdqIhxPbsUH+/JK3zwdZ9SIoJOKSMseB45FkBACLgTXfT0i11sYh3KHPE/br8K
 +kRP/DP6splwv+Kac95HMB2eJw5f9/9wGqJS0vXxKUzduSAin4GTPHaREZmTaQbHW4AaY6/cM1p
 u26OrFZcdELbFElobdifGJFqRpp6Aw3Uc=
X-Gm-Gg: ATEYQzycExWN6w2W+vfDA26n9MYHH6DWqIoyHtMMyNDSmuZ36LuKcIZ89KRWV+Or/s1
 C7sBwZRsTbWBmZSGAZQOz+ZuMK6sMABp397njulKEBkOrKO+Ad1rwUzWW3bvv8crwa7RtTsvR7d
 CoUpbTn3LR/1/d0u1ud/jYysdlYvfQx60SLGS17CSmRCPtYjd1aduyBKN2UIKW9CMEaezQCYuGo
 UysDxogoRsBttsU3uG2V6mJee8qoZ9C7gS1toI2cVMvWD2003KjkmzQuVFC/dIQhJa/fq2PkdvT
 zzjAh4qIEaJdw4nfhDXobkzj
X-Received: by 2002:a17:90b:1dcf:b0:359:87ff:f34f with SMTP id
 98e67ed59e1d1-359a69c0a66mr9033a91.3.1772577222717; 
 Tue, 03 Mar 2026 14:33:42 -0800 (PST)
X-Received: by 2002:a17:90b:1dcf:b0:359:87ff:f34f with SMTP id
 98e67ed59e1d1-359a69c0a66mr9015a91.3.1772577222381; Tue, 03 Mar 2026 14:33:42
 -0800 (PST)
MIME-Version: 1.0
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <aadScmxkeyWBFLeg@x1.local>
In-Reply-To: <aadScmxkeyWBFLeg@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 3 Mar 2026 23:33:31 +0100
X-Gm-Features: AaiRm52s2AB2fKLzvYjW9AoNqafX-WyW_elj4MkHBBh_m2_gOMytHrhkmxz-A30
Message-ID: <CAMxuvay7r_0Fb=MPn5ECkkeVe1sZ7FfG9r8Z=mCcaEpweqh3cQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 3, 2026 at 10:29=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 26, 2026 at 02:59:45PM +0100, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This is an attempt to fix the incompatibility of virtio-mem with confid=
ential
> > VMs. The solution implements what was discussed earlier with D. Hildenb=
rand:
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18=
657-5-chenyi.qiang@intel.com/#3502238
> >
> > The first patches are misc cleanups. Then some code refactoring to have=
 split a
> > manager/source. And finally, the manager learns to deal with multiple s=
ources.
> >
> > I haven't done thorough testing. I only launched a SEV guest with a vir=
tio-mem
> > device. It would be nice to have more tests for those scenarios with
> > VFIO/virtio-mem/confvm.. In any case, review & testing needed!
> >
> > (should fix https://issues.redhat.com/browse/RHEL-131968)
>
> Hi, Marc-Andr=C3=A9,
>
> Just FYI that this series fails some CI tests:
>
> https://gitlab.com/peterx/qemu/-/pipelines/2361780109
>
> Frankly I don't yet know on why rust fails with this, maybe you have bett=
er
> idea..  So I'll leave that to you..
>
> =3D=3D=3D8<=3D=3D=3D
> error: unused import: `InterfaceClass`
>   --> rust/bindings/system-sys/libsystem_sys.rlib.p/structured/lib.rs:23:=
15
>    |
> 23 | use qom_sys::{InterfaceClass, Object, ObjectClass};
>    |               ^^^^^^^^^^^^^^
>    |
>    =3D note: `-D unused-imports` implied by `-D warnings`
>    =3D help: to override `-D warnings` add `#[allow(unused_imports)]`
> error: aborting due to 1 previous error
> =3D=3D=3D8<=3D=3D=3D
>

ok, this is because the RDM is no longer in memory.h, and thus objects
are no longer needed. Fixed

> The other thing is this series will generate tons of checkpatch issues,
> almost only line width issues and unmaintained files, so they're trivial.
> It seems to me it'll be nice if this series can land 11.0.  We have one
> more week.
> Please take a look when repost, thanks!

ok, thanks


