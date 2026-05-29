Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F89CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4kw-0001OJ-FU; Fri, 29 May 2026 17:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wT4kr-0001N5-VM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wT4kq-0000wH-IF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780090110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GffzDqCZ+7Tq9BmlXvj6Ns0DvZ2aPMGfYG9ph4ypnZo=;
 b=GmyYENi7QC8vn72ZKvXn7Di8M4ShwVPJwgBo1jQkKRM0ZYQIMjTlg3zOzNEygYCT1ZbOq7
 6g6Ss5x8XZL6MT8F2XLLzYyAnQOJshCIMTQb7lGQntNKHfhDNCJSzVe1IDQFWQoss5EiC/
 Cn06gW/1dwfM51S024o/G5gHWp5m8B0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-4ju8IIlEPqa79rPerB9Pjw-1; Fri,
 29 May 2026 17:28:26 -0400
X-MC-Unique: 4ju8IIlEPqa79rPerB9Pjw-1
X-Mimecast-MFC-AGG-ID: 4ju8IIlEPqa79rPerB9Pjw_1780090105
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B63E1956080; Fri, 29 May 2026 21:28:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DF011800352; Fri, 29 May 2026 21:28:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/40] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <c856e07c-0ab8-4043-a6b6-8a32f174f478@linaro.org>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-4-d104f809e145@redhat.com>
 <c856e07c-0ab8-4043-a6b6-8a32f174f478@linaro.org>
Date: Sat, 30 May 2026 01:28:19 +0400
Message-Id: <178009009980.2665615.1222278418836271126.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t+SoyeZcSL+byO1LOwXuskdowNeFT/7clFz8bZ4pN7g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGgT06YTavJ4w8O1og/BASDFsi5Uk3AeIWmFic
 7Dgf61AwdmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahoE9AAKCRDa6OEJdZac
 5U7UD/9vRhbvDHwFCkMbz43JmK8xaLcHkydNXFr1ZUtbTR6gBFvQLWwv1Mchtvbt81AfkMKprDn
 hWd7CLcCYfc2uy7HjZc0Po27P7ufnnuddsl2ZDxs4Zmk19pU3mmIF7FVb5SbOlfu/VygyaMoZKn
 dpyoSoJQU/+eB3GgNMQwmrnaX43Ne9D9f188U0avmeNh9hlsF38dzn+Rm142hX9tF53KLBdFG8c
 JsBNUzDSEXrRsEp8bOnZO6DfcquiXv49KMGeKQldWt9qIcp6XdJELZdb9cy7PV3gBAO4TLtq2Hx
 XloQXG7QFz04lmkncEpdqCf2KsUabfdU2KHNWd18vF4LY/lwf+WXrp8CWwbyiNM/omZCOrEjFXp
 J8s7hqfKd8L5wpS+GL+W/tSE26itClBA1oUpMa4LZeBD9BBVNAKqMWUR0ksmPdYIBL6YM25hyOX
 RAjIwx4K/OvF1ttiejecWtWqbe+bYK4aKFqQzAoSl8F2AwYJVkB0US0VkkwJN1f2cb24IgHg1ii
 dKzrSa0w2wKcZAf46OzUG6hCo8tIRl9ctr5Pch+3GJ+lT+QBOjb6zm/EIwWugDQEhNgdYhvmKM5
 tcGxO22QXZ/xUuzisSZkGhIXkBp9GqMm7+Tm7DvC0p6ar66giHdudKj66+xG4rz5hHNZAAU0dVu
 M2S2rscjinc5lRA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On 2026-05-21 07:49:38+02:00, Philippe Mathieu-Daudé wrote:
> On 20/5/26 23:49, Marc-André Lureau wrote:
> 
> > Replace monitor_printf() error reporting with the standard **errp
> > pattern. Drop the Monitor *mon parameter and return bool to indicate
> > success, improving the function usage from non-HMP contexts. Update the
> > KVM MCE injection path and hmp_mce() accordingly.
> > 
> > Notes:
> >   - we may want to print the error in KVM path too
> >   - multiple error prints are now accumulated with error hints
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >   target/i386/cpu.h     |  4 ++--
> >   target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
> >   target/i386/kvm/kvm.c |  4 ++--
> >   target/i386/monitor.c |  6 ++++--
> >   4 files changed, 36 insertions(+), 27 deletions(-)
> 
> 
> 
> > diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> > index a536712c755..785a13dd710 100644
> > --- a/target/i386/monitor.c
> > +++ b/target/i386/monitor.c
> > @@ -580,6 +580,7 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
> >       uint64_t addr = qdict_get_int(qdict, "addr");
> >       uint64_t misc = qdict_get_int(qdict, "misc");
> >       int flags = MCE_INJECT_UNCOND_AO;
> > +    Error *err = NULL;
> >   
> >       if (qdict_get_try_bool(qdict, "broadcast", false)) {
> >           flags |= MCE_INJECT_BROADCAST;
> > @@ -587,7 +588,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
> >       cs = qemu_get_cpu(cpu_index);
> 
> if (!cs) {
>          error_setg(errp, "Invalid CPU %d", cpu_index);
>          return;
>      }
> 
> ?

good idea,

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

thanks


