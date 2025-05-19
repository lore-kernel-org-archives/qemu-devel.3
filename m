Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10AAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH6q9-0000rd-PT; Mon, 19 May 2025 16:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uH6q0-0000rG-Nw
 for qemu-devel@nongnu.org; Mon, 19 May 2025 16:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uH6py-00064C-8g
 for qemu-devel@nongnu.org; Mon, 19 May 2025 16:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747685504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyApLcDR2zB7CQruEoFdGel7epMlT5EH0zCrs31L4y4=;
 b=Z9E457gGZ9WWO+cQIF3oPbX65oZDl71FsZ2O5GVnjKNLPw9DV1C9bMPDHAcsBdB8hZAXKZ
 Kq+/3G/uwmSvRqzc0X2IwI4/WAlhe+e0cdvcfmbEsQQxXWFGFtM+u34khl7LnRvfRs5hyM
 IKTifp6PatvCDKPkGZyipkMsbQ11JhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-BhFMP9ahMM2BREwhL9AvtA-1; Mon,
 19 May 2025 16:11:41 -0400
X-MC-Unique: BhFMP9ahMM2BREwhL9AvtA-1
X-Mimecast-MFC-AGG-ID: BhFMP9ahMM2BREwhL9AvtA_1747685500
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5670C1800370; Mon, 19 May 2025 20:11:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4171A19560A3; Mon, 19 May 2025 20:11:37 +0000 (UTC)
Date: Mon, 19 May 2025 15:11:34 -0500
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org
Subject: Re: [PATCH v4 1/3] io: Add helper for setting socket send buffer size
Message-ID: <eveqd3o23ngck6wmmc2ci6iu5ninhb33232mw3cgckw6cif4vf@6zvcx3q4tis7>
References: <20250517201154.88456-1-nirsof@gmail.com>
 <20250517201154.88456-2-nirsof@gmail.com>
 <20250519112048.GU1450@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112048.GU1450@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 19, 2025 at 12:20:48PM +0100, Richard W.M. Jones wrote:
> On Sat, May 17, 2025 at 11:11:52PM +0300, Nir Soffer wrote:
> > Testings reading and writing from qemu-nbd using a unix domain socket
> 
> Nit pick that this should be "Testing", not "Testings".  (Or
> "Experiments" if you really wanted a plural noun.)

I'll tweak that while staging the patch for a pull request; no need
for another revision.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


