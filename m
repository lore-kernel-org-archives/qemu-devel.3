Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015F5CF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 07:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svtLa-0003dE-2w; Wed, 02 Oct 2024 03:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svtLS-0003Yl-P1; Wed, 02 Oct 2024 03:00:26 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svtLQ-0003wg-Ec; Wed, 02 Oct 2024 03:00:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0791260A52;
 Wed,  2 Oct 2024 10:00:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 90VJ162IjeA0-gfQQfmDx; Wed, 02 Oct 2024 10:00:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727852413;
 bh=bnTMcUpa/lUbvx0VTzF+1J8Fma2kPqb+tdwDBgowbNE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iyGxA5rejqrr4Xob7F+xx/n2tCP8KdefHyXr8ijcAUtLtgwiy0lu2NKoPbHe1Gos4
 5kkfyvzbz2HvIdZdjSZQLQouDi/GjGp570txcackEzXQ9VzY3MsY+Wts7U57WCjIs+
 HgPslUGuKOzxliYau3TtojZgfbz14NsnM8vF5uAE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d97950d9-3f82-4838-a6e8-9e00859e72f6@yandex-team.ru>
Date: Wed, 2 Oct 2024 10:00:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/22] qom/object: fix -Werror=maybe-uninitialized
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Bin Meng <bin.meng@windriver.com>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-22-marcandre.lureau@redhat.com>
 <c02e70b2-c76a-49ff-844d-3e8b66a4fe3b@yandex-team.ru>
 <CAJ+F1C+n3NJDmSP53o9p6qZvPnVzKv20rB0_U7vn+8JRq0Rc0A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1C+n3NJDmSP53o9p6qZvPnVzKv20rB0_U7vn+8JRq0Rc0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
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

On 01.10.24 18:22, Marc-André Lureau wrote:
> Hi Vladimir
> 
> On Tue, Oct 1, 2024 at 6:06 PM Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>     On 30.09.24 11:14, marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com> wrote:
>      > From: Marc-André Lureau <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>>
>      >
>      > object_resolve_path_type() didn't always set *ambiguousp.
>      >
>      > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>>
>      > ---
>      >   qom/object.c | 5 ++++-
>      >   1 file changed, 4 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/qom/object.c b/qom/object.c
>      > index 28c5b66eab..bdc8a2c666 100644
>      > --- a/qom/object.c
>      > +++ b/qom/object.c
>      > @@ -2201,6 +2201,9 @@ Object *object_resolve_path_type(const char *path, const char *typename,
>      >           }
>      >       } else {
>      >           obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
>      > +        if (ambiguousp) {
>      > +            *ambiguousp = false;
>      > +        }
> 
>     Doesn't this hunk in isolation fix the issue? With this object_resolve_path_type() should set the pointer on all paths if it is non-null..
> 
> 
> 
>     Hmm, called object_resolve_partial_path() also doesn't set ambiguous on every path, so this hunk is at lease incomplete.
> 
> 
> yeah, but object_resolve_path_type() initializes it.
> 
>     I'm unsure about what semantics expected around ambigous pointers, but it seems to me that it is set only on failure paths, as a reason, why we failed. If this is true, I think, we need only the second hunk, which initializes local "ambig".
> 
> 
> right, and that seems good enough.
> 
> Do you ack/rb this change then?
> 
> 
>      qom/object: fix -Werror=maybe-uninitialized
> 
>      object_resolve_path_type() didn't always set *ambiguousp.
> 
>      Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>>
> 
> diff --git a/qom/object.c b/qom/object.c
> index 28c5b66eab..d3d3003541 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2226,7 +2226,7 @@ Object *object_resolve_path_at(Object *parent, const char *path)
> 
>   Object *object_resolve_type_unambiguous(const char *typename, Error **errp)
>   {
> -    bool ambig;
> +    bool ambig = false;
>       Object *o = object_resolve_path_type("", typename, &ambig);
> 
>       if (ambig) {
> 
> 

Yes, I think this one in isolation is OK:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


> thanks!
> 
>      >       }
>      >
>      >       g_strfreev(parts);
>      > @@ -2226,7 +2229,7 @@ Object *object_resolve_path_at(Object *parent, const char *path)
>      >
>      >   Object *object_resolve_type_unambiguous(const char *typename, Error **errp)
>      >   {
>      > -    bool ambig;
>      > +    bool ambig = false;
>      >       Object *o = object_resolve_path_type("", typename, &ambig);
>      >
>      >       if (ambig) {
> 
>     -- 
>     Best regards,
>     Vladimir
> 
> 
> 
> 
> -- 
> Marc-André Lureau

-- 
Best regards,
Vladimir


