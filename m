Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE738C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB560-00058j-1a; Mon, 28 Sep 2026 02:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB55y-00058b-Qt
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB55x-0007R9-AP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790577851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJoQlMDxpXOT5ImliZgvbA3UDLQbaLrARQfqeuX9HEo=;
 b=SNaE4WkTUz7p85Od/hJ6AoQoZJAyQwZxyq142V/uKPYjl/vpw68XFs7tp8+TLHAZqWBtqW
 BWepBre3wNqC2SPQkvkWWQ3Yayz3+iWadj+2is4Kjf3iCYJRWB8EWt1uE77KzSc1wvo1yG
 ySyJW7ziRXGIZy/m1XYMK4bI4qJRYb0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-rrRc_G7kMlSXJfFfZLGzKw-1; Mon,
 28 Sep 2026 02:44:09 -0400
X-MC-Unique: rrRc_G7kMlSXJfFfZLGzKw-1
X-Mimecast-MFC-AGG-ID: rrRc_G7kMlSXJfFfZLGzKw_1790577846
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6352D195396A; Mon, 28 Sep 2026 06:44:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 413341956086; Mon, 28 Sep 2026 06:44:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB38421E6A04; Mon, 28 Sep 2026 08:44:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Chao Liu <chao.liu@processmission.com>,  Eric
 Blake <eblake@redhat.com>,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Stafford Horne <shorne@gmail.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Fabiano Rosas <farosas@suse.de>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  qemu-riscv@nongnu.org,  Laurent
 Vivier <lvivier@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Song Gao
 <17746591750@163.com>,  Philippe Mathieu-Daude <philmd@mailo.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Laurent Vivier <laurent@vivier.eu>,  Weiwei
 Li <liwei1518@gmail.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 09/10] qapi: return MachineInfo typename from
 query-machines
In-Reply-To: <20260926081551.29-10-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Sat, 26 Sep 2026 16:15:49 +0800")
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-10-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 08:44:01 +0200
Message-ID: <87pkxxj2oe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> query-machines returned only the -M name, so management apps inferred
> the QOM type as that name plus "-machine". A prefixed type such as
> arm-virt-11.1-machine no longer matches -M virt-11.1. Return the QOM
> type in MachineInfo typename from object_class_get_name() in
> qmp_query_machines(). test_query_machines_typename checks that
> qom-list-properties accepts it.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


