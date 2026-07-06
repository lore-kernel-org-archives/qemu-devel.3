Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeHT-00062J-PG; Mon, 06 Jul 2026 04:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wgeHO-00060b-UP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wgeHN-0000YS-Aw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783324931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqQoiX8nOstIqMDv9TBNeaeMATrv7hzlmItcdj7mYtY=;
 b=fqDBF6p2UYCs9q10pJVYr0uHnmOT2mX43ypq3IXkRpce/oTcCyOdG6P/W2pck1SEvNCZmH
 RZoML0TihPplDyoBz1BZpqBAiYP4EKdG6Lsjt5pKFny8Q1vmWnraAmIl1Xnjlw5VZCmL2T
 /3LWZsiiNZVtS1edxjS59QJb+g64VVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-f90MF37vM6-j2tZnSLWTLg-1; Mon,
 06 Jul 2026 04:02:07 -0400
X-MC-Unique: f90MF37vM6-j2tZnSLWTLg-1
X-Mimecast-MFC-AGG-ID: f90MF37vM6-j2tZnSLWTLg_1783324925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64B2C195607C; Mon,  6 Jul 2026 08:02:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6298F18005A2; Mon,  6 Jul 2026 08:02:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a
 new file
In-Reply-To: <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com> <877bnckuuk.fsf@redhat.com>
 <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 10:02:02 +0200
Message-ID: <871pdglf5x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> On 2026-07-03 16:31, Cornelia Huck wrote:
>> On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
>> 
>>> Move the cpacf sha512 implementation into a new file
>>> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
>>> header file storing function the prototypes.
>>> 
>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>  target/s390x/tcg/cpacf.h         |   5 +
>>>  target/s390x/tcg/crypto_helper.c | 222 
>>> -------------------------------
>>>  target/s390x/tcg/meson.build     |   1 +
>>>  3 files changed, 6 insertions(+), 222 deletions(-)
>> 
>> Forgot to commit the new cpacf_sha512.c file?
>
> Yes - the last rework ...
> Shall I send out v10 with only this missing file fixed ?

Just send out the complete series, that makes it easier to merge.


