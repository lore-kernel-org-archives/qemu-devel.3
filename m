Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E4ED29DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxxb-0003IC-UJ; Wed, 14 Jan 2026 05:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vfxxY-0003HY-Bk
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vfxxW-000278-Em
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768385916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MiLvmT1G+aCIETVtRo6e8IRKYs3Vavl8ZIPRHIWti4=;
 b=aITUcDgA18cwuDoNIRjkcRoME/QwLSKdIyspo3nx2/fltdoa9oW04Zz/HxkSGp1jAWUs+H
 /Eg7yldmk6NJyAWM9ToGsFo6DylrS0Vj8rfIgdh9S4On7dOVwqumaCtgIpPnmdNY4L/xMG
 Vrm+6dwBisBb1QgMkVtJaJk91v5fhtM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-xMyhkl_wP1WVdrSOxCE8nw-1; Wed, 14 Jan 2026 05:18:35 -0500
X-MC-Unique: xMyhkl_wP1WVdrSOxCE8nw-1
X-Mimecast-MFC-AGG-ID: xMyhkl_wP1WVdrSOxCE8nw_1768385914
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b871403f69eso382352166b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 02:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768385914; x=1768990714; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9MiLvmT1G+aCIETVtRo6e8IRKYs3Vavl8ZIPRHIWti4=;
 b=B7wQEmiTE0SWTwpRCZI40gPwbdzWUmgRKaPjK1vpwrG+1HKKH+9pGdVSdYcYdZR3Dc
 POBSJChqi3KRuo7rOfItyjiGG3CkwBxWQpvvC1+sX8F8iJhyQzzlF0jMQCeJ1gn4ryFZ
 svjiYxLvc5MTOcq61frpLLNaNIVmyaihSSUSVG9VG//butA0Q8K1zslzpYIkQ0CaHPET
 zVqBXPQTDBQfk48Arjua2rpBbr56l4LYtKa1F3UYiyFmt4lEB/n+8HFhGss1hKpFe4sL
 gADBRIYNXLSbhEjsKErvDrfq9kfMlwmz8VsBI6R42OPlsveCvbitInCYwa5CMFbiFFhx
 0RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768385914; x=1768990714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MiLvmT1G+aCIETVtRo6e8IRKYs3Vavl8ZIPRHIWti4=;
 b=VqA/zRDmNZ2oWb8U5gF5MDwBnIZw1jjjROWpwoTsvplamjrbL/ow/8QcChBIJ3KJib
 oPCG/MHlzl/WCnk2t9o1WsMtlQXYvCj2UOlfJ3FC7yOpXCjggNWULTab5Ah9HE7I0HMw
 3Nnz8AK2jchvH23/LAs8nhtQ6sB7fxGmVr6V7jGkiykxP7ZHEZVFGnk7zVvcLtosfQGu
 wmJQRnQgN/x4QKdKJMiFhjAPPq3LGf/1mn167QCuoeXahsrhrjFr54LLwlX1aXmDhdxH
 D8havi7f+/gJr0cBhUuZpFMEih7MH6K4fHC2VQY6Ay3i1wC4hNLa2qzkWh7TNed2LgP5
 16tA==
X-Gm-Message-State: AOJu0Yxw0FE4We7SRDtJTPFYMAPdapPokYLdtVMy2M1ggqQMKm/SZyId
 +0InF89cX9hHDRIHPhvIny0AoqrA0yjkdBf2nllEWC2FoZUnmCn/QG/k/FGQOZTpropamXPb7G+
 w3bAKpx6odlC1mdt06wn/egTcxjrLt+KCyIy3b7kA630fMTHqwmr2y75y
X-Gm-Gg: AY/fxX4nQ5IEaQeWibQqoHwCQTiLGyRmfB7B/tphqWO2NA7nXpzZw5MK1jsiZkKoR/v
 bz8iMXYuAXuyhl/1P8AWGFtYfXVgPXWBjPZ2eMP7oP/UwBNTczYB6g2PUSt4ySh3J4fUtUXPkuo
 NhFIorkH8Dew9K2UA90B1raj8ljI7Q7a5H0yFmlI6IMnja5xCsNcGl1ZXvEzkU1V0SBUstgScNc
 LGRBShHaNcR19n+mwVK2gh6M+677qWcK8IdPP7xu2euH4PL7JViCH74r0IR9u9M1AWAn4Vbiy+j
 LXwpsC5mN3zevGqAErekrI3AStelCV3kPixmTTbGhlYTn9a/mOwUtS3wSrW0MxEPpji6V9FuNu2
 YtRTsBIg8TvJkd30rLqUIejloC5UdwNjPOfUVYgOQ6xXm83OVBzWbIr6EhXrFrQ==
X-Received: by 2002:a17:906:ef0c:b0:b87:22b2:6533 with SMTP id
 a640c23a62f3a-b87612c92e2mr222437666b.54.1768385913671; 
 Wed, 14 Jan 2026 02:18:33 -0800 (PST)
X-Received: by 2002:a17:906:ef0c:b0:b87:22b2:6533 with SMTP id
 a640c23a62f3a-b87612c92e2mr222434866b.54.1768385913181; 
 Wed, 14 Jan 2026 02:18:33 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it.
 [87.12.25.233]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d1c61sm2392940266b.35.2026.01.14.02.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 02:18:32 -0800 (PST)
Date: Wed, 14 Jan 2026 11:18:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] docs/system/igvm.rst: Update external link
Message-ID: <aWds0ujDVhaeteAX@sgarzare-redhat>
References: <20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 30, 2025 at 07:23:33PM +0000, Jim MacArthur wrote:
>Also updated revision to 3.43.
>
>Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3247
>Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>---
>Just fixes a broken link for the AMD64 Architecture Programmer's
>Manual.
>---
> docs/system/igvm.rst | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

I'm not sure the new link will be stable, maybe in the future we can 
just mention the manual name and version without any link.

>
>diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
>index 79508d9588..f45eb1707e 100644
>--- a/docs/system/igvm.rst
>+++ b/docs/system/igvm.rst
>@@ -166,8 +166,8 @@ References
> ----------
>
> [1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
>-  Rev 3.41
>-  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>+  Rev 3.43
>+  https://docs.amd.com/v/u/en-US/24593_3.43
>
> [2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
>   https://github.com/roy-hopkins/buildigvm

Oh, I just noticed this. We recently moved this in 
https://gitlab.com/qemu-project/buildigvm

Do you want to fix also that one?


In any case, this change LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


