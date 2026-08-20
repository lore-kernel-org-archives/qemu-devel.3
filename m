Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6DCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwyfW-0007uB-Nh; Thu, 20 Aug 2026 05:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwyfV-0007kU-8C
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwyfT-0004qi-Mt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787216555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMOvKqYz772f80GS5MjGp+n2WJ9885iZjVIwOTgYBRw=;
 b=a6frcNdsmPz/WNvUlA0i6B+Vy0wuslrftjGqADQtFxz1BP8u3zianu9c3hRcXGnB3ln/T6
 jMQ1B5Xya5kcOUF93fv+JoK2JjRxO1vxt7oCSUdAHb+Bq6OpuZVA35HyxEGS9ydxTmnugA
 JC8msAfyd0zOD/Ix0Pr5qZJky4UDD1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Zqk86PbOORyeZZrGzQOhxA-1; Thu,
 20 Aug 2026 05:02:24 -0400
X-MC-Unique: Zqk86PbOORyeZZrGzQOhxA-1
X-Mimecast-MFC-AGG-ID: Zqk86PbOORyeZZrGzQOhxA_1787216542
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBEA9195609F; Thu, 20 Aug 2026 09:02:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3D481955F03; Thu, 20 Aug 2026 09:02:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88C2221E6920; Thu, 20 Aug 2026 11:02:17 +0200 (CEST)
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
Subject: Re: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
 (Connor Kite's message of "Mon, 17 Aug 2026 22:12:28 -0700")
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
Date: Thu, 20 Aug 2026 11:02:17 +0200
Message-ID: <87lda12mhy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Add a memory-isolation property to NetdevPassOptions and
> NetDevVhostUserOptions in net.json.  This property will
> be used for vhost-user devices to disable access to guest
> memory from vhost-user backends.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c..add7cb5408 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -213,6 +213,9 @@
>  #
>  # @param: parameter to pass to passt command
>  #
> +# @memory-isolation: isolate guest memory from vhost-user back-end
> +#     (default: false) (Since 11.2)
> +#

Any guidance on when to enable it?

>  # Since: 10.1
>  ##
>  { 'struct': 'NetdevPasstOptions',
> @@ -250,7 +253,8 @@
>      '*ipv6':               'bool',
>      '*tcp-ports':          ['PasstPortForward'],
>      '*udp-ports':          ['PasstPortForward'],
> -    '*param':              ['PasstParameter'] },
> +    '*param':              ['PasstParameter'],
> +    '*memory-isolation':   'bool'},
>      'if': 'CONFIG_PASST' }
>  
>  ##
> @@ -685,13 +689,17 @@
>  # @queues: number of queues to be created for multiqueue vhost-user
>  #     (default: 1) (Since 2.5)
>  #
> +# @memory-isolation: isolate guest memory from vhost-user back-end
> +#     (default: false) (Since 11.2)

Likewise.

> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NetdevVhostUserOptions',
>    'data': {
> -    'chardev':        'str',
> -    '*vhostforce':    'bool',
> -    '*queues':        'int' } }
> +    'chardev':              'str',
> +    '*vhostforce':          'bool',
> +    '*queues':              'int',
> +    '*memory-isolation':    'bool' } }
>  
>  ##
>  # @NetdevVhostVDPAOptions:


