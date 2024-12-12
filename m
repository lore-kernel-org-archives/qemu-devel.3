Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF60E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkWF-0004zx-41; Thu, 12 Dec 2024 09:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tLkWD-0004zf-Dw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tLkWB-00051X-OR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734015017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGv9SBdawUIsZbYtqcRGA7Fkm/5FJ6KegjuUCF8fxXM=;
 b=Es/unWWUCQxYN9gGd8ROdnrVYFRHlGivzDW3WwxkNML2dGgO1bYj4WE2Zv/EGXlLR3H9Yj
 P3gaN0J9ZidgWWMw74xp92e5xAjyTCUdd7Og3eIpVCPpLglx1Hqyqkg2vtdPISenwouPqb
 BcCsg1uodb1EXDlI4M5s/FwLXJeg3Hc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638--9TMF6QhNhGhbbQZZ2w7mw-1; Thu, 12 Dec 2024 09:50:16 -0500
X-MC-Unique: -9TMF6QhNhGhbbQZZ2w7mw-1
X-Mimecast-MFC-AGG-ID: -9TMF6QhNhGhbbQZZ2w7mw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so49214066b.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734015015; x=1734619815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGv9SBdawUIsZbYtqcRGA7Fkm/5FJ6KegjuUCF8fxXM=;
 b=DgxOkymQ6l7bkDAsnZCYiOYwyJmcmSsgkW5KQg7vx4GNEttchqmTb2yb5Try3Lbsx2
 8LmhAivQ0a4BjOm1ua7Wfgh4v76hFSFJKIpsQy4LxvXHQLgD9FAbapmwYotw2JodeuKZ
 7rQpBqqQYcrsiOrbUcL1YgzMjwAQTax8BzEBwmlBthRJi8/tAixrpxaKfkTJ0MBK048j
 ++/1D7dN/Yuf9YtdYPmYiuOBMTv4k7DBMoffoTyHyoz/NkxDQh1HlX9mnfKDcniQT2+9
 2A2mg9S2uIGpzdY9L70cF8XEJwLyAJ4fkrZv9TkSwwkNqx5cxFO9gukTCar2LMirYI6x
 LXJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAUNdM9K++pKLC5XD2omvZ4MxBn1b8cpCuH2gTH1gCbgPm7qPsJ2BgSqeb1iIbTD8+tCxstQYcPxfo@nongnu.org
X-Gm-Message-State: AOJu0Yw1e0M9fP/IwzISx+7YHW/7GJgvupHt6P7N1SK9Rf2VxbmaVSGP
 VfsOECEzZINzqUaSKSyqhlTLe5wRixeJk5qmRjNbodAZjGECMU7AGoXXor3VgknTMkAxawtSs10
 ceqfYFL4MM4hkQBKDs/wZIbSuNtfs9oQz5beFwnOAosYj6bbXJCSPAXb/pS6bIktIsz77m4fc9c
 tqgPlZXVXZO0rAIxLAsa7wPJwk2so=
X-Gm-Gg: ASbGncvb2Lt16Zs1I40Hr4L6LLKB4Op0oKlYyWo/wnWDlemDZE1cm/AA5ujrPOF2yN5
 i8d+7Wbt9RiKIlJvgcb0vKVXROVIEAm+WLz6W5pU=
X-Received: by 2002:a17:906:1daa:b0:aa6:abb2:31f4 with SMTP id
 a640c23a62f3a-aa6b11e8f29mr635972766b.25.1734015015355; 
 Thu, 12 Dec 2024 06:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo6NYJIYhxEhRIz5jHOMWQ3FEQP7ep7YfL8emtDr8oL6KwR9isdXFtBHXLAorRhsGLmyX/rLrkS/m5a12tvw4=
X-Received: by 2002:a17:906:1daa:b0:aa6:abb2:31f4 with SMTP id
 a640c23a62f3a-aa6b11e8f29mr635969266b.25.1734015014956; Thu, 12 Dec 2024
 06:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20241208064810.893451-1-anisinha@redhat.com>
 <Z1cIY357gcsE1IgJ@intel.com>
 <8FE9B724-4233-4D94-AC17-5D6B90F55D7C@redhat.com>
 <891266A0-3863-48FA-9440-64EB9364E665@redhat.com>
 <Z1rts37J6H8f02iT@intel.com>
In-Reply-To: <Z1rts37J6H8f02iT@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 12 Dec 2024 20:20:03 +0530
Message-ID: <CAK3XEhN=FJE_by10jtfeAXbWMA=QX_ET6HY5cS5XXd49ikEBCw@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Michael Tsirkin <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 12, 2024 at 7:25=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> > Had a conversation with Igor offline. CPU_VERSION_LATEST does not work =
since it=E2=80=99s a moving target. Therefore for a specific machine, what =
version of cpu model will be chosen will depend on what is latest and this =
will change with time. It can break guests that stick to a single cpu model=
.
> >
> > One way to fix this would be to keep a fixed mapping between cpu model =
and machine versions. However, it will be a nightmare to maintain such mapp=
ings.
>
> Thanks Ani!
>
> The commit ad18392 also mentioned the plan to move to CPU_VERSION_LATEST.
>
> Because previsou commits have repeatedly mentioned the plan to move to
> CPU_VERSION_LATEST (not only the commit dcafd1ef0af227 you referred, but
> also the commit ad18392), I think it's necessary to include the
> termination of this plan (i.e., your explanation of why you are no longer
> attempting to move to CPU_VERSION_LATEST) in the commit message.
>
> This way, the history regarding default_cpu_version will be easier to
> search, and it effectively puts an end to the previous plan.

OK I added a comment in v2.

>
> Thanks,
> Zhao
>


