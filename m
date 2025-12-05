Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8DBD2F7D9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 17:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRZTc-0005vd-1i; Fri, 05 Dec 2025 12:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRZTa-0005ui-Cf
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRZTY-00048s-RO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764955211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQu7hm2uH4Dpueofeb0aGNkJKPG85nce4KNgQHFOZUI=;
 b=J5dOD7M9AzYNEmZT7KCZar5EbNo6IUHJO30D2r+6hggrkScm6FTfNovGR2Mz1rcPPhGISg
 pL+4QcJj2ZJ3fkR9+IauKkKMDPoPbgcmO7gImRMJx4MltyRVXggLvkU65A7nE9snSxcIjK
 Ahvs5IyuynuSLE7x1ma/RDUX0mZ7/Dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-GmvrqSudMlGYCwFNcJYLNw-1; Fri,
 05 Dec 2025 12:20:07 -0500
X-MC-Unique: GmvrqSudMlGYCwFNcJYLNw-1
X-Mimecast-MFC-AGG-ID: GmvrqSudMlGYCwFNcJYLNw_1764955206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 758A318001FE; Fri,  5 Dec 2025 17:20:06 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C15B180029B; Fri,  5 Dec 2025 17:20:03 +0000 (UTC)
Date: Fri, 5 Dec 2025 18:20:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Check for a functional "secret"
 object before using it
Message-ID: <aTMUQXOjJO0EiK8b@redhat.com>
References: <20251205130014.693799-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205130014.693799-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 05.12.2025 um 14:00 hat Thomas Huth geschrieben:
> From: Thomas Huth <thuth@redhat.com>
> 
> QEMU iotests 049, 134 and 158 are currently failing if you compiled
> QEMU without the crypto libraries. Thus make sure that the "secret"
> object is really usable and skip the tests otherwise.
> 
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index e977cb4eb61..10d83d8361b 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -1053,6 +1053,20 @@ _require_one_device_of()
>      _notrun "$* not available"
>  }
>  
> +_require_secret()
> +{
> +    if [ -e "$TEST_IMG" ]; then
> +        echo "unwilling to overwrite existing file"
> +        exit 1
> +    fi
> +    if $QEMU_IMG create -f $IMGFMT --object secret,id=sec0,data=123 \
> +                 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 1M 2>&1 \
> +                 | grep "Unsupported cipher" ; then
> +        _notrun "missing cipher support"
> +    fi

What is the thing that you're checking here? If it's really the secret,
then just running 'qemu-io --object secret,data=123,id=sec0 -c ""' would
be enough. If it's not the secret, but encryption support, then the
function is a misnomer.

_require_working_luks() looks pretty similar, though it requires
specifically a working luks driver. Could something be unified? (The
answer might be no, but it would be good to explicitly say it.)

Kevin

> +    rm -f "$TEST_IMG"
> +}
> +
>  _qcow2_dump_header()
>  {
>      if [[ "$1" == "--no-filter-compression" ]]; then
> -- 
> 2.52.0
> 


