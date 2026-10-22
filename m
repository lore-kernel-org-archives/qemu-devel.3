Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8AA606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dIzFHeFL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJlqy-0008Bp-GK; Thu, 22 Oct 2026 02:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJlql-0008Az-Ff
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJlqi-000826-Ns
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792648822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBwf2+BMNU0rmevFLCns+WAs849EkmKj2ePNIPGtdvs=;
 b=dIzFHeFL100YeYNn+MKn30AWoZQVmsjquuu91hnznLVbByDBsuAacxUXleTDB9S7QlCPHZ
 CZ+JJPiDDIm3zaWJkYPSV4QrxXLAs/CEh3ZGK8nrEXruWNUnK49C98u4fngV+T6fM8EwyZ
 rvAeW3OvulTM6aYHSYVRoHEjOD7QB9Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-2WK9gxGNNmWzECh4rvaWBw-1; Thu,
 22 Oct 2026 06:00:17 +0000
X-MC-Unique: 2WK9gxGNNmWzECh4rvaWBw-1
X-Mimecast-MFC-AGG-ID: 2WK9gxGNNmWzECh4rvaWBw_1792648816
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BBB1800599; Thu, 22 Oct 2026 06:00:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D149D46C; Thu, 22 Oct 2026 06:00:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63CB621E6A04; Thu, 22 Oct 2026 08:00:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,
 alistair.francis@wdc.com,  liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com,  chao.liu@processmission.com,
 philmd@oss.qualcomm.com,  Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] target/riscv/cpu.c: duct tape fix for QMP + RV profiles
 introspection
In-Reply-To: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
 (Daniel Henrique Barboza's message of "Wed, 21 Oct 2026 14:31:38
 -0300")
References: <20261021173138.2388231-1-daniel.barboza@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 08:00:12 +0200
Message-ID: <87ecdil1g3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> writes:

> Maruks reported in [1] a problem with QMP introspection with
> qemu-system-riscv64 that happens after querying a profile CPU.  QEMU
> crashes hitting an abort during satp_mode logic that, somehow, is being
> triggered via profile code.
>
> For every profile CPU that goes through init we're setting an 'enabled'
> flag in the static RISCVProfile object.  This sounded like an okay idea
> back when profiles were introduced, but now we've realized that QMP will
> querying CPUs without exiting the QEMU process while also going multiple
> times through cpu_init() and friends.  The result is that we're in a
> situation where we have runtime information being stored in static arrays
> that persists between CPU definitions being introspected.
>
> A proper fix is to get rid of profile->enabled and turn profiles into
> cpu->cfg flags like we do with every other extension.  Unfortunately
> we've been using profile->enabled for lots of things and a redesign
> would be in order, one which I'm not comfortable doing right now - we're
> too close to the QEMU 11.2 code freeze for such a change.
>
> For now let's silver tape a fix in cpu_init() to reset profile->enabled
> for all available profiles.  We'll do a proper redesign in the next
> release cycle.
>
> [1] https://lore.kernel.org/qemu-devel/87ld7rmdi6.fsf@pond.sub.org/
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

That was quick, thank you!

Tested-by: Markus Armbruster <armbru@redhat.com>


