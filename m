Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E3CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaAB-000684-NE; Mon, 08 Jun 2026 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWa9P-00065B-AN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWa9M-0006PN-Rr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEhB5J/m8mgVV+kh6n0LLvbd+zdrpCATTf8w3l+ryfk=;
 b=GfO8K8doZa1McWTboROlgzNsLRswipiE5UKLcBo3b84DWOYhd3Xiops/JCrW3nhQ177Vqe
 OyGLVVRhpHVIqS4DYAdIcMTMaXC7cMzNkX7862VXeAJVPuwYj1Jw1/ItaD7qO/Kb5vOFWW
 +fGzho6jeBBHbmIXxz5Vgpt47nQxIbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-db76uBcRM4ufi_lJJoliUA-1; Mon,
 08 Jun 2026 09:36:14 -0400
X-MC-Unique: db76uBcRM4ufi_lJJoliUA-1
X-Mimecast-MFC-AGG-ID: db76uBcRM4ufi_lJJoliUA_1780925771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912821955DBB; Mon,  8 Jun 2026 13:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580581800367; Mon,  8 Jun 2026 13:36:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5DF021E6A01; Mon, 08 Jun 2026 15:36:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  David Hildenbrand <david@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  qemu-rust@nongnu.org,
 Alex Williamson
 <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,  Fabiano Rosas
 <farosas@suse.de>,  Mark Kanda <mark.kanda@oracle.com>,  Ben Chaney
 <bchaney@akamai.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
In-Reply-To: <aiLO7ZQvowWHwK63@gallifrey> (David Alan Gilbert's message of
 "Fri, 5 Jun 2026 13:28:13 +0000")
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
 <aiLO7ZQvowWHwK63@gallifrey>
Date: Mon, 08 Jun 2026 15:36:06 +0200
Message-ID: <875x3ttard.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> Add a new 'info ramblock-attributes' HMP command and the corresponding
>> 'x-query-ramblock-attributes' QMP command to display the shared/private
>> memory attributes for ram blocks.
>>=20
>> The QMP command returns structured data (RamBlockAttributesInfo list
>> with per-range shared/populated attributes), while HMP formats it for
>> human consumption.
>>=20
>> This is useful for debugging confidential guests (TDX, SNP) to inspect
>> which memory regions are shared vs private, and their population state
>> when a RamDiscardManager is present (e.g. virtio-mem).
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
>>  include/monitor/hmp.h         |  1 +
>>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>>  system/ram-block-attributes.c | 71 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  hmp-commands-info.hx          | 13 ++++++++
>>  5 files changed, 173 insertions(+)
>>=20
>
> <snip>
>
> For HMP,
>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
>
> however, you might consider whether it would be better to add it
> to the existing "info ramblock"

Valid suggestion.

HMP "info ramblock" wraps around QMP x-query-ramblock, which returns
HumanReadableText.

HMP "info ramblock-attributes" wraps around QMP
x-query-ramblock-attributes, which returns a list of
RamBlockAttributesInfo.

So, basic x-query-ramblock returns unstructured text, and
x-query-ramblock-attributes returns structured data.  Hmm.  Feels a bit
odd.

[...]


