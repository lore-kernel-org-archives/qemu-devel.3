Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5093606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iYc5oB9D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmcK-0000aO-TQ; Thu, 22 Oct 2026 02:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJmcI-0000YD-5d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJmcF-0004aR-Hc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792651770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lArC7Nt6Avq1n/8C/Ll+Du0fnsulmEPTNsihfxjq4so=;
 b=iYc5oB9Dl7CW0DUBrh6e5Vd6Qyam2SPi4c69+61+KVDU7+vkfIPL4cP/+Zlvc7vPVu5HEH
 CqForWFYzb4oV+0zcSj18A54JnRLRjPFHk5l/LIF3FZx78qskyvnuczjo5bBItA6eURj5t
 Aa36GwDRy7JRB8k3CMCSdyzbrEzRxFc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-9wIN8bqtNjm5ZsV_6-4TKQ-1; Thu,
 22 Oct 2026 06:49:26 +0000
X-MC-Unique: 9wIN8bqtNjm5ZsV_6-4TKQ-1
X-Mimecast-MFC-AGG-ID: 9wIN8bqtNjm5ZsV_6-4TKQ_1792651761
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E93719560B2; Thu, 22 Oct 2026 06:49:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 725C81803A48; Thu, 22 Oct 2026 06:49:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B3A121E6A04; Thu, 22 Oct 2026 08:49:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: devel@lists.libvirt.org
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kostiantyn
 Kostiuk
 <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Igor Mammedov <imammedo@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  Alberto
 Garcia <berto@igalia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>,  Anisa Su <anisa.su@samsung.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org,  linux-cxl@vger.kernel.org,
 qemu-s390x@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Sergio
 Lopez <slp@redhat.com>,  qemu-arm@nongnu.org,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org,  Song Gao <17746591750@163.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Xianglai Li <lixianglai@loongson.cn>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,  Nicholas Piggin
 <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,  Amit
 Machhiwal <amachhiw@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhang Chen
 <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Alistair
 Francis <alistair@alistair23.me>,  Alexander Graf <graf@amazon.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  Ani Sinha <anisinha@redhat.com>,  Luc Michel
 <luc@lmichel.fr>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Jamin
 Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Samuel
 Tardieu <sam@rfc1149.net>,  "Denis V. Lunev" <den@openvz.org>,  FangSheng
 Huang <FangSheng.Huang@amd.com>,  Tyrone Ting <kfting@nuvoton.com>,  Hao
 Wu <wuhaotsh@google.com>,  Keith Busch <kbusch@kernel.org>,  Klaus Jensen
 <its@irrelevant.dk>,  Jesper Devantier <foss@defmacro.it>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Conor
 Dooley <conor@kernel.org>,  Sebastian Huber
 <sebastian.huber@embedded-brains.de>,  Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Titus Rwantare <titusr@google.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  Peter Xu <peterx@redhat.com>,  Chinmay Rath
 <rathc@linux.ibm.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
 xen-devel@lists.xenproject.org,  Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,  Fam Zheng <fam@euphon.net>,
 Farhan Ali <alifm@linux.ibm.com>,  Alex Williamson <alex@shazbot.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Yoshinori Sato <yoshinori.sato@nifty.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Eric Auger <eric.auger@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>
Subject: Re: Property types changed in this series
In-Reply-To: <87tsmfkoej.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 21 Oct 2026 18:29:40 +0200")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87tsmfkoej.fsf@pond.sub.org>
Date: Thu, 22 Oct 2026 08:49:12 +0200
Message-ID: <878q3qkz6f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Libvirt developers: does libvirt use member @type of the reply of
qom-list, qom-list-properties, qom-list-get?

I'm asking because Marc-Andr=C3=A9's work changes many values to add a more
useful replacement.  I think we should deprecate @type.  I'd like to
find out whether we need to preserve the values for the deprecation
grace period.

Markus Armbruster <armbru@redhat.com> writes:

> I used qom-list-types and qom-list-properties to list all properties and
> their types, then looked for changes.  This can miss changes in
> dynamically created properties; see the note on qom-list-properties in
> qapi/qom.json.  Moreover, I ran into a few QOM types where
> qom-list-properties is broken.

These are ast2700-a1, ast2700-a2, and several riscv CPUs.  A fix for the
latter has been queued.

> 1. Close misses of QAPI type names change to actual QAPI type names
>
>     old property type           new property type
>     ---------------------------------------------
>     string                      str
>     uint64_t                    uint64
>     uint64_t                    size
>     int32_t                     int32
>     int                         size
>     uint32_t                    uint32
>     [uint16]                    uint16List
>     NotifyVMexitOption          NotifyVmexitOption
>     CXLFixedMemoryWindow        CXLFixedMemoryWindowOptionsList
>
> 2. Incorrect QAPI type names change to correct ones
>
>     old property type           new property type
>     ---------------------------------------------
>     SgxEPC                      SgxEPCList
>     QAuthZListRule              QAuthZListRuleList
>     X86CPUFeatureWordInfo       X86CPUFeatureWordInfoList
>     bool                        Pca9552LedState
>
> 3. Less than useful QAPI type names change to more useful ones
>
>     old property type           new property type
>     ---------------------------------------------
>     str                         Pca9552PinState
>     str                         Pca9554PinState
>
> 4. Lazy crap
>=20=20
>     old property type           new property type
>     ---------------------------------------------
>     list                        link<arm-cpu>List
>     list                        strList
>     list                        uint16List
>     list                        uint32List
>     list                        uint64List
>     list                        uint8List
>     struct                      any
>
>     I'm not sure the first one is what it should be.
>
>     I need to have a closer look at the last one.
>
> 5. Inventive crap
>=20=20=20
>     old property type           new property type
>     ---------------------------------------------
>     busnr                       uint8
>     guest statistics            VirtioBalloonGuestStats
>     loadparm                    str
>     on|off|split                OnOffSplit
>     struct tm                   StructTm
>
> 6. An odd duck
>
>     old property type           new property type
>     ---------------------------------------------
>     str                         int32
>
>     This is pci-device property addr.  See PATCH 54.
>
> On the way, I noted properties with anti-social names:
>
>     QOM type name       property name
>     ---------------------------------
>     acpi-ged            memhp container[0]
>     e500-spin           e500 spin pv device[0]


