Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF51C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 06:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUgkJ-00064j-6r; Fri, 19 Jul 2024 02:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUgkH-000649-H9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUgkF-00084v-QR
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721369128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lD4EhpsH+PQTRII4jKty1QkK7BM0vRqoI5Rspsj9iJo=;
 b=dZzBZd7RvvPRdjeGPRZOPQPx4Bu1wX9AXuCtwIr25WAbAg2Z9EWCZDy9oYXbCiv2JWeZ5V
 GwIOgg0OdW9bGrI3gHBSaIDSonnXNuJAYMigzeXuqZilLrKibYrnQwDjwHdrldorfl6hSs
 j0greQpWaQnicu818HhVCfilIGppS0s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-l1_Xo-RwOKanJcZET1AhRA-1; Fri,
 19 Jul 2024 02:05:23 -0400
X-MC-Unique: l1_Xo-RwOKanJcZET1AhRA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29FF1955F3D; Fri, 19 Jul 2024 06:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7671F3000192; Fri, 19 Jul 2024 06:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A18721E66A3; Fri, 19 Jul 2024 08:05:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  qemu-devel@nongnu.org,  "Hao Xiang"
 <hao.xiang@linux.dev>,  "Liu, Yuan1" <yuan1.liu@intel.com>,  "Zou, Nanhai"
 <nanhai.zou@intel.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v6 4/5] migration: Introduce 'qatzip' compression method
In-Reply-To: <20240715221245.12435-5-yichen.wang@bytedance.com> (Yichen Wang's
 message of "Mon, 15 Jul 2024 15:12:44 -0700")
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-5-yichen.wang@bytedance.com>
Date: Fri, 19 Jul 2024 08:05:17 +0200
Message-ID: <87ikx1x6g2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Bryan Zhang <bryan.zhang@bytedance.com>
>
> Adds support for 'qatzip' as an option for the multifd compression
> method parameter, and implements using QAT for 'qatzip' compression and
> decompression.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


