Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F68CDD1CE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 16:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suDXt-0001PO-C1; Fri, 27 Sep 2024 12:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1suDXr-0001Ou-Ss
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1suDXp-0002Hd-A7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 12:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727453411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RcdjwEczBXXLMYU7XQLo2UcGlLTHVRmPrG5upxPDo/E=;
 b=g2s1HCTCZyRYzH8yi4rYbB5xKDtLC1A1JfilBxkdKfKk6LB+sH6amtmv8ar2en2TcA6h2g
 L2Pzn3sOzEEGhAm1JZTvECqkRsWt8c8frd0525wvu6U7TnxHPf2yzJI4mQ6IsCpDBMeQFs
 gqYyR+ZGujdrhMSHD86LrJznmXlb3/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-I8R8NuOjMKOqz2aGyMmhAA-1; Fri,
 27 Sep 2024 12:10:07 -0400
X-MC-Unique: I8R8NuOjMKOqz2aGyMmhAA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79F92191FCCB; Fri, 27 Sep 2024 16:10:06 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB69C184AE37; Fri, 27 Sep 2024 16:09:57 +0000 (UTC)
Date: Fri, 27 Sep 2024 18:09:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to
 convert from/to C representations
Message-ID: <ZvbY0PMWmJPZN7Sq@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701145853.1394967-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Paolo,

as you asked me at KVM Forum to have a look at this, I'm going through
it now.

Am 01.07.2024 um 16:58 hat Paolo Bonzini geschrieben:
> The qemu::util::foreign module provides:
> 
> - A trait for structs that can be converted to a C ("foreign") representation
>   (CloneToForeign)
> 
> - A trait for structs that can be built from a C ("foreign") representation
>   (FromForeign), and the utility IntoNative that can be used with less typing
>   (similar to the standard library's From and Into pair)

It makes sense to me that we'll need something to convert data and that
this usually means creating a new instance, i.e. cloning. However, while
it's obvious that this is similar to From/Into, the part I'm missing
here is what's different from it.

In other words, couldn't we just implement the normal From trait between
FFI types and the native equivalent?

> - Automatic implementations of the above traits for Option<>, supporting NULL
>   pointers

This is nice.

> - A wrapper for a pointer that automatically frees the contained data.  If
>   a struct XYZ implements CloneToForeign, you can build an OwnedPointer<XYZ>
>   and it will free the contents automatically unless you retrieve it with
>   owned_ptr.into_inner()

Something here feels off to me.

At first, I thought it might be only about naming. This is not about
owning the pointer (which you probably do anyway), but that the pointer
owns the object it points to. This concept has in fact a name in Rust:
It's a Box.

The major difference compared to Box is that we're using a different
allocator. Not sure if the allocator APIs would actually be viable, but
they're not stable anyway - but let's at least name this thing in way
that draws the obvious parallel. Maybe ForeignBox.

But the other thing that doesn't feel quite right is how this is coupled
with CloneToForeign. Freeing is different from cloning, and it really
relates to the foreign type itself, and not to the one that can be
cloned into a foreign type.

Bringing both together, what a Box doesn't usually have is a function
pointer for freeing. We probably don't need it here either, almost
everything needs g_free(). There is a different free_foreign()
implementation for Error, but arguably this could be changed:
bindings::Error should then implement Drop for the inner value (with an
error_free_inner() which needs to be exported separately from C first),
and then ForeignBox can just drop the Error object and g_free() the
pointer itself like it would do with any other value.

(Your implementation actually calls free() instead of g_free(). We
generally try to avoid that in our C code, so we should probably avoid
it in Rust, too.)

Kevin


