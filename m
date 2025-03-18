Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA738C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWu7-0007Vu-L1; Tue, 18 Mar 2025 09:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuWtk-0007H5-W6
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuWtf-0007SV-1B
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742304133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ucU0ZJ8qhSmZm1fSrEmhEzuYx9Aabe35mSCnrPTYbY=;
 b=OJOUVUD8nZjBcE+c+6l2yfi5NZ+Z7GWlnbEuA/pZ2updeZb3Ssu6VZrwKOd7N5OEoG3XNt
 rT61Bn3+OOuUQnM+Tn3jo68Z9vJsGuQNL1urOg3YAvMqQHFOnHs1OYvRuB1z93TYyG9zSU
 AJ7ZLCnCbTHO7BCsZ8Hm1HAWgBJY4Fk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-230ZgZw7MFmaQ4R_tJMrWw-1; Tue,
 18 Mar 2025 09:22:04 -0400
X-MC-Unique: 230ZgZw7MFmaQ4R_tJMrWw-1
X-Mimecast-MFC-AGG-ID: 230ZgZw7MFmaQ4R_tJMrWw_1742304123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA2819560AE; Tue, 18 Mar 2025 13:22:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8552180175F; Tue, 18 Mar 2025 13:22:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BBB621E6773; Tue, 18 Mar 2025 14:21:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: qemu-devel@nongnu.org,  arei.gonglei@huawei.com
Subject: Re: [PATCH] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
In-Reply-To: <44db6eee-2cba-43f0-8977-382e44af3b6f@bytedance.com> (zhenwei
 pi's message of "Fri, 14 Mar 2025 16:34:44 +0800")
References: <20250312101131.1615777-1-armbru@redhat.com>
 <df42e188-00b7-46cc-8853-163798c62ac2@bytedance.com>
 <87r032ihj2.fsf@pond.sub.org>
 <44db6eee-2cba-43f0-8977-382e44af3b6f@bytedance.com>
Date: Tue, 18 Mar 2025 14:21:56 +0100
Message-ID: <87zfhi5v9n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

zhenwei pi <pizhenwei@bytedance.com> writes:

> Hi Markus,
>
> Current code style seems buggy, I think the main reason is that the Error *errp is not generated at right place. keyctl_pkey_XXX fails without new error, qcrypto_akcipher_XXX fails with new error, but they are in the same switch-case code block. If we can separate crypto operations into two functions - cryptodev_lkcf_keyctl_op and cryptodev_lkcf_qakcipher_op, and the error is generate inside the functions, it may be handled easily. Then applying your changes, it seem more clear. What do you think?

Looks like a reasonable cleanup to me.

I suggest to proceed as follows.  We apply my minimal bug fix as is.
You post your cleanup on top.  Okay?


