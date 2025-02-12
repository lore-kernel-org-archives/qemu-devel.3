Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659F9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGS9-00068M-VM; Wed, 12 Feb 2025 12:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiGS7-00067q-SV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiGS6-0002VO-8R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739380988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUFY+xQG14kKPRZxkRZi/i89+NEEMJm+I6+932hnwvI=;
 b=H7xMsHYMcaCWM3mtlvSudUX907U1JmUMrGqXWm1eu6SWcDRBN5cz32E71ev48QDjsNnjf4
 H34KzvaYTJKpOS+gyDyOCBbbDTDEYyL+4cLsekUq2cIk9xCKRMnIOF84K+LyLb62IP1vjn
 hplylfY6QjpuiYOCJJVSBbkRK+NtW1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-UmKtBFAePoq-Zp--XWDCKw-1; Wed,
 12 Feb 2025 12:23:07 -0500
X-MC-Unique: UmKtBFAePoq-Zp--XWDCKw-1
X-Mimecast-MFC-AGG-ID: UmKtBFAePoq-Zp--XWDCKw_1739380986
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 353B81800872; Wed, 12 Feb 2025 17:23:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F29B11954B02; Wed, 12 Feb 2025 17:23:01 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:22:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/11] rust/block: Add I/O buffer traits
Message-ID: <Z6zY8yZcKtUXoVib@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-7-kwolf@redhat.com>
 <b3241aed-0470-41c8-ae82-e492fd3802ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3241aed-0470-41c8-ae82-e492fd3802ee@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 12.02.2025 um 17:48 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > +/// Implementing `SizedIoBuffer` provides an implementation for [`IoBuffer`] without having to
> > +/// implement any functions manually.
> > +///
> > +/// # Safety
> > +///
> > +/// Types implementing `SizedIoBuffer` guarantee that the whole object can be accessed as an I/O
> > +/// buffer that is safe to contain any byte patterns.
> > +pub unsafe trait SizedIoBuffer: Sized {
> 
> This is similar to the ByteValued trait in rust-vmm.  Can you name it
> the same so that we can later consider replacing it?

I'm not sure if it's the best name, but could be done, of course.

Though the more interesting thing to replace it with eventually might be
the zerocopy crate which has derive macros that check that the condition
is actually fulfilled. I just didn't feel like bringing in new external
dependencies in this first series.

> > +    fn from_byte_slice(buf: &[u8]) -> Option<&Self> {
> > +        if buf.len() < std::mem::size_of::<Self>() {
> > +            return None;
> > +        }

This is a semantic difference compared to ByteValued::from_slice(),
which requires the sizes to match exactly. For the probe function, I
actually make use of the relaxed requirement here to access a header
struct in a larger buffer passed from C.

> > +        let ptr = buf.as_ptr() as *const Self;
> > +
> > +        // TODO Use ptr.is_aligned() when MSRV is updated to at least 1.79.0
> > +        if (ptr as usize) % std::mem::align_of::<Self>() != 0 {
> > +            return None;
> > +        }
> > +
> > +        // SAFETY: This function checked that the byte slice is large enough and aligned.
> > +        // Implementing SizedIoBuffer promises that any byte pattern is valid for the type.
> > +        Some(unsafe { &*ptr })
> 
> If you want, the function can be written also
> 
>     // SAFETY: implementing SizedIoBuffer promises that any byte pattern
>     // is valid for the type
>     match unsafe { buf.align_to::<Self>() } {
>         ([], mid, _) => mid.get(0),
>         _ => None
>     }
> 
> (trick stolen from rust-vmm, in fact).

Clever way to avoid ptr::is_aligned(), but I feel a bit harder to
understand than just open-coding it like above? (And probably less
efficient, but I don't know how relevant that is.)

Kevin


