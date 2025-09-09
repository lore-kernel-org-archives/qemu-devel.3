Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034FFCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 11:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvwjo-00049x-6c; Tue, 09 Sep 2025 07:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwjf-00048K-W3
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwjY-0000Ah-KI
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757418116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOexa3yyjSLp/FXqMevt04uR4GeAkyx31QUas4F9NTo=;
 b=RDjSTB/Z/EQbHXO7r/ZY3g8lWvVi7g1ZJLLz38x9ZNGp1z24T2MR6gDQ8+H+9L9Xe5UV99
 Q87qetLRoPz70Fov9Y2bQKe6SV1cuGvzdpEI8pVwQHdjKC237siLEZJN8dpNsFN5dStQ+5
 8rLxTnZdT2lzkA8ksXoMWfiFVQ/Qn7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-6xGKShQsMPGq-qx9Rzxidw-1; Tue,
 09 Sep 2025 07:41:55 -0400
X-MC-Unique: 6xGKShQsMPGq-qx9Rzxidw-1
X-Mimecast-MFC-AGG-ID: 6xGKShQsMPGq-qx9Rzxidw_1757418114
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82E521800366; Tue,  9 Sep 2025 11:41:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E7011955F24; Tue,  9 Sep 2025 11:41:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CAC421E6A27; Tue, 09 Sep 2025 13:41:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 07/12] ui/spice-core: Clean up error reporting
In-Reply-To: <aKRc1B-4wf_n2s14@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 12:15:32 +0100")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-8-armbru@redhat.com>
 <aKRc1B-4wf_n2s14@redhat.com>
Date: Tue, 09 Sep 2025 13:41:51 +0200
Message-ID: <87y0qnyhs0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 08, 2025 at 10:08:18AM +0200, Markus Armbruster wrote:
>> watch_add() reports _open_osfhandle() failure with
>> error_setg(&error_warn, ...).
>>=20
>> I'm not familiar with Spice, so I can't say whether it will work after
>> such a failure.  If it doesn't, then this should be an error.  If it
>> does, then why bother the user with a warning that isn't actionable,
>> and likely confusing?
>
> If watch_add fails, spice is dead. Eventually the NULL returned from
> watch_add will bubble up to the spice_server_init function which will
> return non-zero and QEMU will do
>
>         error_report("failed to initialize spice server");
>         exit(1);
>
> The warning in watch_add gives a better chance of understanding
> what failed than this generic error_report() does.

Would you like me to work this into the commit message?

>> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
>> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
>> ...) are.  Replace by warn_report().
>>=20
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  ui/spice-core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!

[...]


