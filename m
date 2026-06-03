Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1BFCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfy9-0000Gp-Vh; Wed, 03 Jun 2026 03:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfy8-0000GD-91
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfy7-00071l-0D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780471489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VLbxsy5WjmdFyxGJGiKLQ/UhByvRY/qcIoivUMmoWk=;
 b=f7YwrNyEv+iEiXD19Q9wB19AqYEz3eXSL5x6BzH4KMLGtHzU6kip+0MQm19AW9s96ZMOzm
 FlmVFmLXPiQJf0eHUY6ZNumj2zcPyjR3YSuJjnjIX1lp/T3gQLJIlU55C91Ogfd1w96PzN
 MC4krUVpK1La1+PhCCQRnw4kXTFke50=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-1VvUS7GQMLO2aHslTh6RLQ-1; Wed,
 03 Jun 2026 03:24:46 -0400
X-MC-Unique: 1VvUS7GQMLO2aHslTh6RLQ-1
X-Mimecast-MFC-AGG-ID: 1VvUS7GQMLO2aHslTh6RLQ_1780471485
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07573195608A; Wed,  3 Jun 2026 07:24:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BEF4404; Wed,  3 Jun 2026 07:24:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2005021E6A01; Wed, 03 Jun 2026 09:24:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qobject/json-writer: preallocate output buffer
In-Reply-To: <20260603022538.92780-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Wed, 3 Jun 2026 10:25:38 +0800")
References: <20260603022538.92780-1-guobin@linux.alibaba.com>
Date: Wed, 03 Jun 2026 09:24:42 +0200
Message-ID: <871peodr2d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Bin Guo <guobin@linux.alibaba.com> writes:

> json_writer_new() creates the output GString with g_string_new(NULL),
> which starts at the GLib default of 64 bytes.  Serializing typical
> QMP responses then requires multiple reallocations as the buffer
> grows -- for query-qmp-schema the GString is reallocated 12+ times.
>
> Preallocate JSON_WRITER_INITIAL_SIZE (4096) bytes.  This covers
> most QMP responses without any reallocation.  The JSONWriter is a
> short-lived object so the preallocation does not accumulate.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Thanks!

Paolo, perhaps you can merge this together with your JSON parser
patches.


