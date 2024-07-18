Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNjp-0001GW-Pz; Thu, 18 Jul 2024 05:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUNjm-0000xT-LC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUNjk-00085p-PJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721296063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OWWassaQ73WAKM6GqTPCeT4OCBvw4yb5ViE+TlnzC6c=;
 b=cE19XLWvZFI0WIQ9OVX/Nuk19q8c4/pnotUSblrm3sypeOoFSY4mkaTbI2To2XA3xHaVwC
 qnZNMNyhD0K6BDSdFpvA+wiWJCoJFFfmh6xV/Msqhd+Sa4l09Im223a9St4Il1HZjMqDyH
 0nR/rfqbEuS6Niy6LgBMrhUCsEOzBnQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-lgT-mHjcNY-NPyTyX1D4Ag-1; Thu,
 18 Jul 2024 05:47:36 -0400
X-MC-Unique: lgT-mHjcNY-NPyTyX1D4Ag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A92B41944A83; Thu, 18 Jul 2024 09:47:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05B9F3000188; Thu, 18 Jul 2024 09:47:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E53BD21E668E; Thu, 18 Jul 2024 11:47:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Octavian Purdila <tavip@google.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  eblake@redhat.com,  berrange@redhat.com,
 Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
In-Reply-To: <CAFEAcA8nFz_4M3s4NoWpfhJZ=pxRc92shSKfoL6iN=_Oqmc-tw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 18 Jul 2024 10:22:01 +0100")
References: <20240605185050.1678102-1-tavip@google.com>
 <87r0br8bve.fsf@pond.sub.org>
 <CAFEAcA8nFz_4M3s4NoWpfhJZ=pxRc92shSKfoL6iN=_Oqmc-tw@mail.gmail.com>
Date: Thu, 18 Jul 2024 11:47:32 +0200
Message-ID: <87msmfkp57.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 18 Jul 2024 at 07:15, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Looks like this one fell through the cracks.
>>
>> Octavian Purdila <tavip@google.com> writes:
>>
>> > Add path option to the pty char backend which will create a symbolic
>> > link to the given path that points to the allocated PTY.
>> >
>> > This avoids having to make QMP or HMP monitor queries to find out what
>> > the new PTY device path is.
>>
>> QMP commands chardev-add and chardev-change return the information you
>> want:
>>
>>     # @pty: name of the slave pseudoterminal device, present if and only
>>     #     if a chardev of type 'pty' was created
>>
>> So does HMP command chardev-add.  HMP chardev apparently doesn't, but
>> that could be fixed.
>>
>> So, the use case is basically the command line, right?
>
>> The feature feels rather doubtful to me, to be honest.
>
> The command line is an important use-case, though. Not every
> user of QEMU is libvirt with a QMP/HMP connection readily
> to hand that they would prefer to use for all configuration...

In general yes.  But what are the use cases for this one?

To me, specifying path=/mumble/symlink plus the bother of cleaning up
stale ones doesn't feel like much of an improvement over reading the pty
name from "info chardev".  I guess I'm missing something.  Tell me!

If we decide we want this, then the QMP interface needs to be fixed:
Call the argument @path for consistency, and document it properly.
Actually straightforward, just create a new struct instead of pressing
ChardevHostdev into service.

Some advice on robust use of @path could be useful, in particular on
guarding against QEMU leaving stale links behind.

Additional decision: whether to extend the old-style syntax.


