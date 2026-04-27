Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EDDFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIpf-000505-S2; Mon, 27 Apr 2026 06:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wHIpI-0004uR-7o
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wHIpG-0001aH-6p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777284265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2dgm4HF15FHe8gkwxTet9JS4hgj0+qdvbuXVdEmCCw=;
 b=GGXEtygjJVehj3svVpgwNwqDd4hwLvKVsE58CQYKGMjirc+C8okJeebYu95V3+NGcUMFEx
 zuQ/L9T9er5ke4AVrFUiMebyHzSRgqb94LJwuAZepUVgxHVLQCY0Bt7aXWtjSUT05VQ9eB
 uXq2ocniLcpTbzaAgV8ud5CKy3Hhewc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-aHG1XxINMH2Oh8ooLqJuxQ-1; Mon, 27 Apr 2026 06:04:23 -0400
X-MC-Unique: aHG1XxINMH2Oh8ooLqJuxQ-1
X-Mimecast-MFC-AGG-ID: aHG1XxINMH2Oh8ooLqJuxQ_1777284262
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5adc12ffso36712485e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777284262; x=1777889062; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X2dgm4HF15FHe8gkwxTet9JS4hgj0+qdvbuXVdEmCCw=;
 b=V8f+8mRir956c30qPHou1E9HJdynO3G1rIQiNh02ja9EtFrZYLSigeTw5m1U8uEi+4
 Yncj3Hh9Fa2kOQXplbnlLdpfYbvdaqPTsyQxKggGMPnK7B7r2cpCzLgnmhyXtDmHUQXg
 avrZey8YUC7k4qqI9UjEVSlqXNigQK/q9DSYQG3HfskIK/gaIFvTzEXn8GJpAXHsLHke
 vkPM1MJLIculB5YORIwmEQb0uGnYun2xucwBKz79RujdVl/dvWtNio0vNMglLBs9N/rj
 vd9EVBy8BnTemc2FlxgyXL3dZTowfIh2qrsTw0EQjEtFhJtKcPK0kd69MtEtgKfysC02
 WOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284262; x=1777889062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2dgm4HF15FHe8gkwxTet9JS4hgj0+qdvbuXVdEmCCw=;
 b=r+u1k4wCQLoxgWJGAFyPWNZiGyf7XhiWX5J/UxqSKBGrYsR664dpkDJIM/DyVQ8SyH
 apkhXBq8FM38AZxOWOkQjdx6D8RzFWJVCuBxALMyKM7e5wIBLxnyfQJZgZK+vTEyStNg
 ZtCvMh1VBNcu01J6FJ9LrKi9PFL7FF1eprD8Yk4+zXWP2DlCH6x/lt1WW4fDgL3HPu/g
 rQHGpU5AEAaS0VzJbz0ZxhZRCIH2pm4oawBK5mmwXYORCZ7Z/9HRH1Ml6H3bs6HA5pPi
 0reswBayJpq+c1bX1pNP9k1CvalYboSjU8oOiCG31IXvAkTTht6snWBd3sQFh6JxYDlL
 +pDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LSu+mSo3icjZWKrcNIkrg7X5SmTp6ezJz/Z0RPeAuQhvMo0HX3UYQVkNns94IToVm2yURI0gKBCE0@nongnu.org
X-Gm-Message-State: AOJu0YwpFuF0C1oLi1lMSnK69p9DUab1rRFqWK/zkPXWXD9m8K0VS2qj
 NlEpHjRvW6A913wjjxGT1ZGRspwhXBmzNOa4B+e+apKzBqZ1UG0uoTxMUZWmL5Xxr++1fC8oHKf
 Y7Qww5xHerDVMgusS3IBwh2f7ZFITzYKeHI8pI2vdyQ/iFeKQtbOa1b3G
X-Gm-Gg: AeBDieu1Ypiyj6dsSTHXFg9gboY9Ip9F3vUIEM4P6AabubCuCBJTKwamA6wc14zX+be
 EBz1jCBRGtAZS+9wIOgDXHnxAiRaGE5gl738OyAYb09jynb3QJd8NSex/2yWxbk9+x+rYLjo2KY
 XOnT5Sfj6xSJ63OViRCrcyAKZc7Ajvjfk+NTkE7jqtg3hQOyXR2XwTVKavKLaiL/clGhWNXR6Mv
 s06nVWd3+TnoD3U4UVUJAIcxDiYxbg+Ie101Gv4oWVM1B5vtD1q0E6ktBgKsoBifgLThciBJwCB
 DH7EjcXHCAnhjBceOHv7JOpYcUjAcBUq6ovuDw6so5KzaH1EwZDlkPReKTC/innpa/EmTedearv
 5f23jhjS4j4k/I/hYZ1vJrewfVyL0QWPkJqhHg0H1sy3HhJ28Iqwna50Z
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-488fb74fe74mr482700795e9.10.1777284261939; 
 Mon, 27 Apr 2026 03:04:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-488fb74fe74mr482700485e9.10.1777284261412; 
 Mon, 27 Apr 2026 03:04:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c24d82asm181779665e9.7.2026.04.27.03.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:04:20 -0700 (PDT)
Date: Mon, 27 Apr 2026 06:04:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Sourish Dutta Sharma <sourishduttasharma770@gmail.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com
Subject: Re: [PATCH] hw/i386/fw_cfg: Use g_new() and g_new0() instead of
 g_malloc()
Message-ID: <20260427060403-mutt-send-email-mst@kernel.org>
References: <20260224160020.137036-1-sourishduttasharma770@gmail.com>
 <883bd7fd-a9e2-49e3-9198-8333825f8aa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883bd7fd-a9e2-49e3-9198-8333825f8aa1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 27, 2026 at 12:02:57PM +0200, Thomas Huth wrote:
> On 24/02/2026 17.00, Sourish Dutta Sharma wrote:
> > Replace g_malloc() and g_malloc0() calls that calculate the allocation
> > size using sizeof() with the type-safe g_new() and g_new0() macros.
> > 
> > This aligns the code with QEMU's coding style guidelines, improving
> > readability and protecting against potential integer overflow
> > vulnerabilities when allocating arrays.
> > 
> > Signed-off-by: Sourish Duttta Sharma  <sourishduttasharma770@gmail.com>
> > ---
> >   hw/i386/fw_cfg.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
>  Hi!
> 
> Thanks for your patch! FWIW, fw_cfg is not really my turf, but since I was
> looking into malloc() related patches today, I noticed your patch which
> seems to have fallen through the cracks (sorry for this!), so I picked it up
> and added it to my latest pull request.
> 
>  Regards,
>   Thomas

Thanks for doing this. FWIW

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


