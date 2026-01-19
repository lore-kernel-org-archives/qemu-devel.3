Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E44CA5FF1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 06:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhj3N-0008Kj-9C; Mon, 19 Jan 2026 01:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhj3K-0008Jo-8X
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 01:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhj3I-0005ug-3P
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 01:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768805270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUH1QpD8GuH+emdbXT41qDCRQHDGxZhVEOzNWsFLWKg=;
 b=elyTVh9WdZKMmqvwzJxITegFdKm5K9kkqVRGWWYxhH9EfadjquybicymQ1qLHJcYcWZ4mI
 zRKzH5B4zWyYL+5nLhlhuVrzMJ5waCFjT7cxnsuypkwlCUO1q+QZ7JFeQhPyzifwMJofD/
 s1Q/pBeUBeOJGVreceHkL7C7Lo6ISiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-OdPljiBFM--ZUrs6IDAHBw-1; Mon,
 19 Jan 2026 01:47:46 -0500
X-MC-Unique: OdPljiBFM--ZUrs6IDAHBw-1
X-Mimecast-MFC-AGG-ID: OdPljiBFM--ZUrs6IDAHBw_1768805265
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC56E180044D; Mon, 19 Jan 2026 06:47:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37A151955F22; Mon, 19 Jan 2026 06:47:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2A2821E692D; Mon, 19 Jan 2026 07:47:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit Shah
 <amit@kernel.org>,  Markus Armbruster <armbru@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,  Szymon Lukasz
 <noh4hss@gmail.com>
Subject: Re: [PATCH v6 07/12] qmp: add chardev-window-size-changed command
In-Reply-To: <20260119-console-resize-v6-7-33a7b0330a7a@gmail.com> (Filip
 Hejsek's message of "Mon, 19 Jan 2026 04:27:50 +0100")
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-7-33a7b0330a7a@gmail.com>
Date: Mon, 19 Jan 2026 07:47:41 +0100
Message-ID: <87jyxep08i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Filip Hejsek <filip.hejsek@gmail.com> writes:

> From: Szymon Lukasz <noh4hss@gmail.com>
>
> The managment software can use this command to notify QEMU about the
> size of the terminal connected to a chardev, QEMU can then forward this
> information to the guest if the chardev is connected to a virtio console
> device.
>
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> [Filip: rename command, change documentation]
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index 140614f82c..bc08f0161a 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -861,6 +861,37 @@
>  { 'command': 'chardev-send-break',
>    'data': { 'id': 'str' } }
>=20=20
> +##
> +# @chardev-window-size-changed:
> +#
> +# Notifies a chardev about the current size of the terminal connected
> +# to this chardev.  The information will be forwarded to the guest if
> +# the chardev is connected to a virtio console device.
> +#
> +# The initial size is 0x0, which should be interpreted as an unknown
> +# size.
> +#
> +# Some backends detect the terminal size automatically, in which case
> +# the size may unpredictably revert to the detected one at any time.
> +#
> +# @id: the chardev's ID, must exist

Please drop ", must exist" for consistency with ID descriptions
elsewhere.

> +#
> +# @cols: the number of columns
> +#
> +# @rows: the number of rows
> +#
> +# Since: 11.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "chardev-window-size-changed", "arguments": { "id"=
: "foo", "cols": 80, "rows": 24 } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'chardev-window-size-changed',
> +  'data': { 'id': 'str',
> +            'cols': 'uint16',
> +            'rows': 'uint16' } }
> +
>  ##
>  # @VSERPORT_CHANGE:
>  #


