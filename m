Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6ECC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsLJ-00054n-1L; Mon, 17 Aug 2026 04:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wvsLG-00054d-HO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wvsLE-0006r2-R3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786953907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReIaoFKGPGVVdkqb6FZPUThLDi9tyUScIQx6OSGTBd8=;
 b=AyBMWUR4BzoqvY5gV/G8ezhmKRjG0a1ruqJoBJVYNhEYN2RIy5IzCsoKJ2y8d3WUCguKmY
 N9c6Pacq65w16NQl2guZmtVWK12ta0EY2+wdE4MWgUOb6WhvSGmMzo+mVMBP/m1GJqZddS
 m6t1LzbRP0fNjZuAYlWv44SkTfrH0+0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-h7Brb7ayP2yL8OwSgZLCVA-1; Mon, 17 Aug 2026 04:05:05 -0400
X-MC-Unique: h7Brb7ayP2yL8OwSgZLCVA-1
X-Mimecast-MFC-AGG-ID: h7Brb7ayP2yL8OwSgZLCVA_1786953905
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso2208795a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 01:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786953904; cv=none;
 d=google.com; s=arc-20260327;
 b=djzbN+tJdYQTfYE9Eugob9jvpio/fIJYErbrQl9aO7nmmQbzr9nWnk7Hvow5rWFvDn
 uUOAzjsIycss3Yluqdqc5SszErVqGSxUXIUL12HmU5yOBn0lByeBivm8aKfi5idQ4N++
 bKuyLYeGI1NwhYDxJ624NgZhq6KSz/SNZpjqX3fYd4s6339jHOBqhSx7PkC1ZIqedjGN
 N3ZWd1MDtI3Xu5VL/+LRow8ui+3/v33m/xgCDgwQyskiWlLPFv1P5NhUHrFqbcMPERtE
 YMfLUVfg6NcHWLFcNMUHtVGlhkcE++/ZsmCF18J4fJW3Mw++P3lwabJ9SNXWTXxnGX50
 Ncrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ReIaoFKGPGVVdkqb6FZPUThLDi9tyUScIQx6OSGTBd8=;
 fh=8JzT6AoTRVfMcA04+D1qj0bBZcmJpg2Sf1Ar+GXOmAA=;
 b=Wpm4waNiVkiGzz9IUzglkXRSDh7daTp41J0/+XMU8/ep1R/Yj1ozsWC4n7mSDCjvVL
 XYl1/HOa7rUcbwCvkMXtq9CoxBJXNB/N91H7ShJL29v8jvR+CP0G3xKMSkYP8bjU/zJV
 aihAjw6xLD4evr4wF2PHGPMFktBj7lgLOVRDciaF/HVJVsXzXv82M97I0Afs4k7Vjxrj
 7QK4POIuwzCL/7DaD8QI3Eoyzoeh0CmkF5HhIkv5lvE43np3Zkp8jnRTXPSXBqV+S0Hm
 Rgd0kJYVhF8W5gsbh+6YfOzH39GN6y0emN6i8n56BwqZZtTPOzc6t5/UPJbxhJ0ycjUQ
 tKZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786953904; x=1787558704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ReIaoFKGPGVVdkqb6FZPUThLDi9tyUScIQx6OSGTBd8=;
 b=bKIVnpfTCaVYbSTmdDmIewxjjvUuUSog2qRU+X82FjUjgpkAT0PHSWOuy2pyE2IqUm
 stG4T4hbbbSbhftG7hHVpiL3d7PtvT622zwNUBSf+s179zToG7lNMTkuCGskfVqGB1Cx
 TXn+UnqHEVfsjwhCZCsa6nXYFThkx/oHK6y/XS0QIYHF75tA9y33xViLVekRvai80Jrc
 ++PdsCZtrUHBQGWmiSfvwjf7Df5pi/RtmC8Wsiq9I6Re2KEBWieLk1OikWHc9ZPGjZuk
 +a4ivvy+d1l2BNoohsaG5SFz3x6GzgXWhQoOMmuvalOB49EGLJlLlGUS6z+1Q0B27vVe
 rcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953904; x=1787558704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ReIaoFKGPGVVdkqb6FZPUThLDi9tyUScIQx6OSGTBd8=;
 b=NbvD67IUfDaVTKEgTdzbUR7aZZlrABoNQ8SpbEPuRuVRGG8dCU9yNxLTpQRBRv297y
 k67rFl8S1CWw1u3d0rB1XVtINFLR7UY5BPX+omGFmzpIxZS8HTAi2JfL0mBHMcPxQpHU
 hsxp1tb8NORSzhjEr7xkiaP2/GwesuHlqDs33v/CItb609kdGILwgAacv4jR30VsjRyS
 YMgwijMMHLUDLL/yAVcA9y43OLLQv6Od+AwN/vkQu8qVPu8PlSymTQWcftQR7+lOsHQH
 cmS6Z0IRawfbYYadeS38IZJjfYPVZpCZ+XMzLfM2Q4GltSuucgoL8ERaQyuOeMRk2BOI
 IZ2g==
