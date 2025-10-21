Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012B4CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB916-0005C8-6c; Tue, 21 Oct 2025 05:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB90v-00059w-SE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB90p-0002Ad-J1
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761040237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0mTjtfTOP2QydRRmhO9T5RRba2u6RKa641RLzZ7Y9+Q=;
 b=SroKR/7Il5G0jJHFUzb1v196wqNi2/C3TzK4dcB4KvXABc8LnQ3EJ+jLhp+CDV8/hvbTEo
 MVfL13pQ/IVEkemhjsS1OTnv8OiygrU3Gmv/ImSd3vcMublavW3f34Z3dyay4cpWCfNdAG
 xWEvD24NbAiSiTROI3Q9Jbxgcy4jvcg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-3fkMG7mONIiOTp7CJx66Sg-1; Tue,
 21 Oct 2025 05:50:36 -0400
X-MC-Unique: 3fkMG7mONIiOTp7CJx66Sg-1
X-Mimecast-MFC-AGG-ID: 3fkMG7mONIiOTp7CJx66Sg_1761040235
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B07219560AF; Tue, 21 Oct 2025 09:50:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB1321955F22; Tue, 21 Oct 2025 09:50:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FD1321E6A27; Tue, 21 Oct 2025 11:50:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <026FC9CD-543B-4A83-9D1A-0C6F59FF9065@gmail.com> (Bernhard
 Beschow's message of "Mon, 20 Oct 2025 17:27:18 +0000")
References: <20251013112102.2396012-1-armbru@redhat.com>
 <1C757C57-9134-4C72-8034-DEC70FFD25FB@gmail.com>
 <877bwpu526.fsf@pond.sub.org>
 <026FC9CD-543B-4A83-9D1A-0C6F59FF9065@gmail.com>
Date: Tue, 21 Oct 2025 11:50:32 +0200
Message-ID: <87sefcoa6v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Bernhard Beschow <shentey@gmail.com> writes:

> Am 20. Oktober 2025 12:32:33 UTC schrieb Markus Armbruster <armbru@redhat.com>:
>>Bernhard Beschow <shentey@gmail.com> writes:
>>
>>> Am 13. Oktober 2025 11:21:02 UTC schrieb Markus Armbruster <armbru@redhat.com>:
>>>>Reported-by: Bernhard Beschow <shentey@gmail.com>
>>>>Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman_shareable_free())
>>>>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>---
>>>> ui/qemu-pixman.c | 4 +++-
>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
>>>>index e46c6232cf..aea09755b9 100644
>>>>--- a/ui/qemu-pixman.c
>>>>+++ b/ui/qemu-pixman.c
>>>>@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handle,
>>>>     Error *err = NULL;
>>>> 
>>>>     qemu_win32_map_free(ptr, handle, &err);
>>>>-    error_report_err(err);
>>>>+    if (err) {
>>>>+        error_report_err(err);
>>>>+    }
>>>> #else
>>>>     qemu_memfd_free(ptr, size, handle);
>>>> #endif
>>>
>>> Thanks for the quick fix, Markus! The patch is reviewed and I've been testing it for a week. Who is going to merge it?
>>
>>I can do it.
>>
>>You provided
>>
>>    Tested-by: Bernhard Beschow
>>    Reviewed-by: Bernhard Beschow
>>
>>without an e-mail address.  Intentional?
>
> Oh, that wasn't intentional.
>
>> If not, should I use <shentey@gmail.com>?
>
> Yes, please.

Done, PR sent.  Thank you!


