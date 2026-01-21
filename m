Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A7C44522
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXb0-0006JX-2Z; Wed, 21 Jan 2026 07:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXUm-00028I-VP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:39:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXUi-0005d0-IS
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:39:35 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx3f7670KzHnGh3;
 Wed, 21 Jan 2026 20:38:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 912574056A;
 Wed, 21 Jan 2026 20:39:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 12:39:28 +0000
Date: Wed, 21 Jan 2026 12:39:27 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Message-ID: <20260121123927.00001daa@huawei.com>
In-Reply-To: <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 12:25:14 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> We can't inject a new GHES record to the same source before
> it has been acked. There is an async mechanism to verify when
> the Kernel is ready, which is implemented at QEMU's ghes
> driver.
> 
> If error inject is too fast, QEMU may return an error. When
> such errors occur, implement a retry mechanism, based on a
> maximum timeout.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
A few trivial comments below. Either way this seems fine to me and
should make the tooling easier to use.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  scripts/qmp_helper.py | 47 +++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> index 40059cd105f6..63f3df2d75c3 100755
> --- a/scripts/qmp_helper.py
> +++ b/scripts/qmp_helper.py
> @@ -14,6 +14,7 @@
>  
>  from datetime import datetime
>  from os import path as os_path
> +from time import sleep
>  
>  try:
>      qemu_dir = os_path.abspath(os_path.dirname(os_path.dirname(__file__)))
> @@ -324,7 +325,8 @@ class qmp:
>      Opens a connection and send/receive QMP commands.
>      """
>  
> -    def send_cmd(self, command, args=None, may_open=False, return_error=True):
> +    def send_cmd(self, command, args=None, may_open=False, return_error=True,
> +                 timeout=None):
>          """Send a command to QMP, optinally opening a connection"""
>  
>          if may_open:
> @@ -336,12 +338,31 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True):
>          if args:
>              msg['arguments'] = args
>  
> -        try:
> -            obj = self.qmp_monitor.cmd_obj(msg)
> -        # Can we use some other exception class here?
> -        except Exception as e:                         # pylint: disable=W0718
> -            print(f"Command: {command}")
> -            print(f"Failed to inject error: {e}.")
> +        if timeout and timeout > 0:
> +            attempts = int(timeout * 10)
> +        else:
> +            attempts = 1
> +
> +        # Try up to attempts
That reads oddly because of the variable name.  Made me ask myself
"How many attempts?"
Maybe  " Retry up to attempts times" or something like that.

> +        for i in range(0, attempts):
> +            try:
> +                obj = self.qmp_monitor.cmd_obj(msg)
> +
> +                if obj and "return" in obj and not obj["return"]:
> +                    break
> +
> +            except Exception as e:                     # pylint: disable=W0718
> +                print(f"Command: {command}")
> +                print(f"Failed to inject error: {e}.")
> +                obj = None
> +
> +            if attempts > 1:
> +                print(f"Error inject attempt {i + 1}/{attempts} failed.")
> +
> +            if i + 1 < attempts:
> +                sleep(0.1)

Do we care about a sleep at the end?  Feels like a micro optimization that
isn't needed.

> +
> +        if not obj:
>              return None



