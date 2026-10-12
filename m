Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCCDCA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 05:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG8vN-0005t2-Ay; Mon, 12 Oct 2026 01:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xG8vL-0005sm-L7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xG8vJ-000278-9D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 01:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791784207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=+znY7KGoUHs/gWbGsmjAFiBJzaX/LEd8pizmRACbnnI=;
 b=cnO7RvhMkGKoNeEsCSk16hd1Q64oZ+X4crjuXsDtvbqqpLj6N8lpFzhE9dDDVcOrp7ectj
 5/PFTe2R7dEE1qgRCmpdf9ZeaYwOiEc/px9LO/tM0vIgxo2ZV+vWcJWmsFpFRejebqC8Uq
 vmX4EGLGnWFlVt29kZSRWrSpE3iGufI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-2p4-ZEYdMpG3rJQOA7ZELA-1; Mon,
 12 Oct 2026 05:50:01 +0000
X-MC-Unique: 2p4-ZEYdMpG3rJQOA7ZELA-1
X-Mimecast-MFC-AGG-ID: 2p4-ZEYdMpG3rJQOA7ZELA_1791784200
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBF7B1801319; Mon, 12 Oct 2026 05:49:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92CC61800473; Mon, 12 Oct 2026 05:49:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 271EF21E6A04; Mon, 12 Oct 2026 07:49:57 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 12 Oct 2026 07:49:57 +0200
Resent-Message-ID: <87o6czii2i.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options support
In-Reply-To: <87qzhy775l.fsf@suse.de> (Fabiano Rosas's message of "Fri, 09 Oct
 2026 21:04:22 -0300")
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de>
 <87h5iyasxn.fsf@pond.sub.org> <87y0c97kbs.fsf@suse.de>
 <874iew7qhw.fsf@pond.sub.org> <87qzhy775l.fsf@suse.de>
Date: Mon, 12 Oct 2026 06:34:40 +0200
Message-ID: <8733ubmt9b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:

[...]

>> The entire parser should be burned with fire.
>>
>> What are the remaining differences to the keyval.c parser after your
>> series?  Can we deprecate them?
>>
>
> I ran a few of the qemu-opts tests with the keyval code and it differs
> mostly in the handling of empty (non-implied) key and implied key +
> empty value. I'll take a close look next week but I think we should
> deprecate them anyway.
>
> It looks easy to add a flag to keyval_parse_one() to turn its errors
> into deprecation warnings ("warning: madness deprecated"). We could then
> gradually make the conversion without having to wait for the deprecated
> parts to be removed. The child is almost 10 years old.
>
>   d454dbe0ee3 ("keyval: New keyval_parse()")
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Tue Feb 28 22:26:49 2017 +0100

Worth a try, I think.

Thanks!

[...]


