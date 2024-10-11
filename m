Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425FAD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJGi-0007GB-FX; Fri, 11 Oct 2024 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ8U-0000hD-Az
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szDeG-0007nV-Ec
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728645450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmN8Qgj4Kgf7zGRW5zmo0Pd2c+XiAVNrp2QHMBev/oI=;
 b=V/bifNWook8tEZz7//7N5igPyPAwxN73ayhviXF67NuDomwInAZOsKByfNYBk/MT9GI48l
 sm5wdJZtYLuFRSPcoSQZ3EfwkRp8fEnbchVkFf8XzoMSE9g8mq103qH4SaCMQWJ8OotP20
 sINBBIWKubae/ckXlDcfSnkUSxUKOiE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-7sbJS-UjM1CZRHBzmAEa5w-1; Fri, 11 Oct 2024 07:17:28 -0400
X-MC-Unique: 7sbJS-UjM1CZRHBzmAEa5w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431123a6eb4so14107735e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728645448; x=1729250248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmN8Qgj4Kgf7zGRW5zmo0Pd2c+XiAVNrp2QHMBev/oI=;
 b=ewvvIAdeDUNYJ+b0/G5on5/uN3YZo1Q6mpWyWOsShIUECpqbeKeX9/HRERVr1r51YU
 5u8L1PcTMvPhesEq7P9Oc991NtlVovU5rTgx8Fi6iyP6a/O0ceixNQrkVh3xG6vfZU7q
 kuSAcDtESyPIi6EwkRcyeNKmwOobPn7Pku1P2fPxKyDrPPhmWjmV7nRY4xIvGp6eU6Ca
 rnnJFqH1AsWEejXshksibT3bBbtu2yLyDaEQni3Qiy6pIpPHPsT276ccHcPPHtsHFQTK
 qLxIiDidHQq1KsaNZnPMJzTTk2XKOtLstZrMCfGbwCSxwkbPtW2hz81b7uc2IJ39QLHi
 snXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1up++B75e7dI0vDwfI19dNlP8xMjy+HXTOr8a69p2PmXTv/gPV4pdgtdZH0SMLlBSRLR5LbQVEsUb@nongnu.org
X-Gm-Message-State: AOJu0YzoiKXWxt3ftzey3gI4elhSj5kqxiC1NWcpT2rXpSmTVw8tFZB1
 Z3UCOZDZP0ckqCWwnnGRx9qzzDOcPdRnEBE/ClODmAYGBBr39adI479ZZS+V8WIpCutsgoezdPu
 2khSnJJnY8ZPvQfRepCLqnkHuWGGA5DYLOz+8d/jtX2cZ7nquHAdN3EM1nPJ8Kggr0zTcxjPZbS
 RkhQTDHYHcuqryZuH5PCzelycOCdE=
X-Received: by 2002:a5d:58fc:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-37d481650acmr4952955f8f.7.1728645447684; 
 Fri, 11 Oct 2024 04:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqrHqkcbBAFvuEIb85FlM98OBhCCo9MlF/p+WfpNxwyQN+e7xxtGpcUVErUHrc3QYezA04LUV68OmIagf76PE=
X-Received: by 2002:a5d:58fc:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-37d481650acmr4952945f8f.7.1728645447310; Fri, 11 Oct 2024
 04:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241011054806.1014276-1-raj.khem@gmail.com>
 <2a543dd0-11e7-4357-97d9-31979a1a87ff@redhat.com>
 <7a2892b6-c0e3-43d5-93e2-30e72cbf9897@vivier.eu>
In-Reply-To: <7a2892b6-c0e3-43d5-93e2-30e72cbf9897@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Oct 2024 13:17:15 +0200
Message-ID: <CABgObfaMqMvuQLavCUYxrHm8oQ993oANUC9Qi5hyxsLvFAWENw@mail.gmail.com>
Subject: Re: [PATCH] sched_attr: Do not define for glibc >= 2.41
To: Laurent Vivier <laurent@vivier.eu>
Cc: Khem Raj <raj.khem@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 11, 2024 at 11:15=E2=80=AFAM Laurent Vivier <laurent@vivier.eu>=
 wrote:
>
> Le 11/10/2024 =C3=A0 11:08, Paolo Bonzini a =C3=A9crit :
> > On 10/11/24 07:48, Khem Raj wrote:
> >> glibc 2.41+ has added [1] definitions for sched_setattr and sched_geta=
ttr functions
> >> and struct sched_attr. Therefore, it needs to be checked for here as w=
ell before
> >> defining sched_attr
> >>
> >> Fixes builds with glibc/trunk
> >>
> >> [1] https://sourceware.org/git/?
> >> p=3Dglibc.git;a=3Dcommitdiff;h=3D21571ca0d70302909cf72707b2a7736cf1219=
0a0;hp=3D298bc488fdc047da37482f4003023cb9adef78f8
> >>
> >> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> >> Cc: Laurent Vivier <laurent@vivier.eu> (m
> >
> > Hi, I think it would be better to test in meson.build (with cc.has_type=
), as is already done in
> > several other places in linux-user/syscall.c.
>
> We can also test if SCHED_ATTR_SIZE_VER0 exists as it is defined when the=
 structure is defined..

Yes, that works too.

Paolo


