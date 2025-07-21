Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976EEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpnl-0005EG-35; Mon, 21 Jul 2025 08:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpne-0004Ez-Tt; Mon, 21 Jul 2025 08:39:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpnb-0004AI-9L; Mon, 21 Jul 2025 08:39:22 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LCcrox050504
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 21:38:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PSICSBuQB3c7G4s1bZ2sgy16pos0hbf+ihrxiWxeX5A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753101534; v=1;
 b=ZmZfZMchXnAs1Gbo3txqx/NUOKHk4jctfZeIZGhHDmlAe8h44+oQQkyeYi5swivm
 /QKmwwzHoFckEoS/0s8q7yEjznKFGIVWy7eA62I8imSyI4qPelXQMp8MeJ9bvI5v
 3EkzbGB6JEiyznNNJbVx3WqHUgVPslg0OEDfvgQAVmLPjG4fBuUKDTfZTZTCPsn2
 +v8WEmo1Lk/rr0lv5T8JFoqD+Jao/zPNulVzVb4azTBs2qUR3nvIXzqP1GCFCM9n
 UXpYgVKg65gXnjuxP145ZgniAOR9FyuM7YrzBxfVccz3O36jFvzmdhapkjntyWBP
 typ+SvkympxvktImNUu6Zw==
Message-ID: <6966dd7b-635a-422c-b4ac-584c0c1fce49@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 21:38:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/24] migration: push Error **errp into
 loadvm_process_command()
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
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-8-fef740e15e17@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250721-propagate_tpm_error-v6-8-fef740e15e17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> It is ensured that loadvm_process_command() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/savevm.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 66 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 96af7b412f2ed43468f4bcac8b833cda223f8321..d8feb9e1599d019636cd400ee7ebe594df27bd1d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2546,12 +2546,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
>    * LOADVM_QUIT All good, but exit the loop
>    * <0          Error
>    */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, Error **errp)
>   {
>       MigrationIncomingState *mis = migration_incoming_get_current();
>       uint16_t cmd;
>       uint16_t len;
>       uint32_t tmp32;
> +    int ret;
>   
>       cmd = qemu_get_be16(f);
>       len = qemu_get_be16(f);
> @@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
>       }
>   
>       if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
> -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
>           return -EINVAL;
>       }
>   
>       trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
>   
>       if (mig_cmd_args[cmd].len != -1 && mig_cmd_args[cmd].len != len) {
> -        error_report("%s received with bad length - expecting %zu, got %d",
> -                     mig_cmd_args[cmd].name,
> -                     (size_t)mig_cmd_args[cmd].len, len);
> +        error_setg(errp, "%s received with bad length - expecting %zu, got %d",
> +                   mig_cmd_args[cmd].name,
> +                   (size_t)mig_cmd_args[cmd].len, len);
>           return -ERANGE;
>       }
>   
> @@ -2590,11 +2591,10 @@ static int loadvm_process_command(QEMUFile *f)
>            * been created.
>            */
>           if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
> -            int ret = migrate_send_rp_switchover_ack(mis);
> +            ret = migrate_send_rp_switchover_ack(mis);
>               if (ret) {
> -                error_report(
> -                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
> -                    strerror(-ret));
> +                error_setg(errp, "Could not send switchover ack "
> +                           "RP MSG, err %d (%s)", ret, strerror(-ret));
>                   return ret;
>               }
>           }
> @@ -2604,39 +2604,84 @@ static int loadvm_process_command(QEMUFile *f)
>           tmp32 = qemu_get_be32(f);
>           trace_loadvm_process_command_ping(tmp32);
>           if (!mis->to_src_file) {
> -            error_report("CMD_PING (0x%x) received with no return path",
> -                         tmp32);
> +            error_setg(errp, "CMD_PING (0x%x) received with no return path",
> +                       tmp32);
>               return -1;
>           }
>           migrate_send_rp_pong(mis, tmp32);
>           break;
>   
>       case MIG_CMD_PACKAGED:
> -        return loadvm_handle_cmd_packaged(mis);
> +        ret = loadvm_handle_cmd_packaged(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;

This "return -1" is extraneous.

The error_setg() call is later replaced with "[PATCH v6 09/24] 
migration: push Error **errp into loadvm_handle_cmd_packaged()", but 
this "return -1" is simply removed in the patch. There is no need to add 
it in the first place.

> +        }
> +        return ret;
>   
>       case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis, len);
> +        ret = loadvm_postcopy_handle_advise(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_POSTCOPY_LISTEN:
> -        return loadvm_postcopy_handle_listen(mis);
> +        ret = loadvm_postcopy_handle_listen(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_POSTCOPY_RUN:
> -        return loadvm_postcopy_handle_run(mis);
> +        ret = loadvm_postcopy_handle_run(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_POSTCOPY_RAM_DISCARD:
> -        return loadvm_postcopy_ram_handle_discard(mis, len);
> +        ret = loadvm_postcopy_ram_handle_discard(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_POSTCOPY_RESUME:
> -        return loadvm_postcopy_handle_resume(mis);
> +        ret = loadvm_postcopy_handle_resume(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_RECV_BITMAP:
> -        return loadvm_handle_recv_bitmap(mis, len);
> +        ret = loadvm_handle_recv_bitmap(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_ENABLE_COLO:
> -        return loadvm_process_enable_colo(mis);
> +        ret = loadvm_process_enable_colo(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>   
>       case MIG_CMD_SWITCHOVER_START:
> -        return loadvm_postcopy_handle_switchover_start();
> +        ret = loadvm_postcopy_handle_switchover_start();
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", ret);
> +            return -1;
> +        }
> +        return ret;
>       }
>   
>       return 0;
> @@ -3074,7 +3119,7 @@ retry:
>               }
>               break;
>           case QEMU_VM_COMMAND:
> -            ret = loadvm_process_command(f);
> +            ret = loadvm_process_command(f, NULL);
>               trace_qemu_loadvm_state_section_command(ret);
>               if ((ret < 0) || (ret == LOADVM_QUIT)) {
>                   goto out;
> 


