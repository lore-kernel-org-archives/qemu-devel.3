Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDA9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 08:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Mjt-0004Tz-KB; Mon, 29 Apr 2024 04:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1Mjq-0004Th-Oh
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1Mjo-0006Yr-NI
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714380711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tYZxiJpCV/r27yuEBveylJs+i6+AW1FdjPtodEpI2CM=;
 b=R64Urglvf6iS2Vnb4/F4h+XRR6CAjI5DrURfNZkFS5vDcHklwa2idoPbstoHAQ8ALRUbk7
 U64qZ/Hq9Ux3uzjpVsH/WHKsq/PGvZzlTN8eJBZPy/+uSXAc1TGLooVOu+F26Yp0ObciCQ
 DMTJC7vVOltNFUDl6JmY3KnanHTq11w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-CaYG9zJzPPWCOoiute-C5A-1; Mon, 29 Apr 2024 04:51:49 -0400
X-MC-Unique: CaYG9zJzPPWCOoiute-C5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82E7D812C54;
 Mon, 29 Apr 2024 08:51:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 415901C060D0;
 Mon, 29 Apr 2024 08:51:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1760421E6680; Mon, 29 Apr 2024 10:51:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1] mc146818rtc: add a way to generate RTC interrupts
 via QMP
In-Reply-To: <20240427075801.491673-1-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Sat, 27 Apr 2024 10:58:01 +0300")
References: <20240427075801.491673-1-d-tatianin@yandex-team.ru>
Date: Mon, 29 Apr 2024 10:51:48 +0200
Message-ID: <87v840mtzv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> Also add a comment to highlight the fact that this (and one other QMP
> command) only works for the MC146818 RTC controller.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>
> Changes since v0:
> - Rename to rtc-inject-irq to match other similar API
> - Add a comment to highlight that this only works for the I386 RTC
>
> ---
>  hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>  include/hw/rtc/mc146818rtc.h |  1 +
>  qapi/misc-target.json        | 16 ++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index f4c1869232..8501b55cbd 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -107,6 +107,11 @@ static void rtc_coalesced_timer_update(MC146818RtcState *s)
>  static QLIST_HEAD(, MC146818RtcState) rtc_devices =
>      QLIST_HEAD_INITIALIZER(rtc_devices);
>  
> +/*
> + * NOTE:
> + * The two QMP functions below are _only_ implemented for the MC146818.
> + * All other RTC devices ignore this.
> + */
>  void qmp_rtc_reset_reinjection(Error **errp)
>  {
>      MC146818RtcState *s;
> @@ -116,6 +121,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>      }
>  }
>  
> +void qmp_rtc_inject_irq(Error **errp)
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
>  static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>  {
>      kvm_reset_irq_delivered();
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 97cec0b3e8..6cd9761d80 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int base_year,
>  void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>  int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>  void qmp_rtc_reset_reinjection(Error **errp);
> +void qmp_rtc_inject_irq(Error **errp);
>  
>  #endif /* HW_RTC_MC146818RTC_H */
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 4e0a6492a9..d84a5d07a2 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -19,6 +19,22 @@
>  { 'command': 'rtc-reset-reinjection',
>    'if': 'TARGET_I386' }
>  
> +##
> +# @rtc-inject-irq:
> +#
> +# Inject an RTC interrupt.

Your cover letter explains what this could be good for.  Would it make
sense to explain it here, too?

> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     -> { "execute": "rtc-inject-irq" }
> +#     <- { "return": {} }
> +#
> +##
> +{ 'command': 'rtc-inject-irq',
> +  'if': 'TARGET_I386' }
> +
>  ##
>  # @SevState:
>  #


