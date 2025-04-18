Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E4CC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 21:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5tgx-0004eh-NC; Fri, 18 Apr 2025 17:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5tgv-0004cc-S9
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 17:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5tgu-0003V6-4X
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 17:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745013367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWKrXYhmnZnUpNcfjhNHK83IiG3OukURVcoYETdJZTU=;
 b=EZrh6sNpAvZxmceVseDPJx0rw/i8wz79E2rb2viK5F065P1lGZOnrvop8tCEaXWbYgi9D2
 eDbr7CQkzjGjAWedjbBgVCGDTIFdfnfw2DyVhSBTXXId5Et4Uib+A0NTX/G3HZ0Edsl80Z
 xDsPXUuFfzQPSw1HPBLlk47ZbP2PaPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-FLX9wX9oMEynInLEkBauBQ-1; Fri,
 18 Apr 2025 17:56:04 -0400
X-MC-Unique: FLX9wX9oMEynInLEkBauBQ-1
X-Mimecast-MFC-AGG-ID: FLX9wX9oMEynInLEkBauBQ_1745013362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B611956094; Fri, 18 Apr 2025 21:56:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B9E19560A3; Fri, 18 Apr 2025 21:55:56 +0000 (UTC)
Date: Fri, 18 Apr 2025 16:55:53 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Lieven <pl@dlhnet.de>, 
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>, 
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2 01/11] block: Expand block status mode from bool to enum
Message-ID: <ox4bzfbcwkuaea6cwoj5egddmdwtxqizt4hz5mxtl4r3wca5g5@fcgtihdnrrnc>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-14-eblake@redhat.com>
 <20250417201755.GA85491@fedora>
 <gbu62ipbe2qsqham2stapswrhyv3s2fbpqrbqninmuuznllj2n@gk2cje7zon2m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbu62ipbe2qsqham2stapswrhyv3s2fbpqrbqninmuuznllj2n@gk2cje7zon2m>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 18, 2025 at 02:02:20PM -0500, Eric Blake wrote:
> > I have trouble understanding what the exact semantics are of these modes
> > are. Would it be possible to pass flags to block status calls that can
> > be ORed together instead: WANT_OFFSET_VALID, WANT_ZERO, etc? The flags
> > would be orthogonal and easier to understand than modes that seem to
> > combine multiple flag behaviors.
> 
> I can give that a try.  If I'm understanding the request correctly, I
> would map it as follows:
> 
> BDRV_BSTAT_PRECISE => WANT_ZERO | WANT_OFFSET_VALID | WANT_ALLOCATED
> BDRV_BSTAT_ALLOCATED => WANT_ALLOCATED
> BDRV_BSTAT_ZERO => WANT_ZERO
> 
> while still trying to keep it a mechanical conversion in this patch.

I've done that as a v2.5 reply to patch 1 and 2 of this series (the
rest of the series is unchanged except for one obvious word change in
the addition of bdrv_co_is_all_zeroes).  If we like it better, I can
resend the full series as v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


