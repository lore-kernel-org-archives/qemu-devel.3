Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9F10ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67gY-0002Ap-Bc; Fri, 27 Mar 2026 09:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w67gW-0002AS-Mn
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w67gV-0001Wd-A5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774619830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5YBl/ngqyfgb56hMGzP0P4SCdxLcFPK6NDGJuqo3H4=;
 b=Fp9zo5JPdfwNlJCvVbXU4EknGm5lUDrTWHQlFF+HGbSIczZr/ZLMAlbUIvJ9AmglmMbhW1
 Ctvc0hWd7df6EhnhPkif3baaAn55myGD03mmVPKeQhuIliBgGWUtC7QVoWncg5hbtLUtkL
 C+KSku3gdBODizBtxSECJiohjVrx74k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-EVGr3K1sPROT6Gt3_Ql_Cg-1; Fri,
 27 Mar 2026 09:57:08 -0400
X-MC-Unique: EVGr3K1sPROT6Gt3_Ql_Cg-1
X-Mimecast-MFC-AGG-ID: EVGr3K1sPROT6Gt3_Ql_Cg_1774619827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA551956056; Fri, 27 Mar 2026 13:57:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449BE1800361; Fri, 27 Mar 2026 13:57:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB9B821E6937; Fri, 27 Mar 2026 14:57:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v3 3/3] hw/qdev: Consolidate qdev_get_printable_name()
 into qdev_get_human_name()
In-Reply-To: <20260321100405.1525059-4-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Sat, 21 Mar 2026 11:04:05 +0100")
References: <20260321100405.1525059-1-alessandro@0x65c.net>
 <20260321100405.1525059-4-alessandro@0x65c.net>
Date: Fri, 27 Mar 2026 14:57:04 +0100
Message-ID: <87fr5l4bpr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Rename qdev_get_printable_name() to qdev_get_human_name(), remove
> the old qdev_get_human_name() implementation, and switch the three
> qdev_get_printable_name() callers in hw/virtio/virtio.c.
>
> qdev_get_printable_name() subsumes qdev_get_human_name(): both
> return the device ID when set and fall back to the canonical QOM
> path, but qdev_get_printable_name() also tries the bus-specific
> path first, providing more informative output.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


