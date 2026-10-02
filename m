Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7441CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCaQt-0006Z2-0L; Fri, 02 Oct 2026 06:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCaQn-0006VE-M3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCaQl-0003pU-As
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790936634;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GB2Lk5Uje/lT+zs14oyAOXXr/0vSNRRtjRKcbmLUuUQ=;
 b=TQfJRgrHWaYSG+7A6nUVl193l8KUrF3ZWjVAkLU/RXMHDIWdOArvLWLN+led2Lj6J3doui
 y5zoptRCyoJMWX7GJKKPRKx7nVbwq/Yz7TOrEP5Yb46pL+MNZjWu0JGseA/OB0YhWLWUlr
 6cwdFgNG374BYrRdpb7sj1GcXqOhh6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-y0NuN1qyP0W6dQrG6GmSXw-1; Fri,
 02 Oct 2026 06:23:51 -0400
X-MC-Unique: y0NuN1qyP0W6dQrG6GmSXw-1
X-Mimecast-MFC-AGG-ID: y0NuN1qyP0W6dQrG6GmSXw_1790936630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11103195BDE8; Fri,  2 Oct 2026 10:23:50 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ED10180049F; Fri,  2 Oct 2026 10:23:47 +0000 (UTC)
Date: Fri, 2 Oct 2026 11:23:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Tanish Desai <tanishdesai37@gmail.com>
Subject: Re: [PULL 15/16] tracetool/ftrace: add Rust support
Message-ID: <ar-GMXSnnVFzV59f@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
 <20251001153059.194991-16-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001153059.194991-16-stefanha@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AFAICT, this support for ftrace is incomplete.

Building with:

  ./configure --enable-trace-backends=ftrace  --enable-rust --target-list=x86_64-softmmu

results in Rust build failures

error[E0425]: cannot find function `ftrace_write` in module `bindings`
   --> /home/berrange/src/virt/qemu/build/trace/trace-hw_char.rs:130:27
    |
130 | ...   unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _desc.as_ptr(), _addr as std::ffi::c_int, _value as std::ff...
    |                         ^^^^^^^^^^^^ not found in `bindings`

error[E0425]: cannot find function `ftrace_write` in module `bindings`
   --> /home/berrange/src/virt/qemu/build/trace/trace-hw_char.rs:140:27
    |
140 | ...   unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _desc.as_ptr(), _addr as std::ffi::c_int, _value as std::ff...
    |                         ^^^^^^^^^^^^ not found in `bindings`


and these errors occur on both today's git master HEAD, and all
the way back to this first patch that claimed to support ftrace
with Rust.

Did some piece of supporting code go missing in the final
pull request here ? 

On Wed, Oct 01, 2025 at 11:30:58AM -0400, Stefan Hajnoczi wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
> 
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20250929154938.594389-16-pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/backend/ftrace.py |  8 +++++-
>  tests/tracetool/ftrace.rs           | 40 +++++++++++++++++++++++++++++
>  tests/tracetool/tracetool-test.py   |  2 +-
>  3 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tracetool/ftrace.rs
> 
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index 7ddd5d11a6..e03698a2ed 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -12,7 +12,7 @@
>  __email__      = "stefanha@redhat.com"
>  
>  
> -from tracetool import out
> +from tracetool import out, expand_format_string
>  
>  
>  PUBLIC = True
> @@ -43,3 +43,9 @@ def generate_h(event, group):
>  def generate_h_backend_dstate(event, group):
>      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
>          event_id="TRACE_" + event.name.upper())
> +
> +def generate_rs(event, group):
> +    out('        let format_string = c"%(fmt)s";',
> +        '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
> +        fmt=expand_format_string(event.fmt),
> +        args=event.args.rust_call_varargs())
> diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
> new file mode 100644
> index 0000000000..07b9259cf2
> --- /dev/null
> +++ b/tests/tracetool/ftrace.rs
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// This file is @generated by tracetool, do not edit.
> +
> +#[allow(unused_imports)]
> +use std::ffi::c_char;
> +#[allow(unused_imports)]
> +use util::bindings;
> +
> +#[inline(always)]
> +fn trace_event_state_is_enabled(dstate: u16) -> bool {
> +    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
> +}
> +
> +extern "C" {
> +    static mut trace_events_enabled_count: u32;
> +}
> +extern "C" {
> +    static mut _TRACE_TEST_BLAH_DSTATE: u16;
> +    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
> +{
> +    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
> +        let format_string = c"Blah context=%p filename=%s";
> +        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
> +    }
> +}
> +
> +#[inline(always)]
> +#[allow(dead_code)]
> +pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
> +{
> +    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
> +        let format_string = c"Wibble context=%p value=%d";
> +        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
> +    }
> +}
> diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
> index f58f3b795e..3341fb18f9 100755
> --- a/tests/tracetool/tracetool-test.py
> +++ b/tests/tracetool/tracetool-test.py
> @@ -14,7 +14,7 @@ def get_formats(backend):
>          "c",
>          "h",
>      ]
> -    if backend in {"log", "simple"}:
> +    if backend in {"ftrace", "log", "simple"}:
>          formats += ["rs"]
>      if backend == "dtrace":
>          formats += [
> -- 
> 2.51.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


