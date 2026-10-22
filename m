Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y1RAI2r6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJkiS-0003GM-Jh; Thu, 22 Oct 2026 00:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xJkiP-0003F0-Oy
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xJkiN-0001PV-I4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 00:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792644461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dItPU84HwxTFS4lQIuE+WlGML9kLKO6IFhbyWEIdIDQ=;
 b=Y1RAI2r6/z91Pt5UkbJ06IJEun6S/cWv8Aj69G81O/GJijiCyScxRpPN14ZbyT+bTdKmST
 5DxsR+dkPoAiIZmPnhJ3WX48AID8xJ/ZEpTbetyhfyg1QIXuEjQrv6RyclHiN8SyEBd4N0
 Zzz84E6wquDZShFtPIQChjiUqi+lrY8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-7pQmmS0dNJGlEv-HmpyDgw-1; Thu,
 22 Oct 2026 04:47:37 +0000
X-MC-Unique: 7pQmmS0dNJGlEv-HmpyDgw-1
X-Mimecast-MFC-AGG-ID: 7pQmmS0dNJGlEv-HmpyDgw_1792644452
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0405C1955D4E; Thu, 22 Oct 2026 04:47:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1CD30000E3; Thu, 22 Oct 2026 04:47:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Richard Henderson
 <richard.henderson@linaro.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Bernhard
 Beschow <shentey@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Paul Durrant <paul@xen.org>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Walk
 <bwalk@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-s390x@nongnu.org, David Woodhouse
 <dwmw2@infradead.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-ppc@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu
 <chao.liu@processmission.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao
 Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 00/23] kvm: introduce KVMCPUOps
In-Reply-To: <80b593cf-77e0-4623-8059-937c51dd5cfd@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
 <87se2039dn.fsf@draig.linaro.org>
 <80b593cf-77e0-4623-8059-937c51dd5cfd@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Thu, 22 Oct 2026 06:47:24 +0200
Message-ID: <87jyna2vfn.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21 2026, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 10/20/26 13:21, Alex Benn=C3=A9e wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> There is a world coming where we can have a KVM interface which
>>> supports multiple architectures. The old style approach of using
>>> linking to resolve per arch kvm_arch_foo handlers won't scale and is
>>> also slightly antithetical to the flexible not-quite object orientated
>>> way we do things in QEMU.
>>=20
>> In case it's not obvious I intended the prefix to be RFC as it needs
>> discussion ;-)
> This generally seems like a good idea, but would this be needed for the=20
> arm-on-s390 support?  Would it use the "single binary" support or would=20
> there be simply two system emulators with KVM support,=20
> qemu-system-aarch64 and qemu-system-s390x?

What would make the most sense logically to me is to use
qemu-system-aarch64 to launch an aarch64 machine and qemu-system-s390x
to launch an s390x machine (at least from an user perspective.) That
said, I haven't looked at this series yet, but it does sound like a good
idea in general regardless of how we plan to launch different arch guests.


