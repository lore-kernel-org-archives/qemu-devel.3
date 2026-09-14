Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55437C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68eT-000861-RZ; Mon, 14 Sep 2026 11:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x68dZ-0007nR-3H
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x68dX-0007lO-5P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789399824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNtH5wTxcL6+tfLz8Ih+76DUyT1jSsf5s4YqsEqbQtI=;
 b=XG880goQS1z6hLA0i+GEcGkDU+jrVGTB201Rcq6RBXD0mYKk63ytFvNjVs0DTP+BpNiuLi
 q6sLfa724+h4ARPk2GM0Yxb+2qW12ZChJvIFk17niuZ8yVk0IEdXidvNp0AVp+oR1FsLEp
 9tJr6gqw5sFD0t6swlLrrcv8V3QjwgA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-lXBCxL2MNl29eZ9xrer7sQ-1; Mon, 14 Sep 2026 11:30:23 -0400
X-MC-Unique: lXBCxL2MNl29eZ9xrer7sQ-1
X-Mimecast-MFC-AGG-ID: lXBCxL2MNl29eZ9xrer7sQ_1789399823
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90ce8ad8002so78527326d6.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789399823; x=1790004623; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fNtH5wTxcL6+tfLz8Ih+76DUyT1jSsf5s4YqsEqbQtI=;
 b=lU4YxI2DTArFG9rT3SKthIp2WuH7kn3cpRFZ+83xav24TWJLsd01sf/Cmsvr/vxfa8
 HR+BUnwRlTlZ1xBcwKdBwDmGTc/0P0tUnb1EAul8XrfreGJanLOZpLsA042XW6TZ6Vp+
 7Czi7BprSYuC+C2wnoxLAXYVEoKMtQz2kFeBzntQzCu8qISLuYB1vx+lrO9NTWGA3+bT
 YIcQ85kDkS1urvGsWg9Itb3tKktz2BkD01Hpc4xVkaarzznz44gmncj5rXedbioNv9J7
 aUiNva7Gw2tEQrsKa0bQr//y3Wice/DygILkZM1Jv8Zn1PYH28mEIaLlv33gYgD5iXTU
 bgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789399823; x=1790004623;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fNtH5wTxcL6+tfLz8Ih+76DUyT1jSsf5s4YqsEqbQtI=;
 b=J/FbGGdkuQFLhSHyV6umPXszbls+o0ejeGf8nlq82NJ12usfMHr1igznHhJpUhB0P3
 NFwAeQuJn0C5m6GeyVvtyh7+Fl20axJqN4XfNdYqVJQaE+lxGibsMkAOVY7zK1rb4th/
 gg542ifZf3s77jMyRcnNzEPfBtVGdk/KhFbpPdLDMSnc/5Rcatiy7/nZ/KBiQxGTPJYW
 tSrR5I6zoZp46AyQbnZ/9bVQSPCfT1PQQ/ffcb2D2dU/ZvUuQmeOuMzfo14a6DyfORmR
 k94YtLoIktnZ5Kvav5AWz8ATthgXSyRP3qW1PTg1lDrpIdJgZ8MfJnjwYvKE1zOvF9dM
 HzEg==
X-Gm-Message-State: AFuF++nD3xx+mmq1XhftNPPEVzFkA74nxPCf0RTkF8M7rQLPhEY5ODbW
 csPsEd88XGAVymWq3LeTwBeP3h5ceWcVpRe/DzaE8mDyr5E8huCTqIDlOb04KK5y3i0VHXZKO7K
 56LNDb6TQMRwcj82OuXbCcbFga+0eysJzucoSXjzYecjVeKjT7wAi2WLY
