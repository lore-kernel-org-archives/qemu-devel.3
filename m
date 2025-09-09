Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26345CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 21:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5Xn-0007zW-If; Tue, 09 Sep 2025 17:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw5Xj-0007yj-TV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw5Xa-0003Yo-Tr
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 17:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757451971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLAsRt7MAJI4R3q9CPFwrxvphZIfvctuMvdK4/DmUus=;
 b=SdnC+zMyo7tBPbOmQibXllyVMmtI6uJ/14XM5l5HwnHcgZ3OoONWv7pcdtflqf6mXpG2ZL
 prs+v27kQ3XmXQ17NnSQpvrZTMttH6bj/xpJ5Yklz4NBuXJ2fqFMHA/lAQqNRYcaUWWdnb
 nsEoMrE+Y7uvWqPe42irjgCzh8ZDZ+g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-t_wd7vb_Nx2hWWpMa18WbQ-1; Tue, 09 Sep 2025 17:06:10 -0400
X-MC-Unique: t_wd7vb_Nx2hWWpMa18WbQ-1
X-Mimecast-MFC-AGG-ID: t_wd7vb_Nx2hWWpMa18WbQ_1757451969
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70fa9206690so523246d6.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 14:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757451969; x=1758056769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLAsRt7MAJI4R3q9CPFwrxvphZIfvctuMvdK4/DmUus=;
 b=jOKLgvoAIZfCzfN8iFt17/rn3oDty7qx5VpKP9Xft+WGLl/ibryAe1feLjO1Uu2D0I
 /TdLVZ/RhqO0mD/YVmFwDhWNlcQzCzTzWdN54Ls2iK2VpLXWD/KieeRazQZkxHLSsF3K
 JGAIMx7EoPm8V+cWCGzPwNyFVibE0hQF8foWQ+LHXsBM3y7uLpbOk1WajtX0CG68Wq6N
 9XpGYvJ5pTq8uyWuw2gA4pLnlL3fyLp02kY9rVmUgswDfVJR75KfOaceL7CiUhrQBL/b
 YbQLGi4foIMsQLJeCwMbTRoiA/nQdwBoSb21tr6nQYsPxpeUcaX8WaccBN+0MrRTNVU5
 pVCw==
X-Gm-Message-State: AOJu0YypQQ5H/OHRpycptF0aBvyMztH1qIQ3n5tB+rLe6TuXFPIvZU1E
 zSYrsOVt6zH6sDmdAsWG9tABRYNJPkwLQHcpH6oddW5QN0/GWuUagwLnkiX4LX0dMXcl9oyupdY
 JHJR0Q6N4qNcgfpz64c7SzmTI4AplosmKXNBqNyfUqvOsnSWdHIjSbmHPUo6iMeOL
X-Gm-Gg: ASbGncsnHVLMF9ld1zLDJo3SXQAkW9KWT/H843FN2xUR9L3vJu2iayu6FE6ILa04fAc
 qBvX/TMFgChFRWnQrvGP2Arv2dKbTfcPTz7LxnsNqZB5hApWqzQ8+1o5N72kebl4Oar0a7czKKt
 pjKLjEnlGwPfQ/WkUZssxrZSdC2iqr+kFeD8BYyjiphqUQ86L0qpqqN07dM0+ymSELrJ1Ifl93W
 brCxrG0FHY23xkraWMUqzfWcS2tDJSANHx6Q+j4Laju7wO29VwBRRqyDGRJUSnJf6dQmtRbNS8Z
 ipwSq5oJrasmpO8HoH6D7YB4NzE0avictbImPBX3WMJ3yuvxOEFpPk+XALXuLhK3COlO6QRPuov
 bqWy2d2mLi1VMLVBXSXXdkQ==
X-Received: by 2002:a05:6214:ca8:b0:720:e4bd:d3f3 with SMTP id
 6a1803df08f44-73a3dbf507dmr117749596d6.26.1757451969296; 
 Tue, 09 Sep 2025 14:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERfR9tFVblOu0HZ1fY0jFxvFFSpTK3VBW4LMG63lUuJhe/Yy3p0wibnm+Rbn0SZbLZ0hYI/A==
X-Received: by 2002:a05:6214:ca8:b0:720:e4bd:d3f3 with SMTP id
 6a1803df08f44-73a3dbf507dmr117749266d6.26.1757451968881; 
 Tue, 09 Sep 2025 14:06:08 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b683283csm148770556d6.68.2025.09.09.14.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 14:06:08 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:06:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org
Subject: Re: [PATCH 05/11] accel/tcg: Move post-load tb_flush to
 vm_change_state hook
Message-ID: <aMCWvYbDZrOowIs5@x1.local>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906051820.160432-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Sep 06, 2025 at 07:18:14AM +0200, Richard Henderson wrote:
> We need not call tb_flush once per cpu, only once per vmload.
> Move the call from cpu_common_post_load to a tcg-specific
> vm_change_state_handler.

The change looks correct.  Though the commit message here implies a
conversion from per-cpu flush to per-system flush, which IMHO is only part
of the change.

IIUC, the change is better than that, because previously when the flush is
in post_load(), it means the per-cpu flush will also happen in a live
migration, but here AFAIU the flush is only needed through a HMP
loadvm-styled migration, where there must be some stale data in the first
place. In case of live migrations there isn't any prior data to flush,
iiuc.

Maybe it would be nice to mention the other side of the changes in the
commit message too?  No strong feelings, though.

Thanks,

-- 
Peter Xu


