Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C954C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9e3N-0007sh-I9; Tue, 29 Apr 2025 02:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9e3H-0007rR-4g
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9e3F-0004JT-Br
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745906559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=maKZnjj9tQQkDQ50CARh8MuV67A8e13wgSWLydJW+1w=;
 b=gcL4Ikfp2BOf05IVIb3T7w8p1DSiTSu4vB5LhsQeqkZEHfPpCmjWt65HcAycWIkJ3WsUqw
 Ucj9mS/hJufQNnhUdkGFqMAycVBYUHzJ0mxXwWPILNZtr7M76C0h5VIOSJAyNLkr1eY6fE
 5fDJdmEwPDEt49rESLn9aO2Aqux4eQk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-Kty8IKZXPNiEjOmoi07Nag-1; Tue,
 29 Apr 2025 02:02:34 -0400
X-MC-Unique: Kty8IKZXPNiEjOmoi07Nag-1
X-Mimecast-MFC-AGG-ID: Kty8IKZXPNiEjOmoi07Nag_1745906553
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D9121801A1A; Tue, 29 Apr 2025 06:02:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECB3519560AB; Tue, 29 Apr 2025 06:02:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EFB521E66C2; Tue, 29 Apr 2025 08:02:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  devel@lists.libvirt.org
Subject: Re: [PATCH V1 0/6] fast qom tree get
In-Reply-To: <3c5e9e8d-a3c5-4179-800f-2c11d38b7b02@oracle.com> (Steven
 Sistare's message of "Mon, 28 Apr 2025 12:18:45 -0400")
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87selszp8o.fsf@pond.sub.org>
 <3c5e9e8d-a3c5-4179-800f-2c11d38b7b02@oracle.com>
Date: Tue, 29 Apr 2025 08:02:30 +0200
Message-ID: <87v7qnpksp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 4/28/2025 4:04 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>>>> Hi Steve, I apologize for the slow response.
>>>>
>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>
>>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>>> start up time.
>>>>
>>>> "Some managers"... could you name one?
>>>
>>> My personal experience is with Oracle's OCI, but likely others could benefit.
>> 
>> Elsewhere in this thread, we examined libvirt's use qom-get.  Its use of
>> qom-get is also noticably slow, and your work could speed it up.
>> However, most of its use is for working around QMP interface
>> shortcomings around probing CPU flags.  Addressing these would help it
>> even more.
>> 
>> This makes me wonder what questions Oracle's OCI answers with the help
>> of qom-get.  Can you briefly describe them?
>> 
>> Even if OCI would likewise be helped more by better QMP queries, your
>> fast qom tree get work might still be useful.
>
> We already optimized our queries as a first step, but what remains is still
> significant, which is why I submitted this RFE.

I understand your motivation.  I'd like to learn more on what OCI
actually needs from QMP, to be able to better serve it and potentially
other management applications.


