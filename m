Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5663606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gVxfmSMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLafr-0001qS-JP; Tue, 27 Oct 2026 02:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLafk-0001pm-Uv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLafh-00088I-9s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793082510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdyxn/88Lnb01SmqF7aVPO1XRx4I5EDa3qJzLSUt84M=;
 b=gVxfmSMdwLOrSexkxjoaY2DdWWNM/8/RbUGZG+/yjrhWSMAhwnqgKG4YWiPP0HKth+7kBx
 U32PDA/oJSootunv7rIw1y8bFh/5Js1XjSrDvfQ1Jh2oWSzCle8iLYQ/MfkY3VGOOmuwaG
 FNrHNhoBHaUObm27Ytbi+mP9QXsUjtg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-6orgKz9NNWmg3O8-BPoe7g-1; Tue,
 27 Oct 2026 02:28:27 -0400
X-MC-Unique: 6orgKz9NNWmg3O8-BPoe7g-1
X-Mimecast-MFC-AGG-ID: 6orgKz9NNWmg3O8-BPoe7g_1793082506
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A95141955F04; Tue, 27 Oct 2026 06:28:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49BED195608B; Tue, 27 Oct 2026 06:28:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD4F821E6A04; Tue, 27 Oct 2026 07:28:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  David
 Hildenbrand <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
 (Peter Maydell's message of "Fri, 23 Oct 2026 12:50:24 +0100")
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <attACqgQQ-Lxt5Pj@redhat.com>
 <CAFEAcA-2Zkw-xhZ59nAfFOEbGz8W2XSOdi8d4eD5F8U4T1YE-Q@mail.gmail.com>
Date: Tue, 27 Oct 2026 07:28:22 +0100
Message-ID: <87o6cfbqt5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 23 Oct 2026 at 12:08, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> The memory backends are all implementing the UserCreatable
>> interface, which provides a "complete" method where they
>> could gracefully report lack of the feature via 'errp'.
>
> I didn't realize UserCreatable was a thing. It seems unfortunate
> that we have accumulated three different kinds of object
> creation/destruction life cycle:

Yes.  See also "Problem 5: QOM lacks a clear life cycle" in

    Subject: Dynamic & heterogeneous machines, initial configuration: probl=
ems
    Date: Wed, 31 Jan 2024 21:14:21 +0100
    Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/=20=20=
=20=20

> - instance_init / instance_finalize

All QOM types (but some add to this protocol).

> - instance_init / realize / unrealize / instance_finalize

Device types, i.e. subtypes of "device".

> - instance_init / complete / prepare_delete / instance_finalize

User-createble object types, i.e. types that provide interface
"user-creatable".  No device type does that.

Related: machine init done notifiers.


