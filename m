Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAABCA5FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpwq-0005WV-Pg; Wed, 30 Sep 2026 04:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBpwb-0005Ow-DJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBpwZ-00022u-Mk
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790757938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dNSxQr+yr6uUw9PmZZOTCyF+B8AcKQY4ABTEkMBecPI=;
 b=fe5UzZR7YA4ZexVvmvbjhOriv4Eq2gHueyFAvWE6Q9GWQGP8g4I8Jqs2wfM7a0w64B/k3U
 IIL2qGZqz35rNm8zOOs81MhdD1d2uw88idlrDhtyCIghnUjttsZw3BpAmG8v89ySRkCopN
 NMgYC5e77dtlWCOLdERCDGV76DbBZWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-9XSoaMO1Ox6Gxi4UM2mqaw-1; Wed,
 30 Sep 2026 04:45:35 -0400
X-MC-Unique: 9XSoaMO1Ox6Gxi4UM2mqaw-1
X-Mimecast-MFC-AGG-ID: 9XSoaMO1Ox6Gxi4UM2mqaw_1790757933
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37734187A5D1; Wed, 30 Sep 2026 08:45:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DD581956095; Wed, 30 Sep 2026 08:45:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 06/12] char-stdio: add support for the terminal size
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
In-Reply-To: <20260929-console-resize-v8-6-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
 <20260929-console-resize-v8-6-2ff9183f8750@gmail.com>
Date: Wed, 30 Sep 2026 12:45:20 +0400
Message-Id: <179075792013.1303431.129983921020844209.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pA7WPrjUBOngvljoChxZwztK3GhSC19HqbTe9ZrZvCE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvMwjJIPDZ+W0fj2ZUzCJ3z0XOi58jyRZNm8ML
 97cNVssBhmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarzMIwAKCRDa6OEJdZac
 5aowEACWdSDQTVf9b8tY8Qj9dimhfk4qAXfU/JQbS8fkghGjaBP/8nV4EQKVAmHS1DXilwbznBZ
 PLGZRqAlrSb9KvWoVoL4CdJ3Gog+p/I1i3pxnNFJmshVwpsSFpNipkjnPCdnZyFpq5WOh6O3tqx
 lerXpUL5mMX/lJpQOfrOnemPBpr6ZoCWgUsp5OOyiZamtE3+t+9nbx2e/6OwHWZgXYQwopWZ2np
 C1rPR4LtevL7Ywf4Z57hb/L2NDOw9lR7lojYvMrb7PCe0eziUPikSSWrZbBt0JzzLsJ5PYZnv4u
 5HIKF2NXGRSgGYTSzKqiHENAHgJ+oUCScwOB5A4qiDFZTNdwo73IBveZjjkAsdrAILjnL8TEXz8
 ZVMEcsWuZtKR9qywjgRAj3D7lp/ZKRS+g/D6qDt7bCF/7f0ePd0F/bV5ubR83FDmE0WN49SRDwi
 Tfab8JZn4DEXRxSf4Y4B+d8SthzS3uoA8erH1fL9MmSXDBCTEAJ/6wxo5cuHmCAfRhGncyLmzIR
 BDBiidVniV4/OpvVV9WJyTanStalD3BbhGU6RD7VCTOM9pbVEdCOoaQR31HRsHBJyzS2Q+CleFQ
 FQwTW+lsdZZtcb5Nf0SidnHFfHLeV7XbmsTx9MpR9euzLsdPk0vTZ+v5w99Wn/sjACCFj+iqdqQ
 WKktWeHYj80XicQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

> Update the terminal size upon SIGWINCH delivery.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> [Filip: use DECLARE_INSTANCE_CHECKER, qemu_chr_resize_stdio -> stdio_chr_resize]
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20260929-console-resize-v8-6-2ff9183f8750@gmail.com>
>
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index fe1cbb2d880f..4fc8db212cde 100644
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

There should be a corresponding sigwinch_remove_notifier() on finalize

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