X-Gm-Message-State: AOJu0Yx4Wu7Ck2DxVqMAI5cwFuT5DTTOyQCMLwiKm0WXuxlMGQIBRvyw
 pkfXE7JPjn5n/21ze8NPdfIO1zl9X8dOIgwIwhg2+V4Re7CHwiQoMZ1lar1fCQkfrqGlqJJIIJb
 6EHj9aXM+GRH6Qyd02S+MAwOHPpPE4+I926wCB2aj6R/elsJUW89JOQlhw5vInhgfx/N9h6uCrm
 fKlCY7mbuBLfpZwF89IMHE1lIuQcEPyUY=
X-Gm-Gg: AR+sD10DVZLhkFTu/UgQTsJH2e0NBZDnte3tHHPFXCbUOlQWnaqMNY8CcfuROjYAHj/
 ms6q/VHKSkFLMY2qrmKe8iyidaY3ABRlhaIEfUXOcDt6dRKyjlbVUePTM2O8VPjVH+JBg/wxV3S
 VRwffmoE7LwDCaPj7jfXLctphnrsybVAD0SN7ueyfuJ5zLBtsG1fuoRNBImvufh4ihZN70LTAKl
 y8EUdGaQl5+Cn/d3tfbE0Ty/z9jakWXa4unbVvp93QjmyXIK/92xtLvhmQJAnzgJmAo6NQQlBzk
 OQ==
X-Received: by 2002:a05:6a20:918f:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3cc71d27199mr19788753637.27.1786953904366; 
 Mon, 17 Aug 2026 01:05:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:918f:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3cc71d27199mr19788679637.27.1786953903730; Mon, 17 Aug 2026
 01:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-7-e53fc35bc550@redhat.com>
 <26d7e5e0-fcdc-4051-bc5f-d06b4decf1c2@oss.qualcomm.com>
In-Reply-To: <26d7e5e0-fcdc-4051-bc5f-d06b4decf1c2@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Aug 2026 12:04:51 +0400
X-Gm-Features: AcwNN1W_cvaf9ixOhRbCszixwo1KT43YQV1Ag-kzTqoBQe8HQ-NmohwMFsqcaP0
Message-ID: <CAMxuvawzwR2xSdxk_hCBDfVBhsYduwf17mZixzb1BJuMsRCf1Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/49] system: decouple qmp_inject_nmi() from Monitor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Aug 17, 2026 at 7:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/8/26 21:12, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Use first_cpu directly instead of going through monitor_get_cpu_index()=
,
> > as this is HMP-territory. QMP doesn't have a `cpu` command, we should
> > add arguments instead when needed.
> >
> > Update the inject-nmi doc to accurately describe per-architecture NMI
> > delivery.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qapi/machine.json | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 2d63c1bac3b4..29ab1cb9d7f4 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -432,10 +432,10 @@
> >   ##
> >   # @inject-nmi:
> >   #
> > -# Injects a Non-Maskable Interrupt (machine specific: for example on
> > -# s390x CCW only the first vCPU receives the NMI, but on x86 machines
> > -# all vCPUs receive it).  The command fails when the guest doesn't
> > -# support injecting.
> > +# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
> > +# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
> > +# (s390).  The command fails when the guest doesn't support
> > +# injecting.
>
> You can drop this one.

ack


