Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18887E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLlut-0007rH-DX; Thu, 12 Dec 2024 11:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLluo-0007q9-QV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLluj-0006m7-Uq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 11:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734020383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjLjmf2xqc+J9/1KQmmjLod5nkYXfAqv9KztQKPtyBY=;
 b=X53b39u9Fo54XoVxbBBOU17HkTrc0UdGxRbuccXuDWNiCxuv5ef4vXkoE96SANqyG6/bed
 ydVj0jILKUykKPyn2BqAAOIBcXSW8F0eW7WX67dNLi5FrptLSy80RbtsQVUyEfT+54HbxB
 PM76CeImMx/f4Ne00m+pCBMVzQH6uSU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-p7rOdWX6OSyba4PwklPrZg-1; Thu, 12 Dec 2024 11:19:42 -0500
X-MC-Unique: p7rOdWX6OSyba4PwklPrZg-1
X-Mimecast-MFC-AGG-ID: p7rOdWX6OSyba4PwklPrZg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e4bea711so114501885a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 08:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734020382; x=1734625182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjLjmf2xqc+J9/1KQmmjLod5nkYXfAqv9KztQKPtyBY=;
 b=Cnarx17xjKjvrcJJ6XhWcGKX+Zdu4EDBGvIS6uOKIjtMDCotXgYR11s3HwUBRnuR0f
 4XNgH+WtsjImqw0AxKvMdUcWT/1F4pLvunX8rcFc5op8vmGAcdp+Wc/cj9wSuGII2XQC
 iCe+gEybNR5UlCJvQKB+e8A+nXumFyUjcVjp6t6+gQfGa+KKgfxAP2L28RHhzyHgKN9x
 HfkR12QFQBaegoPkU0R4voPmkFD+Tg1Q0t9BMYl9UU+hRXD7RP5946TNAq3rPPP25hMj
 YceBFMZpf1/yL7tMVUNmOo6j+H7c0jJRDHGQDaoTsdbKjOn+QgkFUT//bPfZIpYsTZwB
 YAEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX57bPajnMCkVntf9gzLusj3x9y5A1cjBuxaINGIDai1flDUJyLnRmY+w0Ts0iDKRRhL1jZX9j4ng+M@nongnu.org
X-Gm-Message-State: AOJu0YyJVLWQ9IU0UXN2c/JtjfrlWEI+TIChhB5X7sY7dYQMx7ykSde4
 jgAQJ8NUu4Vv9qa6+iQcTVH8MVxK69BKVk5iRxE8lRtDUwamL//tODLJbanqjLK+MkRhiFI7jKF
 jSqM9FiDR1MGWkGxwpoK3hV5DhX8Vqs08MingjQQ9uB5tHokFtLWL
X-Gm-Gg: ASbGncsdZOcosVnmdfGjE1aWrPmvNiRvBYUIllaFPTKssxRzo+Z7ce1IBmgJ0C4Sa5D
 RR2YIx1+5jfywy97C1UAf3KC+eXPaIOISL8E+eVimC2YXoekb1PRCo0J7e6fpIi0U/QIEtT4cy0
 CCLFyPxr0Ovst9rKYUbxnSqpRx1b7cA6Pmt6j1fDSfpO/W/uuksogAQptycbqDD9q4bVEXWzZOi
 wSYPa5LgifnByFrRy9Ho84mQbw4AWQVHpk3BWEbQ+DjMHwM0pmxz5CNz/X9v34IzKone7Xi4KKy
 9YdtprxJm7o1dX/OyA==
X-Received: by 2002:a05:620a:268e:b0:7b6:d736:55c1 with SMTP id
 af79cd13be357-7b6f89bc371mr167007885a.48.1734020381722; 
 Thu, 12 Dec 2024 08:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW/ghKyVVLXxUIrTfZWj1TN2WDAitKEjNpX+KtrhlGOtMuniQ7kTtkYbXIeLrYEXUmC2AEiA==
X-Received: by 2002:a05:620a:268e:b0:7b6:d736:55c1 with SMTP id
 af79cd13be357-7b6f89bc371mr167004685a.48.1734020381440; 
 Thu, 12 Dec 2024 08:19:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f711fac7sm34898685a.116.2024.12.12.08.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:19:40 -0800 (PST)
Date: Thu, 12 Dec 2024 11:19:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] sysemu: introduce a new MlockState enum
Message-ID: <Z1sNG4gZDwx8WzXi@x1n>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-4-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230433.1371327-4-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Dec 12, 2024 at 02:04:32AM +0300, Daniil Tatianin wrote:
> Replace the boolean value enable_mlock with an enum and add a helper to
> decide whether we should be calling os_mlock.
> 
> This is a stepping stone towards introducing a new mlock mode, which
> will be the third possible state of this enum.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


