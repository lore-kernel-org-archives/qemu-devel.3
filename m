Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1956C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRLz-0005yo-Cn; Tue, 18 Feb 2025 12:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkRLv-0005v0-Ay
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkRLp-0008Uf-JU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739899540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWbzdWE5qn3aQcOFbn1v4WB1dzT5uxBu53Xzc/bEn3E=;
 b=OV8uyUGslzkgIABpOIWdBwHNNsdfo2eRm8rskc/H5i0GCkG/+Osn/2oo1d1UoBY90FLrDG
 b7C72BGDTzzrrnLuSzjyGClBOKEZCkEw9t8/IbA/6M9IoT+s2aXlfSc69Tg2jtLyJEYO4h
 zP15y75imHQ29ctMDflOjgOhZ21Sv5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-GahShb3uPBWCw9_D3X5a_Q-1; Tue,
 18 Feb 2025 12:25:36 -0500
X-MC-Unique: GahShb3uPBWCw9_D3X5a_Q-1
X-Mimecast-MFC-AGG-ID: GahShb3uPBWCw9_D3X5a_Q_1739899536
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A7BC180087B; Tue, 18 Feb 2025 17:25:33 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.66])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1336E19560AF; Tue, 18 Feb 2025 17:25:29 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:25:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/11] rust/qemu-api: Add wrappers to run futures in QEMU
Message-ID: <Z7TCh16eBTqbHAFE@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-5-kwolf@redhat.com>
 <533ac9c1-7486-4b1b-af9a-ed4a864727de@redhat.com>
 <Z6yYRrp4KTjveCHg@redhat.com>
 <CABgObfZ=YjFSkfH9gDWbjeWjkVo6oYgYMdEsZPyaXzeXY=qLtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZ=YjFSkfH9gDWbjeWjkVo6oYgYMdEsZPyaXzeXY=qLtw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 12.02.2025 um 14:22 hat Paolo Bonzini geschrieben:
> > > Also, would qemu_co_run_future() and qemu_run_future() become methods on an
> > > Executor later?  Maybe it make sense to have already something like
> > >
> > > pub trait QemuExecutor {
> > >     fn run_until<F: Future>(future: F) -> F::Output;
> > > }
> > >
> > > pub struct Executor;
> > > pub struct CoExecutor;
> > >
> > > and pass an executor to Rust functions (&Executor for no_coroutine_fn,
> > > &CoExecutor for coroutine_fn, &dyn QemuExecutor for mixed).  Or would that
> > > be premature in your opinion?
> >
> > If we could get bindgen to actually do that for the C interface, then
> > this could be interesting, though for most functions it also would
> > remain unused boilerplate. If we have to get the executor manually on
> > the Rust side for each function, that's probably the same function that
> > will want to execute the future - in which case it just can directly
> > call the correct function.
> 
> The idea was that you don't call the correct function but the *only*
> function :) i.e. exec.run_until(), and it will do the right thing for
> coroutine vs. no coroutine.
> 
> But yeah, there would be boilerplate to pass it all the way down so
> maybe it is not a great idea. I liked the concept that you just
> *couldn't* get _co_ wrong... but perhaps it is not necessary once more
> of "BlockDriver::open"
> is lifted into bdrv_open<D: BlockDriver>.

Yes, my assumption is that in the final state there is no "all the way
down" because the function wanting to run a future will be the outermost
Rust function. At any other level, the Rust function can just be async
itself.

That's why I said that calling the only function of the correct executor
isn't really any better than directly calling the correct function.

Kevin


