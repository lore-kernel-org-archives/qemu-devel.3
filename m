Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC7ACD98C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw8Q-0007ox-3q; Tue, 09 Jun 2026 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWw8O-0007oo-E6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWw8M-0006Vu-1B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781010283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3CmK6ZXtYFIZx5iWj69/LflJXKWuy6s6P57URhYfz4=;
 b=Ouj16zkGb5R2L1r/dYX2GQN72f0Tvvau6v14uB7/iIch2SmEsl0OuOmp6JQtDghzf8Cehp
 9+1K19MY7z192zZhjqE+MzzfACNdPkSIfbV0nwT5pYTFNKr3RxhkLRoJvL6rXhoLSABNbM
 aAHY+Ha1F0egBltdAK6fpxUq1rbkdHc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-zsc8jzQYOCqcrbG20Qr8eA-1; Tue,
 09 Jun 2026 09:04:38 -0400
X-MC-Unique: zsc8jzQYOCqcrbG20Qr8eA-1
X-Mimecast-MFC-AGG-ID: zsc8jzQYOCqcrbG20Qr8eA_1781010275
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98AF81964CFA; Tue,  9 Jun 2026 13:04:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CD4CD6E; Tue,  9 Jun 2026 13:04:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C07A621E6A01; Tue, 09 Jun 2026 15:04:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  amit@kernel.org,
 berrange@redhat.com,  eblake@redhat.com,  eduardo@habkost.net,
 lvivier@redhat.com,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  maxbr@linux.ibm.com,  noh4hss@gmail.com,
 pbonzini@redhat.com,  philmd@linaro.org,  qemu-devel@nongnu.org,
 wangyanan55@huawei.com,  zhao1.liu@intel.com
Subject: Re: [PATCH] qapi: drop "must exist" from ID descriptions for
 consistency
In-Reply-To: <87ik7rq36i.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 09 Jun 2026 15:00:21 +0200")
References: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
 <20260120081821.884342-1-filip.hejsek@gmail.com>
 <877bo8q9yc.fsf@pond.sub.org>
 <20260609063539-mutt-send-email-mst@kernel.org>
 <87ik7rq36i.fsf@pond.sub.org>
Date: Tue, 09 Jun 2026 15:04:32 +0200
Message-ID: <87tsrboof3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:

[...]

>> maybe after it gets a signed off by tag from the author.
>
> Oops, missed that!  Can't take it without.
>
> Filip?

Found v2, thanks!


