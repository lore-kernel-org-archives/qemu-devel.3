Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3589FC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNJC-0002bq-5O; Mon, 14 Jul 2025 13:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a886bafff4ae5a00747a+7995+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1ubMFS-0002Ir-TK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:41:51 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a886bafff4ae5a00747a+7995+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1ubMFK-0006pL-0y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=lLEp+/J9pyCnuWXEMcBv4njSSDRIuiy1dbMgL/lhgrw=; b=heGrVJ3fNBfhGsasi7ZEkYK8L1
 sWK6kafnN3TFu/rqZlKk9kvSYot0lq+ShBFLoG4RJ82NNT3uG1SN26D2zgzGjlrYneTDlR3ATIp9l
 fULm04ekAwIA17Yspfvl/t5rWTXdec5ESxOTgm6T3HbgZ5+JXJpEY8gmGwA8tWqyNtX2WG78tIqdr
 gKni665E3nSf+h+TiU1s157OZms6PjQbkdLuiGOcebltSH8tnRsEpvNaJ3hnR5MakUaFihrciNvQI
 ehZW850RSYpYHa2N6NlG0WFiZxhlJERNdi0srDzPllKBs6soSENGN+MtQHlTWAKwCwM23hzfS7geR
 dGEMjtFA==;
Received: from [31.94.34.59] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1ubMF2-00000009mjE-2EaF; Mon, 14 Jul 2025 16:41:26 +0000
Date: Mon, 14 Jul 2025 17:41:22 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Le Tan <tamlokveer@gmail.com>,
 kib <kib@freebsd.org>, jhb@freebsd.org
CC: =?ISO-8859-1?Q?Cl=E9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_intel=5Fiommu=3A_Allow_both_S?=
 =?US-ASCII?Q?tatus_Write_and_Interrupt_Flag_in_QI_wait?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
Message-ID: <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+a886bafff4ae5a00747a+7995+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi=2El=2Eliu@intel=2Ecom> wrote=
:
>Hi David,
>
>On 2025/7/14 16:00, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> FreeBSD does both, and this appears to be perfectly valid=2E The VT-d
>> spec even talks about the ordering (the status write should be done
>> first, unsurprisingly)=2E
>
>interesting=2E Have you tried setting both flags on baremetal and the hw
>gives you both the status code and an interrupt?

I see no reason why it shouldn't=2E The spec (=C2=A76=2E5=2E2=2E8) gives n=
o that the IF and SW bits should be mutually exclusive and even talks about=
 ordering:

Section 6=2E5=2E2=2E11 describes queued invalidation ordering consideratio=
ns=2E Hardware completes an=20
invalidation wait command as follows:
=E2=80=A2 If a status write is specified in the wait descriptor (SW=3D1), =
hardware performs a coherent write of=20
the status data to the status address=2E
=E2=80=A2 If an interrupt is requested in the wait descriptor (IF=3D1), ha=
rdware sets the IWC field in the=20
Invalidation Completion Status Register=2E An invalidation completion inte=
rrupt may be generated as=20
described in the following section



>I think this "if branch" can be moved just after the inv_desc non-zero
>reserved bit checking=2E Hence you don't need a ret at all=2E :)

We want to return false if the memory write fails, and the interrupt has t=
o happen afterwards=2E

> btw=2E I'm
>also asking if VT-d spec allows it or not=2E So let's wait for a while=2E=
=2E

Ok=2E



