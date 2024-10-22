Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84537CDD0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 19:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Kpw-0002gW-Gi; Tue, 22 Oct 2024 15:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3Kpu-0002g2-PG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3Kpt-0002Kx-5w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 15:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729626392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYAjFvtVZJcADGnp+w2DYKYZM8M1rHi1oKfx0V61k4I=;
 b=LcUas+agqblet/S4LpnU49rb53hLM2uDDPR5Zm/DnwtYbwwOF1HStutJpD7Ncxyi+pxwKj
 yGtpzd07bMJ7jUcnGxVX+3KHHdG28v5ZeplZ3CL1h6PTjkQk+cTswanBLCaPMgPVNHs8gs
 bCeEz1Nbz0lISJZNchaBi3kpVWseSx4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-KsAU4BIGN-ODvhlZcBLylg-1; Tue,
 22 Oct 2024 15:46:28 -0400
X-MC-Unique: KsAU4BIGN-ODvhlZcBLylg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70DF01955D44; Tue, 22 Oct 2024 19:46:26 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12211956088; Tue, 22 Oct 2024 19:46:24 +0000 (UTC)
Date: Tue, 22 Oct 2024 21:46:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 09/13] rust: clean up define_property macro
Message-ID: <ZxgBDQ0fgwRr7D9P@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-10-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 21.10.2024 um 18:35 hat Paolo Bonzini geschrieben:
> Use the "struct update" syntax to initialize most of the fields to zero,
> and simplify the handmade type-checking of $name.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
> index 2219b9f73d0..5aba426d243 100644
> --- a/rust/qemu-api/src/device_class.rs
> +++ b/rust/qemu-api/src/device_class.rs
> @@ -29,44 +29,27 @@ macro_rules! device_class_init {
>  macro_rules! define_property {
>      ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
>          $crate::bindings::Property {
> -            name: {
> -                #[used]
> -                static _TEMP: &::core::ffi::CStr = $name;
> -                _TEMP.as_ptr()
> -            },
> +            // use associated function syntax for type checking
> +            name: ::core::ffi::CStr::as_ptr($name),

I like this part.

>              info: $prop,
>              offset: ::core::mem::offset_of!($state, $field)
>                  .try_into()
>                  .expect("Could not fit offset value to type"),
> -            bitnr: 0,
> -            bitmask: 0,
>              set_default: true,
>              defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
> -            arrayoffset: 0,
> -            arrayinfo: ::core::ptr::null(),
> -            arrayfieldsize: 0,
> -            link_type: ::core::ptr::null(),
> +            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }

But is it really worth introducing unsafe code just for a more compact
notation? If the compiler doesn't actually understand the pattern, it
might even be less efficient than what we had (i.e. if it really creates
the zeroed object and copies stuff over).

Kevin


