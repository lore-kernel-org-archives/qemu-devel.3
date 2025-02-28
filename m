Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC70C282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6tP-0002Ou-LW; Fri, 28 Feb 2025 15:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1to6tO-0002Jk-Q7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1to6tL-00031G-B3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740774204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eni8Zrw7kMLCtsByvvKGEtf/CYD4C5cbO1hI1SodTwY=;
 b=F/4fmJCfXpIYv1dRjsqnZXnN+CcdDVk6rCFNbRFtT62DhxdUg6IMPODBc9p40/NdCvS68q
 uIYI07VRvEHYvmbnroGgbQOy4pUGfWVZ3SFaMw9zKqn0FVFaasd2M1IyAxRC45udMwUJTO
 vkITz37XTZ1nIoZWxeAPmOui3wqxOlI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-aOkxnnfWN4uaPLcpXFFn6g-1; Fri,
 28 Feb 2025 15:23:19 -0500
X-MC-Unique: aOkxnnfWN4uaPLcpXFFn6g-1
X-Mimecast-MFC-AGG-ID: aOkxnnfWN4uaPLcpXFFn6g_1740774198
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40A519560B5; Fri, 28 Feb 2025 20:23:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B6A1800359; Fri, 28 Feb 2025 20:23:15 +0000 (UTC)
Date: Fri, 28 Feb 2025 14:23:12 -0600
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2] iotest: Unbreak 302 with python 3.13
Message-ID: <dyhnb6zxkmzkr6gkhwokdjibvrt52otmqqc6q6ko5ejfkub6tk@lnwxbr7lnppq>
References: <20250228195708.48035-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228195708.48035-1-nirsof@gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 28, 2025 at 09:57:08PM +0200, Nir Soffer wrote:
> This test depends on TarFile.addfile() to add tar member header without
> writing the member data, which we write ourself using qemu-nbd. Python
> 3.13 changed the function in a backward incompatible way[1] to require a
> file object for tarinfo with non-zero size, breaking the test:
> 
>      -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
>      +Traceback (most recent call last):
>      +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <module>
>      +    tar.addfile(disk)
>      +    ~~~~~~~~~~~^^^^^^
>      +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
>      +    raise ValueError("fileobj not provided for non zero-size regular file")
>      +ValueError: fileobj not provided for non zero-size regular file
> 
> The new behavior makes sense for most users, but breaks our unusual
> usage. Fix the test to add the member header directly using public but
> undocumented attributes. This is more fragile but the test works again.
> 
> This also fixes a bug in the previous code - when calling addfile()
> without a fileobject, tar.offset points to the start of the member data
> instead of the end.
> 
> [1] https://github.com/python/cpython/pull/117988
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>


Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
>  tests/qemu-iotests/302 | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
> index a6d79e727b..e980ec513f 100755
> --- a/tests/qemu-iotests/302
> +++ b/tests/qemu-iotests/302
> @@ -115,13 +115,22 @@ with tarfile.open(tar_file, "w") as tar:
>  
>      disk = tarfile.TarInfo("disk")
>      disk.size = actual_size
> -    tar.addfile(disk)
>  
> -    # 6. Shrink the tar to the actual size, aligned to 512 bytes.
> +    # Since python 3.13 we cannot use addfile() to create the member header.
> +    # Add the tarinfo directly using public but undocumented attributes.
>  
> -    tar_size = offset + (disk.size + 511) & ~511
> -    tar.fileobj.seek(tar_size)
> -    tar.fileobj.truncate(tar_size)
> +    buf = disk.tobuf(tar.format, tar.encoding, tar.errors)
> +    tar.fileobj.write(buf)
> +    tar.members.append(disk)
> +
> +    # Update the offset and position to the location of the next member.
> +
> +    tar.offset = offset + (disk.size + 511) & ~511
> +    tar.fileobj.seek(tar.offset)
> +
> +    # 6. Shrink the tar to the actual size.
> +
> +    tar.fileobj.truncate(tar.offset)
>  
>  with tarfile.open(tar_file) as tar:
>      members = [{"name": m.name, "size": m.size, "offset": m.offset_data}
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


