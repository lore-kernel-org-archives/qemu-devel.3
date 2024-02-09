Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5396CC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQDz-00020Q-J1; Fri, 09 Feb 2024 07:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYQDy-00020I-CV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYQDv-0003T7-La
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707482598;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BYkzwTp7qpaea3U10Rh4C78Bl6YrrexAzFxZ32/joBM=;
 b=CLQuuCED/h0AXqzLFI2YfOLU3oAbklWs5RQTUAvCVDBnGrRt8wo0VN9ZuF3YToxKcqHIoy
 /p4U28T6roBX6Q6lpjEfxWJ5IHPdfr6IrP/fkX0jBljSZuCWCSVOem2xl2jmLFiUWB7uGa
 m0RJchK0PLCNS5oa015WK5N0Jv5Ywok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-4__y5-pnPgyNr5UrVv2zCQ-1; Fri, 09 Feb 2024 07:43:09 -0500
X-MC-Unique: 4__y5-pnPgyNr5UrVv2zCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 828DE881C82;
 Fri,  9 Feb 2024 12:43:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A331103A;
 Fri,  9 Feb 2024 12:43:08 +0000 (UTC)
Date: Fri, 9 Feb 2024 12:43:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 7/7] tests: Add case for LUKS volume with detached
 header
Message-ID: <ZcYd2pYRjCOPWgDA@redhat.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
 <87aa559fbc0c98a5b90ac4f3fa25cb7438a5c181.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87aa559fbc0c98a5b90ac4f3fa25cb7438a5c181.1706586786.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 30, 2024 at 01:37:25PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Also, add a section to the MAINTAINERS file for detached
> LUKS header, it only has a test case in it currently.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  MAINTAINERS                                   |   5 +
>  tests/qemu-iotests/tests/luks-detached-header | 218 ++++++++++++++++++
>  .../tests/luks-detached-header.out            |   5 +
>  3 files changed, 228 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/luks-detached-header
>  create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

Pylint has some complaints on this which I needed to fix. Most of the
issues were long line length related.

Rather than manmually fix it, I decided to run it through the
'black -l 80' to bulk reformat in a standard style. There were
a few bits black didn't want to fix, so I refactored a couple.

> diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-iotests/tests/luks-detached-header
> new file mode 100755
> index 0000000000..f0b5f3921c
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/luks-detached-header
> @@ -0,0 +1,218 @@
> +#!/usr/bin/env python3
> +# group: rw auto
> +#
> +# Test LUKS volume with detached header
> +#
> +# Copyright (C) 2024 SmartX Inc.
> +#
> +# Authors:
> +#     Hyman Huang <yong.huang@smartx.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import os
> +import iotests
> +from iotests import imgfmt, qemu_img_create, img_info_log, qemu_img_info, QMPTestCase

img_info_log si unused, so I dropped that.

> +
> +
> +image_size = 128 * 1024 * 1024
> +
> +luks_img = os.path.join(iotests.test_dir, 'luks.img')
> +detached_header_img1 = os.path.join(iotests.test_dir, 'detached_header.img1')
> +detached_header_img2 = os.path.join(iotests.test_dir, 'detached_header.img2')
> +detached_payload_raw_img = os.path.join(iotests.test_dir, 'detached_payload_raw.img')
> +detached_payload_qcow2_img = os.path.join(iotests.test_dir, 'detached_payload_qcow2.img')
> +detached_header_raw_img = \
> +    "json:{\"driver\":\"luks\",\"file\":{\"filename\":\"%s\"},\"header\":{\"filename\":\"%s\"}}" % (detached_payload_raw_img, detached_header_img1)
> +detached_header_qcow2_img = \
> +    "json:{\"driver\":\"luks\",\"file\":{\"filename\":\"%s\"},\"header\":{\"filename\":\"%s\"}}" % (detached_payload_qcow2_img, detached_header_img2)

Black doesn't like to break strings, so I decided to turn
this into python objects and get rid of the formatting:

detached_header_raw_img = "json:" + json.dumps(
    {
        "driver": "luks",
        "file": {"filename": detached_payload_raw_img},
        "header": {
            "filename": detached_header_img1,
        },
    }
)



> +        # Detached LUKS header with raw payload
> +        result = self.vm.qmp('human-monitor-command',
> +                             command_line='qemu-io luks-2-payload-raw-format "write -P 41 0 64k"')
> +        self.assert_qmp(result, 'return', '')

Here, I just declared the qemu-io command ahead of time

        cmd = 'qemu-io luks-2-payload-raw-format "write -P 41 0 64k"'
        result = self.vm.qmp(
            "human-monitor-command",
            command_line=cmd
        )


> +
> +        result = self.vm.qmp('human-monitor-command',
> +                             command_line='qemu-io luks-2-payload-raw-format "read -P 41 0 64k"')
> +        self.assert_qmp(result, 'return', '')
> +
> +        # Detached LUKS header with qcow2 payload
> +        result = self.vm.qmp('human-monitor-command',
> +                             command_line='qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"')
> +        self.assert_qmp(result, 'return', '')
> +
> +        result = self.vm.qmp('human-monitor-command',
> +                             command_line='qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"')
> +        self.assert_qmp(result, 'return', '')
> +
> +        self.vm.shutdown()
> +


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


