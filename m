Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D78CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlrC-0008Jz-Nv; Mon, 05 Oct 2026 12:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xDlqO-0008AO-Gf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xDlqM-0001pb-Db
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791218833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfE4jn8R5CeMJqVd+Sml4oHZnPiAjulZz6wtCK0m3zk=;
 b=AxFSaJ8/9HMMoPQJsIiTFX7axQs/9zUDxGoA8R+VH/1YO4YkG6duX83WWB5iJ7tnVdprvZ
 X5IN91QlGWQt406kjUuq86G/MU6CdlgLFzBeSSreKOraPCB7lAYd6mpgtrfVA+4LHrMu7d
 Q4/1isbXG4pde9EjiwKriqUo0jh5cKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-G_wea8NIOxmqaYJPF5ieKw-1; Mon,
 05 Oct 2026 12:47:08 -0400
X-MC-Unique: G_wea8NIOxmqaYJPF5ieKw-1
X-Mimecast-MFC-AGG-ID: G_wea8NIOxmqaYJPF5ieKw_1791218826
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BF0C190FFA4; Mon,  5 Oct 2026 16:47:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 617C43003EFB; Mon,  5 Oct 2026 16:45:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 11/28] hw/watchdog: mark some watchdog devices as secure
In-Reply-To: <20260911143627.2743803-12-berrange@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-12-berrange@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 05 Oct 2026 18:45:43 +0200
Message-ID: <87qzi4jdu0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, Sep 11 2026, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> The ib700, i6300esb, gwdt, spapr and diag288 watchdog devices are marked
> as secure since they have traditionally been, or are intended to be,
> used in virtualization use cases on x86, arm, ppc and s390x architectures
> respectively. Other watchdogs are primarily for emulation.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/watchdog/sbsa_gwdt.c      | 1 +
>  hw/watchdog/spapr_watchdog.c | 1 +
>  hw/watchdog/wdt_diag288.c    | 1 +
>  hw/watchdog/wdt_i6300esb.c   | 1 +
>  hw/watchdog/wdt_ib700.c      | 1 +
>  5 files changed, 5 insertions(+)

Acked-by: Cornelia Huck <cohuck@redhat.com> #diag288


