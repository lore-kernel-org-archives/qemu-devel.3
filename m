Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88126C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLifH-0007Rw-2l; Mon, 24 Jun 2024 08:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sLifF-0007RV-9M
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sLifA-00014k-UG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719231550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bXld1KoVDk+O29bfZaoBJiljr+/K1/Bde++8SxeV9q8=;
 b=TaTbNqVURHhib8U8VzqIqoi+CEvUyrHEWi4P6Zy4H9DCdk7cqc/6d543rq1IwXHW7LdDjS
 ngaSViTVR7KxwXpkNN8UOFkYFv6A4YEGeqYQOmHf02zAfbop4JBVcVZTQ3iDMaKBAGzRaa
 vpo+hQ22DoE/gyMeB1hl7NlU+Xykbv4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-VNJdIqywNeqxWp7GOIYMBw-1; Mon,
 24 Jun 2024 08:19:06 -0400
X-MC-Unique: VNJdIqywNeqxWp7GOIYMBw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DCDF1955F16; Mon, 24 Jun 2024 12:19:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23D2F300021C; Mon, 24 Jun 2024 12:18:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0974121E6687; Mon, 24 Jun 2024 14:18:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Sai
 Pavan Boddu <sai.pavan.boddu@amd.com>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: command line syntax for connecting a chardev to a CPU
In-Reply-To: <CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 21 Jun 2024 18:43:57 +0100")
References: <CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com>
Date: Mon, 24 Jun 2024 14:18:57 +0200
Message-ID: <877ceesfda.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Arm CPUs have a "debug communications channel" which on real hardware
> is basically a way to talk to the debugger on the other end of a JTAG
> connection; Linux supports using this as a console. This patchseries:
>  https://patchew.org/QEMU/20240614093026.328271-1-sai.pavan.boddu@amd.com/
> proposes implementing this in QEMU by wiring it up to a QEMU chardev.
>
> I think this is useful (among other things, it lets the user sidestep
> the "where is my UART?" question). But I'm not sure what the right way
> to let the user enable it and pick the chardev on the command line is.
> Do we have any relevant existing precedent?
>
> The patchseries has the CPU look for a chardev by ID, so if the user
> creates a chardev with id=dcc0 the first CPU will use that, if there's
> a chardev with id=dcc1 the second CPU will use that, and so on. I
> don't think we really want to make some ID string values be magic,

Neither do I.

> but maybe we do that already somewhere, and so it's OK to do here?

I'm not aware of such existing (ab)use of chardev IDs.

> I thought also of having the CPU take a chardev property, but then the
> question is how to specify that on the command line. AFAICT the -cpu
> option (a) requires a CPU type first, which is a pain for cases where
> otherwise the user has no need to care about the exact type of CPU
> because the machine model creates the right one for them, and (b) for
> the key=value properties in a -cpu option string it will set the same
> property value for every CPU in the system (which obviously isn't what
> we want for this chardev).

Looks like an instance of the old "how to set properties of onboard
devices" problem.  Still no good solution.

> We could make it a machine property (so you would say eg
>  -M xlnx-zcu102,dcc0=mychardev -chardev stdio,id=mychardev)
> but then that would require plumbing code in every machine model to
> create the property and set the value on the right CPU.

Machine properties that are aliases of the to onboard device properties
we want to set is a solution we used in places.  Requires plumbing, as
you wrote.

> Do we have a neat way to specify per-cpu CPU properties that I'm missing?

I'm not aware of a better solution.


