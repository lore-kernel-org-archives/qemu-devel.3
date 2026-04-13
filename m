Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D36BEBFD10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCOV-0001NY-7i; Mon, 13 Apr 2026 04:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wCCNU-0001EF-Gv
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wCCNS-00087S-EI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776067837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBy1Z9iAFrwDgubE854sZbP4t6wpVWhVvni7i4dtyXA=;
 b=NZK1BkgYtgzRjrGPlSNt6j7RdGskZSlFbOKmjaBobb5phe0OrbY/qiTLyP63lqECMdIZig
 aGAvLLRlAGRYUc8ecxlIZIzETJy+vGrqC/9hz2LruvAP/iFqw25ErGA+758PpoD3pg3kJH
 lnGrzyn6DJMw56rbC0QAewjxL+Ip6/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-p2UB40wqM2GMkQRHEBcGyg-1; Mon,
 13 Apr 2026 04:10:34 -0400
X-MC-Unique: p2UB40wqM2GMkQRHEBcGyg-1
X-Mimecast-MFC-AGG-ID: p2UB40wqM2GMkQRHEBcGyg_1776067832
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 410C5195609D; Mon, 13 Apr 2026 08:10:32 +0000 (UTC)
Received: from localhost (dhcp-192-192.str.redhat.com [10.33.192.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10C5B19560AB; Mon, 13 Apr 2026 08:10:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan
 Gilbert" <dave@treblig.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org, Markus Armbruster
 <armbru@redhat.com>, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric
 Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/27] monitor: Do not check TARGET_S390X to build
 s390x commands
In-Reply-To: <20260410195323.17937-22-philmd@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-22-philmd@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 13 Apr 2026 10:10:28 +0200
Message-ID: <87zf37b7rf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Apr 10 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These commands are filtered at build-time for s390x binary.
> By using the recently introduced HMPCommand::arch_bitmask flag
> we can filter them at runtime, making it possible to compile
> hmp-commands[-info].hx files once.
>
> Since the methods are used inconditionally within hw/s390x/,
> define them in the same stub file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS               |  1 +
>  include/monitor/hmp.h     |  7 +++++++
>  monitor/hmp-target.c      |  5 -----
>  stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
>  hmp-commands-info.hx      |  6 ++----
>  hmp-commands.hx           |  6 ++----
>  stubs/meson.build         |  1 +
>  7 files changed, 28 insertions(+), 13 deletions(-)
>  create mode 100644 stubs/hmp-cmds-hw-s390x.c

Acked-by: Cornelia Huck <cohuck@redhat.com>


