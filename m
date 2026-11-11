Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127D606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQBXgcy4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8ub-0007HL-CL; Wed, 11 Nov 2026 09:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR8uY-0007Gy-Gl
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:02:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR8uW-00028F-Ph
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794405765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LiCC19jLTdGKsepraKUucbwAQdsGgvzlzKUI736EdLM=;
 b=ZQBXgcy4lWD6LALclGnP+gBF4qQIXeV/3vzo467/O0voXyzQvyKnJ1jxMioaHzHUTBBQLE
 30iUqdHCGyC+phIAD2uaXwdOkSE0ejKAXxApe186F01UocgEIfIrQPXfPCnV9aNIEnnSnJ
 JLgQNeRTMFHCLJazv4wc6wGHWIFkIQY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-KoDcIrDuPTSR76STCQNNpg-1; Wed,
 11 Nov 2026 09:02:40 -0500
X-MC-Unique: KoDcIrDuPTSR76STCQNNpg-1
X-Mimecast-MFC-AGG-ID: KoDcIrDuPTSR76STCQNNpg_1794405759
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBFF518004FE; Wed, 11 Nov 2026 14:02:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77071410; Wed, 11 Nov 2026 14:02:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1540E21E6A04; Wed, 11 Nov 2026 15:02:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  David Hildenbrand
 <david@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <20261102122336.2f564b26@imammedo> (Igor Mammedov's message of
 "Mon, 2 Nov 2026 12:23:36 +0100")
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com> <87ecdbbq93.fsf@pond.sub.org>
 <20261102122336.2f564b26@imammedo>
Date: Wed, 11 Nov 2026 15:02:36 +0100
Message-ID: <87o6bvtqir.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Igor Mammedov <imammedo@redhat.com> writes:

> On Tue, 27 Oct 2026 07:40:24 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>> David, Igor, can you clean this up?  Or would you like me to try?
>
> Please go ahead, I'm not likely to have bandwidth for upstream ATM. 

Posted:

    Subject: [PATCH 0/7] backends/hostmem: Make QOM types and properties unconditional
    Date: Wed, 11 Nov 2026 13:23:35 +0100
    Message-ID: <20261111122342.634370-1-armbru@redhat.com>