X-Gm-Gg: AYBFou28g1zMlXUAmBOqIXefSIbqLqdwAxOY1RzyC+x0EA+72p0gANENkvo60JU250L
 x4uT2gZ99OuwhxxiJ+f5djK87l/3UF1J/wbdTCXMGFzmmmOBU/d3l7xsN8DtY0GHZ/+GmXxKk2K
 f9jes6z9668ET3azhUo6DB/a7T5Sxow9wg0MFC84XVpyPUTEFebnum1/5TZeSoMRjk7Rdz/hBvs
 cU2PaXVdL5wdNJqXraXjfCIOIrvb3Qz4ScK8XNFhJfX8B7+8OIafAD45LOiDYd44ArCz/KqVjn/
 VtQ7FBM8q0PpiFOQ8MwXwQVTUjXTmriWxf2WhVh2vGtQ/8vz7QoT6QPi3PbVTeov740CUscFfW2
 vq6QgTAedQyFeCp6HA5Q4Qvq8JNaSwy3IDy8f4hOGt9MhXExn7BEP7OB7XKo=
X-Received: by 2002:ac8:7d56:0:b0:530:f992:b1de with SMTP id
 d75a77b69052e-5310cf0ac43mr44219971cf.3.1789399822272; 
 Mon, 14 Sep 2026 08:30:22 -0700 (PDT)
X-Received: by 2002:ac8:7d56:0:b0:530:f992:b1de with SMTP id
 d75a77b69052e-5310cf0ac43mr44219021cf.3.1789399821594; 
 Mon, 14 Sep 2026 08:30:21 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530ca4ba156sm101144991cf.19.2026.09.14.08.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:30:20 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:30:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] io: cork TLS writes to avoid small TLS records
Message-ID: <aqgTBpC0wcuuzYWa@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909120033.1303511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909120033.1303511-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 09, 2026 at 01:00:33PM +0100, Daniel P. Berrangé wrote:
> The migration code caches vmstate/ram writes into an iovec and
> flushes this periodically. The total amount of data to sent
> may be 100's of KB, but split across many iovec, each of which
> is potentially quite small.
> 
> The QIOChannelTLS receives the iovec, but since GNUTLS cannot
> accept iovec data, it iterates calling send for each element.
> 
> As a result of the migration data pattern, this results in
> GNUTLS putting lots of small TLS records on the wire. This
> has shown writes alternate between about 4k and 30 bytes
> in some tests.
> 
> This is triggering the nagle algorithm on migration-test for
> many of the TLS test cases, resulting in a "go slow" for I/O
> that eventually hits the migration timeout configured by the
> test.
> 
> Not every contributor reports seeing the "go slow" but for
> those who do see it, it hits >= 95% of the time for at least
> one of the migration TLS test cases run by 'make check'.
> 
> While we could disable the nagle algorithm (and multifd
> channels already do this), that would stil result in lots
> of small TLS records hitting the wire which is not good for
> throughput. The migration code flushes in batches because
> it wants large writes for high throughput.
> 
> To achieve this we must tell GNUTLS to encrypt data but not
> immediately sent TLS records by "corking" its output. Once
> the complete iovec has been written to GNUTLS, it can be
> uncorked allowing it to hit the wire.
> 
> There is added complexity with uncorking on non-blocking
> channels as not all encrypted data can be sent at once.
> qio_channel_write() will return what was sent, but some
> data might remain pending inside GNUTLS buffers. A later
> call to qio_channel_write() will provide the same plain
> text data buffers that have already been cached. Thus the
> code must attempt to uncork GNUTLS again to clear pending
> data and then deduct the equivalent amount of plain text.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

I wanted to test across two hosts on this patch, not for the issue because
I can't reproduce, but for perf, due to the expected reduce on write
syscalls. But then one of my hosts died.. so I only did a run locally with
PSK, running high dirty loads and sample the bandwidth without multifd.

vanilla:

2203.89 2061.09 2243.31 2241.19 2183.49
2186.59 (±74.59)

patched:

3185.10 3223.91 2877.11 2987.71 2632.30
2981.23 (±241.40)

That's 36% improvement.

I still think we can do more things on top when we will care about perf
(ktls might be the next to think about), but it looks a good start besides
fixing the extremely (kind of a bug) slowness.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


