Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB48CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHK8-0006Iy-F7; Wed, 27 May 2026 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHK6-0006Il-KT
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHK4-0005Yo-FO
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779900076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5mUaX5/aGiyG1uHfCheFXFRVeRJzSAqsdfAj8UK6jQ=;
 b=Ha9ultwURcnKI/WyZlRKe/Pu+lkoTg7orJ2K1pdQCzKHVaPPDeosVpPdtQUvx/B+Z+WD1K
 S+BpJbj3nIbe2bwgzOJWTXVYqLYaF7shfcV7X0kPNaQFlUm3+nDHmpXkbd0MeYqtCifneo
 Oa0j6Bo3Q+hp6GqGNZPymo4ilo6Wt0o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-h36KQGkUPr-FUa-eUpwykQ-1; Wed, 27 May 2026 12:41:12 -0400
X-MC-Unique: h36KQGkUPr-FUa-eUpwykQ-1
X-Mimecast-MFC-AGG-ID: h36KQGkUPr-FUa-eUpwykQ_1779900071
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fdad6cce4so59879095e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779900071; x=1780504871; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X5mUaX5/aGiyG1uHfCheFXFRVeRJzSAqsdfAj8UK6jQ=;
 b=Sx660lbD8+7d909UvmeutZzSn32BWzeABbVnzRVY3Ay5KGFr/Net0I3mS/HDymiqo4
 QREpMvo9lDnsrVBiNisVSJl7ApJHD3BjpSLmRT3UgIZ4+3mUIVhcEGM6XISmJd9u6ZXm
 rDJ9jxXAyOmJT89Ndvk5M7z2mFr5ZM+Byerpkgp/ud8cs7buo3KoHIELOtilpSyzxAhz
 tChrDwphXJLNHfdpdBc050nmBmyC+YtW8T47nWrIg9Fygq1UsmJqnHiA4ivZaGzW0PXl
 RbqrNHCBw/6CboLAbMIp+pT+sOIrVyQNgXBvK/Mgou+iTVbTFkoIpSyWJGL22Gn0/i6L
 25CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779900071; x=1780504871;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5mUaX5/aGiyG1uHfCheFXFRVeRJzSAqsdfAj8UK6jQ=;
 b=EgB+67na29qGM+0Z55Bld9l6TphM3bTPXFmzqFnS0meao4A/qMZKh/EH5IscV9PYxf
 doaEYbnP+6BnS19htpE15od+RI5Wr9aBQTS0yPssB3Q+VnCUwNn3TWvmBRCZ/oqW/s9f
 A+zP6vR7NNJHWYt2N7hfqWptHYiiVYNAltUCbOmyw52L0Q6UzJymuJEavIxaBjSlZoGI
 0WuE/jwLpSSzz24moz4AZ1AeacOWwg07BDpajVkto138RXvQNb7uAfIUzpf9xt3UOyKr
 VVaLPVd3AbcKTbDfZQEw27sXRCGjGnwvtDMDdTX98cPvJnpYFRNZHGAEkwvKJKAKvP/P
 vAPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pvGY8yQrAeB7mrkCW7jB1wr0GKa/43BDmlevPpx35aVuhCz7E6ckt9X7QKTQatjFhO2EEd9xdZ16d@nongnu.org
X-Gm-Message-State: AOJu0YxZwqrElj7R2MJdSYhH+w/SyFbCB2+oOn7gtPgk247/JbyHbicS
 ASBrbp8UVnUEE0/mq5vkpKXww9MhWYJ1OtISZja3NedpLe6xJR4P8bgcYwBjOcFbZQ5XM8j0nGp
 gDGRQNvdADnJr531bolSjnKmDcisD5dZQmKc8E30QciPckw5y6IR1diHpa3cVpZzr
X-Gm-Gg: Acq92OGHdCBD3yhHeBeTTadvckpHrwgb4Sjcnf+RVo+ygYmNnGxnTMnO3K1S3Sthyl9
 boougsb+waDFI+KeasJxIndJ4D5TJdVrwHnUrBh4m4I/drqhEZ5LdnvG1jDzlS2PjFJLu0PKqGr
 92CtCZ+xnOYsHoKeqxeDs96vZZOuGyMNWj5roctv//Yi2423JHQOdRqInpqRsuf1vUOBNZO65s6
 f6Zm7Lut6JZSP3mT2q5Vmqw+ggkYSLLfsXTV3k4pOqPW5JAKULOE7tfUJ/rbHjYbT2rF3eBbt9h
 8jo+tRgByuTM0p95fNk50361xN8keeSHnCIWR4L1ulaNr6+RNGWMo42DdisJ3l59Oku/TeQ4A5D
 cxq/Pxnt5HMJM
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490426b0c92mr282552515e9.16.1779900070757; 
 Wed, 27 May 2026 09:41:10 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490426b0c92mr282551535e9.16.1779900069431; 
 Wed, 27 May 2026 09:41:09 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561f682sm428803485e9.13.2026.05.27.09.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:41:08 -0700 (PDT)
Date: Wed, 27 May 2026 12:41:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527123942-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcE-pDc_7tTrsz3@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > On Wed, May 27, 2026 at 4:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > Commit messages for AI-assisted changes
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > When AI/LLM tools produce or substantively shape your patch, add an
> > > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > > explanation in parentheses::
> > >
> > >      AI-used-for: tests, docs
> > >      AI-used-for: code
> > >      AI-used-for: code (refactoring)
> > >      AI-used-for: code (prototype)
> > >      AI-used-for: research
> > >
> > > The trailer is intended as a clarification of your DCO obligations as
> > > well as to guide reviewers.  It is not intended for minimal presence
> > > such as autocomplete or asking for a pre-review of the patch, and it
> > > does not remove your responsibility to understand the changes that you
> > > are submitting.
> > 
> > Why invent something new here when Assisted-by: is used elsewhere
> > and is likely more familiar to other users.
> 
> Because Assisted-by: gives different information, which at least to me
> isn't really interesting at all. It's much more interesting to me if the
> code I'm looking at is generated, or if you only generated the tests.
> 
> Kevin

I personally am interested to know which models work better than others.
Contributions are about reputation not just code.  I'll learn which
models produce better output, just like I learn to trust specific
contributors better.

-- 
MST


