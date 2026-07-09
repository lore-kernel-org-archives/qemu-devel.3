Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E87FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh5B-0000dQ-HW; Thu, 09 Jul 2026 01:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whh5A-0000d4-78
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whh58-0006ZM-En
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783574032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tf5he4wmaY2AeBot2uDsad+o3XZtnJZp33fIG1QUFJM=;
 b=ZRRm4ngEU5HsElSpYPMKGeXINzFt7EgD++c1a7fEjZX9368+ZaiqmNI+2Vi284U1f+kbAp
 DTfnMU6rLufvjW73Cf6x39Td6GhQmDcy9ufCAr4FDhxvNtyunpQ32wZPnRGkwMFmckV/c8
 ijjpF/+1xtmOyeSy5RY7B+0IT5LQ/pg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-fIdXnwCXMH-ghjCRT8380Q-1; Thu,
 09 Jul 2026 01:13:47 -0400
X-MC-Unique: fIdXnwCXMH-ghjCRT8380Q-1
X-Mimecast-MFC-AGG-ID: fIdXnwCXMH-ghjCRT8380Q_1783574025
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 911B5195604A; Thu,  9 Jul 2026 05:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E987636F2A; Thu,  9 Jul 2026 05:13:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6052821E6920; Thu, 09 Jul 2026 07:13:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  mjrosato@linux.ibm.com,
 farman@linux.ibm.com,  cohuck@redhat.com,  david@kernel.org,
 iii@linux.ibm.com,  richard.henderson@linaro.org
Subject: Re: [PATCH] target/s390x: query-cpu-definitions filter deprecated
 features
In-Reply-To: <20260708202149.103063-1-walling@linux.ibm.com> (Collin Walling's
 message of "Wed, 8 Jul 2026 16:21:49 -0400")
References: <20260708202149.103063-1-walling@linux.ibm.com>
Date: Thu, 09 Jul 2026 07:13:42 +0200
Message-ID: <87mrw0hhix.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Collin Walling <walling@linux.ibm.com> writes:

> Part of the query-cpu-definitions return payload includes an array of
> of "unavailable-features" which helps determine if the CPU model is
> compatible with the system's configuration.  When a KVM guest is
> using a CPU model with deprecated features disabled,
> query-cpu-definitions will claim that certain models are incompatible
> due to these features missing.
>
> Since deprecated features are preferred to be disabled for s390 CPU
> models, lets filter them out from the "missing" features list.
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>
> Examples output of query-cpu-definitions ran on a gen17a host:
>
> WithOUT patch:
>
> ```
> {
>   "return": [
>     {
>       "name": "z13",
>       "typename": "z13-s390x-cpu",
>       "unavailable-features": [
>         "csske"
>       ],
>       "static": false,
>       "migration-safe": true,
>       "deprecated": false
>     },
>     ...
> ```
>
> WITH patch:
>
> ```
> {
>   "return": [
>     {
>       "name": "z13",
>       "typename": "z13-s390x-cpu",
>       "unavailable-features": [],
>       "static": false,
>       "migration-safe": true,
>       "deprecated": false
>     },
>     ...
> ```

I'd put this right into the commit message.

Possibly stupid question (I know nothing about the subject matter): any
compatibility ramifications?  Does the change need to be tied to machine
type version?


