Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCEECD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJg0d-0003Jc-Sl; Thu, 13 Nov 2025 17:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJg0a-0003Dw-DK
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJg0Y-00043M-LC
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763073696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgXcHG46wxL3pZ39V5oMlmCNkz5eh4V+3AIczQNmxjI=;
 b=acex7Irx7tAXuqsC/SiN8ss93VPt/I8Md4uYnxgFNXMluMNLx4S5mYoEMU06myJb8u+uFA
 dBZYKwqrbD9v5aaRDyhPhdX0lQppakVLy4i0lFgWWwKST1/ZtMNsweYNlVEW6Jj/stUyta
 I/eg6N/kI9zLEoQTN+lnRRq5QHpJiLA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-qCwEdkMVMGGiEQdUMDVuCQ-1; Thu,
 13 Nov 2025 17:41:34 -0500
X-MC-Unique: qCwEdkMVMGGiEQdUMDVuCQ-1
X-Mimecast-MFC-AGG-ID: qCwEdkMVMGGiEQdUMDVuCQ_1763073693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6F9719560B2; Thu, 13 Nov 2025 22:41:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D3CC1955F1B; Thu, 13 Nov 2025 22:41:31 +0000 (UTC)
Date: Thu, 13 Nov 2025 16:41:28 -0600
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Fix broken grep command in iotest 207
Message-ID: <zkfx3yai3l5tmisvm5hzl5xfux7u45gqc65m7bu6zf5azavc2q@manwrxeveolq>
References: <20251113080525.444826-1-thuth@redhat.com>
 <aRWiW4cTKqArWZUu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRWiW4cTKqArWZUu@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Nov 13, 2025 at 09:18:19AM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 13, 2025 at 09:05:25AM +0100, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > Running "./check -ssh 207" fails for me with lots of lines like this
> > in the output:
> > 
> > +base64: invalid input
> > 
> > While looking closer at it, I noticed that the grep -v "\\^#" command
> > in this test is not working as expected - it is likely meant to filter
> > out the comment lines that are starting with a "#", but at least my
> > version of grep (GNU grep 3.11) does not work with the backslashes here.
> > There does not seem to be a compelling reason for these backslashes,
> > so let's simply drop them to fix this issue.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/qemu-iotests/207 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Not quite NBD material, but since it touches iotests and I was
preparing a pull request that benefitted from a cleaner run, I went
ahead and queued it through my tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


