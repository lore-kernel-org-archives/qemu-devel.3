Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FC4CA0FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 23:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUkU-0001f6-6q; Sat, 30 Aug 2025 19:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUkO-0001cs-4G; Sat, 30 Aug 2025 19:12:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUkK-0003O9-En; Sat, 30 Aug 2025 19:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=07tye9m7eYTzKcdfaWvaCSP5dbaJXmYQAlIefu6c9SE=; b=d1vN0rxgrc6GIfm+
 jSp1+0ZdzG+8rDjEjZV840tGVq3mxGpZBAiFWPdYXjgxO7t89HJ/pRkVUwztp7bLvBsgDPQ61Kkf+
 UTjOoOBq8NpQITZvROrBZtwx0kmxXtxsUW6DHzssA6r+DTms+ih1mfy3LMM6EGzpfdQLrJcFDWmEo
 P9c64E5XbSU6SeQSX9/4KirgnCM9B/HOUP04g9AGGGSzAWIBud8Fl5L8mC3EauxK4BVX1IRHE0CEW
 kLfA4lSwXVOLeEHUkP37+K0Jy4cx1BRCQE9LNVFb/TCebl2CBQ2wWE2qnExNAUcmej8bQ0B9GHQtK
 bftbEroE6zztiEv83w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1usUkH-007aWX-27;
 Sat, 30 Aug 2025 23:12:29 +0000
Date: Sat, 30 Aug 2025 23:12:29 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 05/14] audio: make jackaudio use qemu_thread_set_name
Message-ID: <aLOFXb18pV85FPq7@gallifrey>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829180354.2922145-6-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:11:45 up 125 days,  7:25,  1 user,  load average: 0.00, 0.00, 0.00
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> This has greater portability than directly call pthread_setname_np,
> which is only 1 out of 3 possible functions for pthreads that can
> set the name.
> 
> The new API requires a trampoline function, since it can only set
> the name of the current thread.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  audio/jackaudio.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 974a3caad3..48ffbf735f 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -629,18 +629,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool enable)
>      ji->c.enabled = enable;
>  }
>  
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)
> +struct QJackThreadData {
> +    void *(*function)(void *);
> +    void *arg;
> +};
> +
> +static void *qjack_thread_trampoline(void *targ)
> +{
> +    struct QJackThreadData *data = targ;
> +    void *(*function)(void *) = data->function;
> +    void *arg = data->arg;
> +
> +    g_free(data);
> +    qemu_thread_set_name("jack-client");
> +
> +    return function(arg);
> +}
> +
>  static int qjack_thread_creator(jack_native_thread_t *thread,
>      const pthread_attr_t *attr, void *(*function)(void *), void *arg)
>  {
> -    int ret = pthread_create(thread, attr, function, arg);
> +    struct QJackThreadData *data = g_new0(struct QJackThreadData, 1);
> +    data->function = function;
> +    data->arg = arg;
> +    int ret = pthread_create(thread, attr, qjack_thread_trampoline, data);
>      if (ret != 0) {
> +        g_free(data);
>          return ret;
>      }
>  
> -    /* set the name of the thread */
> -    pthread_setname_np(*thread, "jack-client");
> -
>      return ret;
>  }
>  #endif
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

