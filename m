Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh4Rl-00079V-Vh; Tue, 07 Jul 2026 07:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh4Rk-00079F-JB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh4Rj-0000y4-24
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783425518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sx9ceVBIxTCChNgTGrKuGZRevVRYlusqsxzmiPTO8Us=;
 b=hPXOZ84YJADTZsgwSa+HHxBtXOiPZDjIVVdIwbBWc2ZmMqcpzPAMuBsFYVlCwVUAFV9BRz
 BK0/LqmBCalKNBBbfknQf4a7z1YROnmkfSRhwo6DSoSZQZjgQ4wfvOWHHZPYsbXRBrNBgO
 NGT0aQ8KNi2NSmUz30lY0+l59ZI6JLo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-lAZwFgu9MkqGWxIg_eEijQ-1; Tue,
 07 Jul 2026 07:58:35 -0400
X-MC-Unique: lAZwFgu9MkqGWxIg_eEijQ-1
X-Mimecast-MFC-AGG-ID: lAZwFgu9MkqGWxIg_eEijQ_1783425513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 501361954212; Tue,  7 Jul 2026 11:58:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66E353000C01; Tue,  7 Jul 2026 11:58:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 13:58:29 +0200
Message-ID: <87bjcjj9ju.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> Harald Freudenberger (21):
>   target/s390x: Fix wrong address handling in address loops

I've picked the first patch as a bugfix.

>   target/s390x: Rework s390 cpacf implementations
>   target/s390x: Move cpacf sha512 code into a new file
>   target/s390x: Support cpacf sha256
>   target/s390x: Support AES ECB for cpacf km instruction
>   target/s390x: Support AES CBC for cpacf kmc instruction
>   target/s390x: Support AES CTR for cpacf kmctr instruction
>   target/s390x: Minimal AES XTS support for cpacf pcc instruction
>   target/s390x: Support AES XTS for cpacf km instruction
>   target/s390x: Base support for cpacf protected keys
>   target/s390x: Support pckmo encrypt AES subfunctions
>   target/s390x: Support protected key AES ECB for cpacf km instruction
>   target/s390x: Support protected key AES CBC for cpacf kmc instruction
>   target/s390x: Support protected key AES CTR for cpacf kmctr
>     instruction
>   target/s390x: Minimal protected key AES XTS support for cpacf pcc
>     instruction
>   target/s390x: Support protected key AES XTS for cpacf km instruction
>   docs/s390: Document CPACF instructions support
>   crypto: Add aes-helpers file to support some AES modes
>   target/s390x: Use generic AES helper functions
>   target/s390x: Improve fetch and store mem from and to guest
>   tests/tcg/s390x: Add tests for CPACF instructions


