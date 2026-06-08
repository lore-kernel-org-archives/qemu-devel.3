Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EAFCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWa3Z-00042Z-JU; Mon, 08 Jun 2026 09:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWa3U-00042F-OH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWa3S-0002fu-TE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yydCoCed6+ynC97mmYPUNt3OveMLiukoasGjhCjXbws=;
 b=Q3zdO+9E1szMxUevPsmyFbF8id1oqy3ag8R9kJNRD0bm720RU3gO3VEpGOfU1BvVSyF81F
 DpA+LGERykHT2TVjmnli7u2MlxvBISe/2F5tHr9AoH4Ekz5jCVpeGEY0ZQZDzJrSHxsIif
 kmRWf9kTu6WYOlc6Xgl5E9lBaKqSjnI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-LpNAokFvMyyu7BAMMXaYIw-1; Mon,
 08 Jun 2026 09:30:09 -0400
X-MC-Unique: LpNAokFvMyyu7BAMMXaYIw-1
X-Mimecast-MFC-AGG-ID: LpNAokFvMyyu7BAMMXaYIw_1780925406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E1281955F6A; Mon,  8 Jun 2026 13:30:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A7F19560A6; Mon,  8 Jun 2026 13:30:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4088E21E6A01; Mon, 08 Jun 2026 15:30:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  David Hildenbrand
 <david@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 qemu-rust@nongnu.org,  Alex Williamson <alex@shazbot.org>,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>,  "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>,  Fabiano Rosas <farosas@suse.de>,  Mark
 Kanda <mark.kanda@oracle.com>,  Ben Chaney <bchaney@akamai.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
In-Reply-To: <20260604-rdm5-v5-12-5768e6a0943d@redhat.com> (=?utf-8?Q?=22M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau"'s message of "Thu, 04 Jun 2026 17:43:58 +0400")
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
Date: Mon, 08 Jun 2026 15:30:02 +0200
Message-ID: <87a4t5tb1h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a new 'info ramblock-attributes' HMP command and the corresponding
> 'x-query-ramblock-attributes' QMP command to display the shared/private
> memory attributes for ram blocks.
>
> The QMP command returns structured data (RamBlockAttributesInfo list
> with per-range shared/populated attributes), while HMP formats it for
> human consumption.
>
> This is useful for debugging confidential guests (TDX, SNP) to inspect
> which memory regions are shared vs private, and their population state
> when a RamDiscardManager is present (e.g. virtio-mem).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
>  include/monitor/hmp.h         |  1 +
>  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>  system/ram-block-attributes.c | 71 +++++++++++++++++++++++++++++++++++++=
++++++
>  hmp-commands-info.hx          | 13 ++++++++
>  5 files changed, 173 insertions(+)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b87..a1af5c61176 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1738,6 +1738,62 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>=20=20
> +##
> +# @RamBlockAttributeRange:
> +#
> +# A contiguous range within a ram block with uniform attributes.

RAM please.  More of the same below, not flagging it again.

> +#
> +# @start: start offset in bytes within the ram block
> +#
> +# @length: length in bytes of the range
> +#
> +# @shared: true if the range is shared, false if private

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "range is shared" means?

> +#
> +# @populated: true if the entire range is fully populated across all
> +#     RamDiscardManager sources; false if any sub-block is discarded.
> +#     Only present when a RamDiscardManager is managing the block.

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "a RamDiscardManager is managing the block" means?

I can't find anything about RamDiscardManager in docs.  Would it make
sense to have something there, so we can point to it here?

> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributeRange',
> +  'data': { 'start': 'uint64',
> +            'length': 'uint64',
> +            'shared': 'bool',
> +            '*populated': 'bool' } }
> +
> +##
> +# @RamBlockAttributesInfo:
> +#
> +# Shared/private memory attributes for a ram block.
> +#
> +# @name: the ram block identifier

Apparently, this is a memory region name, obtained with
memory_region_name().  Correct?

If yes, then what about "@name: the memory region name"?  Or maybe "the
name of the RAM block's memory region"?

> +#
> +# @ranges: list of attribute ranges
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RamBlockAttributesInfo',
> +  'data': { 'name': 'str',
> +            'ranges': [ 'RamBlockAttributeRange' ] } }
> +
> +##
> +# @x-query-ramblock-attributes:
> +#
> +# Query ram block shared/private attributes.  This is useful
> +# to debug confidential guests.

Ignorant question: how are RAM blocks related to memory regions?

> +#
> +# Features:
> +#
> +# @unstable: This command is meant for debugging.
> +#
> +# Returns: list of ram block attributes
> +#
> +# Since: 11.1
> +##
> +{ 'command': 'x-query-ramblock-attributes',
> +  'returns': [ 'RamBlockAttributesInfo' ],
> +  'features': [ 'unstable' ] }
> +
>  ##
>  # @x-query-roms:
>  #

[...]


