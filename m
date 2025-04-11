Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6F4C369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BSk-000879-Tq; Fri, 11 Apr 2025 06:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u3BSg-00085z-C7
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u3BSe-0004tR-Do
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744366691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TC1GazO+Tx15ziDQ42Lqp+RD4ZnOsCR1FjJglwXfgJI=;
 b=NVbdyARqctRTHwVKjzuc8DhVdJNRs70h3DmjF6c4AJv5pylUCt6ZM4ECAza/3yFeqePq2h
 Bysa2XhoXSuiZG0vq0g7r6QwV6K9alER9zqnzjXTI4BL4FIpmiGgRKcP527JSrmYJnzsXz
 EMPIlsOW30T4sv5WdpnpKOnuAX+4EhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-eBVZvZSpMyK63EQioNnBCA-1; Fri,
 11 Apr 2025 06:18:08 -0400
X-MC-Unique: eBVZvZSpMyK63EQioNnBCA-1
X-Mimecast-MFC-AGG-ID: eBVZvZSpMyK63EQioNnBCA_1744366687
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D49881800257; Fri, 11 Apr 2025 10:18:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6943001D0E; Fri, 11 Apr 2025 10:18:03 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:18:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
Message-ID: <Z_jsWQElOJyblb91@redhat.com>
References: <20250407155949.44736-1-kwolf@redhat.com>
 <bf72ef35-289c-4ec7-962b-414e3487c176@redhat.com>
 <CABgObfaJw1VSE6pbs2o1oTTGi6nXLtFQG90RG3J9DY1sukZpMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaJw1VSE6pbs2o1oTTGi6nXLtFQG90RG3J9DY1sukZpMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 10.04.2025 um 17:28 hat Paolo Bonzini geschrieben:
> On Thu, Apr 10, 2025 at 4:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > You should set ret = 0 here to avoid going down the
> > scsi_sense_from_errno() path.
> >
> > Otherwise,
> >
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Okay, going down the scsi_sense_from_errno() path is more or less
> harmless because status and sense end up unused; even though ENODEV is
> not something that the function handles, that can be added as a
> cleanup in 10.1.

Yes, it could be handled more explicitly. I considered adding a special
if branch in scsi_handle_rw_error() for host_status != -1 before
checking ret < 0, but didn't do it in the end because the existing code
already handles it fine. If you prefer it to be there for readability, I
can send a cleanup patch.

Kevin


