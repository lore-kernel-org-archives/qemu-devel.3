Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3583CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI016-0001UM-Ko; Sat, 17 Oct 2026 04:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI015-0001U8-Av
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI013-0007BY-SB
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukQ3+0B3ipd1SsCuZTOpjg5xDUwqAUvbDjZRazZ36Vc=;
 b=DlqVSQQTEbA7/oc6nEhC00jek4T4WIo63txu28iqVSqb1EJH+rj6M620Qy2T3sUGb/ny47
 XOmpPgTpFjGNxexQxwcXWRhiWpzxwZ4UuAo/YMCrCtdxNH3ulSvv4vn+Gcg5owAwaQtQPX
 xn0JhwDEO36wmoI9+apc9VlcuGXEVQo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-hYuZ68WZPB2Hs_tPWWN9sw-1; Sat,
 17 Oct 2026 08:43:42 +0000
X-MC-Unique: hYuZ68WZPB2Hs_tPWWN9sw-1
X-Mimecast-MFC-AGG-ID: hYuZ68WZPB2Hs_tPWWN9sw_1792226621
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63E3318004AD; Sat, 17 Oct 2026 08:43:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C7671955F10; Sat, 17 Oct 2026 08:43:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 13/23] dump: use get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656904.1619676.8797747178657746975.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2904;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vzHZsvriuUKHMRkVKhEwu/En5m/O6dHrKLCDZY78SwM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUNmuvH/+z5gj7f2Vs9uJtmd/3tEGG15JYS4
 pNiG5IwIseJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DQAKCRDa6OEJdZac
 5VGFD/9x8GCm5zCTxl6F8DQGyJP/IeCVcBSSoLYa70T3AJ5hZTxxAZN7/hrg1es5M5k2gGZApWz
 Sr7ZaW0iubndI1RNh9ZQqITD/HT8POYX9fuNZU1t58NM5oteLT52nDG82mD9avUkwP24RCbfdCs
 tw70WxmptQXy2EFFxor0HwqMOTGIz+n+Rpi9YWMyOOe+Pgb69bxaF3P0BkP38SdJdOhrteo/H2k
 bio2hjW/nWmX6sMCWFB+xCc48dLtczqSH1H923UBlCCvZ15jNMrZ3aQJ5PDiXUWJ0ImwKqWgYsw
 J+6E8t3blhmOROUe6GU5DH4uWOU86wJJMAfs6zBSAsDAAXaEn0mgpavLWSJtw4ndKbi5gXQvk7t
 y3sI7TwwWk7zCo0Bk5ppaCUe0YPDTAlg4qGpJlsnj+HlPcPOyVlD+VyF/m87OLruTKLhcAFrpY6
 fpxKv2vtLvB4kj9cPPrae2VguPoGfgLTrnlU6lRuX7bEqjRmGg8KtB5p05ySrLXyCllFwmZAORO
 feG7PAZpnzlQfUt4/8DLlSrSCYMDi/KnIQWrDBy5Oo7o6jnxUyhBbSXT1/LLMZp2/N2GYOp4wUP
 jIi8wvjCPlmiq0mQvBOdFTcZkXdnUxI5zx3giuGykuPd/TRHu+2T+LL3gwxvIhDK332Gi+qPOcZ
 aATy8wafQDWmngA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

> Now that all targets implement this interface, we can replace the
> cpu_get_dump_info() call with the new interface.
> 
> We always check if there is at least one cpu available. For instance,
> machine null has no cpu present. Heterogeneous emulation is
> already handled by the check above which disable dump.
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 0ecff682dd4e..e0a7dfd58785 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -32,6 +32,7 @@
>  #include "migration/blocker.h"
>  #include "migration/misc.h"
>  #include "hw/core/cpu.h"
> +#include "hw/core/sysemu-cpu-ops.h"
>  #include "win_dump.h"
>  #include "qemu/range.h"
>  
> @@ -1793,7 +1794,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>      VMCoreInfoState *vmci = vmcoreinfo_find();
>      CPUState *cpu;
>      int nr_cpus;
> -    int ret;
>  
>      if (target_heterogeneous()) {
>          error_setg(errp,
> @@ -1858,12 +1858,16 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>          goto cleanup;
>      }
>  
> -    /* get dump info: endian, class and architecture.
> -     * If the target architecture is not supported, cpu_get_dump_info() will
> -     * return -1.
> +    /*
> +     * get dump info: endian, class and architecture.
> +     * If the cpu does not support dumping this information, get_dump_info
> +     * returns -1.
>       */
> -    ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
> -    if (ret < 0) {
> +    const SysemuCPUOps *sysemu_ops =
> +        first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;

Per style, avoid mixed declarations, please declare it at the top of dump_init().

> +    if (!sysemu_ops || !sysemu_ops->get_dump_info ||
> +        sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
> +                                  &s->guest_phys_blocks) < 0) {
>          error_setg(errp,
>                     "dumping guest memory is not supported on this target");
>          goto cleanup;

Something like this would be clearer:

     if (!first_cpu) {
         error_setg(errp, "dump: no CPU to dump");
         goto cleanup;
     }
     sysemu_ops = first_cpu->cc->sysemu_ops;
     if (!sysemu_ops->get_dump_info ||
         sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
                                   &s->guest_phys_blocks) < 0) {

Another option is a cpu_get_dump_info(CPUState *, ...) wrapper in
hw/core/cpu-system.c, next to cpu_write_elf64_note() and friends. That would
match how the other dump-related sysemu ops are called and keep dump.c from
dereferencing SysemuCPUOps directly.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


