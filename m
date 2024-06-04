Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21DC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sETHr-0004bL-Sy; Tue, 04 Jun 2024 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sETHn-0004aU-R8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sETHl-0005L5-3H
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717504143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xDFsrXwaNaInsZ8AxXaZ9DH8FqH1/zcsyoVrAYeJ0o=;
 b=Ecve2KusGKlpsiJEcJCf0JkmS2BrMgyFsFpW7UGOqOc/IV7Ma1gFyVOTeTX5xIsVdW9SSr
 xQfQeSydThDknIJ2dJTBv1q0AwJdP+TExeLPFIgOxsoNqc7Qfliw1bqWIHQJ/LdAx4X+mD
 PlzlhOuoJOSOrRHz+mD/xvRYHr0NDJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-eD-6wDx8MLqxw7m7qm4rvA-1; Tue, 04 Jun 2024 08:28:57 -0400
X-MC-Unique: eD-6wDx8MLqxw7m7qm4rvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC137811E85;
 Tue,  4 Jun 2024 12:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B461492BD1;
 Tue,  4 Jun 2024 12:28:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BF7A21E66E5; Tue,  4 Jun 2024 14:28:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>,  fan <nifan.cxl@gmail.com>,
 <qemu-devel@nongnu.org>,  <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>,  <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>,  <a.manzanares@samsung.com>,
 <dave@stgolabs.net>,  <nmtadam.samsung@gmail.com>,
 <jim.harris@samsung.com>,  <Jorgen.Hansen@wdc.com>,
 <wj28.lee@gmail.com>,  Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240604125428.00003a1d@Huawei.com> (Jonathan Cameron's message
 of "Tue, 4 Jun 2024 12:54:28 +0100")
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjEnwPeoivsW8y5Z@debian>
 <20240501155812.00002ec3@Huawei.com> <87cyox9icl.fsf@pond.sub.org>
 <20240604125428.00003a1d@Huawei.com>
Date: Tue, 04 Jun 2024 14:28:54 +0200
Message-ID: <87h6e87uyh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 04 Jun 2024 11:18:18 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I finally got around to read this slowly.  Thank you, Fan and Jonathan!
>> 
>> I'm getting some "incomplete" vibes: "if we ever implement", "patches
>> for this on list", "we aren't emulating this yet at all", and ...
>
> Absolutely.  There is a bunch of stuff that we reject today but
> the interfaces allow you to specify it and align with the CXL specification
> Fabric Management API definition which is the spec used to control this
> stuff from a BMC etc.  If that doesn't work we have a hardware errata
> problem, so hopefully that is fairly stable.
>
> I think I can publicly confirm there are some related errata in flight,
> seeing as we said we'd raise questions on some aspects in the kernel and
> QEMU series preceding this one (so no IP secrecy issues). These are as a
> result of this work from Fan, but we have carefully avoided implementing
> anything that 'may' change.
>
>
>> 
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>> 
>> [...]
>> 
>> > Only thing I'd add is that for now (because we don't need it for testing
>> > the kernel flows) is that this does not provide any way for external
>> > agents (e.g. our 'fabric manager' to find out what the state is - i.e.
>> > if the extents have been accepted by the host etc). That stuff is all
>> > defined by the spec, but not yet in the QMP interface.  At somepoint
>> > we may want to add that as a state query type interface.  
>> 
>> ... this, too.
>> 
>> In review of v5, I asked whether this interface needs to be stable.
>> 
>> "Not stable" doesn't mean we change an interface without thought.  It
>> merely means we can change it much, much faster, and with much less
>> overhead.
>> 
>> I understand you want it chiefly for CXL development.  Development aids
>> commonly don't need to be stable.
>
> Ok. If it makes sense to make this unstable for now I'm fine with that.
> I don't see why it would change beyond in backwards compatible fashion
> with new optional fields to cover future specification updates allowing
> for more information. However I've been wrong on such things before.
>
> So I'm fine adding a patch on top of v8 marking them unstable for now.

I'd squash it into v8, but follow-up patch works for me, too.

>> If you're aiming for stable, you need to convince us the interface can
>> support the foreseeable purposes without incompatible changes.  In
>> particular, I'd like to see how you intend to support "finding out what
>> the state is".  I suspect that's related to my question in review of v8:
>> how to detect completion, and maybe track progress.
>
> There is a need for completion information but given it's completely
> asynchronous to the commands defined here (Can be out of order, lots of
> ongoing capacity add / remove flows in flight etc) and for the hardware
> definition the feedback occurs via an event record log I'm not expecting it
> to affect the interfaces added so far.
>
>> 
>> There's infrastructure for background jobs: job.json.  We might be
>> better off using it, unless completion is trivial and progress tracking
>> unnecessary.
>
> I'll take a look, but these are not conventional background commands
> (We do have those as well, but that's a whole different set of future
> problems!)
>
> The actual command itself completes synchronously but not the flow
> it kicked off which is not background as such because it may never
> finish and involves lots of moving parts.  This is similar to any
> form of error injection.  We inject the error synchronously and that
> creates a bunch of records in various registers / firmware etc but
> the actions the host OS takes are asynchronous and may only happen
> when it decides to poll some register or a driver loads much later.
>
> So I'm not sure if job.json approach fits.

Neither am I, but I want you to be aware of it, so you can make an
informed decision :)

>> [...]


