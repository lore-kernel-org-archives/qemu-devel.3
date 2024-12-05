Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3438EE7716F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 01:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ0DG-0007Mz-Lm; Wed, 04 Dec 2024 19:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tJ0DF-0007Mo-5k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 19:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tJ0DD-0000KA-NR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 19:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733360361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkPFXHFKWo/6rrItyMyAL4Iug0HflUNwI37Ct6W0mww=;
 b=XIirV3SAovcACbvELGv7vJVw86JjuwxDYUhIgYK65E604GIdDBlV181Pf/aSpsbhsAxpTm
 RNnQtNziSzqsDb9524DmMb64fl4Oj61epyr29lUzEbE5fgxGndWLjesE1L9X+b81CIfAqj
 Fz9X7Hq7wCp59ZAFHw+Pr0PbDXSfk/4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588--0r0vAq0MnanEAnTjfRVeg-1; Wed, 04 Dec 2024 19:59:20 -0500
X-MC-Unique: -0r0vAq0MnanEAnTjfRVeg-1
X-Mimecast-MFC-AGG-ID: -0r0vAq0MnanEAnTjfRVeg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa51a52a5a5so15885566b.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 16:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733360359; x=1733965159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkPFXHFKWo/6rrItyMyAL4Iug0HflUNwI37Ct6W0mww=;
 b=MU8osVG1X6YoMzW9BPz5Jkb1dyu5hYRRjlBnkgdNkGAeLyGMX0XzmpsYjFoaexD7Jr
 GwywoZHLVgGc/+Ae0CCiIQmc0Ch5nLxe9TdfDD0KPhvO4nVt8vk+pHwqUbPmuRH0ebfX
 H8GuiljPRzbd2XKB9gS0XdgDetrdf87jmKWIH3jTWIYWaQXSNpHAkIalRm95CJLlJLw1
 LyMLjgBL24UTJRUSrZG0XpkOFBwgx/puE2CAyXMnjkkCNvqqFH5E1+imWp2uYq05RKao
 Tuat+/fWK/HaQPO7vMQPpf7bR9PEkA4FTmZ1eYlObb+u8Jcr6GoSdAqHRYpwpgtsq89u
 3J3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYqQw483LaGbRHZw8H7cJQEnaUBQdTvmkpj4e9DhfsdKZzWiKb2Y5lMlXjvsI+Szftt4VqeUQCsq3G@nongnu.org
X-Gm-Message-State: AOJu0YyR+3+s3fcnBDqOjbyhhLcxjo0q4WcWAt81/X+b/NhA/bPUSoor
 Y1xYywpDEhGblHPlCWV/kpb8hl11zQC7RPA7DecPhx/lQhpEHnPpJDqqZhqmti4NGg4d15pbFZG
 FAvQyAtduSCUih6ik5ZlLqyfY3eG8DfPgcsKVckMhNRMy/xoV1dEDVLNrUYR8p3i6TyrwBg5RmA
 2i2gg+rdqMz0q6LHo4jLgODJ6G7H8=
X-Gm-Gg: ASbGncsK3+TC2YL4uP1584EJw9qoF5A+YH7QCQPsFphgFMItCw//yZJL8cKQGgb2OrY
 gjSIY5TfTWfy1mTVdjfe2V4MKRB1E599Z
X-Received: by 2002:a17:906:2932:b0:aa5:3d3d:f959 with SMTP id
 a640c23a62f3a-aa5f7dbd388mr602023166b.29.1733360358798; 
 Wed, 04 Dec 2024 16:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbZoXrSqXzt+/ouCycOwywLBsA895SakrwiUBaKrlnZs5vJRXyk0AfkC2B9QQ9lyWtBvFYxx7DY3cnw+8SV1M=
X-Received: by 2002:a17:906:2932:b0:aa5:3d3d:f959 with SMTP id
 a640c23a62f3a-aa5f7dbd388mr602022366b.29.1733360358500; Wed, 04 Dec 2024
 16:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20241203172445.28576-1-philmd@linaro.org>
 <9e878028-cff8-4fca-960d-d66e68334acc@linaro.org>
In-Reply-To: <9e878028-cff8-4fca-960d-d66e68334acc@linaro.org>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 5 Dec 2024 08:58:41 +0800
Message-ID: <CAPpAL=yYfhenWbt1Xb31747GWAbXSqzKZ6ur9WuvhbwQp-55oA@mail.gmail.com>
Subject: Re: [PATCH] include: Rename sysemu/ -> system/
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

I tested this patch with virtio-net regression tests, these changes
are working fine related to the virtio-net part.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Dec 4, 2024 at 2:27=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/3/24 11:24, Philippe Mathieu-Daud=C3=A9 wrote:
> > Headers in include/sysemu/ are not only related to system
> > *emulation*, they are also used by virtualization. Rename
> > as system/ which is clearer.
> >
> > Mechanical change using sed tool.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9<philmd@linaro.org>
> > ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>


