Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A90C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 14:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukkm5-0000oa-Ht; Sat, 09 Aug 2025 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukkm3-0000oB-5I
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 10:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukkm1-0004dF-7i
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 10:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754750534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2NM3l7XR05i+A2K2K8J48blPPmCvnHS/4DEL1G+qjc=;
 b=L387O/BMOguHK+d/4JpdW6unJHaStQuddoxOCYLNdRMz5ikBhnAyoPe1SNn3ytiVT05/Ge
 qDsWywXtu3bfbvYBE2jsHRST5tjNWr+WAmUl1reDbTNwV4PmQBfWtnL1OcFKReAArshrQm
 Z7JlM6acyLd0PHz++0UdeXwnPQDVt+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-JKwbezO3OWCJK187Zxv0KA-1; Sat,
 09 Aug 2025 10:42:10 -0400
X-MC-Unique: JKwbezO3OWCJK187Zxv0KA-1
X-Mimecast-MFC-AGG-ID: JKwbezO3OWCJK187Zxv0KA_1754750529
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B422180034A; Sat,  9 Aug 2025 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC3C719560B0; Sat,  9 Aug 2025 14:42:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F96E21E6A27; Sat, 09 Aug 2025 16:42:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com
Subject: Re: [PATCH 12/12] error: Kill @error_warn
In-Reply-To: <baeed4ff-9366-482c-9b08-85e0fdcc6ebb@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Sat, 9 Aug 2025 19:27:55 +0900")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
 <fcd5c891-b3c5-4b7d-a0ed-0e776d55ad5e@rsg.ci.i.u-tokyo.ac.jp>
 <875xewucar.fsf@pond.sub.org>
 <baeed4ff-9366-482c-9b08-85e0fdcc6ebb@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 Aug 2025 16:42:06 +0200
Message-ID: <87a548sgjl.fsf@pond.sub.org>
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

> On 2025/08/09 17:30, Markus Armbruster wrote:

[...]

>> As I wrote, the defects are all fixable.  However, there has been so
>> little use of &error_warn, and so much of it has been unclean or
>> otherwise undesirable.  It's obviously prone to misuse.  I think we're
>> better off without it.
>>
>> See also the memo "Abuse of warnings for unhandled errors and
>> programming errors" I posted yesterday.
>
> It is insightful. The cover letter can have a reference to it and this patch can have similar description.
>
> However I still have a few counterarguments:
>
> A reason of the &error_warn usage may be caused by the complexity
> to deal with unhandled errors and programming errors. If so, adding mechanisms to ease that may naturally sufficiently reduce the wrong usage added in the future.
>
> The "&error_fatal without exit(1)" may be good enough for unhandled errors. For example, "[PATCH v10 00/27] migration: propagate vTPM errors using Error objects" would not have used &error_warn if there is the "&error_fatal without exit(1)".

I fear it would be prone to misuse.

Consider

    Error *err = NULL;

    if (!frobnicate(a, b, c, &err)) {
        error_report_err(err);
        // cleanup here, if any
        return false;
    }

With a special &error_fatal_without_exit (terrible name, but you get
what I mean), we could shorten this to

    if (!frobnicate(a, b, c, &error_fatal_without_exit)) {
        // cleanup here, if any
        return false;
    }

However, this invites

    frobnicate(a, b, c, &error_fatal_without_exit);

which is almost always wrong.  If it's an error, we normally can't just
continue as if nothing had happened.

We should make the common case as easy to get rigtht as we can.

Making the exceptions even easier invites misuse.

> There are also warn_report*() functions which also have the same problem. A comprehensive solution needs to deal with them all. Removing all of them will do but may not be practical. Another possibility is that to write a documentation telling warning should be avoided for unhandled/programming errors and let all refer to it.
>
> I agree that there is little valid usage of &error_warn and removing it may not cause a problem at all, but it is still nice if there is a reasoning for the removal, ideally addressing these counterarguments as well.

I can look into improving the commit message after my vacation.

Thanks!


