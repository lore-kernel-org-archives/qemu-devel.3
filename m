Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC27ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snb8B-0005SF-Vm; Mon, 09 Sep 2024 05:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1snb86-00054l-9D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1snb84-0007Mp-Hd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725875775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtcpCuv+xs+kaRVqMi+GRxdjcOEyUNo2VlBFhPkk3nM=;
 b=hAEXgiey/Nes3sdlec1cFr9JTvfYWJWthoAIRxvH5dlOd04BTt/n2d+WCSQtC/K2YtvY1T
 6EdqdD2EV7TCQ73alQ9mSx7vuNNd4PdZJAo5n5Dnqyc2c/SltAeI6BJ+rODMONkVr0KfhQ
 pBZ+AjWMzoTDD/xYMmFhXbpoiLkG5vM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-l5Cw-hJvOJ6HWl0xeie5wA-1; Mon,
 09 Sep 2024 05:56:12 -0400
X-MC-Unique: l5Cw-hJvOJ6HWl0xeie5wA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27C1119560A5; Mon,  9 Sep 2024 09:56:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A18E41956048; Mon,  9 Sep 2024 09:56:06 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:56:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH] block: support locking on change medium
Message-ID: <Zt7GM1uLzE5Z176u@redhat.com>
References: <20240909015847.40377-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909015847.40377-1-j@getutm.app>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 09.09.2024 um 03:58 hat Joelle van Dyne geschrieben:
> New optional argument for 'blockdev-change-medium' QAPI command to allow
> the caller to specify if they wish to enable file locking.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

I feel once you need to control such details of the backend, you should
really use a separate 'blockdev-add' commannd.

If it feels a bit too cumbersome to send explicit commands to open the
tray, remove the medium, insert the new medium referencing the node you
added with 'blockdev-add' and then close the tray again, I can
understand. Maybe what we should do is extend 'blockdev-change-medium'
so that it doesn't only accept a filename to specify the new images, but
alternatively also a node-name.

> +    switch (file_locking_mode) {
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
> +        break;
> +
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
> +        qdict_put_str(options, "file.locking", "off");
> +        break;
> +
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
> +        qdict_put_str(options, "file.locking", "on");
> +        break;
> +
> +    default:
> +        abort();
> +    }

Using "file.locking" makes assumptions about what the passed filename
string would result in. There is nothing that guarantees that the block
driver even has a "file" child, or that the "file" child is referring
to a file-posix driver rather than using a different protocol or being a
filter driver above yet another node. It also doesn't consider backing
files and other non-primary children of the opened node.

So this is not correct, and I don't think there is any realistic way of
making it correct with this approach.

Kevin


