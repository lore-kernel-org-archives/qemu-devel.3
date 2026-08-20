Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F61C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2l8-0001aY-GA; Thu, 20 Aug 2026 09:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2l2-0001Vy-7d
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2l0-0003Sf-Uw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riwG4xtr0rOs0plMj1RshFuHKSJoydNTJv+uwBtzJzk=;
 b=YhFXs8kDVixqC3bziNrSsYWKGXbablbXa00IjCcODIG2A6aTWjNhF0Jwphji3hUgRuenml
 2qlCeZjKjdfyKd1JGC34ZWHHpjQuq8dGOxi2o+a5IlI2AAqbCRWXW7KWA+e1evFBRgKCzL
 TLAAsNQKgQJJr0pqVnuOLmDmS7//rEw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-y8ASwNuLOl6LF-a_oA-DYQ-1; Thu,
 20 Aug 2026 09:24:23 -0400
X-MC-Unique: y8ASwNuLOl6LF-a_oA-DYQ-1
X-Mimecast-MFC-AGG-ID: y8ASwNuLOl6LF-a_oA-DYQ_1787232260
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7259418002F8; Thu, 20 Aug 2026 13:24:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADEF31955F03; Thu, 20 Aug 2026 13:24:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 07/13] target/riscv: Constify CPURISCVState for various
 cpu_*() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
In-Reply-To: <20260820104730.25462-8-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-8-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213509.2730041.9717030057064138463.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=315;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bvH1QWvHD/nYW/4PfgtZML+/6UJ6NwizxcUnnk223UY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhv/qttH+gzQS3zafwuPSeqEUnXRPmKwobmksw
 Vmrl6U1Ex+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob/6gAKCRDa6OEJdZac
 5SzuD/96Uz/ElYAgkJUL5xWlKzMWOtTwinKq86/9KDtvIQ7mZlmX3/uY7K0JK6HaSzOE/i0p6bv
 MXO1g3yjLYrTmY8osfpi0guEvtFyK/3mV+helgmrqPDpWNN+BCmm88kG6oWdBvIqMum+0h66yLx
 /Vk/hTDTYlvxOtRVjdhXbsMjfdM5+ruOXsu+7rze4ZPygvdUoZ2kuNyr3dWr4yRdqFTTL3rP3U2
 /pFskmsiP4phnDjXC5zwHgHurm4CZmhyz97N9XkbD5If1SiPsC6dYKvGlTp+nLt3bJ0e2/894zj
 +rXsjKAP0EVUNXp6TRD4wDP2Qh/IxZ8MzyjGBu8OeY3WKO4L1I0+C5aHmbyXnCccKJciJl8EIEU
 RJnWVSkI9Xtn2VU16U9zqPJt6kFhUUq9BiNJrlTfypW3kqm+wHV7sTeYre5UW4pRJCwc8W5IsEn
 afUfmgqyBE4vrH39esCfT2ksnn1YmjxtXLLg8knK1n9YW4FFdUT2Rz/L4IDCK3ZslV748n/gjXR
 BBz/1xGUdHuxz2E1aiWlGhIJA7A8K2TkzIAWjbLZS8DxbysUU9RAWjz9Eq8Kh1zEXYS1s4TVWEv
 O4ztLVNn8sLNe8unYur2jPSMxHkhjrrDB90LquTH/n7vediAMKiatqFXTRlG+UmJiFqGRTByh18
 eWIy7jYw4B5QDfQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Aug 2026 12:47:23 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to CPURISCVState when the
> argument is accessed without modification.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


