Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73462C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpwK-0001lQ-4a; Mon, 21 Jul 2025 08:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpvQ-0007fN-VK; Mon, 21 Jul 2025 08:47:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpvN-0005cw-4k; Mon, 21 Jul 2025 08:47:24 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LCkx02052232
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 21:46:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=E2PezotxEVdua1A4XzIXD4BEPSpx2lxJHdXRWsMMqkA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753102019; v=1;
 b=pwl0pQcErqYynPcCP2cUpg4fM+T3eC7xA71CAaMilTy0u+bATddPzqMBpBTKcMV+
 s/wVnodnV2VORG6MPQCfjA7XEQ2g7HvGQzsFKACT75oDQtrLWcIeFz6RsxDY7sdR
 aJndC+LQJbwqzgcD5Wbx/s/jsNuJmD5Nn5t5kq1dvK5R/MraugnhoLyDbRA8zLD9
 TYrYzvXtCuY61T793nYT2f7aoCz4nLKPUQcGbqJcDuKRToKV2WMFo5+iiMXIO5zN
 UmemaV32I5SAetUFT/EybdyOMUwOtLNIHANnyuBRkHLY2YGySSjrHNNUAETteaoI
 IyQ1Egt4bDWgYXFo0mVr1w==
Message-ID: <af32a0a2-96f1-4e8d-b7ea-aa6bdecbfc75@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 21:46:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/24] migration: make loadvm_postcopy_handle_resume()
 void
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
 <20250721-propagate_tpm_error-v6-15-fef740e15e17@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250721-propagate_tpm_error-v6-15-fef740e15e17@redhat.com>
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
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/savevm.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e472f79d5d5c4fb4410a28cbf43c298be028f4b4..6887877f2f8648f66e34bdb1cc3ca6dc7514f9df 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2339,12 +2339,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
>       }
>   }
>   
> -static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> +static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>   {
>       if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> -        error_report("%s: illegal resume received", __func__);
> +        warn_report("%s: illegal resume received", __func__);
>           /* Don't fail the load, only for this. */
> -        return 0;
> +        return;
>       }
>   
>       /*
> @@ -2396,8 +2396,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>           /* Kick the fast ram load thread too */
>           qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
>       }
> -
> -    return 0;
>   }
>   
>   /**
> @@ -2635,12 +2633,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
>           return loadvm_postcopy_ram_handle_discard(mis, len, errp);
>   
>       case MIG_CMD_POSTCOPY_RESUME:
> -        ret = loadvm_postcopy_handle_resume(mis);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to load device state command: %d", ret);
> -            return -1;
> -        }
> -        return ret;
> +        loadvm_postcopy_handle_resume(mis);
> +        return 0;

This patch can be moved before "[PATCH v6 08/24] migration: push Error 
**errp into loadvm_process_command()" to make it smaller.

>   
>       case MIG_CMD_RECV_BITMAP:
>           ret = loadvm_handle_recv_bitmap(mis, len);
> 


