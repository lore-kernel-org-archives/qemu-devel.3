Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D425C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udps3-0003Rf-Kk; Mon, 21 Jul 2025 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udprx-00036M-Nk; Mon, 21 Jul 2025 08:43:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udprv-00058X-BW; Mon, 21 Jul 2025 08:43:49 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LChVJ6051357
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 21:43:31 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bi4uS/D0wPht6DS+lgGGmKKhRTkmgzkopOjGsFvu0jU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753101811; v=1;
 b=qNGH2ut9RXSFgZLuc8aFttMfuyuQfaH0jR5JG6jP5TNK4gw8NTpg+1yfZkVXzZe3
 a6mt/StJ4CvlHujjmAn+9VS9+fEr1sZlwpZ1A/BC3LH5MhfDSWJWWBQ/xJcjZxZj
 IzMGF2UcsmC1Bt5eapwjUP5CVPLRwG7dX33YS9AQukF0w8DDzHU18MCtuQk340Si
 DbQR67TNtQ66FAuO+5ZYngMPxF2rKbWVk9yy8cX0V3/tbOnQCLbb1qe5hvG1khrQ
 +yHUPua4QDwW7ILv2C1yfl9y+T2T6RWooD8c47PbAFSMXLOagonq3NVA3YjjJhln
 fXGsVW/bTHcpv30t26Zz5Q==
Message-ID: <ba4ca7d3-efb9-47a9-a84e-95394fe8bfff@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 21:43:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/24] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-11-fef740e15e17@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250721-propagate_tpm_error-v6-11-fef740e15e17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/21 20:29, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_postcopy_handle_advise() must report an error
> in errp, in case of failure.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/savevm.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 6b8c78bfb9bde2a8e7500b0342cd386b0d12db97..4a3db9498678a19597257e683029cd3f6c8d1a65 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
>    * quickly.
>    */
>   static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> -                                         uint16_t len)
> +                                         uint16_t len, Error **errp)
>   {
>       PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
>       uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
>       size_t page_size = qemu_target_page_size();
> -    Error *local_err = NULL;
>   
>       trace_loadvm_postcopy_handle_advise();
>       if (ps != POSTCOPY_INCOMING_NONE) {
> -        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
> +        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy "
> +                   "state (%d)", ps);
>           return -1;
>       }
>   
>       switch (len) {
>       case 0:
>           if (migrate_postcopy_ram()) {
> -            error_report("RAM postcopy is enabled but have 0 byte advise");
> +            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
>               return -EINVAL;
>           }
>           return 0;
>       case 8 + 8:
>           if (!migrate_postcopy_ram()) {
> -            error_report("RAM postcopy is disabled but have 16 byte advise");
> +            error_setg(errp, "RAM postcopy is disabled but have 16 "
> +                       "byte advise");
>               return -EINVAL;
>           }
>           break;
>       default:
> -        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> +        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
>           return -EINVAL;
>       }
>   
> -    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
> -        error_report_err(local_err);
> +    if (!postcopy_ram_supported_by_host(mis, errp)) {
>           postcopy_state_set(POSTCOPY_INCOMING_NONE);
>           return -1;
>       }
> @@ -1967,9 +1967,9 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>            *      also fails when passed to an older qemu that doesn't
>            *      do huge pages.
>            */
> -        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
> -                                                             " d=%" PRIx64 ")",
> -                     remote_pagesize_summary, local_pagesize_summary);
> +        error_setg(errp, "Postcopy needs matching RAM "
> +                   "page sizes (s=%" PRIx64 " d=%" PRIx64 ")",
> +                   remote_pagesize_summary, local_pagesize_summary);
>           return -1;
>       }
>   
> @@ -1979,17 +1979,17 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>            * Again, some differences could be dealt with, but for now keep it
>            * simple.
>            */
> -        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
> -                     (int)remote_tps, page_size);
> +        error_setg(errp, "Postcopy needs matching target "
> +                   "page sizes (s=%d d=%zd)", (int)remote_tps, page_size);
>           return -1;
>       }
>   
> -    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
> -        error_report_err(local_err);
> +    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
>           return -1;
>       }
>   
> -    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
> +    if (ram_postcopy_incoming_init(mis, errp) < 0) {
> +        error_prepend(errp, "PostCopy RAM incoming init failed ");

Nitpick: s/PostCopy/Postcopy/ for consistency with other error messages.

