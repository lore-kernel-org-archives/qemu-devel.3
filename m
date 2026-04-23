Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099BFC0379
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwKM-0006nH-Vh; Thu, 23 Apr 2026 11:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwK6-0006h5-Pv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwK4-0001Tl-GN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776959435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPdG0ff6z03upCp6SXXsDQRav0FBOCWPnDB88yqTgj0=;
 b=cP78euya18F41z3MM7yDANdyHKcOB1SJXHNcKMgc9NsBmrCvrRnv0Ps4h7HL14eNCnnu6q
 U2eOh/01oOFMQhbJWXXNyAxRsuS3pYbiI1I4+mJYJmRE6g9dKSvQw9coL2120nETvrxp2W
 PvdPkhpVuWWYSCiNvYbW1lXsIFkb2Bw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-46EvIPQ3M_GOl2bO6GPZ7w-1; Thu, 23 Apr 2026 11:50:32 -0400
X-MC-Unique: 46EvIPQ3M_GOl2bO6GPZ7w-1
X-Mimecast-MFC-AGG-ID: 46EvIPQ3M_GOl2bO6GPZ7w_1776959432
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eb55e55394so902642985a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776959432; x=1777564232; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uPdG0ff6z03upCp6SXXsDQRav0FBOCWPnDB88yqTgj0=;
 b=bj+kt+P5svsKDJgWY87r2skFKLx9TzF6ZevEAFz2DtcBKCYfS4SDkvyw8md0uJcflr
 mI6juN3D+AyNNhy7PCDsjwm0wPTIOXnl+Mc14R3QCZV4I6NnmT/2c94rT6k7kR01WBNw
 MLua3buFAABPJwF0f7fboo1+0/9ix5ewML9LGGItm9kgofrmGmJmRaB2py+akhPjvxaQ
 9fkgtef6j652C7ZWbUdHpIUiQ+tP9kq4YxA9f6MAkVI21gMXecJHlNS+Y2z1T0322VLN
 i3702qmQohexDNB1Sv0yXjW+HjBsMBLrqsPtZ6dxF+/xznbzITMwYGkEsQw1douc8X06
 TspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776959432; x=1777564232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPdG0ff6z03upCp6SXXsDQRav0FBOCWPnDB88yqTgj0=;
 b=VC8iE5a/xdIs+WpORQY08kSyLZej2R8wjieprIzTGU7BetCSSCFNusXD/v2S9HGXat
 F73DKRPokHiOoV5Zb2nHxHtjbaVYRpi9vxXlyA4HMnsazFdR+yJy7Bwf/ohR6gRnK8h8
 64M+4E8efsxOxfryp7jykkeISARwCfd2nCVU7rQKW0yrBjylJ4CmveT7SizLPc1oBfWJ
 0hn0V1GxYa0U7mR98nOXKHwwEzUHxMRBwHzVUqMzJKAbZ+WeAxlrPzVQbCigKdHIl8WT
 u8iFEuINd7YN44BsFC1nt0DH73D9T5IiEbRpy6IxTvJCJFVNEKsIOlmkta3QTg044oK1
 Iusg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lZ8tRZe67D+GrW/XIY49VVlh1qw7XPgf/CTlarJ6myM3pHV8Dg6TuayyNNgaQwze94o8sYLjnFOB9@nongnu.org
X-Gm-Message-State: AOJu0YyAc80pPa/OrV7HJbTCdsRJM4ZouMTENLz8CsnKScW1kSuBLE8d
 82hTkVdL4FFgoQVLh/RnQLEvhYMBTW7OoouS0d/WTHa8UGucbCE9DA3afRilYQasx9H5Z7qCLkw
 MuyhbJn3/Bc3QCggCWav16MmIaYqLGaCD8SAOMk9TjmLvXR9l/cCDjzU6
X-Gm-Gg: AeBDievLughem7ClO1jKqgbr8ftFHbRvWQX0prhIamPOd35xccOHsUrn1k6vNbCxZ+H
 IIYkfl0MJrBNDdDAI/moGBJJN5Grcp6LdnJ7S3nJyhX95rN/7rwvCPJuPgpctrFrygb2okEy/4T
 26yFLTjzbOCUCcC1N1GbR/Ofd7R+LS9PzDh8m4Lekih/EHHmr91s78LzBv+K6tZM53ugU+r0E27
 Ky/X+XfSdlesDGpR4r1RQ1Q/j5mIqqg2ImK3GQFIdj7dqNVySWiqcCmdrFJ5tbOEBE6rL6RA3lP
 W8gFcNapO9MQz/CDg1lmefIy1tES4286DOq4CF9xcRKPzV0Vk24AIZeyBKri7PP/KGbdUBgmi3g
 39xxVTUe7wWHqRw3oeg5+20Hmb21Kq6hOA9/teksLJDmmUbtIY18wvTWvcQ==
X-Received: by 2002:a05:620a:3948:b0:8cd:8ad9:c893 with SMTP id
 af79cd13be357-8e78fa1e71emr4115244385a.6.1776959431796; 
 Thu, 23 Apr 2026 08:50:31 -0700 (PDT)
X-Received: by 2002:a05:620a:3948:b0:8cd:8ad9:c893 with SMTP id
 af79cd13be357-8e78fa1e71emr4115237585a.6.1776959431251; 
 Thu, 23 Apr 2026 08:50:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb772sm1720707985a.27.2026.04.23.08.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:50:30 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:50:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
Message-ID: <aeo_xCeDUu2VRKyc@x1.local>
References: <20260423151521.3969-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423151521.3969-1-deller@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23, 2026 at 05:15:21PM +0200, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I'd like to step up as maintainer for linux-user. I'm actively using
> linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
> buildd servers, so I'm very much interested that linux-user is running
> good and stable.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced8..4736f5ad74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4074,6 +4074,7 @@ F: tests/vm/*bsd
>  T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
>  
>  Linux user
> +M: Helge Deller <deller@gmx.de>
>  M: Laurent Vivier <laurent@vivier.eu>

Will Laurent still be maintaining?

I don't know if the order matters at all, no matter so.. IHMO it might be
good to keep Laurent as the 1st entry.

>  R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  S: Odd Fixes
> -- 
> 2.53.0
> 
> 

-- 
Peter Xu


