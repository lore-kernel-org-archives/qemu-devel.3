Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C5DC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2D3-00014H-3b; Tue, 11 Jun 2024 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sH2D0-00013j-Ov
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sH2Cy-0002tX-Kr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nVJ2izZLVjMsazCvPuJFZaL76226IQ8pZ8tQy6BmbOs=;
 b=ZMQ6htEVWy4qfPBwialRujnWCNgDWk6wFuN0znee1WaTesQed9vrXmau5fer9g9LDyl2Wl
 PRUDFc31eVTrEPWmB2WojUnN/apM2ZD8kPRHY2CZ6g63zcK5tmIhtdKqcqoOa10ygPJFu4
 caZjfvJyUBJOv/YGghkllLS2rwKT40I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-FZtNOCnBMJivtOpZsTKbMA-1; Tue,
 11 Jun 2024 10:10:42 -0400
X-MC-Unique: FZtNOCnBMJivtOpZsTKbMA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C75319560B8; Tue, 11 Jun 2024 14:10:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5D1300021B; Tue, 11 Jun 2024 14:10:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D95221E6757; Tue, 11 Jun 2024 16:10:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] qapi: clarify that the default is backend dependent
In-Reply-To: <20240611130231.83152-1-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Tue, 11 Jun 2024 15:02:31 +0200")
References: <20240611130231.83152-1-sgarzare@redhat.com>
Date: Tue, 11 Jun 2024 16:10:38 +0200
Message-ID: <87y17bin8h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> The default value of the @share option of the @MemoryBackendProperties
> really depends on the backend type, so let's document the default
> values in the same place where we define the option to avoid
> dispersing the information.
>
> Cc: David Hildenbrand <david@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

and queued.  Thanks!


