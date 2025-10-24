Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1822CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 14:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCITU-0005TP-Vc; Fri, 24 Oct 2025 10:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCITP-0005Ss-E3
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCITN-0003qp-Aj
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761314931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4U/sWqrpc3a4btbxAWo6H/G1bY+HTYlS6Kp3FO696c=;
 b=VU3gXoxkdmr7iOkTQAmf8WpVPNwtdT8YJSTH1j2ejR6ZbJrQqnq5mYs6P3ON9EcFWYCKUW
 byjei30uaOR+1D+XoJhUzn5mDNY/wCJStfLwaMyKdfwHp59uDGp8Fp7+NoqtY/u/ioDYs1
 WwKtQmHIqjWau91hEYfLQqQ8XlObfII=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-swZePv2BMhiatMm8Nm35WA-1; Fri,
 24 Oct 2025 10:08:47 -0400
X-MC-Unique: swZePv2BMhiatMm8Nm35WA-1
X-Mimecast-MFC-AGG-ID: swZePv2BMhiatMm8Nm35WA_1761314926
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AF79197753E; Fri, 24 Oct 2025 14:08:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEE2518005B0; Fri, 24 Oct 2025 14:08:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F69921E6A27; Fri, 24 Oct 2025 16:08:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bin Guo <guobin@linux.alibaba.com>,  qemu-devel@nongnu.org,
 peterx@redhat.com,  farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <874irozabw.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 24 Oct 2025 15:41:07 +0200")
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org>
Date: Fri, 24 Oct 2025 16:08:39 +0200
Message-ID: <87v7k4xuhk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

>> But wow, the migrate_add_blocker API design is unpleasant with its
>> pair of "Error **" parameters - it is practically designed to
>> maximise confusion & surprise.
>
> It's quite a sight, isn't it?
>
> I'll give it a quick Friday afternoon try.

Alright, my confusion has been maximised.  Giving up on this.


