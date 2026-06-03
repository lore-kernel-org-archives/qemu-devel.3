Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26A5CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsUm-0005Tl-5d; Wed, 03 Jun 2026 16:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsUk-0005TM-Ji
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsUi-0002ie-Oy
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780519639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDR5+lYyk3z/GesgUC/50RweQqLYHp/PxYmcD9eHnJs=;
 b=CDLnxipmJLPHcXeG9bxana5m7UEAbCfPwbqlWUe+kKxXx2Kvays/FJTqraWQ/8VZzRkjdq
 dXoTPOqCRUZ4daDmeHNVIAou0bm/JGmR0DaBcgR+GGuT3jPYywL1Ivz1Xu0wZ09kiH/oBO
 05dtNvL959m89+WEE51HOiKwkiFZ6Co=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-RWxDXR9lNTqq-W3h5tVhlA-1; Wed, 03 Jun 2026 16:47:18 -0400
X-MC-Unique: RWxDXR9lNTqq-W3h5tVhlA-1
X-Mimecast-MFC-AGG-ID: RWxDXR9lNTqq-W3h5tVhlA_1780519638
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177f07ea82so25224251cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780519638; x=1781124438; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDR5+lYyk3z/GesgUC/50RweQqLYHp/PxYmcD9eHnJs=;
 b=ArCkbbSaM0gtahiQD9AXQLeilOCBe2XrKbvkkAFSNl/MMaLqNBu6FCXWI+uys767uZ
 D2MO6l0G5VATRrIRLW0JpX1VeUpDihmBoo8vhGPQ6pa7wgPVU9JGK5IlYIabnGoSqOyY
 uRcs03OCHk/Q6ydvkQ80KWXCrgD00wJRxqgQ7tyk1/WDCxMRufN9lQavOQEzStwWEVCG
 nn5E68NZg6esvATFcxpFKC6wSK6XwXSASLxUipxdYnybTVf27MV4AgwcXz8Ndww6kyGA
 XPugMiHT0Y/623S4g25lCMrJnQ5v7LvQe5ZYCRB8BkTm9ifmJRSiVCVlZq0hSfC/PYrf
 zCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519638; x=1781124438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDR5+lYyk3z/GesgUC/50RweQqLYHp/PxYmcD9eHnJs=;
 b=MI1ecQMESCuWX/ayxmZkzB4wAK9LTdfNBPiaH+bTgiliJGeMSsOlqHIE7CqWJ2uxl2
 jrLwoFK0eYjpZto0GFzKq5TuPpozXvbJ3B8h2zMoQ/ikZ5d7sYelM/+5rVCwRd2SzSte
 hWoRtIgSmxD4fruoyys1pX10dCGmlmp200AHZ8SzKZX7ahO53pGjg2YVMNvrtzc0d8qg
 m0NPE8Wxrx447niy0wMUQALkPqXdfE/Dnxgb8L5Xa0q7ZnfG7KKjP5Qc9lLYlkDVRjHA
 izAk7nvwaX091ZGQWBfesurO3uEUt6DwIAL2cpI0iCuITGQbJOZBYixhfzbZBK0PH/Ny
 1MMg==
X-Gm-Message-State: AOJu0YyErEC0ERzQKfJlZSkSVC7cPpmgVrGr0xO1lN5FC0QCkX0TLukN
 ZK2BOZHYBzjjyLykAZdvXaMvkPSYsDigYl5cnEHybw8NqrVA7merwW7M904PuRCi6gVL9n0/Cun
 wcDI4ZUo83UTQQrw4rLkcrZ8YxMiDUMhyPjD6BaSSRNrFQJMu7kaWqFma
X-Gm-Gg: Acq92OHCsEQv1FlBKJZVLZCwTOPUDd3MPuoqvbFBb1N+umXrn0GXaw29zMznRR8sTgX
 Px6tINIUIpprR+7xH8OgaSmvEcd1EaSBXAtAAyKkjJ3lTNL7lmCx/3XJXMa+eO9biOEGdfDI31i
 Oyux7mYiowZE01CycAh9GKzPOxZMhj2mHH0PCcH0lWu31gnTIwEy6DV2U3l/3fRwWFHzTzAiWnf
 ShWhRX8499kXXVQZTFbI6k25ft0UTlitUqj/DqNIwH6x+q+lrsV/PlzXLh/rUbsDGrDRghX5mQ0
 3pwRwHFPXFFj1JgZzmEQqN2gXitJh1MGM/lihwyaBVmiidG6IFm9O6l4i1Cmt1JqSOIfkJlMQz+
 3pQ3j2+1zZbKanp8SZiogLU+eUQ==
X-Received: by 2002:ac8:6f13:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-517787a16eamr71890731cf.56.1780519637944; 
 Wed, 03 Jun 2026 13:47:17 -0700 (PDT)
X-Received: by 2002:ac8:6f13:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-517787a16eamr71890261cf.56.1780519637394; 
 Wed, 03 Jun 2026 13:47:17 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c29360sm32909031cf.7.2026.06.03.13.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:47:16 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:47:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 10/13] vfio/migration: Add new switchover-ack mechanism
Message-ID: <aiCS0jK314MXWRuN@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-11-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-11-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 02, 2026 at 12:26:18PM +0300, Avihai Horon wrote:
> Add support for the new switchover-ack mechanism. This includes
> requesting a switchover ACK on the first save_query_pending call (with
> exact=false) if VFIO precopy is supported.
> 
> This achieves the same functionality of legacy switchover-ack but with
> the new switchover-ack mechanism.
> 
> Keep legacy switchover-ack functionality for backward compatibility.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


