Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58CBC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 17:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoDN-0004yc-Vn; Wed, 19 Feb 2025 12:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tkoDL-0004vq-GX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1tkoDJ-0008LI-9R
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739987422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gCe5UVaGw9AQknVZGGe5+i3g/s0v6GAA8hRwe2QAPA=;
 b=UppdnG1WK4UBJZWmgX6Vs6JwASpAm4ESTsPfza3br+/FonQ+dMnXimUSKQybOaZq75PSjx
 5SVtnXTxDgwDCLUxxiWJ5si74LWSBkSHXjRWq9QLtZQJroYJuVnuB4ZEVMdRGTTcYpopvy
 Ry6rXPsr3LuF9hrV3hWflumbUe8X8tQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-O5d3kYZXOf2qvTkpxXya3w-1; Wed, 19 Feb 2025 12:50:20 -0500
X-MC-Unique: O5d3kYZXOf2qvTkpxXya3w-1
X-Mimecast-MFC-AGG-ID: O5d3kYZXOf2qvTkpxXya3w_1739987420
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fc1eadf5a8so96746a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 09:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739987419; x=1740592219;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gCe5UVaGw9AQknVZGGe5+i3g/s0v6GAA8hRwe2QAPA=;
 b=hMTkVtR1ilGsA4W/eea64wqoiqY2Eyz1//O2lpE4e1/up9vJ04/Q/VYAsS0uhjyw8G
 FhUvoDIk0I1poBdxXfjTiMXMCW2x0mifhjHKVSnZjmoh8REpRKEtx/ikYl+6xkUmbWlZ
 e2AikGER1OdKXMUfqn2m7+WYlBszEFTFhz/V6esskBbgX22w9LTLA/BEZCKLn+DhubXz
 g8GI3wU1HVudYRQv3SfjN5eebmIJXNm+vvox7iUra1qdmR2ALnhxOS9I6VB6EIUZ6nnU
 289VmjaH62dIYYPDw4S/dcKOOepF2Wayr9KiuuQkl5+UYwF8xRcqmpdS1P3pY7adOc2J
 +lGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHdmQoY/dwYXOBOtb0YQQSSDXjqGBqZesHe1o85mbsEUlzy7YiRd2FzXHOTRUKbrlSrOtpFMuPR9oE@nongnu.org
X-Gm-Message-State: AOJu0Yw4iQLcfzXHwKVBuEa9T0il8AB+0C9UtKk6Owy4+IoiWOhdRPsr
 p47nb8E03JVQbNWCmIvoY+8+kL/Fv2H4KSxiHAZHU46KNq2Uw2SmZAZeNidZtqnrO1n7/5Gm9nu
 qx5WAq+X2E8VSCafBuFXy4WeKXQaqQKEJBpDVU4TqyFAnVhVYzZpwa9uIKcKErkQHMoR6YYqwVy
 z4nQbGw1jZsW3mEF2qv+bCbZ2JhAA=
X-Gm-Gg: ASbGncswGml+EaLiy+qBtBeCW0b49cKnfet2+1HE21epvE3TGIHCafWZd/8nK9uZcU5
 1T0IXK/JAfAWJMwnscjAzXozT7pi70eG1SRWMB3cpJITLv59mnALPXMpfyQ==
X-Received: by 2002:a17:90b:47:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2fcb5a12ee4mr7635713a91.10.1739987419661; 
 Wed, 19 Feb 2025 09:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0AdA6pS2KePj74plGONkQn60b3InqZ4ndGVV7tnHWiYPc0sSQl3RrYmsDCG/Hc3Jl1tpRLsZt15p0gcrMLMs=
X-Received: by 2002:a17:90b:47:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2fcb5a12ee4mr7635611a91.10.1739987418693; Wed, 19 Feb 2025
 09:50:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 09:50:17 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20250213094100.129358-1-anisinha@redhat.com>
References: <20250213094100.129358-1-anisinha@redhat.com>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 09:50:17 -0800
X-Gm-Features: AWEUYZmlS4GMLZYmz9c8Yy1aegaILqB5L1s3zsPlPcLrL7Lbi-MLkfrA2dsD7Yk
Message-ID: <CAAiTLFU9U_XVdPWdO1w-nu7__GxPkwd09tibx+-VRVed43M6Xw@mail.gmail.com>
Subject: Re: [PATCH] microvm: do not use the lastest cpu version
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Ani Sinha <anisinha@redhat.com> writes:

> Microvm machines are not versioned and therefore there is no requirement to use
> the latest cpu model by default. Let microvms use the non-versioned cpu model.
> Those users who need spefific cpu versions can use explicit commandline to
> select the cpu version desired.
>
> CC: imammedo@redhat.com
> CC: zhao1.liu@intel.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/microvm.c |  2 +-
>  target/i386/cpu.c | 15 ---------------
>  target/i386/cpu.h |  4 ----
>  3 files changed, 1 insertion(+), 20 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>


