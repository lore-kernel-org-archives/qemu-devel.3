Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D940BC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwyda-0002hu-7U; Thu, 20 Aug 2026 05:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwydY-0002eF-R6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwydX-0004cv-Ap
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787216433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzMGwljsMZ4U6CxcMqMO9az3lZ1eStsTxI29qdoslA4=;
 b=do0AiQWS4HMhD/W+kKLX7fgW0DH6w3NuAqj/PbHCWJ1lQCZQTXAFmJuf956I8P8YzszvN3
 QSXVSOjsSVqZVIX8D76xp1dPNN856BCFJxS28yCrbsfwMAI3c0l5aYxpkhrRIqXOrC5Yui
 Sg2nwOMzZqNWv2iHOAAb+KLF9jLWuCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-iEy-tMaVPwyFGNo48zaQsQ-1; Thu,
 20 Aug 2026 05:00:29 -0400
X-MC-Unique: iEy-tMaVPwyFGNo48zaQsQ-1
X-Mimecast-MFC-AGG-ID: iEy-tMaVPwyFGNo48zaQsQ_1787216426
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 467AD1800651; Thu, 20 Aug 2026 09:00:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38D21955F03; Thu, 20 Aug 2026 09:00:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 226D921E6920; Thu, 20 Aug 2026 11:00:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mathieu Poirier <mathieu.poirier@linaro.org>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Raphael Norwitz
 <rnorwitz@nvidia.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Peter Xu <peterx@redhat.com>,  Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Alyssa Ross <hi@alyssa.is>,  Demi Marie Obenour
 <demiobenour@gmail.com>,  20260817233147.2867623-1-connorkite@gmail.com
Subject: Re: [PATCH RFC v2 12/13] backends/cryptodev-vhost-user: add memory
 isolation bool
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-12-948aae960abb@gmail.com>
 (Connor Kite's message of "Mon, 17 Aug 2026 22:12:27 -0700")
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-12-948aae960abb@gmail.com>
Date: Thu, 20 Aug 2026 11:00:21 +0200
Message-ID: <87pkzd2ml6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Connor Kite <connorkite@gmail.com> writes:

> Add a memory_isolation property to CryptoDevBackendVhostUser and
> add add it as an optional member of CryptodevVhostUserProperties
> in qapi.
>
> This is needed to be able to specify memory isolation for
> cryptodev-vhost-user objects, and the bool will eventually be
> passed to vhost_user_init() in a future patch.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index c55776af7d..1024027195 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -350,11 +350,17 @@
>  # @chardev: the name of a Unix domain socket character device that
>  #     connects to the vhost-user server
>  #
> +# @memory-isolation: disable direct access from vhost-user back-end
> +#     to guest memory.  The back-end will instead access data via
> +#     bounce buffers residing in the QEMU virtual address space.
> +#     (default: false) (Since 11.2)

We spell it "backend" elsewhere in doc comments.

Any guidance on when to enable it?

> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'CryptodevVhostUserProperties',
>    'base': 'CryptodevBackendProperties',
> -  'data': { 'chardev': 'str' },
> +  'data': { 'chardev': 'str',
> +            '*memory-isolation': 'bool' },
>    'if': 'CONFIG_VHOST_CRYPTO' }
>  
>  ##


