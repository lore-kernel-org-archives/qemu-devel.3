Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BF8CC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHa7l-0004hu-1R; Fri, 16 Oct 2026 01:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHa7e-0004hf-HN
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHa7c-0007nf-BV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792127086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJeRR+B+DD2ZhZJ78MnoapdX7pVDkyl1YTpMi+HujU4=;
 b=CenTxagzpHTzSWwovAsL4PztaYu5SHPbusvscw6OznLfWv9nkyVmkvdX3LqIGXnJQ1wu0R
 WAtb0NF954kcpBAoBWMosCvtA3im1XS7HVxoYDsC+2dTx1vkSt12SybwalF2sZpaqcw8GW
 VACVHuCrNi3SHn5Xnnlq1WOWxSE/0+A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-AGIMjziTO8G7m6M0dIVPzA-1; Fri,
 16 Oct 2026 05:04:42 +0000
X-MC-Unique: AGIMjziTO8G7m6M0dIVPzA-1
X-Mimecast-MFC-AGG-ID: AGIMjziTO8G7m6M0dIVPzA_1792127081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64AC61800594; Fri, 16 Oct 2026 05:04:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C9118001CA; Fri, 16 Oct 2026 05:04:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CA1C21E6A04; Fri, 16 Oct 2026 07:04:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,  david@kernel.org,  imammedo@redhat.com,
 maciej.szmigiero@oracle.com,  peterx@redhat.com,  farosas@suse.de,
 mark.kanda@oracle.com,  bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com,  alex@shazbot.org,  clg@redhat.com,
 yi.l.liu@intel.com,  eric.auger@redhat.com,  zhenzhong.duan@intel.com,
 mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com, eblake@redhat.com
Subject: Re: [PATCH 01/21] qapi/migration: add cpr-luo migration mode
In-Reply-To: <c00b8d21-ba36-4a2a-ad22-56ec1ffc2250@oracle.com> (Dongli Zhang's
 message of "Thu, 15 Oct 2026 13:37:57 -0700")
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <20261012235727.398133-2-dongli.zhang@oracle.com>
 <878q40eni8.fsf@pond.sub.org>
 <4b7de1ba-f063-43b9-9dd2-64d1187e488f@oracle.com>
 <87qzhrblil.fsf@pond.sub.org>
 <c00b8d21-ba36-4a2a-ad22-56ec1ffc2250@oracle.com>
Date: Fri, 16 Oct 2026 07:04:37 +0200
Message-ID: <8733u68cd6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> On Wed, Oct 14, 2026 10:06:26PM -0700, Markus Armbruster wrote:

[...]

>> Is this covered in the documentation?
>
> The existing doc is already in the QEMU source code and explains the usage and
> basic mechanism.
>
> https://www.qemu.org/docs/master/devel/migration/CPR.html
>
> I just prefer to summarize it in my own way, as in my previous email, as that
> helps me compare different modes.

Appreciated!

>                                   I have added cpr-luo to the doc in patch 0021.
>
> Thank you very much!
>
> Dongli Zhang

You're welcome!


