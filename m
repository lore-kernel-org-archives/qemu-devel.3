Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44388CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOjr-0004Fx-Vv; Thu, 30 Apr 2026 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIOjr-0004Fl-5q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIOjp-0003cP-Lh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777545321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEiaM4nnLIL8FvWNwqi93qDfFi/OsG+rt+TEb/RJdAU=;
 b=f1+tJFP6UZPJ+7ykwCEJekeUSyPQfbMnGHJSCJUpSyM6McMF3PwvIC/rFKGel9Bg1RcXyM
 BMo4laimP8WDnn6KAed48NC75xELY71hOSkpLpsd9GOBJBXVtzwEFVPfTp00zYoWSMAEz2
 jTgskinSRWm5yt7toDhXSroOrHft6rI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-axAvCK9PPdGXHFCYjuVcAA-1; Thu,
 30 Apr 2026 06:35:17 -0400
X-MC-Unique: axAvCK9PPdGXHFCYjuVcAA-1
X-Mimecast-MFC-AGG-ID: axAvCK9PPdGXHFCYjuVcAA_1777545317
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE58B1800473
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:35:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 852E51800480; Thu, 30 Apr 2026 10:35:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/13] minikconf: modernize handling of include chain
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20260430090534.841894-9-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
 <20260430090534.841894-9-pbonzini@redhat.com>
Date: Thu, 30 Apr 2026 14:34:59 +0400
Message-Id: <177754529909.1138192.2800708626696584583.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MIv5ViCfUh3ZBAMjPOdpncMHX6pn4FQ6+URFFxXSr4w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8zBWjGial43B8t++lAE5vbX/LCfj7W2yUTjiq
 5tVddhq5FaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafMwVgAKCRDa6OEJdZac
 5VoQD/0S4YC2bnlz1pLXOtf/kURtHkghsZx3VnAPLRnQlzMhZHOy3jYE3UR5ZnRQKmm9b2VqE7G
 tnSwFbz1jZtKGbNHeHrQGb7+PR0jiKNCbJablL3qIPZEGtvK3eQn7sz0x/5XMq4xxHguAS4xsge
 nnzoWBpjZU1+/lgz2Y5jBNYR6qsgEVtjm9yeqUbUhIl/MS/l64eoT22S/yOSmiavhLnsg3+wfbx
 tgYjpkBkvbC8f66fO43CsDZVHx3EcgIB5NDtnWWTeHYrKB4r8w9Jc0xHflT+l0ObpOr9pIE5wZZ
 E3cyMYk5inSiAdSvvna8CD+LvCFH3djxFAwpd4rzefa8WaJgvjG1ZYeT5iCkIg4ivFrEIJZrfWm
 /CcyY6SwII8e/CwTPtv6gKL7qpQwFCoxQUtOSKN/Lg57Dc10n1CIScEbOPHPanNLvqFO2B/onVR
 vq35r6z99W13haZIyRIR8DES1oPLBPuMc5+UteQsVhFZfIVGuSBDrCNucgdaASbTgzH+VqMWdO/
 xCCnAhSe+SJAF7VCi/BdGjrTGBfko9ln+AxC8HTfdcJAkoC7GpF2gZCRJ1WMAPGGg8CSeupTGPn
 k+6ITlWqMuhxlXn8QfI9NzrOyxHPWbVGwtbPuyIBhS0VyQvIwnwrOh3I6nGTAWrHdrkrH8o3tNn
 o1HxELZfM5m8inw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, 30 Apr 2026 11:05:29 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> index 3d63cc6b21f..07a5152ef54 100644
> --- a/scripts/minikconf.py
> +++ b/scripts/minikconf.py
> @@ -15,11 +15,30 @@
>  import random
>  import re
>  import sys
> +from dataclasses import dataclass
>  
>  __all__ = [ 'KconfigDataError', 'KconfigParserError',
>              'KconfigData', 'KconfigParser' ,
>              'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
>  
> +@dataclass
> +class IncludeInfo:
> +    file: str
> +    line: int
> +    parent: IncludeInfo | None

Add `from __future__ import annotations` with this patch or add the annotations with patch 13?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


