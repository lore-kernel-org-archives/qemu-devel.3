Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAEBD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 08:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOX1U-000221-E7; Thu, 27 Nov 2025 03:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOX1S-0001yv-NS
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 03:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOX1R-0005kT-3r
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 03:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764230794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=odTaX9SCJEIxv6WemmaZZj8/+9ZA+2YsQknZ9nts5n4=;
 b=BaVNsc9Gv3RxKSSn1Lmg0QT/kTQlwkwEOUx2CIGyqonb/LPKTuDF0HbjTix0UvEYSkcjsh
 55SN3guXgYtNtihU4l4rrPhkw5t+r22Afn6WyBvi5II8HYDB1YBYDmnOjSx3dm8o3ac6Qw
 EFpkhHR0R5teDI2j9ddFJFnb7xOhrbU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-xU5HwO_LMqGfSDRPQ5QTMw-1; Thu,
 27 Nov 2025 03:06:30 -0500
X-MC-Unique: xU5HwO_LMqGfSDRPQ5QTMw-1
X-Mimecast-MFC-AGG-ID: xU5HwO_LMqGfSDRPQ5QTMw_1764230789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 855C1195608F; Thu, 27 Nov 2025 08:06:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95B619560B0; Thu, 27 Nov 2025 08:06:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A27C21E6A27; Thu, 27 Nov 2025 09:06:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com,  mst@redhat.com,  imammedo@redhat.com,
 anisinha@redhat.com,  gengdongjiu1@gmail.com,  peter.maydell@linaro.org,
 pbonzini@redhat.com,  shan.gavin@gmail.com
Subject: Re: [PATCH 1/5] acpi/ghes: Automate data block cleanup in
 acpi_ghes_memory_errors()
In-Reply-To: <20251127004435.2098335-2-gshan@redhat.com> (Gavin Shan's message
 of "Thu, 27 Nov 2025 10:44:31 +1000")
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-2-gshan@redhat.com>
Date: Thu, 27 Nov 2025 09:06:25 +0100
Message-ID: <87wm3b7vcu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gavin Shan <gshan@redhat.com> writes:

> Use g_auto_ptr() to automate data block cleanup in the function so
> that it won't be a burden to us.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


