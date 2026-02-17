Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478F8E68165
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 11:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsJCv-0001BX-KH; Tue, 17 Feb 2026 06:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsJCs-0001B6-GT
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 06:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsJCq-0002hF-13
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 06:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771327526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdN74SNI4C5i0j/Bd4DQ23T8s4MFrzW9feCq1F4CcYA=;
 b=e+3TYSELi1u3R5vmx+JQm7Ico7+NFj47x9KozhJIp6EfEutYEBOhLKAGm8YU9eOb2uTxgv
 XPU+Ky65h7usy5kLj7B3VL0sOxMtTmDS/b1KreMWfWO0mrUmNSyF1pzHyDIHHgbX+oYYCq
 jZWjD3V3k5JynQc4IjTJiLjFE6wp7mg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-7qOjpSG0PsyF-15C6Y_nTg-1; Tue,
 17 Feb 2026 06:25:24 -0500
X-MC-Unique: 7qOjpSG0PsyF-15C6Y_nTg-1
X-Mimecast-MFC-AGG-ID: 7qOjpSG0PsyF-15C6Y_nTg_1771327524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07BA18003F6; Tue, 17 Feb 2026 11:25:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8790E19560A2; Tue, 17 Feb 2026 11:25:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E94BA21E692D; Tue, 17 Feb 2026 12:25:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Juraj Marcin
 <jmarcin@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
In-Reply-To: <aZQ0q2r6w3OkSP2f@angien.pipo.sk> (Peter Krempa's message of
 "Tue, 17 Feb 2026 10:29:38 +0100")
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk>
Date: Tue, 17 Feb 2026 12:25:20 +0100
Message-ID: <87ms17lihr.fsf@pond.sub.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
>> v2:
>> - Added R-bs
>> - Updated description for removing zero-blocks [Markus]
>> - Squashed the "fd: to file" test removal into the 2nd patch
>> - I dropped the COLO patch, I have a local patch to remove colo migration
>>   completely, but looks like we won't do it..  Let's leave it for later but
>>   do the rest first
>> 
>> This series removes two deprecated features for 11.0.
>> 
>> Please review, thanks.
>> 
>> Peter Xu (2):
>>   migration: Remove zero-blocks capability
>>   migration: Remove fd: support on files
>> 
>>  docs/about/deprecated.rst             | 20 -------------
>
> Note that per the 'MAINTAINERS' file, changes to any deprecations ought
> to be CC'd to the libvirt list for visibility.
>
> In this case we've forgotten about the deprecation and didn't fix it
> before the qemu cahnge was pushed. I'll send out patches soon, but keep
> in mind to *always* CC the libvirt list with deprecations.

Review fail (mine).

Should we try to make checkpatch.pl catch it?  So far, it doesn't check
cc: at all.


