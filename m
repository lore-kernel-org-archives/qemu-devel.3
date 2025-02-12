Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE4C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGbS-0000mo-8M; Wed, 12 Feb 2025 12:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiGbN-0000lp-6C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiGbJ-0004ZU-6o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWyecTaypBns+gpe4qOWDjVM7MDUMdV8SfX1LeARB/U=;
 b=Of0yP94WKrgOmYlGHklt4tYxf4yqrGoG93XPchnD7hcegJ0LqwXg5tk6B0oPMWOnDm4d0O
 YPMFb+adhAr5bk3wIqQdbwQQ5hHrKjWELOdfBc3lA/RrAmB/q8K0rrllL0NqprsxfOVfqQ
 NHEzcwjapeJjdxQwz6e5vMUmdKuulwY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-blJ4CU2pPgiF_2D1c_zhTw-1; Wed,
 12 Feb 2025 12:32:37 -0500
X-MC-Unique: blJ4CU2pPgiF_2D1c_zhTw-1
X-Mimecast-MFC-AGG-ID: blJ4CU2pPgiF_2D1c_zhTw_1739381556
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D4CE195609D; Wed, 12 Feb 2025 17:32:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35DCB1800359; Wed, 12 Feb 2025 17:32:31 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:32:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/11] rust/block: Add driver module
Message-ID: <Z6zbLVVWu4zxwdVE@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-9-kwolf@redhat.com>
 <7fe0ba58-8d91-49c7-8f93-d17f42c74fbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe0ba58-8d91-49c7-8f93-d17f42c74fbc@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.02.2025 um 17:43 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > +    /// Reads data from the child node into a linear typed buffer.
> > +    pub async fn read<T: IoBuffer + ?Sized>(&self, offset: u64, buf: &mut T) -> io::Result<()> {
> > +        unsafe {
> > +            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
> > +                .await
> > +        }
> > +    }
> > +
> > +    /// Reads data from the child node into a linear, potentially uninitialised typed buffer.
> > +    pub async fn read_uninit<T: SizedIoBuffer>(
> > +        &self,
> > +        offset: u64,
> > +        mut buf: MaybeUninit<T>,
> 
> I think Rust doesn't guarantee no copies here, so maybe this could be

Do you think that in practice the compiler won't optimise the copy away?
Or is this more of a theoretical concern?

>    pub async fn read_uninit<T: SizedIoBuffer>(
>        &self,
>        offset: u64,
>        buf: &mut MaybeUninit<T>,
>     ) -> io::Result<&mut T>
> 
> using assume_init_mut().

Are you sure that callers are ok with only getting a &mut T rather than
an owned T?

Kevin


