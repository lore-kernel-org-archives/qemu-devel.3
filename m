Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DD4CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7xW-0004WD-J6; Thu, 04 Jun 2026 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7xU-0004Vf-Nc
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7xT-0004yM-1n
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780579081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sEWi6G8/UGMpayW8eJf11XoBujX7FDgoivK7+ZHkzEI=;
 b=STetW3IfBtPcQ0GnwumHaKnaS8ov4imr+dTQhqKmTt8tAX70EN3D2sEryKFxi0LJWcHXdD
 fRftT/SfT9B7yPr5EX+rZcQqkagN2X9VVppmJQO6m+4vbMg2FZA6H4/DcEVZpU08HRf0Fr
 WkHLaFngHL32OYeY1P0J0LNAywWRBhM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-x-955FoBOvmLlGJLNkL5UQ-1; Thu, 04 Jun 2026 09:17:59 -0400
X-MC-Unique: x-955FoBOvmLlGJLNkL5UQ-1
X-Mimecast-MFC-AGG-ID: x-955FoBOvmLlGJLNkL5UQ_1780579079
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-460153ce644so487914f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780579079; x=1781183879; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sEWi6G8/UGMpayW8eJf11XoBujX7FDgoivK7+ZHkzEI=;
 b=SILMHLnb+gcKyFU68jBXaXUgTL8S2PUlFIUm/XSMhGAp31BNCxdGTWYZZ+osu/25JQ
 sB2xWaYo6/xHNchy5j/pi6+ClabVbAgKsdWoYlJ5KqVO/cBVJdKDoQ/H0yFfC3F+50NP
 Ga2E9HKhj3mF9RFUO/tUfBPnbbY5YC+HwdyLm7GzVuEWFt9bYWYfvIncNhIB0FB2hege
 9k1xLwFcrEiqFbVRwAW7rbYLUZyzC1SPZWwSbh92a6+aUGxfqTnNpkrXZabFjALN4jMm
 zGB/kelfhGgo+Z0D3hB+nhpQhX7duTo5eceHW8vXC7xhxeCXBHd3umljjR7Wvzi8R+OK
 +6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579079; x=1781183879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEWi6G8/UGMpayW8eJf11XoBujX7FDgoivK7+ZHkzEI=;
 b=byePAzyBvyB1gFTGuCW1+KH0GfnF8EzqA2WAK3XR7vLF0f7XzRkqkKB3kNF1AYKoAx
 ZYFMWSTco3sF9UHFA9b71PEnPcEh9822Pjy3WvYnht8P/vDczudzlBFadGjBcDer8bHj
 iTkasDENsA8GJi52NKeyhS7XdXssJ4dhAMSKo1DCczVZzTamGDx1ZsIXbqfi4Xzacc+I
 ZFR5NhYmfds52Feq90sah6Fu3TRRMWTQMJ9Z643PK30ng/+OimtU7uc1Kn+q5iSR4ugp
 K4ZvzVuFRp0HzyIDr3tmepZWAZhhv55gIBlc3lvLmLLm+RrFrd7hNg0/p7Y9ZNCZrs/i
 JcJQ==
X-Gm-Message-State: AOJu0Yyq/SUlkx5AMzUnw7QncmYv9n7s1pkSMsLauAli9PRpROUDZThv
 YqvdbFHtWblFF0BA8mOBMSIWuLurIKno7LkUnDjYRW+G8BX6WaQtsBEwkzCcctdw4wWhZvKvw5A
 BwwjxA6sYySC+Y+MCPTctLwV02LPr0XfsNjD1aqqMTgpCuzl8g92s8OhU
X-Gm-Gg: Acq92OFUZWb39ZnNpWdzoAbJfsf8/eZdS9SycJtnI8AjojBtXB5kg1ZXndd4UeKFZX+
 Xsl7F6SB7lXIhREZjm4MiuvzXih+mh1fwG90T93sNjHB2Kn7Ct5kFgOQiwpSDvTl/xSO57GEnAp
 ri7+GAh/djI/Z9rs9wcnGN0Ahxo5vceULnU17ZG5TtKzu3Vxo1YzkF+ah9+E8QWRQepW4ugVAMf
 NkCuRs21cnYkxski3ix7jWd22QsOQk/dasENpsbSWw0QeSi/RYyXz8stRCEJxLy5ZAiLBqvldSv
 ctqDF3Iw6xB72DmEZAhMU+YVMMFiBi5/jr8td1PkxiVGtI0+17tpWpRKLGqHFlOdqIlsxOqYMa5
 ZECxLyRj2d9aoljyWCn2ms/i/30GKZkPhFMMX5KcB+GkDMUaqMWsn/Ym1Hl32Y+dRQUcvU28WVW
 nzVuFT1g==
X-Received: by 2002:a05:600c:4691:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-490bcf647e6mr59286025e9.0.1780579078383; 
 Thu, 04 Jun 2026 06:17:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4691:b0:490:bcf6:469f with SMTP id
 5b1f17b1804b1-490bcf647e6mr59284995e9.0.1780579077649; 
 Thu, 04 Jun 2026 06:17:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm16894564f8f.13.2026.06.04.06.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:17:56 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:17:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, 
 pierrick.bouvier@oss.qualcomm.com, Julia Suvorova <jusual@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 34/38] MAINTAINERS: Drop stale F: from "Linux io_uring"
Message-ID: <aiF6lwircL8PCske@sgarzare-redhat>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-35-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260603064032.3733394-35-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
>We neglected to update MAINTAINERS when we dropped stubs/io_uring.c.
>Update it now.
>
>Fixes: 047dabef97 (block/io_uring: use aio_add_sqe(), 2025-11-03)
>Cc: Julia Suvorova <jusual@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: qemu-block@nongnu.org
>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 71383b9807..c5b6985767 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4331,7 +4331,6 @@ R: Stefano Garzarella <sgarzare@redhat.com>
> L: qemu-block@nongnu.org
> S: Maintained
> F: block/io_uring.c
>-F: stubs/io_uring.c

Should we add `util/fdmon-io_uring.c` in this list ?

BTW this is unrelated to this patch that LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> qcow2
> M: Kevin Wolf <kwolf@redhat.com>
>-- 
>2.54.0
>


