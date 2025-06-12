Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45105C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 19:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPnNC-0004MZ-PP; Thu, 12 Jun 2025 15:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uPnNB-0004MN-Ew
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uPnN9-0004Ti-WC
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 15:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749755639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fbL54LZAbYychfWBsxS+kwA/bJySc8qZd3neB8AdNY=;
 b=fL7KuC3lXhEqwWD+nh18VfczXzN+Q4Xwot152f40UzOb8VI/dwhot7LJrXwp6A0G6yUp5h
 nKrbgMb+h6/Yx8S0FKjYh4gOUcUCFL7HY9EqEkT3Z8920ArGTzgb6e9dur69f5Kiyu4Sug
 y2EQy3gW9rJgBnYUtH+AmEBDfcJQWBg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-5cSM4TcjOsWO8rIh974Etw-1; Thu,
 12 Jun 2025 15:13:56 -0400
X-MC-Unique: 5cSM4TcjOsWO8rIh974Etw-1
X-Mimecast-MFC-AGG-ID: 5cSM4TcjOsWO8rIh974Etw_1749755635
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31103195608E; Thu, 12 Jun 2025 19:13:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57808195E74E; Thu, 12 Jun 2025 19:13:53 +0000 (UTC)
Date: Thu, 12 Jun 2025 14:13:50 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 4/4] iotests/244: Add test cases for keep_data_file
Message-ID: <wp3ans5btyhk5mccchlsrmpsmwklsvdmoh3rfl75wy5lwif33v@lgg7c7u2y7ns>
References: <20250530084448.192369-1-hreitz@redhat.com>
 <20250530084448.192369-5-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530084448.192369-5-hreitz@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, May 30, 2025 at 10:44:47AM +0200, Hanna Czenczek wrote:
> Add various test cases around keep_data_file to the existing data_file
> test suite 244.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  tests/qemu-iotests/244     | 71 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/244.out | 53 ++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
> index bb9cc6512f..ec81df8d6a 100755
> --- a/tests/qemu-iotests/244
> +++ b/tests/qemu-iotests/244
> @@ -384,6 +384,77 @@ $QEMU_IMG compare --image-opts \
>      "driver=raw,file.filename=$TEST_IMG.data"  \
>      "file.filename=$TEST_IMG,backing.file.filename=$TEST_IMG.base"
>  

> +
> +# Maybe a matter of taste whether this should fail or create the file, but
> +# failing is simpler (= will always skip create) and seems safer (users may
> +# expect the file to exist, and the error will warn them when it does not).
> +_make_test_img \
> +    -o "data_file=$TEST_IMG.doesnotexist,keep_data_file=on,data_file_raw=on" \
> +    1M

I agree with the failure here.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


