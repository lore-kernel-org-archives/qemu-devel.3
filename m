Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86740CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 10:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uypgC-0007DK-Sq; Wed, 17 Sep 2025 06:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uypg7-00075s-6W
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 06:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uypg3-0008Am-2x
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 06:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758105976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtbzjloC89zh/35p6UijKT43wnQvBLPBcQPZYHIa1Fg=;
 b=jSsP2GxJiX8i+PFF0fy6OX/RzNxd6FO4qWWg0GbXHdPAExbBuevaiZPbEGfaeBiBzVDpBi
 jUKokaiEIRx2wt7F7GDiLYXFDm7T7Z07fOibZ+9gadS+3YgwjmhM5TDosf5vtBSkTWx+Js
 rkpS3brUov7zRHwGvo3SE5pDMYLebjQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-eQgWT5sDOQuwj_XF-oJ0Dw-1; Wed,
 17 Sep 2025 06:46:13 -0400
X-MC-Unique: eQgWT5sDOQuwj_XF-oJ0Dw-1
X-Mimecast-MFC-AGG-ID: eQgWT5sDOQuwj_XF-oJ0Dw_1758105972
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF3B11800562; Wed, 17 Sep 2025 10:46:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A501955F21; Wed, 17 Sep 2025 10:46:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 868C721E6A27; Wed, 17 Sep 2025 12:46:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 03/12] hw/cxl: Convert cxl_fmws_link() to Error
In-Reply-To: <87ikiygj64.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 08 Aug 2025 13:13:55 +0200")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-4-armbru@redhat.com>
 <20250808114442.0000234d@huawei.com> <87ikiygj64.fsf@pond.sub.org>
Date: Wed, 17 Sep 2025 12:46:08 +0200
Message-ID: <87bjn973wv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

Markus Armbruster <armbru@redhat.com> writes:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>
>> On Fri,  8 Aug 2025 10:08:14 +0200
>> Markus Armbruster <armbru@redhat.com> wrote:
>>
>>> Functions that use an Error **errp parameter to return errors should
>>> not also report them to the user, because reporting is the caller's
>>> job.  When the caller does, the error is reported twice.  When it
>>> doesn't (because it recovered from the error), there is no error to
>>> report, i.e. the report is bogus.
>>> 
>>> cxl_fmws_link_targets() violates this principle: it calls
>>> error_setg(&error_fatal, ...) via cxl_fmws_link().  Goes back to
>>> commit 584f722eb3ab (hw/cxl: Make the CXL fixed memory windows
>>> devices.)  Currently harmless, because cxl_fmws_link_targets()'s
>>> callers always pass &error_fatal.  Clean this up by converting
>>> cxl_fmws_link() to Error.
>>
>> Patch is definitely an improvement though I'm no sure how
>> it is really a violation of the above principle given
>> it has no effect on being called twice for example.
>
> Note I wrote "Clean this up", not "fix this" :)
>
> This is actually a canned commit message I've been using with suitable
> adjustments for similar patches: commit b765d21e4ab, 35b1561e3ec,
> e6696d3ee9b, 07d5b946539, ...
>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> The -1 return is perhaps unrelated to the main thing here,
>> but does make more sense than return 1 so fair enough.
>
> Accident, will back it out.

Changed my mind: I'm keeping it, with rationale in the commit message.

>> None of the above comments I've raised are that important to me though.
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Thanks!


