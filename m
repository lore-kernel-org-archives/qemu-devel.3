Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4530CC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9N3-0001Pm-Na; Thu, 05 Jun 2025 08:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN9Mw-0001N2-4L
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN9Mu-0000Ul-92
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749125206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hjq7PRBrGKH+pUaHF5VWFOYtWfvMXQv7b8Sj1cP1SmM=;
 b=dgkY7iOeHZ12MrMZyLplpYH7GG7XH0xmgOuW7C/948/r3OB5vVs7zChpyBQDSMleAXHab1
 vcrH4nQQvebGA+pT/zIQHMvxoYRWHrymvHoZ2jCrQ6Qov4GGTUo7mIQBhwGVRU+Ci4vxTe
 8Ub5JfaM0jfvuudbG4Xxra6GkqCRY1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-w5_cI8MwPt2Hr2GZb7HWqA-1; Thu,
 05 Jun 2025 08:06:42 -0400
X-MC-Unique: w5_cI8MwPt2Hr2GZb7HWqA-1
X-Mimecast-MFC-AGG-ID: w5_cI8MwPt2Hr2GZb7HWqA_1749125201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A89691956095; Thu,  5 Jun 2025 12:06:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 602BE18002A5; Thu,  5 Jun 2025 12:06:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD6B321E6766; Thu, 05 Jun 2025 14:06:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  zhao1.liu@intel.com,  qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
In-Reply-To: <20250605101544.368953-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 5 Jun 2025 12:15:35 +0200")
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-7-pbonzini@redhat.com>
Date: Thu, 05 Jun 2025 14:06:38 +0200
Message-ID: <87o6v2fl4h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Provide an implementation of std::error::Error that bridges the Rust
> anyhow::Error and std::panic::Location types with QEMU's Error*.
>
> It also has several utility methods, analogous to error_propagate(),
> that convert a Result into a return value + Error** pair.  One important
> difference is that these propagation methods *panic* if *errp is NULL,
> unlike error_propagate() which eats subsequent errors[1].  The reason
> for this is that in C you have an error_set*() call at the site where
> the error is created, and calls to error_propagate() are relatively rare.
>
> In Rust instead, even though these functions do "propagate" a
> qemu_api::Error into a C Error**, there is no error_setg() anywhere that
> could check for non-NULL errp and call abort().  error_propagate()'s
> behavior of ignoring subsequent errors is generally considered weird,
> and there would be a bigger risk of triggering it from Rust code.
>
> [1] This is actually a violation of the preconditions of error_propagate(=
),
>     so it should not happen.  But you never know...
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

> diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
> new file mode 100644
> index 00000000000..80157f6ea1b
> --- /dev/null
> +++ b/rust/qemu-api/src/error.rs

[...]

> +    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
> +    /// with the information container in `self` if `errp` is not NULL;
> +    /// then consume it.
> +    ///
> +    /// This is similar to the C API `error_propagate`, but it panics if
> +    /// `*errp` is not `NULL`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `errp` must be a valid argument to `error_propagate`; it can be
> +    /// `NULL` or it can point to any of:
> +    /// * `error_abort`
> +    /// * `error_fatal`
> +    /// * a local variable of (C) type `Error *`

This local variable must contain NULL.

> +    ///
> +    /// Typically `errp` is received from C code and need not be
> +    /// checked further at the Rust=E2=86=94C boundary.
> +    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
> +        if errp.is_null() {
> +            return;
> +        }
> +
> +        // SAFETY: caller guarantees that errp and *errp are valid
> +        unsafe {
> +            assert_eq!(*errp, ptr::null_mut());
> +            bindings::error_propagate(errp, self.clone_to_foreign_ptr());
> +        }
> +    }

[...]

With the comment tightened:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

The commit message and comment improvements are lovely!


