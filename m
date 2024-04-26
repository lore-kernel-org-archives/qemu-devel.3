Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0101C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MEy-00018t-Pt; Fri, 26 Apr 2024 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MEv-00016z-As
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MEt-0006Gu-QZ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714140464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNlsBq9ToqR3CSouKfqsSaCHMmBjwGwKg0dbrNmFK68=;
 b=fXjXCxz05bJk0AUDA30Duf4Y6w85DSUJOGvvOacnax3DxDdjm22VmAiKpnqFpCWC0Awj08
 ig5jzOyn819xD98kt/GbwsIk3RgOJvRSyvo+JYD0Q2e0RMYkux90qxEFv05CNomde2+5nG
 JmhPOui5PCQmbSk7mGPp55s1/xI5Ymk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ojJocEMpOdOEpxCITtKc6A-1; Fri, 26 Apr 2024 10:07:42 -0400
X-MC-Unique: ojJocEMpOdOEpxCITtKc6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6FCE8032FA;
 Fri, 26 Apr 2024 14:07:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C71891C22819;
 Fri, 26 Apr 2024 14:07:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7D8B21E6811; Fri, 26 Apr 2024 16:07:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 2/6] migration: Remove 'inc' option from migrate command
In-Reply-To: <8734r8tfwg.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 26 Apr 2024 15:25:19 +0200")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-3-farosas@suse.de> <8734r8tfwg.fsf@pond.sub.org>
Date: Fri, 26 Apr 2024 16:07:40 +0200
Message-ID: <87h6forzdf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The block incremental option for block migration has been deprecated
>> in 8.2 in favor of using the block-mirror feature. Remove it now.
>>
>> Deprecation commit 40101f320d ("migration: migrate 'inc' command
>> option is deprecated.").
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I think you missed the update to hmp-commands.hx.  I almost missed it,
too :)


