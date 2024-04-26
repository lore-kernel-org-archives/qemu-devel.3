Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA9AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0H78-00046L-7I; Fri, 26 Apr 2024 04:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0H76-00046C-HS
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0H73-0002f4-Nz
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714120760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JEdOeaX8spuPawVTP9NbGYG3RYBIZhk1yrVrxrsIwc=;
 b=dWCBdVlotSdm4f9P5YV5yjPrTn3tZkAfuEpZQrcqnGMzXXpGZ0mitYAnYmZEyn9W5ae78R
 rv0ScS8Dz1dfCw0UdFlndPMVGUEveU3n2P3yJj6Is+NQjd9HbRVa0XdLRE0zVuTKxbpZws
 h4h6bjTY6rten718rDfNxIfRsbrG3AM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6jSnObUHMIC33FInZg7Z5A-1; Fri, 26 Apr 2024 04:39:16 -0400
X-MC-Unique: 6jSnObUHMIC33FInZg7Z5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10AB718065AB;
 Fri, 26 Apr 2024 08:39:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2B112166B31;
 Fri, 26 Apr 2024 08:39:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6F0321E6811; Fri, 26 Apr 2024 10:39:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
In-Reply-To: <20240425133745.464091-1-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Thu, 25 Apr 2024 16:37:45 +0300")
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
Date: Fri, 26 Apr 2024 10:39:14 +0200
Message-ID: <87v844y0ul.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniil Tatianin <d-tatianin@yandex-team.ru> writes:

> This can be used to force-synchronize the time in guest after a long
> stop-cont pause, which can be useful for serverless-type workload.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>  include/hw/rtc/mc146818rtc.h |  1 +
>  qapi/misc-target.json        | 16 ++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index f4c1869232..6980a78d5f 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>      }
>  }
>  
> +void qmp_rtc_notify(Error **errp)
> +{
> +    MC146818RtcState *s;
> +
> +    /*
> +     * See:
> +     * https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
> +     */
> +    QLIST_FOREACH(s, &rtc_devices, link) {
> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
> +        qemu_irq_raise(s->irq);
> +    }
> +}
> +

Note for later: qmp_rtc_notify() works on all realized mc146818rtc
devices.  Other kinds of RTC devices are silently ignored.  Just like
qmp_rtc_reset_reinjection().

>  static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>  {
>      kvm_reset_irq_delivered();
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 97cec0b3e8..5229dffbbd 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>  void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>  int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>  void qmp_rtc_reset_reinjection(Error **errp);
> +void qmp_rtc_notify(Error **errp);
>  
>  #endif /* HW_RTC_MC146818RTC_H */
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 4e0a6492a9..20457b0acc 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -19,6 +19,22 @@
   ##
   # @rtc-reset-reinjection:
   #
   # This command will reset the RTC interrupt reinjection backlog.  Can
   # be used if another mechanism to synchronize guest time is in effect,
   # for example QEMU guest agent's guest-set-time command.
   #
   # Since: 2.1
   #
   # Example:
   #
   #     -> { "execute": "rtc-reset-reinjection" }
   #     <- { "return": {} }
   ##
>  { 'command': 'rtc-reset-reinjection',
>    'if': 'TARGET_I386' }
>  
> +##
> +# @rtc-notify:
> +#
> +# Generate an RTC interrupt.

Our QMP command to generate NMIs is called inject-nmi.  Call this one
inject-rtc-irq for consistency?  rtc-inject-irq?

> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     -> { "execute": "rtc-notify" }
> +#     <- { "return": {} }
> +#
> +##
> +{ 'command': 'rtc-notify',
> +  'if': 'TARGET_I386' }
> +

As noted above, both commands silently ignore RTCs other than
mc146818rtc.

They're only available with TARGET_I386.

As long as all machines available with TARGET_I386 can only ever contain
mc146818rtc RTCs, ignoring other RTCs is a non-problem in practice.

Feels a bit fragile to me.  Thoughts?

>  ##
>  # @SevState:
>  #


