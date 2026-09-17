Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F23BC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76oA-0006fT-53; Thu, 17 Sep 2026 03:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76o4-0006ex-PG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76ny-0005Qs-MW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1TA90r3YZcKKDONnLeduSBp3vj199eApS6wzkY4hSlQ=;
 b=fJMey4juAthXE/HSMWKaixkP2NFxMj5EM6iGR1DclR84LZk1+Gh1+GgVUXepLfBJQiJh12
 iZLSzLQQi8tp4OOdFev48+La/3zZU6g4f0oGAAfaA+R2IrwTVjX9LxDLoUtKtVE8NHKZY8
 NbOrm3+YZI+o9E0IyI7SoplAJka5yVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-7BA1Afs1Muq1u-Yc6nu0gg-1; Thu, 17 Sep 2026 03:45:12 -0400
X-MC-Unique: 7BA1Afs1Muq1u-Yc6nu0gg-1
X-Mimecast-MFC-AGG-ID: 7BA1Afs1Muq1u-Yc6nu0gg_1789631111
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49d0ae342b9so3333685e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789631111; x=1790235911; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TA90r3YZcKKDONnLeduSBp3vj199eApS6wzkY4hSlQ=;
 b=SYN3mVMNArIVu3FUM0WTfF+zLrDsMhcJHFdBk6tmul5mKltAW+y1Hb7KtWiAxtrqJO
 57okXsT8ONd0M/J+/SpZQRwHCIcJbab7SXmNtti6W4Je+ZSXsMXk+843KJQIDD8JSPks
 9OmM7Tpy/BI5RIegnZoC081F/EgLiPzMbH9xcG+KT70t+79iXMlbjyUX4XsvsKW/0kR1
 9EUHlp+jz2FAajyk1cjyrLI8AlrTSyTSImC4oH8fZ5ygwLYjUvKJD925HsQ7Vctqqh2M
 xHsUapWX9szMHGgEFvm8ZvNxULH4IaaHaOrsWrIJDnzUwd3QmL2Tp9SAspou+Up1FfgF
 TDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631111; x=1790235911;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TA90r3YZcKKDONnLeduSBp3vj199eApS6wzkY4hSlQ=;
 b=KbWCrmOvKRN4w6xhWVwHoYeHs/D/DMFs7g88+e0pNsOLAojFptRdBowkA5wZ8SvuGL
 B7SaZKSz25zKrNilnL3yQ3FhT0fpx15sXKfiN28lQBXRW8ZjOcu8NakC9UPcVlw9g/Uk
 BwI2wZ1RoW7+ODT+jGflcGynwFeIX/oYo4+qbMqXxHPbKMoXW+dmZqEXFKZVrFSaL5yA
 T9qvPgyYZ8qJ+s2miZZFDcWZyKsbO3RNmufF2nh7dB6ecS308FPe8YowIO2W3pPvAItj
 U/36o8EaS5rc22e3A3ejGj+qrY+TrS7uQYqQplBtBeAnhZjeyywK8qU+Sqs051fkh/U/
 vZMw==
X-Gm-Message-State: AFuF++l0fbW9YJr2kqMu3SNbcGqBbDjIwcNWZbA4AZm8hm8zGH+VAnz0
 rvRddB27fdr21PsgYRgT0snz5K3JSNdytOgON2/w1SoRk5A2Tka1EM8caDVfrj8p9QFH1D7xT08
 sb3htzb7gzubE4ayrw/7JXKh88TrIIYtd/KgzxmSsx0Q59RE/ONfH+vkZ
X-Gm-Gg: AYBFou0Mp03Vv9DbXJW01oUe5+f44YlvdajAsTBkNk7qtoOSwsvA7kK6tUUCvUj7vfo
 KPBubUBoodDOZVtCZql+Tj90spVR540m42JiTI/QkZZrl+40BidVzFKkLEhPCHcbpn3fYgmX7ag
 d2j+rPo6ujva6d88kYSsz8MDVa8bCSvgTGIStC6DD0O7+idZYdolVYJFI3RQIL1u6BvRzt20JXy
 zjN+GkSb28DGmTM5kdSyQif5SyFplW/z4nc5njA+513LTRrkWSeXrfU87uZd6u9Onc8i+njA4A6
 Rk2FtxnsmnFkes7tdh/wyuM78K7+1Gv2+TBZjlMbqqAN9xWdMwKBEKNY8xvCZ36bmehSUdSYX8n
 c1jUXV2GtdYo/bQUzHo9VkBUmnyVq4kizf+JPtVd8j4zavQ==
X-Received: by 2002:a05:600c:6290:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-49eb732cd4amr62421145e9.18.1789631111059; 
 Thu, 17 Sep 2026 00:45:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6290:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-49eb732cd4amr62420905e9.18.1789631110571; 
 Thu, 17 Sep 2026 00:45:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0d0bsm52941655e9.1.2026.09.17.00.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:45:09 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:45:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 1/2] igvm: validate and honor byte_offset in parameter
 directives
Message-ID: <aquadMIKhr6eUHzW@sgarzare-redhat>
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
 <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260916-fix_offset-v5-1-11cf8ef37854@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 16, 2026 at 05:10:05PM +0200, Luigi Leonardi wrote:
>Parameter directive handlers either ignore param->byte_offset,
>overwriting each other when several parameters share one area, or use
>it without validating it, letting a malformed IGVM file corrupt QEMU's
>memory.
>
>Add qigvm_get_param_data(), which validates byte_offset against the
>parameter area size and returns the offset-adjusted pointer together
>with the space left after it. Convert all parameter directive handlers
>to use it and to check their writes against that remaining space, so
>that no parameter can be written past the end of its area.
>
>Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
>Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
>Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 89 +++++++++++++++++++++++++++++++-----------
> include/system/igvm-internal.h |  5 +++
> target/i386/igvm.c             | 12 +++---
> 3 files changed, 77 insertions(+), 29 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


