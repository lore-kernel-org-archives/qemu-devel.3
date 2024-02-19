Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F20C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4ZB-000263-0X; Mon, 19 Feb 2024 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Z9-000202-EV
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Z7-00020C-OA
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708352655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKmwzc9arQvQ/YMujDPllRaQRZ7lO5m8ghqbTilMuRA=;
 b=g+/KqvJjUQj2fPwpIU3aIK8A0OzTEElakEF8w1yD7g+/Li1++HmquyZOemQ/LofVYf2d19
 bnlPSQfwCXXOWtjphbC+oG3ZO9QHXqcFPoUYjAW/nV1RWNzNgo/8xLs6scC1qhhHTTzgtp
 v3lqOwPw9+4f9EE+fb9uixPheECL2Yc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-5Z60k3E3M9aDlecb0-mwtg-1; Mon,
 19 Feb 2024 09:24:12 -0500
X-MC-Unique: 5Z60k3E3M9aDlecb0-mwtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66CB33C0ED51;
 Mon, 19 Feb 2024 14:24:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0085D1C060AF;
 Mon, 19 Feb 2024 14:24:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9FA521E66D0; Mon, 19 Feb 2024 15:24:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 4/7] block: Support detached LUKS header creation
 using blockdev-create
In-Reply-To: <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
 (yong huang's message of "Tue, 30 Jan 2024 13:37:22 +0800")
References: <cover.1706586786.git.yong.huang@smartx.com>
 <9e35e621f12478822072e5c740ed65beb77f1238.1706586786.git.yong.huang@smartx.com>
Date: Mon, 19 Feb 2024 15:24:04 +0100
Message-ID: <87v86kjzwb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Firstly, enable the ability to choose the block device containing
> a detachable LUKS header by adding the 'header' parameter to
> BlockdevCreateOptionsLUKS.
>
> Secondly, when formatting the LUKS volume with a detachable header,
> truncate the payload volume to length without a header size.
>
> Using the qmp blockdev command, create the LUKS volume with a
> detachable header as follows:
>
> 1. add the secret to lock/unlock the cipher stored in the
>    detached LUKS header
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
>> "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'
>
> 2. create a header img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
>> "arguments":{"job-id":"job0", "options":{"driver":"file",
>> "filename":"/path/to/detached_luks_header.img", "size":0 }}}'
>
> 3. add protocol blockdev node for header
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>> "arguments": {"driver":"file", "filename":
>> "/path/to/detached_luks_header.img", "node-name":
>> "detached-luks-header-storage"}}'
>
> 4. create a payload img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
>> "arguments":{"job-id":"job1", "options":{"driver":"file",
>> "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'
>
> 5. add protocol blockdev node for payload
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
>> "arguments": {"driver":"file", "filename":
>> "/path/to/detached_luks_payload_raw.img", "node-name":
>> "luks-payload-raw-storage"}}'
>
> 6. do the formatting with 128M size
> $ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
>> "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
>> "detached-luks-header-storage", "file":"luks-payload-raw-storage",
>> "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 69a88d613d..eab15d7dd9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4960,6 +4960,8 @@
>  # @file: Node to create the image format on, mandatory except when
>  #        'preallocation' is not requested
>  #
> +# @header: Block device holding a detached LUKS header. (since 9.0)
> +#

Behavior when @header is present vs. behavior when it's absent?

>  # @size: Size of the virtual disk in bytes
>  #
>  # @preallocation: Preallocation mode for the new image (since: 4.2)
> @@ -4970,6 +4972,7 @@
>  { 'struct': 'BlockdevCreateOptionsLUKS',
>    'base': 'QCryptoBlockCreateOptionsLUKS',
>    'data': { '*file':            'BlockdevRef',
> +            '*header':          'BlockdevRef',
>              'size':             'size',
>              '*preallocation':   'PreallocMode' } }


