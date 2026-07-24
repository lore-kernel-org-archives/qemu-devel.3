Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418DAC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn94h-00026i-8j; Fri, 24 Jul 2026 02:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wn94f-00025G-4i
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wn94d-00086F-Ib
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784873274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w9O6KyIWmVVPSWAdn3TWrQGghYaE/eWA8y4KU2yeK80=;
 b=H4+MiRZDzFTPU1MbFiu3TnWDLJnzHlbMFaXrPFa0Qb3k9XbOvDoSxfdc9I+IoDnlDrqXHT
 pPs61Yp6XpMBEr3BPi7m3Up+UG+k3gx0ORi0H2DPWadzshb5tv+MCAI/5MWmXpevpgzOLt
 gWwLqfhJ8EK0sVpjM4Z0v7DP0JoM3a0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-5sbwfBJYPbyh3dkZPeYbrg-1; Fri,
 24 Jul 2026 02:06:45 -0400
X-MC-Unique: 5sbwfBJYPbyh3dkZPeYbrg-1
X-Mimecast-MFC-AGG-ID: 5sbwfBJYPbyh3dkZPeYbrg_1784873202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3861319540E9; Fri, 24 Jul 2026 06:06:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18FA21954221; Fri, 24 Jul 2026 06:06:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5554521E6920; Fri, 24 Jul 2026 08:06:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mathieu Poirier <mathieu.poirier@linaro.org>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Haixu Cui
 <quic_haixcui@quicinc.com>,  Raphael Norwitz <rnorwitz@nvidia.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Milan Zamazal <mzamazal@redhat.com>,  Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Peter Xu <peterx@redhat.com>,  Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Alyssa Ross <hi@alyssa.is>,  Demi Marie Obenour
 <demiobenour@gmail.com>
Subject: Re: [PATCH RFC 03/15] backends/cryptodev-vhost-user: add memory
 isolation bool
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-3-6b97c439eb28@gmail.com>
 (Connor Kite's message of "Thu, 23 Jul 2026 15:30:02 -0700")
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-3-6b97c439eb28@gmail.com>
Date: Fri, 24 Jul 2026 08:06:36 +0200
Message-ID: <87fr18diqb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> index c55776af7d..d7ca1b4203 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -350,11 +350,15 @@
>  # @chardev: the name of a Unix domain socket character device that
>  #     connects to the vhost-user server
>  #
> +# @memory-isolation: disables access from cryptodev to guest memory.
> +#     (default: false)

Want imperative mood and need "since", like this:

   # @memory-isolation: disable access from cryptodev to guest memory.
   #     (default: false) (since 11.2)

Pardon my ignorance...  What exactly is "cryptodev" here?  Is it code
running in another process?

Should the description answer my question?  Perhaps like this:

  # @memory-isolation: isolate guest memory.  Isolated guest memory
  #     cannot be accessed from uh, what exactly?

Fill in the blank.

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


