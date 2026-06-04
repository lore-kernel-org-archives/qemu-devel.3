Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDAACD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7yY-0004ie-CQ; Thu, 04 Jun 2026 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7xz-0004ah-Tk
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wV7xu-00056f-FK
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780579109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvCxTQw9ovB9wOhjJPcWh5M8dH+iDbxIEU3jgUeJjjM=;
 b=azvWmDkkX3TM4WVeQ82xh6n6xus158uGapbXB5+fKCvB0q/Eb3+W6MGKTLV/xozTiiBwQ6
 y678KCpa35znbv9G3GSeGQnMoEW3EFHL1glwa5wPl9wTfAZxr2mes2H6oecrChHe50Vz7E
 NVeYJwM8cglZO7bTAJwXMsQuWtnSc3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-HVsopveAOwW8BYZEsHTPwQ-1; Thu, 04 Jun 2026 09:18:27 -0400
X-MC-Unique: HVsopveAOwW8BYZEsHTPwQ-1
X-Mimecast-MFC-AGG-ID: HVsopveAOwW8BYZEsHTPwQ_1780579107
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49048e21ea7so11979965e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780579106; x=1781183906; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wvCxTQw9ovB9wOhjJPcWh5M8dH+iDbxIEU3jgUeJjjM=;
 b=tACdI4JtA/I86ZqiLfo/Pmq09OarWOTJR6o5QPdWjaLnJ8iysWgWzUe2oXcs8cCzt2
 /jK9Zd80vZWI9MVH9wH1ALTYYyHjNxs3xHrU/mmjrDqmU9thxH0yTCaZlOIORAv4Clbq
 sGZveeMBGrCdqNVsDD0ilXh3F49rCEDE+MfbHC4dzfyLZmCrKNVTR2NMuz74J0Ncl67i
 NQ7OHCVlR8+jJ6eH3vcBL9bPLn0ty7X4iSrud60QqA60MlD5XeF4m1EPXm7Ji/7Erd1h
 WjfLr4sKe4Zx0MgMwH6rkJF2d9tUx8fYv/wT23iw/P3sciirQXwjxBFdDx0Xe0y2Ql3e
 PEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579106; x=1781183906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wvCxTQw9ovB9wOhjJPcWh5M8dH+iDbxIEU3jgUeJjjM=;
 b=mYQIfaIm8yR1hjaoQiHE9aRbFB6ftGgvs5vZWmTzKohWPAEd4dDmW4HsJRpf303ZLp
 LuWpbh7iOhk8WLCF/uR6Zj4XiUO7eoyLi/1ODaCcyZUEE/u2pEL3zI9AZLgzI7Pzhh61
 fxQ1v1igkl2ANWKFhAZViJzDXe6/dsmzdTSNaOHxBmZxN5tu987STzKVZp4ntHw5/Jo6
 JiiaSfX2e0BL1+jz8naKdQqKzym00CnC21EWS/636hi30uTHpD7Ho0W+gCYG9D2meOH/
 I2azgomfuOP+rdDQMToWYXI3wLsOtwY7h5uQxeGGX3GuTSKTKpajV7u/ceTAjoA97hBL
 +WLA==
X-Gm-Message-State: AOJu0YyFK1jroBKap6yXk5XtRWOpXvG+FucFP2Qs/Cmhtb9qILvC5u4w
 3aEGKu+v9hJ+coJ8mQzECwI2BGClaKAgCVPwjM2H98VEZQ/2OPC+Kpz8tKZpKHlqNY0zf4T41sV
 RnEXDtYCV4KGW3IjcvPwicVkcOEtQIHDjXNgN1lgh2aqtWV5XUsJu5P3K
X-Gm-Gg: Acq92OFppQD1xVGl1o1Tt72/XCBUD8dFSj1R8ISHPIqFYuhT7qTmJxqKjHgayU6aLxT
 8OJZldznYCyQl9GCHxO2Q8+SPBfdLIorkuY9Vl+Xi0d3qRVRRerxrPP2MSjYa27vQOTduo7JUGo
 5U5NE8EjS18JfpmYHaDbYVFjxg1DizDXZORrEj6aJgdjC/pO2iCyQXKVzVLZVi+FUGh809Uv68+
 HzeUkrVd8pvmodUWmLsUn37IH2YibylmlKfzcPSxPzoinhdpZe0HBbUZ/9Fk3PFOqMDzc7vFTKt
 lhYS2yGnMr1Peo17jyK6Ksqa0EYsHTjhZrL3VAl35GKOw7OtQ7xZpSyxs1DFJph/oScvcdhVcdV
 BlwKZ+LV5fYb9O64n6KL19i9wVRmzYKLNe6bHAZZSRKdzIRXPVNIWcR2xk84vl0B3N2+xtvbARw
 2IyoCdRg==
X-Received: by 2002:a05:600c:4453:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490bc50dcecmr54374555e9.16.1780579104826; 
 Thu, 04 Jun 2026 06:18:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490bc50dcecmr54369595e9.16.1780579101811; 
 Thu, 04 Jun 2026 06:18:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918d7sm64292175e9.2.2026.06.04.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:18:20 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:18:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove Julia Suvorova from Linux io_uring
Message-ID: <aiF7Dx84EoqVXiZg@sgarzare-redhat>
References: <20260603194732.79041-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260603194732.79041-1-stefanha@redhat.com>
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

On Wed, Jun 03, 2026 at 03:47:32PM -0400, Stefan Hajnoczi wrote:
>Julia's email is bouncing because she no longer works for Red Hat. She
>has not responded to when asked whether she wishes to update her email
>address. Remove her old email address for now.
>
>Cc: Markus Armbruster <armbru@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7752917d8c..738d084b1a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -4346,7 +4346,6 @@ F: block/file-win32.c
> F: block/win32-aio.c
>
> Linux io_uring
>-M: Julia Suvorova <jusual@redhat.com>
> M: Stefan Hajnoczi <stefanha@redhat.com>
> R: Stefano Garzarella <sgarzare@redhat.com>
> L: qemu-block@nongnu.org
>-- 
>2.54.0
>


