Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837CACD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjbE-0004gc-4c; Wed, 20 May 2026 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjbB-0004Xf-JB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPjbA-00062X-62
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779293803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0aP2SDjJ3QP/hvAy50J0j6mqmnpEb8QxiOrOkS2SAA=;
 b=M7f6lVS+aae8dgOzmZhPQDI8XX9UcWWWuNrVx3jSljERJlBG4OFCTrFi3dZiVABNcRvJ+Y
 rr3CsYjvgM5n/b8eYXt1jjDnjsGq1+Mqftd3mxosJ9hFtdM7fuzKc3P2svXrScWyEk2FSZ
 oE14OCKPm3SH/yh6PtNvKRlo5TDcEdU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pGfl-8-lNrK2yashwBw6Xg-1; Wed, 20 May 2026 12:16:41 -0400
X-MC-Unique: pGfl-8-lNrK2yashwBw6Xg-1
X-Mimecast-MFC-AGG-ID: pGfl-8-lNrK2yashwBw6Xg_1779293801
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-439b8d149bfso5355883fac.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779293801; x=1779898601; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y0aP2SDjJ3QP/hvAy50J0j6mqmnpEb8QxiOrOkS2SAA=;
 b=GSWHPh6EUOf3cSDo+VGRJ2bYah8wvLwZcGFr/tOc0GNbAYOUoQgNa409NZX1fVC2fm
 n7ayXeE5xAPrbuPpYTY0Yrn9nNv4wpJZifhX351RbVM16HQhTlkyT9ilTBfMjdxCMPGd
 v+HXIy0G6lwRn3wNISMOQ+gxyF/+bH+1a/Y/V4DAi8JkDZr5EOgTidvlejGAttQ93x2s
 RUi5yAF9JNQuZ5aVGLnFxAUTs5BkI5voMBtOkNNS8v5+IulPnzBWz8GwNBx88OQMT7Lj
 VBrFGpJJ7C88NVRn/kXrvqPm03oD5BVdSmiWBOkvm+kQeyT4Opm1EeO8PkplS0zhvL7Q
 LKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293801; x=1779898601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0aP2SDjJ3QP/hvAy50J0j6mqmnpEb8QxiOrOkS2SAA=;
 b=Ay+vEIh6qLBo5y/IzVn6Q9KTP2zEMjzr3uu58YQR9zxO8scfRvYeLYCYNhP6BzHRPV
 99QU9i5gNeFbK4beq0Fr44Dmftgp4S66oo68y073b5ALI05lrW/iWh8wkiQbivPqJwqV
 lXhy+5CKFBSjs4baQqlvKkQNnTYx61O9joywwJ2Dbs5+VSJx898TiqBTYJLTvKUEBO8v
 1u5THq8dfYxsPrV9ev5g19w+iJuy2+3k0O3GsWovUyZVJ3n22y1AyafJXGJv/my78sjX
 6NRs0fqzIlCwRvHmYa0oZOvzmc8HhpRrk1WIz7qH+I4jN1e2Q2GOPf+Z1bqGLnpO6pSy
 HyOA==
X-Gm-Message-State: AOJu0YwFcmVxZA6rWq31H4qEgOwnoRsn1eBaDDp/6c5/3sYYQb1sGhSS
 YJ7Bsx+qbwEAL83G6gvaFsSF2o2DiCzlVyYxy5+yAxSc6qmBr4Scvwt/n5JhulC0W8x2D8CGPgn
 NfG/b0427YsqQKEDQVOtmw94Bn9XGqnQAgoY/5g00uI+Fo0yetXxBFpJ2
X-Gm-Gg: Acq92OHB/Ak942TYnYSiAQop/mVWaW5ylp9eVhB8YjT/YGCnBn8jO05zQetbJbiYk5X
 Epy7c/XsXMCDqSTDUsb5mlIF4BV9T5T/U/iBYgRqhsGjbIgdgkc8IYxziuxWAwnaqkRuHm2TkDB
 jpsnf8sGYL8zd714RkFpD1zczKo5aetG40HA5EE9rpyJkD73/reWkLU+xP63DTKimEORbIZOzus
 BSCr5tLNAjwAdteXusYB6jGiwtTXhCiunNTiTNQtWUSnzrnCty9iGBazVMRbMT5qgoyLiMHgvuV
 V0p/Os9rYX+uQcy4JfJw1GVPRlALU6+jq0KhEafToXp7C8zocGTYRBRLDDaphhUXbfLQVpSVbez
 TlGi4sF4TORHbzWfc7V1mQ51QRqV2KX6SOpTl412hND99pkc=
X-Received: by 2002:a05:6870:a196:b0:439:f092:8394 with SMTP id
 586e51a60fabf-43a2dcc70b5mr16586645fac.19.1779293800632; 
 Wed, 20 May 2026 09:16:40 -0700 (PDT)
X-Received: by 2002:a05:6870:a196:b0:439:f092:8394 with SMTP id
 586e51a60fabf-43a2dcc70b5mr16586588fac.19.1779293800128; 
 Wed, 20 May 2026 09:16:40 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba36d137sm2155330885a.1.2026.05.20.09.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:16:39 -0700 (PDT)
Date: Wed, 20 May 2026 12:16:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 09/15] tests/qtest/migration: Remove multifd
 compression hook
Message-ID: <ag3eZtEOhmifKw17@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-10-farosas@suse.de>
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

On Tue, May 05, 2026 at 01:09:08PM -0300, Fabiano Rosas wrote:
> Take advantage of the default compression method for multifd being
> "none" and remove the common compression hook.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


