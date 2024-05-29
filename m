Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E105BC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCI25-0005Zh-PQ; Wed, 29 May 2024 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCI22-0005ZY-Tl
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCI20-0007b3-2c
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716984226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0Ybe18sUFqmaFzxor/gNMCjRrjzWF1NZNKevjP2bnA=;
 b=fpoljdOwlGBQ1fe6NaLvHLlXCY7H9qIZ4imiS30De703vZzquREWlet+DX4gVpYgf/kz5I
 ygrvK3rXSM+hRS+8A+o6C3gMwOwONrawQxqklk8I+HLges+Jd9WUzA+VL4lUGFqxFKtFxF
 HQogNVe2G7UGDj6oezoj3sfBB8xShjg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Ex9JVx2-Ngy3_7JwxK0TXA-1; Wed, 29 May 2024 08:03:41 -0400
X-MC-Unique: Ex9JVx2-Ngy3_7JwxK0TXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A08B800169;
 Wed, 29 May 2024 12:03:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4652873;
 Wed, 29 May 2024 12:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8FFD21E66E5; Wed, 29 May 2024 14:03:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org
Subject: Re: [PATCH v4] mc146818rtc: add a way to generate RTC interrupts
 via QMP
In-Reply-To: <20240528072242.493056-1-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Tue, 28 May 2024 10:22:42 +0300")
References: <20240528072242.493056-1-d-tatianin@yandex-team.ru>
Date: Wed, 29 May 2024 14:03:39 +0200
Message-ID: <87mso8n7tw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>
> Changes since v0:
> - Rename to rtc-inject-irq to match other similar API
> - Add a comment to highlight that this only works for the I386 RTC
>
> Changes since v1:
> - Added a description below the QMP command to explain how it can be
>   used and what it does.
>
> Changes since v2:
> - Add a 'broadcast' suffix.
> - Change the comments to explain the flags we're setting.
> - Change the command description to fix styling & explain that it's a bro=
adcast command.
>
> Changes since v3:
> - Fix checkpatch complaints about usage of C99 comments
>
> ---
>  hw/rtc/mc146818rtc.c         | 20 ++++++++++++++++++++
>  include/hw/rtc/mc146818rtc.h |  1 +
>  qapi/misc-target.json        | 19 +++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 3379f92748..96ecd43036 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -107,6 +107,11 @@ static void rtc_coalesced_timer_update(MC146818RtcSt=
ate *s)
>  static QLIST_HEAD(, MC146818RtcState) rtc_devices =3D
>      QLIST_HEAD_INITIALIZER(rtc_devices);
>=20=20
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
>=20=20
> +void qmp_rtc_inject_irq_broadcast(Error **errp)
> +{
> +    MC146818RtcState *s;
> +
> +    QLIST_FOREACH(s, &rtc_devices, link) {
> +        /* Update-ended interrupt enable */
> +        s->cmos_data[RTC_REG_B] |=3D REG_B_UIE;
> +
> +        /* Interrupt request flag | update interrupt flag */
> +        s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF | REG_C_UF;
> +
> +        qemu_irq_raise(s->irq);
> +    }
> +}
> +
>  static bool rtc_policy_slew_deliver_irq(MC146818RtcState *s)
>  {
>      kvm_reset_irq_delivered();
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 97cec0b3e8..e9dd0f9c72 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -56,5 +56,6 @@ MC146818RtcState *mc146818_rtc_init(ISABus *bus, int ba=
se_year,
>  void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val);
>  int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr);
>  void qmp_rtc_reset_reinjection(Error **errp);
> +void qmp_rtc_inject_irq_broadcast(Error **errp);
>=20=20
>  #endif /* HW_RTC_MC146818RTC_H */
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 4e0a6492a9..7d388a3753 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -19,6 +19,25 @@
>  { 'command': 'rtc-reset-reinjection',
>    'if': 'TARGET_I386' }
>=20=20
> +##
> +# @rtc-inject-irq-broadcast:
> +#
> +# Inject an RTC interrupt for all existing RTCs on the system.
> +# The interrupt forces the guest to synchronize the time with RTC.
> +# This is useful after a long stop-cont pause, which is common for
> +# serverless-type workload.

Make that "workloads".

"For all existing RTCs" is a lie.  It's really just all mc146818s.  The
command works as documented only as long as the VM has no other RTCs.

> +#
> +# Since: 9.1
> +#
> +# Example:
> +#
> +#     -> { "execute": "rtc-inject-irq-broadcast" }
> +#     <- { "return": {} }
> +#
> +##
> +{ 'command': 'rtc-inject-irq-broadcast',
> +  'if': 'TARGET_I386' }

The conditional kind-of-sort-of ensures "VM has no other RTCs":
TARGET_I386 compiles only this file in hw/rtc/, and therefore can't have
other RTCs (unless they're hiding in some other directory).  Brittle.

When we move to single binary, we will compile in other RTCs.  How can
we ensure "VM has no nother RTCs" then?  What if one of these other RTCs
can be added with -device or device_add?

When this falls apart because the VM does have other RTCs, it can only
do so silently: the command can't tell us for which RTCs it actually
injected an interrupt.

Documentation making promises the implementation doesn't actually
deliver can only end in tears.  The only reason I'm not rejecting this
patch out of hand is the existing and similarly broken
rtc-reset-reinjection.

I'm willing to reluctantly accept it with honest documentation.
Perhaps: "Bug: RTCs other than mc146818rtc are silently ignored."

Much, much better would be an interface that's actually usable with
multiple RTCs.  We'd have to talk how interrupt injection could be used
with such a machine.

Anything less will likely need to be replaced later on.

> +
>  ##
>  # @SevState:
>  #


