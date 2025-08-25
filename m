Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A354DCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWAR-0008P8-IB; Mon, 25 Aug 2025 08:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqWAP-0008O4-4L
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqWAK-0002AK-2v
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756124347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VByHut9H3MF7QlLTeafHqwOLZzc/NO83uAJLM77kUtk=;
 b=HvOIquIod+P3oiNOkW7exvwp9CGrPNCs3twwTgnnJp7b2fCgUEzYHgvJB+G5t87+iv6XCE
 qjE6dJBvTWnFhTmYn8E1kQhtKIGeyKCJ6W/HJM/yX1PIch6EBiEuSTgn6Cr7CNTmpOgygn
 DA+XnxpHh/0aZ9xnNXowaQS4Q4DgJLc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-eWmCmbmhMP2Wp_ORD58OiQ-1; Mon,
 25 Aug 2025 08:19:05 -0400
X-MC-Unique: eWmCmbmhMP2Wp_ORD58OiQ-1
X-Mimecast-MFC-AGG-ID: eWmCmbmhMP2Wp_ORD58OiQ_1756124344
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7001800371; Mon, 25 Aug 2025 12:19:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63D3E30001A5; Mon, 25 Aug 2025 12:19:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBA2E21E6A27; Mon, 25 Aug 2025 14:19:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Andrew
 Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>
Subject: Re: ebpf functions can fail without setting an error
In-Reply-To: <aKRWZwvbWzA0QbA_@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 11:48:07 +0100")
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
Date: Mon, 25 Aug 2025 14:19:01 +0200
Message-ID: <87sehfsife.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
>> Three functions in ebpf_rss.h take an Error ** argument and return bool.
>> Good.
>>=20
>> They can all fail without setting an error.  Not good.
>>=20
>> The failures without error are:
>>=20
>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
>
> Opps, yes, we really should have added error_setg() calls for diagnosis
> if someone tries to use eBPF when QEMU build has it disabled.

Some stubs exist only to mollify the linker.  They are not meant to be
called.  They should abort(), optionally with lipstick.

Other stubs are called and should fail nicely.

Can you tell me offhand which kind these are?

>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
>>   reachable?
>
> This scenario should never happen, and we should add a call like
>
>   error_setg(errp, "eBPF program is already loaded");
>
> to report it correctly.

Is it a programming error when it happens?


