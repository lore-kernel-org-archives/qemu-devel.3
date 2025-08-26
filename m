Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771E4CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsFg-00009C-FC; Tue, 26 Aug 2025 07:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsFe-00008l-RV
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsFX-0003jL-DP
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756209239;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6hHxM8/HfwFFSYWjjLM249sSSY/+gfKqliyzmskxLE4=;
 b=HYJ2ysRj002D+0O1HBdkis8wuQ+13tQGFng+wGwxrtRz+CFOeC6IKvvnrR8jWSuBZogKld
 wbn9kBaM0GdjBaPJjCXRCk7MqentefPOotpwW3DOJrBFg/Oe4UyoOifanEWwdIzzWddr/p
 W0C++YCH8P40rJYuBYIKb0ZWi/Rf/EQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-c1_3yk81Mnmal9pL3mHM1g-1; Tue,
 26 Aug 2025 07:53:56 -0400
X-MC-Unique: c1_3yk81Mnmal9pL3mHM1g-1
X-Mimecast-MFC-AGG-ID: c1_3yk81Mnmal9pL3mHM1g_1756209235
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F921956088; Tue, 26 Aug 2025 11:53:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22BDF19560AB; Tue, 26 Aug 2025 11:53:52 +0000 (UTC)
Date: Tue, 26 Aug 2025 12:53:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 10/14] tracetool/simple: add Rust support
Message-ID: <aK2gTWBwHpOY4iwm@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-11-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 22, 2025 at 02:26:51PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py       |  2 +-
>  scripts/tracetool/backend/simple.py |  7 +++++
>  tests/tracetool/simple.rs           | 41 +++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py   |  2 ++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tracetool/simple.rs
> 
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 0b8ec707332..7542757799e 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -336,7 +336,7 @@ def rust_call_extern(self):
>          def rust_cast(name, type_):
>              if type_ == "const char *":
>                  return f"_{name}.as_ptr()"
> -            return "_{name}"
> +            return f"_{name}"
>  
>          return ", ".join((rust_cast(name, type_) for type_, name in self._args))
>

This should be squashed into the earlier patch that introduced the mistake

> diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
> new file mode 100644
> index 00000000000..895096088dc
> --- /dev/null
> +++ b/tests/tracetool/simple.rs
> @@ -0,0 +1,41 @@
> +// This file is autogenerated by tracetool, do not edit.
> +
> +#[allow(unused_imports)]
> +use std::ffi::c_char;
> +#[allow(unused_imports)]
> +use qemu_api::bindings;
> +
> +#[inline(always)]
> +fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {
> +    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }
> +}
> +
> +extern "C" {
> +    static mut trace_events_enabled_count: u32;
> +}
> +extern "C" {
> +    static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
> +}
> +const _TRACE_TEST_BLAH_ENABLED: bool = true;
> +const _TRACE_TEST_WIBBLE_ENABLED: bool = true;

Does rust have any policy reserving use of leading underscore in
identifiers  ?


> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> +{
> +    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
> +        extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
> +        unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
> +    }
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> +{
> +    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
> +        extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
> +        unsafe { _simple_trace_test_wibble(_context, _value); }
> +    }
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


