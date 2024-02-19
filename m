Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46341C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Zn-0002ib-2i; Mon, 19 Feb 2024 09:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Zk-0002iG-MJ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc4Zj-00024i-A4
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708352694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xAmZgNX4gqK1FDrzwrmDlpXb4sl6ZgTXQJkyvMR8EM=;
 b=IIRf4BBIe7ygzwET/6c8sa0E4/xLrcMZeHoW/EWeQURsF9WkzmSVbYEdq2/Fud8AE5rBRn
 8cD8onwEPhCZFOOdOEIdZPiZPksfWSPoK3lJZo4zuFGIpOIC1gv591LRzzbRcK8q11oLbu
 DqXZ/B7b90O+Kya4Om6wlBD5d0ZU+V8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-kE-tBj4ZO3iOzfXxtA0nHQ-1; Mon,
 19 Feb 2024 09:24:52 -0500
X-MC-Unique: kE-tBj4ZO3iOzfXxtA0nHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 077CF1C54460;
 Mon, 19 Feb 2024 14:24:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9CAB40149B7;
 Mon, 19 Feb 2024 14:24:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE1EA21E66D0; Mon, 19 Feb 2024 15:24:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 5/7] block: Support detached LUKS header creation
 using qemu-img
In-Reply-To: <c573cf4d985b0386e2e419fcccd92245800cdeca.1706586786.git.yong.huang@smartx.com>
 (yong huang's message of "Tue, 30 Jan 2024 13:37:23 +0800")
References: <cover.1706586786.git.yong.huang@smartx.com>
 <c573cf4d985b0386e2e419fcccd92245800cdeca.1706586786.git.yong.huang@smartx.com>
Date: Mon, 19 Feb 2024 15:24:50 +0100
Message-ID: <87r0h8jzv1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Even though a LUKS header might be created with cryptsetup,
> qemu-img should be enhanced to accommodate it as well.
>
> Add the 'detached-header' option to specify the creation of
> a detached LUKS header. This is how it is used:
> $ qemu-img create --object secret,id=sec0,data=abc123 -f luks
>> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
>> -o detached-header=true header.luks
>
> Using qemu-img or cryptsetup tools to query information of
> an LUKS header image as follows:
>
> Assume a detached LUKS header image has been created by:
> $ dd if=/dev/zero of=test-header.img bs=1M count=32
> $ dd if=/dev/zero of=test-payload.img bs=1M count=1000
> $ cryptsetup luksFormat --header test-header.img test-payload.img
>> --force-password --type luks1
>
> Header image information could be queried using cryptsetup:
> $ cryptsetup luksDump test-header.img
>
> or qemu-img:
> $ qemu-img info 'json:{"driver":"luks","file":{"filename":
>> "test-payload.img"},"header":{"filename":"test-header.img"}}'
>
> When using qemu-img, keep in mind that the entire disk
> information specified by the JSON-format string above must be
> supplied on the commandline; if not, an overlay check will reveal
> a problem with the LUKS volume check logic.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

[...]

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index fd3d46ebd1..62fd145223 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -223,6 +223,8 @@
>  # @iter-time: number of milliseconds to spend in PBKDF passphrase
>  #     processing.  Currently defaults to 2000. (since 2.8)
>  #
> +# @detached-header: create a detached LUKS header. (since 9.0)
> +#

Behavior when @detached-header is present vs. behavior when it's absent?

>  # Since: 2.6
>  ##
>  { 'struct': 'QCryptoBlockCreateOptionsLUKS',
> @@ -232,7 +234,8 @@
>              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
>              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
>              '*hash-alg': 'QCryptoHashAlgorithm',
> -            '*iter-time': 'int'}}
> +            '*iter-time': 'int',
> +            '*detached-header': 'bool'}}
>  
>  ##
>  # @QCryptoBlockOpenOptions:


