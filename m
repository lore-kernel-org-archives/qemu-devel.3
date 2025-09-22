Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C01ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 06:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0aJ8-0002yg-OT; Mon, 22 Sep 2025 02:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0aJ4-0002yM-EI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0aJ0-00061H-Mx
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758523540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTgDNx5rY2NZ1/p8wRYZxQUjFRiVpdhb40CZ0+mdA5o=;
 b=TtX1st9sQpO4MelJO37HBk8NMsVyTTTWDoFrZ4QcZp6BUTghPNesE39dkvdgKeqBtP4/jH
 31Zfv/UyPVAOkrsmcEbx9JLwnW3i6/xWduSPLkFBvbgd79rQwe09HoUX+gP9d19i7AhEwR
 8PqpiJqmUL34gUOfxEiHfYsshogJ124=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-rDUeMrX7NCGT_4LZEzGd4A-1; Mon,
 22 Sep 2025 02:45:37 -0400
X-MC-Unique: rDUeMrX7NCGT_4LZEzGd4A-1
X-Mimecast-MFC-AGG-ID: rDUeMrX7NCGT_4LZEzGd4A_1758523535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36D3C1800286; Mon, 22 Sep 2025 06:45:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70AE418004A3; Mon, 22 Sep 2025 06:45:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C38B121E6A27; Mon, 22 Sep 2025 08:45:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit Shah
 <amit@kernel.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Maximilian Immanuel
 Brandtner <maxbr@linux.ibm.com>,  Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH RFC v5 07/12] qmp: add chardev-window-size-changed command
In-Reply-To: <20250921-console-resize-v5-7-89e3c6727060@gmail.com> (Filip
 Hejsek's message of "Sun, 21 Sep 2025 01:45:37 +0200")
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
Date: Mon, 22 Sep 2025 08:45:31 +0200
Message-ID: <878qi7nfxw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  chardev/char.c | 14 ++++++++++++++
>  qapi/char.json | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index b45d79cb9b57643827eb7479257fdda2cf6b0434..f3aad545afe3d325aac388015=
b3d5517c2e48f0d 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth=
, bool skipauth,
>      return true;
>  }
>=20=20
> +void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
> +                                     uint16_t rows, Error **errp)
> +{
> +    Chardev *chr;
> +
> +    chr =3D qemu_chr_find(id);
> +    if (chr =3D=3D NULL) {
> +        error_setg(errp, "Chardev '%s' not found", id);
> +        return;
> +    }
> +
> +    qemu_chr_resize(chr, cols, rows);
> +}
> +
>  /*
>   * Add a timeout callback for the chardev (in milliseconds), return
>   * the GSource object created. Please use this to add timeout hook for
> diff --git a/qapi/char.json b/qapi/char.json
> index f0a53f742c8bee24c377551803a864fd36ac78cf..93b0d239276077d808af2e547=
9d539728377a99f 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -874,6 +874,36 @@
>  { 'command': 'chardev-send-break',
>    'data': { 'id': 'str' } }
>=20=20
> +##
> +# @chardev-window-size-changed:
> +#
> +# Notifies a chardev about the current size of the terminal connected
> +# to this chardev. The information will be forwarded to the guest if
> +# the chardev is connected to a virtio console device.
> +#
> +# The initial size is 0x0, which should be interpreted as an unknown siz=
e.
> +#
> +# Some backends detect the terminal size automatically, in which case
> +# the size may unpredictably revert to the detected one at any time.

Nicely done now!

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> +#
> +# @id: the chardev's ID, must exist

Let's drop ", must exist" for consistency with ID descriptions
elsewhere.

> +#
> +# @cols: the number of columns
> +#
> +# @rows: the number of rows
> +#
> +# Since: 10.2
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

Acked-by: Markus Armbruster <armbru@redhat.com>


