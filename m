Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F77CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPo6X-0006Fa-Df; Wed, 20 May 2026 17:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPo6N-00069O-Do
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPo6I-0008Ly-JD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779311108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJtmFgLzK9kfBDWm4yDLTjmsni1UTJ8ZnKX7tyfPuFI=;
 b=GE8WvxVU5rBg+2cYkstkpgL87z59XDTagY0OBRVVEJuDuNt6hLCt+jICExW+Ux/eyVWaKh
 T0u0HW/lEkke6xxsCrCafICCR6HW2QHABl+YoPeoNqDke29ELIepDP2CLCR2QAkZ8vbA0b
 st8zD6JZrKnDdCjOGRVVtwKZ4T+U9VI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-22Gkw7VcO8i2PaCjAfDCZw-1; Wed, 20 May 2026 17:05:06 -0400
X-MC-Unique: 22Gkw7VcO8i2PaCjAfDCZw-1
X-Mimecast-MFC-AGG-ID: 22Gkw7VcO8i2PaCjAfDCZw_1779311106
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90f03c426e7so944403085a.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779311106; x=1779915906; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YJtmFgLzK9kfBDWm4yDLTjmsni1UTJ8ZnKX7tyfPuFI=;
 b=eFN9Pbdw9vwvI+VrvWDUuWkYhb+WKqz6h6Pz03g4UkB+3eU1jGJvKGtQj4RccJ32TU
 qwmNo8D3KJxm9dcnOLcJMMjiMM6klahUEij32WZsL6BeBCCKh28imQ81GKkSB2YrXw80
 gyxHIx0WnEUlCBUFDGOssNhIvWcujA2h1AYxt5BKSxyXbo5LwU4d2oX2klI36MG+w1kx
 m6wGJVqr49e8p4Q+Nk8J8T9e5KGqm62FsS/eBllD5uWF9MhVYlEBtHT5ciHx5sXzsMf4
 fbJeEwAIzOCSorogskBbHieDMlkNac7irl2DjttXOo/nlRUuqfLbreRd8gZNdHJ9+Bcz
 XtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779311106; x=1779915906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJtmFgLzK9kfBDWm4yDLTjmsni1UTJ8ZnKX7tyfPuFI=;
 b=ojyrRHNVxUtPjtR8aUnI5mKbXxPSN90LMBN/pHeGsmZLF1dw4tuJ1fGiP2ldus7M8z
 se3A9ClNdF9+g9ixJmVW4b/CyM+7raPx9bsHEvztVojpCGBmYACy/B4Ar8JT7CaPxGDj
 +1o1tEZLCrvR7Qlo4Mcp3wkF6zkj1ccjMo44l1S7ER1fUzOFbDFmkrn2cmTJJqB0qPeP
 z3+dlUmVnVMZsm3/o/VXxsP6+xIBjtc6uaeeD/CJGr7gdTJkNT6eGZ+SWCN2S7JmlbEX
 j2rSTEK77ZtWurMXxzpsWiqoxZp7TfKYlEUj/6I90nmTJs39eN4W1SK6v/MTHGOJvcof
 Lc7g==
X-Gm-Message-State: AOJu0YyPE3hoT2U577X5t1d7SZdHR8zpW1EQ5IzBieg+ZMXCBogS2s6I
 2OnuSXuXc8hVtVcToM914jMsbdCDdh2FzoIKWAJW/P96o2Y1odKMn6ZeR5xBBWqd8wzT77+Bpvu
 9hAfO4Y6YqvN0UhZhRR4zb9fYyrG9CqywDkzhtKZzHAStbbRxu7RnXDf3
X-Gm-Gg: Acq92OFYvAKXyTv5bvIRYyriKDefu8mja4xwb3wgQoLHjdat32sHJEUU4aGi6Wdk9iA
 TffFDOO1cSxPFzYV6wshRjPFyl1hIE4R/I+GFzSocDYhgMT5BFUMjT0bFAH/U91HSdXVJk+zjVr
 xFRxcbkrCx1MbybTkwQ9PXlVEdkQhQqUqIKVsCiGHqn/YNWlgt+92MnffvrBe6ZYicLP8nTfs5a
 Ob7m5l6kykeBZJY9aNuO5geGyt1PQZdXjYvOh8ObQxVrgTIHdKMLA/LeA0d5gxcL65hw7dE0GWX
 git1op0yuCYNpThDFzTpX61csanFiEr+u62qVrsFup+oqX12TC1aDS3D/BwoMomL4LoZf0nQ7sa
 3c9E5U5ABWblMQrihL2x/cF/4Jk89bY9oYFtNWBmivdMiMdY=
X-Received: by 2002:a05:620a:199b:b0:8f8:cdd0:df80 with SMTP id
 af79cd13be357-911d0c5b55fmr3993905085a.59.1779311105754; 
 Wed, 20 May 2026 14:05:05 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:8f8:cdd0:df80 with SMTP id
 af79cd13be357-911d0c5b55fmr3993897785a.59.1779311105192; 
 Wed, 20 May 2026 14:05:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba9454basm2264780185a.12.2026.05.20.14.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:05:04 -0700 (PDT)
Date: Wed, 20 May 2026 17:05:03 -0400
From: Peter Xu <peterx@redhat.com>
To: infra.ai.cloud@bitdeer.com
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@bitdeer.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Yong Huang
Message-ID: <ag4h_-o7u9-0pdqN@x1.local>
References: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
 <ag4HBdzJXGdKgy50@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag4HBdzJXGdKgy50@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 20, 2026 at 03:09:57PM -0400, Peter Xu wrote:
> > @@ -3784,7 +3784,7 @@ F: migration/rdma*
> >  F: scripts/rdma-migration-helper.sh
> >  
> >  Migration dirty limit and dirty page rate
> > -M: Hyman Huang <yong.huang@smartx.com>
> > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
> >  S: Maintained
> >  F: system/dirtylimit.c
> >  F: include/system/dirtylimit.h
> > @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h
> >  F: docs/devel/migration/dirty-limit.rst
> >  
> >  Detached LUKS header
> > -M: Hyman Huang <yong.huang@smartx.com>
> > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>

Both addresses are wrong.  I think you typed one more "i".  Well, I
enriched my life by finding a bug in a maintainer file update..

I'll fix it when sending the pull.

> >  S: Maintained
> >  F: tests/qemu-iotests/tests/luks-detached-header
> >  F: docs/devel/luks-detached-header.rst
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


