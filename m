Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0402EC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIB0-0006IG-9x; Thu, 03 Jul 2025 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uXIAv-0006Hr-3M
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:32:23 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uXIAs-0006wh-3v
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ddlCtZR0+hZ41Fp5P3ea9W0RE4pvU3NEq8jcXcphVUw=; b=pTUh2OSre5DeO0IO
 RfPMIJtCimXFewCmnf7+CS/uWjtK/RyEbhF1X50/vSj+9uNrH368+zUllZSgnZnco4ojcKd2VdZmu
 XGgBuyUKrRnzWhhkqc8yV7f2qHVb9/WBtUUF3kMsoOzUvgUOdqeYW4F5wEOLigtVvizzdGgF1v2RU
 7B/KJGJCAa0GbEcEZQTUYMNt4yyAAqGUc3B2X4KBKr16KuV3gLM3FqyBJoWdv1QecygEXIICfwIOO
 kLT5zZzMrsXV/vtDBIZkhRS4pb9cAmw+YWgrHpdQZqL7Qv+ou1b6t817ies7fLVx4y12TDbWzAxFO
 wgdCzokpSUEQKpUnFA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uXIAj-00DqzF-24;
 Thu, 03 Jul 2025 11:32:09 +0000
Date: Thu, 3 Jul 2025 11:32:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v5 23/69] accel/tcg: Remove 'info opcount' and
 @x-query-opcount
Message-ID: <aGZqObkB6cBqo2tv@gallifrey>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-24-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703105540.67664-24-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:32:00 up 66 days, 19:45, 1 user, load average: 0.10, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
> released with QEMU v8.1.0) we get pointless output:
> 
>   (qemu) info opcount
>   [TCG profiler not compiled]
> 
> Remove that unstable and unuseful command.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

For HMP
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  qapi/machine.json          | 18 ------------------
>  accel/tcg/monitor.c        | 21 ---------------------
>  tests/qtest/qmp-cmd-test.c |  1 -
>  hmp-commands-info.hx       | 14 --------------
>  4 files changed, 54 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index d5bbb5e367e..acf6610efa5 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1764,24 +1764,6 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ] }
>  
> -##
> -# @x-query-opcount:
> -#
> -# Query TCG opcode counters
> -#
> -# Features:
> -#
> -# @unstable: This command is meant for debugging.
> -#
> -# Returns: TCG opcode counters
> -#
> -# Since: 6.2
> -##
> -{ 'command': 'x-query-opcount',
> -  'returns': 'HumanReadableText',
> -  'if': 'CONFIG_TCG',
> -  'features': [ 'unstable' ] }
> -
>  ##
>  # @x-query-ramblock:
>  #
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 1c182b6bfb5..7c686226b21 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -215,30 +215,9 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
>      return human_readable_text_from_str(buf);
>  }
>  
> -static void tcg_dump_op_count(GString *buf)
> -{
> -    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
> -}
> -
> -HumanReadableText *qmp_x_query_opcount(Error **errp)
> -{
> -    g_autoptr(GString) buf = g_string_new("");
> -
> -    if (!tcg_enabled()) {
> -        error_setg(errp,
> -                   "Opcode count information is only available with accel=tcg");
> -        return NULL;
> -    }
> -
> -    tcg_dump_op_count(buf);
> -
> -    return human_readable_text_from_str(buf);
> -}
> -
>  static void hmp_tcg_register(void)
>  {
>      monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
> -    monitor_register_hmp_info_hrt("opcount", qmp_x_query_opcount);
>  }
>  
>  type_init(hmp_tcg_register);
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 040d042810b..cf718761861 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -51,7 +51,6 @@ static int query_error_class(const char *cmd)
>          { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
>          /* Only valid with accel=tcg */
>          { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
> -        { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
>          { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
>          { NULL, -1 }
>      };
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 639a450ee51..d7979222752 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -256,20 +256,6 @@ SRST
>      Show dynamic compiler info.
>  ERST
>  
> -#if defined(CONFIG_TCG)
> -    {
> -        .name       = "opcount",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show dynamic compiler opcode counters",
> -    },
> -#endif
> -
> -SRST
> -  ``info opcount``
> -    Show dynamic compiler opcode counters
> -ERST
> -
>      {
>          .name       = "sync-profile",
>          .args_type  = "mean:-m,no_coalesce:-n,max:i?",
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

