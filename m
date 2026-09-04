Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9DCC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2cJo-00036K-Ed; Fri, 04 Sep 2026 18:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2cJm-00035j-7S
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 18:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2cJk-0000AP-I5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 18:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788560607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZrwI7AcVfc7bjI/Pw68HHhS3g79z7lgO/lEvZhXNUM=;
 b=OrIHso0wxjNN0uD9ud2Dyl3VSydkabpr9FQGp6nCHm6NSpe8AUkBxonMwIT7EjJU3puJPO
 qHiVxVPId8wCuCaFYZ6FwWHZ0E6Skf49zomhQwxwSo7EecQirYSmQhNgsNYDlnZ5Iofn3K
 BkNvcQJpTDTIDWIH+i8HxcF+Ws5RaMo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-7MSbLDWKOia9PTTOZtIoDg-1; Fri, 04 Sep 2026 18:23:25 -0400
X-MC-Unique: 7MSbLDWKOia9PTTOZtIoDg-1
X-Mimecast-MFC-AGG-ID: 7MSbLDWKOia9PTTOZtIoDg_1788560604
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4843313047eso987817f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788560604; x=1789165404; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JZrwI7AcVfc7bjI/Pw68HHhS3g79z7lgO/lEvZhXNUM=;
 b=JcMMM2r3cxkmgIuulICK5HCseMEhKpzco1y+i2dN2dyaWHLDo14LlqLsyNlvwl7inc
 UeuwowwlUEm2dBoMUWT3QLzDqv8Mq5+d0o6XOutjUedfNJPh6UtP0N2DzuSXZKPWHeql
 pdRKJLzmtjDSiyxNM08fdXMUhpgFOM1/+BKIX6+Cv9OX4ctHpcG793gc6anUW//Endl0
 Gs5f9VDqWVvF6E8NjWhZo5eT37o/2eTqkDNRtyp48058GwxNnPTgo+EAYSQ5NrYCXrzE
 2gVmOxQkbxiGnjNaeH4vJQT1hyl6uZ3bJRigpIqWDYPilkFdaptc3q0dlROMxp7fIL9A
 4XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788560604; x=1789165404;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JZrwI7AcVfc7bjI/Pw68HHhS3g79z7lgO/lEvZhXNUM=;
 b=jWAooEOk49RHvB08b/eiEZRLk4n5k9F0GqGNu0gdcB2UcGQgjS6X2eYqaAckFhztwY
 Z8HuCNtv4pbehAXB6F1Qn5m8FdfkP0wcEUpXYMdebx4V6xVMX2JOocxV1F1yVM7wr/vp
 CftWRjvJN++LptsHgpWbaXUIyWZjXt2n10R/7CpQO8xkRdY9JHVinJGBqaWO8sBKmflW
 RuFfhWvOwl1ZC6QoZ3uoEymMegunSxAfzWUC73fz7m//BALH3l6pa4iGq657Kq+2sCjl
 Pw5yUx+oZN1QKSkeoM2OrYI2xf1fQ+fA4kvbJv2QjGhslIVkra7gYYkjhlyp6fHa7cqW
 OuYA==
X-Gm-Message-State: AFuF++lniy8pNZ8yfBnUUAbQLkAYnzn9kPxRbqDd6m09BxoLMs5JO5nz
 opG1PPrReZ6SQ7LTo4oXJlr5e3/TvF9TUAB7zzbhHgQ1xuj321FaNjCoVnyUXmF+VF1GZh2GvI7
 z9DlzK2nxs78GnwrK7DD2EaYuuDV30VOk5nCGZLvCXxwgXII5gqmiwRAr
X-Gm-Gg: AYBFou0yGa2wlRpvkCcQ0zkTo1rvtkGklUn+uiMZyJ5z4oZ3SdOegUSGWYFKFSXP7Rx
 5kFEIy1QATshipz2dX8k68V7CanD2ji46NEp4SNnYNgVOBTwBAxlPY7LS1Czq/j+F6HFMh8Arhr
 /9Jpv5Nkt0Ylxx0P3m/7SL8OV5OQW9uTOCmPGYhpGz3CGgIsEuML1PvLigvj/sCEWAwL2HDO7es
 lmX+jPO5JIFgF+OSHxr4Trz+QBrBEIeL8lpOSZR25CuktPZvUnHr8pbE6WkHo0oNjMUylQpvqmz
 aImIqSSZmY9HqpakZea9HjEaRNZmZ+fHkGdKi6N3AOV8a/JeOf8CG25WfPMe0X/5EA+bz9hkqi/
 YiwW849OsYECHwWDB3ivGM8I=
X-Received: by 2002:a05:6000:2282:b0:485:8a47:5b82 with SMTP id
 ffacd0b85a97d-4858a475d65mr8115508f8f.31.1788560604393; 
 Fri, 04 Sep 2026 15:23:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2282:b0:485:8a47:5b82 with SMTP id
 ffacd0b85a97d-4858a475d65mr8115480f8f.31.1788560603939; 
 Fri, 04 Sep 2026 15:23:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm5904110f8f.3.2026.09.04.15.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:23:23 -0700 (PDT)
Date: Fri, 4 Sep 2026 18:23:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: shenjiatong <yshxxsjt715@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] rtc/mc146818rtc: fix QEMU crash when time runs backwards
Message-ID: <20260904182057-mutt-send-email-mst@kernel.org>
References: <20251113030211.6283-1-yshxxsjt715@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113030211.6283-1-yshxxsjt715@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 11:02:11AM +0800, shenjiatong wrote:
> Loosen restriction on computed lost_tick. When QEMU's rtc_clock is set
> to host, the walltime is used for mc146818rtc which requires computed
> lost_tick to be strictly non-negative. But host walltime could possibly
> run backwards, for example, configured by NTP service. Under such
> circumstances QEMU process could crash unexpectly.

could crash -> crashes on an assert

remove "unexpectly."

> This situation is
> easy to reproduce for Windows 2012/2016 guests.

hmm what does it matter what is the guest?


Pls describe a fix shortly here.


And please follow standard practice to submit changes,
such as read and sign off on the DCO.


> ---
>  hw/rtc/mc146818rtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 8631386b9f..04185eb6e9 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -173,8 +173,7 @@ static void periodic_timer_update(MC146818RtcState *s, int64_t current_time,
>          next_periodic_clock = muldiv64(s->next_periodic_time,
>                                  RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>          last_periodic_clock = next_periodic_clock - old_period;
> -        lost_clock = cur_clock - last_periodic_clock;
> -        assert(lost_clock >= 0);
> +        lost_clock = MAX(cur_clock - last_periodic_clock, 0);
>      }
>  
>      /*
> -- 
> 2.34.1
> 
> 
> 


