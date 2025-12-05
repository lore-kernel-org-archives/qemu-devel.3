Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF00D374A1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 21:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRcxW-0006GF-CF; Fri, 05 Dec 2025 16:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRcxT-0006El-8c
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 16:03:19 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRcxQ-0006Wh-JF
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 16:03:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D404E8076C;
 Sat, 06 Dec 2025 00:03:09 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:87c::1:2a] (unknown
 [2a02:6bf:8080:87c::1:2a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 83uwDv0F00U0-H6esWKC7; Sat, 06 Dec 2025 00:03:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764968589;
 bh=S2WN79KD3N2DJqpIMl5FviIxgRNGgOfMwqTd0ZruTBw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MJEfHZoIr2uKyGqVc+ths01mdAzBYglfhtuIHl7uIfNbRHin74bK/UFEp5qmU1oKk
 YmTPka3Z0nlHh6kdHmiyRmSo4mtSDFMskhoujKaGXyVY1Wb3upEYsoVC5KMhlyXqT2
 nz8imUIRyWruFsxV5VTCN70sfCu21TNqsqF+bm4M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3d215410-5ddf-4b0c-b30f-decff7fae2a8@yandex-team.ru>
Date: Sat, 6 Dec 2025 00:03:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] chardev: rework filename handling
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-10-vsementsov@yandex-team.ru>
 <CAMxuvaw5MfXrSiqY3taObYn9cTAg6teJ5RYAjj+c6i3qip3Euw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAMxuvaw5MfXrSiqY3taObYn9cTAg6teJ5RYAjj+c6i3qip3Euw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05.12.25 18:33, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Dec 4, 2025 at 7:42 PM Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>     We have the following flaws with it:
> 
>     1. Layring violation by modifying generic state directly in backends
> 
> 
> Well, it's a parent field that can be modified, I am not sure it qualifies as such
> 
>     2. Tricky generic logic: we should check, did backend set the
>     generic state field, and fill it when not.
> 
>     Let's fix them all by making filename a private field with getter
>     and setter. And move the "default logic" into getter.
> 
> 
> The tradeoff is that your implementation will do more allocation/free, but I don't think we care much here.
> 
> I am not sure we gain much overall.


My actual goal is to "open the doors" for further movement of qemu_char_open() call
to the later point (I came to this idea instead of trying to split .open() into
.open() and .init())..

So I should do something with the logic in chardev_new(), done after qemu_char_open()
call. Alternative is to put it into qemu_char_open(). But I decided, that being here,
it's better to generalize it somehow.

Agree, that setter/getter for filename seems a bit cumbersome here.

Hmm. I think, I have a clearer idea:

add .chr_get_filename() handler and drop the .filename field and qemu_chr_set_filename()
function.

So, qemu_chr_get_filename() will realize the default logic or call .chr_get_filename() if
it exist.

We'll need implementations only for char-socket and char-pty.


> 
>     Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> 
> 
>     ---
>       chardev/char-pty.c     |  4 +++-
>       chardev/char-socket.c  | 17 ++++++++---------
>       chardev/char.c         |  8 ++------
>       hw/misc/ivshmem-pci.c  |  4 ++--
>       include/chardev/char.h | 21 ++++++++++++++++++++-
>       5 files changed, 35 insertions(+), 19 deletions(-)
> 
>     diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>     index 047aade09e..f4294679be 100644
>     --- a/chardev/char-pty.c
>     +++ b/chardev/char-pty.c
>     @@ -336,6 +336,7 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>           int master_fd, slave_fd;
>           char *name;
>           char *path = backend->u.pty.data->path;
>     +    g_autofree char *filename = NULL;
> 
>           s = PTY_CHARDEV(chr);
> 
>     @@ -351,7 +352,8 @@ static bool pty_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>               return false;
>           }
> 
>     -    chr->filename = g_strdup_printf("pty:%s", s->pty_name);
>     +    filename = g_strdup_printf("pty:%s", s->pty_name);
>     +    qemu_chr_set_filename(chr, filename);
>           qemu_printf("char device redirected to %s (label %s)\n",
>                       s->pty_name, chr->label);
> 
>     diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>     index 31c9acd164..9387760009 100644
>     --- a/chardev/char-socket.c
>     +++ b/chardev/char-socket.c
>     @@ -384,8 +384,7 @@ static void tcp_chr_free_connection(Chardev *chr)
>           s->sioc = NULL;
>           object_unref(OBJECT(s->ioc));
>           s->ioc = NULL;
>     -    g_free(chr->filename);
>     -    chr->filename = NULL;
>     +    qemu_chr_set_filename(chr, NULL);
>           tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>       }
> 
>     @@ -443,11 +442,11 @@ static void update_disconnected_filename(SocketChardev *s)
>       {
>           Chardev *chr = CHARDEV(s);
> 
>     -    g_free(chr->filename);
>           if (s->addr) {
>     -        chr->filename = qemu_chr_socket_address(s, "disconnected:");
>     +        g_autofree char *filename = qemu_chr_socket_address(s, "disconnected:");
>     +        qemu_chr_set_filename(chr, filename);
>           } else {
>     -        chr->filename = g_strdup("disconnected:socket");
>     +        qemu_chr_set_filename(chr, "disconnected:socket");
>           }
>       }
> 
>     @@ -638,9 +637,9 @@ static void tcp_chr_connect(void *opaque)
>       {
>           Chardev *chr = CHARDEV(opaque);
>           SocketChardev *s = SOCKET_CHARDEV(opaque);
>     +    g_autofree char *filename = qemu_chr_compute_filename(s);
> 
>     -    g_free(chr->filename);
>     -    chr->filename = qemu_chr_compute_filename(s);
>     +    qemu_chr_set_filename(chr, filename);
> 
>           tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTED);
>           update_ioc_handlers(s);
>     @@ -1000,8 +999,8 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
>       {
>           SocketChardev *s = SOCKET_CHARDEV(chr);
>           QIOChannelSocket *sioc;
>     -    info_report("QEMU waiting for connection on: %s",
>     -                chr->filename);
>     +    g_autofree char *filename = qemu_chr_get_filename(chr);
>     +    info_report("QEMU waiting for connection on: %s", filename);
>           tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
>           sioc = qio_net_listener_wait_client(s->listener);
>           tcp_chr_set_client_ioc_name(chr, sioc);
>     diff --git a/chardev/char.c b/chardev/char.c
>     index 0dc792b88f..bdd907f015 100644
>     --- a/chardev/char.c
>     +++ b/chardev/char.c
>     @@ -309,7 +309,7 @@ static void char_finalize(Object *obj)
>           if (chr->fe) {
>               chr->fe->chr = NULL;
>           }
>     -    g_free(chr->filename);
>     +    qemu_chr_set_filename(chr, NULL);
>           g_free(chr->label);
>           if (chr->logfd != -1) {
>               close(chr->logfd);
>     @@ -796,7 +796,7 @@ static int qmp_query_chardev_foreach(Object *obj, void *data)
>           ChardevInfo *value = g_malloc0(sizeof(*value));
> 
>           value->label = g_strdup(chr->label);
>     -    value->filename = g_strdup(chr->filename);
>     +    value->filename = qemu_chr_get_filename(chr);
>           value->frontend_open = chr->fe && chr->fe->fe_is_open;
> 
>           QAPI_LIST_PREPEND(*list, value);
>     @@ -1025,10 +1025,6 @@ static Chardev *chardev_new(const char *id, const char *typename,
>               return NULL;
>           }
> 
>     -    if (!chr->filename) {
>     -        chr->filename = g_strdup(typename + 8);
>     -    }
>     -
>           return chr;
>       }
> 
>     diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
>     index 636d0b83de..2c7b987241 100644
>     --- a/hw/misc/ivshmem-pci.c
>     +++ b/hw/misc/ivshmem-pci.c
>     @@ -873,10 +873,10 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>               host_memory_backend_set_mapped(s->hostmem, true);
>           } else {
>               Chardev *chr = qemu_chr_fe_get_driver(&s->server_chr);
>     +        char *filename = qemu_chr_get_filename(chr);
> 
> 
> Should be auto-free, since returned allocated
> 
>               assert(chr);
> 
>     -        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n",
>     -                        chr->filename);
>     +        IVSHMEM_DPRINTF("using shared memory server (socket = %s)\n", filename);
> 
>               /* we allocate enough space for 16 peers and grow as needed */
>               resize_peers(s, 16);
>     diff --git a/include/chardev/char.h b/include/chardev/char.h
>     index d36e50b99e..ffeb4a4e3b 100644
>     --- a/include/chardev/char.h
>     +++ b/include/chardev/char.h
>     @@ -62,7 +62,7 @@ struct Chardev {
>           QemuMutex chr_write_lock;
>           CharFrontend *fe;
>           char *label;
>     -    char *filename;
>     +    char *_filename;
> 
> 
> Why rename the field? we don't have a  convention to have "private" fields with _ prefix afaik.
> 
>           int logfd;
>           int be_open;
>           /* used to coordinate the chardev-change special-case: */
>     @@ -72,6 +72,25 @@ struct Chardev {
>           DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
>       };
> 
>     +static inline char *qemu_chr_get_filename(Chardev *chr)
> 
> 
> Let's avoid code in headers.
> 
>     +{
>     +    const char *typename;
>     +
>     +    if (chr->_filename) {
>     +        return g_strdup(chr->_filename);
>     +    }
>     +
>     +    typename = object_get_typename(OBJECT(chr));
>     +    assert(g_str_has_prefix(typename, "chardev-"));
>     +    return g_strdup(typename + 8);
>     +}
>     +
>     +static inline void qemu_chr_set_filename(Chardev *chr, const char *filename)
>     +{
>     +    g_free(chr->_filename);
>     +    chr->_filename = g_strdup(filename);
>     +}
>     +
>       /**
>        * qemu_chr_new_from_opts:
>        * @opts: see qemu-config.c for a list of valid options
>     -- 
>     2.48.1
> 


-- 
Best regards,
Vladimir

