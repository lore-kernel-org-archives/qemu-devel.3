Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F26C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5Q1-0008DT-Vu; Mon, 19 Feb 2024 10:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5Q0-0008D4-Ag
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5Py-0004WD-RH
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708355934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fu8/Mt2aSHQuTJ845USkw9KXJ7rUafATcJ5jr+Y/klA=;
 b=exlpeZbSO3jxAFn54wfjQNs04yhxxEbOYHffNGIWDKvVh/dI4cyTh+f+JIlQvPDCgfXQn9
 Os5uEafR5X0owKuvtCAxNuZhRdlX67cPE69KpHw3f+2UYB8ra23qI8OSUHkl4ly74LgylM
 G3YrrfzFBmDTpEVMhYJtGcMWvI8JU48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-8lCE89LmM_ie_TvEAQDJqg-1; Mon, 19 Feb 2024 10:18:50 -0500
X-MC-Unique: 8lCE89LmM_ie_TvEAQDJqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D1EE10AF98A;
 Mon, 19 Feb 2024 15:18:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B0D12166B34;
 Mon, 19 Feb 2024 15:18:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3971821E6767; Mon, 19 Feb 2024 16:18:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to
 numeric encoding
In-Reply-To: <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Fri, 2 Feb 2024 22:32:15 +0800")
References: <cover.1706883915.git.yong.huang@smartx.com>
 <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
Date: Mon, 19 Feb 2024 16:18:43 +0100
Message-ID: <87plwsiiss.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hyman Huang <yong.huang@smartx.com> writes:

> x-query-virtio-status returns several sets of virtio feature and
> status flags.  It goes back to v7.2.0.
>
> In the initial commit 90c066cd682 (qmp: add QMP command
> x-query-virtio-status), we returned them as numbers, using virtio's
> well-known binary encoding.
>
> The next commit f3034ad71fc (qmp: decode feature & status bits in
> virtio-status) replaced the numbers by objects.  The objects represent
> bits QEMU knows symbolically, and any unknown bits numerically just like
> before.
>
> Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command

added the matching HMP command

> "info virtio" (and a few more, which aren't relevant here).
>
> The symbolic representation uses lists of strings.  The string format is
> undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
> explanation".
>
> This symbolic representation is nice for humans.  Machines it can save
> the trouble of decoding virtio's well-known binary encoding.
>
> However, we sometimes want to compare features and status bits without
> caring for their exact meaning.  Say we want to verify the correctness
> of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
> QMP command x-query-virtio-status to retrieve vhost-user net device
> features, and the "ovs-vsctl list interface" command to retrieve
> interface features.  Without commit f3034ad71fc, we could then simply
> compare the numbers.  With this commit, we first have to map from the
> strings back to the numeric encoding.
>
> Revert the decoding for QMP, but keep it for HMP.
>
> This makes the QMP command easier to use for use cases where we
> don't need to decode, like the comparison above.  For use cases
> where we need to decode, we replace parsing undocumented strings by
> decoding virtio's well-known binary encoding.
>
> Incompatible change; acceptable because x-query-virtio-status does

Scratch "does".

> comes without a stability promise.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


