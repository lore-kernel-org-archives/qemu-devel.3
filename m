Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E0BC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Gl5-0007lF-UC; Tue, 01 Sep 2026 01:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1Gl4-0007l7-Qo
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1Gl2-0002WW-V7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788239402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnfXRlAcJrwfTCB8n5BaIdWM6kMvbaIRnSci+GXe2Ow=;
 b=MJP8vh+5Js9eo+a56LVzDarNHcHXRwrWBdTWktC18NZPok1QwJtD/fX1l6zjUUEDpMtIc1
 5jWx8aFmFqlQuRbrUUbdp5nXZtsyieWH422QPj8jcBQwFzGlN9OuZ2n74iPr1m16h+7XhH
 YdOAhUII/Hy+yY+r9k3CBSOmRTIaHDc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-d0QNJnR5NCCnWwMPD2BDvg-1; Tue,
 01 Sept 2026 01:09:59 -0400
X-MC-Unique: d0QNJnR5NCCnWwMPD2BDvg-1
X-Mimecast-MFC-AGG-ID: d0QNJnR5NCCnWwMPD2BDvg_1788239394
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B74981955DC3; Tue,  1 Sep 2026 05:09:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22F831803A55; Tue,  1 Sep 2026 05:09:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD7D321E6832; Tue, 01 Sep 2026 07:09:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "BillXiang" <xiangwencheng@lanxincomputing.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  "Albert Esteve" <aesteve@redhat.com>,  "Alberto
 Faria" <afaria@redhat.com>,  "Alessandro Di Federico" <ale@rev.ng>,
 "Alistair Francis" <alistair.francis@wdc.com>,  "Anton Johansson"
 <anjo@rev.ng>,  "Markus Armbruster" <armbru@redhat.com>,  "Brian Cain"
 <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  "Chao
 Peng" <chao.p.peng@linux.intel.com>,  <cjia@nvidia.com>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater
 <clg@redhat.com>,  <cw@f00f.org>,  <dbarboza@qti.qualcomm.com>,  "Demi
 Marie Obenour" <demiobenour@gmail.com>,  <dhedde@kalrayinc.com>,  "Eric
 Blake" <eblake@redhat.com>,  <eblot@rivosinc.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  "Eduardo Habkost" <eduardo@habkost.net>,
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>,  "Auger Eric"
 <eric.auger@redhat.com>,  <felipe@nutanix.com>,
 <helge.deller@googlemail.com>,  "Alyssa Ross" <hi@alyssa.is>,
 <iggy@theiggy.com>,  "Warner Losh" <imp@bsdimp.com>,
 <jacob.oursland@gmail.com>,  "Jan Kiszka" <jan.kiszka@web.de>,  "Jason
 Gunthorpe" <jgg@nvidia.com>,  <jidong.xiao@gmail.com>,  "Jim Shu"
 <jim.shu@sifive.com>,  "Joao Martins" <joao.m.martins@oracle.com>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,  "Luc Michel"
 <luc@lmichel.fr>,  "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 <matthieu@minio.io>, "Max Chou" <max.chou@sifive.com>,  "Mark Burton"
 <mburton@qti.qualcomm.com>,  "Ho, Nelson" <nelson.ho@windriver.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Peter Maydell" <peter.maydell@linaro.org>,  "QEMU
 Developers" <qemu-devel@nongnu.org>,  "Roberto Campesato" <rbc@meta.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,  "Shameerali Kolothum
 Thodi" <shameerali.kolothum.thodi@huawei.com>,  "Bernhard Beschow"
 <shentey@gmail.com>,  "Stefan Hajnoczi" <stefanha@gmail.com>,  "Thomas
 Huth" <thuth@redhat.com>,  <utsingh@redhat.com>,  "Wei Wang"
 <wei.w.wang@intel.com>,  <z.huo@139.com>,  "LIU Zhiwei"
 <zhiwei_liu@linux.alibaba.com>,  <zwu.kernel@gmail.com>,
 <peterx@redhat.com>
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
In-Reply-To: <930ccce8-a520-4387-82ed-982f2b824505@lanxincomputing.com>
 (BillXiang's message of "Tue, 1 Sep 2026 10:07:06 +0800")
References: <877bl6eoqv.fsf@draig.linaro.org>
 <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
 <48cef34d-18c1-4b8c-a75d-19d1d1321634@oss.qualcomm.com>
 <930ccce8-a520-4387-82ed-982f2b824505@lanxincomputing.com>
Date: Tue, 01 Sep 2026 07:09:45 +0200
Message-ID: <87jyp5blra.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"BillXiang" <xiangwencheng@lanxincomputing.com> writes:

> On 8/31/2026 11:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 31/8/26 13:49, BillXiang wrote:
>>=20
>>> How about discussing the patch[1]:
>>> "virtio: Add aligned ld/st accessors for vring".
>>>
>>> As pointed out in the patch, this has been a long-standing issue. It is
>>> now necessary to introduce atomic accessors for fields that require
>>> atomicity, such as the avail_idx field in virtio. This support is
>>> especially crucial for architectures like RISC-V, which do not natively
>>> support misaligned memory accesses.
>>>
>>> I'm particularly eager to receive more suggestions for it.
>>=20
>> This is a very technical topic, not sure if the community call will
>> be a better place than the mailing list, in particular if no virtio /
>> atomic expert developers appears. We'll see :)
>
> Sorry, I'm not yet familiar with the community call process. If this=20
> isn't for technical topic, please feel free to disregard my message.

The technical conversation with reviewers starts on the mailing list,
where it's asynchronous, public, and archived.

Occasionally, this gets stuck in ways that a call can resolve best.  The
community call is an option then.  Make sure that the right people
attend.  Do consider scheduling a separate call instead, to not bore the
"wrong" people on the community call.

[...]


