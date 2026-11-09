Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F7606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JOEiWCAw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQNp-0005dk-3H; Mon, 09 Nov 2026 09:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQNT-0005T6-1a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQQNR-0003rj-Ba
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794234578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjayitvpK+RuIcoheEEHrCfH68raRoPPvO3X1dCoBmA=;
 b=JOEiWCAwkFnRFulPGzP7d38UIoHKN41Ac+Ktccr5C7qn99Naypu+3ZJ8ETcP7mxo8ZsJYs
 hZcrXDMSaVQ1lP2ofvmfwRRxjHozjTwwLp7aLjEL0Qga4IUiaSbMF0BvONWu61pr/7DF64
 mnaKK2+Hk9Pwe9f6GsSSeXoLw2p2yuU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-aBPsUiroOiyXU00l20MvAQ-1; Mon,
 09 Nov 2026 09:29:34 -0500
X-MC-Unique: aBPsUiroOiyXU00l20MvAQ-1
X-Mimecast-MFC-AGG-ID: aBPsUiroOiyXU00l20MvAQ_1794234573
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A13371800544; Mon,  9 Nov 2026 14:29:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4743230000E5; Mon,  9 Nov 2026 14:29:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0174221E6A04; Mon, 09 Nov 2026 15:29:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@kernel.org>,  Igor
 Mammedov <imammedo@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
In-Reply-To: <ats0_RfeVugAofN9@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 23 Oct 2026 11:20:45 +0100")
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
Date: Mon, 09 Nov 2026 15:29:30 +0100
Message-ID: <87qzgu2i45.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
>> My build of qemu-system-x86_64 has device sgx-epc:
>>=20
>>  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc"=
}}
>>  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
>>=20
>> The device as a link property to a memory-backend-epc:
>>=20
>>  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-e=
pc"}}
>>  <-- {"return": [...
>>                  {"name": "memdev", "type": "link<memory-backend-epc>"},
>>                  ...]}
>>=20
>> However, type memory-backend-epc does not exist:
>>=20
>>  --> {"execute": "qom-list-types", "arguments": {"implements": "memory-b=
ackend"}}
>>  <-- {"return": [{"name": "memory-backend-ram", "parent": "memory-backen=
d"}, {"name": "memory-backend-file", "parent": "memory-backend"}, {"name": =
"memory-backend-memfd", "parent": "memory-backend"}, {"name": "memory-backe=
nd-shm", "parent": "memory-backend"}]}
>
> There is some rather dubious code that conditionally registers
> the type
>
> static void register_types(void)
> {
>     int fd =3D qemu_open_old("/dev/sgx_vepc", O_RDWR);
>     if (fd >=3D 0) {
>         close(fd);
>
>         type_register_static(&sgx_epc_backed_info);
>     }
> }
>
>
> Normal practice is for types to be unconditionally registered.  Do we
> have any examples outside of this SGX case where we conditionally
> register types ?   Should we change this to follow normal practice ?

Loosely related: conditional *class* properties.  Example:

    static void
    memfd_backend_class_init(ObjectClass *oc, const void *data)
    {
        HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);

        bc->alloc =3D memfd_backend_memory_alloc;

        if (qemu_memfd_check(MFD_HUGETLB)) {
            object_class_property_add_bool(oc, "hugetlb",
                                           memfd_backend_get_hugetlb,
                                           memfd_backend_set_hugetlb);
            object_class_property_set_description(oc, "hugetlb",
                                                  "Use huge pages");
            object_class_property_add(oc, "hugetlbsize", "uint64",
                                      &uint64_type_info,
                                      memfd_backend_get_hugetlbsize,
                                      memfd_backend_set_hugetlbsize,
                                      NULL, NULL);
            object_class_property_set_description(oc, "hugetlbsize",
                                                  "Huge pages size (ex: 2M,=
 1G)");
        }

        [...]
    }

These properties are also declared in qapi/qom.json if CONFIG_LINUX.
QAPI introspection (query-qmp-schema) shows them then.  QOM
introspection (qom-list-properties etc.) only shows them when the
MFD_HUGETLB check succeeded.

Feels undesirable to me.

Should we instead make them read-only when the check fails?


