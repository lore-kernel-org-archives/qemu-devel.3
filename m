Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3664DEB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyPM-00061D-8b; Tue, 10 Mar 2026 10:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzyOj-0005j2-HV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzyOh-00079c-6w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773154161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDjrOX8OTmS0YrJS/HUadDL3Jw4oRW7VqR0OXakNd7k=;
 b=h9ufMZ5KCwChtGpaLf0DA0tRmDf86ljyvrKgLzA+jddZzj09qXadO/9M1sIZD4S91jIGjY
 ZDd0FekRKyVtLjfo5hlgGvIdiVjqfzSZ52qbyXtdaOkN8vsGKKtwAjJF9O+UvhHWyP1E5O
 rU6hGnwiT/U35q/LkQuINDYcOXa4TfU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-IiwWGl5aOd6SfN4-NqShNg-1; Tue,
 10 Mar 2026 10:49:18 -0400
X-MC-Unique: IiwWGl5aOd6SfN4-NqShNg-1
X-Mimecast-MFC-AGG-ID: IiwWGl5aOd6SfN4-NqShNg_1773154157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 026F018002C7; Tue, 10 Mar 2026 14:49:17 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 880F1180075C; Tue, 10 Mar 2026 14:49:14 +0000 (UTC)
Date: Tue, 10 Mar 2026 15:49:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 0/3] block/curl: fix S3 presigned URL support
Message-ID: <abAvZxR8bXI_RvVW@redhat.com>
References: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 27.02.2026 um 13:45 hat Antoine Damhet geschrieben:
> Hi,
> 
> This series adds the support for S3 presigned URLs that only allow HTTP
> GET requests. While working on this I also stumbled upon a deadlock with
> concurrent I/O and slipped the fix here. Over the years there was
> already an attempt to support these kinds of URLs[1] and at least one
> report of a user in need of the feature[2].
> 
> Unfortunately S3 only allows a presigned URL to live up to 7 days so we
> can't really put an example with a stable URL on the commit message but
> here is a presigned URL for the archlinux cloud image[3] that will
> expire in ~7 days.
> 
> [1]: https://lore.kernel.org/qemu-devel/110120539.4133.de5ac8a5-69d1-4f59-9540-4a679771a547.open-xchange@ox.pcextreme.nl/
> [2]: https://lore.kernel.org/qemu-devel/7b37cc65-1314-29f4-006f-70836bdfb4b4@linaro.org/
> [3]: https://test-presigned.s3.fr-par.scw.cloud/Arch-Linux-x86_64-cloudimg.qcow2?AWSAccessKeyId=SCWDHE3XBQGZFV282QKG&Expires=1772798381&Signature=zUxbVAWQ9Tl%2B%2Bf1jUW6q3o3His4%3D

Thanks, applied to the block branch.

Kevin


