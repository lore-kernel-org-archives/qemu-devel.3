Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F90AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwasH-0006T6-08; Wed, 19 Aug 2026 03:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwasB-0006SW-Ss; Wed, 19 Aug 2026 03:38:08 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wwas9-0000nX-Dc; Wed, 19 Aug 2026 03:38:07 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67J7bQaT038534
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 19 Aug 2026 16:37:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=40/SmnpS+414qCoeOzC/7o/OH5OFlR/RHKU1VqwYRf4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787125047; v=1;
 b=T3B5R5ZqQUJ1TEvEA0ze3E+13+8Ad5xvt9C6mORoWPsFow36N/DBLDT44kfNuqjv
 bsSWDJMYhBUrEiPsr4iTEOPmvNtdx07VhxwrZBehtk0GwbMi9mb/HNFnSFvZQLV5
 3XCmu+rAD1kD320MdIjSDa8Q6NI1WC2WwesFlaxmZ7w8mcQ9CxMWuArDdQOh0rbv
 qwq4pY3A9p5KIzO2bs+dnymwH7zuCnhM53XTEjGp3dg0tTNqpkFcSEUwkdBuIa9F
 DcbHKTXHhQYS5kZ6InbdmsnYC/wQ3+zRKN9cQQ94Xhdu/EFnvr3cTMMGfKZihO6s
 9yy1gtNKKSq4F6YDl8ckvQ==
Message-ID: <15427c56-a585-48ff-b024-e48a2fdea697@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 19 Aug 2026 16:37:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>,
 20260817233147.2867623-1-connorkite@gmail.com
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/08/18 14:12, Connor Kite wrote:
> Add a memory-isolation property to NetdevPassOptions and
> NetDevVhostUserOptions in net.json.  This property will
> be used for vhost-user devices to disable access to guest
> memory from vhost-user backends.

The cover letter says multiqueue is not supported but the code just 
continues with multiqueue and breaks.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   net/passt.c      |  5 +++++
>   net/vhost-user.c |  3 +++
>   qapi/net.json    | 16 ++++++++++++----
>   3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/net/passt.c b/net/passt.c
> index 35ec6ad6de..7bcd47ad32 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -741,6 +741,11 @@ int net_init_passt(const Netdev *netdev, const char *name,
>       if (netdev->u.passt.has_vhost_user && netdev->u.passt.vhost_user) {
>           bool memory_isolation = false;
>   
> +        if (netdev->u.passt.has_memory_isolation &&
> +            netdev->u.passt.memory_isolation) {
> +            memory_isolation = true;
> +        }
> +
>           if (net_passt_vhost_user_init(s, memory_isolation, errp) == -1) {
>               qemu_del_net_client(nc);
>               return -1;
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index b6ee9ed297..bd33decadf 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -477,6 +477,9 @@ int net_init_vhost_user(const Netdev *netdev, const char *name,
>           return -1;
>       }
>   
> +    memory_isolation = vhost_user_opts->has_memory_isolation ?
> +                       vhost_user_opts->memory_isolation : false;
> +
>       return net_vhost_user_init(peer, "vhost_user", name, chr, queues,
>                                  memory_isolation);
>   }
> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c..add7cb5408 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -213,6 +213,9 @@
>   #
>   # @param: parameter to pass to passt command
>   #
> +# @memory-isolation: isolate guest memory from vhost-user back-end
> +#     (default: false) (Since 11.2)
> +#
>   # Since: 10.1
>   ##
>   { 'struct': 'NetdevPasstOptions',
> @@ -250,7 +253,8 @@
>       '*ipv6':               'bool',
>       '*tcp-ports':          ['PasstPortForward'],
>       '*udp-ports':          ['PasstPortForward'],
> -    '*param':              ['PasstParameter'] },
> +    '*param':              ['PasstParameter'],
> +    '*memory-isolation':   'bool'},
>       'if': 'CONFIG_PASST' }
>   
>   ##
> @@ -685,13 +689,17 @@
>   # @queues: number of queues to be created for multiqueue vhost-user
>   #     (default: 1) (Since 2.5)
>   #
> +# @memory-isolation: isolate guest memory from vhost-user back-end
> +#     (default: false) (Since 11.2)
> +#
>   # Since: 2.1
>   ##
>   { 'struct': 'NetdevVhostUserOptions',
>     'data': {
> -    'chardev':        'str',
> -    '*vhostforce':    'bool',
> -    '*queues':        'int' } }
> +    'chardev':              'str',
> +    '*vhostforce':          'bool',
> +    '*queues':              'int',
> +    '*memory-isolation':    'bool' } }
>   
>   ##
>   # @NetdevVhostVDPAOptions:
> 


