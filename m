Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAFBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAll-0001Ek-J3; Wed, 31 Jul 2024 10:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAlj-0001Cl-EK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZAli-00080O-48
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722437853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmyU/f3fDuNCQIc55Ym4tlhTz2jInek6tMCDKFI9v2c=;
 b=WscZMHyv8A+UtDCsvsWR7Aqbez/UcXG+6D3IqGkkhL66ECJ6N1UjXMUAF7tn1ndMrV7I2w
 tqk7wQmAV6KewqU95nVNwT5v95OCHMzHDWQE/NLt5ZMcZblTrKev54CK3NaHOweueqGRN3
 LRevcyvf01u9d9BMDNwjpYcSQ9dMIRM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-DbRNp03lORWfSYwAQLvvcA-1; Wed,
 31 Jul 2024 10:57:27 -0400
X-MC-Unique: DbRNp03lORWfSYwAQLvvcA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DECBC1955D4F; Wed, 31 Jul 2024 14:57:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BE3F1955D42; Wed, 31 Jul 2024 14:57:21 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:57:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 4/7] hw/ide/atapi: Be explicit that assigning to s->lcyl
 truncates
Message-ID: <ZqpQz77u7Q6D5yR-@redhat.com>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143617.3391947-5-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
> In ide_atapi_cmd_reply_end() we calculate a 16-bit size, and then
> assign its two halves to s->lcyl and s->hcyl like this:
> 
>            s->lcyl = size;
>            s->hcyl = size >> 8;
> 
> Coverity warns that the first line here can overflow the
> 8-bit s->lcyl variable. This is true, and in this case we're
> deliberately only after the low 8 bits of the value. The
> code is clearer to both humans and Coverity if we're explicit
> that we only wanted the low 8 bits, though.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


