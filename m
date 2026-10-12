Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B21ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGF3m-0004kK-19; Mon, 12 Oct 2026 08:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3c-0004jw-EW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3Z-0007Kg-GA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791807783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Z5KMjYqhDOmGJa/L8V9+5NG6AeDAiE5fg0xQCM7qx8=;
 b=M5U4OMUAeLSiHzuYhX7BgDEQd8MLFPPYIgYvLaXu/Rqbxh+BjkY3P7TN++9ZCb+s5RQ8ui
 iiE7DnHiJXyJerqARINr7Ga3awEivN8sVvyt/4r5aUrsq7TnDOuI9ZcNalTujKyMG7peG0
 KQ5MocWUl8bCBR/bGOrl66KaFKcZAVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-BSV0kAepOLivHsU1YkLJsw-1; Mon,
 12 Oct 2026 12:22:59 +0000
X-MC-Unique: BSV0kAepOLivHsU1YkLJsw-1
X-Mimecast-MFC-AGG-ID: BSV0kAepOLivHsU1YkLJsw_1791807778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE948180A37E; Mon, 12 Oct 2026 12:22:57 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 298F2195608C; Mon, 12 Oct 2026 12:22:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 00/12] virtio-console: notify about the terminal
 size
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
Date: Mon, 12 Oct 2026 16:22:47 +0400
Message-Id: <179180776714.1821755.6914686134404102313.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lL6zp0fyopDZDGnErCgu9svfocLP0vsukv9GMn+MirQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzNEaEgijGkAngGBQGptZKKa4qnHbWQw6kNyIU
 D5CvCARYgSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaszRGgAKCRDa6OEJdZac
 5b7YD/91D6gaqNc7TGhZZbkBFvDmaQmCdSEvDu8jk1C82JaR4iMaCMFt9vtxVYMIasJhumfRppe
 ROgOfWCwuhrQYr0DH/SSJXWwtGJ+4CXTnnerTAw3+WL1hBNLI6gGQknBaw7j54YOPBsuttEC8x7
 CLmILHswiDs7REz9B7s6O25rMrnbMIKxsxXziL1kyFpEwC9Ny1FxdAB9FqXb3NmhjrFFynf1WgJ
 e9n+Yl8IvYqMMg/3yyr6GqjVyn2umZVB0lcU6i2sOtARLig6iM0BRxdcSHQIKRgkp9W1Hy3wOrf
 g3HKrHwgN710kROCY8dm+EBMBw1XSIEh0z1yRoMLf/uKmqzTn9L7f/LAmkZjpHxfQVeltXpHIpG
 E6y8abP6yOJMY8d5b5zyuMDtk2NDvLO3gdNyN5gjyNnaej2lZh4H/Urap2i1WiADOfuvpNpD17/
 Bet/ulvsq74pAVHOdytm+AudymvJ9WhbP5Dzat6LKF0EEJ3T6Thxb1mVgdgz+8WHd0DLejkG2JY
 P/sCk/d2esBtA6pcFjhkBg2QHC8oYt8b3bD3STBZDU7JAk9cx/Jt28sbgsKYXwOhyO874X1KVjH
 UUm7JmULkz7EKcr0ka6+ZhAVroDc+rLWHDmf05cHWbKUkNWwuhGt8VdSYCcISQ95t6Sd28KhNvU
 A2iQhKGYGspK6Zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Summary of the Series
> ---------------------
> 
> This series adds terminal size support to the virtio-console device.
> The goal is to make it possible to get a resizable terminal into a guest
> without using e.g. ssh.
> 
> Support for detecting terminal size is added to stdio and vc backends,
> but not pty and serial, because for the later it's unfortunately
> impossible to get resize notifications.
> 
> A QMP command is added for notifying QEMU about the terminal size
> of any chardev. This can be used by clients to support resizing for
> devices where QEMU is not able to detect the size by itself (e.g. virsh
> console).
> 
> There was a bug in Linux versions prior to 6.15 which caused the
> dimensions to be interpreted incorrectly by the guest. The fix has
> been backported to currently supported kernels, but to avoid making the
> terminal harder to use on out of date guests, the feature is disabled
> by default and must be enabled with the console-size property.
> 
> Limitations
> -----------
> 
> There is no documentation for the virtio-serial device. I'm working on
> this and will submit it separately.
> 
> Resizing support for the spice version of 'vc' chardev is still missing.
> 
> After migration, the guest is not informed about the new console size.
> I propably won't fix this any time soon unless someone helps me with
> migration stream changes.
> 
> Full Changelog
> --------------
> 
> v9:
> - Clean up SIGWINCH notifier when stdio or curses chardev is destroyed
> - Link to v8: https://lore.kernel.org/qemu-devel/20260929-console-resize-v8-0-2ff9183f8750@gmail.com

Only a build issue on win32 with patch 6, I can eventually fix on commit, but
you can also send v10.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


