Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C5C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkO7L-0000da-Qs; Tue, 18 Feb 2025 08:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkO7J-0000dN-Ne
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkO7I-0001sT-7y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739887107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pOSX5NIHHMPhAaq+sG4UYAAQKCwNrzbgBJkeM7u56w=;
 b=hZp37o29y1Z5Td9vtOawY6inmo3Jgyr4D4fEjS8yY/zkU1Zz4v5AOMz4L3Lym9fP7pNzdE
 vAM/QwYPJRif+yd8A+FlLGFPhQAbSj2MCVJEObnzp8VOkLmy9PYtUOK/fLgn3Jqsxv8U0y
 lcXbJo6hBFqdsSAMBldRmcUiOS3Kmdw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-wQ_QSqnHP2el5GHZEKCSow-1; Tue,
 18 Feb 2025 08:57:20 -0500
X-MC-Unique: wQ_QSqnHP2el5GHZEKCSow-1
X-Mimecast-MFC-AGG-ID: wQ_QSqnHP2el5GHZEKCSow_1739887039
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0181800264; Tue, 18 Feb 2025 13:57:17 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27E8A300018D; Tue, 18 Feb 2025 13:57:14 +0000 (UTC)
Date: Tue, 18 Feb 2025 14:57:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] rust: add module to convert between -errno and
 io::Error
Message-ID: <Z7SRuD9Wob8wQK1z@redhat.com>
References: <20250213143216.3910163-1-pbonzini@redhat.com>
 <20250213143216.3910163-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213143216.3910163-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.02.2025 um 15:32 hat Paolo Bonzini geschrieben:
> It is a common convention in QEMU to return a positive value in case of
> success, and a negated errno value in case of error.  Unfortunately,
> using errno portably in Rust is a bit complicated; on Unix the errno
> values are supported natively by io::Error, but on Windows they are not;
> so, use the libc crate.
> 
> This is a set of utility functions that are used by both chardev and
> block layer bindings.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

In my series, this allows a simplification of sorts:

     let mapping = match qemu_co_run_future(s.map(&req)) {
         Ok(mapping) => mapping,
-        Err(e) => {
-            return -e
-                .raw_os_error()
-                .unwrap_or(bindings::EIO as std::os::raw::c_int)
-        }
+        Err(e) => return -i32::from(Errno::from(e).0),
     };

Not really nice yet, though.

> +pub fn into_neg_errno<T: MergeErrno, E: Into<Errno>>(value: Result<T, E>) -> T::Out {
> +    match value {
> +        Ok(x) => x.map_ok(),
> +        Err(err) => -T::Out::from(err.into().0),
> +    }
> +}

How about making this a method of a trait that is implemented for
Result<T, E> similar to what you already have, but also directly for
io::Error (or actually E: Into<Errno>)?

Then the above could become:

     let mapping = match qemu_co_run_future(s.map(&req)) {
         Ok(mapping) => mapping,
         Err(e) => return e.into_neg_errno(),
     };

Kevin


