Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE76CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGF3r-0004lS-9o; Mon, 12 Oct 2026 08:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3g-0004kE-7U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3d-0007LB-Lx
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791807788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBVv5O41ojjjDsfCDy2nge18bJlhHb3ZAHwQT+wWWAg=;
 b=Z2W2Rk8IYPwwulGq+Kui3Ut70mTiz14qwwJylrc0jj5+rvxGRuKMv0EEQwHo8QCH/18ZDx
 19m+Ua0WxNxv22PZatXPWo3LqfEE6/M8Em2dQhDZb/nknOOBDxhoZ7glREvw6INbHiS083
 +IAJoGm0yoOw3cZ+OWWX8MY4BLMSQSo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-zu8NSvBSMhekjje9fv9ZSA-1; Mon,
 12 Oct 2026 12:23:05 +0000
X-MC-Unique: zu8NSvBSMhekjje9fv9ZSA-1
X-Mimecast-MFC-AGG-ID: zu8NSvBSMhekjje9fv9ZSA_1791807783
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7290195DBA9; Mon, 12 Oct 2026 12:23:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97AD730001B9; Mon, 12 Oct 2026 12:23:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 06/12] char-stdio: add support for the terminal size
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v9-6-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
 <20261012-console-resize-v9-6-8db78320ba81@gmail.com>
Date: Mon, 12 Oct 2026 16:22:47 +0400
Message-Id: <179180776717.1821755.7903445932593824183.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3463;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5etAfmTBw/DWvvntq5Cw8PmIWTms+Ffg/HxYlSvoO/4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzNEbSfCGS5m8D1FiOh+og5Z3Y5zHcXOFcTKnT
 OADnxFx+/uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaszRGwAKCRDa6OEJdZac
 5VwaD/9+rVK1VHfVSDtVids49erc5wc7Ln9cBd51IspMfGUJ/kqWVOFhBkslZXNUi06wAuSQw5t
 JW6rw+OArS2KEah8BsaaZw4O0+CnNvwdIxqmGQPf/CKkQfLZNvgvnX0N4oaMcvFBxJZimPnDFrF
 GPsBuGPFpjEBuy5G9Acsbb+HBFywMFyagko8qWQnaOBD/JedQ+DhJEaWMyUv1zQ18z500M/o1mW
 sLfuIajva8ROCNj0dgxDZf/uFD9O0hO3FRo7zVwrRvW3ghWe+PqR+JUMaxfrsJTKUi4N8sNrRD/
 +k3UGuCSc+ZTK19x+rcaBf8L2z02FYB4RzpDYe4ufv9LRpEPzk05EsHNpp0iGCDIUHkG6sr1CxK
 BniO6ZmEXi6cQrnV3SOCfSoSY0Qz4W0SLzQB+MqDeLPtldYBrDNTphrNY1YA7c1W8r9T63pDFrH
 gwlToSdwQyCDez10mb2QujrJgcjZse+mIu9LGpSUPHL61kPENjcM6m1d/J6LJb1fmJRRLMm7hqv
 7hdUIN3nURfq6OlWqWe+YiOJf7t8Q6Qd4RWAYv9DU7Zdc5uvdna0el42KMs2hGtcCoxxsj5Jszm
 WAKe9W+TUndu0UWldwvpabbc4pb6/V0P0sQSBh4JHsZESR7XjgLEy6F4iRzYlSjidj6ZfiU87AV
 kpkV1S45YyaNUyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

> Update the terminal size upon SIGWINCH delivery.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> [Filip: use DECLARE_INSTANCE_CHECKER,
>         qemu_chr_resize_stdio -> stdio_chr_resize,
>         remove notifier in char_stdio_finalize]
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20261012-console-resize-v9-6-8db78320ba81@gmail.com>
>
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index fe1cbb2d880f..58299ff4369a 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -34,7 +34,9 @@
>  #include "chardev/char-win-stdio.h"
>  #else
>  #include <termios.h>
> +#include <sys/ioctl.h>
>  #include "chardev/char-fd.h"
> +#include "qemu/main-loop.h"
>  #endif
>  
>  #ifndef _WIN32
> @@ -46,6 +48,14 @@ static bool stdio_in_use;
>  static bool stdio_allow_signal;
>  static bool stdio_echo_state;
>  
> +typedef struct {
> +    FDChardev parent;
> +    Notifier resize_notifier;
> +} StdioChardev;
> +
> +DECLARE_INSTANCE_CHECKER(StdioChardev, STDIO_CHARDEV,
> +                         TYPE_CHARDEV_STDIO)
> +
>  static void term_exit(void)
>  {
>      if (stdio_in_use) {
> @@ -85,8 +95,23 @@ static void term_stdio_handler(int sig)
>      stdio_chr_set_echo(NULL, stdio_echo_state);
>  }
>  
> +static void stdio_chr_resize(Chardev *chr)
> +{
> +    struct winsize ws;
> +    if (ioctl(1, TIOCGWINSZ, &ws) != -1) {
> +        qemu_chr_resize(chr, ws.ws_col, ws.ws_row);
> +    }
> +}
> +
> +static void term_resize_notify(Notifier *n, void *data)
> +{
> +    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
> +    stdio_chr_resize(CHARDEV(s));
> +}
> +
>  static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>  {
> +    StdioChardev *s = STDIO_CHARDEV(chr);
>      ChardevStdio *opts = backend->u.stdio.data;
>      struct sigaction act;
>  
> @@ -121,6 +146,10 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>      stdio_allow_signal = !opts->has_signal || opts->signal;
>      stdio_chr_set_echo(chr, false);
>  
> +    s->resize_notifier.notify = term_resize_notify;
> +    sigwinch_add_notifier(&s->resize_notifier);
> +    stdio_chr_resize(chr);
> +
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>      return true;
>  }
> @@ -151,7 +180,10 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
>  
>  static void char_stdio_finalize(Object *obj)
>  {
> +    StdioChardev *s = STDIO_CHARDEV(obj);

../chardev/char-stdio.c:183:5: error: unknown type name 'StdioChardev'; did you mean 'WinChardev'?
  183 |     StdioChardev *s = STDIO_CHARDEV(obj);
      |     ^~~~~~~~~~~~
      |     WinChardev

StdioChardev is only defined under #ifndef _WIN32 (line 42 of the file). This
declaration is outside that guard, so the build will fail. Move it inside the

> +
>  #ifndef _WIN32
> +    sigwinch_remove_notifier(&s->resize_notifier);
>      term_exit();
>  #endif
>  }
> @@ -162,6 +194,7 @@ static const TypeInfo char_stdio_type_info = {
>      .parent = TYPE_CHARDEV_WIN_STDIO,
>  #else
>      .parent = TYPE_CHARDEV_FD,
> +    .instance_size = sizeof(StdioChardev),
>  #endif
>      .instance_finalize = char_stdio_finalize,
>      .class_init = char_stdio_class_init,

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


