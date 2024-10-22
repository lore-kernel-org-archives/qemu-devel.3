Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D3CDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LYe-0005ep-BT; Tue, 22 Oct 2024 16:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3LYc-0005eM-3g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3LYa-0007o4-3P
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729629162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT7eZYxt1FuUHmcpeD52AmtCZP1VQksIdo9GswzjOQU=;
 b=O2F7G90RVlE8kgBRpoCMPqFfoaUC0oF/kaoxhw7uDQzOr3m4Hr7F667QC3OiTO8KKMkgZ1
 yGIz2HHUb7/uJw0MIUdc9UUgFv19YoAibNnC67RvwzN0yJkuQjO/CLdObhS91KIGc8UE0u
 jJVua9XDEzgmM7jITxgadppreltjXsQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-5i8jKdQMNLWJ6dXj0IdDmQ-1; Tue,
 22 Oct 2024 16:32:38 -0400
X-MC-Unique: 5i8jKdQMNLWJ6dXj0IdDmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD89219560A5; Tue, 22 Oct 2024 20:32:37 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A811956088; Tue, 22 Oct 2024 20:32:36 +0000 (UTC)
Date: Tue, 22 Oct 2024 22:32:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 08/13] rust: cleanup module_init!, use it from
 #[derive(Object)]
Message-ID: <ZxgL4l-itd8GjhnB@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-9-pbonzini@redhat.com>
 <ME0P300MB1040AEF7807BCED2866FA5F6954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfZ95u+3CG92Zoobju=Sg19W4P2Dzb2YAGms=nwoydaknQ@mail.gmail.com>
 <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ME0P300MB1040458035970DCE9B84D6A3954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
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

Am 22.10.2024 um 08:00 hat Junjie Mao geschrieben:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On Tue, Oct 22, 2024 at 4:12 AM Junjie Mao <junjie.mao@hotmail.com> wrote:
> >> > +    ($type:ident => $body:block) => {
> >> > +        const _: () = {
> >> > +            #[used]
> >> > +            #[cfg_attr(
> >> > +                not(any(target_vendor = "apple", target_os = "windows")),
> >> > +                link_section = ".init_array"
> >> > +            )]
> >> > +            #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
> >> > +            #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> >> > +            pub static LOAD_MODULE: extern "C" fn() = {
> >> > +                extern "C" fn init_fn() {
> >>
> >> init_fn() should be unsafe fn according to the signature of
> >> register_module_init.
> >
> > I think it *can* be unsafe (which bindgen does by default). It's
> > always okay to pass a non-unsafe function as unsafe function pointer:
> >
> > fn f() {
> >     println!("abc");
> > }
> >
> > fn g(pf: unsafe fn()) {
> >     unsafe {
> >         pf();
> >     }
> > }
> >
> > fn main() {
> >     g(f);
> > }
> >
> >> Being unsafe fn also makes sense here because it
> >> is the caller, not init_fn() itself, that is responsible for the safety of
> >> the unsafe code in the body.
> >
> > Isn't it the opposite? Since the caller of module_init! is responsible
> > for the safety, init_fn() itself can be safe.
> 
> My understanding is that:
> 
>   1. init_fn() is called by QEMU QOM subsystem with certain timing
>      (e.g., called after main()) and concurrency (e.g., all init_fn()
>      are called sequentially) preconditions.

Though these conditions are not a matter of safety, but of correctness.

>   2. The caller of module_init! is responsible for justifying the safety
>      of their $body under the preconditions established in #1.
> 
> "unsafe fn" in Rust is designed to mark functions with safety
> preconditions so that the compiler can raise an error if the caller
> forgets that it has those preconditions to uphold [1].

I don't think we expect to have preconditions here that are required for
safety (in the sense with which the term is used in Rust).

But safe code is not automatically correct.

If you added "unsafe" for every function that requires some
preconditions to be met so that it functions correctly (instead of only
so that it doesn't have undefined behaviour on the language level), then
you would annotate almost every function as "unsafe".

I think the rule of thumb for marking a function unsafe is when you have
unsafe code inside of it whose safety (not correctness!) depends on a
condition that the caller must reason about because you can't guarantee
it in the function itself.

This macro should probably only be used with code that can guarantee the
safety of its unsafe blocks in itself. The C side of constructors can't
make many guarantees anyway, and there is nobody who would reason about
them.

Kevin


