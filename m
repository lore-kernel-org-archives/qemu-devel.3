Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6763BC87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 08:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukeyt-0004Ne-S2; Sat, 09 Aug 2025 04:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukeyo-0004Lh-Gk
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 04:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukeyk-0003oG-At
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 04:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754728258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA9XqTlFb6oLGRfX0QHBtY9/IrRsSFr4peKr9LTWWew=;
 b=bMdrTv5q8RmlVXV5W7fk28UVYZO3tCgfDg5+MwfZilSacDXWLRMhgjrr2U446fvfZFuzrT
 lBPES3dLZYstbVwma5D2Idrk4RJ7BDLnJB5c28T/5dq9oqPufpjSWfj5sgw08RqehPdS5i
 AFo/6AYMxAMUyo/QolIrbbV8ZlxjTtc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-a6rOb7XvPau4dT3skaC9GQ-1; Sat,
 09 Aug 2025 04:30:56 -0400
X-MC-Unique: a6rOb7XvPau4dT3skaC9GQ-1
X-Mimecast-MFC-AGG-ID: a6rOb7XvPau4dT3skaC9GQ_1754728256
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D28E19560AA; Sat,  9 Aug 2025 08:30:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FB0F19560AD; Sat,  9 Aug 2025 08:30:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E76B221E6A27; Sat, 09 Aug 2025 10:30:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com
Subject: Re: [PATCH 12/12] error: Kill @error_warn
In-Reply-To: <fcd5c891-b3c5-4b7d-a0ed-0e776d55ad5e@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Sat, 9 Aug 2025 16:07:54 +0900")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
 <fcd5c891-b3c5-4b7d-a0ed-0e776d55ad5e@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 Aug 2025 10:30:52 +0200
Message-ID: <875xewucar.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/08/08 17:08, Markus Armbruster wrote:
>> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
>> add global &error_warn destination).  It has multiple issues:
>>
>> * error.h's big comment was not updated for it.
>>
>> * Function contracts were not updated for it.
>>
>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>    error_prepend() and such.  These crash on @error_warn, as pointed
>>    out by Akihiko Odaki.
>>
>> All fixable.  However, after more than two years, we had just of 15
>> uses, of which the last few patches removed eight as unclean or
>> otherwise undesirable.  I didn't look closely enough at the remaining
>> seven to decide whether they are desirable or not.
>>
>> I don't think this feature earns its keep.  Drop it.
>
> I want to note that the following patch series temporarily use &error_warn during its conversion to add errp parameters:
> https://lore.kernel.org/qemu-devel/20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com/
> ("[PATCH v10 00/27] migration: propagate vTPM errors using Error objects")
>
> I think this series needs to be rebased on top of the migration change.

Thanks for the heads-up.

> I'm not sure if seven uses are insufficient to keep it.
>
> I also have a general impression that perhaps a special error destination for error_report_err() is more useful. Today, there are many functions use Error, but there are also functions that still follow old error handling patterns. When legacy functions call functions with Error, a common pattern is to use error_report_err() and return -1.

You mean like &error_fatal less the exit(1)?

> "[PATCH 01/12] monitor: Clean up HMP gdbserver error reporting" and "[PATCH 09/12] ui/pixman: Consistent error handling in qemu_pixman_shareable_free()" are examples that will benefit from error_report_err() as an error destination. The migration patch series I mentioned earlier can also use one.
>
> Perhaps it is nicer if there is an infrastructure shared by the special destinations. In particular, we can have common solutions for the three problems you pointed out:
>
>> * error.h's big comment was not updated for it.
>>
>> * Function contracts were not updated for it.
>
> For these two problems, they can refer to "special error destinations" instead of listing them, and delegate explanations of them to corresponding ones.
>
>>
>> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>>   error_prepend() and such.  These crash on @error_warn, as pointed
>>   out by Akihiko Odaki.
>
> For this problem, Error can tell that it is a special destination by leaving msg NULL, for example. ERRP_GUARD() then rewrites errp it is not &error_abort and msg is NULL.

As I wrote, the defects are all fixable.  However, there has been so
little use of &error_warn, and so much of it has been unclean or
otherwise undesirable.  It's obviously prone to misuse.  I think we're
better off without it.

See also the memo "Abuse of warnings for unhandled errors and
programming errors" I posted yesterday.

> Special destinations can also have a function pointer void (*)(Error*), which will be called by error_handle(). This way, we can ensure that having a special destination will not require changes to the common code.
>
> By the way, I also asked for a comment with the migration patch series. Please reply the following if you have anything to say:
> https://lore.kernel.org/qemu-devel/9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp/
>
> There is also an additional context:
> https://lore.kernel.org/qemu-devel/aJMsRBd9-XOMRG78@armenon-kvm.bengluru.csb/

I replied there.

I'll be on vacation the next two weeks.


