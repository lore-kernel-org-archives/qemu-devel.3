Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D9CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoUa-0003fU-1W; Mon, 20 Oct 2025 07:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAoUO-0003ex-8p
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAoUM-0003DN-8p
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760961344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmL+MV8QCR7wsKGI3c8+ysd/x7X57aKdgxrzHw58KXA=;
 b=UqR+v1YFSt6JuSU5+5OjPKt/zJG8swCwTh1oN01xQ0h+qFEDlEELZRxnE92a7NLxV8letB
 ISAb9GxcTwNNNgx4CKwcCJ5Yydl3hib92Dc/xSxxzl49eScP0xqKov7HfLfUikPrPDKowk
 RrDs06+OndNlkRUGBr/Z6S26M8XfL2s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-R5niTov4PyCJbunz9WyF1w-1; Mon,
 20 Oct 2025 07:55:35 -0400
X-MC-Unique: R5niTov4PyCJbunz9WyF1w-1
X-Mimecast-MFC-AGG-ID: R5niTov4PyCJbunz9WyF1w_1760961334
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B6918002E4; Mon, 20 Oct 2025 11:55:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F11F71800578; Mon, 20 Oct 2025 11:55:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78BC921E6A27; Mon, 20 Oct 2025 13:55:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Andrew Keesler <ankeesler@google.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PULL 04/11] Support per-head resolutions with virtio-gpu
In-Reply-To: <20251020104149.4034124-5-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 20 Oct 2025 11:41:42 +0100")
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
 <20251020104149.4034124-5-alex.bennee@linaro.org>
Date: Mon, 20 Oct 2025 13:55:30 +0200
Message-ID: <87ms5lu6rx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I missed this one somehow.  My apologies!

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Andrew Keesler <ankeesler@google.com>
>
> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
>
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
>
>   -display vnc=3Dlocalhost:0,id=3Daaa,display=3Dvga,head=3D0 \
>   -display vnc=3Dlocalhost:1,id=3Dbbb,display=3Dvga,head=3D1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>                  "xres":111,
>                  "yres":222
>               },
>               {
>                  "name":"BBB",
>                  "xres":333,
>                  "yres":444
>               }
>             ]}'
>
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
>
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
>
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
>
> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-ID: <20250902141312.750525-2-ankeesler@google.com>
> [AJB: dropped pointless output_idx range check, tweak commit]
> Message-ID: <20251016150357.876415-5-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 05295ab6655..0ce789bb22f 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -971,15 +971,21 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output. If both xres and
> +# yres are set, they take precedence over root virtio-gpu

Please use @NAME to refer to a local member or argument NAME for proper
rendering.

Elsewhere, we use @width and @height.  Consistency is desirable.

What happens when only one of @xres and @yres are provided?

> +# resolution configuration and enable the corresponding output.
>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)
> +#
>  # Since: 10.1
>  ##
>=20=20
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>=20=20
>  ##
>  # @DummyVirtioForceArrays:

[...]


