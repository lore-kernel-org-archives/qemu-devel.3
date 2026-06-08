Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B762FCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYAm-0002h2-7a; Mon, 08 Jun 2026 07:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wWYAk-0002ge-GQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wWYAi-0002Kp-LZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780918174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xrFBiHbsR2xLcxFFb/nU7kGddYmgrbpO//+1JMRkvk=;
 b=iJyF6jELLf+mfIQWAO5lFy2wI8Ush4byf9mDzmL/XbxMj7sdqIKa3X+blGiVqQPo5cu9u+
 9B+rJaFk1URWPBKdFhRTGxJRVAEccUNvd9jr9wZFkgD3OXvj4XSVrjd2ZzD9KU+AFvAEsp
 xCOhimRs10CzRMgiz8w5J+J56s6jCHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-eHICoDzYOFWU961pettNGw-1; Mon,
 08 Jun 2026 07:29:31 -0400
X-MC-Unique: eHICoDzYOFWU961pettNGw-1
X-Mimecast-MFC-AGG-ID: eHICoDzYOFWU961pettNGw_1780918169
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CED11955D84; Mon,  8 Jun 2026 11:29:29 +0000 (UTC)
Received: from localhost (unknown [10.44.33.129])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0CDC27A; Mon,  8 Jun 2026 11:29:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH v6 00/17] target/s390x: Extend qemu CPACF support
In-Reply-To: <60756e0a-0dba-4e0c-a3c3-cf1758062556@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260526121550.5296-1-freude@linux.ibm.com>
 <87y0gpmnnp.fsf@redhat.com>
 <60756e0a-0dba-4e0c-a3c3-cf1758062556@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 08 Jun 2026 13:29:26 +0200
Message-ID: <87v7btmfs9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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

On Mon, Jun 08 2026, Holger Dengler <dengler@linux.ibm.com> wrote:

> Hi Cornelia,
>
> On 08/06/2026 10:39, Cornelia Huck wrote:
>> Also, is there any public documentation for these instructions? If not,
>> it would be helpful if someone with access to the documentation could
>> give an R-b here.
>
> All CPACF instructions and related topics are documented in the z/Architecture
> Principles of Operation [1].
>
> [1] https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf

TIL :) Thanks!


