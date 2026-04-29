Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F141FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0PG-0004Oi-Ab; Wed, 29 Apr 2026 04:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PC-0004OH-8G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wI0PA-0007wz-Tq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaZj8pal5da/zaSmOZv4b0JsFZgLKcdDgZj+F88KO7w=;
 b=Yw0BwOtKi1sVsbwaD2z23nN5/ZaugD/iMjFxhXfwd8Ad8hgHpNgWem6wwSI03nqC037VKY
 /Q3/y0wOsRCYGxDBKfMG57QODsLxoexdETBL1Amdnx66z/9QQ3dPEXRij7RYL4gjnglAdV
 JxF7ySHHTJeRKMsKwBPY3EC82V0ODJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-VvZceKEWMeSc4Vcn9z1nnA-1; Wed,
 29 Apr 2026 04:36:20 -0400
X-MC-Unique: VvZceKEWMeSc4Vcn9z1nnA-1
X-Mimecast-MFC-AGG-ID: VvZceKEWMeSc4Vcn9z1nnA_1777451779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8505A1956048; Wed, 29 Apr 2026 08:36:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC2CC19560AB; Wed, 29 Apr 2026 08:36:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/6] target-info: introduce TargetInfo in QOM
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260428234519.1812371-3-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-3-pierrick.bouvier@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:36:03 +0400
Message-Id: <177745176382.2166241.2505852709346670944.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=742;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xp/ueK2QFidmpq3m9A6rwbfNgzIcR540qNMtm7qpkqQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8cL3nVW28ObQHq43vYcdit0B9r5VL6L6lhHJA
 8xsdvmQxSOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafHC9wAKCRDa6OEJdZac
 5eZtD/94UqtW6RIT5k0ywTwC8oM/SCnG2y97M1KtGYr25j3cdugBrq7/WkC0r/7pia8rdxnvLQQ
 5BYXKWin8YUsOVnrSy/XY5pXuhMhwELCYUOF/w6sS4DgPRnR0/jw8rri0YdaBHywX3JnkAW9nq3
 Cq7uAGNnGihtYog6w3xnFwxnFChXlAAD/bStcfZUm+lqF9Zl4WIrOsS0HF9xTCUkv8+9Km2/A1s
 eYIXp351/3qPSjZKMO3XIjHr19O7DTo/HBsvxU6sAaHCDTdrLmdM6VGcmAkLzeFrC96ywUj8cey
 2Adm2VtPN16v5zrXczldG7zpb2wxJz/GqEsJb38bhP+MpKzMcqlYLmhA0lKKxLMIuEH0WamnUoE
 VP1599aMzqiju408gSI7F5PXHTEPF/PGXMKN1qRTLYVcmxCoXQO9+PUd0YQHvDDRXz0+qfUAnVB
 DJBAK0xG7YgPDsMRlYTClq7RfDGL1G0kSh1uEAnTRRRkk2SbhoFMPpRo566ZcdNHkJimaZTxdZ1
 XGsDyBloNiExPdruts5Sjf8b8Lfe1/nd8QRi7UBjszrb1wOINh80KAkaAPk/MMaDhnxCp72D/Xz
 5v/x4SSR+fH/xgqUo61KKq7KEU/y2z7qZ5iFao8lpdrTxYgxI5vuwjHwdZhMjbkqEaWxS7eUaCm
 yNbh0edYhuR50cg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
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

On Tue, 28 Apr 2026 16:45:15 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> new file mode 100644
> index 00000000000..db069db718a
> --- /dev/null
> +++ b/include/qemu/target-info-qom.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU target info QOM types
> + *
> + * Copyright (c) Qualcomm
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/target-info-impl.h"
> +#include "qom/object.h"

Missing include guard. Add:

  #ifndef QEMU_TARGET_INFO_QOM_H
  #define QEMU_TARGET_INFO_QOM_H

before the includes, and a matching #endif at the end.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


