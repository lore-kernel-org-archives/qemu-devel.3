Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A40DCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICe9-0007ai-1o; Wed, 29 Apr 2026 17:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wICe6-0007aS-Fn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wICe4-0001bn-5H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777498835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KbTZ2/A31vu8u5Fk63E89SiOYzPV3tayMh7vwYj5E5w=;
 b=DDflbL6TQPF7+ovsFgztI/CYkGVJwPf9ZQmZbWMPMA04zHnGMZH3oKUVOG+IdEmR+hFf16
 oUZjGYsGerRBQqQ8ULdWgmoSLMndOweLmqa14Q8aAajFumpgT6UYUQb1zkx8Zx6D8h8j/q
 9VAcSLaBerotFKeAzCVwExzFpQZBw7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-GhD7BgPvOne4Q7XhGh-BWQ-1; Wed,
 29 Apr 2026 17:40:33 -0400
X-MC-Unique: GhD7BgPvOne4Q7XhGh-BWQ-1
X-Mimecast-MFC-AGG-ID: GhD7BgPvOne4Q7XhGh-BWQ_1777498832
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9229B1800366
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:40:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26DF1180045E; Wed, 29 Apr 2026 21:40:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/9] qom: move object_set_prop_keyval into object.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260429210830.594724-7-berrange@redhat.com>
References: <20260429210830.594724-1-berrange@redhat.com>
 <20260429210830.594724-7-berrange@redhat.com>
Date: Thu, 30 Apr 2026 01:40:15 +0400
Message-Id: <177749881570.809163.1931324275553253319.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=528;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qVBvMaqWiSGckAh0pYehlbLc/P8sERtJ/XAVYaiKziU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nrFz7jF7o4kHUeMK2V3at+E9ZpL/qU6upli9
 RFsR+VsyHeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJ6xQAKCRDa6OEJdZac
 5TkiEACl2ywhHMJu3MrWuTXsYJ51X9xaCFPYD9dE3dzOXAGHk/NU701Y6fBrQXXHShju4WOQcJd
 P4yOjBUQ7jwCs8/jG1+Dh2KwYBomW7xfYrFuKB2EXwq610xZjlRCbr7d/MBhbk8MK1eaqJqmHon
 qtnvabrKCMHnBcvPpIS50++gS2Zh3cSzMkSccIcYQ2FHYlGWvwFqroIygtt0b0k/VC5uVOy1aOg
 YUd/ZEsUVd2NKkjmJ40Ixhi+Ei/+DJoifo9MZooNHhBYrIp3y3o/i4cKxWk9R1GAK1Aug0B4Hj7
 akxCQ6gdem9RHRvm0eJBr928CoC3O0Kj75AeadeIpw52psXYFWUq/HgCF0jGiHNhf5FZ/AN4CEW
 zeieAEUJHEGPhpw8aq7zbZFpLHPkaCQQgAMi0OF412wz/d/ljUIZc77xHfrCGn6nf1J9Qrlf6O4
 BHPrTTp2bLtgtaOp+4M5jRpfT/xrmqFeh6VClu47px5qYmEHR93jdLH7t5T7KxO0L7lI0vyM13m
 ujPSPKM2xWqmIscfVOjzXcQcbcJXx/wiKvFNgFB3aXUZy/icEOniQeHUyZq2gt4CvJs4bWGQNX3
 QceAdmzf++Qb8J4pFkj9xuvwdviEIvK/v1xTZQUq/oNBSFYVLspVZxj6SiU1mktMUTC1Bs8tMZt
 955sWtz0aErAgOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 29 Apr 2026 22:08:27 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/qom/object.c b/qom/object.c
> index 2671c471ab2..c44e2b2eff4 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -23,7 +23,9 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/forward-visitor.h"
>  #include "qapi/qapi-builtin-visit.h"
> +#include "qobject/qdict.h"
>  #include "qobject/qjson.h"
> +#include "qobject/qdict.h"

double-included

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


