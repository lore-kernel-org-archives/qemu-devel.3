Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2847CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 04:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUGpC-0005ey-He; Tue, 02 Jun 2026 00:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUGpA-0005eU-SP
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUGp9-0004eK-8I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 00:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780374834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+efnebQxO0RbZLNT5rADfunKjLe1/NxjHosxYzzRBUU=;
 b=aCxOTV0B/M59oT64hjKsjjJMBLC9nq6c+Z5k6I51fnmFsXE2vUexrCQJbg9LXrjznOBZcg
 moTDLTPXUVmmLiVr/l05PAwXMO3lSYIB4pPOGG9nXx/8Ah5znCb2brH8HvTUmDAXCkq6gW
 Wfbpa9eCW5+2RpEfwFrMYysysRAggs8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-QB27piITNFmcXYjg1ubGCQ-1; Tue,
 02 Jun 2026 00:33:50 -0400
X-MC-Unique: QB27piITNFmcXYjg1ubGCQ-1
X-Mimecast-MFC-AGG-ID: QB27piITNFmcXYjg1ubGCQ_1780374829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDAB61956053; Tue,  2 Jun 2026 04:33:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBC3D30001A2; Tue,  2 Jun 2026 04:33:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D54521E6A01; Tue, 02 Jun 2026 06:33:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/5] qemu-options: fix missing addr. prefix on -netdev
 stream inet/unix options
In-Reply-To: <20260524073442.435408-2-Mitsuru.Kariya@oss.nttdata.com> (Mitsuru
 Kariya's message of "Sun, 24 May 2026 16:34:38 +0900")
References: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
 <20260524073442.435408-2-Mitsuru.Kariya@oss.nttdata.com>
Date: Tue, 02 Jun 2026 06:33:45 +0200
Message-ID: <8733z5a7di.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com> writes:

> -netdev stream uses modern syntax parsed by netdev_parse_modern() which
> goes through the QAPI keyval visitor (qobject_input_visitor_new_str() ->
> keyval_parse() -> qobject_input_visitor_new_keyval() -> visit_type_Netdev()).
> Options nested under addr (of type SocketAddress) must therefore be
> written with the "addr." prefix: a top-level "keep-alive=on" is rejected
> by the QAPI input visitor with "Parameter 'keep-alive' is unexpected",
> because NetdevStreamOptions has no such member.
>
> The documentation listed several InetSocketAddress members (to, numeric,
> keep-alive, mptcp, ipv4, ipv6) and UnixSocketAddress members (abstract,
> tight) without the prefix, which never actually worked.  Only
> addr.type/addr.host/addr.port/addr.path/addr.str were spelled correctly
> in the synopsis.
>
> Add the missing addr. prefix to all affected option names.
>
> Fixes: bb1326abd9df ("net: update netdev stream/dgram man page")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


