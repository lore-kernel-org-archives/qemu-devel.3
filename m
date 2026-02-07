Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1831BEE6B74
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 06:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voc6q-0003f2-Jq; Sat, 07 Feb 2026 01:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voc6n-0003et-T3
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 01:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voc6l-0000mL-5g
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 01:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770446872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jgANyiTbmgTMuxaDKrLzkQCKWlksMQ6/XtxVHSxWcA4=;
 b=EsITkKMNJOPpRxCqExw5uBkuqkPuF/aaDsgeHIompMiKZyXbcTJ03fNncSNZ6UFWJYc7y1
 VROo2uN/kMy0JDxVQ8bGcJfP4eacf6EJDvarGdxTt6ue41Nm23z6TpRPF6MO99YpMLRVgc
 81drQysBFymts9Cm1OYkY/WSfSXCz50=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-8aUNHa64PvW_Xv_46eEumg-1; Sat,
 07 Feb 2026 01:47:48 -0500
X-MC-Unique: 8aUNHa64PvW_Xv_46eEumg-1
X-Mimecast-MFC-AGG-ID: 8aUNHa64PvW_Xv_46eEumg_1770446867
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 207E31955F20; Sat,  7 Feb 2026 06:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8663919560BA; Sat,  7 Feb 2026 06:47:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DA7021E692D; Sat, 07 Feb 2026 07:47:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: alex.bennee@linaro.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
In-Reply-To: <CAGZECHOuMEhotdv7YB7GL71cKF4dzbYhbLE4DN39f-ype=Gc3A@mail.gmail.com>
 (Andrew Keesler's message of "Fri, 6 Feb 2026 11:23:13 -0500")
References: <20260109202740.362506-1-ankeesler@google.com>
 <20260109202740.362506-2-ankeesler@google.com>
 <CAGZECHP9i9zeZP4wLtDtx44OsPesOC3hG=bmpjsGrYUVAG-mXg@mail.gmail.com>
 <87ikccy8sm.fsf@pond.sub.org>
 <CAGZECHOuMEhotdv7YB7GL71cKF4dzbYhbLE4DN39f-ype=Gc3A@mail.gmail.com>
Date: Sat, 07 Feb 2026 07:47:44 +0100
Message-ID: <87wm0pgicv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Andrew Keesler <ankeesler@google.com> writes:

>> So when exactly one of @xres or @yes is present, it's silently ignored?
>
> That is the currently proposed behavior, yes.
>
> Here is the related review comment.
>
>   https://mail.gnu.org/archive/html/qemu-devel/2025-08/msg04584.html
>
> WDYT?

I think nonsensical configuration should be an error.

>> (since 11.0)
>
> ACK, fixed in next patch.
>
>> Mentioning this in the commit message wouldn't hurt.
>
> ACK, fixed in next patch.
>
>> Recovering from the coughing plague.
>
> Hope you feel better.

Much improved, thanks!

[...]


