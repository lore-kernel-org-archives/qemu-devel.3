Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E3E9B262
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusXj-0003ip-AC; Tue, 24 Feb 2026 08:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vusXh-0003iX-RQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vusXf-0006Kd-Tl
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771940014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+LL3GxD9m9DctRFVB6UIKNfTk2pEvHDknDKJHpZ4Xo=;
 b=HcBN3OzJas6XuE+eimPaNgOe4DVdeyYfGSIXbFDoD0DzV/ia1wmCOatRmD/balkALIPik+
 KSF5rJjHuv2QcUIfgfVLe0kyvp4GhVUFrPi1GojKOgipLeFjhO1pVoJ/7+rIAJxA9iGRLR
 tDY0fdSS64WtbsiILVyrU7v0HLLB4pY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-0uYuX87lOU6xXJsuch07ww-1; Tue,
 24 Feb 2026 08:33:30 -0500
X-MC-Unique: 0uYuX87lOU6xXJsuch07ww-1
X-Mimecast-MFC-AGG-ID: 0uYuX87lOU6xXJsuch07ww_1771940009
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C1AF1956053; Tue, 24 Feb 2026 13:33:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17E331955F43; Tue, 24 Feb 2026 13:33:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0BD221E692D; Tue, 24 Feb 2026 14:33:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 01/16] rust/qobject: add basic bindings
In-Reply-To: <58720d10-5613-4235-b47f-939e9a8d3096@redhat.com> (Paolo
 Bonzini's message of "Tue, 24 Feb 2026 11:35:31 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-2-pbonzini@redhat.com>
 <87jyw24fw5.fsf@pond.sub.org>
 <58720d10-5613-4235-b47f-939e9a8d3096@redhat.com>
Date: Tue, 24 Feb 2026 14:33:26 +0100
Message-ID: <87y0ki1d21.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/24/26 11:03, Markus Armbruster wrote:
>>> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
>>> index b9ed68a01d8..0907dd59142 100644
>>> --- a/rust/util/wrapper.h
>>> +++ b/rust/util/wrapper.h
>>> @@ -30,3 +30,10 @@ typedef enum memory_order {
>>>  #include "qemu/log.h"
>>>  #include "qemu/module.h"
>>>  #include "qemu/timer.h"
>>> +#include "qobject/qnull.h"
>>> +#include "qobject/qbool.h"
>>> +#include "qobject/qnum.h"
>>> +#include "qobject/qstring.h"
>>> +#include "qobject/qobject.h"
>>> +#include "qobject/qlist.h"
>>> +#include "qobject/qdict.h"
>> 
>> Is this file just for bindgen, and never actually fed to the C compiler?
>
> Yes.

Thanks!

>>> +impl From<()> for QObject {
>>> +    fn from(_null: ()) -> Self {
>>> +        // Conversion of the C inline `qnull` function
>>> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
>>> +    }
>>> +}
>> 
>> Could we call C qnull() instead of using qnull_.base?
>
> See v1 review - no, because qnull() is inline.  I can make it not 
> inline, of course.

I feel making it inline was a bit silly.  Perhaps I had a non-silly
reason back then, but I can't see it anymore.

Up to you.


