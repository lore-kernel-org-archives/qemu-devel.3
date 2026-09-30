Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A208CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpwn-0005Ug-Gg; Wed, 30 Sep 2026 04:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBpwZ-0005O5-Rg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xBpwY-00021X-5j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790757936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbT8ycYYGC2jwOJDhQt0rEIAroIdZitjYaB99eg8B6c=;
 b=bIShRdynZZJNKIZ5FFmpkDMlh83uHOfEXDhANcVn12GbbLZ/ApOAFon61++H0jWHzpy/xe
 OFtP/sCbYNTE6YC+albMhHAO8Oewf+zQhZQ5L6PU03L+2GBjkA5s3QyBzae59C5JMHTyI6
 CY6a8v+deiWWhUm6/wqw8/PhOVjLBQs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-0woTVLgcPeerhlAmUt4uMg-1; Wed,
 30 Sep 2026 04:45:30 -0400
X-MC-Unique: 0woTVLgcPeerhlAmUt4uMg-1
X-Mimecast-MFC-AGG-ID: 0woTVLgcPeerhlAmUt4uMg_1790757929
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C69A187A5F2; Wed, 30 Sep 2026 08:45:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 126B7180035F; Wed, 30 Sep 2026 08:45:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 05/12] main-loop: change the handling of SIGWINCH
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
In-Reply-To: <20260929-console-resize-v8-5-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
 <20260929-console-resize-v8-5-2ff9183f8750@gmail.com>
Date: Wed, 30 Sep 2026 12:45:20 +0400
Message-Id: <179075792011.1303431.7825080413230909437.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wixhU4Zohq53XPWw9xSvqtapmUzA3thExu1xI3s64LM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvMwiRSt4dcHAhimDWhiCPvDD/pKWeBunXdT3A
 sEmdfL/iYaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarzMIgAKCRDa6OEJdZac
 5QpBEACHeq/nbfy6BaBqTJHhUVqBKIMinGBez1FpsqdXxzUqV4q6vxHAaIdN170h4bx/sGEQfWE
 HKTj4h8vA9+7kMboLQeMIyf3YpDJxF6vTSw3QNby4Op78s2HKObePtzmp/XGI6CEbga6dU727kG
 Rg5OvMIWuSrpzXZzdL7vyVTXAWGTQINcpWom9FSdZCnBtkThkUVkAGeSuQFILjQvZG1HV2UGG2x
 iSSwahSG6JyFfcsgAQLkSDfk16JqR+6kZLIrgSnFeeXNjIARs3ZraZzxXXAMA6A0KU9aOPIlo5c
 WUl6qiKVsv/bs57ZJALf+uOM7GHzWYQwE3WRZx5slO+7Uqj75tWdWN2ri+b1N1GTepeWtGBZxUY
 Rd+Yqizz7prtJySoEZNYp+hogAta5jUTb58sCe+zj9ZxKsd+aTXRJ7qPj+QauJDiiEwcOeX//b6
 J8XLs5SaciQ+dcdnWZJj/EJ49+/OxMuH0uVW+e6O2y4xnxJfinI1KM8hhmKztmN+QkAAGHt3vAj
 lpPR/9GBxzsK8695xQh+SbMdQlFGsgMAKCK1kcXvkJmYYaJlxGeZOivTyQbJ3ANRhGvXErnl4Ko
 b6CG6O0EYkoRjgE9MdN3Mj5KQFXLWLiBu+2+5zsr0/chL6jtpLHha99608KKOQJ7xVgddWslAeu
 HuRixNmtjes1gHw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> Block SIGWINCH, so it is delivered only via signalfd.
> Install a handler that uses NotifierList to tell
> interested parties about SIGWINCH delivery.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20260929-console-resize-v8-5-2ff9183f8750@gmail.com>
>
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 8c1241a2c11c..ff41346b0b5a 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -449,4 +449,8 @@ typedef struct MainLoopPoll {
>  void main_loop_poll_add_notifier(Notifier *notify);
>  void main_loop_poll_remove_notifier(Notifier *notify);
>  
> +#ifndef _WIN32
> +void sigwinch_add_notifier(Notifier *n);

Add a sigwinch_remove_notifier()

> +#endif
> +
>  #endif
> diff --git a/ui/curses.c b/ui/curses.c
> index 4db32b6168d6..ced5fd1216b2 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -33,6 +33,7 @@
>  #include <iconv.h>
>  
>  #include "qapi/error.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
> @@ -149,7 +150,7 @@ static void curses_resize(DisplayChangeListener *dcl,
>  }
>  
>  #if !defined(_WIN32) && defined(SIGWINCH) && defined(KEY_RESIZE)
> -static volatile sig_atomic_t got_sigwinch;
> +static bool got_sigwinch;
>  static void curses_winch_check(void)
>  {
>      struct winsize {
> @@ -172,17 +173,17 @@ static void curses_winch_check(void)
>      invalidate = 1;
>  }
>  
> -static void curses_winch_handler(int signum)
> +static void curses_winch_handler(Notifier *n, void *data)
>  {
>      got_sigwinch = true;
>  }
>  
>  static void curses_winch_init(void)
>  {
> -    struct sigaction old, winch = {
> -        .sa_handler  = curses_winch_handler,
> +    static Notifier n = {
> +        .notify = curses_winch_handler
>      };
> -    sigaction(SIGWINCH, &winch, &old);
> +    sigwinch_add_notifier(&n);
>  }

And remove the notifier in curses_cleanup()

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


