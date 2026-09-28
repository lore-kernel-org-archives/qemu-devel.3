Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB11EC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9kN-0002IE-HT; Mon, 28 Sep 2026 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB9kH-0002Fz-Qc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB9kF-0002wB-B4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790595725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lT/7dUd3Ns3Hv2bavTQFNjVEdK3MCpIQuBS+9fK13UY=;
 b=DQ/H26WjMfmULppNgU+OkwZfPmHMhIl3KdPsBQehd/3y7G4j8ctiUjI0Z65uu3bGC+laBU
 rvlx0CT2krrE9vnv5HdGMCEit2N7vZGFjg1T9yHAZLw0adaq2+jdmk4m/cNEHsSE7lYHCz
 d9ZxVdq+mpyHndtkoAP6qaiHrCW5/NY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-lQ4Kth-gPn6aKFylciYdQQ-1; Mon,
 28 Sep 2026 07:42:03 -0400
X-MC-Unique: lQ4Kth-gPn6aKFylciYdQQ-1
X-Mimecast-MFC-AGG-ID: lQ4Kth-gPn6aKFylciYdQQ_1790595721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 548BC195607C; Mon, 28 Sep 2026 11:42:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95EA81800345; Mon, 28 Sep 2026 11:42:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 362E721E6A04; Mon, 28 Sep 2026 13:41:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 40/55] meson: link shared objects into qemu-system
In-Reply-To: <20260926070057.1234-41-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Sat, 26 Sep 2026 15:00:39 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-41-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 13:41:58 +0200
Message-ID: <8733uthabd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> Extract common_ss, system_ss, and family-common objects into one
> qemu-system binary. Only arm, aarch64, microblaze-softmmu are
> listed; a new target must have arch_srcs equal to target_info_def
> only (target-info-def.c). Config headers stay in arch_genh.
>
> - Union non-TARGET_* keys with y taking precedence
> - Reject leftover arch_srcs on participating targets
> - Reject TARGET_* conditions on common_ss and system_ss
> - Link SDL, install the binary, and apply Darwin entitlements
>
> Adding a target that still has per-target sources fails meson, for
> example:
>
>   combined qemu-system leftover for :
>   expected:
>   target-info-def.c
>   arch_srcs:
>   target/microblaze/mmu.c
>   target/microblaze/machine.c
>   target-info-def.c
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Watch query-target lie:

    $ qemu-system -S -nodefaults -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "package": "v11.1.0-1902-g88f617913a"}, "capabilities": ["oob"]}}
    qemu-system: warning: nic xlnx.xps-ethernetlite.0 has no peer
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {'execute': 'query-target'}
--> {"return": {"arch": "aarch64"}}

Perhaps you can fix this by reordering patches.  If you can't,
deficiencies like this one need a prominent mention in the commit
message.


